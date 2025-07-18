<?php
require_once '../includes/functions.php';
require_once '../includes/financialLedger.php';
require_once '../includes/auth.php';
require_once 'includes/adminHeader.php';

// Check if user is logged in and has permission
if (!is_logged_in()) {
    header('Location: ../login.php');
    exit;
}

if (!has_permission('financial_management')) {
    header('Location: ../404.php');
    exit;
}

// Restrict to super admin only
$current_admin = get_current_admin();
if ($current_admin['role'] !== 'super_admin') {
    header('Location: ../404.php');
    exit;
}

$current_admin = get_current_admin();
$page_title = "Financial Management";

// Handle form submissions
$message = '';
$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';

    switch ($action) {
        case 'create_transaction':
            $result = FinancialLedger::createTransaction($_POST['project_id'], $_POST, $current_admin['id']);
            if ($result['success']) {
                $message = 'Transaction created successfully';
            } else {
                $error = $result['message'];
            }
            break;

        case 'create_purchase_request':
            $result = FinancialLedger::createPurchaseRequest($_POST['project_id'], $_POST, $current_admin['id']);
            if ($result['success']) {
                $message = "Purchase Request {$result['pr_number']} created successfully";
            } else {
                $error = $result['message'];
            }
            break;

        case 'create_wbs':
            $result = FinancialLedger::createWBS($_POST['project_id'], $_POST, $current_admin['id']);
            if ($result['success']) {
                $message = 'WBS item created successfully';
            } else {
                $error = $result['message'];
            }
            break;

        case 'create_cbs':
            $result = FinancialLedger::createCBS($_POST['project_id'], $_POST, $current_admin['id']);
            if ($result['success']) {
                $message = 'CBS item created successfully';
            } else {
                $error = $result['message'];
            }
            break;
    }
}

// Get available projects based on admin role
$role_filter = build_role_filter($current_admin);
$projects = $pdo->prepare("SELECT id, project_name FROM projects" . $role_filter['filter'] . " ORDER BY project_name");
$projects->execute($role_filter['params']);
$available_projects = $projects->fetchAll();

// Get chart of accounts
$accounts = $pdo->query("SELECT * FROM chart_of_accounts WHERE is_active = 1 ORDER BY account_code")->fetchAll();

// Get fund sources
$fund_sources = get_fund_sources();

