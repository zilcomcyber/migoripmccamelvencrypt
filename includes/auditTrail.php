<?php
/**
 * Audit Trail Management Class
 * Handles all audit trail operations and statistics
 */

class AuditTrail {
    
    /**
     * Get audit statistics for the dashboard
     */
    public static function getAuditStats($days = 30) {
        global $pdo;
        
        try {
            $sql = "SELECT 
                        target_type as table_name,
                        COUNT(*) as total_operations,
                        SUM(CASE WHEN activity_type LIKE '%create%' THEN 1 ELSE 0 END) as creates,
                        SUM(CASE WHEN activity_type LIKE '%update%' THEN 1 ELSE 0 END) as updates,
                        SUM(CASE WHEN activity_type LIKE '%delete%' THEN 1 ELSE 0 END) as deletes
                    FROM admin_activity_log 
                    WHERE created_at >= DATE_SUB(NOW(), INTERVAL ? DAY)
                    GROUP BY target_type
                    ORDER BY total_operations DESC";
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute([$days]);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
            
        } catch (Exception $e) {
            error_log("Audit stats error: " . $e->getMessage());
            return [];
        }
    }
    
    /**
     * Get list of auditable tables
     */
    public static function getAuditableTables() {
        return [
            'admins',
            'departments', 
            'counties',
            'sub_counties',
            'wards',
            'fund_sources',
            'transaction_types',
            'prepared_responses',
            'import_logs',
            'projects',
            'project_steps',
            'project_transactions',
            'project_comments'
        ];
    }
    
    /**
     * Check if a table has all required audit columns
     */
    public static function checkTableAuditColumns($table_name) {
        global $pdo;
        
        $required_columns = ['created_by', 'created_at', 'modified_by', 'modified_at'];
        $existing_columns = [];
        $missing_columns = [];
        
        try {
            // Get table structure
            $stmt = $pdo->prepare("DESCRIBE `{$table_name}`");
            $stmt->execute();
            $columns = $stmt->fetchAll(PDO::FETCH_COLUMN);
            
            foreach ($required_columns as $required_col) {
                if (in_array($required_col, $columns)) {
                    $existing_columns[] = $required_col;
                } else {
                    $missing_columns[] = $required_col;
                }
            }
            
            return [
                'has_all_columns' => empty($missing_columns),
                'existing_columns' => $existing_columns,
                'missing_columns' => $missing_columns
            ];
            
        } catch (Exception $e) {
            error_log("Table audit check error for {$table_name}: " . $e->getMessage());
            return [
                'has_all_columns' => false,
                'existing_columns' => [],
                'missing_columns' => $required_columns
            ];
        }
    }
    
    /**
     * Log an audit trail entry
     */
    public static function logActivity($admin_id, $activity_type, $target_type, $target_id, $description, $details = null) {
        global $pdo;
        
        try {
            $sql = "INSERT INTO admin_activity_log 
                    (admin_id, activity_type, target_type, target_id, activity_description, activity_details, ip_address, user_agent, created_at) 
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute([
                $admin_id,
                $activity_type,
                $target_type,
                $target_id,
                $description,
                $details ? json_encode($details) : null,
                $_SERVER['REMOTE_ADDR'] ?? '',
                $_SERVER['HTTP_USER_AGENT'] ?? ''
            ]);
            
            return true;
            
        } catch (Exception $e) {
            error_log("Audit log error: " . $e->getMessage());
            return false;
        }
    }
    
    /**
     * Get recent audit activities
     */
    public static function getRecentActivities($limit = 50, $filters = []) {
        global $pdo;
        
        try {
            $sql = "SELECT 
                        aal.*,
                        a.name as admin_name,
                        a.email as admin_email
                    FROM admin_activity_log aal
                    LEFT JOIN admins a ON aal.admin_id = a.id
                    WHERE 1=1";
            
            $params = [];
            
            if (!empty($filters['date_from'])) {
                $sql .= " AND aal.created_at >= ?";
                $params[] = $filters['date_from'];
            }
            
            if (!empty($filters['date_to'])) {
                $sql .= " AND aal.created_at <= ?";
                $params[] = $filters['date_to'];
            }
            
            if (!empty($filters['table'])) {
                $sql .= " AND aal.target_type = ?";
                $params[] = $filters['table'];
            }
            
            if (!empty($filters['admin'])) {
                $sql .= " AND aal.admin_id = ?";
                $params[] = $filters['admin'];
            }
            
            if (!empty($filters['action'])) {
                $sql .= " AND aal.activity_type LIKE ?";
                $params[] = "%{$filters['action']}%";
            }
            
            $sql .= " ORDER BY aal.created_at DESC LIMIT ?";
            $params[] = $limit;
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
            
        } catch (Exception $e) {
            error_log("Get recent activities error: " . $e->getMessage());
            return [];
        }
    }
    
