-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2025 at 01:21 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_activation_tokens`
--

CREATE TABLE `account_activation_tokens` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(128) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email_hash` char(64) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `password_last_changed_at` datetime DEFAULT NULL,
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

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `email_hash`, `password_hash`, `password_last_changed_at`, `role`, `is_active`, `email_verified`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`, `last_login`, `last_ip`, `permissions`, `two_factor_secret`, `last_password_change`, `password_reset_token`, `token_expires`) VALUES
(1, 'MIGORI COUNTY', 'hamisi@gmail.com', '3a5141152721db14812df22b927773658d8fdc8cc30c537be226e68e5487070e', '$argon2id$v=19$m=65536,t=4,p=1$Qm82Z0ltS3VveTcxVzl0Wg$K7VZMwiZmUSlev7Hezyp7kYkWDBOz4B21nBqfOVaUUY', '2025-05-29 18:20:11', 'super_admin', 1, 1, '2025-05-29 15:20:11', NULL, '2025-07-20 21:30:41', 1, '2025-07-20 21:27:28', '2025-07-20 21:27:28', '::1', NULL, NULL, NULL, NULL, NULL),
(5, 'test encrypt', 'achiengp888@gmail.com', NULL, '$2y$10$BLrN..ymlFwfByf0xJ0TxOu0dDnUeiU/0/wEk/vVlZ8e9sNfpT5a2', '2025-07-14 02:40:26', 'admin', 1, 1, '2025-07-13 23:40:26', NULL, '2025-07-20 21:30:41', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Hamisi Willian', 'hamweed68@gmail.com', NULL, '$argon2id$v=19$m=65536,t=4,p=1$MGR1LkNmRmNDR0pSY2R0Nw$Ymeao9NAyQ5kmOga3T0wuPFDKp2y2aemFoWj5Vvd688', '2025-07-14 05:00:57', 'admin', 1, 1, '2025-07-14 02:00:57', NULL, '2025-07-20 21:30:41', 6, '2025-07-16 21:27:27', '2025-07-16 21:27:27', '::1', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_log`
--

CREATE TABLE `admin_activity_log` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `activity_description` text NOT NULL,
  `target_type` varchar(50) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_data`)),
  `old_values` longtext DEFAULT NULL,
  `new_values` longtext DEFAULT NULL,
  `changed_fields` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_activity_log`
--

