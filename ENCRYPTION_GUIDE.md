
# Database Encryption Implementation Guide

## Overview
Your encryption system is now set up to automatically encrypt sensitive data when inserting/updating and decrypt when fetching from the database.

## How to Use

### 1. For New Code (Recommended)
Use the new PDO helper functions that automatically handle encryption:

```php
// Insert with automatic encryption
pdo_insert($pdo, 'admins', [
    'name' => 'John Doe',
    'email' => 'john@example.com',
    'password' => password_hash('password', PASSWORD_DEFAULT)
]);

// Select with automatic decryption
$admins = pdo_select($pdo, "SELECT * FROM admins", [], 'admins');

// Select one record with decryption
$admin = pdo_select_one($pdo, "SELECT * FROM admins WHERE id = ?", [1], 'admins');

// Update with automatic encryption
pdo_update($pdo, 'admins', ['email' => 'newemail@example.com'], ['id' => 1]);
```

### 2. For Existing Code
Update your existing SQL queries to use the new functions:

**Before:**
```php
$stmt = $pdo->prepare("SELECT * FROM admins WHERE id = ?");
$stmt->execute([1]);
$admin = $stmt->fetch();
```

**After:**
```php
$admin = pdo_select_one($pdo, "SELECT * FROM admins WHERE id = ?", [1], 'admins');
```

### 3. Supported Tables and Fields
The system automatically encrypts these sensitive fields:

- **admins**: name, email, last_ip
- **admin_activity_log**: ip_address, user_agent
- **security_logs**: ip_address, user_agent
- **project_subscriptions**: email, ip_address, user_agent
- **feedback**: citizen_email, user_ip, user_agent

### 4. Migration
Use the admin panel to encrypt existing data:
1. Go to `/admin/dataEncryption.php`
2. Click "Encrypt Data" to encrypt all existing sensitive data
3. Check the status to verify encryption

## Examples for Common Operations

### Feedback Submission
```php
// In api/feedback.php
pdo_insert($pdo, 'feedback', [
    'project_id' => $project_id,
    'citizen_name' => $citizen_name,
    'citizen_email' => $citizen_email,
    'message' => $message,
    'status' => $status
]);
```

### Admin Login Logging
```php
// Log admin activity
pdo_insert($pdo, 'admin_activity_log', [
    'admin_id' => $admin_id,
    'action' => 'login',
    'ip_address' => $_SERVER['REMOTE_ADDR'],
    'user_agent' => $_SERVER['HTTP_USER_AGENT']
]);
```

### Get Feedback for Display
```php
// Get feedback with automatic decryption
$feedback = pdo_select($pdo, 
    "SELECT * FROM feedback WHERE project_id = ? ORDER BY created_at DESC", 
    [$project_id], 
    'feedback'
);
```

## Security Notes
1. Encryption key is stored in config.php for now
2. Later, move to environment variables using Replit Secrets
3. All sensitive data is encrypted using AES-256-GCM
4. Non-sensitive fields (like IDs, timestamps) remain unencrypted for database efficiency

## Next Steps on Localhost
1. Test the new functions with some sample data
2. Update your existing PHP files to use the new PDO functions
3. Run the encryption migration from the admin panel
4. Verify that data is being encrypted/decrypted properly
