<?php
require_once '../config.php';
require_once '../includes/functions.php';
require_once '../includes/EncryptionManager.php';
require_once '../includes/commentFilter.php';

header('Content-Type: application/json');

// Only allow POST
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Method not allowed']);
    exit;
}

// Rate limiting: 5 attempts per 5 minutes
if (!enhanced_rate_limit('feedback', 5, 300)) {
    http_response_code(429);
    echo json_encode(['success' => false, 'message' => 'Too many feedback attempts. Please try again later.']);
    exit;
}

// Parse request body
$input = json_decode(file_get_contents('php://input'), true) ?: $_POST;

// Required inputs
$project_id = (int)($input['project_id'] ?? 0);
$citizen_name = trim($input['citizen_name'] ?? '');
$citizen_email = trim($input['citizen_email'] ?? '');
$subject = trim($input['subject'] ?? '');
$message = trim($input['message'] ?? '');
$parent_comment_id = (int)($input['parent_comment_id'] ?? 0);

// Validate inputs
if (!$project_id || !$citizen_name || !$message) {
    echo json_encode(['success' => false, 'message' => 'Project ID, name, and message are required']);
    exit;
}

if (!empty($citizen_email) && !filter_var($citizen_email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(['success' => false, 'message' => 'Please enter a valid email address']);
    exit;
}

// Verify project exists
$project = get_project_by_id($project_id);
if (!$project) {
    echo json_encode(['success' => false, 'message' => 'Project not found']);
    exit;
}

try {
    $user_ip = $_SERVER['REMOTE_ADDR'] ?? $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '127.0.0.1';
    $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';

    // Filter subject
    $feedback_subject = $parent_comment_id > 0 ? "Reply to comment" : ($subject ?: "Project Feedback");

    // Duplicate comment check within 30 seconds
    $duplicate_check = $pdo->prepare("
        SELECT COUNT(*) FROM feedback 
        WHERE project_id = ? AND citizen_name = ? AND message = ? 
        AND created_at > DATE_SUB(NOW(), INTERVAL 30 SECOND)
    ");
    $duplicate_check->execute([$project_id, $citizen_name, $message]);
    if ($duplicate_check->fetchColumn() > 0) {
        echo json_encode(['success' => false, 'message' => 'Duplicate comment detected. Please wait before submitting again.']);
        exit;
    }

    // Filter comment
    $filter_result = ['status' => 'pending', 'message' => 'Submitted for review'];
    try {
        if (class_exists('CommentFilter')) {
            $commentFilter = new CommentFilter();
            $filter_result = $commentFilter->filterComment($message);
        } elseif (function_exists('filter_comment')) {
            $filter_result = filter_comment($message, $citizen_name);
        }
        if ($filter_result['status'] === 'rejected') {
            echo json_encode(['success' => false, 'message' => $filter_result['message']]);
            exit;
        }
    } catch (Exception $e) {
        error_log("Comment filtering failed: " . $e->getMessage());
    }

    // Final status mapping
    $db_status = match ($filter_result['status']) {
        'approved' => 'approved',
        'pending_review' => 'pending',
        'rejected' => 'rejected',
        default => 'pending'
    };
    $filtering_metadata = isset($filter_result['details']) ? json_encode($filter_result['details']) : null;

    // Prepare row
    $feedback_data = [
        'project_id' => $project_id,
        'citizen_name' => $citizen_name,
        'citizen_email' => !empty($citizen_email) ? $citizen_email : null,
        'subject' => $feedback_subject,
        'message' => $message,
        'status' => $db_status,
        'parent_comment_id' => $parent_comment_id ?: null,
        'user_ip' => $user_ip,
        'user_agent' => $user_agent,
        'filtering_metadata' => $filtering_metadata,
        'created_at' => date('Y-m-d H:i:s')
    ];

    // Encrypt based on system settings
    EncryptionManager::init($pdo);
    $prepared_data = EncryptionManager::processDataForStorage($feedback_data, 'feedback');

    // Insert feedback
    $columns = implode(', ', array_keys($prepared_data));
    $placeholders = implode(', ', array_fill(0, count($prepared_data), '?'));
    $values = array_values($prepared_data);

    $stmt = $pdo->prepare("INSERT INTO feedback ($columns) VALUES ($placeholders)");
    $stmt->execute($values);
    $comment_id = $pdo->lastInsertId();

    // Log activity
    $action_type = $parent_comment_id > 0 ? 'comment_reply' : 'feedback_submission';
    log_activity(
        $action_type,
        "Comment filtered with status: {$filter_result['status']} for project ID: $project_id",
        null,
        'comment',
        $comment_id,
        $filter_result['details'] ?? []
    );

    // Send notification to subscribers
    if ($parent_comment_id == 0 && $db_status === 'approved') {
        notify_project_subscribers($project_id, 'project_update', "New feedback received from $citizen_name");
    }

    echo json_encode([
        'success' => true,
        'message' => $db_status === 'approved'
            ? ($parent_comment_id > 0 ? 'Reply posted successfully!' : 'Comment posted successfully!')
            : $filter_result['message']
    ]);

} catch (Exception $e) {
    error_log("Feedback API error: " . $e->getMessage());
    echo json_encode(['success' => false, 'message' => 'Service temporarily unavailable. Please try again later.']);
}
?>