INSERT INTO `admin_activity_log` (`id`, `admin_id`, `activity_type`, `activity_description`, `target_type`, `target_id`, `ip_address`, `user_agent`, `additional_data`, `old_values`, `new_values`, `changed_fields`, `created_at`) VALUES
(1, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', 'system', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '[]', NULL, NULL, NULL, '2025-07-20 23:07:50'),
(2, 1, 'pmc_reports_access', 'Accessed PMC reports page', 'system', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '[]', NULL, NULL, NULL, '2025-07-20 23:08:05'),
(3, 1, 'report_export', 'Exported project_progress report in pdf format', 'system', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '[]', NULL, NULL, NULL, '2025-07-20 23:08:11'),
(4, 1, 'activity_logs_access', 'Viewed activity logs page', 'system', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '[]', NULL, NULL, NULL, '2025-07-20 23:08:51');

-- --------------------------------------------------------

--
-- Table structure for table `admin_permissions`
--

CREATE TABLE `admin_permissions` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `permission_key` varchar(100) NOT NULL,
  `granted_by` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_permissions`
--

INSERT INTO `admin_permissions` (`id`, `admin_id`, `permission_key`, `granted_by`, `is_active`, `created_at`, `updated_at`) VALUES
(92, 5, 'dashboard_access', 1, 1, '2025-07-13 23:40:26', '2025-07-13 23:40:26'),
(93, 5, 'view_projects', 1, 1, '2025-07-13 23:40:26', '2025-07-13 23:40:26'),
(94, 5, 'create_projects', 1, 1, '2025-07-13 23:40:26', '2025-07-13 23:40:26'),
(95, 5, 'edit_projects', 1, 1, '2025-07-13 23:40:26', '2025-07-13 23:40:26'),
(96, 5, 'manage_feedback', 1, 1, '2025-07-13 23:40:26', '2025-07-13 23:40:26'),
(97, 5, 'view_reports', 1, 1, '2025-07-13 23:40:26', '2025-07-13 23:40:26'),
(98, 6, 'dashboard_access', 1, 1, '2025-07-14 02:00:57', '2025-07-14 02:11:43');

-- --------------------------------------------------------

--
-- Table structure for table `budget_allocations`
--

CREATE TABLE `budget_allocations` (
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

-- --------------------------------------------------------

--
-- Table structure for table `counties`
--

CREATE TABLE `counties` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counties`
--

INSERT INTO `counties` (`id`, `name`, `code`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'Migori', 'MGR', '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'Public Health and Medical Services', 'Oversees healthcare services, hospitals, clinics, and public health programs across Migori County.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(2, 'Water and Energy', 'Responsible for water supply, irrigation systems, and energy development projects in the county.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(3, 'Finance and Economic Planning', 'Manages county budgeting, financial planning, revenue collection and economic development strategies.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(4, 'Public Service Management and Devolution', 'Handles human resource management, capacity building and implementation of devolution policies.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(5, 'Roads, Transport and Public Works', 'Develops and maintains road infrastructure, public transport systems and county government buildings.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(6, 'Education, Gender, Youth, Sports, Culture and Social Services', 'Coordinates education programs, youth empowerment, sports development and cultural activities.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(7, 'Lands, Housing, Physical Planning and Urban Development', 'Manages land administration, housing projects, urban planning and development control.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(8, 'Agriculture, Livestock, Veterinary Services, Fisheries and Blue Economy', 'Promotes agricultural development, livestock health, fisheries and blue economy initiatives.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(9, 'Environment, Natural Resources, Climate Change and Disaster Management', 'Leads environmental conservation, natural resource management and climate resilience programs.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(10, 'Trade, Tourism, Industrialization and Cooperative Development', 'Facilitates trade, tourism promotion, industrialization and cooperative society development.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(11, 'ICT, e-Governance and Innovation', 'Drives digital transformation, e-government services and innovation in public service delivery.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(12, 'County Assembly', 'The legislative arm of Migori County Government that makes laws and oversees county operations.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL),
(13, 'Public Service Board', 'Responsible for human resource management and public service administration in the county.', '2025-06-21 09:39:48', NULL, '2025-07-14 09:30:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
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

-- --------------------------------------------------------

--
-- Table structure for table `feedback_notifications`
--

CREATE TABLE `feedback_notifications` (
  `id` int(11) NOT NULL,
  `feedback_id` int(11) NOT NULL,
  `notification_type` enum('response_sent','status_updated','follow_up') NOT NULL,
  `recipient_email` varchar(255) NOT NULL,
  `sent_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivery_status` enum('pending','sent','failed') DEFAULT 'pending',
  `error_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `fund_sources`
--

CREATE TABLE `fund_sources` (
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

--
-- Dumping data for table `fund_sources`
--

INSERT INTO `fund_sources` (`id`, `source_name`, `source_code`, `source_type`, `description`, `contact_person`, `contact_details`, `terms_conditions`, `is_active`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'County Development Fund', 'CDF', 'government', 'Primary county development funding', NULL, NULL, NULL, 1, '2025-07-04 07:54:29', NULL, '2025-07-04 07:54:29', NULL, NULL),
(2, 'World Bank', 'WB', 'donor', 'World Bank development projects', NULL, NULL, NULL, 1, '2025-07-04 07:54:29', NULL, '2025-07-04 07:54:29', NULL, NULL),
(3, 'African Development Bank', 'ADB', 'donor', 'African Development Bank funding', NULL, NULL, NULL, 1, '2025-07-04 07:54:29', NULL, '2025-07-04 07:54:29', NULL, NULL),
(4, 'USAID', 'USAID', 'donor', 'United States Agency for International Development', NULL, NULL, NULL, 1, '2025-07-04 07:54:29', NULL, '2025-07-04 07:54:29', NULL, NULL),
(5, 'Emergency Fund', 'EMF', 'government', 'County emergency response fund', NULL, NULL, NULL, 1, '2025-07-04 07:54:29', NULL, '2025-07-04 07:54:29', NULL, NULL),
(6, 'Internally Generated Revenue', 'IGR', 'internally_generated', 'County own revenue sources', NULL, NULL, NULL, 1, '2025-07-04 07:54:29', NULL, '2025-07-04 07:54:29', NULL, NULL),
(7, 'Kenya Urban Support Programme', 'KUSP', 'donor', NULL, NULL, NULL, NULL, 1, '2025-07-04 20:16:20', NULL, '2025-07-04 20:16:20', NULL, NULL),
(8, 'Equalization Fund', 'EQF', 'government', NULL, NULL, NULL, NULL, 1, '2025-07-04 20:16:20', NULL, '2025-07-04 20:16:20', NULL, NULL),
(9, 'Conditional Grants', 'CG', 'government', NULL, NULL, NULL, NULL, 1, '2025-07-04 20:16:20', NULL, '2025-07-04 20:16:20', NULL, NULL),
(10, 'Other', 'OTHER', '', NULL, NULL, NULL, NULL, 1, '2025-07-04 20:16:20', NULL, '2025-07-04 20:16:20', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `import_logs`
--

CREATE TABLE `import_logs` (
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

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
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

-- --------------------------------------------------------

--
-- Table structure for table `password_history`
--

CREATE TABLE `password_history` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `token` varchar(128) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `prepared_responses`
--

CREATE TABLE `prepared_responses` (
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

--
-- Dumping data for table `prepared_responses`
--

INSERT INTO `prepared_responses` (`id`, `name`, `content`, `category`, `is_active`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'Thank You', 'Thank you for your feedback. We appreciate your input and will review it carefully.', 'acknowledgment', 1, '2025-06-19 14:28:09', NULL, '2025-06-19 14:28:09', NULL, NULL),
(2, 'Under Review', 'Your feedback is currently under review by our team. We will respond within 3-5 business days.', 'status', 1, '2025-06-19 14:28:09', NULL, '2025-06-19 14:28:09', NULL, NULL),
(3, 'More Information Needed', 'Thank you for reaching out. To better assist you, could you please provide more specific details about your concern?', 'inquiry', 1, '2025-06-19 14:28:09', NULL, '2025-06-19 14:28:09', NULL, NULL),
(4, 'Issue Resolved', 'Thank you for bringing this to our attention. The issue has been resolved and appropriate measures have been taken.', 'resolution', 1, '2025-06-19 14:28:09', NULL, '2025-06-19 14:28:09', NULL, NULL),
(5, 'Project Progress Update', 'Thank you for your inquiry about the project progress. We are currently on track with our planned timeline and will provide regular updates as work continues.', 'progress', 1, '2025-06-19 14:28:09', NULL, '2025-06-19 14:28:09', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
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

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `project_name`, `description`, `department_id`, `project_year`, `county_id`, `sub_county_id`, `ward_id`, `location_address`, `location_coordinates`, `start_date`, `expected_completion_date`, `actual_completion_date`, `contractor_name`, `contractor_contact`, `status`, `visibility`, `step_status`, `progress_percentage`, `total_steps`, `completed_steps`, `created_by`, `created_at`, `updated_at`, `average_rating`, `total_ratings`, `allocated_budget`, `spent_budget`, `budget_status`, `total_budget`, `last_step_milestone`, `last_financial_milestone`) VALUES
(1, 'Migori County Health Center Construction', 'construction of Migori County Health Center Construction', 1, 2025, 1, 4, 15, 'Migori Town Center, near the main market', '-1.063711456264273, 34.47765470147226', '2026-12-01', NULL, NULL, 'FM Constructors Group', 'abccontractorsltd@gmail.com', 'ongoing', 'published', 'awaiting', 35.42, 4, 0, 1, '2025-07-07 18:19:59', '2025-07-08 20:21:55', 5.00, 0, 0.00, 0.00, 'not_allocated', 12000000.00, 0, 0),
(2, 'Migori-Isebania Road Improvement', 'Upgrading of 15km stretch of Migori-Isebania road with tarmac surface and proper drainage', 3, 2024, 1, 8, 35, 'Migori-Isebania Highway, Migori Town', '-0.835649, 34.189739', '1750-07-31', NULL, NULL, 'Kens Construction Ltd', 'abccontractorsltd1@gmail.com', 'ongoing', 'published', 'awaiting', 57.64, 4, 3, 1, '2025-07-08 06:48:53', '2025-07-14 11:35:57', 5.00, 0, 0.00, 0.00, 'not_allocated', 17000000.00, 0, 0),
(3, 'Rongo Bus stage Upgrade', 'Construction of modern market stalls with proper sanitation and drainage facilities', 4, 2024, 1, 5, 18, 'Rongo Town Center', '-0.762871, 34.599666', '1199-11-30', NULL, NULL, '', 'Unity Builders', 'ongoing', 'private', 'awaiting', 25.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 19:18:39', 5.00, 0, 0.00, 0.00, 'not_allocated', 25478947485.00, 0, 0),
(4, 'Isibania Health Center Extension', 'Addition of maternity wing and medical equipment procurement', 2, 2024, 1, 6, 24, 'Nyatike Health Center', '-1.218048, 34.482936', '1499-11-30', NULL, NULL, 'ABC Construction LTD', '0702353585', 'ongoing', 'private', 'awaiting', 25.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-16 22:58:34', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471252674.00, 0, 0),
(5, 'Lela Dispensary expansion', 'contruction of ward fercility', 8, 2025, 1, 2, 7, 'Oyani SDA', '-0.975707, 34.241237', '9699-11-30', NULL, NULL, '', 'ABC Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25484648599.00, 0, 0),
(6, 'Lela market construction', 'kaminolewe market improvement to market standards', 7, 2026, 1, 3, 12, 'Kaminolewe market', '-0.941379, 34.432811', '1970-01-01', NULL, NULL, '', 'ABC Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25473574848.00, 0, 0),
(7, 'Central Sakwa police post construction', 'Implementation of public service management and devolution in Central Sakwa ward under Awendo sub-county.', 13, 2024, 1, 2, 8, 'Central Sakwa Area, Awendo Sub-county', '-1.200886, 34.621639', '1970-01-01', NULL, NULL, '', 'Blue Economy Partners', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25463848848.00, 0, 0),
(8, 'South Sakwa Lands, Project', 'Implementation of lands, housing, physical planning and urban development in South Sakwa ward under Awendo sub-county.', 4, 2023, 1, 1, 3, 'South Sakwa Area, Awendo Sub-county', '-0.904305, 34.528255', '1099-11-30', NULL, NULL, '', 'MajiWorks Kenya', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25475465154.00, 0, 0),
(11, 'North Kamagambo Public Project', 'Implementation of public service management and devolution in North Kamagambo ward under Rongo sub-county.', 9, 2025, 1, 3, 11, 'North Kamagambo Area, Rongo Sub-county', '-0.874096, 34.581813', '1399-11-30', NULL, NULL, '', 'EcoDev Works', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-17 12:27:05', '2025-07-17 12:27:05', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471163680.00, 0, 0),
(12, 'PMC System development', 'Development of a PMC system to manage the progress and project progress tracking for the public', 11, 2025, 1, 3, 10, 'Migori Town Center, ICT Department offices', '-1.063711456264273, 34.47765470147226', '2025-05-06', '2025-08-08', NULL, 'ABC Construction Ltd', '0702353585', 'ongoing', 'published', 'awaiting', 19.86, 7, 2, 1, '2025-07-17 12:36:21', '2025-07-17 12:46:59', 5.00, 0, 0.00, 0.00, 'not_allocated', 500000.00, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_documents`
--

CREATE TABLE `project_documents` (
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

--
-- Dumping data for table `project_documents`
--

INSERT INTO `project_documents` (`id`, `project_id`, `document_type`, `document_title`, `filename`, `original_name`, `description`, `document_status`, `version_number`, `original_document_id`, `edit_reason`, `deletion_reason`, `modified_by`, `modified_at`, `is_public`, `file_size`, `mime_type`, `uploaded_by`, `created_at`) VALUES
(1, 1, 'Signed Contract Agreement', 'SIGNED CONTRACT AGREEMENT', 'doc_686c112813bac8.74791928.pdf', 'PAKNOTIX RUSH-BN-REG356734T.pdf', 'Contract agreement', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 124192, 'application/pdf', 1, '2025-07-07 18:25:44'),
(2, 2, 'Project Approval Letter', 'Project Aproval Letter', 'doc_686cc07a8088d6.59564747.pdf', 'ZILCOM KOTIENO GROUP.pdf', 'Project Aproval Letter', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 123491, 'application/pdf', 1, '2025-07-08 06:53:46'),
(3, 1, 'Final Joint Inspection Report', 'Joint inspection report', 'doc_686d5fec5a2a60.76639716.pdf', 'doc_686d5ea955e7e6.34870331.pdf', 'joint inspection report', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 37175, 'application/pdf', 1, '2025-07-08 18:14:04'),
(4, 2, 'Other', 'Site Visit Report', 'doc_68780163344ed7.34891983.pdf', 'Financial summary Report1.pdf', 'pmc visit report', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 215162, 'application/pdf', 1, '2025-07-16 19:45:39'),
(5, 12, 'PMC Workplan', 'System Development Workplan', 'doc_6878ef08c845f0.32715967.pdf', 'doc_68780163344ed7.34891983.pdf', 'System Development Workplan', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 215162, 'application/pdf', 1, '2025-07-17 12:39:36');

-- --------------------------------------------------------

--
-- Stand-in structure for view `project_financial_summary`
-- (See below for the actual view)
--
CREATE TABLE `project_financial_summary` (
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

CREATE TABLE `project_steps` (
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

--
-- Dumping data for table `project_steps`
--

INSERT INTO `project_steps` (`id`, `project_id`, `step_number`, `step_name`, `description`, `status`, `start_date`, `expected_end_date`, `actual_end_date`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'planning and approval', 'project planning and approval by the county assembly', 'in_progress', '2025-07-07', NULL, '2025-07-08', '2025-07-07 18:20:48', '2025-07-08 20:21:55'),
(2, 1, 2, 'creation of PMC', 'creation of the project management committee and initial project steps mapping', 'pending', NULL, NULL, NULL, '2025-07-07 18:21:41', '2025-07-07 18:21:41'),
(3, 1, 3, 'Procurement of Construction materials', 'procurement and installation of construction materials', 'pending', NULL, NULL, NULL, '2025-07-07 18:23:03', '2025-07-07 18:23:03'),
(4, 1, 4, 'Final completion analysis and report', 'final step of the project', 'pending', NULL, NULL, NULL, '2025-07-07 18:23:48', '2025-07-07 18:23:48'),
(5, 2, 1, 'Road Survey and Design', 'Conduct topographical survey and prepare detailed engineering designs', 'completed', '2025-07-08', NULL, '2025-07-09', '2025-07-08 06:48:53', '2025-07-08 21:48:06'),
(6, 3, 1, 'Site Preparation', 'Clear site and prepare foundation for market construction', 'in_progress', '2025-07-08', NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 19:18:39'),
(7, 4, 1, 'Architectural Planning', 'Design maternity wing and plan equipment installation', 'in_progress', '2025-07-17', NULL, NULL, '2025-07-08 06:48:53', '2025-07-16 22:58:11'),
(8, 5, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(9, 6, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(10, 7, 1, 'Design and Costing', 'Drafting architectural drawings and estimating costs.', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(11, 8, 1, 'Land Survey', 'Carrying out land demarcation and topographical survey.', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(13, 2, 2, 'Project Planning and Approval', 'this step involves alot', 'completed', '2025-07-09', NULL, '2025-07-12', '2025-07-08 06:49:55', '2025-07-12 13:54:14'),
(14, 2, 3, 'Procurement of Construction materials', 'procurement of materials', 'completed', '2025-07-12', NULL, '2025-07-14', '2025-07-08 06:50:30', '2025-07-14 11:35:47'),
(15, 2, 4, 'commissioning', 'final reporting about the project', 'in_progress', '2025-07-14', NULL, NULL, '2025-07-08 06:51:10', '2025-07-14 11:35:57'),
(19, 11, 1, 'Feasibility Study', 'Conducting technical and social feasibility assessment.', 'pending', NULL, NULL, NULL, '2025-07-17 12:27:05', '2025-07-17 12:27:05'),
(20, 12, 2, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'completed', '2025-07-17', NULL, '2025-07-17', '2025-07-17 12:36:21', '2025-07-17 12:46:39'),
(21, 12, 3, 'Establishment of project committee', 'establishment of the project committee', 'completed', '2025-07-17', NULL, '2025-07-17', '2025-07-17 12:36:21', '2025-07-17 12:46:53'),
(22, 12, 4, 'System design and development', 'creation of a timeline and layouts for the system', 'in_progress', '2025-07-17', NULL, NULL, '2025-07-17 12:36:21', '2025-07-17 12:46:59'),
(23, 12, 5, 'Development of the system', 'actual development of the system database and blocks', 'pending', NULL, NULL, NULL, '2025-07-17 12:36:21', '2025-07-17 12:36:21'),
(24, 12, 6, 'testing of the system', 'vigorous tests on the system to meet the security and encryption standards', 'pending', NULL, NULL, NULL, '2025-07-17 12:36:21', '2025-07-17 12:36:21'),
(25, 12, 7, 'deployment', 'deployment of the system to an online hosting', 'pending', NULL, NULL, NULL, '2025-07-17 12:36:21', '2025-07-17 12:36:21'),
(26, 12, 8, 'system launching', 'start of the official use of the PMC system', 'pending', NULL, NULL, NULL, '2025-07-17 12:36:21', '2025-07-17 12:36:21');

-- --------------------------------------------------------

--
-- Table structure for table `project_subscriptions`
--

CREATE TABLE `project_subscriptions` (
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
  `user_agent` text DEFAULT NULL,
  `email_hash` char(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_subscriptions`
--

INSERT INTO `project_subscriptions` (`id`, `project_id`, `email`, `subscription_token`, `is_active`, `email_verified`, `verification_token`, `subscribed_at`, `last_notification_sent`, `unsubscribed_at`, `ip_address`, `user_agent`, `email_hash`) VALUES
(1, 12, 'jenifermuhonja01@gmail.com', '7461a2f156213203e79fd79675d5cf866cc45bc14629005435474b4a97928adc', 1, 0, '000c48b44eb5dbae06e44a795558f9415304899d5f5e36bf7285e45702b315cc', '2025-07-17 12:56:08', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '0a32d6f79d4dbd327583a652caacaa161c1679d630d1433e08cb4b4c36133b20'),
(2, 12, 'hamweed68@gmail.com', '49b6c50bcbdc9f3a6b6094a7a7cf57cc5d78d5c5487543de5a156f15f93a2c18', 1, 0, 'efb372f304ef4a54c7694483022ce28d9c408ff91a40faec63760f5572b7a3bf', '2025-07-20 09:43:43', NULL, NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'b815dd50b802df7befefdf894db35d19413004cdda878bcd5441f47e7f0599f3');

-- --------------------------------------------------------

--
-- Table structure for table `project_transactions`
--

CREATE TABLE `project_transactions` (
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

--
-- Dumping data for table `project_transactions`
--

INSERT INTO `project_transactions` (`id`, `project_id`, `transaction_type`, `amount`, `description`, `transaction_date`, `reference_number`, `document_path`, `document_type`, `created_by`, `created_at`, `updated_at`, `fund_source`, `funding_category`, `disbursement_method`, `voucher_number`, `approval_status`, `approved_by`, `approved_at`, `payment_status`, `transaction_status`, `original_transaction_id`, `edit_reason`, `deletion_reason`, `modified_by`, `modified_at`, `receipt_number`, `bank_receipt_reference`) VALUES
(1, 2, 'budget_increase', 1000000.00, 'Additional project allocation', '2025-07-08', 'GSTE53Q8', NULL, NULL, 1, '2025-07-08 09:37:41', '2025-07-08 09:37:41', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(2, 2, 'disbursement', 7000000.00, 'First Disbursement', '2025-07-08', 'GSTE53D', NULL, NULL, 1, '2025-07-08 09:39:41', '2025-07-08 09:39:41', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(3, 2, 'expenditure', 5000000.00, 'Payment for the contractor', '2025-07-08', 'GSTE534', NULL, NULL, 1, '2025-07-08 09:41:22', '2025-07-08 09:41:22', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(5, 1, 'disbursement', 12000000.00, 'First Tranche Disbursement', '2025-07-08', 'GSTE53D', NULL, NULL, 1, '2025-07-08 18:06:10', '2025-07-08 18:06:10', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(6, 1, 'expenditure', 7000000.00, 'Payment to the Constructors', '2025-07-08', 'GSTE534', NULL, NULL, 1, '2025-07-08 18:08:41', '2025-07-08 18:08:41', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(7, 12, 'disbursement', 100000.00, 'First Disbursement', '2025-07-17', 'GSTE522', NULL, NULL, 1, '2025-07-17 12:43:33', '2025-07-17 12:43:33', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, 'VDT/TEDR/235', ''),
(8, 12, 'expenditure', 20000.00, 'Being Purchase of Development Resources', '2025-07-17', 'GSTE567', NULL, NULL, 1, '2025-07-17 12:45:35', '2025-07-17 12:45:35', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, 'VDT/TEDR/238', '');

-- --------------------------------------------------------

--
-- Table structure for table `project_transaction_documents`
--

CREATE TABLE `project_transaction_documents` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `file_size` int(11) DEFAULT 0,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_transaction_documents`
--

INSERT INTO `project_transaction_documents` (`id`, `transaction_id`, `file_path`, `original_filename`, `file_size`, `mime_type`, `uploaded_by`, `created_at`) VALUES
(1, 1, 'doc_686ce6e577ef50.56581539.pdf', 'PAKNOTIX RUSH-BN-REG356734T.pdf', 124192, 'application/pdf', 1, '2025-07-08 09:37:41'),
(2, 2, 'doc_686ce75dcacf75.23158197.pdf', 'PAKNOTIX RUSH-BN-REG356734T.pdf', 124192, 'application/pdf', 1, '2025-07-08 09:39:41'),
(3, 3, 'doc_686ce7c2eb3797.88996745.pdf', 'PAKNOTIX RUSH-BN-REG356734T.pdf', 124192, 'application/pdf', 1, '2025-07-08 09:41:22'),
(4, 5, 'doc_686d5e1267a0b6.69624577.pdf', 'MIGORI COUNTY HEALTH CENTER CONSTRACTION DISBURSEMENT.pdf', 37343, 'application/pdf', 1, '2025-07-08 18:06:10'),
(5, 6, 'doc_686d5ea955e7e6.34870331.pdf', 'MIGORI COUNTY HEALTH CENTER CONSTRACTION PAYMENT.pdf', 37175, 'application/pdf', 1, '2025-07-08 18:08:41'),
(6, 7, 'doc_6878eff54c9f96.85081382.pdf', 'doc_68780163344ed7.34891983.pdf', 215162, 'application/pdf', 1, '2025-07-17 12:43:33'),
(7, 8, 'doc_6878f06febe2c8.52873435.pdf', 'doc_68780163344ed7.34891983.pdf', 215162, 'application/pdf', 1, '2025-07-17 12:45:35');

-- --------------------------------------------------------

--
-- Table structure for table `publication_logs`
--

CREATE TABLE `publication_logs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `attempt_date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  `errors` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `security_logs`
--

CREATE TABLE `security_logs` (
  `id` int(11) NOT NULL,
  `event_type` varchar(50) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `details` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `security_logs`
--

INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(1, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047162}', '2025-07-20 21:32:42'),
(2, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047192}', '2025-07-20 21:33:12'),
(3, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047222}', '2025-07-20 21:33:42'),
(4, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047252}', '2025-07-20 21:34:12'),
(5, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047298}', '2025-07-20 21:34:58'),
(6, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047358}', '2025-07-20 21:35:58'),
(7, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047418}', '2025-07-20 21:36:58'),
(8, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047478}', '2025-07-20 21:37:58'),
(9, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047538}', '2025-07-20 21:38:58'),
(10, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047598}', '2025-07-20 21:39:58'),
(11, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047658}', '2025-07-20 21:40:58'),
(12, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047718}', '2025-07-20 21:41:58'),
(13, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047778}', '2025-07-20 21:42:58'),
(14, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047838}', '2025-07-20 21:43:58'),
(15, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047898}', '2025-07-20 21:44:58'),
(16, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753047958}', '2025-07-20 21:45:58'),
(17, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048018}', '2025-07-20 21:46:58'),
(18, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048078}', '2025-07-20 21:47:58'),
(19, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048138}', '2025-07-20 21:48:58'),
(20, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048198}', '2025-07-20 21:49:58'),
(21, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048258}', '2025-07-20 21:50:58'),
(22, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048318}', '2025-07-20 21:51:58'),
(23, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048378}', '2025-07-20 21:52:58'),
(24, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048419}', '2025-07-20 21:53:39'),
(25, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048422}', '2025-07-20 21:53:42'),
(26, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048452}', '2025-07-20 21:54:12'),
(27, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048482}', '2025-07-20 21:54:42'),
(28, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048512}', '2025-07-20 21:55:12'),
(29, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048558}', '2025-07-20 21:55:58'),
(30, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048618}', '2025-07-20 21:56:58'),
(31, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048678}', '2025-07-20 21:57:58'),
(32, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048738}', '2025-07-20 21:58:58'),
(33, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048798}', '2025-07-20 21:59:58'),
(34, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048858}', '2025-07-20 22:00:58'),
(35, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048918}', '2025-07-20 22:01:58'),
(36, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753048978}', '2025-07-20 22:02:58'),
(37, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049038}', '2025-07-20 22:03:58'),
(38, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049098}', '2025-07-20 22:04:58'),
(39, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049158}', '2025-07-20 22:05:58'),
(40, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049218}', '2025-07-20 22:06:58'),
(41, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049278}', '2025-07-20 22:07:58'),
(42, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049338}', '2025-07-20 22:08:58'),
(43, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049398}', '2025-07-20 22:09:58'),
(44, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049458}', '2025-07-20 22:10:58'),
(45, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049518}', '2025-07-20 22:11:58'),
(46, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049578}', '2025-07-20 22:12:58'),
(47, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049638}', '2025-07-20 22:13:58'),
(48, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049698}', '2025-07-20 22:14:58'),
(49, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049758}', '2025-07-20 22:15:58'),
(50, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049818}', '2025-07-20 22:16:58'),
(51, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049878}', '2025-07-20 22:17:58'),
(52, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049938}', '2025-07-20 22:18:58'),
(53, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753049998}', '2025-07-20 22:19:58'),
(54, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050058}', '2025-07-20 22:20:58'),
(55, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050118}', '2025-07-20 22:21:58'),
(56, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050178}', '2025-07-20 22:22:58'),
(57, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050238}', '2025-07-20 22:23:58'),
(58, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050298}', '2025-07-20 22:24:58'),
(59, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050358}', '2025-07-20 22:25:58'),
(60, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050418}', '2025-07-20 22:26:58'),
(61, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050478}', '2025-07-20 22:27:58'),
(62, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050538}', '2025-07-20 22:28:58'),
(63, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050598}', '2025-07-20 22:29:58'),
(64, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050658}', '2025-07-20 22:30:58'),
(65, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050718}', '2025-07-20 22:31:58'),
(66, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050778}', '2025-07-20 22:32:58'),
(67, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050838}', '2025-07-20 22:33:58'),
(68, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050898}', '2025-07-20 22:34:58'),
(69, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753050958}', '2025-07-20 22:35:58'),
(70, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051018}', '2025-07-20 22:36:58'),
(71, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051078}', '2025-07-20 22:37:58'),
(72, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051138}', '2025-07-20 22:38:58'),
(73, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051198}', '2025-07-20 22:39:58'),
(74, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051241}', '2025-07-20 22:40:41'),
(75, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051272}', '2025-07-20 22:41:12'),
(76, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051302}', '2025-07-20 22:41:42'),
(77, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051363}', '2025-07-20 22:42:43'),
(78, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051424}', '2025-07-20 22:43:44'),
(79, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051485}', '2025-07-20 22:44:45'),
(80, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051546}', '2025-07-20 22:45:46'),
(81, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051607}', '2025-07-20 22:46:47'),
(82, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051668}', '2025-07-20 22:47:48'),
(83, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051729}', '2025-07-20 22:48:49'),
(84, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051790}', '2025-07-20 22:49:50'),
(85, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051851}', '2025-07-20 22:50:51'),
(86, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051912}', '2025-07-20 22:51:52'),
(87, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753051973}', '2025-07-20 22:52:53'),
(88, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052034}', '2025-07-20 22:53:54'),
(89, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052095}', '2025-07-20 22:54:55'),
(90, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052156}', '2025-07-20 22:55:56'),
(91, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052217}', '2025-07-20 22:56:57'),
(92, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052278}', '2025-07-20 22:57:58'),
(93, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052338}', '2025-07-20 22:58:58'),
(94, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052398}', '2025-07-20 22:59:58'),
(95, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052458}', '2025-07-20 23:00:58'),
(96, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052518}', '2025-07-20 23:01:58'),
(97, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052578}', '2025-07-20 23:02:58'),
(98, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052638}', '2025-07-20 23:03:58'),
(99, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052698}', '2025-07-20 23:04:58'),
(100, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052758}', '2025-07-20 23:05:58'),
(101, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052818}', '2025-07-20 23:06:58'),
(102, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dataEncryption.php\",\"method\":\"GET\",\"timestamp\":1753052868}', '2025-07-20 23:07:48'),
(103, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1753052870}', '2025-07-20 23:07:50'),
(104, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1753052876}', '2025-07-20 23:07:56'),
(105, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1753052885}', '2025-07-20 23:08:05'),
(106, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1753052885}', '2025-07-20 23:08:05'),
(107, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1753052915}', '2025-07-20 23:08:35'),
(108, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1753052925}', '2025-07-20 23:08:45'),
(109, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1753052925}', '2025-07-20 23:08:45'),
(110, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"activityLogs.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/activityLogs.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1753052931}', '2025-07-20 23:08:51'),
(111, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1753052931}', '2025-07-20 23:08:51'),
(112, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1753052941}', '2025-07-20 23:09:01'),
(113, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1753052942}', '2025-07-20 23:09:02'),
(114, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"auditTrail.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1753052946}', '2025-07-20 23:09:06'),
(115, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753052946}', '2025-07-20 23:09:06'),
(116, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753052976}', '2025-07-20 23:09:36'),
(117, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753053006}', '2025-07-20 23:10:06'),
(118, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753053036}', '2025-07-20 23:10:36'),
(119, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753053067}', '2025-07-20 23:11:07');
INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(120, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753053097}', '2025-07-20 23:11:37'),
(121, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753053127}', '2025-07-20 23:12:07'),
(122, 'page_access', 1, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"getDashboardStats.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/ajax\\/getDashboardStats.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1753053157}', '2025-07-20 23:12:37');

-- --------------------------------------------------------

--
-- Table structure for table `session_management`
--

CREATE TABLE `session_management` (
  `id` int(11) NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_activity` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expires_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_active` tinyint(1) DEFAULT 1,
  `login_method` varchar(50) DEFAULT 'password'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_settings`
--

CREATE TABLE `site_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(255) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_description` text DEFAULT NULL,
  `setting_type` enum('string','integer','boolean','json') DEFAULT 'string',
  `is_encrypted` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_settings`
--

INSERT INTO `site_settings` (`id`, `setting_key`, `setting_value`, `setting_description`, `setting_type`, `is_encrypted`, `created_at`, `updated_at`, `updated_by`) VALUES
(1, 'site_name', 'Migori County Project Management', 'Official site name', 'string', 0, '2025-07-20 21:16:27', '2025-07-20 21:16:27', NULL),
(2, 'max_login_attempts', '5', 'Maximum login attempts before lockout', 'integer', 0, '2025-07-20 21:16:27', '2025-07-20 21:16:27', NULL),
(3, 'session_timeout', '3600', 'Session timeout in seconds', 'integer', 0, '2025-07-20 21:16:27', '2025-07-20 21:16:27', NULL),
(4, 'maintenance_mode', '0', 'Enable maintenance mode (1=enabled, 0=disabled)', 'boolean', 0, '2025-07-20 21:16:27', '2025-07-20 21:16:27', NULL),
(5, 'email_notifications', '1', 'Enable email notifications (1=enabled, 0=disabled)', 'boolean', 0, '2025-07-20 21:16:27', '2025-07-20 21:16:27', NULL),
(6, 'encryption_mode', '1', 'Enable/disable automatic data encryption (1=enabled, 0=disabled)', 'boolean', 0, '2025-07-20 21:22:56', '2025-07-20 21:22:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sub_counties`
--

CREATE TABLE `sub_counties` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `county_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_counties`
--

INSERT INTO `sub_counties` (`id`, `name`, `county_id`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'Rongo', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(2, 'Awendo', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(3, 'Suna East', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(4, 'Suna West', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(5, 'Uriri', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(6, 'Kuria East', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(7, 'Nyatike', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(8, 'Kuria West', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` enum('true','false') NOT NULL DEFAULT 'false',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `created_at`, `updated_at`, `updated_by`) VALUES
(1, 'encryption_mode', 'false', '2025-07-16 10:32:27', '2025-07-20 21:30:41', 1);

-- --------------------------------------------------------

--
-- Table structure for table `total_budget`
--

CREATE TABLE `total_budget` (
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

--
-- Dumping data for table `total_budget`
--

INSERT INTO `total_budget` (`id`, `project_id`, `budget_amount`, `budget_type`, `budget_source`, `fiscal_year`, `approval_status`, `approved_by`, `approved_at`, `approval_comments`, `budget_breakdown`, `supporting_documents`, `created_by`, `created_at`, `updated_at`, `is_active`, `version`, `previous_version_id`, `fund_source`, `funding_category`, `disbursement_schedule`, `allocated_amount`, `disbursed_amount`, `remaining_amount`, `budget_notes`, `financial_year`, `budget_line_item`, `funding_agency`, `disbursement_conditions`) VALUES
(1, 1, 12000000.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-07 18:19:59', '2025-07-07 18:19:59', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(2, 2, 25476473647.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(3, 3, 25478947485.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(4, 4, 25471252674.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(5, 5, 25484648599.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(6, 6, 25473574848.00, 'initial', 'County Development Fund', '2026/2027', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(7, 7, 25463848848.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(8, 8, 25475465154.00, 'initial', 'County Development Fund', '2023/2024', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(11, 11, 25471163680.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-17 12:27:05', '2025-07-17 12:27:05', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(12, 12, 500000.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-17 12:36:21', '2025-07-17 12:36:21', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `debit` decimal(15,2) DEFAULT NULL,
  `credit` decimal(15,2) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_types`
--

CREATE TABLE `transaction_types` (
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

--
-- Dumping data for table `transaction_types`
--

INSERT INTO `transaction_types` (`id`, `type_code`, `display_name`, `description`, `affects_budget`, `affects_expenditure`, `is_active`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'budget_increase', 'Additional Budget Increase', 'Increases the approved budget amount for the project', 1, 0, 1, '2025-07-05 09:34:28', NULL, '2025-07-14 09:30:02', NULL, NULL),
(2, 'disbursement', 'Disbursement to Project Account', 'Money transferred to project account from county funds', 0, 0, 1, '2025-07-05 09:34:28', NULL, '2025-07-14 09:30:02', NULL, NULL),
(3, 'expenditure', 'Project Expenditure', 'Money spent from project account for project activities', 0, 1, 1, '2025-07-05 09:34:28', NULL, '2025-07-14 09:30:02', NULL, NULL),
(4, 'adjustment', 'Budget Adjustment', 'Miscellaneous budget adjustments', 0, 0, 1, '2025-07-05 09:34:28', NULL, '2025-07-14 09:30:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `unified_logs`
--

CREATE TABLE `unified_logs` (
  `id` int(11) NOT NULL,
  `log_type` enum('activity','audit') NOT NULL DEFAULT 'activity',
  `action_type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `affected_table` varchar(100) DEFAULT NULL,
  `affected_record_id` int(11) DEFAULT NULL,
  `old_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_values`)),
  `new_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_values`)),
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wards`
--

CREATE TABLE `wards` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sub_county_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `modified_by` int(11) DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wards`
--

INSERT INTO `wards` (`id`, `name`, `sub_county_id`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, 'North Kamagambo', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(2, 'Central Kamagambo', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(3, 'East Kamagambo', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(4, 'South Kamagambo', 1, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(5, 'North East Sakwa', 2, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(6, 'South Sakwa', 2, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(7, 'West Sakwa', 2, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(8, 'Central Sakwa', 2, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(9, 'God Jope', 3, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(10, 'Suna Central', 3, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(11, 'Kakrao', 3, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(12, 'Kwa', 3, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(13, 'Wiga', 4, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(14, 'Wasweta II', 4, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(15, 'Ragana-Oruba', 4, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(16, 'Wasimbete', 4, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(17, 'West Kanyamkago', 5, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(18, 'North Kanyamkago', 5, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(19, 'Central Kanyamkago', 5, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(20, 'South Kanyamkago', 5, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(21, 'East Kanyamkago', 5, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(22, 'Gokeharaka/Getamwega', 6, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(23, 'Ntimaru West', 6, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(24, 'Ntimaru East', 6, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(25, 'Nyabasi East', 6, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(26, 'Nyabasi West', 6, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(27, 'Kachieng', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(28, 'Kanyasa', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(29, 'North Kadem', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(30, 'Macalder/Kanyarwanda', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(31, 'Kaler', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(32, 'Got Kachola', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(33, 'Muhuru', 7, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(34, 'Bukira East', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(35, 'Bukira Central/Ikerege', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(36, 'Isibania', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(37, 'Makerero', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(38, 'Masaba', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(39, 'Tagare', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL),
(40, 'Nyamosense/Komosoko', 8, '2025-06-21 09:39:15', NULL, '2025-07-14 09:30:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure for view `project_financial_summary`
--
DROP TABLE IF EXISTS `project_financial_summary`;

CREATE VIEW `project_financial_summary` AS 
SELECT 
    `p`.`id` AS `project_id`, 
    `p`.`project_name` AS `project_name`, 
    `p`.`total_budget` AS `approved_budget`, 
    COALESCE(SUM(CASE WHEN `pt`.`transaction_type` = 'budget_increase' AND `pt`.`transaction_status` = 'active' THEN `pt`.`amount` ELSE 0 END), 0) AS `budget_increases`, 
    COALESCE(SUM(CASE WHEN `pt`.`transaction_type` = 'disbursement' AND `pt`.`transaction_status` = 'active' THEN `pt`.`amount` ELSE 0 END), 0) AS `total_disbursed`, 
    COALESCE(SUM(CASE WHEN `pt`.`transaction_type` = 'expenditure' AND `pt`.`transaction_status` = 'active' THEN `pt`.`amount` ELSE 0 END), 0) AS `total_spent`, 
    `p`.`total_budget` + COALESCE(SUM(CASE WHEN `pt`.`transaction_type` = 'budget_increase' AND `pt`.`transaction_status` = 'active' THEN `pt`.`amount` ELSE 0 END), 0) AS `total_allocated`, 
    COALESCE(SUM(CASE WHEN `pt`.`transaction_type` = 'disbursement' AND `pt`.`transaction_status` = 'active' THEN `pt`.`amount` ELSE 0 END), 0) - COALESCE(SUM(CASE WHEN `pt`.`transaction_type` = 'expenditure' AND `pt`.`transaction_status` = 'active' THEN `pt`.`amount` ELSE 0 END), 0) AS `remaining_balance` 
FROM 
    (`projects` `p` 
    LEFT JOIN `project_transactions` `pt` ON `p`.`id` = `pt`.`project_id`) 
GROUP BY 
    `p`.`id`, `p`.`project_name`, `p`.`total_budget`;
--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_activation_tokens`
--
ALTER TABLE `account_activation_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_id` (`admin_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token_expiry` (`token`,`expires_at`),
  ADD KEY `idx_admin_used` (`admin_id`,`used`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_admins_role` (`role`),
  ADD KEY `idx_admins_active` (`is_active`),
  ADD KEY `idx_admins_email_active` (`email`,`is_active`),
  ADD KEY `idx_admins_active_verified` (`is_active`,`email_verified`),
  ADD KEY `fk_admins_created_by` (`created_by`),
  ADD KEY `fk_admins_modified_by` (`modified_by`);

--
-- Indexes for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `idx_target` (`target_type`,`target_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_admin_activity_log_admin_id` (`admin_id`),
  ADD KEY `idx_admin_activity_log_activity_type` (`activity_type`),
  ADD KEY `idx_admin_activity_log_target` (`target_type`,`target_id`),
  ADD KEY `idx_admin_activity_log_created_at` (`created_at`);

--
-- Indexes for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_admin_permission` (`admin_id`,`permission_key`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_permission_key` (`permission_key`),
  ADD KEY `idx_is_active` (`is_active`),
  ADD KEY `granted_by` (`granted_by`);

--
-- Indexes for table `budget_allocations`
--
ALTER TABLE `budget_allocations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `budget_id` (`budget_id`),
  ADD KEY `allocated_by` (`allocated_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `idx_project_budget` (`project_id`,`budget_id`),
  ADD KEY `idx_financial_year` (`financial_year`),
  ADD KEY `idx_fund_source` (`fund_source`);

--
-- Indexes for table `counties`
--
ALTER TABLE `counties`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `fk_counties_created_by` (`created_by`),
  ADD KEY `fk_counties_modified_by` (`modified_by`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `fk_departments_created_by` (`created_by`),
  ADD KEY `fk_departments_modified_by` (`modified_by`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `responded_by` (`responded_by`),
  ADD KEY `moderated_by` (`moderated_by`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_parent_comment_id` (`parent_comment_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_user_ip` (`user_ip`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_project_status` (`project_id`,`status`),
  ADD KEY `idx_feedback_status_created` (`status`,`created_at`),
  ADD KEY `idx_feedback_filtering` (`status`,`filtering_metadata`(100));

--
-- Indexes for table `feedback_notifications`
--
ALTER TABLE `feedback_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_feedback_notifications_feedback_id` (`feedback_id`),
  ADD KEY `idx_feedback_notifications_status` (`delivery_status`);

--
-- Indexes for table `fund_sources`
--
ALTER TABLE `fund_sources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `source_name` (`source_name`),
  ADD UNIQUE KEY `source_code` (`source_code`),
  ADD KEY `fk_fund_sources_created_by` (`created_by`),
  ADD KEY `fk_fund_sources_modified_by` (`modified_by`);

--
-- Indexes for table `import_logs`
--
ALTER TABLE `import_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `imported_by` (`imported_by`),
  ADD KEY `fk_import_logs_modified_by` (`modified_by`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_timestamp` (`timestamp`),
  ADD KEY `idx_ip_address` (`ip_address`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `fk_login_attempts_user_id` (`user_id`),
  ADD KEY `idx_email_timestamp` (`email`,`timestamp`),
  ADD KEY `idx_session_id` (`session_id`),
  ADD KEY `idx_failure_reason` (`failure_reason`);

--
-- Indexes for table `password_history`
--
ALTER TABLE `password_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin_created` (`admin_id`,`created_at`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admin_id` (`admin_id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `idx_token_expiry` (`token`,`expires_at`),
  ADD KEY `idx_admin_used` (`admin_id`,`used`);

--
-- Indexes for table `prepared_responses`
--
ALTER TABLE `prepared_responses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_prepared_responses_created_by` (`created_by`),
  ADD KEY `fk_prepared_responses_modified_by` (`modified_by`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `department_id` (`department_id`),
  ADD KEY `county_id` (`county_id`),
  ADD KEY `sub_county_id` (`sub_county_id`),
  ADD KEY `ward_id` (`ward_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_projects_status` (`status`),
  ADD KEY `idx_projects_visibility` (`visibility`),
  ADD KEY `idx_projects_year` (`project_year`);

--
-- Indexes for table `project_documents`
--
ALTER TABLE `project_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `fk_project_documents_modified_by` (`modified_by`),
  ADD KEY `fk_project_documents_original` (`original_document_id`),
  ADD KEY `idx_project_documents_status` (`document_status`),
  ADD KEY `idx_project_documents_public` (`is_public`),
  ADD KEY `idx_project_documents_type` (`document_type`),
  ADD KEY `idx_project_documents_project_status` (`project_id`,`document_status`);

--
-- Indexes for table `project_steps`
--
ALTER TABLE `project_steps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_project_step` (`project_id`,`step_number`),
  ADD KEY `idx_project_steps_status` (`status`);

--
-- Indexes for table `project_subscriptions`
--
ALTER TABLE `project_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `subscription_token` (`subscription_token`),
  ADD KEY `idx_project_email` (`project_id`,`email`),
  ADD KEY `idx_subscription_token` (`subscription_token`),
  ADD KEY `idx_verification_token` (`verification_token`),
  ADD KEY `idx_project_email_hash` (`project_id`,`email_hash`);

--
-- Indexes for table `project_transactions`
--
ALTER TABLE `project_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `transaction_date` (`transaction_date`),
  ADD KEY `idx_transaction_status` (`transaction_status`),
  ADD KEY `idx_transaction_project_admin` (`project_id`,`created_by`),
  ADD KEY `idx_transaction_type_status` (`transaction_type`,`transaction_status`),
  ADD KEY `fk_pt_approved_by` (`approved_by`),
  ADD KEY `fk_pt_modified_by` (`modified_by`);

--
-- Indexes for table `project_transaction_documents`
--
ALTER TABLE `project_transaction_documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `uploaded_by` (`uploaded_by`);

--
-- Indexes for table `publication_logs`
--
ALTER TABLE `publication_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_admin_id` (`admin_id`);

--
-- Indexes for table `security_logs`
--
ALTER TABLE `security_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_event_type` (`event_type`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `session_management`
--
ALTER TABLE `session_management`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `session_id` (`session_id`),
  ADD KEY `idx_session_id` (`session_id`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `site_settings`
--
ALTER TABLE `site_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_setting_key` (`setting_key`);

--
-- Indexes for table `sub_counties`
--
ALTER TABLE `sub_counties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `county_id` (`county_id`),
  ADD KEY `fk_sub_counties_created_by` (`created_by`),
  ADD KEY `fk_sub_counties_modified_by` (`modified_by`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `total_budget`
--
ALTER TABLE `total_budget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_approval_status` (`approval_status`),
  ADD KEY `idx_fiscal_year` (`fiscal_year`),
  ADD KEY `idx_created_by` (`created_by`),
  ADD KEY `idx_approved_by` (`approved_by`),
  ADD KEY `idx_is_active` (`is_active`),
  ADD KEY `fk_total_budget_previous_version` (`previous_version_id`),
  ADD KEY `idx_total_budget_project_active` (`project_id`,`is_active`),
  ADD KEY `idx_total_budget_version_active` (`project_id`,`version`,`is_active`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_date` (`date`);

--
-- Indexes for table `transaction_types`
--
ALTER TABLE `transaction_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type_code` (`type_code`),
  ADD KEY `fk_transaction_types_created_by` (`created_by`),
  ADD KEY `fk_transaction_types_modified_by` (`modified_by`);

--
-- Indexes for table `unified_logs`
--
ALTER TABLE `unified_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_log_type` (`log_type`),
  ADD KEY `idx_action_type` (`action_type`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_affected_table` (`affected_table`);

--
-- Indexes for table `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_county_id` (`sub_county_id`),
  ADD KEY `fk_wards_created_by` (`created_by`),
  ADD KEY `fk_wards_modified_by` (`modified_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_activation_tokens`
--
ALTER TABLE `account_activation_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `budget_allocations`
--
ALTER TABLE `budget_allocations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `counties`
--
ALTER TABLE `counties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feedback_notifications`
--
ALTER TABLE `feedback_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fund_sources`
--
ALTER TABLE `fund_sources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `import_logs`
--
ALTER TABLE `import_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_history`
--
ALTER TABLE `password_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `prepared_responses`
--
ALTER TABLE `prepared_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `project_documents`
--
ALTER TABLE `project_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `project_steps`
--
ALTER TABLE `project_steps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `project_subscriptions`
--
ALTER TABLE `project_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `project_transactions`
--
ALTER TABLE `project_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `project_transaction_documents`
--
ALTER TABLE `project_transaction_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `publication_logs`
--
ALTER TABLE `publication_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `security_logs`
--
ALTER TABLE `security_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `session_management`
--
ALTER TABLE `session_management`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_settings`
--
ALTER TABLE `site_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `total_budget`
--
ALTER TABLE `total_budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_types`
--
ALTER TABLE `transaction_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `unified_logs`
--
ALTER TABLE `unified_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_activation_tokens`
--
ALTER TABLE `account_activation_tokens`
  ADD CONSTRAINT `account_activation_tokens_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `fk_admins_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_admins_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD CONSTRAINT `admin_activity_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  ADD CONSTRAINT `admin_permissions_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_permissions_ibfk_2` FOREIGN KEY (`granted_by`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `budget_allocations`
--
ALTER TABLE `budget_allocations`
  ADD CONSTRAINT `budget_allocations_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `budget_allocations_ibfk_2` FOREIGN KEY (`budget_id`) REFERENCES `total_budget` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `budget_allocations_ibfk_3` FOREIGN KEY (`allocated_by`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `budget_allocations_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `counties`
--
ALTER TABLE `counties`
  ADD CONSTRAINT `fk_counties_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_counties_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_departments_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_departments_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `fund_sources`
--
ALTER TABLE `fund_sources`
  ADD CONSTRAINT `fk_fund_sources_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_fund_sources_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `import_logs`
--
ALTER TABLE `import_logs`
  ADD CONSTRAINT `fk_import_logs_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD CONSTRAINT `fk_login_attempts_user_id` FOREIGN KEY (`user_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `password_history`
--
ALTER TABLE `password_history`
  ADD CONSTRAINT `password_history_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `prepared_responses`
--
ALTER TABLE `prepared_responses`
  ADD CONSTRAINT `fk_prepared_responses_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_prepared_responses_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `project_documents`
--
ALTER TABLE `project_documents`
  ADD CONSTRAINT `fk_project_documents_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_project_documents_original` FOREIGN KEY (`original_document_id`) REFERENCES `project_documents` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `project_documents_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_documents_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `project_subscriptions`
--
ALTER TABLE `project_subscriptions`
  ADD CONSTRAINT `project_subscriptions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `project_transactions`
--
ALTER TABLE `project_transactions`
  ADD CONSTRAINT `fk_pt_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_pt_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transactions_approved_by_new` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transactions_modified_by_new` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `project_transactions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `project_transaction_documents`
--
ALTER TABLE `project_transaction_documents`
  ADD CONSTRAINT `project_transaction_documents_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `project_transactions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `project_transaction_documents_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `publication_logs`
--
ALTER TABLE `publication_logs`
  ADD CONSTRAINT `publication_logs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `publication_logs_ibfk_2` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `security_logs`
--
ALTER TABLE `security_logs`
  ADD CONSTRAINT `security_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `session_management`
--
ALTER TABLE `session_management`
  ADD CONSTRAINT `fk_session_admin` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `sub_counties`
--
ALTER TABLE `sub_counties`
  ADD CONSTRAINT `fk_sub_counties_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_sub_counties_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `total_budget`
--
ALTER TABLE `total_budget`
  ADD CONSTRAINT `fk_total_budget_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_total_budget_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_total_budget_previous_version` FOREIGN KEY (`previous_version_id`) REFERENCES `total_budget` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_total_budget_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `transaction_types`
--
ALTER TABLE `transaction_types`
  ADD CONSTRAINT `fk_transaction_types_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transaction_types_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `unified_logs`
--
ALTER TABLE `unified_logs`
  ADD CONSTRAINT `unified_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `wards`
--
ALTER TABLE `wards`
  ADD CONSTRAINT `fk_wards_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_wards_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
