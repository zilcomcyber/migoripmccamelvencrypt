
<?php
/**
 * Financial Ledger Management System
 * Handles debit/credit transactions, purchase requests, purchase orders, WBS, and CBS
 */

require_once __DIR__ . '/functions.php';
require_once __DIR__ . '/encryptionHelper.php';

class FinancialLedger {
    
    /**
     * Create a new ledger transaction with proper debit/credit accounting
     */
    public static function createTransaction($project_id, $data, $admin_id) {
        global $pdo;
        
        try {
            $pdo->beginTransaction();
            
            // Validate transaction data
            $required_fields = ['description', 'account_type', 'transaction_date'];
            foreach ($required_fields as $field) {
                if (empty($data[$field])) {
                    throw new Exception("Missing required field: $field");
                }
            }
            
            // Ensure either debit or credit is provided, not both
            $debit_amount = floatval($data['debit_amount'] ?? 0);
            $credit_amount = floatval($data['credit_amount'] ?? 0);
            
            if (($debit_amount > 0 && $credit_amount > 0) || ($debit_amount == 0 && $credit_amount == 0)) {
                throw new Exception("Transaction must have either debit OR credit amount, not both or neither");
            }
            
            $transaction_data = [
                'project_id' => $project_id,
                'transaction_reference' => $data['transaction_reference'] ?? self::generateTransactionReference(),
                'transaction_date' => $data['transaction_date'],
                'description' => $data['description'],
                'debit_amount' => $debit_amount,
                'credit_amount' => $credit_amount,
                'account_type' => $data['account_type'],
                'account_code' => $data['account_code'] ?? null,
                'voucher_number' => $data['voucher_number'] ?? null,
                'supporting_document' => $data['supporting_document'] ?? null,
                'transaction_status' => 'pending',
                'created_by' => $admin_id
            ];
            
            $result = EncryptionHelper::insertEncrypted($pdo, 'transactions_ledger', $transaction_data);
            
            if (!$result) {
                throw new Exception('Failed to create transaction');
            }
            
            $transaction_id = $pdo->lastInsertId();
            
            // Map to CBS if provided
            if (!empty($data['cbs_allocations']) && is_array($data['cbs_allocations'])) {
                foreach ($data['cbs_allocations'] as $allocation) {
                    self::mapTransactionToCBS($transaction_id, $allocation['cbs_id'], $allocation['amount']);
                }
            }
            
            log_activity('financial_transaction_created', 
                        "Created financial transaction: {$data['description']}", 
                        $admin_id, 'financial', $transaction_id);
            
            $pdo->commit();
            return ['success' => true, 'transaction_id' => $transaction_id];
            
        } catch (Exception $e) {
            $pdo->rollBack();
            error_log("Create financial transaction error: " . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Create Purchase Request
     */
    public static function createPurchaseRequest($project_id, $data, $admin_id) {
        global $pdo;
        
        try {
            $pdo->beginTransaction();
            
            $pr_data = [
                'pr_number' => self::generatePRNumber(),
                'project_id' => $project_id,
                'department_id' => $data['department_id'],
                'request_title' => $data['request_title'],
                'justification' => $data['justification'],
                'estimated_cost' => $data['estimated_cost'],
                'priority' => $data['priority'] ?? 'medium',
                'requested_delivery_date' => $data['requested_delivery_date'] ?? null,
                'budget_line_item' => $data['budget_line_item'] ?? null,
                'procurement_method' => $data['procurement_method'] ?? 'quotation',
                'requested_by' => $admin_id,
                'created_by' => $admin_id
            ];
            
            $result = EncryptionHelper::insertEncrypted($pdo, 'purchase_requests', $pr_data);
            
            if (!$result) {
                throw new Exception('Failed to create purchase request');
            }
            
            $pr_id = $pdo->lastInsertId();
            
            // Add items if provided
            if (!empty($data['items']) && is_array($data['items'])) {
                foreach ($data['items'] as $item) {
                    $item_data = [
                        'purchase_request_id' => $pr_id,
                        'item_description' => $item['description'],
                        'quantity' => $item['quantity'],
                        'unit_of_measure' => $item['unit'],
                        'estimated_unit_cost' => $item['unit_cost'],
                        'specifications' => $item['specifications'] ?? null
                    ];
                    
                    EncryptionHelper::insertEncrypted($pdo, 'purchase_request_items', $item_data);
                }
            }
            
            log_activity('purchase_request_created', 
                        "Created purchase request: {$data['request_title']}", 
                        $admin_id, 'procurement', $pr_id);
            
            $pdo->commit();
            return ['success' => true, 'pr_id' => $pr_id, 'pr_number' => $pr_data['pr_number']];
            
        } catch (Exception $e) {
            $pdo->rollBack();
            error_log("Create purchase request error: " . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Create Purchase Order from approved Purchase Request
     */
    public static function createPurchaseOrder($purchase_request_id, $data, $admin_id) {
        global $pdo;
        
        try {
            $pdo->beginTransaction();
            
            // Get PR details
            $pr = EncryptionHelper::selectDecrypted($pdo, 
                "SELECT * FROM purchase_requests WHERE id = ? AND status = 'approved'", 
                [$purchase_request_id], 'purchase_requests', false);
            
            if (!$pr) {
                throw new Exception('Purchase request not found or not approved');
            }
            
            $po_data = [
                'po_number' => self::generatePONumber(),
                'purchase_request_id' => $purchase_request_id,
                'project_id' => $pr['project_id'],
                'supplier_name' => $data['supplier_name'],
                'supplier_contact' => $data['supplier_contact'] ?? null,
                'supplier_address' => $data['supplier_address'] ?? null,
                'po_title' => $data['po_title'] ?? $pr['request_title'],
                'total_amount' => $data['total_amount'],
                'vat_amount' => $data['vat_amount'] ?? 0,
                'delivery_date' => $data['delivery_date'] ?? null,
                'delivery_location' => $data['delivery_location'] ?? null,
                'payment_terms' => $data['payment_terms'] ?? null,
                'warranty_terms' => $data['warranty_terms'] ?? null,
                'issued_date' => date('Y-m-d'),
                'notes' => $data['notes'] ?? null,
                'created_by' => $admin_id
            ];
            
            $result = EncryptionHelper::insertEncrypted($pdo, 'purchase_orders', $po_data);
            
            if (!$result) {
                throw new Exception('Failed to create purchase order');
            }
            
            $po_id = $pdo->lastInsertId();
            
            // Copy items from PR to PO
            $pr_items = EncryptionHelper::selectDecrypted($pdo, 
                "SELECT * FROM purchase_request_items WHERE purchase_request_id = ?", 
                [$purchase_request_id], 'purchase_request_items');
            
            foreach ($pr_items as $pr_item) {
                $po_item_data = [
                    'purchase_order_id' => $po_id,
                    'item_description' => $pr_item['item_description'],
                    'quantity_ordered' => $pr_item['quantity'],
                    'unit_of_measure' => $pr_item['unit_of_measure'],
                    'unit_cost' => $pr_item['estimated_unit_cost'],
                    'specifications' => $pr_item['specifications']
                ];
                
                EncryptionHelper::insertEncrypted($pdo, 'purchase_order_items', $po_item_data);
            }
            
            // Update PR status
            EncryptionHelper::updateEncrypted($pdo, 'purchase_requests', 
                ['status' => 'converted_to_po'], ['id' => $purchase_request_id]);
            
            log_activity('purchase_order_created', 
                        "Created purchase order: {$po_data['po_title']}", 
                        $admin_id, 'procurement', $po_id);
            
            $pdo->commit();
            return ['success' => true, 'po_id' => $po_id, 'po_number' => $po_data['po_number']];
            
        } catch (Exception $e) {
            $pdo->rollBack();
            error_log("Create purchase order error: " . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Create Work Breakdown Structure
     */
    public static function createWBS($project_id, $data, $admin_id) {
        global $pdo;
        
        try {
            $wbs_data = [
                'project_id' => $project_id,
                'wbs_code' => $data['wbs_code'],
                'parent_wbs_id' => $data['parent_wbs_id'] ?? null,
                'wbs_level' => $data['wbs_level'] ?? 1,
                'work_package_name' => $data['work_package_name'],
                'description' => $data['description'] ?? null,
                'deliverables' => $data['deliverables'] ?? null,
                'start_date' => $data['start_date'] ?? null,
                'end_date' => $data['end_date'] ?? null,
                'estimated_cost' => $data['estimated_cost'] ?? 0,
                'responsible_admin' => $data['responsible_admin'] ?? null,
                'is_milestone' => $data['is_milestone'] ?? 0,
                'created_by' => $admin_id
            ];
            
            $result = EncryptionHelper::insertEncrypted($pdo, 'work_breakdown_structure', $wbs_data);
            
            if (!$result) {
                throw new Exception('Failed to create WBS item');
            }
            
            $wbs_id = $pdo->lastInsertId();
            
            log_activity('wbs_created', 
                        "Created WBS item: {$data['work_package_name']}", 
                        $admin_id, 'project', $wbs_id);
            
            return ['success' => true, 'wbs_id' => $wbs_id];
            
        } catch (Exception $e) {
            error_log("Create WBS error: " . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Create Cost Breakdown Structure
     */
    public static function createCBS($project_id, $data, $admin_id) {
        global $pdo;
        
        try {
            $cbs_data = [
                'project_id' => $project_id,
                'wbs_id' => $data['wbs_id'] ?? null,
                'cbs_code' => $data['cbs_code'],
                'parent_cbs_id' => $data['parent_cbs_id'] ?? null,
                'cost_category' => $data['cost_category'],
                'cost_subcategory' => $data['cost_subcategory'] ?? null,
                'description' => $data['description'] ?? null,
                'budget_allocation' => $data['budget_allocation'],
                'cost_type' => $data['cost_type'] ?? 'direct',
                'is_controllable' => $data['is_controllable'] ?? 1,
                'fiscal_year' => $data['fiscal_year'] ?? date('Y'),
                'fund_source_id' => $data['fund_source_id'] ?? null,
                'created_by' => $admin_id
            ];
            
            $result = EncryptionHelper::insertEncrypted($pdo, 'cost_breakdown_structure', $cbs_data);
            
            if (!$result) {
                throw new Exception('Failed to create CBS item');
            }
            
            $cbs_id = $pdo->lastInsertId();
            
            log_activity('cbs_created', 
                        "Created CBS item: {$data['cost_category']}", 
                        $admin_id, 'financial', $cbs_id);
            
            return ['success' => true, 'cbs_id' => $cbs_id];
            
        } catch (Exception $e) {
            error_log("Create CBS error: " . $e->getMessage());
            return ['success' => false, 'message' => $e->getMessage()];
        }
    }
    
    /**
     * Get financial summary for a project
     */
    public static function getProjectFinancialSummary($project_id) {
        global $pdo;
        
        try {
            // Get ledger summary
            $ledger_stmt = $pdo->prepare("
                SELECT 
                    SUM(debit_amount) as total_debits,
                    SUM(credit_amount) as total_credits,
                    COUNT(*) as transaction_count
                FROM transactions_ledger 
                WHERE project_id = ? AND transaction_status = 'posted'
            ");
            $ledger_stmt->execute([$project_id]);
            $ledger_summary = $ledger_stmt->fetch();
            
            // Get CBS summary
            $cbs_stmt = $pdo->prepare("
                SELECT 
                    SUM(budget_allocation) as total_budget_allocation,
                    SUM(committed_amount) as total_committed,
                    SUM(actual_expenditure) as total_expenditure,
                    AVG(budget_utilization_percentage) as avg_utilization
                FROM cost_breakdown_structure 
                WHERE project_id = ?
            ");
            $cbs_stmt->execute([$project_id]);
            $cbs_summary = $cbs_stmt->fetch();
            
            // Get Purchase Orders summary
            $po_stmt = $pdo->prepare("
                SELECT 
                    COUNT(*) as total_pos,
                    SUM(total_amount) as total_po_value,
                    SUM(CASE WHEN status = 'fully_delivered' THEN total_amount ELSE 0 END) as delivered_value
                FROM purchase_orders 
                WHERE project_id = ?
            ");
            $po_stmt->execute([$project_id]);
            $po_summary = $po_stmt->fetch();
            
            return [
                'ledger' => $ledger_summary,
                'cbs' => $cbs_summary,
                'purchase_orders' => $po_summary
            ];
            
        } catch (Exception $e) {
            error_log("Get project financial summary error: " . $e->getMessage());
            return null;
        }
    }
    
    /**
     * Helper method to map transaction to CBS
     */
    private static function mapTransactionToCBS($transaction_id, $cbs_id, $amount) {
        global $pdo;
        
        $mapping_data = [
            'transaction_id' => $transaction_id,
            'cbs_id' => $cbs_id,
            'allocated_amount' => $amount
        ];
        
        return EncryptionHelper::insertEncrypted($pdo, 'transaction_cbs_mapping', $mapping_data);
    }
    
    /**
     * Generate unique transaction reference
     */
    private static function generateTransactionReference() {
        return 'TXN-' . date('Ymd') . '-' . strtoupper(substr(uniqid(), -6));
    }
    
    /**
     * Generate unique Purchase Request number
     */
    private static function generatePRNumber() {
        return 'PR-' . date('Y') . '-' . str_pad(mt_rand(1, 9999), 4, '0', STR_PAD_LEFT);
    }
    
    /**
     * Generate unique Purchase Order number
     */
    private static function generatePONumber() {
        return 'PO-' . date('Y') . '-' . str_pad(mt_rand(1, 9999), 4, '0', STR_PAD_LEFT);
    }
}
?>
