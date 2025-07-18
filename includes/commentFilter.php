<?php
/**
 * Global wrapper function for backward compatibility
 */
if (!function_exists('filter_comment')) {
    function filter_comment($message, $citizen_name) {
        try {
            if (class_exists('CommentFilter')) {
                $filter = new CommentFilter();
                return $filter->filterComment($message);
            }
        } catch (Exception $e) {
            error_log("Filter comment error: " . $e->getMessage());
        }
        
        return ['status' => 'pending', 'message' => 'Submitted for review'];
    }
}
/**
 * Advanced Comment Filtering System
 * Handles language detection, banned words, and flagged words filtering
 */

class CommentFilter {
    private $banned_words = [];
    private $flagged_words = [];
    private $libre_translate_url = 'https://libretranslate.de/detect';

    public function __construct() {
        $this->loadWordLists();
    }

    /**
     * Load banned and flagged words from JSON file
     */
    private function loadWordLists() {
        $json_file = __DIR__ . '/../banned_and_flagged_words.json';

        if (file_exists($json_file)) {
            $word_data = json_decode(file_get_contents($json_file), true);
            $this->banned_words = array_map('strtolower', $word_data['banned_words'] ?? []);
            $this->flagged_words = array_map('strtolower', $word_data['flagged_words'] ?? []);
        } else {
            error_log("Word list file not found: $json_file");
        }
    }

    /**
     * Detect language using simple PHP detection (no external API)
     */
    private function detectLanguage($text) {
        // Use only basic detection since LibreTranslate API is unreliable
        return $this->basicLanguageDetection($text);
    }

    /**
     * Basic language detection as fallback
     */
    private function basicLanguageDetection($text) {
        $text = strtolower(trim($text));

        // Common Swahili words/patterns
        $swahili_indicators = [
            'habari', 'asante', 'karibu', 'hujambo', 'pole', 'sawa', 'ndiyo', 'hapana',
            'kitu', 'mtu', 'watu', 'nyumba', 'shule', 'kazi', 'pesa', 'chakula',
            'maji', 'jina', 'hali', 'mahali', 'wakati', 'siku', 'wiki', 'mwezi',
            'mwaka', 'leo', 'jana', 'kesho', 'asubuhi', 'mchana', 'jioni', 'usiku',
            'ninyi', 'wewe', 'yeye', 'sisi', 'mimi', 'wao', 'hii', 'hiyo', 'hizi',
            'na', 'ya', 'wa', 'za', 'la', 'cha', 'kwa', 'katika', 'kwenye', 'ni',
            'au', 'lakini', 'pia', 'tu', 'ndio', 'bado', 'sana', 'kwanza', 'baada',
            'kabla', 'hata', 'ikiwa', 'endapo', 'jambo', 'mambo', 'vizuri'
        ];

        // Common English words
        $english_indicators = [
            'the', 'and', 'is', 'are', 'was', 'were', 'have', 'has', 'had',
            'will', 'would', 'could', 'should', 'can', 'may', 'must', 'shall',
            'this', 'that', 'these', 'those', 'with', 'from', 'they', 'them',
            'their', 'there', 'where', 'when', 'what', 'why', 'how', 'who',
            'but', 'or', 'not', 'yes', 'no', 'good', 'bad', 'very', 'also',
            'just', 'only', 'like', 'well', 'now', 'get', 'make', 'do', 'go'
        ];

        // Count word boundaries to avoid false positives
        $swahili_count = 0;
        $english_count = 0;

        foreach ($swahili_indicators as $indicator) {
            if (preg_match('/\b' . preg_quote($indicator, '/') . '\b/', $text)) {
                $swahili_count++;
            }
        }

        foreach ($english_indicators as $indicator) {
            if (preg_match('/\b' . preg_quote($indicator, '/') . '\b/', $text)) {
                $english_count++;
            }
        }

        error_log("Language detection: Swahili indicators: $swahili_count, English indicators: $english_count");

        // If very short text (less than 10 words), be more permissive
        $word_count = str_word_count($text);
        if ($word_count < 10) {
            // For short texts, if any English or Swahili words found, consider it that language
            if ($swahili_count > 0 && $swahili_count >= $english_count) {
                return 'sw';
            }
            if ($english_count > 0) {
                return 'en';
            }
            // For very short texts without clear indicators, default to English to be safe
            return 'en';
        }

        // For longer texts, require stronger evidence
        if ($swahili_count >= 2 && $swahili_count > $english_count) {
            return 'sw';
        }

        if ($english_count >= 2) {
            return 'en';
        }

        // If both have equal indicators or neither has strong indicators
        if ($swahili_count > 0 || $english_count > 0) {
            // If we found some indicators but not decisive, lean towards English
            return 'en';
        }

        // If no clear indicators, flag as uncertain
        return 'unknown';
    }

    /**
     * Check if text contains banned words
     */
    private function containsBannedWords($text) {
        $text = strtolower($text);
        $found_words = [];

        foreach ($this->banned_words as $banned_word) {
            // Use word boundaries to avoid false positives
            if (preg_match('/\b' . preg_quote($banned_word, '/') . '\b/i', $text)) {
                $found_words[] = $banned_word;
            }
        }

        return !empty($found_words) ? $found_words : false;
    }

