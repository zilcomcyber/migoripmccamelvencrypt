<?php
// This file includes page security and displays system settings for super admin only
require_once 'includes/pageSecurity.php';
$current_admin = get_current_admin();

// Force logout if not super admin
if ($current_admin['role'] !== 'super_admin') {
    force_logout_with_incident('unauthorized_system_settings_access');
}

$page_title = "System Settings";

include 'includes/adminHeader.php';
?>

<div class="bg-white rounded-xl p-6 mb-6 shadow-sm border border-gray-200">
    <!-- Breadcrumbs -->
    <div class="mb-6">
        <nav class="flex" aria-label="Breadcrumb">
            <ol class="flex items-center space-x-2">
                <li><a href="index.php" class="text-gray-500 hover:text-gray-700">Dashboard</a></li>
                <li><span class="text-gray-400">/</span></li>
                <li><span class="text-gray-900">System Settings</span></li>
            </ol>
        </nav>
    </div>

    <!-- Page Header -->
    <div class="mb-8">
        <h1 class="text-2xl font-bold text-gray-900">System Settings</h1>
        <p class="text-gray-600 mt-2">Advanced system administration and configuration tools</p>
    </div>

    <!-- Quick Actions Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">
        <!-- Subscription Manager -->
        <a href="subscriptionManager.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-blue-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center group-hover:bg-blue-200 transition-colors">
                    <i class="fas fa-users text-blue-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-blue-600">Subscription Manager</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">Manage user subscriptions and notifications</p>
        </a>

        <!-- Data Encryption -->
        <a href="dataEncryption.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-green-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center group-hover:bg-green-200 transition-colors">
                    <i class="fas fa-shield-alt text-green-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-green-600">Data Encryption</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">Configure and manage data encryption settings</p>
        </a>

        <!-- Database Monitor -->
        <a href="dbmonitor.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-purple-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-purple-100 rounded-lg flex items-center justify-center group-hover:bg-purple-200 transition-colors">
                    <i class="fas fa-database text-purple-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-purple-600">Database Monitor</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">Monitor database performance and health</p>
        </a>

        <!-- Activity Logs -->
        <a href="activityLogs.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-indigo-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-indigo-100 rounded-lg flex items-center justify-center group-hover:bg-indigo-200 transition-colors">
                    <i class="fas fa-history text-indigo-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-indigo-600">Activity Logs</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">Track all administrative actions and system activities</p>
        </a>

        <!-- Comment Filtering -->
        <a href="commentFiltering.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-orange-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-orange-100 rounded-lg flex items-center justify-center group-hover:bg-orange-200 transition-colors">
                    <i class="fas fa-filter text-orange-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-orange-600">Comment Filtering</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">Manage comment moderation and filtering rules</p>
        </a>

        <!-- Activity Logs -->
        <a href="activityLogs.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-red-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-red-100 rounded-lg flex items-center justify-center group-hover:bg-red-200 transition-colors">
                    <i class="fas fa-history text-red-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-red-600">Activity Logs</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">View system activity and audit trails</p>
        </a>

        <!-- Financial Management -->
        <a href="financialManagement.php" class="group block p-6 bg-white rounded-lg border border-gray-200 hover:border-emerald-300 hover:shadow-md transition-all duration-200">
            <div class="flex items-center mb-4">
                <div class="w-12 h-12 bg-emerald-100 rounded-lg flex items-center justify-center group-hover:bg-emerald-200 transition-colors">
                    <i class="fas fa-chart-line text-emerald-600 text-lg"></i>
                </div>
                <div class="ml-4">
                    <h3 class="text-lg font-semibold text-gray-900 group-hover:text-emerald-600">Financial Management</h3>
                </div>
            </div>
            <p class="text-gray-600 text-sm">Advanced financial ledger, transactions, and procurement management</p>
        </a>
    </div>

    <!-- System Information -->
    <div class="mt-8 p-6 bg-gray-50 rounded-lg">
        <h3 class="text-lg font-semibold text-gray-900 mb-4">System Information</h3>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
            <div>
                <span class="font-medium text-gray-700">PHP Version:</span>
                <span class="text-gray-600 ml-2"><?php echo PHP_VERSION; ?></span>
            </div>
            <div>
                <span class="font-medium text-gray-700">Server Software:</span>
                <span class="text-gray-600 ml-2"><?php echo $_SERVER['SERVER_SOFTWARE'] ?? 'Unknown'; ?></span>
            </div>
            <div>
                <span class="font-medium text-gray-700">Current User:</span>
                <span class="text-gray-600 ml-2"><?php echo $current_admin['name']; ?> (<?php echo $current_admin['role']; ?>)</span>
            </div>
            <div>
                <span class="font-medium text-gray-700">Last Login:</span>
                <span class="text-gray-600 ml-2"><?php echo date('Y-m-d H:i:s'); ?></span>
            </div>
        </div>
    </div>
</div>

<?php include 'includes/adminFooter.php'; ?>
