-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 12, 2025 at 12:10 PM
-- Server version: 8.0.42-cll-lve
-- PHP Version: 8.3.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lakeside_manage_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_activation_tokens`
--

CREATE TABLE `account_activation_tokens` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('super_admin','admin') COLLATE utf8mb4_general_ci DEFAULT 'admin',
  `is_active` tinyint(1) DEFAULT '0',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `last_ip` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `two_factor_secret` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_password_change` datetime DEFAULT NULL,
  `password_reset_token` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `token_expires` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password_hash`, `role`, `is_active`, `email_verified`, `created_at`, `updated_at`, `last_login`, `last_ip`, `permissions`, `two_factor_secret`, `last_password_change`, `password_reset_token`, `token_expires`) VALUES
(1, 'MIGORI COUNTY', 'hamisi@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$Qm82Z0ltS3VveTcxVzl0Wg$K7VZMwiZmUSlev7Hezyp7kYkWDBOz4B21nBqfOVaUUY', 'super_admin', 1, 0, '2025-05-29 12:20:11', '2025-07-12 10:05:56', '2025-07-12 10:05:56', '102.0.11.44', NULL, NULL, NULL, NULL, NULL),
(2, 'HAMISI ACCOUNT 2', 'hamweed68@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$Wk5TQjFnQ2FIdndBbHYwaw$7o07LABBBKBX51L6ENPLW8qtLkk2E9yg8kFiJKO2qpk', 'admin', 1, 0, '2025-06-13 04:00:04', '2025-07-12 10:03:56', '2025-07-12 10:02:19', '102.0.11.44', NULL, NULL, NULL, NULL, NULL),
(3, 'Steve Odoyo', 'stevekyle106@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$cWpxTU9jbWVEVDQ2bVhWYQ$NTkZZWsvPsAwQyTPpoWcQBUrihbgaV3wOP53d4vWtco', 'admin', 1, 0, '2025-07-02 08:51:08', '2025-07-12 09:47:56', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'PMC USER 2', 'fbhamisike@gmail.com', '$argon2id$v=19$m=65536,t=4,p=1$RjRaZUhjTlF2V3BKRFUuTg$kDr91eEvaDEM7m2eCPdlJc+9MGn6JTDpVQuPbdtvIjM', 'admin', 1, 0, '2025-07-12 10:07:57', '2025-07-12 10:09:55', '2025-07-12 10:09:55', '102.0.11.44', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_log`
--

CREATE TABLE `admin_activity_log` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `activity_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `activity_description` text COLLATE utf8mb4_general_ci NOT NULL,
  `target_type` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_id` int DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_general_ci,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `admin_activity_log`
--