    /**
     * Add missing audit columns to a table
     */
    public static function addAuditColumnsToTable($table_name) {
        global $pdo;
        
        try {
            $status = self::checkTableAuditColumns($table_name);
            
            if ($status['has_all_columns']) {
                return ['success' => true, 'message' => "Table $table_name already has all audit columns"];
            }
            
            $pdo->beginTransaction();
            
            foreach ($status['missing_columns'] as $column) {
                switch ($column) {
                    case 'created_by':
                        $sql = "ALTER TABLE `$table_name` ADD COLUMN `created_by` INT(11) NULL AFTER `id`";
                        break;
                    case 'created_at':
                        $sql = "ALTER TABLE `$table_name` ADD COLUMN `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP AFTER `created_by`";
                        break;
                    case 'modified_by':
                        $sql = "ALTER TABLE `$table_name` ADD COLUMN `modified_by` INT(11) NULL";
                        break;
                    case 'modified_at':
                        $sql = "ALTER TABLE `$table_name` ADD COLUMN `modified_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP";
                        break;
                }
                
                $pdo->exec($sql);
                error_log("Added audit column '$column' to table '$table_name'");
            }
            
            $pdo->commit();
            return ['success' => true, 'message' => "Successfully added audit columns to $table_name"];
            
        } catch (Exception $e) {
            $pdo->rollBack();
            error_log("Failed to add audit columns to $table_name: " . $e->getMessage());
            return ['success' => false, 'message' => "Failed to add audit columns: " . $e->getMessage()];
        }
    }
    
    /**
     * Fix all auditable tables by adding missing columns
     */
    public static function fixAllAuditableTables() {
        $results = [];
        $auditable_tables = self::getAuditableTables();
        
        foreach ($auditable_tables as $table) {
            $results[$table] = self::addAuditColumnsToTable($table);
        }
        
        return $results;
    }

    /**
     * Export audit trail data
     */
    public static function exportAuditData($filters = []) {
        global $pdo;
        
        try {
            $sql = "SELECT 
                        aal.created_at,
                        a.name as admin_name,
                        aal.activity_type,
                        aal.target_type,
                        aal.target_id,
                        aal.activity_description,
                        aal.ip_address
                    FROM admin_activity_log aal
                    LEFT JOIN admins a ON aal.admin_id = a.id
                    WHERE 1=1";
            
            $params = [];
            
            if (!empty($filters['date_from'])) {
                $sql .= " AND aal.created_at >= ?";
                $params[] = $filters['date_from'];
            }
            
            if (!empty($filters['date_to'])) {
                $sql .= " AND aal.created_at <= ?";
                $params[] = $filters['date_to'];
            }
            
            $sql .= " ORDER BY aal.created_at DESC";
            
            $stmt = $pdo->prepare($sql);
            $stmt->execute($params);
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
            
        } catch (Exception $e) {
            error_log("Export audit data error: " . $e->getMessage());
            return [];
        }
    }
}

/**
 * Log audit trail entry using the admin_activity_log table
 */
function log_audit_trail($admin_id, $action, $table_name, $record_id, $old_values = null, $new_values = null, $ip_address = null) {
    return AuditTrail::logActivity(
        $admin_id,
        $action,
        $table_name,
        $record_id,
        $action . " on " . $table_name . " (ID: " . $record_id . ")",
        [
            'old_values' => $old_values,
            'new_values' => $new_values
        ]
    );
}

/**
 * Simplified audit verification using admin_activity_log
 */
function verify_audit_trail() {
    global $pdo;

    try {
        // Check if admin_activity_log table exists
        $stmt = $pdo->query("SHOW TABLES LIKE 'admin_activity_log'");
        $table_exists = $stmt->rowCount() > 0;

        if (!$table_exists) {
            error_log("AUDIT TRAIL VERIFICATION: Table 'admin_activity_log' does not exist!");
            return false;
        }

        // Test insertion
        $test_result = AuditTrail::logActivity(
            1, 
            'TEST', 
            'test_table', 
            999, 
            'Test audit entry',
            ['test' => 'verification']
        );

        if ($test_result) {
            error_log("AUDIT TRAIL VERIFICATION: Test entry successful");
            return true;
        } else {
            error_log("AUDIT TRAIL VERIFICATION: Test entry failed");
            return false;
        }

    } catch (Exception $e) {
        error_log("AUDIT TRAIL VERIFICATION ERROR: " . $e->getMessage());
        return false;
    }
}