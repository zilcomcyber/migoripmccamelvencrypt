<?php
require_once '../config.php';
require_once '../includes/functions.php';
require_once '../includes/EncryptionManager.php';

header('Content-Type: application/json');

// Initialize encryption manager based on system settings
EncryptionManager::init($pdo);

try {
    if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
        json_response(['success' => false, 'message' => 'Method not allowed'], 405);
    }

    $project_id = intval($_GET['project_id'] ?? 0);
    $offset = intval($_GET['offset'] ?? 0);
    $limit = intval($_GET['limit'] ?? 20);

    if (!$project_id) {
        json_response(['success' => false, 'message' => 'Project ID required'], 400);
    }

    $user_ip = $_SERVER['REMOTE_ADDR'] ?? $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '127.0.0.1';
    $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';

    $sql = "SELECT f.*, 
                   a.name as admin_name,
                   CASE WHEN f.user_ip = ? AND f.user_agent = ? AND f.status = 'pending' THEN 1 ELSE 0 END as is_user_pending,
                   CASE WHEN f.comment_type = 'admin_response' OR f.admin_id IS NOT NULL THEN 1 ELSE 0 END as is_admin_comment
            FROM feedback f
            LEFT JOIN admins a ON f.admin_id = a.id
            WHERE f.project_id = ?
            AND (f.parent_comment_id IS NULL OR f.parent_comment_id = 0)
            AND f.comment_type IN ('user_comment', 'user_reply')
            AND (
                f.status IN ('approved', 'reviewed', 'responded')
                OR (f.status = 'pending' AND f.user_ip = ? AND f.user_agent = ?)
            )
            ORDER BY f.created_at DESC
            LIMIT ? OFFSET ?";

    $stmt = $pdo->prepare($sql);
    $stmt->execute([$user_ip, $user_agent, $project_id, $user_ip, $user_agent, $limit, $offset]);
    $comments = $stmt->fetchAll();

    // ✅ Correct parameter order
    $decrypted = EncryptionManager::processDataForReading('feedback', $comments);

    $formatted_comments = [];
    foreach ($decrypted as $comment) {
        $replies_count_sql = "SELECT COUNT(*) 
                              FROM feedback f
                              WHERE f.parent_comment_id = ?
                              AND (
                                  f.status IN ('approved', 'reviewed', 'responded')
                                  OR (f.status = 'pending' AND f.user_ip = ? AND f.user_agent = ?)
                                  OR f.comment_type = 'admin_response'
                              )";
        $replies_count_stmt = $pdo->prepare($replies_count_sql);
        $replies_count_stmt->execute([$comment['id'], $user_ip, $user_agent]);
        $total_replies = $replies_count_stmt->fetchColumn();

        $replies_sql = "SELECT f.*, 
                               a.name as admin_name, a.email as admin_email,
                               CASE WHEN f.user_ip = ? AND f.user_agent = ? AND f.status = 'pending' THEN 1 ELSE 0 END as is_user_pending,
                               CASE WHEN f.comment_type = 'admin_response' OR f.admin_id IS NOT NULL THEN 1 ELSE 0 END as is_admin_comment
                        FROM feedback f
                        LEFT JOIN admins a ON f.admin_id = a.id
                        WHERE f.parent_comment_id = ?
                        AND (
                            f.status IN ('approved', 'reviewed', 'responded')
                            OR (f.status = 'pending' AND f.user_ip = ? AND f.user_agent = ?)
                            OR f.comment_type = 'admin_response'
                        )
                        ORDER BY f.created_at ASC
                        LIMIT 4";

        $replies_stmt = $pdo->prepare($replies_sql);
        $replies_stmt->execute([$user_ip, $user_agent, $comment['id'], $user_ip, $user_agent]);
        $replies = $replies_stmt->fetchAll();

        // ✅ Correct parameter order
        $decrypted_replies = EncryptionManager::processDataForReading('feedback', $replies);

        $comment_is_admin = isset($comment['is_admin_comment']) ? 
            $comment['is_admin_comment'] : 
            (strpos($comment['id'], 'admin_') === 0 || $comment['subject'] === 'Admin Response' || empty($comment['citizen_name']));

        $comment_display_name = $comment_is_admin ? 
            ($comment['admin_name'] ?? 'Admin') : 
            $comment['citizen_name'];

        $comment_is_user_pending = isset($comment['is_user_pending']) ? $comment['is_user_pending'] : false;

        $formatted_replies = [];
        foreach ($decrypted_replies as $reply) {
            $reply_is_admin = isset($reply['is_admin_comment']) ? 
                $reply['is_admin_comment'] : 
                (($reply['comment_type'] === 'admin_response') || !empty($reply['admin_id']));

            $reply_display_name = $reply_is_admin ? 
                ($reply['admin_name'] ?? 'Admin') : 
                $reply['citizen_name'];

            $reply_is_user_pending = isset($reply['is_user_pending']) ? $reply['is_user_pending'] : false;

            $formatted_replies[] = [
                'id' => $reply['id'],
                'message' => $reply['message'],
                'created_at' => $reply['created_at'],
                'display_name' => $reply_display_name,
                'citizen_name' => $reply['citizen_name'],
                'admin_name' => $reply['admin_name'],
                'is_admin' => $reply_is_admin,
                'is_user_pending' => $reply_is_user_pending,
                'time_ago' => time_ago($reply['created_at'])
            ];
        }

        $formatted_comments[] = [
            'id' => $comment['id'],
            'message' => $comment['message'],
            'created_at' => $comment['created_at'],
            'display_name' => $comment_display_name,
            'citizen_name' => $comment['citizen_name'],
            'admin_name' => $comment['admin_name'],
            'is_admin' => $comment_is_admin,
            'is_user_pending' => $comment_is_user_pending,
            'time_ago' => time_ago($comment['created_at']),
            'total_replies' => $total_replies,
            'shown_replies' => count($formatted_replies),
            'replies' => $formatted_replies
        ];
    }

    $count_sql = "SELECT COUNT(*) 
                  FROM feedback f
                  WHERE f.project_id = ?
                  AND (f.parent_comment_id IS NULL OR f.parent_comment_id = 0)
                  AND f.comment_type IN ('user_comment', 'user_reply')
                  AND f.status IN ('approved', 'reviewed', 'responded')";
    $count_stmt = $pdo->prepare($count_sql);
    $count_stmt->execute([$project_id]);
    $total_count = $count_stmt->fetchColumn();
    $remaining = max(0, $total_count - ($offset + $limit));

    json_response([
        'success' => true,
        'comments' => $formatted_comments,
        'remaining' => $remaining,
        'has_more' => $remaining > 0
    ]);

} catch (Exception $e) {
    error_log("Load comments error: " . $e->getMessage());
    json_response(['success' => false, 'message' => 'Failed to load comments'], 500);
}

function time_ago($datetime) {
    $time = time() - strtotime($datetime);
    if ($time < 60) return 'just now';
    if ($time < 3600) return floor($time / 60) . ' minutes ago';
    if ($time < 86400) return floor($time / 3600) . ' hours ago';
    if ($time < 2592000) return floor($time / 86400) . ' days ago';
    if ($time < 31536000) return floor($time / 2592000) . ' months ago';
    return floor($time / 31536000) . ' years ago';
}