INSERT INTO `admin_activity_log` (`id`, `admin_id`, `activity_type`, `activity_description`, `target_type`, `target_id`, `ip_address`, `user_agent`, `additional_data`, `created_at`) VALUES
(281, 1, 'Project created: DEDE SCHOOL DORMITORY', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:33:19'),
(282, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 0%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:33:53'),
(283, 1, 'Added project step for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:33:53'),
(284, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 0%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:34:19'),
(285, 1, 'Added project step for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:34:19'),
(286, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 6.25%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:34:33'),
(287, 1, 'Updated step status for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:34:33'),
(288, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:34:55'),
(289, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 6.25%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:36:47'),
(290, 1, 'Updated project step for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:36:47'),
(291, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 6.25%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:37:32'),
(292, 1, 'Updated project step for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:37:32'),
(293, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 6.25%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:38:22'),
(294, 1, 'Updated project step for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:38:22'),
(295, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:39:04'),
(296, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:40:11'),
(297, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:42:32'),
(298, 1, 'document_uploaded', 'Uploaded PMC document: certificate of comletion (Completion Certificate) for project #11', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:42:32'),
(299, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:42:50'),
(300, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:44:20'),
(301, 1, 'project_subscription', 'New subscription for project ID: 11 from email: stevekyle106@gmail.com', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:46:14'),
(302, 1, 'project_subscription', 'New subscription for project ID: 11 from email: jjoyam976@gmail.com', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:48:39'),
(303, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:49:44'),
(304, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:49:48'),
(305, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:50:05'),
(306, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 12.5%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:50:25'),
(307, 1, 'Updated step status for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:50:25'),
(308, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 18.75%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:51:29'),
(309, 1, 'Updated step status for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:51:29'),
(310, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 25%', 'project', 11, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:51:52'),
(311, 1, 'project_update_notification', 'Sent update notifications for project ID: 11 to 2 subscribers', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:51:53'),
(312, 1, 'Updated step status for project ID: 11', '1', NULL, NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 07:51:53'),
(313, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:17:19'),
(314, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 37.5%', 'project', 11, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:17:45'),
(315, 1, 'Updated step status for project ID: 11', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:17:45'),
(316, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:19:15'),
(317, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:20:00'),
(318, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:20:24'),
(319, 1, 'activity_logs_access', 'Viewed activity logs page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:20:39'),
(320, 1, 'Project created: KARUNGU DAM PROJECT', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:32:18'),
(321, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 0%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:47:22'),
(322, 1, 'Added project step for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:47:22'),
(323, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 0%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:15'),
(324, 1, 'Added project step for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:15'),
(325, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 5%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:31'),
(326, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:31'),
(327, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 10%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:41'),
(328, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:41'),
(329, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:48:51'),
(330, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:50:24'),
(331, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 37.5%', 'project', 11, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:51:08'),
(332, 1, 'Updated project step for project ID: 11', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:51:08'),
(333, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 37.5%', 'project', 11, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:53:23'),
(334, 1, 'transaction_added', 'Added new disbursement transaction for project ID 11', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:53:23'),
(335, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:53:52'),
(336, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 76.54%', 'project', 11, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:56:26'),
(337, 1, 'transaction_added', 'Added new expenditure transaction for project ID 11', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:56:26'),
(338, 1, 'project_progress_updated', 'Updated progress for project ID: 11 to 76.54%', 'project', 11, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:57:55'),
(339, 1, 'transaction_updated', 'Edited expenditure transaction for project ID 11', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:57:55'),
(340, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:58:56'),
(341, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 08:59:39'),
(342, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:01:31'),
(343, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:02:31'),
(344, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:02:38'),
(345, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:02:45'),
(346, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:04:42'),
(347, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:15:33'),
(348, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:15:57'),
(349, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:17:05'),
(350, 1, 'document_uploaded', 'Uploaded PMC document: APPROVAL LETTER (Project Approval Letter) for project #12', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:17:05'),
(351, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:17:12'),
(352, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:17:42'),
(353, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 10%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:23:23'),
(354, 1, 'transaction_added', 'Added new disbursement transaction for project ID 12', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:23:23'),
(355, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 42.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:24:53'),
(356, 1, 'transaction_added', 'Added new expenditure transaction for project ID 12', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:24:53'),
(357, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:26:18'),
(358, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 47.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:26:29'),
(359, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:26:29'),
(360, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 52.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:26:39'),
(361, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 09:26:39'),
(362, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:46:44'),
(363, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:48:57'),
(364, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:51:51'),
(365, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:52:04'),
(366, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:52:34'),
(367, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:52:58'),
(368, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 0%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:53:11'),
(369, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:53:34'),
(370, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:53:37'),
(371, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 0%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:54:38'),
(372, 1, 'Added project step for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:54:38'),
(373, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:54:54'),
(374, 1, 'Added project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:54:54'),
(375, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:55:34'),
(376, 1, 'Added project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:55:34'),
(377, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 0%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:55:45'),
(378, 1, 'Added project step for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:55:45'),
(379, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 0%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:56:11'),
(380, 1, 'Added project step for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:56:11'),
(381, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:56:15'),
(382, 1, 'Added project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:56:15'),
(383, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:56:33'),
(384, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 11:56:58'),
(385, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:57:35'),
(386, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 11:57:42'),
(387, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:00:34'),
(388, 1, 'document_uploaded', 'Uploaded PMC document: Project Aproval Letter (Project Approval Letter) for project #13', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:00:34'),
(389, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:00:54'),
(390, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:01:10'),
(391, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 0%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:01:59'),
(392, 1, 'Added project step for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:01:59'),
(393, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 0%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:02:26'),
(394, 1, 'Added project step for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:02:26'),
(395, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:03:42'),
(396, 1, 'Project updated: South Sakwa Lands, Project', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:03:42'),
(397, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:04:16'),
(398, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:04:32'),
(399, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:05:18'),
(400, 1, 'document_uploaded', 'Uploaded PMC document: PMS WORKMAN (PMC Workplan) for project #20', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:05:18'),
(401, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:05:25'),
(402, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:05:47'),
(403, 1, 'Updated project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:05:47'),
(405, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:08:45'),
(406, 1, 'Updated project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:08:45'),
(407, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:09:01'),
(408, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 57.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:09:18'),
(409, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:09:18'),
(410, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 62.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:09:36'),
(411, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:09:36'),
(412, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:10:02'),
(413, 1, 'Project updated: South Sakwa Lands, Project', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:10:02'),
(414, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 62.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:10:05'),
(415, 1, 'Updated project step for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:10:05'),
(416, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:10:10'),
(418, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:11:51'),
(419, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:12:32'),
(422, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 4.17%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:32:28'),
(423, 1, 'Updated step status for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 12:32:28'),
(424, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 12:43:10'),
(425, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 8.33%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:01:59'),
(426, 1, 'Updated step status for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:01:59'),
(427, 1, 'project_progress_updated', 'Updated progress for project ID: 13 to 12.5%', 'project', 13, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:02:05'),
(428, 1, 'Updated step status for project ID: 13', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:02:05'),
(429, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:04:23'),
(430, 1, 'project_progress_updated', 'Updated progress for project ID: 12 to 67.53%', 'project', 12, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:04:39'),
(431, 1, 'Updated step status for project ID: 12', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:04:39'),
(432, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:05:05'),
(433, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 13:05:10'),
(435, 1, 'project_progress_updated', 'Updated progress for project ID: 19 to 25%', 'project', 19, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:05:30'),
(436, 1, 'Updated step status for project ID: 19', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:05:30'),
(437, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:10:48'),
(438, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 6.25%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:11:05'),
(439, 1, 'Updated step status for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:11:06'),
(441, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:52:08'),
(442, 1, 'project_update_notification', 'Sent update notifications for project ID: 20 to 1 subscribers', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:52:08'),
(443, 1, 'Updated step status for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:52:08'),
(444, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 13:53:23'),
(445, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 0%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:54:32'),
(446, 1, 'transaction_added', 'Added new disbursement transaction for project ID 20', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:54:32'),
(447, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 29.44%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:56:27'),
(448, 1, 'project_update_notification', 'Sent update notifications for project ID: 20 to 2 subscribers', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:56:27'),
(449, 1, 'transaction_added', 'Added new expenditure transaction for project ID 20', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 13:56:27'),
(450, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:00:29'),
(451, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:00:35'),
(452, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:00:41'),
(453, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 41.94%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:03:07'),
(454, 1, 'Updated step status for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:03:07'),
(455, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 41.94%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:03:28'),
(456, 1, 'Updated project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:03:28'),
(457, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 41.94%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:03:55'),
(458, 1, 'Updated project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:03:55'),
(459, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 54.44%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:04:18'),
(460, 1, 'project_update_notification', 'Sent update notifications for project ID: 20 to 1 subscribers', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:04:19'),
(461, 1, 'Updated step status for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:04:19'),
(462, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:15:10'),
(463, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:15:22'),
(464, 1, 'activity_logs_access', 'Viewed activity logs page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:16:20'),
(465, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:19:24'),
(466, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:19:28'),
(467, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:19:38'),
(468, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:21:00'),
(469, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:21:15'),
(470, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:21:26'),
(471, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:21:46'),
(472, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:21:58'),
(473, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:22:17'),
(474, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:26:40'),
(475, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:26:46'),
(476, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:26:53'),
(477, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:26:55'),
(478, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:26:59'),
(479, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 54.44%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:27:23'),
(480, 1, 'Updated project step for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:27:23'),
(481, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 60.69%', 'project', 20, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:27:33'),
(482, 1, 'Updated step status for project ID: 20', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:27:33'),
(483, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:27:40'),
(484, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:28:04'),
(485, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:28:24'),
(486, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:28:35'),
(487, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:29:12'),
(488, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:29:49'),
(489, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:31:42'),
(490, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:31:51');
INSERT INTO `admin_activity_log` (`id`, `admin_id`, `activity_type`, `activity_description`, `target_type`, `target_id`, `ip_address`, `user_agent`, `additional_data`, `created_at`) VALUES
(491, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:32:20'),
(492, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:32:23'),
(493, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:32:25'),
(494, 1, 'dashboard_access', 'Accessed PMC analytics dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:32:26'),
(495, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:32:40'),
(496, 1, 'Project created: OCHOTO VILLAGE WATER PUM', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:34:43'),
(497, 1, 'project_progress_updated', 'Updated progress for project ID: 22 to 50%', 'project', 22, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:34:56'),
(498, 1, 'Updated step status for project ID: 22', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:34:56'),
(499, 1, 'project_progress_updated', 'Updated progress for project ID: 22 to 0%', 'project', 22, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:35:08'),
(500, 1, 'Updated step status for project ID: 22', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:35:08'),
(501, 1, 'project_progress_updated', 'Updated progress for project ID: 22 to 0%', 'project', 22, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:35:35'),
(502, 1, 'Project updated: OCHOTO VILLAGE WATER PUMP', '1', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:35:35'),
(503, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:35:38'),
(504, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-09 14:41:15'),
(505, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:42:28'),
(506, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:42:42'),
(507, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:47:40'),
(508, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:50:16'),
(509, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-09 14:51:04'),
(510, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-10 10:02:20'),
(511, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-10 10:03:34'),
(512, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-10 14:00:09'),
(513, 1, 'activity_logs_access', 'Viewed activity logs page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-10 14:00:23'),
(514, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-10 18:54:06'),
(515, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', NULL, '2025-07-10 18:54:14'),
(516, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:00:18'),
(517, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:02:09'),
(518, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:02:13'),
(519, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:02:22'),
(520, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:02:33'),
(521, 1, 'dashboard_access', 'Accessed PMC analytics dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:02:35'),
(522, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:02:49'),
(523, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-11 17:03:39'),
(524, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:20:04'),
(525, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:20:14'),
(526, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:20:57'),
(527, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:21:59'),
(528, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:23:08'),
(529, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:23:26'),
(530, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:25:06'),
(531, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:25:49'),
(532, 1, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:25:55'),
(533, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:28:10'),
(534, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 54.44%', 'project', 20, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:29:07'),
(535, 1, 'Added project step for project ID: 20', '1', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:29:07'),
(536, 1, 'project_progress_updated', 'Updated progress for project ID: 20 to 60.69%', 'project', 20, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:29:28'),
(537, 1, 'Deleted project step for project ID: 20', '1', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:29:28'),
(538, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:29:59'),
(539, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:08'),
(540, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:17'),
(541, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:23'),
(542, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:29'),
(543, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:33'),
(544, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:40'),
(545, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:48'),
(546, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:51'),
(547, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:30:56'),
(548, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:01'),
(549, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:04'),
(550, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:10'),
(551, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:15'),
(552, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:19'),
(553, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:26'),
(554, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:31:32'),
(555, 1, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:35:49'),
(556, 1, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:38:05'),
(557, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:42:29'),
(558, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:43:42'),
(559, 1, 'document_uploaded', 'Uploaded PMC document: Test A (Other) for project #11', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:43:42'),
(560, 1, 'document_manager_access', 'Accessed document manager', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:44:01'),
(561, 1, 'document_deleted', 'Deleted document: Test A from project: DEDE SCHOOL DORMITORY', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:44:01'),
(562, 1, 'activity_logs_access', 'Viewed activity logs page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:45:58'),
(563, 1, 'activity_logs_access', 'Viewed activity logs page', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:46:17'),
(564, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-11 21:47:09'),
(565, 2, 'password_reset_requested', 'Password reset requested for email: hamweed68@gmail.com', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-12 09:51:29'),
(566, 2, 'password_reset_completed', 'Password reset completed for admin ID: 2', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:01:46'),
(567, 2, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:02:19'),
(568, 2, 'pmc_reports_access', 'Accessed PMC reports page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:04:08'),
(569, 2, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:04:39'),
(570, 2, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:04:42'),
(571, 2, 'csv_import_access', 'Accessed CSV import page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:04:45'),
(572, 2, 'projects_page_access', 'Accessed projects management page', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:04:49'),
(573, 2, 'document_manager_access', 'Accessed document manager', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:04:55'),
(574, 2, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:05:08'),
(575, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', NULL, '2025-07-12 10:05:56'),
(576, 1, 'admin_created', 'Created new administrator: PMC USER 2 (fbhamisike@gmail.com) with role: admin', 'admin', 4, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"name\":\"PMC USER 2\",\"email\":\"fbhamisike@gmail.com\",\"role\":\"admin\"}', '2025-07-12 10:07:57'),
(577, 4, 'admin_dashboard_access', 'Accessed main admin dashboard', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', NULL, '2025-07-12 10:09:56');

-- --------------------------------------------------------

--
-- Table structure for table `admin_permissions`
--

CREATE TABLE `admin_permissions` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `permission_key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `granted_by` int NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_permissions`
--

INSERT INTO `admin_permissions` (`id`, `admin_id`, `permission_key`, `granted_by`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 2, 'dashboard_access', 1, 1, '2025-07-02 08:04:05', '2025-07-09 00:38:24'),
(13, 3, 'dashboard_access', 1, 1, '2025-07-02 08:51:08', '2025-07-02 08:53:45'),
(66, 2, 'profile_access', 1, 1, '2025-07-04 02:00:38', '2025-07-09 00:38:24'),
(67, 2, 'create_projects', 1, 1, '2025-07-04 02:00:38', '2025-07-09 00:38:24'),
(75, 2, 'manage_feedback', 1, 1, '2025-07-04 02:00:38', '2025-07-09 00:38:24'),
(77, 2, 'view_projects', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(78, 2, 'edit_projects', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(79, 2, 'manage_projects', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(80, 2, 'import_data', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(81, 2, 'manage_project_steps', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(82, 2, 'manage_budgets', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(83, 2, 'manage_documents', 1, 1, '2025-07-04 21:22:40', '2025-07-09 00:38:24'),
(84, 2, 'view_reports', 1, 1, '2025-07-09 00:38:15', '2025-07-09 00:38:24'),
(85, 4, 'dashboard_access', 1, 1, '2025-07-12 10:07:57', '2025-07-12 10:07:57');

-- --------------------------------------------------------

--
-- Table structure for table `budget_allocations`
--

CREATE TABLE `budget_allocations` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `budget_id` int NOT NULL,
  `allocation_type` enum('initial','supplementary','reallocation') COLLATE utf8mb4_general_ci DEFAULT 'initial',
  `allocated_amount` decimal(15,2) NOT NULL,
  `fund_source` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `funding_category` enum('development','recurrent','emergency','donor') COLLATE utf8mb4_general_ci DEFAULT 'development',
  `allocation_date` date NOT NULL,
  `financial_year` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `budget_line_item` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `allocation_reference` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `conditions` text COLLATE utf8mb4_general_ci,
  `status` enum('pending','approved','active','exhausted','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `allocated_by` int NOT NULL,
  `approved_by` int DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `counties`
--

CREATE TABLE `counties` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `counties`
--

INSERT INTO `counties` (`id`, `name`, `code`, `created_at`) VALUES
(1, 'Migori', 'MGR', '2025-06-21 06:39:15');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `description`, `created_at`) VALUES
(1, 'Public Health and Medical Services', 'Oversees healthcare services, hospitals, clinics, and public health programs across Migori County.', '2025-06-21 06:39:48'),
(2, 'Water and Energy', 'Responsible for water supply, irrigation systems, and energy development projects in the county.', '2025-06-21 06:39:48'),
(3, 'Finance and Economic Planning', 'Manages county budgeting, financial planning, revenue collection and economic development strategies.', '2025-06-21 06:39:48'),
(4, 'Public Service Management and Devolution', 'Handles human resource management, capacity building and implementation of devolution policies.', '2025-06-21 06:39:48'),
(5, 'Roads, Transport and Public Works', 'Develops and maintains road infrastructure, public transport systems and county government buildings.', '2025-06-21 06:39:48'),
(6, 'Education, Gender, Youth, Sports, Culture and Social Services', 'Coordinates education programs, youth empowerment, sports development and cultural activities.', '2025-06-21 06:39:48'),
(7, 'Lands, Housing, Physical Planning and Urban Development', 'Manages land administration, housing projects, urban planning and development control.', '2025-06-21 06:39:48'),
(8, 'Agriculture, Livestock, Veterinary Services, Fisheries and Blue Economy', 'Promotes agricultural development, livestock health, fisheries and blue economy initiatives.', '2025-06-21 06:39:48'),
(9, 'Environment, Natural Resources, Climate Change and Disaster Management', 'Leads environmental conservation, natural resource management and climate resilience programs.', '2025-06-21 06:39:48'),
(10, 'Trade, Tourism, Industrialization and Cooperative Development', 'Facilitates trade, tourism promotion, industrialization and cooperative society development.', '2025-06-21 06:39:48'),
(11, 'ICT, e-Governance and Innovation', 'Drives digital transformation, e-government services and innovation in public service delivery.', '2025-06-21 06:39:48'),
(12, 'County Assembly', 'The legislative arm of Migori County Government that makes laws and oversees county operations.', '2025-06-21 06:39:48'),
(13, 'Public Service Board', 'Responsible for human resource management and public service administration in the county.', '2025-06-21 06:39:48');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `citizen_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `citizen_email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `citizen_phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subject` varchar(500) COLLATE utf8mb4_general_ci DEFAULT 'Project Comment',
  `message` text COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','approved','rejected','responded','grievance') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `priority` enum('low','medium','high') COLLATE utf8mb4_general_ci DEFAULT 'medium',
  `sentiment` enum('positive','neutral','negative') COLLATE utf8mb4_general_ci DEFAULT 'neutral',
  `parent_comment_id` int DEFAULT '0',
  `user_ip` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_general_ci,
  `filtering_metadata` text COLLATE utf8mb4_general_ci,
  `admin_response` text COLLATE utf8mb4_general_ci,
  `responded_by` int DEFAULT NULL,
  `responded_at` timestamp NULL DEFAULT NULL,
  `moderated_by` int DEFAULT NULL,
  `moderated_at` timestamp NULL DEFAULT NULL,
  `internal_notes` text COLLATE utf8mb4_general_ci,
  `is_featured` tinyint(1) DEFAULT '0',
  `engagement_score` int DEFAULT '0',
  `response_time_hours` decimal(10,2) DEFAULT NULL,
  `follow_up_required` tinyint(1) DEFAULT '0',
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `visitor_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `grievance_status` enum('open','resolved') COLLATE utf8mb4_general_ci DEFAULT 'open',
  `resolved_by` int DEFAULT NULL,
  `resolution_notes` text COLLATE utf8mb4_general_ci,
  `resolved_at` datetime DEFAULT NULL
) ;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `project_id`, `citizen_name`, `citizen_email`, `citizen_phone`, `subject`, `message`, `status`, `priority`, `sentiment`, `parent_comment_id`, `user_ip`, `user_agent`, `filtering_metadata`, `admin_response`, `responded_by`, `responded_at`, `moderated_by`, `moderated_at`, `internal_notes`, `is_featured`, `engagement_score`, `response_time_hours`, `follow_up_required`, `tags`, `attachments`, `created_at`, `updated_at`, `visitor_id`, `grievance_status`, `resolved_by`, `resolution_notes`, `resolved_at`) VALUES
(9, 11, 'steve', '', NULL, 'Project Comment', 'its good project to help students and the community have valuable education', 'responded', 'medium', 'neutral', 0, NULL, NULL, NULL, 'this issue has now been resloved, thank you', 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 07:44:06', '2025-07-09 08:18:36', NULL, 'open', NULL, NULL, NULL),
(12, 20, 'Steve punter', 'admin@everfc.com', NULL, 'Project Comment', 'Temo keto paro gi dholuo', 'rejected', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 13:06:36', '2025-07-09 14:17:41', NULL, 'open', NULL, NULL, NULL),
(13, 20, 'Steve 2', 'admin@everfc.com', NULL, 'Project Comment', 'Trying English comments', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 13:07:07', '2025-07-09 13:07:07', NULL, 'open', NULL, NULL, NULL),
(14, 20, 'Steve punter', 'hamweed68@gmail.com', NULL, 'Project Comment', 'Hapa tunajaribu kiswahili', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 13:07:31', '2025-07-09 13:07:31', NULL, 'open', NULL, NULL, NULL),
(15, 20, 'Steve odoyo', '', NULL, 'Project Comment', 'Its good idea.', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 14:52:27', '2025-07-09 14:56:55', NULL, 'open', NULL, NULL, NULL),
(16, 20, 'Didi', '', NULL, 'Project Comment', 'Good project to help the community', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 14:54:19', '2025-07-09 14:54:19', NULL, 'open', NULL, NULL, NULL),
(17, 20, 'Nick', '', NULL, 'Project Comment', 'Ni lengo poa sana kuunganisha wenye kikiji na maendeleo kama hii. Generally pleased.', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-09 14:55:56', '2025-07-09 14:55:56', NULL, 'open', NULL, NULL, NULL),
(18, 11, 'Ruto', '', NULL, 'Project Comment', 'Testing names: Part 1', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-11 20:39:04', '2025-07-11 20:39:04', NULL, 'open', NULL, NULL, NULL),
(19, 11, 'Ruto', '', NULL, 'Project Comment', 'Testing names: Part 2 \r\nRuto', 'pending', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-11 20:39:37', '2025-07-11 20:39:37', NULL, 'open', NULL, NULL, NULL),
(20, 11, 'ABCD', '', NULL, 'Project Comment', 'Test: Is this visible only to me?', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-11 20:40:31', '2025-07-11 20:40:31', NULL, 'open', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fund_sources`
--

CREATE TABLE `fund_sources` (
  `id` int NOT NULL,
  `source_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `source_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `source_type` enum('government','donor','loan','grant','internally_generated') COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `contact_person` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_details` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `terms_conditions` text COLLATE utf8mb4_general_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fund_sources`
--

INSERT INTO `fund_sources` (`id`, `source_name`, `source_code`, `source_type`, `description`, `contact_person`, `contact_details`, `terms_conditions`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'County Development Fund', 'CDF', 'government', 'Primary county development funding', NULL, NULL, NULL, 1, '2025-07-04 04:54:29', '2025-07-04 04:54:29'),
(2, 'World Bank', 'WB', 'donor', 'World Bank development projects', NULL, NULL, NULL, 1, '2025-07-04 04:54:29', '2025-07-04 04:54:29'),
(3, 'African Development Bank', 'ADB', 'donor', 'African Development Bank funding', NULL, NULL, NULL, 1, '2025-07-04 04:54:29', '2025-07-04 04:54:29'),
(4, 'USAID', 'USAID', 'donor', 'United States Agency for International Development', NULL, NULL, NULL, 1, '2025-07-04 04:54:29', '2025-07-04 04:54:29'),
(5, 'Emergency Fund', 'EMF', 'government', 'County emergency response fund', NULL, NULL, NULL, 1, '2025-07-04 04:54:29', '2025-07-04 04:54:29'),
(6, 'Internally Generated Revenue', 'IGR', 'internally_generated', 'County own revenue sources', NULL, NULL, NULL, 1, '2025-07-04 04:54:29', '2025-07-04 04:54:29'),
(7, 'Kenya Urban Support Programme', 'KUSP', 'donor', NULL, NULL, NULL, NULL, 1, '2025-07-04 17:16:20', '2025-07-04 17:16:20'),
(8, 'Equalization Fund', 'EQF', 'government', NULL, NULL, NULL, NULL, 1, '2025-07-04 17:16:20', '2025-07-04 17:16:20'),
(9, 'Conditional Grants', 'CG', 'government', NULL, NULL, NULL, NULL, 1, '2025-07-04 17:16:20', '2025-07-04 17:16:20'),
(10, 'Other', 'OTHER', '', NULL, NULL, NULL, NULL, 1, '2025-07-04 17:16:20', '2025-07-04 17:16:20');

-- --------------------------------------------------------

--
-- Table structure for table `import_logs`
--

CREATE TABLE `import_logs` (
  `id` int NOT NULL,
  `filename` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `total_rows` int NOT NULL,
  `successful_imports` int NOT NULL,
  `failed_imports` int NOT NULL,
  `error_details` text COLLATE utf8mb4_general_ci,
  `imported_by` int NOT NULL,
  `imported_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `import_logs`
--

INSERT INTO `import_logs` (`id`, `filename`, `total_rows`, `successful_imports`, `failed_imports`, `error_details`, `imported_by`, `imported_at`) VALUES
(1, '6838cd091aa11_1748552969.csv', 3, 0, 3, 'Row 2: Column count mismatch\nRow 3: Column count mismatch\nRow 4: Column count mismatch', 1, '2025-05-29 15:09:29'),
(2, 'Migori_Projects_Realistic.csv', 18, 9, 0, NULL, 1, '2025-07-09 11:52:25');

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `attempts` int NOT NULL,
  `last_attempt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `email`, `attempts`, `last_attempt`) VALUES
(1, 'omolloosoo1967@gmail.com', 5, '2025-07-12 05:39:08');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL,
  `admin_id` int NOT NULL,
  `token` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` timestamp NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT '0',
  `used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `admin_id`, `token`, `expires_at`, `used`, `used_at`, `created_at`) VALUES
(1, 2, 'c934df80b7238897c3fc7a972d56b2298097c3a6b4fdfe0343f24b794fd5e7b5', '2025-07-12 13:51:28', 1, '2025-07-12 10:01:46', '2025-07-12 09:51:28');

-- --------------------------------------------------------

--
-- Table structure for table `prepared_responses`
--

CREATE TABLE `prepared_responses` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `content` text COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci DEFAULT 'general',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `prepared_responses`
--

INSERT INTO `prepared_responses` (`id`, `name`, `content`, `category`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'Thank You', 'Thank you for your feedback. We appreciate your input and will review it carefully.', 'acknowledgment', 1, '2025-06-19 11:28:09', '2025-06-19 11:28:09'),
(2, 'Under Review', 'Your feedback is currently under review by our team. We will respond within 3-5 business days.', 'status', 1, '2025-06-19 11:28:09', '2025-06-19 11:28:09'),
(3, 'More Information Needed', 'Thank you for reaching out. To better assist you, could you please provide more specific details about your concern?', 'inquiry', 1, '2025-06-19 11:28:09', '2025-06-19 11:28:09'),
(4, 'Issue Resolved', 'Thank you for bringing this to our attention. The issue has been resolved and appropriate measures have been taken.', 'resolution', 1, '2025-06-19 11:28:09', '2025-06-19 11:28:09'),
(5, 'Project Progress Update', 'Thank you for your inquiry about the project progress. We are currently on track with our planned timeline and will provide regular updates as work continues.', 'progress', 1, '2025-06-19 11:28:09', '2025-06-19 11:28:09');

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int NOT NULL,
  `project_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `department_id` int NOT NULL,
  `project_year` int NOT NULL,
  `county_id` int NOT NULL,
  `sub_county_id` int NOT NULL,
  `ward_id` int NOT NULL,
  `location_address` text COLLATE utf8mb4_general_ci,
  `location_coordinates` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expected_completion_date` date DEFAULT NULL,
  `actual_completion_date` date DEFAULT NULL,
  `contractor_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contractor_contact` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('planning','ongoing','completed','suspended','cancelled') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'planning',
  `visibility` enum('private','published') COLLATE utf8mb4_general_ci DEFAULT 'private',
  `step_status` enum('awaiting','running','completed') COLLATE utf8mb4_general_ci DEFAULT 'awaiting',
  `progress_percentage` decimal(5,2) DEFAULT '0.00',
  `total_steps` int DEFAULT '0',
  `completed_steps` int DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `average_rating` decimal(3,2) DEFAULT '5.00',
  `total_ratings` int DEFAULT '0',
  `allocated_budget` decimal(15,2) DEFAULT '0.00',
  `spent_budget` decimal(15,2) DEFAULT '0.00',
  `budget_status` enum('not_allocated','allocated','overspent') COLLATE utf8mb4_general_ci DEFAULT 'not_allocated',
  `total_budget` decimal(15,2) DEFAULT NULL,
  `last_step_milestone` int DEFAULT '0',
  `last_financial_milestone` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `projects`
--

INSERT INTO `projects` (`id`, `project_name`, `description`, `department_id`, `project_year`, `county_id`, `sub_county_id`, `ward_id`, `location_address`, `location_coordinates`, `start_date`, `expected_completion_date`, `actual_completion_date`, `contractor_name`, `contractor_contact`, `status`, `visibility`, `step_status`, `progress_percentage`, `total_steps`, `completed_steps`, `created_by`, `created_at`, `updated_at`, `average_rating`, `total_ratings`, `allocated_budget`, `spent_budget`, `budget_status`, `total_budget`, `last_step_milestone`, `last_financial_milestone`) VALUES
(11, 'DEDE SCHOOL DORMITORY', 'To help in students accomodation during their stay in school, there should be increased accomodation facility.', 6, 2025, 1, 2, 8, 'dede centre', '-0.8097944788712975, 34.535521306125716', '2025-07-15', NULL, NULL, 'Unity Construction Ltd', '0700000000', 'ongoing', 'published', 'awaiting', 76.54, 4, 3, 1, '2025-07-09 07:33:19', '2025-07-09 08:57:55', 5.00, 0, 0.00, 0.00, 'not_allocated', 3580000.00, 0, 0),
(12, 'KARUNGU DAM PROJECT', 'To help curb drought amd minimize loss of plants and animal health, it vital to developm good solution to provide stable water to the neigborhood', 2, 2025, 1, 7, 29, 'gingo dam', '-0.8786266417248146, 34.254758011644995', '2025-07-10', NULL, NULL, 'Unity Construction Ltd', '0731920091', 'ongoing', 'published', 'awaiting', 67.53, 5, 3, 1, '2025-07-09 08:32:18', '2025-07-09 13:04:39', 5.00, 0, 0.00, 0.00, 'not_allocated', 2305700.00, 0, 0),
(13, 'Migori County Health Center Construction', 'Construction of a modern health center to serve the local community with medical facilities and equipment', 2, 2024, 1, 3, 11, 'Migori Town Center, near the main market', '-1.063583, 34.298915', '2499-11-30', NULL, NULL, 'ABC Construction Lt', '0702353585', 'ongoing', 'published', 'awaiting', 12.50, 6, 1, 1, '2025-07-09 11:52:25', '2025-07-09 13:02:05', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471274674.00, 0, 0),
(14, 'Migori-Isebania Road Improvement', 'Upgrading of 15km stretch of Migori-Isebania road with tarmac surface and proper drainage', 3, 2024, 1, 8, 35, 'Migori-Isebania Highway, Migori Town', '-0.835649, 34.189739', '1750-07-31', NULL, NULL, '', 'Kens Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 5.00, 0, 0.00, 0.00, 'not_allocated', 25476473647.00, 0, 0),
(15, 'Rongo Bus stage Upgrade', 'Construction of modern market stalls with proper sanitation and drainage facilities', 4, 2024, 1, 5, 18, 'Rongo Town Center', '-0.762871, 34.599666', '1199-11-30', NULL, NULL, '', 'Unity Builders', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 5.00, 0, 0.00, 0.00, 'not_allocated', 25478947485.00, 0, 0),
(16, 'Isibania Health Center Extension', 'Addition of maternity wing and medical equipment procurement', 2, 2024, 1, 2, 8, 'Nyatike Health Center', '-1.218048, 34.482936', '1499-11-30', NULL, NULL, '', 'Medical Contractors Kenya', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471252674.00, 0, 0),
(17, 'Lela Dispensary expansion', 'contruction of ward fercility', 8, 2025, 1, 2, 7, 'Oyani SDA', '-0.975707, 34.241237', '9699-11-30', NULL, NULL, '', 'ABC Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 5.00, 0, 0.00, 0.00, 'not_allocated', 25484648599.00, 0, 0),
(18, 'Lela market construction', 'kaminolewe market improvement to market standards', 7, 2026, 1, 3, 12, 'Kaminolewe market', '-0.941379, 34.432811', '1970-01-01', NULL, NULL, '', 'ABC Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 5.00, 0, 0.00, 0.00, 'not_allocated', 25473574848.00, 0, 0),
(19, 'Central Sakwa police post construction', 'Implementation of public service management and devolution in Central Sakwa ward under Awendo sub-county.', 13, 2024, 1, 2, 8, 'Central Sakwa Area, Awendo Sub-county', '-1.200886, 34.621639', '1970-01-01', NULL, NULL, '', 'Blue Economy Partners', 'ongoing', 'private', 'awaiting', 25.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 13:05:30', 5.00, 0, 0.00, 0.00, 'not_allocated', 25463848848.00, 0, 0),
(20, 'South Sakwa Lands, Project', 'Implementation of lands, housing, physical planning and urban development in South Sakwa ward under Awendo sub-county.', 4, 2023, 1, 1, 4, 'South Sakwa Area, Awendo Sub-county', '-0.904305, 34.528255', '2027-02-09', NULL, NULL, 'Unity Construction Ltd', '0731920094', 'ongoing', 'published', 'awaiting', 60.69, 4, 2, 1, '2025-07-09 11:52:25', '2025-07-11 21:29:28', 5.00, 0, 0.00, 0.00, 'not_allocated', 25475465154.00, 0, 0),
(21, 'North Kamagambo Public Project', 'Implementation of public service management and devolution in North Kamagambo ward under Rongo sub-county.', 9, 2025, 1, 3, 11, 'North Kamagambo Area, Rongo Sub-county', '-0.874096, 34.581813', '1399-11-30', NULL, NULL, '', 'EcoDev Works', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471163680.00, 0, 0),
(22, 'OCHOTO VILLAGE WATER PUMP', 'safe water for the people of ochoto village', 2, 2025, 1, 5, 20, 'ochoto village', '-0.7206644065329251, 34.40977270271737', NULL, NULL, NULL, 'seka contrating', '023589654345', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-09 14:34:43', '2025-07-09 14:35:35', 5.00, 0, 0.00, 0.00, 'not_allocated', 370000.00, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `project_documents`
--

CREATE TABLE `project_documents` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `document_type` enum('Project Approval Letter','Tender Notice','Signed Contract Agreement','Award Notification','Site Visit Report','Completion Certificate','Tender Opening Minutes','PMC Appointment Letter','Budget Approval Form','PMC Workplan','Supervision Report','Final Joint Inspection Report','Other') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Other',
  `document_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `original_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `document_status` enum('active','edited','deleted') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `version_number` int DEFAULT '1',
  `original_document_id` int DEFAULT NULL,
  `edit_reason` text COLLATE utf8mb4_general_ci,
  `deletion_reason` text COLLATE utf8mb4_general_ci,
  `modified_by` int DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT '1',
  `file_size` int DEFAULT '0',
  `mime_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_documents`
--

INSERT INTO `project_documents` (`id`, `project_id`, `document_type`, `document_title`, `filename`, `original_name`, `description`, `document_status`, `version_number`, `original_document_id`, `edit_reason`, `deletion_reason`, `modified_by`, `modified_at`, `is_public`, `file_size`, `mime_type`, `uploaded_by`, `created_at`) VALUES
(4, 11, 'Completion Certificate', 'certificate of comletion', 'doc_686e1d689cd424.12992647.pdf', 'Mepro solutions AMEP5736TFD.pdf', 'awarded certificate of comletion to the county board members', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 105720, 'application/pdf', 1, '2025-07-09 07:42:32'),
(5, 12, 'Project Approval Letter', 'APPROVAL LETTER', 'doc_686e3391c9e423.56249519.pdf', 'county_projects_2025-07-09_12-00-50.pdf', '', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 7085, 'text/html', 1, '2025-07-09 09:17:05'),
(6, 13, 'Project Approval Letter', 'Project Aproval Letter', 'doc_686e59e2a88357.28331284.pdf', 'MIGORI COUNTY HEALTH CENTER CONSTRACTION PAYMENT.pdf', '', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 37175, 'application/pdf', 1, '2025-07-09 12:00:34'),
(7, 20, 'PMC Workplan', 'PMS WORKMAN', 'doc_686e5afe7dd116.27718367.pdf', 'county_projects_2025-07-09_12-00-50.pdf', 'The approved workmanship letter', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 7085, 'text/html', 1, '2025-07-09 12:05:18'),
(8, 11, 'Other', 'Test A', 'doc_6871858e490db0.09437778.jpg', 'clintonelectricco-95136-bad-circuit-breaker-blogbanner1.jpg', '', 'deleted', 1, NULL, NULL, 'Deleted via document manager', 1, '2025-07-11 21:44:01', 1, 106039, 'image/jpeg', 1, '2025-07-11 21:43:42'),
(9, 11, 'Other', 'Test A', 'doc_6871858e490db0.09437778.jpg', 'clintonelectricco-95136-bad-circuit-breaker-blogbanner1.jpg', '', 'deleted', 1, 8, NULL, 'Deleted via document manager', 1, '2025-07-11 21:44:01', 1, 106039, 'image/jpeg', 1, '2025-07-11 21:43:42');

-- --------------------------------------------------------

--
-- Stand-in structure for view `project_financial_summary`
-- (See below for the actual view)
--
CREATE TABLE `project_financial_summary` (
`project_id` int
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
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `step_number` int NOT NULL,
  `step_name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `status` enum('pending','in_progress','completed','skipped') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `start_date` date DEFAULT NULL,
  `expected_end_date` date DEFAULT NULL,
  `actual_end_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_steps`
--

INSERT INTO `project_steps` (`id`, `project_id`, `step_number`, `step_name`, `description`, `status`, `start_date`, `expected_end_date`, `actual_end_date`, `created_at`, `updated_at`) VALUES
(19, 11, 2, 'Mapping of the project site', 'Geo location to map the land', 'completed', '2025-07-09', '2025-07-22', '2025-07-09', '2025-07-09 07:33:19', '2025-07-09 07:51:29'),
(20, 11, 3, 'land clearing', 'clearing land to enable the project start. getting rid of bushes and unncesesary structures', 'completed', '2025-07-09', '2025-08-01', '2025-07-09', '2025-07-09 07:33:19', '2025-07-09 07:51:52'),
(21, 11, 4, 'Project Planning and  Design', 'Effective project design and planning lead to better resource allocation, improved communication, and increased chances of project success', 'completed', NULL, '2025-08-04', '2025-07-09', '2025-07-09 07:33:53', '2025-07-09 08:51:08'),
(22, 11, 5, 'Infrastructure Development &amp; Renovation', 'planning, designing, constructing, and maintaining physical structures such as roads, bridges, airports, and public transportation systems', 'pending', NULL, '2025-08-20', NULL, '2025-07-09 07:34:19', '2025-07-09 07:38:22'),
(23, 12, 2, 'Project Planning &amp; Approval step', 'Initial project planning, design review, and regulatory approval process', 'completed', '2025-07-09', NULL, '2025-07-09', '2025-07-09 08:32:18', '2025-07-09 12:10:05'),
(24, 12, 3, 'contracting', 'This agreement defines the scope, timeline, budget, deliverables, and the roles and responsibilities of each party involved. It serves as a formal agreement to ensure all parties are aligned and to protect their interests throughout the project lifecycle', 'completed', '2025-07-09', NULL, '2025-07-09', '2025-07-09 08:32:18', '2025-07-09 09:26:39'),
(25, 12, 4, 'mapping and geo loation', 'determining the geographic location of , while mapping involves the creation and display of geographic information, often on a map', 'completed', '2025-07-09', NULL, '2025-07-09', '2025-07-09 08:32:18', '2025-07-09 12:09:36'),
(29, 12, 5, 'Regulatory Approvals &amp; Permits', 'construction, and maintenance of essential physical structures and systems that support economic growth and improve quality of life', 'in_progress', '2025-07-09', NULL, NULL, '2025-07-09 08:47:22', '2025-07-09 13:04:39'),
(30, 12, 6, 'Budgeting &amp; Resource Mobilization', 'creating a financial plan, allocating resources, and managing expenses, while resource mobilization focuses on securing new and additional financial, human, and material resources.', 'pending', NULL, NULL, NULL, '2025-07-09 08:48:15', '2025-07-09 08:48:15'),
(31, 13, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'completed', '2025-07-09', NULL, '2025-07-09', '2025-07-09 11:52:25', '2025-07-09 13:01:59'),
(32, 14, 1, 'Road Survey and Design', 'Conduct topographical survey and prepare detailed engineering designs', 'pending', NULL, NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 11:52:25'),
(33, 15, 1, 'Site Preparation', 'Clear site and prepare foundation for market construction', 'pending', NULL, NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 11:52:25'),
(34, 16, 1, 'Architectural Planning', 'Design maternity wing and plan equipment installation', 'pending', NULL, NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 11:52:25'),
(35, 17, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'pending', NULL, NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 11:52:25'),
(36, 18, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'pending', NULL, NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 11:52:25'),
(37, 19, 1, 'Design and Costing', 'Drafting architectural drawings and estimating costs.', 'in_progress', '2025-07-09', NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 13:05:30'),
(38, 20, 1, 'Land Survey', 'Carrying out land demarcation and topographical survey.', 'completed', '2025-07-09', NULL, '2025-07-09', '2025-07-09 11:52:25', '2025-07-09 14:03:07'),
(39, 21, 1, 'Feasibility Study', 'Conducting technical and social feasibility assessment.', 'pending', NULL, NULL, NULL, '2025-07-09 11:52:25', '2025-07-09 11:52:25'),
(40, 13, 2, 'Second step of this project goes here', 'a note about the second step:', 'in_progress', '2025-07-09', NULL, NULL, '2025-07-09 11:54:38', '2025-07-09 13:02:05'),
(41, 20, 2, 'Budgeting and  Resource Mobilization', 'component of financial and strategic planning, particularly important in organizations, governments, and development projects. Here&apos;s a concise overview of both terms and how they work together', 'completed', NULL, NULL, '2025-07-09', '2025-07-09 11:54:54', '2025-07-09 14:04:18'),
(42, 20, 3, 'Regulatory Approvals and Permits', 'These approvals ensure compliance with local, national, or international laws, promoting safety, environmental protection, and ethical standards.', 'in_progress', '2025-07-09', NULL, NULL, '2025-07-09 11:55:34', '2025-07-09 14:27:33'),
(43, 13, 3, 'Third step to be undertaken on this project ie. procurement processes', 'an informative/description of the steps expected activities', 'pending', NULL, NULL, NULL, '2025-07-09 11:55:45', '2025-07-09 11:55:45'),
(44, 13, 4, '4th step for this project', 'what happens in this step', 'pending', NULL, NULL, NULL, '2025-07-09 11:56:11', '2025-07-09 11:56:11'),
(45, 20, 4, 'Procurement of Contractors and Equipment', 'involves acquiring external services (contractors) and physical assets (equipment) necessary to complete a project or carry out organizational functions.', 'pending', NULL, NULL, NULL, '2025-07-09 11:56:15', '2025-07-09 14:03:55'),
(46, 13, 5, 'Joint inspection', 'what will happen during this step  here', 'pending', NULL, NULL, NULL, '2025-07-09 12:01:59', '2025-07-09 12:01:59'),
(47, 13, 6, 'commissioning', 'the final launch of the project', 'pending', NULL, NULL, NULL, '2025-07-09 12:02:26', '2025-07-09 12:02:26'),
(48, 22, 2, 'Project Planning & Approval', 'to enable accuracy of expenditure and strategic unit construction', 'pending', NULL, NULL, '2025-07-09', '2025-07-09 14:34:43', '2025-07-09 14:35:08');

-- --------------------------------------------------------

--
-- Table structure for table `project_subscriptions`
--

CREATE TABLE `project_subscriptions` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `subscription_token` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `email_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `subscribed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_notification_sent` timestamp NULL DEFAULT NULL,
  `unsubscribed_at` timestamp NULL DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_subscriptions`
--

INSERT INTO `project_subscriptions` (`id`, `project_id`, `email`, `subscription_token`, `is_active`, `email_verified`, `verification_token`, `subscribed_at`, `last_notification_sent`, `unsubscribed_at`, `ip_address`, `user_agent`) VALUES
(9, 11, 'stevekyle106@gmail.com', '44fd50fdd4d6105d32b961618de1a58578f17966366e70c3e4b95e903edf71cb', 1, 1, NULL, '2025-07-09 07:46:14', '2025-07-09 07:51:53', NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(10, 11, 'jjoyam976@gmail.com', 'fd91abb424fb7894dbe36036efdfac8ef508deb0c1d903355827047149270cf3', 1, 1, NULL, '2025-07-09 07:48:38', '2025-07-09 07:51:52', NULL, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36'),
(11, 12, 'achiengp888@gmail.com', '98cafc26556758d1d69bd74ec0711801857ea98b178f3028b79c1ca9ab82e952', 1, 0, '3aea416bbd758edfb1b2c393de280d7d495d0e097c918107fb44ffceda1922ce', '2025-07-09 09:18:49', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36'),
(12, 12, 'jatelolaktar@gmail.com', '256608327e6cd7cfcc94541ed9453e4754d5a4ed3b7ccb27546bc4a150524f51', 1, 1, NULL, '2025-07-09 09:20:48', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36'),
(13, 20, 'stevekyle106@gmail.com', 'c74c5c4f7431af0eb871a5e29c595d4817a7aa860157c5a2bbc186fe82b234e7', 1, 0, '46dc7be38a61d62ed516fab6cfe247906131d7bb55373886edc3b70ebb271c56', '2025-07-09 12:13:51', NULL, NULL, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36'),
(14, 20, 'fbhamisike@gmail.com', 'ebee2a07e5116c4b806452b25d50543863ba9dc9704e78392bd27302a6d65fed', 0, 1, NULL, '2025-07-09 13:05:58', '2025-07-09 14:04:19', '2025-07-09 14:04:47', '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36'),
(15, 20, 'suramb12@gmail.com', '997f80cae863ab1b06498a5a9b2278ed32822389af85350c38b4b83b5ffbfa94', 0, 1, NULL, '2025-07-09 13:53:04', '2025-07-09 13:56:27', '2025-07-09 13:57:46', '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36');

-- --------------------------------------------------------

--
-- Table structure for table `project_transactions`
--

CREATE TABLE `project_transactions` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `transaction_type` enum('budget_increase','expenditure','disbursement','adjustment') COLLATE utf8mb4_general_ci NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `description` text COLLATE utf8mb4_general_ci NOT NULL,
  `transaction_date` date NOT NULL,
  `reference_number` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_path` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `document_type` enum('invoice','receipt','voucher','other') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fund_source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'County Development Fund',
  `funding_category` enum('development','recurrent','emergency','donor','other') COLLATE utf8mb4_general_ci DEFAULT 'development',
  `disbursement_method` enum('cheque','bank_transfer','mobile_money','cash') COLLATE utf8mb4_general_ci DEFAULT 'bank_transfer',
  `voucher_number` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `approval_status` enum('pending','approved','rejected') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `approved_by` int DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `payment_status` enum('pending','processed','completed','failed') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `transaction_status` enum('active','edited','deleted','reversed') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `original_transaction_id` int DEFAULT NULL,
  `edit_reason` text COLLATE utf8mb4_general_ci,
  `deletion_reason` text COLLATE utf8mb4_general_ci,
  `modified_by` int DEFAULT NULL,
  `modified_at` timestamp NULL DEFAULT NULL,
  `receipt_number` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bank_receipt_reference` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_transactions`
--

INSERT INTO `project_transactions` (`id`, `project_id`, `transaction_type`, `amount`, `description`, `transaction_date`, `reference_number`, `document_path`, `document_type`, `created_by`, `created_at`, `updated_at`, `fund_source`, `funding_category`, `disbursement_method`, `voucher_number`, `approval_status`, `approved_by`, `approved_at`, `payment_status`, `transaction_status`, `original_transaction_id`, `edit_reason`, `deletion_reason`, `modified_by`, `modified_at`, `receipt_number`, `bank_receipt_reference`) VALUES
(21, 11, 'disbursement', 2907543.00, 'DEPOSIT TO THE PROJECT ACCOUNT', '2025-07-09', 'RYEDDKJU7', NULL, NULL, 1, '2025-07-09 08:53:23', '2025-07-09 08:53:23', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '7908', 'E9748DHL'),
(22, 11, 'expenditure', 2795379.00, 'MONEY DISBURSED TO THE CONTRACTOR', '2025-07-09', '098643E', NULL, NULL, 1, '2025-07-09 08:56:26', '2025-07-09 08:57:55', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, 1, '2025-07-09 08:57:55', '896GFS', '09IHG'),
(23, 11, 'expenditure', 2795379.00, 'MONEY DISBURSED TO THE CONTRACTOPR', '2025-07-09', '098643E', NULL, NULL, 1, '2025-07-09 08:56:26', '2025-07-09 08:57:55', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'edited', 22, 'MONEY DEPOSITED TO THE CONTRATOR', NULL, 1, '2025-07-09 08:57:55', '896GFS', '09IHG'),
(24, 12, 'disbursement', 1500000.00, 'FIRST BATCH DISBURSMENT', '2025-07-09', '87YUTH', NULL, NULL, 1, '2025-07-09 09:23:23', '2025-07-09 09:23:23', 'County Development Fund', 'development', 'bank_transfer', '7493YJJ', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', 'IEUYEUDH'),
(25, 12, 'expenditure', 1500000.00, 'EXPENDITURE', '2025-07-09', '73038YT', NULL, NULL, 1, '2025-07-09 09:24:53', '2025-07-09 09:24:53', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(26, 20, 'disbursement', 20000000000.00, 'First Disbursement', '2025-07-09', 'GSTE567', NULL, NULL, 1, '2025-07-09 13:54:32', '2025-07-09 13:54:32', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', ''),
(27, 20, 'expenditure', 15000000000.00, 'Payment for the contructor', '2025-07-09', 'GSTE53D', NULL, NULL, 1, '2025-07-09 13:56:27', '2025-07-09 13:56:27', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `project_transaction_documents`
--

CREATE TABLE `project_transaction_documents` (
  `id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `file_path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `original_filename` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `file_size` int DEFAULT '0',
  `mime_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_transaction_documents`
--

INSERT INTO `project_transaction_documents` (`id`, `transaction_id`, `file_path`, `original_filename`, `file_size`, `mime_type`, `uploaded_by`, `created_at`) VALUES
(19, 21, 'doc_686e2e030d1b63.01384286.docx', 'velocraft technologies A08HKDT4BXC.docx', 110643, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 1, '2025-07-09 08:53:23'),
(20, 22, 'doc_686e2ebaeecb77.20238598.pdf', 'ADLIFE GROUP.pdf', 122601, 'application/pdf', 1, '2025-07-09 08:56:26'),
(21, 24, 'doc_686e350b417c92.72471201.pdf', 'Mepro solutions AMEP5736TFD.pdf', 105720, 'application/pdf', 1, '2025-07-09 09:23:23'),
(22, 25, 'doc_686e356599ae31.97620123.pdf', 'Mepro solutions AMEP5736TFD.pdf', 105720, 'application/pdf', 1, '2025-07-09 09:24:53'),
(23, 26, 'doc_686e74988694e1.97883580.pdf', 'MIGORI COUNTY HEALTH CENTER CONSTRACTION DISBURSEMENT.pdf', 37343, 'application/pdf', 1, '2025-07-09 13:54:32'),
(24, 27, 'doc_686e750bc92c19.95758451.pdf', 'MIGORI COUNTY HEALTH CENTER CONSTRACTION PAYMENT.pdf', 37175, 'application/pdf', 1, '2025-07-09 13:56:27');

-- --------------------------------------------------------

--
-- Table structure for table `publication_logs`
--

CREATE TABLE `publication_logs` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `admin_id` int NOT NULL,
  `attempt_date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  `errors` text COLLATE utf8mb4_general_ci,
  `ip_address` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publication_logs`
--

INSERT INTO `publication_logs` (`id`, `project_id`, `admin_id`, `attempt_date`, `success`, `errors`, `ip_address`) VALUES
(6, 11, 1, '2025-07-09 07:43:09', 1, '[]', '196.96.237.220'),
(7, 11, 1, '2025-07-09 08:51:29', 1, '[]', '102.0.11.44'),
(8, 12, 1, '2025-07-09 09:17:22', 1, '[]', '102.0.11.44'),
(9, 13, 1, '2025-07-09 12:02:33', 1, '[]', '102.0.11.44'),
(10, 20, 1, '2025-07-09 12:07:16', 1, '[]', '102.0.11.44'),
(11, 20, 1, '2025-07-09 12:12:46', 1, '[]', '102.0.11.44'),
(12, 20, 1, '2025-07-09 14:51:56', 1, '[]', '102.0.11.44');

-- --------------------------------------------------------

--
-- Table structure for table `security_logs`
--

CREATE TABLE `security_logs` (
  `id` int NOT NULL,
  `event_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_id` int DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `security_logs`
--

INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(271, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752046400}', '2025-07-09 07:33:20'),
(272, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11&created=1\",\"method\":\"POST\",\"timestamp\":1752046433}', '2025-07-09 07:33:53'),
(273, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11&created=1\",\"method\":\"POST\",\"timestamp\":1752046459}', '2025-07-09 07:34:19'),
(274, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11&created=1\",\"method\":\"POST\",\"timestamp\":1752046473}', '2025-07-09 07:34:33'),
(275, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11&created=1\",\"method\":\"GET\",\"timestamp\":1752046495}', '2025-07-09 07:34:55'),
(276, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752046505}', '2025-07-09 07:35:05'),
(277, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752046607}', '2025-07-09 07:36:47'),
(278, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752046652}', '2025-07-09 07:37:32'),
(279, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752046702}', '2025-07-09 07:38:22'),
(280, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/editProject.php?id=11\",\"method\":\"GET\",\"timestamp\":1752046744}', '2025-07-09 07:39:04'),
(281, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php?search=&project_id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752046811}', '2025-07-09 07:40:11'),
(282, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php?search=&project_id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php?search=&project_id=11\",\"method\":\"POST\",\"timestamp\":1752046952}', '2025-07-09 07:42:32'),
(283, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php?search=&project_id=11\",\"method\":\"GET\",\"timestamp\":1752046970}', '2025-07-09 07:42:50'),
(284, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752046975}', '2025-07-09 07:42:55'),
(285, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752046989}', '2025-07-09 07:43:09'),
(286, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752047064}', '2025-07-09 07:44:24'),
(287, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752047091}', '2025-07-09 07:44:51'),
(288, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752047091}', '2025-07-09 07:44:51'),
(289, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752047092}', '2025-07-09 07:44:52'),
(290, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752047379}', '2025-07-09 07:49:39'),
(291, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752047384}', '2025-07-09 07:49:44'),
(292, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752047388}', '2025-07-09 07:49:48'),
(293, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752047405}', '2025-07-09 07:50:05'),
(294, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752047416}', '2025-07-09 07:50:16'),
(295, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752047425}', '2025-07-09 07:50:25'),
(296, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752047489}', '2025-07-09 07:51:29'),
(297, 'page_access', 1, '196.96.237.220', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752047512}', '2025-07-09 07:51:52'),
(298, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752049039}', '2025-07-09 08:17:19'),
(299, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752049045}', '2025-07-09 08:17:25'),
(300, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752049052}', '2025-07-09 08:17:32'),
(301, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752049065}', '2025-07-09 08:17:45'),
(302, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752049088}', '2025-07-09 08:18:08'),
(303, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752049116}', '2025-07-09 08:18:36'),
(304, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752049116}', '2025-07-09 08:18:36'),
(305, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752049117}', '2025-07-09 08:18:37'),
(306, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752049155}', '2025-07-09 08:19:15'),
(307, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752049200}', '2025-07-09 08:20:00'),
(308, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"activityLogs.php\",\"url\":\"\\/admin\\/activityLogs.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752049239}', '2025-07-09 08:20:39'),
(309, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1752049373}', '2025-07-09 08:22:53'),
(310, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752049938}', '2025-07-09 08:32:18'),
(311, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752049976}', '2025-07-09 08:32:56'),
(312, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752049994}', '2025-07-09 08:33:14'),
(313, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752050007}', '2025-07-09 08:33:27'),
(314, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752050026}', '2025-07-09 08:33:46'),
(315, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752050043}', '2025-07-09 08:34:03'),
(316, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752050842}', '2025-07-09 08:47:22'),
(317, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752050895}', '2025-07-09 08:48:15'),
(318, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752050911}', '2025-07-09 08:48:31'),
(319, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"POST\",\"timestamp\":1752050921}', '2025-07-09 08:48:41'),
(320, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752050938}', '2025-07-09 08:48:58'),
(321, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752050950}', '2025-07-09 08:49:10'),
(322, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752050951}', '2025-07-09 08:49:11'),
(323, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752051024}', '2025-07-09 08:50:24'),
(324, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752051036}', '2025-07-09 08:50:36'),
(325, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752051049}', '2025-07-09 08:50:49'),
(326, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752051068}', '2025-07-09 08:51:08'),
(327, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=11\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=11\",\"method\":\"POST\",\"timestamp\":1752051089}', '2025-07-09 08:51:29'),
(328, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12&created=1\",\"method\":\"GET\",\"timestamp\":1752051232}', '2025-07-09 08:53:52'),
(329, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752051536}', '2025-07-09 08:58:56'),
(330, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752051541}', '2025-07-09 08:59:01'),
(331, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752051579}', '2025-07-09 08:59:39'),
(332, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1752051691}', '2025-07-09 09:01:31'),
(333, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752051751}', '2025-07-09 09:02:31'),
(334, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"POST\",\"timestamp\":1752051758}', '2025-07-09 09:02:38'),
(335, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"POST\",\"timestamp\":1752051765}', '2025-07-09 09:02:45'),
(336, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752051882}', '2025-07-09 09:04:42'),
(337, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752052533}', '2025-07-09 09:15:33'),
(338, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752052540}', '2025-07-09 09:15:40'),
(339, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"GET\",\"timestamp\":1752052557}', '2025-07-09 09:15:57'),
(340, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"POST\",\"timestamp\":1752052625}', '2025-07-09 09:17:05'),
(341, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752052632}', '2025-07-09 09:17:12'),
(342, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752052636}', '2025-07-09 09:17:16'),
(343, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752052642}', '2025-07-09 09:17:22'),
(344, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752053178}', '2025-07-09 09:26:18'),
(345, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752053182}', '2025-07-09 09:26:22'),
(346, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752053189}', '2025-07-09 09:26:29'),
(347, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752053199}', '2025-07-09 09:26:39'),
(348, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752061770}', '2025-07-09 11:49:30'),
(349, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752061911}', '2025-07-09 11:51:51'),
(350, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752061924}', '2025-07-09 11:52:04'),
(351, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752061954}', '2025-07-09 11:52:34'),
(352, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752061961}', '2025-07-09 11:52:41'),
(353, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752061978}', '2025-07-09 11:52:58'),
(354, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/editProject.php?id=13\",\"method\":\"GET\",\"timestamp\":1752061991}', '2025-07-09 11:53:11'),
(355, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752062014}', '2025-07-09 11:53:34'),
(356, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"POST\",\"timestamp\":1752062017}', '2025-07-09 11:53:37'),
(357, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062043}', '2025-07-09 11:54:03'),
(358, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"method\":\"POST\",\"timestamp\":1752062078}', '2025-07-09 11:54:38'),
(359, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062094}', '2025-07-09 11:54:54'),
(360, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062134}', '2025-07-09 11:55:34'),
(361, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"method\":\"POST\",\"timestamp\":1752062145}', '2025-07-09 11:55:45'),
(362, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"method\":\"POST\",\"timestamp\":1752062171}', '2025-07-09 11:56:11'),
(363, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062175}', '2025-07-09 11:56:15'),
(364, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752062193}', '2025-07-09 11:56:33'),
(365, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13&success=Project+updated+successfully\",\"method\":\"GET\",\"timestamp\":1752062218}', '2025-07-09 11:56:58'),
(366, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752062262}', '2025-07-09 11:57:42'),
(367, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062269}', '2025-07-09 11:57:49'),
(368, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"POST\",\"timestamp\":1752062434}', '2025-07-09 12:00:34'),
(369, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752062454}', '2025-07-09 12:00:54'),
(370, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062464}', '2025-07-09 12:01:04'),
(371, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752062470}', '2025-07-09 12:01:10'),
(372, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752062519}', '2025-07-09 12:01:59'),
(373, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752062546}', '2025-07-09 12:02:26'),
(374, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752062553}', '2025-07-09 12:02:33'),
(375, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062588}', '2025-07-09 12:03:08'),
(376, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/editProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752062623}', '2025-07-09 12:03:43'),
(377, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20&success=Project+updated+successfully\",\"method\":\"GET\",\"timestamp\":1752062656}', '2025-07-09 12:04:16'),
(378, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/editProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752062665}', '2025-07-09 12:04:25'),
(379, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20&success=Project+updated+successfully\",\"method\":\"GET\",\"timestamp\":1752062672}', '2025-07-09 12:04:32'),
(380, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"POST\",\"timestamp\":1752062718}', '2025-07-09 12:05:18'),
(381, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752062725}', '2025-07-09 12:05:25'),
(382, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062729}', '2025-07-09 12:05:29'),
(383, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062747}', '2025-07-09 12:05:47'),
(384, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062766}', '2025-07-09 12:06:06'),
(385, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062827}', '2025-07-09 12:07:07'),
(386, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062836}', '2025-07-09 12:07:16'),
(387, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752062925}', '2025-07-09 12:08:45'),
(388, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"GET\",\"timestamp\":1752062941}', '2025-07-09 12:09:01'),
(389, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752062949}', '2025-07-09 12:09:09'),
(390, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752062958}', '2025-07-09 12:09:18'),
(391, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752062976}', '2025-07-09 12:09:36'),
(392, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/editProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752063003}', '2025-07-09 12:10:03'),
(393, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752063005}', '2025-07-09 12:10:05'),
(394, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"GET\",\"timestamp\":1752063010}', '2025-07-09 12:10:10'),
(395, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752063019}', '2025-07-09 12:10:19'),
(396, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752063030}', '2025-07-09 12:10:30'),
(397, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752063152}', '2025-07-09 12:12:32'),
(398, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752063158}', '2025-07-09 12:12:38'),
(399, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752063166}', '2025-07-09 12:12:46'),
(400, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752063458}', '2025-07-09 12:17:38');
INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(401, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752063592}', '2025-07-09 12:19:52'),
(402, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752064348}', '2025-07-09 12:32:28'),
(403, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752066111}', '2025-07-09 13:01:51'),
(404, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752066114}', '2025-07-09 13:01:54'),
(405, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752066119}', '2025-07-09 13:01:59'),
(406, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"POST\",\"timestamp\":1752066125}', '2025-07-09 13:02:05'),
(407, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"systemSettings.php\",\"url\":\"\\/admin\\/systemSettings.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=13\",\"method\":\"GET\",\"timestamp\":1752066261}', '2025-07-09 13:04:21'),
(408, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752066263}', '2025-07-09 13:04:23'),
(409, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752066272}', '2025-07-09 13:04:32'),
(410, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=12\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"POST\",\"timestamp\":1752066279}', '2025-07-09 13:04:39'),
(411, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=12\",\"method\":\"GET\",\"timestamp\":1752066305}', '2025-07-09 13:05:05'),
(412, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=19\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752066310}', '2025-07-09 13:05:10'),
(413, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=19\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=19\",\"method\":\"POST\",\"timestamp\":1752066315}', '2025-07-09 13:05:15'),
(414, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752066326}', '2025-07-09 13:05:26'),
(415, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=19\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=19\",\"method\":\"POST\",\"timestamp\":1752066330}', '2025-07-09 13:05:30'),
(416, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=19\",\"method\":\"GET\",\"timestamp\":1752066648}', '2025-07-09 13:10:48'),
(417, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752066658}', '2025-07-09 13:10:58'),
(418, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752066665}', '2025-07-09 13:11:05'),
(419, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752067246}', '2025-07-09 13:20:46'),
(420, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752068835}', '2025-07-09 13:47:15'),
(421, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752069128}', '2025-07-09 13:52:08'),
(422, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752069203}', '2025-07-09 13:53:23'),
(423, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752069224}', '2025-07-09 13:53:44'),
(424, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752069635}', '2025-07-09 14:00:35'),
(425, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"POST\",\"timestamp\":1752069641}', '2025-07-09 14:00:41'),
(426, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752069780}', '2025-07-09 14:03:00'),
(427, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752069787}', '2025-07-09 14:03:07'),
(428, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752069808}', '2025-07-09 14:03:28'),
(429, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752069835}', '2025-07-09 14:03:55'),
(430, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752069858}', '2025-07-09 14:04:18'),
(431, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752069944}', '2025-07-09 14:05:44'),
(432, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752070522}', '2025-07-09 14:15:22'),
(433, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"activityLogs.php\",\"url\":\"\\/admin\\/activityLogs.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752070580}', '2025-07-09 14:16:20'),
(434, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1752070606}', '2025-07-09 14:16:46'),
(435, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752070628}', '2025-07-09 14:17:08'),
(436, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1752070637}', '2025-07-09 14:17:17'),
(437, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1752070642}', '2025-07-09 14:17:22'),
(438, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752070661}', '2025-07-09 14:17:41'),
(439, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752070662}', '2025-07-09 14:17:42'),
(440, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752070683}', '2025-07-09 14:18:03'),
(441, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752070683}', '2025-07-09 14:18:03'),
(442, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752070764}', '2025-07-09 14:19:24'),
(443, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"POST\",\"timestamp\":1752070768}', '2025-07-09 14:19:28'),
(444, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"POST\",\"timestamp\":1752070778}', '2025-07-09 14:19:38'),
(445, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752070860}', '2025-07-09 14:21:00'),
(446, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752070875}', '2025-07-09 14:21:15'),
(447, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=sakwa&status=&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&visibility=\",\"method\":\"GET\",\"timestamp\":1752070886}', '2025-07-09 14:21:26'),
(448, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=uriri&status=&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=sakwa&status=&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752070906}', '2025-07-09 14:21:46'),
(449, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=uriri&status=&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752070915}', '2025-07-09 14:21:55'),
(450, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752070918}', '2025-07-09 14:21:58'),
(451, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752070925}', '2025-07-09 14:22:05'),
(452, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752070937}', '2025-07-09 14:22:17'),
(453, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752070945}', '2025-07-09 14:22:25'),
(454, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071172}', '2025-07-09 14:26:12'),
(455, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071196}', '2025-07-09 14:26:36'),
(456, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752071200}', '2025-07-09 14:26:40'),
(457, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071203}', '2025-07-09 14:26:43'),
(458, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752071206}', '2025-07-09 14:26:46'),
(459, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071209}', '2025-07-09 14:26:49'),
(460, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752071219}', '2025-07-09 14:26:59'),
(461, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071224}', '2025-07-09 14:27:04'),
(462, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752071243}', '2025-07-09 14:27:23'),
(463, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752071253}', '2025-07-09 14:27:33'),
(464, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752071260}', '2025-07-09 14:27:40'),
(465, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=19\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071276}', '2025-07-09 14:27:56'),
(466, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=19\",\"method\":\"GET\",\"timestamp\":1752071284}', '2025-07-09 14:28:04'),
(467, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=r&status=&sub_county=4&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071304}', '2025-07-09 14:28:24'),
(468, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=r&status=&sub_county=2&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=r&status=&sub_county=4&visibility=\",\"method\":\"GET\",\"timestamp\":1752071315}', '2025-07-09 14:28:35'),
(469, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=r&status=&sub_county=2&visibility=\",\"method\":\"GET\",\"timestamp\":1752071352}', '2025-07-09 14:29:12'),
(470, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071367}', '2025-07-09 14:29:27'),
(471, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752071389}', '2025-07-09 14:29:49'),
(472, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071393}', '2025-07-09 14:29:53'),
(473, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752071511}', '2025-07-09 14:31:51'),
(474, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=21\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071524}', '2025-07-09 14:32:04'),
(475, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752071540}', '2025-07-09 14:32:20'),
(476, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752071542}', '2025-07-09 14:32:22'),
(477, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752071543}', '2025-07-09 14:32:23'),
(478, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"dashboard.php\",\"url\":\"\\/admin\\/dashboard.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752071546}', '2025-07-09 14:32:26'),
(479, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"systemSettings.php\",\"url\":\"\\/admin\\/systemSettings.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/dashboard.php\",\"method\":\"GET\",\"timestamp\":1752071558}', '2025-07-09 14:32:38'),
(480, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752071560}', '2025-07-09 14:32:40'),
(481, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=22&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752071683}', '2025-07-09 14:34:43'),
(482, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=22&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=22&created=1\",\"method\":\"POST\",\"timestamp\":1752071696}', '2025-07-09 14:34:56'),
(483, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=22&created=1\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=22&created=1\",\"method\":\"POST\",\"timestamp\":1752071708}', '2025-07-09 14:35:08'),
(484, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=22&success=Project+updated+successfully\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/editProject.php?id=22\",\"method\":\"GET\",\"timestamp\":1752071735}', '2025-07-09 14:35:35'),
(485, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=22&success=Project+updated+successfully\",\"method\":\"GET\",\"timestamp\":1752071738}', '2025-07-09 14:35:38'),
(486, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752072075}', '2025-07-09 14:41:15'),
(487, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752072148}', '2025-07-09 14:42:28'),
(488, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752072162}', '2025-07-09 14:42:42'),
(489, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/admin\\/commentFiltering.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1752072237}', '2025-07-09 14:43:57'),
(490, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752072616}', '2025-07-09 14:50:16'),
(491, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1752072661}', '2025-07-09 14:51:01'),
(492, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752072664}', '2025-07-09 14:51:04'),
(493, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752072682}', '2025-07-09 14:51:22'),
(494, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752072690}', '2025-07-09 14:51:30'),
(495, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752072716}', '2025-07-09 14:51:56'),
(496, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752072762}', '2025-07-09 14:52:42'),
(497, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752072795}', '2025-07-09 14:53:15'),
(498, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752072966}', '2025-07-09 14:56:06'),
(499, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/admin\\/commentFiltering.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752072981}', '2025-07-09 14:56:21'),
(500, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/commentFiltering.php\",\"method\":\"GET\",\"timestamp\":1752072987}', '2025-07-09 14:56:27'),
(501, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php?search=&status=pending&project_id=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752073007}', '2025-07-09 14:56:47'),
(502, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php?search=&status=pending&project_id=\",\"method\":\"POST\",\"timestamp\":1752073015}', '2025-07-09 14:56:55'),
(503, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php?search=&status=pending&project_id=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php?search=&status=pending&project_id=\",\"method\":\"GET\",\"timestamp\":1752073016}', '2025-07-09 14:56:56'),
(504, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752141814}', '2025-07-10 10:03:34'),
(505, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752141964}', '2025-07-10 10:06:04'),
(506, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"activityLogs.php\",\"url\":\"\\/admin\\/activityLogs.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752156023}', '2025-07-10 14:00:23'),
(507, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752173654}', '2025-07-10 18:54:14'),
(508, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752253270}', '2025-07-11 17:01:10'),
(509, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php?search=&status=rejected&project_id=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752253290}', '2025-07-11 17:01:30'),
(510, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php?search=&status=&project_id=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php?search=&status=rejected&project_id=\",\"method\":\"GET\",\"timestamp\":1752253315}', '2025-07-11 17:01:55'),
(511, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php?search=&status=&project_id=\",\"method\":\"GET\",\"timestamp\":1752253329}', '2025-07-11 17:02:09'),
(512, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752253342}', '2025-07-11 17:02:22'),
(513, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"dashboard.php\",\"url\":\"\\/admin\\/dashboard.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752253355}', '2025-07-11 17:02:35'),
(514, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/dashboard.php\",\"method\":\"GET\",\"timestamp\":1752253369}', '2025-07-11 17:02:49'),
(515, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752253419}', '2025-07-11 17:03:39'),
(516, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Mobile Safari/537.36', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/admin\\/commentFiltering.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752253446}', '2025-07-11 17:04:06'),
(517, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=22\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752268832}', '2025-07-11 21:20:32'),
(518, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=13\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752268873}', '2025-07-11 21:21:13'),
(519, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752268931}', '2025-07-11 21:22:11'),
(520, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752269000}', '2025-07-11 21:23:20'),
(521, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752269155}', '2025-07-11 21:25:55'),
(522, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752269196}', '2025-07-11 21:26:36'),
(523, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php?error=Invalid+security+token\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752269275}', '2025-07-11 21:27:55'),
(524, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php?error=Invalid+security+token\",\"method\":\"GET\",\"timestamp\":1752269290}', '2025-07-11 21:28:10'),
(525, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752269308}', '2025-07-11 21:28:28'),
(526, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752269347}', '2025-07-11 21:29:07'),
(527, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"manageProject.php\",\"url\":\"\\/admin\\/manageProject.php?id=20\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"POST\",\"timestamp\":1752269368}', '2025-07-11 21:29:28'),
(528, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/manageProject.php?id=20\",\"method\":\"GET\",\"timestamp\":1752269399}', '2025-07-11 21:29:59'),
(529, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=planning&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752269408}', '2025-07-11 21:30:08'),
(530, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=cancelled&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=planning&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269417}', '2025-07-11 21:30:17'),
(531, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=suspended&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=cancelled&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269423}', '2025-07-11 21:30:23');
INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(532, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=completed&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=suspended&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269429}', '2025-07-11 21:30:29'),
(533, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=ongoing&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=completed&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269433}', '2025-07-11 21:30:33'),
(534, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=planning&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=ongoing&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269440}', '2025-07-11 21:30:40'),
(535, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=planning&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269448}', '2025-07-11 21:30:48'),
(536, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=5&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269451}', '2025-07-11 21:30:51'),
(537, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=4&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=5&visibility=\",\"method\":\"GET\",\"timestamp\":1752269456}', '2025-07-11 21:30:56'),
(538, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=3&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=4&visibility=\",\"method\":\"GET\",\"timestamp\":1752269460}', '2025-07-11 21:31:00'),
(539, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=1&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=3&visibility=\",\"method\":\"GET\",\"timestamp\":1752269464}', '2025-07-11 21:31:04'),
(540, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=7&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=1&visibility=\",\"method\":\"GET\",\"timestamp\":1752269470}', '2025-07-11 21:31:10'),
(541, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=8&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=7&visibility=\",\"method\":\"GET\",\"timestamp\":1752269475}', '2025-07-11 21:31:15'),
(542, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=6&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=8&visibility=\",\"method\":\"GET\",\"timestamp\":1752269479}', '2025-07-11 21:31:19'),
(543, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=&visibility=\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=6&visibility=\",\"method\":\"GET\",\"timestamp\":1752269486}', '2025-07-11 21:31:26'),
(544, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=&sub_county=&visibility=published\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=&visibility=\",\"method\":\"GET\",\"timestamp\":1752269492}', '2025-07-11 21:31:32'),
(545, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php?search=&status=ongoing&sub_county=&visibility=published\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/projects.php?search=&status=&sub_county=&visibility=published\",\"method\":\"GET\",\"timestamp\":1752269749}', '2025-07-11 21:35:49'),
(546, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752269885}', '2025-07-11 21:38:05'),
(547, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1752270149}', '2025-07-11 21:42:29'),
(548, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"POST\",\"timestamp\":1752270222}', '2025-07-11 21:43:42'),
(549, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"POST\",\"timestamp\":1752270241}', '2025-07-11 21:44:01'),
(550, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752270251}', '2025-07-11 21:44:11'),
(551, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/admin\\/commentFiltering.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752270254}', '2025-07-11 21:44:14'),
(552, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"rolesPermissions.php\",\"url\":\"\\/admin\\/rolesPermissions.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752270341}', '2025-07-11 21:45:41'),
(553, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"activityLogs.php\",\"url\":\"\\/admin\\/activityLogs.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752270358}', '2025-07-11 21:45:58'),
(554, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"activityLogs.php\",\"url\":\"\\/admin\\/activityLogs.php?page=8\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1752270377}', '2025-07-11 21:46:17'),
(555, 'page_access', 1, '217.199.146.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"systemSettings.php\",\"url\":\"\\/admin\\/systemSettings.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/activityLogs.php?page=8\",\"method\":\"GET\",\"timestamp\":1752270391}', '2025-07-11 21:46:31'),
(556, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752314579}', '2025-07-12 10:02:59'),
(557, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752314599}', '2025-07-12 10:03:19'),
(558, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"pmcReports.php\",\"url\":\"\\/admin\\/pmcReports.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752314648}', '2025-07-12 10:04:08'),
(559, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1752314679}', '2025-07-12 10:04:39'),
(560, 'undefined_page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"csv_import\",\"url\":\"\\/admin\\/importCsv.php\"}', '2025-07-12 10:04:39'),
(561, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"importCsv.php\",\"url\":\"\\/admin\\/importCsv.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752314685}', '2025-07-12 10:04:45'),
(562, 'undefined_page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"csv_import\",\"url\":\"\\/admin\\/importCsv.php\"}', '2025-07-12 10:04:45'),
(563, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752314687}', '2025-07-12 10:04:47'),
(564, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"projects.php\",\"url\":\"\\/admin\\/projects.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752314689}', '2025-07-12 10:04:49'),
(565, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"documentManager.php\",\"url\":\"\\/admin\\/documentManager.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752314695}', '2025-07-12 10:04:55'),
(566, 'page_access', 2, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"createProject.php\",\"url\":\"\\/admin\\/createProject.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752314711}', '2025-07-12 10:05:11'),
(567, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"feedback.php\",\"url\":\"\\/admin\\/feedback.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752314766}', '2025-07-12 10:06:06'),
(568, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"rolesPermissions.php\",\"url\":\"\\/admin\\/rolesPermissions.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752314831}', '2025-07-12 10:07:11'),
(569, 'page_access', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"page\":\"rolesPermissions.php\",\"url\":\"\\/admin\\/rolesPermissions.php\",\"referrer\":\"https:\\/\\/shop.lakeside.co.ke\\/admin\\/rolesPermissions.php\",\"method\":\"POST\",\"timestamp\":1752314877}', '2025-07-12 10:07:57'),
(570, 'permissions_updated', 1, '102.0.11.44', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', '{\"target_admin\":\"4\",\"final_permissions\":[\"dashboard_access\"],\"permissions_added\":[\"dashboard_access\"],\"permissions_removed\":[],\"total_permissions\":1}', '2025-07-12 10:07:57');

-- --------------------------------------------------------

--
-- Table structure for table `sub_counties`
--

CREATE TABLE `sub_counties` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `county_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_counties`
--

INSERT INTO `sub_counties` (`id`, `name`, `county_id`, `created_at`) VALUES
(1, 'Rongo', 1, '2025-06-21 06:39:15'),
(2, 'Awendo', 1, '2025-06-21 06:39:15'),
(3, 'Suna East', 1, '2025-06-21 06:39:15'),
(4, 'Suna West', 1, '2025-06-21 06:39:15'),
(5, 'Uriri', 1, '2025-06-21 06:39:15'),
(6, 'Kuria East', 1, '2025-06-21 06:39:15'),
(7, 'Nyatike', 1, '2025-06-21 06:39:15'),
(8, 'Kuria West', 1, '2025-06-21 06:39:15');

-- --------------------------------------------------------

--
-- Table structure for table `total_budget`
--

CREATE TABLE `total_budget` (
  `id` int NOT NULL,
  `project_id` int NOT NULL,
  `budget_amount` decimal(15,2) NOT NULL DEFAULT '0.00',
  `budget_type` enum('initial','revised','supplementary') COLLATE utf8mb4_general_ci DEFAULT 'initial',
  `budget_source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fiscal_year` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `approval_status` enum('pending','approved','rejected','under_review') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `approved_by` int DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_comments` text COLLATE utf8mb4_general_ci,
  `budget_breakdown` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `supporting_documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '1',
  `previous_version_id` int DEFAULT NULL,
  `fund_source` varchar(255) COLLATE utf8mb4_general_ci DEFAULT 'County Development Fund',
  `funding_category` enum('development','recurrent','emergency','donor') COLLATE utf8mb4_general_ci DEFAULT 'development',
  `disbursement_schedule` text COLLATE utf8mb4_general_ci,
  `allocated_amount` decimal(15,2) DEFAULT '0.00',
  `disbursed_amount` decimal(15,2) DEFAULT '0.00',
  `remaining_amount` decimal(15,2) DEFAULT '0.00',
  `budget_notes` text COLLATE utf8mb4_general_ci,
  `financial_year` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `budget_line_item` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `funding_agency` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `disbursement_conditions` text COLLATE utf8mb4_general_ci
) ;

--
-- Dumping data for table `total_budget`
--

INSERT INTO `total_budget` (`id`, `project_id`, `budget_amount`, `budget_type`, `budget_source`, `fiscal_year`, `approval_status`, `approved_by`, `approved_at`, `approval_comments`, `budget_breakdown`, `supporting_documents`, `created_by`, `created_at`, `updated_at`, `is_active`, `version`, `previous_version_id`, `fund_source`, `funding_category`, `disbursement_schedule`, `allocated_amount`, `disbursed_amount`, `remaining_amount`, `budget_notes`, `financial_year`, `budget_line_item`, `funding_agency`, `disbursement_conditions`) VALUES
(11, 11, 3580000.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 07:33:19', '2025-07-09 07:33:19', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(12, 12, 2305700.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 08:32:18', '2025-07-09 08:32:18', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(13, 13, 25471274674.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(14, 14, 25476473647.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(15, 15, 25478947485.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(16, 16, 25471252674.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(17, 17, 25484648599.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(18, 18, 25473574848.00, 'initial', 'County Development Fund', '2026/2027', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(19, 19, 25463848848.00, 'initial', 'County Development Fund', '2024/2025', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(20, 20, 25475465154.00, 'initial', 'County Development Fund', '2023/2024', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(21, 21, 25471163680.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 11:52:25', '2025-07-09 11:52:25', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL),
(22, 22, 370000.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-09 14:34:43', '2025-07-09 14:34:43', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_types`
--

CREATE TABLE `transaction_types` (
  `id` int NOT NULL,
  `type_code` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `display_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `affects_budget` tinyint(1) DEFAULT '0',
  `affects_expenditure` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_types`
--

INSERT INTO `transaction_types` (`id`, `type_code`, `display_name`, `description`, `affects_budget`, `affects_expenditure`, `is_active`, `created_at`) VALUES
(1, 'budget_increase', 'Additional Budget Increase', 'Increases the approved budget amount for the project', 1, 0, 1, '2025-07-05 06:34:28'),
(2, 'disbursement', 'Disbursement to Project Account', 'Money transferred to project account from county funds', 0, 0, 1, '2025-07-05 06:34:28'),
(3, 'expenditure', 'Project Expenditure', 'Money spent from project account for project activities', 0, 1, 1, '2025-07-05 06:34:28'),
(4, 'adjustment', 'Budget Adjustment', 'Miscellaneous budget adjustments', 0, 0, 1, '2025-07-05 06:34:28');

-- --------------------------------------------------------

--
-- Table structure for table `wards`
--

CREATE TABLE `wards` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `sub_county_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wards`
--

INSERT INTO `wards` (`id`, `name`, `sub_county_id`, `created_at`) VALUES
(1, 'North Kamagambo', 1, '2025-06-21 06:39:15'),
(2, 'Central Kamagambo', 1, '2025-06-21 06:39:15'),
(3, 'East Kamagambo', 1, '2025-06-21 06:39:15'),
(4, 'South Kamagambo', 1, '2025-06-21 06:39:15'),
(5, 'North East Sakwa', 2, '2025-06-21 06:39:15'),
(6, 'South Sakwa', 2, '2025-06-21 06:39:15'),
(7, 'West Sakwa', 2, '2025-06-21 06:39:15'),
(8, 'Central Sakwa', 2, '2025-06-21 06:39:15'),
(9, 'God Jope', 3, '2025-06-21 06:39:15'),
(10, 'Suna Central', 3, '2025-06-21 06:39:15'),
(11, 'Kakrao', 3, '2025-06-21 06:39:15'),
(12, 'Kwa', 3, '2025-06-21 06:39:15'),
(13, 'Wiga', 4, '2025-06-21 06:39:15'),
(14, 'Wasweta II', 4, '2025-06-21 06:39:15'),
(15, 'Ragana-Oruba', 4, '2025-06-21 06:39:15'),
(16, 'Wasimbete', 4, '2025-06-21 06:39:15'),
(17, 'West Kanyamkago', 5, '2025-06-21 06:39:15'),
(18, 'North Kanyamkago', 5, '2025-06-21 06:39:15'),
(19, 'Central Kanyamkago', 5, '2025-06-21 06:39:15'),
(20, 'South Kanyamkago', 5, '2025-06-21 06:39:15'),
(21, 'East Kanyamkago', 5, '2025-06-21 06:39:15'),
(22, 'Gokeharaka/Getamwega', 6, '2025-06-21 06:39:15'),
(23, 'Ntimaru West', 6, '2025-06-21 06:39:15'),
(24, 'Ntimaru East', 6, '2025-06-21 06:39:15'),
(25, 'Nyabasi East', 6, '2025-06-21 06:39:15'),
(26, 'Nyabasi West', 6, '2025-06-21 06:39:15'),
(27, 'Kachieng', 7, '2025-06-21 06:39:15'),
(28, 'Kanyasa', 7, '2025-06-21 06:39:15'),
(29, 'North Kadem', 7, '2025-06-21 06:39:15'),
(30, 'Macalder/Kanyarwanda', 7, '2025-06-21 06:39:15'),
(31, 'Kaler', 7, '2025-06-21 06:39:15'),
(32, 'Got Kachola', 7, '2025-06-21 06:39:15'),
(33, 'Muhuru', 7, '2025-06-21 06:39:15'),
(34, 'Bukira East', 8, '2025-06-21 06:39:15'),
(35, 'Bukira Central/Ikerege', 8, '2025-06-21 06:39:15'),
(36, 'Isibania', 8, '2025-06-21 06:39:15'),
(37, 'Makerero', 8, '2025-06-21 06:39:15'),
(38, 'Masaba', 8, '2025-06-21 06:39:15'),
(39, 'Tagare', 8, '2025-06-21 06:39:15'),
(40, 'Nyamosense/Komosoko', 8, '2025-06-21 06:39:15');

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
  ADD KEY `idx_admins_active_verified` (`is_active`,`email_verified`);

--
-- Indexes for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_activity_type` (`activity_type`),
  ADD KEY `idx_target` (`target_type`,`target_id`),
  ADD KEY `idx_created_at` (`created_at`);

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
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

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
-- Indexes for table `fund_sources`
--
ALTER TABLE `fund_sources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `source_name` (`source_name`),
  ADD UNIQUE KEY `source_code` (`source_code`);

--
-- Indexes for table `import_logs`
--
ALTER TABLE `import_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `imported_by` (`imported_by`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`email`);

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
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `idx_verification_token` (`verification_token`);

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
-- Indexes for table `sub_counties`
--
ALTER TABLE `sub_counties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `county_id` (`county_id`);

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
-- Indexes for table `transaction_types`
--
ALTER TABLE `transaction_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type_code` (`type_code`);

--
-- Indexes for table `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_county_id` (`sub_county_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_activation_tokens`
--
ALTER TABLE `account_activation_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_permissions`
--
ALTER TABLE `admin_permissions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `budget_allocations`
--
ALTER TABLE `budget_allocations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `counties`
--
ALTER TABLE `counties`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fund_sources`
--
ALTER TABLE `fund_sources`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `import_logs`
--
ALTER TABLE `import_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prepared_responses`
--
ALTER TABLE `prepared_responses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `project_documents`
--
ALTER TABLE `project_documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `project_steps`
--
ALTER TABLE `project_steps`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `project_subscriptions`
--
ALTER TABLE `project_subscriptions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `project_transactions`
--
ALTER TABLE `project_transactions`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `project_transaction_documents`
--
ALTER TABLE `project_transaction_documents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `publication_logs`
--
ALTER TABLE `publication_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `security_logs`
--
ALTER TABLE `security_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `total_budget`
--
ALTER TABLE `total_budget`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_types`
--
ALTER TABLE `transaction_types`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- --------------------------------------------------------

--
-- Structure for view `project_financial_summary`
--
DROP TABLE IF EXISTS `project_financial_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`lakeside`@`localhost` SQL SECURITY DEFINER VIEW `project_financial_summary`  AS SELECT `p`.`id` AS `project_id`, `p`.`project_name` AS `project_name`, `p`.`total_budget` AS `approved_budget`, coalesce(sum((case when ((`pt`.`transaction_type` = 'budget_increase') and (`pt`.`transaction_status` = 'active')) then `pt`.`amount` else 0 end)),0) AS `budget_increases`, coalesce(sum((case when ((`pt`.`transaction_type` = 'disbursement') and (`pt`.`transaction_status` = 'active')) then `pt`.`amount` else 0 end)),0) AS `total_disbursed`, coalesce(sum((case when ((`pt`.`transaction_type` = 'expenditure') and (`pt`.`transaction_status` = 'active')) then `pt`.`amount` else 0 end)),0) AS `total_spent`, (`p`.`total_budget` + coalesce(sum((case when ((`pt`.`transaction_type` = 'budget_increase') and (`pt`.`transaction_status` = 'active')) then `pt`.`amount` else 0 end)),0)) AS `total_allocated`, (coalesce(sum((case when ((`pt`.`transaction_type` = 'disbursement') and (`pt`.`transaction_status` = 'active')) then `pt`.`amount` else 0 end)),0) - coalesce(sum((case when ((`pt`.`transaction_type` = 'expenditure') and (`pt`.`transaction_status` = 'active')) then `pt`.`amount` else 0 end)),0)) AS `remaining_balance` FROM (`projects` `p` left join `project_transactions` `pt` on((`p`.`id` = `pt`.`project_id`))) GROUP BY `p`.`id`, `p`.`project_name`, `p`.`total_budget` ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_activation_tokens`
--
ALTER TABLE `account_activation_tokens`
  ADD CONSTRAINT `account_activation_tokens_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

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
-- Constraints for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD CONSTRAINT `password_reset_tokens_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE CASCADE;

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
-- Constraints for table `total_budget`
--
ALTER TABLE `total_budget`
  ADD CONSTRAINT `fk_total_budget_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_total_budget_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_total_budget_previous_version` FOREIGN KEY (`previous_version_id`) REFERENCES `total_budget` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_total_budget_project` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
