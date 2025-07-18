
<?php
require_once '../config.php';
require_once '../includes/encryption.php';
require_once '../includes/dataInterceptor.php';
require_once '../includes/encryptionHelper.php';
require_once '../includes/pdoHelpers.php';

header('Content-Type: application/json');

try {
    // Test database connection
    $test_results = [
        'database_connection' => false,
        'encryption_status' => [],
        'sample_data' => [],
        'errors' => []
    ];
    
    // Test connection
    if ($pdo) {
        $test_results['database_connection'] = true;
        
        // Test subscription functionality
        try {
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM project_subscriptions");
            $stmt->execute();
            $subscription_count = $stmt->fetchColumn();
            $test_results['subscription_count'] = $subscription_count;
        } catch (Exception $e) {
            $test_results['errors'][] = "Subscription test: " . $e->getMessage();
        }
        
        // Test feedback functionality
        try {
            $stmt = $pdo->prepare("SELECT COUNT(*) FROM feedback");
            $stmt->execute();
            $feedback_count = $stmt->fetchColumn();
            $test_results['feedback_count'] = $feedback_count;
        } catch (Exception $e) {
            $test_results['errors'][] = "Feedback test: " . $e->getMessage();
        }
        
        // Test encryption functions
        try {
            $test_email = "test@example.com";
            $encrypted = DataEncryption::encrypt($test_email);
            $decrypted = DataEncryption::decrypt($encrypted);
            $test_results['encryption_test'] = [
                'original' => $test_email,
                'encrypted' => substr($encrypted, 0, 20) . '...',
                'decrypted' => $decrypted,
                'match' => ($test_email === $decrypted)
            ];
        } catch (Exception $e) {
            $test_results['errors'][] = "Encryption test: " . $e->getMessage();
        }
    }
    
    echo json_encode($test_results, JSON_PRETTY_PRINT);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>
