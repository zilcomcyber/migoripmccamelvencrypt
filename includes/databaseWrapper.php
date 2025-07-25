<?php
/**
 * Database Wrapper for automatic encryption/decryption
 */

require_once __DIR__ . '/EncryptionManager.php';

class DatabaseWrapper {
    private $pdo;
    
    public function __construct($pdo) {
        $this->pdo = $pdo;
    }
    
    /**
     * Insert with automatic encryption
     */
    public function insert($table, $data) {
        $processedData = EncryptionManager::processDataForStorage($table, $data);
        
        $columns = implode(', ', array_keys($processedData));
        $placeholders = ':' . implode(', :', array_keys($processedData));
        
        $sql = "INSERT INTO $table ($columns) VALUES ($placeholders)";
        $stmt = $this->pdo->prepare($sql);
        
        return $stmt->execute($processedData);
    }
    
    /**
     * Update with automatic encryption
     */
    public function update($table, $data, $where) {
        $processedData = EncryptionManager::processDataForStorage($table, $data);
        
        $setParts = array();
        foreach (array_keys($processedData) as $key) {
            $setParts[] = "$key = :$key";
        }
        $setClause = implode(', ', $setParts);
        
        $whereParts = array();
        foreach (array_keys($where) as $key) {
            $whereParts[] = "$key = :where_$key";
        }
        $whereClause = implode(' AND ', $whereParts);
        
        $sql = "UPDATE $table SET $setClause WHERE $whereClause";
        $stmt = $this->pdo->prepare($sql);
        
        // Combine data and where parameters
        $params = $processedData;
        foreach ($where as $key => $value) {
            $params["where_$key"] = $value;
        }
        
        return $stmt->execute($params);
    }
    
    /**
     * Select with automatic decryption
     */
    public function select($table, $where = array(), $columns = '*') {
        $whereClause = '';
        if (!empty($where)) {
            $whereParts = array();
            foreach (array_keys($where) as $key) {
                $whereParts[] = "$key = :$key";
            }
            $whereClause = 'WHERE ' . implode(' AND ', $whereParts);
        }
        
        $sql = "SELECT $columns FROM $table $whereClause";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($where);
        
        $results = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        // Process results for reading
        return array_map(function($row) use ($table) {
            return EncryptionManager::processDataForReading($table, $row);
        }, $results);
    }
    
    /**
     * Select single row with automatic decryption
     */
    public function selectOne($table, $where = array(), $columns = '*') {
        $results = $this->select($table, $where, $columns);
        return !empty($results) ? $results[0] : null;
    }
    
    /**
     * Raw query with manual encryption handling
     */
    public function query($sql, $params = array()) {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }
    
    /**
     * Get PDO instance for complex queries
     */
    public function getPDO() {
        return $this->pdo;
    }
    
    /**
     * Begin a transaction
     */
    public function beginTransaction() {
        return $this->pdo->beginTransaction();
    }
    
    /**
     * Commit a transaction
     */
    public function commit() {
        return $this->pdo->commit();
    }
    
    /**
     * Roll back a transaction
     */
    public function rollBack() {
        return $this->pdo->rollBack();
    }
    
    /**
     * Insert multiple rows at once
     */
    public function insertBatch($table, array $rows) {
        if (empty($rows)) return 0;
        
        // Process all rows for encryption
        $processedData = array();
        foreach ($rows as $row) {
            $processedData[] = EncryptionManager::processDataForStorage($table, $row);
        }
        
        $columns = implode(', ', array_keys($processedData[0]));
        $placeholders = '(' . implode(', ', array_fill(0, count($processedData[0]), '?')) . ')';
        $values = implode(', ', array_fill(0, count($rows), $placeholders));
        
        $sql = "INSERT INTO $table ($columns) VALUES $values";
        $stmt = $this->pdo->prepare($sql);
        
        // Flatten the array of parameters
        $flattenedValues = array();
        foreach ($processedData as $row) {
            $flattenedValues = array_merge($flattenedValues, array_values($row));
        }
        
        return $stmt->execute($flattenedValues);
    }
}

?>