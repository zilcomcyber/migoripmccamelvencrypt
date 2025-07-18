<?php
require_once '../config.php';
require_once __DIR__ . '/includes/pageSecurity.php';
require_once '../includes/auditTrail.php';

$page_title = "Audit Trail";
include __DIR__ . '/includes/adminHeader.php';

// Get filter parameters
$table_filter = $_GET['table'] ?? '';
$date_from = $_GET['date_from'] ?? date('Y-m-d', strtotime('-30 days'));
$date_to = $_GET['date_to'] ?? date('Y-m-d');
$admin_filter = $_GET['admin'] ?? '';
$action_filter = $_GET['action'] ?? '';

// Get audit statistics
$audit_stats = AuditTrail::getAuditStats(30);

// Get auditable tables
$auditable_tables = AuditTrail::getAuditableTables();

// Check audit trail status for each table
$table_audit_status = [];
foreach ($auditable_tables as $table) {
    $table_audit_status[$table] = AuditTrail::checkTableAuditColumns($table);
}

// Get audit history with filters
$sql_filters = ["aal.created_at >= ? AND aal.created_at <= ?"];
$params = [$date_from . ' 00:00:00', $date_to . ' 23:59:59'];

if (!empty($table_filter)) {
    $sql_filters[] = "aal.target_type = ?";
    $params[] = $table_filter;
}

if (!empty($admin_filter)) {
    $sql_filters[] = "aal.admin_id = ?";
    $params[] = $admin_filter;
}

if (!empty($action_filter)) {
    $sql_filters[] = "aal.activity_type LIKE ?";
    $params[] = "%{$action_filter}%";
}

$sql = "
    SELECT 
        aal.*,
        a.name as admin_name,
        a.email as admin_email
    FROM admin_activity_log aal
    LEFT JOIN admins a ON aal.admin_id = a.id
    WHERE " . implode(' AND ', $sql_filters) . "
    ORDER BY aal.created_at DESC
    LIMIT 100
";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$audit_logs = $stmt->fetchAll();

// Get all admins for filter dropdown
$admins_stmt = $pdo->query("SELECT id, name FROM admins WHERE is_active = 1 ORDER BY name");
$admins = $admins_stmt->fetchAll();
?>