    /**
     * Check if text contains flagged words
     */
    private function containsFlaggedWords($text) {
        $text = strtolower($text);
        $found_words = [];

        foreach ($this->flagged_words as $flagged_word) {
            // Use word boundaries to avoid false positives
            if (preg_match('/\b' . preg_quote($flagged_word, '/') . '\b/i', $text)) {
                $found_words[] = $flagged_word;
            }
        }

        return !empty($found_words) ? $found_words : false;
    }

    /**
     * Validate comment length and word count
     */
    private function validateCommentLength($text) {
        $words = str_word_count($text);

        if ($words < 3) {
            return [
                'valid' => false,
                'message' => 'Comment must contain at least 3 words.'
            ];
        }

        if ($words > 100) {
            return [
                'valid' => false,
                'message' => 'Comment cannot exceed 100 words. Current word count: ' . $words
            ];
        }

        return ['valid' => true];
    }

    /**
     * Main filtering function
     */
    public function filterComment($comment_text) {
        $result = [
            'status' => '',
            'message' => '',
            'details' => []
        ];

        // 1. Validate comment length and word count
        $length_validation = $this->validateCommentLength($comment_text);
        if (!$length_validation['valid']) {
            $result['status'] = 'rejected';
            $result['message'] = $length_validation['message'];
            $result['details']['reason'] = 'invalid_length';
            return $result;
        }

        // 2. Check for banned words first (highest priority)
        $banned_words_found = $this->containsBannedWords($comment_text);
        if ($banned_words_found) {
            $result['status'] = 'rejected';
            $result['message'] = 'Your comment contains inappropriate language and cannot be posted. Please revise your comment and try again.';
            $result['details']['reason'] = 'banned_words';
            $result['details']['banned_words_found'] = $banned_words_found;
            return $result;
        }

        // 3. Check for flagged words
        $flagged_words_found = $this->containsFlaggedWords($comment_text);
        if ($flagged_words_found) {
            $result['status'] = 'pending_review';
            $result['message'] = 'Your comment has been submitted for review due to potentially sensitive content. It will be published after approval by our moderation team.';
            $result['details']['reason'] = 'flagged_words';
            $result['details']['flagged_words_found'] = $flagged_words_found;
            return $result;
        }

        // 4. Language Detection
        $detected_language = $this->detectLanguage($comment_text);
        $result['details']['detected_language'] = $detected_language;

        error_log("Final language detection result: $detected_language for text: " . substr($comment_text, 0, 100));

        // Only allow English (en) and Swahili (sw)
        if (!in_array($detected_language, ['en', 'sw'])) {
            // If language is not English or Swahili, send for review
            $result['status'] = 'pending_review';
            $result['message'] = 'Your comment has been submitted for review to verify it meets our language requirements (English or Kiswahili only).';
            $result['details']['reason'] = 'language_review';
            error_log("Comment flagged for language review: $detected_language");
            return $result;
        }

        // 5. Comment is clean - auto-approve
        $result['status'] = 'approved';
        $result['message'] = 'Your comment has been posted successfully!';
        $result['details']['reason'] = 'clean_content';
        error_log("Comment auto-approved as clean content");

        return $result;
    }

    /**
     * Get filtering statistics
     */
    public function getFilteringStats() {
        return [
            'banned_words_count' => count($this->banned_words),
            'flagged_words_count' => count($this->flagged_words),
            'supported_languages' => ['en', 'sw']
        ];
    }
}

/**
 * Save comment with proper status
 */
function save_comment_with_filtering($project_id, $comment_text, $user_name, $user_email = null, $parent_id = 0, $filter_result = null) {
    global $pdo;

    try {
        $user_ip = $_SERVER['REMOTE_ADDR'] ?? $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '127.0.0.1';
        $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? '';
        $subject = $parent_id > 0 ? "Reply to comment" : "Project Comment";

        // Determine status based on filtering result
        $status = $filter_result ? $filter_result['status'] : 'pending';

        // Map filtering statuses to database statuses
        $db_status = match($status) {
            'approved' => 'approved',
            'pending_review' => 'pending',
            'rejected' => 'rejected',
            default => 'pending'
        };

        // Add filtering metadata
        $filtering_metadata = $filter_result ? json_encode($filter_result['details']) : null;

        $sql = "INSERT INTO feedback 
                (project_id, citizen_name, citizen_email, subject, message, status, 
                 parent_comment_id, user_ip, user_agent, filtering_metadata, created_at) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        $stmt = $pdo->prepare($sql);
        $result = $stmt->execute([
            $project_id, $user_name, $user_email, $subject, $comment_text, 
            $db_status, $parent_id, $user_ip, $user_agent, $filtering_metadata
        ]);

        if ($result) {
            $comment_id = $pdo->lastInsertId();

            // Log the filtering action
            log_activity(
                'comment_filtered', 
                "Comment filtered with status: $status for project ID: $project_id", 
                null, 
                'comment', 
                $comment_id,
                $filter_result['details'] ?? []
            );

            return [
                'success' => true, 
                'comment_id' => $comment_id,
                'status' => $status,
                'message' => $filter_result['message'] ?? 'Comment saved successfully'
            ];
        }

        return ['success' => false, 'message' => 'Failed to save comment'];

    } catch (Exception $e) {
        error_log("Save filtered comment error: " . $e->getMessage());
        return ['success' => false, 'message' => 'Database error occurred'];
    }
}
?>