log_activity('financial_management_access', 'Accessed financial management page', $current_admin['id']);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $page_title; ?> - PMC Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0 text-gray-800">Financial Management System</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.php">Dashboard</a></li>
                            <li class="breadcrumb-item active">Financial Management</li>
                        </ol>
                    </nav>
                </div>

                <?php if ($message): ?>
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <?php echo htmlspecialchars($message); ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>

                <?php if ($error): ?>
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <?php echo htmlspecialchars($error); ?>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <?php endif; ?>

                <!-- Navigation Tabs -->
                <ul class="nav nav-tabs mb-4" id="financialTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="ledger-tab" data-bs-toggle="tab" data-bs-target="#ledger" type="button">
                            Transactions Ledger
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="procurement-tab" data-bs-toggle="tab" data-bs-target="#procurement" type="button">
                            Procurement
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="wbs-tab" data-bs-toggle="tab" data-bs-target="#wbs" type="button">
                            Work Breakdown Structure
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="cbs-tab" data-bs-toggle="tab" data-bs-target="#cbs" type="button">
                            Cost Breakdown Structure
                        </button>
                    </li>
                </ul>

                <div class="tab-content" id="financialTabsContent">
                    <!-- Transactions Ledger Tab -->
                    <div class="tab-pane fade show active" id="ledger" role="tabpanel">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Create New Transaction</h5>
                            </div>
                            <div class="card-body">
                                <form method="POST" class="row g-3">
                                    <input type="hidden" name="action" value="create_transaction">

                                    <div class="col-md-6">
                                        <label for="project_id" class="form-label">Project</label>
                                        <select class="form-select" name="project_id" required>
                                            <option value="">Select Project</option>
                                            <?php foreach ($available_projects as $project): ?>
                                                <option value="<?php echo $project['id']; ?>">
                                                    <?php echo htmlspecialchars($project['project_name']); ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="transaction_date" class="form-label">Transaction Date</label>
                                        <input type="date" class="form-control" name="transaction_date" value="<?php echo date('Y-m-d'); ?>" required>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3" required></textarea>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="account_type" class="form-label">Account Type</label>
                                        <select class="form-select" name="account_type" required>
                                            <option value="">Select Account Type</option>
                                            <option value="asset">Asset</option>
                                            <option value="liability">Liability</option>
                                            <option value="equity">Equity</option>
                                            <option value="income">Income</option>
                                            <option value="expense">Expense</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="account_code" class="form-label">Account Code</label>
                                        <select class="form-select" name="account_code">
                                            <option value="">Select Account</option>
                                            <?php foreach ($accounts as $account): ?>
                                                <option value="<?php echo $account['account_code']; ?>">
                                                    <?php echo $account['account_code'] . ' - ' . $account['account_name']; ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="debit_amount" class="form-label">Debit Amount (KES)</label>
                                        <input type="number" step="0.01" class="form-control" name="debit_amount" placeholder="0.00">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="credit_amount" class="form-label">Credit Amount (KES)</label>
                                        <input type="number" step="0.01" class="form-control" name="credit_amount" placeholder="0.00">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="voucher_number" class="form-label">Voucher Number</label>
                                        <input type="text" class="form-control" name="voucher_number">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="transaction_reference" class="form-label">Reference Number</label>
                                        <input type="text" class="form-control" name="transaction_reference">
                                    </div>

                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Create Transaction</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Procurement Tab -->
                    <div class="tab-pane fade" id="procurement" role="tabpanel">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Create Purchase Request</h5>
                            </div>
                            <div class="card-body">
                                <form method="POST" class="row g-3">
                                    <input type="hidden" name="action" value="create_purchase_request">

                                    <div class="col-md-6">
                                        <label for="project_id" class="form-label">Project</label>
                                        <select class="form-select" name="project_id" required>
                                            <option value="">Select Project</option>
                                            <?php foreach ($available_projects as $project): ?>
                                                <option value="<?php echo $project['id']; ?>">
                                                    <?php echo htmlspecialchars($project['project_name']); ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="department_id" class="form-label">Department</label>
                                        <select class="form-select" name="department_id" required>
                                            <option value="">Select Department</option>
                                            <?php 
                                            $departments = get_departments();
                                            foreach ($departments as $dept): ?>
                                                <option value="<?php echo $dept['id']; ?>">
                                                    <?php echo htmlspecialchars($dept['name']); ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="request_title" class="form-label">Request Title</label>
                                        <input type="text" class="form-control" name="request_title" required>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="justification" class="form-label">Justification</label>
                                        <textarea class="form-control" name="justification" rows="3" required></textarea>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="estimated_cost" class="form-label">Estimated Cost (KES)</label>
                                        <input type="number" step="0.01" class="form-control" name="estimated_cost" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="priority" class="form-label">Priority</label>
                                        <select class="form-select" name="priority">
                                            <option value="medium">Medium</option>
                                            <option value="low">Low</option>
                                            <option value="high">High</option>
                                            <option value="urgent">Urgent</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="procurement_method" class="form-label">Procurement Method</label>
                                        <select class="form-select" name="procurement_method">
                                            <option value="quotation">Quotation</option>
                                            <option value="direct">Direct Procurement</option>
                                            <option value="tender">Tender</option>
                                            <option value="framework">Framework Agreement</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="requested_delivery_date" class="form-label">Requested Delivery Date</label>
                                        <input type="date" class="form-control" name="requested_delivery_date">
                                    </div>

                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Create Purchase Request</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- WBS Tab -->
                    <div class="tab-pane fade" id="wbs" role="tabpanel">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Create WBS Item</h5>
                            </div>
                            <div class="card-body">
                                <form method="POST" class="row g-3">
                                    <input type="hidden" name="action" value="create_wbs">

                                    <div class="col-md-6">
                                        <label for="project_id" class="form-label">Project</label>
                                        <select class="form-select" name="project_id" required>
                                            <option value="">Select Project</option>
                                            <?php foreach ($available_projects as $project): ?>
                                                <option value="<?php echo $project['id']; ?>">
                                                    <?php echo htmlspecialchars($project['project_name']); ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="wbs_code" class="form-label">WBS Code</label>
                                        <input type="text" class="form-control" name="wbs_code" placeholder="e.g., 1.1.1" required>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="work_package_name" class="form-label">Work Package Name</label>
                                        <input type="text" class="form-control" name="work_package_name" required>
                                    </div>

                                    <div class="col-md-12">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3"></textarea>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="estimated_cost" class="form-label">Estimated Cost (KES)</label>
                                        <input type="number" step="0.01" class="form-control" name="estimated_cost">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="wbs_level" class="form-label">WBS Level</label>
                                        <input type="number" class="form-control" name="wbs_level" value="1" min="1">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="start_date" class="form-label">Start Date</label>
                                        <input type="date" class="form-control" name="start_date">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="end_date" class="form-label">End Date</label>
                                        <input type="date" class="form-control" name="end_date">
                                    </div>

                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="is_milestone" value="1">
                                            <label class="form-check-label" for="is_milestone">
                                                Mark as Milestone
                                            </label>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Create WBS Item</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- CBS Tab -->
                    <div class="tab-pane fade" id="cbs" role="tabpanel">
                        <div class="card">
                            <div class="card-header">
                                <h5 class="card-title mb-0">Create CBS Item</h5>
                            </div>
                            <div class="card-body">
                                <form method="POST" class="row g-3">
                                    <input type="hidden" name="action" value="create_cbs">

                                    <div class="col-md-6">
                                        <label for="project_id" class="form-label">Project</label>
                                        <select class="form-select" name="project_id" required>
                                            <option value="">Select Project</option>
                                            <?php foreach ($available_projects as $project): ?>
                                                <option value="<?php echo $project['id']; ?>">
                                                    <?php echo htmlspecialchars($project['project_name']); ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="cbs_code" class="form-label">CBS Code</label>
                                        <input type="text" class="form-control" name="cbs_code" placeholder="e.g., C1.1" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="cost_category" class="form-label">Cost Category</label>
                                        <input type="text" class="form-control" name="cost_category" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="cost_subcategory" class="form-label">Cost Subcategory</label>
                                        <input type="text" class="form-control" name="cost_subcategory">
                                    </div>

                                    <div class="col-md-12">
                                        <label for="description" class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3"></textarea>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="budget_allocation" class="form-label">Budget Allocation (KES)</label>
                                        <input type="number" step="0.01" class="form-control" name="budget_allocation" required>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="cost_type" class="form-label">Cost Type</label>
                                        <select class="form-select" name="cost_type">
                                            <option value="direct">Direct</option>
                                            <option value="indirect">Indirect</option>
                                            <option value="overhead">Overhead</option>
                                            <option value="contingency">Contingency</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="fund_source_id" class="form-label">Fund Source</label>
                                        <select class="form-select" name="fund_source_id">
                                            <option value="">Select Fund Source</option>
                                            <?php foreach ($fund_sources as $source): ?>
                                                <option value="<?php echo $source['id']; ?>">
                                                    <?php echo htmlspecialchars($source['source_name']); ?>
                                                </option>
                                            <?php endforeach; ?>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="fiscal_year" class="form-label">Fiscal Year</label>
                                        <input type="text" class="form-control" name="fiscal_year" value="<?php echo date('Y'); ?>">
                                    </div>

                                    <div class="col-12">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="is_controllable" value="1" checked>
                                            <label class="form-check-label" for="is_controllable">
                                                Controllable Cost
                                            </label>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <button type="submit" class="btn btn-primary">Create CBS Item</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation to ensure only debit OR credit is entered
        document.addEventListener('DOMContentLoaded', function() {
            const debitInput = document.querySelector('input[name="debit_amount"]');
            const creditInput = document.querySelector('input[name="credit_amount"]');

            if (debitInput && creditInput) {
                debitInput.addEventListener('input', function() {
                    if (this.value > 0) {
                        creditInput.value = '';
                        creditInput.disabled = true;
                    } else {
                        creditInput.disabled = false;
                    }
                });

                creditInput.addEventListener('input', function() {
                    if (this.value > 0) {
                        debitInput.value = '';
                        debitInput.disabled = true;
                    } else {
                        debitInput.disabled = false;
                    }
                });
            }
        });
    </script>
</body>
</html>

<?php require_once 'includes/adminFooter.php'; ?>