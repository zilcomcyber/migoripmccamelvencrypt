<?php
$page_title = "Roles & Permissions";
require_once '../config.php';
require_once '../includes/auth.php';
require_once '../includes/functions.php';
require_once '../includes/passwordRecovery.php';
require_once '../includes/rbac.php';
require_once '../includes/EncryptionManager.php';
require_once 'includes/pageSecurity.php';

// Initialize encryption
EncryptionManager::init($pdo);

// Only super admin can manage roles
require_role('super_admin');
$current_admin = get_current_admin();

$success_message = '';
$error_message = '';

// Handle permission updates
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['update_permissions'])) {
    if (!verify_csrf_token($_POST['csrf_token'] ?? '')) {
        $error_message = 'Invalid security token. Please try again.';
    } else {
        $admin_id = intval($_POST['admin_id']);
        $permissions = $_POST['permissions'] ?? [];

        if ($admin_id && $admin_id !== $current_admin['id']) {
            $valid_permissions = [];
            $all_permissions = [];
            foreach (get_available_permissions() as $category => $perms) {
                foreach ($perms as $key => $details) {
                    $all_permissions[] = $key;
                }
            }


            if (SecureRBAC::updateAdminPermissions($admin_id, $valid_permissions, $current_admin['id'])) {
                $success_message = "Permissions updated successfully.";
                log_activity('permissions_updated', "Updated admin permissions.", $current_admin['id'], 'admin', $admin_id);

                if ($admin_id === $current_admin['id']) {
                    $_SESSION['permissions'] = $valid_permissions;
                }
            } else {
                $error_message = "Failed to update permissions.";
            }
        } else {
            $error_message = "Invalid admin ID or cannot modify own permissions.";
        }
    }
}

// Handle admin creation
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['create_admin'])) {
    if (!verify_csrf_token($_POST['csrf_token'] ?? '')) {
        $error_message = 'Invalid security token.';
    } else {
        $name = sanitize_input($_POST['name'] ?? '');
        $email = filter_input(INPUT_POST, 'email', FILTER_VALIDATE_EMAIL);
        $password = $_POST['password'] ?? '';
        $role = sanitize_input($_POST['role'] ?? '');

        if (empty($name) || empty($email) || empty($password) || empty($role)) {
            $error_message = "All fields are required.";
        } elseif (!in_array($role, ['admin', 'viewer', 'super_admin'])) {
            $error_message = "Invalid role.";
        } elseif (strlen($password) < 8) {
            $error_message = "Password must be at least 8 characters.";
        } else {
            try {
                $email_hash = hash('sha256', strtolower(trim($email)));

                $stmt = $pdo->prepare("SELECT id FROM admins WHERE email_hash = ?");
                $stmt->execute([$email_hash]);
                $existing = $stmt->fetch();

                if ($existing) {
                    $error_message = "Email already exists.";
                } else {
                    $password_hash = password_hash($password, PASSWORD_BCRYPT);
                    $admin_data = [
                        'name' => $name,
                        'email' => $email,
                        'email_hash' => $email_hash,
                        'password_hash' => $password_hash,
                        'role' => $role,
                        'is_active' => 0,
                        'email_verified' => 0,
                        'created_at' => date('Y-m-d H:i:s')
                    ];

                    $inserted = EncryptionManager::insertEncrypted($pdo, 'admins', $admin_data);
                    if ($inserted) {
                        $admin_id = $pdo->lastInsertId();
                        $default_permissions = ['dashboard_access'];

                        if ($role === 'super_admin') {
                            $default_permissions = array_keys(get_available_permissions());
                        } elseif ($role === 'admin') {
                            $default_permissions = [
                                'dashboard_access', 'view_projects', 'create_projects',
                                'edit_projects', 'manage_feedback', 'view_reports'
                            ];
                        }

                        SecureRBAC::updateAdminPermissions($admin_id, $default_permissions, $current_admin['id']);
                        $email_result = send_activation_email($admin_id);

                        if ($email_result['success']) {
                            $success_message = "Admin created and activation email sent.";
                        } else {
                            $success_message = "Admin created. Failed to send email.";
                        }

                        log_activity('admin_created', "Created admin: $name", $current_admin['id'], 'admin', $admin_id);
                    } else {
                        $error_message = "Failed to create admin.";
                    }
                }
            } catch (Exception $e) {
                error_log("Admin creation error: " . $e->getMessage());
                $error_message = "Database error.";
            }
        }
    }
}

