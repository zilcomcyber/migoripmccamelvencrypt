CREATE TABLE IF NOT EXISTS `account_activation_tokens` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(128) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('super_admin','admin') DEFAULT 'admin',
  `is_active` tinyint(1) DEFAULT 1,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `last_ip` varchar(45) DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `two_factor_secret` varchar(255) DEFAULT NULL,
  `last_password_change` datetime DEFAULT NULL,
  `password_reset_token` varchar(255) DEFAULT NULL,
  `token_expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `admin_activity_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `activity_description` text NOT NULL,
  `target_type` varchar(50) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `admin_permissions` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `permission_key` varchar(100) NOT NULL,
  `granted_by` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `budget_allocations` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `budget_id` int(11) NOT NULL,
  `allocation_type` enum('initial','supplementary','reallocation') DEFAULT 'initial',
  `allocated_amount` decimal(15,2) NOT NULL,
  `fund_source` varchar(255) NOT NULL,
  `funding_category` enum('development','recurrent','emergency','donor') DEFAULT 'development',
  `allocation_date` date NOT NULL,
  `financial_year` varchar(20) NOT NULL,
  `budget_line_item` varchar(255) DEFAULT NULL,
  `allocation_reference` varchar(100) DEFAULT NULL,
  `conditions` text DEFAULT NULL,
  `status` enum('pending','approved','active','exhausted','cancelled') DEFAULT 'pending',
  `allocated_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `cbs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `chart_of_accounts` (
  `id` int(11) NOT NULL,
  `account_code` varchar(50) NOT NULL,
  `account_name` varchar(255) NOT NULL,
  `account_type` enum('asset','liability','equity','income','expense') NOT NULL,
  `account_subtype` varchar(100) DEFAULT NULL,
  `parent_account_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `cost_breakdown_structure` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `wbs_id` int(11) DEFAULT NULL,
  `cbs_code` varchar(50) NOT NULL,
  `parent_cbs_id` int(11) DEFAULT NULL,
  `cost_category` varchar(255) NOT NULL,
  `cost_subcategory` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `budget_allocation` decimal(15,2) NOT NULL DEFAULT 0.00,
  `committed_amount` decimal(15,2) DEFAULT 0.00,
  `actual_expenditure` decimal(15,2) DEFAULT 0.00,
  `remaining_budget` decimal(15,2) GENERATED ALWAYS AS (`budget_allocation` - `committed_amount` - `actual_expenditure`) STORED,
  `budget_utilization_percentage` decimal(5,2) GENERATED ALWAYS AS ((`committed_amount` + `actual_expenditure`) / `budget_allocation` * 100) STORED,
  `cost_type` enum('direct','indirect','overhead','contingency') DEFAULT 'direct',
  `is_controllable` tinyint(1) DEFAULT 1,
  `fiscal_year` varchar(20) DEFAULT NULL,
  `fund_source_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `counties` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `feedback` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `citizen_name` varchar(255) NOT NULL,
  `citizen_email` varchar(255) DEFAULT NULL,
  `citizen_phone` varchar(20) DEFAULT NULL,
  `subject` varchar(500) DEFAULT 'Project Comment',
  `message` text NOT NULL,
  `status` enum('pending','approved','rejected','responded','grievance') DEFAULT 'pending',
  `priority` enum('low','medium','high') DEFAULT 'medium',
  `sentiment` enum('positive','neutral','negative') DEFAULT 'neutral',
  `parent_comment_id` int(11) DEFAULT 0,
  `user_ip` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `filtering_metadata` text DEFAULT NULL,
  `admin_response` text DEFAULT NULL,
  `responded_by` int(11) DEFAULT NULL,
  `responded_at` timestamp NULL DEFAULT NULL,
  `moderated_by` int(11) DEFAULT NULL,
  `moderated_at` timestamp NULL DEFAULT NULL,
  `internal_notes` text DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `engagement_score` int(11) DEFAULT 0,
  `response_time_hours` decimal(10,2) DEFAULT NULL,
  `follow_up_required` tinyint(1) DEFAULT 0,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `visitor_id` varchar(255) DEFAULT NULL,
  `grievance_status` enum('open','resolved') DEFAULT 'open',
  `resolved_by` int(11) DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL,
  `resolved_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `feedback_notifications` (
  `id` int(11) NOT NULL,
  `feedback_id` int(11) NOT NULL,
  `notification_type` enum('response_sent','status_updated','follow_up') NOT NULL,
  `recipient_email` varchar(255) NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivery_status` enum('pending','sent','failed') DEFAULT 'pending',
  `error_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `fund_sources` (
  `id` int(11) NOT NULL,
  `source_name` varchar(255) NOT NULL,
  `source_code` varchar(50) NOT NULL,
  `source_type` enum('government','donor','loan','grant','internally_generated') NOT NULL,
  `description` text DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `contact_details` varchar(255) DEFAULT NULL,
  `terms_conditions` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `import_logs` (
  `id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `total_rows` int(11) NOT NULL,
  `successful_imports` int(11) NOT NULL,
  `failed_imports` int(11) NOT NULL,
  `error_details` text DEFAULT NULL,
  `imported_by` int(11) NOT NULL,
  `imported_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int(11) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `attempts` int(11) NOT NULL,
  `last_attempt` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp(),
  `status` enum('success','fail') NOT NULL DEFAULT 'fail',
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `failure_reason` varchar(191) DEFAULT NULL,
  `session_id` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(128) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `prepared_responses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `category` varchar(100) DEFAULT 'general',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `project_year` int(11) NOT NULL,
  `county_id` int(11) NOT NULL,
  `sub_county_id` int(11) NOT NULL,
  `ward_id` int(11) NOT NULL,
  `location_address` text DEFAULT NULL,
  `location_coordinates` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expected_completion_date` date DEFAULT NULL,
  `actual_completion_date` date DEFAULT NULL,
  `contractor_name` varchar(255) DEFAULT NULL,
  `contractor_contact` varchar(100) DEFAULT NULL,
  `status` enum('planning','ongoing','completed','suspended','cancelled') NOT NULL DEFAULT 'planning',
  `visibility` enum('private','published') DEFAULT 'private',
  `step_status` enum('awaiting','running','completed') DEFAULT 'awaiting',
  `progress_percentage` decimal(5,2) DEFAULT 0.00,
  `total_steps` int(11) DEFAULT 0,
  `completed_steps` int(11) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `average_rating` decimal(3,2) DEFAULT 5.00,
  `total_ratings` int(11) DEFAULT 0,
  `allocated_budget` decimal(15,2) DEFAULT 0.00,
  `spent_budget` decimal(15,2) DEFAULT 0.00,
  `budget_status` enum('not_allocated','allocated','overspent') DEFAULT 'not_allocated',
  `total_budget` decimal(15,2) DEFAULT NULL,
  `last_step_milestone` int(11) DEFAULT 0,
  `last_financial_milestone` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `project_documents` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `document_type` enum('Project Approval Letter','Tender Notice','Signed Contract Agreement','Award Notification','Site Visit Report','Completion Certificate','Tender Opening Minutes','PMC Appointment Letter','Budget Approval Form','PMC Workplan','Supervision Report','Final Joint Inspection Report','Other') NOT NULL DEFAULT 'Other',
  `document_title` varchar(255) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `original_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `document_status` enum('active','edited','deleted') DEFAULT 'active',
  `version_number` int(11) DEFAULT 1,
  `original_document_id` int(11) DEFAULT NULL,
  `edit_reason` text DEFAULT NULL,
  `deletion_reason` text DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT 1,
  `file_size` int(11) DEFAULT 0,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `project_financial_summary` (
`project_id` int(11)
,`project_name` varchar(255)
,`approved_budget` decimal(15,2)
,`budget_increases` decimal(37,2)
,`total_disbursed` decimal(37,2)
,`total_spent` decimal(37,2)
,`total_allocated` decimal(38,2)
,`remaining_balance` decimal(38,2)
);

-- --------------------------------------------------------

--
-- Table structure for table `project_steps`
--

CREATE TABLE IF NOT EXISTS `project_steps` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `step_number` int(11) NOT NULL,
  `step_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `status` enum('pending','in_progress','completed','skipped') DEFAULT 'pending',
  `start_date` date DEFAULT NULL,
  `expected_end_date` date DEFAULT NULL,
  `actual_end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `project_subscriptions` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subscription_token` varchar(64) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `email_verified` tinyint(1) DEFAULT 0,
  `verification_token` varchar(64) DEFAULT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_notification_sent` timestamp NULL DEFAULT NULL,
  `unsubscribed_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `project_transactions` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `transaction_type` enum('budget_increase','expenditure','disbursement','adjustment') NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `description` text NOT NULL,
  `transaction_date` date NOT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `document_path` varchar(255) DEFAULT NULL,
  `document_type` enum('invoice','receipt','voucher','other') DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fund_source` varchar(255) DEFAULT 'County Development Fund',
  `funding_category` enum('development','recurrent','emergency','donor','other') DEFAULT 'development',
  `disbursement_method` enum('cheque','bank_transfer','mobile_money','cash') DEFAULT 'bank_transfer',
  `voucher_number` varchar(100) DEFAULT NULL,
  `approval_status` enum('pending','approved','rejected') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `payment_status` enum('pending','processed','completed','failed') DEFAULT 'pending',
  `transaction_status` enum('active','edited','deleted','reversed') DEFAULT 'active',
  `original_transaction_id` int(11) DEFAULT NULL,
  `edit_reason` text DEFAULT NULL,
  `deletion_reason` text DEFAULT NULL,
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `receipt_number` varchar(100) DEFAULT NULL,
  `bank_receipt_reference` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `project_transaction_documents` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT 0,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `publication_logs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `attempt_date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  `errors` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `purchase_orders` (
  `id` int(11) NOT NULL,
  `po_number` varchar(50) NOT NULL,
  `purchase_request_id` int(11) DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_contact` varchar(255) DEFAULT NULL,
  `supplier_address` text DEFAULT NULL,
  `po_title` varchar(255) NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `currency` varchar(10) DEFAULT 'KES',
  `vat_amount` decimal(15,2) DEFAULT 0.00,
  `gross_amount` decimal(15,2) GENERATED ALWAYS AS (`total_amount` + `vat_amount`) STORED,
  `delivery_date` date DEFAULT NULL,
  `delivery_location` text DEFAULT NULL,
  `payment_terms` varchar(255) DEFAULT NULL,
  `warranty_terms` text DEFAULT NULL,
  `status` enum('draft','issued','acknowledged','partially_delivered','fully_delivered','cancelled','closed') DEFAULT 'draft',
  `issued_date` date DEFAULT NULL,
  `acknowledged_date` date DEFAULT NULL,
  `contract_file_path` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `purchase_order_items` (
  `id` int(11) NOT NULL,
  `purchase_order_id` int(11) NOT NULL,
  `item_description` text NOT NULL,
  `quantity_ordered` decimal(10,2) NOT NULL,
  `quantity_delivered` decimal(10,2) DEFAULT 0.00,
  `quantity_remaining` decimal(10,2) GENERATED ALWAYS AS (`quantity_ordered` - `quantity_delivered`) STORED,
  `unit_of_measure` varchar(50) NOT NULL,
  `unit_cost` decimal(15,2) NOT NULL,
  `total_cost` decimal(15,2) GENERATED ALWAYS AS (`quantity_ordered` * `unit_cost`) STORED,
  `specifications` text DEFAULT NULL,
  `delivery_status` enum('pending','partial','complete') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `purchase_requests` (
  `id` int(11) NOT NULL,
  `pr_number` varchar(50) NOT NULL,
  `project_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `request_title` varchar(255) NOT NULL,
  `justification` text NOT NULL,
  `estimated_cost` decimal(15,2) NOT NULL,
  `currency` varchar(10) DEFAULT 'KES',
  `priority` enum('low','medium','high','urgent') DEFAULT 'medium',
  `requested_delivery_date` date DEFAULT NULL,
  `budget_line_item` varchar(100) DEFAULT NULL,
  `procurement_method` enum('direct','quotation','tender','framework') DEFAULT 'quotation',
  `status` enum('draft','submitted','approved','rejected','converted_to_po','cancelled') DEFAULT 'draft',
  `requested_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `purchase_request_items` (
  `id` int(11) NOT NULL,
  `purchase_request_id` int(11) NOT NULL,
  `item_description` text NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_of_measure` varchar(50) NOT NULL,
  `estimated_unit_cost` decimal(15,2) NOT NULL,
  `estimated_total_cost` decimal(15,2) GENERATED ALWAYS AS (`quantity` * `estimated_unit_cost`) STORED,
  `specifications` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `security_logs` (
  `id` int(11) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `sub_counties` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `county_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `total_budget` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `budget_amount` decimal(15,2) NOT NULL DEFAULT 0.00,
  `budget_type` enum('initial','revised','supplementary') DEFAULT 'initial',
  `budget_source` varchar(255) DEFAULT NULL,
  `fiscal_year` varchar(10) NOT NULL,
  `approval_status` enum('pending','approved','rejected','under_review') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_comments` text DEFAULT NULL,
  `budget_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`budget_breakdown`)),
  `supporting_documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`supporting_documents`)),
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `version` int(11) DEFAULT 1,
  `previous_version_id` int(11) DEFAULT NULL,
  `fund_source` varchar(255) DEFAULT 'County Development Fund',
  `funding_category` enum('development','recurrent','emergency','donor') DEFAULT 'development',
  `disbursement_schedule` text DEFAULT NULL,
  `allocated_amount` decimal(15,2) DEFAULT 0.00,
  `disbursed_amount` decimal(15,2) DEFAULT 0.00,
  `remaining_amount` decimal(15,2) DEFAULT 0.00,
  `budget_notes` text DEFAULT NULL,
  `financial_year` varchar(20) DEFAULT NULL,
  `budget_line_item` varchar(255) DEFAULT NULL,
  `funding_agency` varchar(255) DEFAULT NULL,
  `disbursement_conditions` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Stores project budget information with approval workflow and version control';

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(11) NOT NULL,
  `debit` decimal(15,2) DEFAULT NULL,
  `credit` decimal(15,2) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `transactions_ledger` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `transaction_reference` varchar(100) NOT NULL,
  `transaction_date` date NOT NULL,
  `description` text NOT NULL,
  `debit_amount` decimal(15,2) DEFAULT 0.00,
  `credit_amount` decimal(15,2) DEFAULT 0.00,
  `account_type` enum('asset','liability','equity','income','expense') NOT NULL,
  `account_code` varchar(50) DEFAULT NULL,
  `voucher_number` varchar(100) DEFAULT NULL,
  `supporting_document` varchar(255) DEFAULT NULL,
  `transaction_status` enum('pending','posted','cancelled','reversed') DEFAULT 'pending',
  `posted_by` int(11) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `transaction_cbs_mapping` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `cbs_id` int(11) NOT NULL,
  `allocated_amount` decimal(15,2) NOT NULL,
  `percentage_allocation` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `transaction_types` (
  `id` int(11) NOT NULL,
  `type_code` varchar(50) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `affects_budget` tinyint(1) DEFAULT 0,
  `affects_expenditure` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `wards` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sub_county_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `wbs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `work_breakdown_structure` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `wbs_code` varchar(50) NOT NULL,
  `parent_wbs_id` int(11) DEFAULT NULL,
  `wbs_level` int(11) NOT NULL DEFAULT 1,
  `work_package_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `deliverables` text DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `estimated_cost` decimal(15,2) DEFAULT 0.00,
  `actual_cost` decimal(15,2) DEFAULT 0.00,
  `progress_percentage` decimal(5,2) DEFAULT 0.00,
  `responsible_admin` int(11) DEFAULT NULL,
  `status` enum('not_started','in_progress','completed','on_hold','cancelled') DEFAULT 'not_started',
  `is_milestone` tinyint(1) DEFAULT 0,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;