<div class="bg-white rounded-xl p-6 mb-6 shadow-sm border border-gray-200">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">Audit Trail</h1>
        <p class="text-gray-600">Track all data changes and administrative actions</p>
    </div>

    <!-- Audit Statistics -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="bg-blue-50 rounded-lg p-6">
            <h3 class="text-lg font-semibold text-blue-900 mb-2">Total Operations</h3>
            <p class="text-3xl font-bold text-blue-600">
                <?php echo array_sum(array_column($audit_stats, 'total_operations')); ?>
            </p>
            <p class="text-sm text-blue-700">Last 30 days</p>
        </div>

        <div class="bg-green-50 rounded-lg p-6">
            <h3 class="text-lg font-semibold text-green-900 mb-2">Creates</h3>
            <p class="text-3xl font-bold text-green-600">
                <?php echo array_sum(array_column($audit_stats, 'creates')); ?>
            </p>
            <p class="text-sm text-green-700">New records created</p>
        </div>

        <div class="bg-yellow-50 rounded-lg p-6">
            <h3 class="text-lg font-semibold text-yellow-900 mb-2">Updates</h3>
            <p class="text-3xl font-bold text-yellow-600">
                <?php echo array_sum(array_column($audit_stats, 'updates')); ?>
            </p>
            <p class="text-sm text-yellow-700">Records modified</p>
        </div>

        <div class="bg-red-50 rounded-lg p-6">
            <h3 class="text-lg font-semibold text-red-900 mb-2">Deletes</h3>
            <p class="text-3xl font-bold text-red-600">
                <?php echo array_sum(array_column($audit_stats, 'deletes')); ?>
            </p>
            <p class="text-sm text-red-700">Records deleted</p>
        </div>
    </div>

    <!-- Table Audit Status -->
    <div class="mb-8">
        <h2 class="text-xl font-bold text-gray-900 mb-4">Table Audit Status</h2>
        <div class="overflow-x-auto">
            <table class="min-w-full table-auto">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Table</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Columns</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Missing</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <?php foreach ($table_audit_status as $table => $status): ?>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                            <?php echo htmlspecialchars($table); ?>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <?php if ($status['has_all_columns']): ?>
                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-green-100 text-green-800">
                                    Complete
                                </span>
                            <?php else: ?>
                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-red-100 text-red-800">
                                    Incomplete
                                </span>
                            <?php endif; ?>
                        </td>
                        <td class="px-6 py-4 text-sm text-gray-900">
                            <?php echo implode(', ', $status['existing_columns']); ?>
                        </td>
                        <td class="px-6 py-4 text-sm text-red-600">
                            <?php echo implode(', ', $status['missing_columns']); ?>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Filters -->
    <div class="bg-gray-50 rounded-lg p-6 mb-6">
        <h2 class="text-lg font-semibold text-gray-900 mb-4">Filters</h2>
        <form method="GET" class="grid grid-cols-1 md:grid-cols-5 gap-4">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Table</label>
                <select name="table" class="w-full border border-gray-300 rounded-md px-3 py-2">
                    <option value="">All Tables</option>
                    <?php foreach ($auditable_tables as $table): ?>
                    <option value="<?php echo htmlspecialchars($table); ?>" 
                            <?php echo $table_filter === $table ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($table); ?>
                    </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">From Date</label>
                <input type="date" name="date_from" value="<?php echo htmlspecialchars($date_from); ?>"
                       class="w-full border border-gray-300 rounded-md px-3 py-2">
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">To Date</label>
                <input type="date" name="date_to" value="<?php echo htmlspecialchars($date_to); ?>"
                       class="w-full border border-gray-300 rounded-md px-3 py-2">
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Admin</label>
                <select name="admin" class="w-full border border-gray-300 rounded-md px-3 py-2">
                    <option value="">All Admins</option>
                    <?php foreach ($admins as $admin): ?>
                    <option value="<?php echo $admin['id']; ?>" 
                            <?php echo $admin_filter == $admin['id'] ? 'selected' : ''; ?>>
                        <?php echo htmlspecialchars($admin['name']); ?>
                    </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <div class="flex items-end">
                <button type="submit" class="w-full bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700">
                    Filter
                </button>
            </div>
        </form>
    </div>

    <!-- Audit Log -->
    <div class="bg-white rounded-lg shadow overflow-hidden">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-900">Recent Activity</h2>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full table-auto">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Timestamp</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Admin</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Action</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Table</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Record ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Description</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <?php foreach ($audit_logs as $log): ?>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <?php echo date('M j, Y H:i:s', strtotime($log['created_at'])); ?>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <?php 
                            $admin_name = $log['admin_name'] ?? 'System';
                            // Decrypt admin name if it's encrypted
                            if (!empty($admin_name) && DataEncryption::isEncrypted($admin_name)) {
                                $admin_name = DataEncryption::decrypt($admin_name);
                            }
                            echo htmlspecialchars($admin_name); 
                            ?>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <?php
                            $action_class = 'bg-gray-100 text-gray-800';
                            if (strpos($log['activity_type'], 'create') !== false) {
                                $action_class = 'bg-green-100 text-green-800';
                            } elseif (strpos($log['activity_type'], 'update') !== false) {
                                $action_class = 'bg-yellow-100 text-yellow-800';
                            } elseif (strpos($log['activity_type'], 'delete') !== false) {
                                $action_class = 'bg-red-100 text-red-800';
                            }
                            ?>
                            <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full <?php echo $action_class; ?>">
                                <?php echo htmlspecialchars($log['activity_type']); ?>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <?php echo htmlspecialchars($log['target_type'] ?? 'N/A'); ?>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                            <?php echo htmlspecialchars($log['target_id'] ?? 'N/A'); ?>
                        </td>
                        <td class="px-6 py-4 text-sm text-gray-900">
                            <?php echo htmlspecialchars($log['activity_description']); ?>
                        </td>
                    </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php include __DIR__ . '/includes/adminFooter.php'; ?>