// Toggle admin active status
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['toggle_status'])) {
    if (!verify_csrf_token($_POST['csrf_token'] ?? '')) {
        $error_message = 'Invalid security token.';
    } else {
        $admin_id = intval($_POST['admin_id']);
        $current_status = intval($_POST['current_status']);
        $new_status = $current_status ? 0 : 1;

        if ($admin_id !== $current_admin['id']) {
            $stmt = $pdo->prepare("SELECT role FROM admins WHERE id = ?");
            $stmt->execute([$admin_id]);
            $role = $stmt->fetchColumn();

            if ($role === 'super_admin' && $new_status === 0) {
                $error_message = "Cannot deactivate a super admin.";
            } else {
                $stmt = $pdo->prepare("UPDATE admins SET is_active = ? WHERE id = ?");
                if ($stmt->execute([$new_status, $admin_id])) {
                    $success_message = "Admin status updated.";
                    if ($new_status === 1) {
                        send_reactivation_email($admin_id);
                    }
                    log_activity('admin_status_changed', "Changed status of admin ID $admin_id", $current_admin['id']);
                } else {
                    $error_message = "Failed to update status.";
                }
            }
        } else {
            $error_message = "Cannot change own account status.";
        }
    }
}

// Fetch all admins with permission count
$sql = "SELECT id, name, email, role, is_active, email_verified, last_login, created_at, last_ip,
               (SELECT COUNT(*) FROM admin_permissions WHERE admin_id = admins.id AND is_active = 1) as permission_count
        FROM admins ORDER BY 
        CASE WHEN id = ? THEN 1 ELSE 0 END DESC, role DESC, name ASC";

$admins = pdo_select($pdo, $sql, [$current_admin['id']], 'admins');

// Process admin data for output
$admins = EncryptionManager::processDataForReading('admins', $admins);

// Get available permissions
$permission_categories = SecureRBAC::getPermissionCategories();
$available_permissions = [];
foreach ($permission_categories as $cat => $perms) {
    foreach ($perms as $key => $perm) {
        $available_permissions[$key] = $perm['description'] ?? $key;
    }
}

// Get current permissions for each admin
$admin_permissions = [];
foreach ($admins as $admin) {
    $admin_permissions[$admin['id']] = SecureRBAC::getAdminPermissions($admin['id']);
}

// Stats
try {
    $total_users = $pdo->query("SELECT COUNT(*) FROM admins")->fetchColumn();
    $total_roles = $pdo->query("SELECT COUNT(DISTINCT role) FROM admins")->fetchColumn();
} catch (Exception $e) {
    $total_users = 0;
    $total_roles = 0;
}

include 'includes/adminHeader.php';
?>


<style>
/* Mobile-first responsive design */
.roles-container {
    padding: 0.75rem;
    background: #f8f9fa;
}

.main-card {
    background: #fffef7 !important;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    margin: 0;
    padding: 0;
}

.card-header {
    background: #fffef7 !important;
    padding: 1rem;
    border-bottom: 1px solid #e5e7eb;
    border-radius: 8px 8px 0 0;
}

.card-content {
    background: #fffef7 !important;
    padding: 1rem;
}

.stats-header {
    background: #fffef7 !important;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
    padding: 1rem;
    margin-bottom: 1rem;
}

.tab-button {
    border-bottom: 2px solid transparent;
    padding: 0.75rem 1rem;
    font-medium: 500;
    color: #6b7280;
    transition: all 0.2s;
    font-size: 0.9rem;
}

.tab-button.active {
    border-bottom-color: #3b82f6;
    color: #3b82f6;
}

.admin-item {
    background: #f8f9fa;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    padding: 0.75rem;
    margin-bottom: 0.75rem;
}

.admin-item.current-admin {
    border: 2px solid #dc3545;
    background: #fff5f5;
}

.admin-avatar {
    width: 36px;
    height: 36px;
    background: #e5e7eb;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.875rem;
    font-weight: 600;
    color: #374151;
}

.permissions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 0.5rem;
    margin: 0.75rem 0;
}

.permission-item {
    display: flex;
    align-items: center;
    padding: 0.5rem;
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 4px;
    font-size: 0.8rem;
}

.permission-item input {
    margin-right: 0.5rem;
}

.quick-action-btn {
    padding: 0.25rem 0.5rem;
    font-size: 0.75rem;
    border-radius: 4px;
    border: 1px solid;
    cursor: pointer;
    margin-right: 0.25rem;
    margin-bottom: 0.25rem;
}

.btn-approve { background: #ecfdf5; color: #065f46; border-color: #a7f3d0; }
.btn-reject { background: #fef2f2; color: #991b1b; border-color: #fecaca; }
.btn-edit { background: #eff6ff; color: #1e40af; border-color: #bfdbfe; }

.status-badge {
    padding: 0.25rem 0.5rem;
    border-radius: 12px;
    font-size: 0.75rem;
    font-weight: 500;
}

.status-active { background: #ecfdf5; color: #065f46; }
.status-inactive { background: #fef2f2; color: #991b1b; }
.status-unverified { background: #fef3c7; color: #92400e; }

.form-section {
    background: white;
    border: 1px solid #e5e7eb;
    border-radius: 6px;
    padding: 1rem;
    margin-bottom: 1rem;
}

@media (max-width: 768px) {
    .roles-container {
        padding: 0.5rem;
    }

    .card-header, .card-content {
        padding: 0.75rem;
    }

    .permissions-grid {
        grid-template-columns: 1fr;
        gap: 0.25rem;
    }

    .tab-button {
        padding: 0.5rem 0.75rem;
        font-size: 0.8rem;
    }

    .admin-item {
        padding: 0.5rem;
    }
}
</style>

<!-- Breadcrumb -->
<div class="mb-6">
    <nav class="flex" aria-label="Breadcrumb">
        <ol class="flex items-center space-x-2 text-sm">
            <li class="text-gray-600 font-medium">
                <i class="fas fa-home mr-1"></i> Dashboard
            </li>
            <li class="text-gray-400">/</li>
            <li class="text-gray-600 font-medium">Roles & Permissions</li>
        </ol>
    </nav>
</div>

<!-- Page Header -->
<div class="mb-8">
    <div class="bg-white shadow-sm rounded-lg border border-gray-200 p-6">
        <div class="flex flex-col md:flex-row items-start justify-between">
            <div class="mb-4 md:mb-0">
                <h1 class="text-2xl font-bold text-gray-900 mb-2">Roles & Permissions</h1>
                <p class="text-gray-600">Manage user access and permissions</p>
                <p class="text-sm text-gray-500 mt-2">Control administrative access and system permissions</p>
            </div>
            <div class="text-center md:text-right">
                <div class="text-3xl font-bold text-blue-600 mb-1">
                    <i class="fas fa-users-cog"></i>
                </div>
                <div class="text-sm text-gray-600 mb-3">User Management</div>
                <div class="text-xs text-gray-500"><?php echo number_format($total_users); ?> users, <?php echo $total_roles; ?> roles</div>
            </div>
        </div>
    </div>
</div>

<div class="roles-container">

    <!-- Main Card -->
    <div class="main-card">
        <!-- Alert Messages -->
        <?php if ($success_message): ?>
            <div class="mx-4 mt-4 rounded-md bg-green-50 p-3 border border-green-200">
                <div class="flex items-center">
                    <i class="fas fa-check-circle text-green-400 mr-2"></i>
                    <p class="text-sm text-green-800"><?php echo htmlspecialchars($success_message); ?></p>
                </div>
            </div>
        <?php endif; ?>

        <?php if ($error_message): ?>
            <div class="mx-4 mt-4 rounded-md bg-red-50 p-3 border border-red-200">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle text-red-400 mr-2"></i>
                    <p class="text-sm text-red-800"><?php echo htmlspecialchars($error_message); ?></p>
                </div>
            </div>
        <?php endif; ?>

        <!-- Tab Navigation -->
        <div class="border-b border-gray-200 mx-4 mt-4">
            <nav class="flex space-x-4">
                <button onclick="showTab('administrators')" id="administrators-tab" class="tab-button active">
                    <i class="fas fa-users mr-1"></i>Administrators
                </button>
                <button onclick="showTab('create')" id="create-tab" class="tab-button">
                    <i class="fas fa-user-plus mr-1"></i>Create Admin
                </button>
            </nav>
        </div>

        <!-- Administrators Tab -->
        <div id="administrators-content" class="tab-content card-content">
            <div class="mb-3">
                <h3 class="font-semibold text-gray-900 text-lg">System Administrators</h3>
                <p class="text-sm text-gray-600">Total: <strong><?php echo count($admins); ?></strong> administrators</p>
            </div>

            <?php foreach ($admins as $admin): ?>
                <?php $current_permissions = $admin_permissions[$admin['id']]; ?>
                <?php $is_current_admin = $admin['id'] === $current_admin['id']; ?>
                <div class="admin-item <?php echo $is_current_admin ? 'current-admin' : ''; ?>">
                    <?php if ($is_current_admin): ?>
                        <div class="mb-2">
                            <span class="bg-red-100 text-red-800 text-xs font-medium px-2 py-1 rounded">
                                <i class="fas fa-user-shield mr-1"></i>Your Account
                            </span>
                        </div>
                    <?php endif; ?>
                    
                    <div class="flex items-start justify-between mb-2">
                        <div class="flex items-center">
                            <div class="admin-avatar">
                                <?php echo strtoupper(substr($admin['name'], 0, 2)); ?>
                            </div>
                            <div class="ml-3">
                                <h4 class="font-medium text-gray-900 text-sm"><?php echo htmlspecialchars($admin['name']); ?></h4>
                                <p class="text-xs text-gray-500"><?php echo htmlspecialchars($admin['email']); ?></p>
                                <div class="flex items-center space-x-1 mt-1">
                                    <span class="status-badge <?php echo $admin['role'] === 'super_admin' ? 'bg-red-100 text-red-800' : 
                                                  ($admin['role'] === 'admin' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-800'); ?>">
                                        <?php echo ucfirst(str_replace('_', ' ', $admin['role'])); ?>
                                    </span>
                                    <span class="status-badge <?php echo $admin['is_active'] ? 'status-active' : 'status-inactive'; ?>">
                                        <?php echo $admin['is_active'] ? 'Active' : 'Inactive'; ?>
                                    </span>
                                    <?php if (!$admin['email_verified']): ?>
                                        <span class="status-badge status-unverified">
                                            Email Unverified
                                        </span>
                                    <?php endif; ?>
                                </div>
                            </div>
                        </div>

                        <?php if (!$is_current_admin): ?>
                            <div class="flex flex-wrap gap-1">
                                <button onclick="togglePermissions(<?php echo $admin['id']; ?>)" class="quick-action-btn btn-edit">
                                    <i class="fas fa-edit mr-1"></i>Edit
                                </button>
                                <?php if ($admin['is_active']): ?>
                                    <form method="POST" class="inline" onsubmit="return confirm('Are you sure you want to deactivate this administrator?')">
                                        <input type="hidden" name="csrf_token" value="<?php echo generate_csrf_token(); ?>">
                                        <input type="hidden" name="toggle_status" value="1">
                                        <input type="hidden" name="admin_id" value="<?php echo $admin['id']; ?>">
                                        <input type="hidden" name="current_status" value="<?php echo $admin['is_active']; ?>">
                                        <button type="submit" class="quick-action-btn btn-reject">
                                            <i class="fas fa-ban mr-1"></i>Deactivate
                                        </button>
                                    </form>
                                <?php else: ?>
                                    <form method="POST" class="inline" onsubmit="return confirm('Are you sure you want to activate this administrator?')">
                                        <input type="hidden" name="csrf_token" value="<?php echo generate_csrf_token(); ?>">
                                        <input type="hidden" name="toggle_status" value="1">
                                        <input type="hidden" name="admin_id" value="<?php echo $admin['id']; ?>">
                                        <input type="hidden" name="current_status" value="<?php echo $admin['is_active']; ?>">
                                        <button type="submit" class="quick-action-btn btn-approve">
                                            <i class="fas fa-check mr-1"></i>Activate
                                        </button>
                                    </form>
                                <?php endif; ?>
                            </div>
                        <?php endif; ?>
                    </div>

                    <!-- Current Permissions Display -->
                    <div class="flex flex-wrap gap-1 mb-2">
                        <?php if ($admin['role'] === 'super_admin'): ?>
                            <span class="status-badge bg-red-100 text-red-800">All Permissions</span>
                        <?php else: ?>
                            <?php foreach (array_slice($current_permissions, 0, 3) as $perm): ?>
                                <span class="status-badge bg-blue-100 text-blue-800">
                                    <?php echo $available_permissions[$perm] ?? $perm; ?>
                                </span>
                            <?php endforeach; ?>
                            <?php if (count($current_permissions) > 3): ?>
                                <span class="status-badge bg-gray-100 text-gray-800">
                                    +<?php echo count($current_permissions) - 3; ?> more
                                </span>
                            <?php endif; ?>
                            <?php if (empty($current_permissions)): ?>
                                <span class="text-xs text-gray-500">No permissions assigned</span>
                            <?php endif; ?>
                        <?php endif; ?>
                    </div>

                    <?php if (!$is_current_admin): ?>
                        <div id="permissions-<?php echo $admin['id']; ?>" class="hidden border-t border-gray-200 pt-3 mt-3">
                            <form method="POST">
                                <input type="hidden" name="csrf_token" value="<?php echo generate_csrf_token(); ?>">
                                <input type="hidden" name="update_permissions" value="1">
                                <input type="hidden" name="admin_id" value="<?php echo $admin['id']; ?>">

                                <div class="permissions-grid">
                                    <?php foreach ($available_permissions as $perm_key => $perm_name): ?>
                                        <label class="permission-item">
                                            <input type="checkbox" name="permissions[]" value="<?php echo $perm_key; ?>" 
                                                   <?php echo in_array($perm_key, $current_permissions) ? 'checked' : ''; ?>>
                                            <span class="text-xs"><?php echo $perm_name; ?></span>
                                        </label>
                                    <?php endforeach; ?>
                                </div>

                                <div class="flex justify-end space-x-2 mt-3">
                                    <button type="button" onclick="togglePermissions(<?php echo $admin['id']; ?>)" 
                                            class="px-3 py-1 text-xs text-gray-600 hover:text-gray-800">Cancel</button>
                                    <button type="submit" class="px-3 py-1 bg-blue-600 text-white rounded text-xs hover:bg-blue-700">
                                        Save Permissions
                                    </button>
                                </div>
                            </form>
                        </div>
                    <?php endif; ?>
                </div>
            <?php endforeach; ?>
        </div>

        <!-- Create Administrator Tab -->
        <div id="create-content" class="tab-content hidden card-content">
            <div class="mb-3">
                <h3 class="font-semibold text-gray-900 text-lg">Create New Administrator</h3>
                <p class="text-sm text-gray-600">Add a new administrator to the system</p>
            </div>

            <form method="POST" class="space-y-4">
                <input type="hidden" name="csrf_token" value="<?php echo generate_csrf_token(); ?>">
                <input type="hidden" name="create_admin" value="1">

                <div class="form-section">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
                            <input type="text" name="name" required 
                                   class="w-full rounded border-gray-300 text-sm focus:border-blue-500 focus:ring-blue-500"
                                   placeholder="Enter full name">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Email Address *</label>
                            <input type="email" name="email" required 
                                   class="w-full rounded border-gray-300 text-sm focus:border-blue-500 focus:ring-blue-500"
                                   placeholder="Enter email address">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Password *</label>
                            <input type="password" name="password" required minlength="8"
                                   class="w-full rounded border-gray-300 text-sm focus:border-blue-500 focus:ring-blue-500"
                                   placeholder="Minimum 8 characters">
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Role *</label>
                            <select name="role" required 
                                    class="w-full rounded border-gray-300 text-sm focus:border-blue-500 focus:ring-blue-500">
                                <option value="">Select Role</option>
                                <option value="admin">Administrator</option>
                                <option value="viewer">Viewer</option>
                                <option value="super_admin">Super Administrator</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="bg-blue-50 border border-blue-200 rounded p-3">
                    <div class="flex items-start">
                        <i class="fas fa-info-circle text-blue-600 mt-1 mr-2"></i>
                        <div class="text-sm text-blue-800">
                            <p class="font-medium">Email Verification Process</p>
                            <p>New administrators will be created as inactive and require email verification. An activation email will be sent automatically.</p>
                        </div>
                    </div>
                </div>

                <div class="flex justify-end">
                    <button type="submit" 
                            class="px-4 py-2 bg-blue-600 text-white text-sm font-medium rounded hover:bg-blue-700">
                        <i class="fas fa-user-plus mr-1"></i>Create Administrator
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function showTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.add('hidden');
    });
    document.querySelectorAll('.tab-button').forEach(button => {
        button.classList.remove('active');
    });
    document.getElementById(tabName + '-content').classList.remove('hidden');
    document.getElementById(tabName + '-tab').classList.add('active');
}

function togglePermissions(adminId) {
    const element = document.getElementById('permissions-' + adminId);
    element.classList.toggle('hidden');
}

function refreshCSRFToken() {
    fetch('../api/csrfToken.php')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                document.querySelectorAll('input[name="csrf_token"]').forEach(input => {
                    input.value = data.token;
                });
            }
        })
        .catch(error => {
            console.error('Error refreshing CSRF token:', error);
        });
}

setInterval(refreshCSRFToken, 240000);

document.addEventListener('visibilitychange', function() {
    if (!document.hidden) {
        refreshCSRFToken();
    }
});
</script>

<?php include 'includes/adminFooter.php'; ?>