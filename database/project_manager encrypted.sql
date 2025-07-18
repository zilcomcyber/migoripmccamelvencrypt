-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 14, 2025 at 02:53 PM
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

--
-- Dumping data for table `account_activation_tokens`
--

INSERT INTO `account_activation_tokens` (`id`, `admin_id`, `token`, `expires_at`, `used`, `used_at`, `created_at`) VALUES
(1, 5, '49dabbf37022b3d144a53aac90eaa7618c9eaba4e39527c1e2f022cbcf5701f2', '2025-07-14 23:40:26', 0, NULL, '2025-07-13 23:40:26'),
(2, 6, '4d3e47e492a51d072dd84fc55e0d1686610c7f6fa9766b759ff3149b73ed6005', '2025-07-15 02:00:57', 0, NULL, '2025-07-14 02:00:57');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
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

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `password_hash`, `role`, `is_active`, `email_verified`, `created_at`, `created_by`, `updated_at`, `modified_by`, `modified_at`, `last_login`, `last_ip`, `permissions`, `two_factor_secret`, `last_password_change`, `password_reset_token`, `token_expires`) VALUES
(1, 'KOAxf0ejDA+vTVGEf7wd0AEmoF6ZhgPy1AxYFlpqoMmB4U50bvbJpzU=', 'zvSdtXCPU5xswPuSA8Ewy++s9GCg30pfahNXj84gE2co25u0iQsTOqncOQU=', '$argon2id$v=19$m=65536,t=4,p=1$Qm82Z0ltS3VveTcxVzl0Wg$K7VZMwiZmUSlev7Hezyp7kYkWDBOz4B21nBqfOVaUUY', 'super_admin', 1, 1, '2025-05-29 15:20:11', NULL, '2025-07-14 12:51:59', NULL, NULL, '2025-07-14 12:22:45', 'B3YvfExlwHum3JnCXKBbeDr3pOlmgTWoJ4sAqX8S8w==', NULL, NULL, NULL, NULL, NULL),
(5, 'xJ375+gOV/F//jovzKRGkTxKePqUdBb8LsWVRP3zAommFYCMt9kiCw==', '+6WD+eoVycgE3B1vgwqXtrlIqjmATkMzYYKn3v3XG/tHDfTn8Qo5b3h1pn1Ggmlx5w==', '$2y$10$BLrN..ymlFwfByf0xJ0TxOu0dDnUeiU/0/wEk/vVlZ8e9sNfpT5a2', 'admin', 0, 0, '2025-07-13 23:40:26', NULL, '2025-07-14 12:51:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'QSIRckTmDaNy538LuTvG7YhUY/MTMl6HcVbT3eZLIA+DeO/pYyGg34QG', 'EyGft7940cFd6oU79f8yvKc6Xh2SDi4xo0PVA9r1H/9mCKhZGrVmf/Oaf6RIDMk=', '$2y$10$rWfZ.5AaxZj3ZB/g5jPdCe4k0YPH1/VL0ggS61RNW0J/rZmFJ1Ade', 'admin', 0, 0, '2025-07-14 02:00:57', NULL, '2025-07-14 12:51:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_activity_log`
--

INSERT INTO `admin_activity_log` (`id`, `admin_id`, `activity_type`, `activity_description`, `target_type`, `target_id`, `ip_address`, `user_agent`, `additional_data`, `created_at`) VALUES
(1, 1, 'activity_logs_access', 'Viewed activity logs page', 'general', NULL, 'Bq4ekXpg9wjaL4M1aMHy6JGOqqjwlspshASKVEx+pQ==', 'y4gpb/uNOxvYsrhywQLPad5mIwIfrO9yCMtQ2t/5D28iVmu6yX6qW9Denys6XCoQ1XN7O7AuJvv5FqTSGeOaIJcCrIdPs6C0nIAFNwD+g8UW0jTgq356lJ8MEy7lWiiG3XP5Q8wgzvytShGbOCDxi7TJwzos5tbOSpq7KVwXghwqVrzDc2jt3WMKag==', NULL, '2025-07-14 03:28:39'),
(2, 1, 'activity_logs_access', 'Viewed activity logs page', 'general', NULL, 'rwiA/qQfIjDLVPjFQsw7Ad0dTsaTyCQ4WIfY/2UpPg==', 'n08HoC4TYSmjcKJWcQNK5CuIO9jL8bp2cxP3uOfsHbagylkwKN2xM3UElK9pDQU2miNqaqU6oDBHgKqWIAw8/fF8uvQKOXT2+OJNkb90iiKd9jRBQE5lHCXYeduFsT8y6Dha6BW1Ghh0rPHlv7GAraA0Swo7mRfKZXP8+kAiQDJSXn7b+h6BUnHTRw==', NULL, '2025-07-14 03:31:16'),
(3, 1, 'activity_logs_access', 'Viewed activity logs page', 'general', NULL, 'eUGVhAeIWdW98UCOvky7OtqLCtOU0ANb3ZdYkcBncg==', '/E5yAp9/3C8tLe/8f7j/Y+YZ6+9srLHW5fE4hpq7+ZHgfls7ooMmyfmJrpoBa7r9sZnBKhboAFEHSp2N3MQf6cEFWQ3A6pA+glma8Ej9cvYST5DBnuUW20FZC9ISOwAguUWuHEo9U/bU8v7VAPyt9zrFWaqzluLHNRaj9UcHfM3GkysLqTvu4BLWUw==', NULL, '2025-07-14 03:32:57'),
(4, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', 'general', NULL, 'UtAPV77j0CkpRL1/W/H+IwMzfV2nhbICs2r/DR4H4A==', 'gq3d4STXi3y+UhC7eJgL2hMMeAiyttG770Hf6ZobfsFC3NvSF7hoXW0gdhaX1jPZtI5cur3P8rBjrz47s6+OD20SGdlkOO+YfmbcyJCyKiJBNrX/5nxbdU/M5l110TbthVG/0t5CGc84gi5q7uf7xf4VlEET8mCkevNGp8dKpGJjRr2A/Zxi1LGlaA==', NULL, '2025-07-14 07:02:58'),
(5, 1, 'dashboard_access', 'Accessed PMC analytics dashboard', 'general', NULL, '3QPGzKlw+Pmqgb90eEeTPZFjOTaU/oUbecuXwDI5AQ==', 'xp6BWaTmSLICvLSifgE53jtBfyytE6xsol9fJ8CkX1NLyjzQhuj/b6dcN9YQeXQF6TnsKvJ7mllnm3uocaG0rXmOnFAL2N0GacjZOEdnXtAuwYcDvg7uercCSLqTILhoiC+PIqI61SZmYBUthNanOurMerMi8U4pvo0CqP6Lp0I0iCOVQcpXPyuvFw==', NULL, '2025-07-14 07:05:58'),
(6, 1, 'word_list_updated', 'Updated banned and flagged words list', 'general', NULL, 'LPgXZsGwtT9aPE9/U3FUCtajbTqpSXnEaxNsj2FMSw==', 'wXD5887f7zC9lxa2cy4bltrajjKLC2yepMzcq9+XU66OjhEpfOJZ0Jf/xNPRJUC2a+tVJ3WALElYCXHUQnmS4H8FDiYdZEhAc12w4mCeso8J7fjtIPvug6fWqrE81z6JEfJM+ZRMFrqt5Zurcd6UbDWQvUQjwD8u0CqT0cvDqUXqkRY9yTYV4W7OFg==', NULL, '2025-07-14 07:20:21'),
(7, 1, 'activity_logs_access', 'Viewed activity logs page', 'general', NULL, 'NwEKNT7fANqFl35SuZS8QwsM/T2l+mtsW4RlN2VPZw==', 'ilcmg7TfqWB22kuBNDYmgD+UZeiI87AQrsakgWorgeJPfm1rFtQy5MtMgVvG8Ei/ahwQ+C9lHtFu1uz8gF9EhspsQkurBudPgd5YhdmH96NvemO11zz3hwuQkfQH/puMlDb19oO6MKsgBydboCOz6F9Nomh1O2uHO7WNHVVONcV7gGOZhDwga5Yagg==', NULL, '2025-07-14 07:24:25'),
(8, 1, 'admin_dashboard_access', 'Accessed main admin dashboard', 'general', NULL, 'bRQinbbWjvx/bmo/HHpxX0SafdXNzIXUQJc7shf51Q==', 'XN0ksmLgCHWHWSgwMFncwikA6IbcF7mdNwrOHM6RC8OEp2XJ/NWP1uAkh7iX4ttshj9sW18ZyBAFeFgVjGspzvYRjjxmJgA4r50mFBJAfj4SSoE3LiOtVLcOo26x81BplG/6gDHExFcBtcvuUVbtYmJIeOIZK59PrLqWnG1EtRlv49d3e2FBsDnVoQ==', NULL, '2025-07-14 07:26:22'),
(9, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, 'pXMbRgKMhaTpQNpB2EtC/8hRumqPnZhY4s3IH918XA==', 'u6KLR+wsVa/o2qOw+yceEV1nPqX6qBvpzuPWmVdbd5vz/RKvUhXhV9qH0n9xgV8+dFpFq9gj70CFG6jo9xxrQtVteST8VMokiT3AS/NuVcjBtsMILSthAAgQoURQQ9AdXVAL2jobBP8EK54ovcA8rXov+msIc2Qezma1vjS/IHBBxntUGnfmKwkHyA==', NULL, '2025-07-14 08:06:09'),
(10, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, 'JowCZGYD3m00v2CLeDxSlBNHqKlB/9c7A4RljaApMQ==', '5xScHhTN5JNGWVvsYGrJpe6opWCxGqFTKwLzV4GZ9qsIA3GIEJWoxSjbquFP6ZnmJ0Wm09YZj4Dile2j3tFz4HKJidWdWXaxENmu9W79BmPgyK1qjuEK6jxlPGnu7GpimmsLkKZRBRk8V2HLaaqsGPGDyQulWEFp7RXwDq33AJ/0aRu21r0cezv2+g==', NULL, '2025-07-14 08:06:46'),
(11, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, '/0yfpjAafUrW9Q4EZJRb3Xz/3ItkLAlXFpADPDjb9w==', 'JZoH5M9F3m4k79poNnjcRrsSFcAL4xZZk8GhcMdMz8pj1MxFT5xNXyUMbl+lbsxAN1iKca6kUiZY+HVWDx1NREUNuS0GNSjcO4mk+fwlQo3Odr3dGQJLRXHl5TX6D0GedcOBNEg55Iz8GEHqkn7c1xIFULrHGa/4JvLGLOIioZRFF8oGVke//aqJqA==', NULL, '2025-07-14 08:07:28'),
(12, 1, 'grievance_responded', 'Responded to grievance #17 for project: Migori-Isebania Road Improvement', 'general', NULL, '3lF5UTtiJuhEfSBlE4cS29IVf5k5b/qX5Xt0PNDTZQ==', '8RolpbnhxPKaNk0Rfvqf6Fs3a2gq3SVE2PcEMkU1mkTGkvPplkeCrxtAlkemPQKRVdql9URb59WmM1h6TzvlM+QBD7faO99e5wuFcSkDG7OH5cOCOxi5FzYQRm34aZ9LZ6y3pQ3a+8mVIHs8f6T5fpkkxh3bOfDekmWxwV7/xTzlQSmub8bwTPgnag==', NULL, '2025-07-14 08:07:28'),
(13, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, 'LMlm3jjeG3u5tpTpBVjX2NHjDLopxqEMH9y0i1PLNA==', 'pc1LAmsUhxH/Dpk6DxOmMHp2SoSu2g3I//K4XUvRmK8/ESzS9sTzp+SH8a02XDS+JH3i31hVPJ8mZqjGQFqmB+lgO0zIMw8uA2aissq8GwSDBSfQTViStf6z9kkKmh8uw5QhqR/AkN5ziAIidl9Y3j7I8ti5ghkP8CJzM+2/G92vyD3xDgF6qH+dMA==', NULL, '2025-07-14 08:14:45'),
(14, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, 'VxoLiIf4+SLcgNVjrWilpQ7qK71pGvrn2EegjoNQPg==', '/o3Ie/kP4RrZOAxjNUNjgzilfXl9X4FR9DFosI+4YJKmgym+UVY6zVqCqoO6JZUJyiiSagttKXTwA/IqzJ4YkURmFYva//mO40kdFWNTuV+Sdv80OUrV8doe8GlNltKDbqfoGJKnEFD1WxfWpiXXbBftV4flxBZM8buK6b/vvq2NZeQZfLREi0tnlA==', NULL, '2025-07-14 08:18:17'),
(15, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, 'YHc8G4nfiRK0VjDg/wtSEurV2hq+nAasoseFy1m+nA==', 'rc+w3YOjICDo/0PcoeR/ncOkuOMCqpsFtb60Z6ADr60rGpkeS9h3buuAqA5SaTClTievvRJvzF0gQ6hoJqQMfDzjmkUE7OwYKgZ0zCWGunc26OXMEHVhZvh2VweKPvx8Q6QvvzXzXyh9xPG8Q6DHrtWEPIBCSPx9EdyIkrk+Xh6pN6dR3VWbd8UXMA==', NULL, '2025-07-14 08:18:18'),
(16, 1, 'grievances_access', 'Accessed grievance management page', 'general', NULL, '9Z9/2ZecYdz9o5cvITKT92ozgClqhTha3eNBGxBRqQ==', 'GoDYl0cfDKFtgqnlbS6e80vhI9nENzcZp29y4rDJYf/6S7IBBjlcFxXAHSJt29T543meFTMttLfdQT4SRa3gCrO8Y1CcrmMQZsgAeN1wfv/kJog1IRDxjjrsz5gwA22r3XquaV09th+edHYJorHkvKDXTjFsz4auHDTHGvwZi15VL71dVxQCGRA8ow==', NULL, '2025-07-14 08:20:04');

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
-- Table structure for table `cbs`
--

CREATE TABLE `cbs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chart_of_accounts`
--

CREATE TABLE `chart_of_accounts` (
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

--
-- Dumping data for table `chart_of_accounts`
--

INSERT INTO `chart_of_accounts` (`id`, `account_code`, `account_name`, `account_type`, `account_subtype`, `parent_account_id`, `is_active`, `description`, `created_at`) VALUES
(1, '1000', 'Assets', 'asset', NULL, NULL, 1, 'All asset accounts', '2025-07-14 11:52:38'),
(2, '1100', 'Current Assets', 'asset', NULL, NULL, 1, 'Short-term assets', '2025-07-14 11:52:38'),
(3, '1110', 'Cash and Cash Equivalents', 'asset', NULL, NULL, 1, 'Cash, bank accounts, and short-term investments', '2025-07-14 11:52:38'),
(4, '1120', 'Accounts Receivable', 'asset', NULL, NULL, 1, 'Money owed to the county', '2025-07-14 11:52:38'),
(5, '1200', 'Fixed Assets', 'asset', NULL, NULL, 1, 'Long-term physical assets', '2025-07-14 11:52:38'),
(6, '2000', 'Liabilities', 'liability', NULL, NULL, 1, 'All liability accounts', '2025-07-14 11:52:38'),
(7, '2100', 'Current Liabilities', 'liability', NULL, NULL, 1, 'Short-term obligations', '2025-07-14 11:52:38'),
(8, '2110', 'Accounts Payable', 'liability', NULL, NULL, 1, 'Money owed by the county', '2025-07-14 11:52:38'),
(9, '3000', 'Equity', 'equity', NULL, NULL, 1, 'County fund balance', '2025-07-14 11:52:38'),
(10, '4000', 'Revenue', 'income', NULL, NULL, 1, 'Government allocations and grants', '2025-07-14 11:52:38'),
(11, '4100', 'National Government Allocation', 'income', NULL, NULL, 1, 'Funds from national government', '2025-07-14 11:52:38'),
(12, '4200', 'Donor Funding', 'income', NULL, NULL, 1, 'External donor contributions', '2025-07-14 11:52:38'),
(13, '5000', 'Expenses', 'expense', NULL, NULL, 1, 'All expenditure accounts', '2025-07-14 11:52:38'),
(14, '5100', 'Project Expenses', 'expense', NULL, NULL, 1, 'Direct project implementation costs', '2025-07-14 11:52:38'),
(15, '5200', 'Administrative Expenses', 'expense', NULL, NULL, 1, 'General administrative costs', '2025-07-14 11:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `cost_breakdown_structure`
--

CREATE TABLE `cost_breakdown_structure` (
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

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `project_id`, `citizen_name`, `citizen_email`, `citizen_phone`, `subject`, `message`, `status`, `priority`, `sentiment`, `parent_comment_id`, `user_ip`, `user_agent`, `filtering_metadata`, `admin_response`, `responded_by`, `responded_at`, `moderated_by`, `moderated_at`, `internal_notes`, `is_featured`, `engagement_score`, `response_time_hours`, `follow_up_required`, `tags`, `attachments`, `created_at`, `updated_at`, `visitor_id`, `grievance_status`, `resolved_by`, `resolution_notes`, `resolved_at`) VALUES
(1, 1, 'hamisi william', NULL, NULL, 'Project Comment', 'kazi safi sanana tuna matumaini kwamba italeta mabadiliko makubwa sana katika kaonti letu', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-07 18:28:58', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(2, 1, 'steve odoyo', NULL, NULL, 'Project Comment', 'Nimependa maoni yako', 'approved', 'medium', 'neutral', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-07 18:29:44', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(3, 1, 'willy', NULL, NULL, 'Project Comment', 'Ambia raila na handshake lake wakwende na huyo ruto kasongo must go!!', 'responded', 'medium', 'neutral', 0, NULL, NULL, NULL, 'Thank you for your feedback. We appreciate your input and will review it carefully.', 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-07 18:30:52', '2025-07-13 23:08:08', NULL, 'open', NULL, NULL, NULL),
(5, 2, 'steve odoyo', NULL, NULL, 'Project Comment', 'dholuo bende nyaka watemnrego', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-08 09:51:57', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(7, 1, 'kenya', NULL, NULL, 'Project Comment', 'raila ruto what was that for', 'approved', 'medium', 'neutral', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-12 15:29:46', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(8, 2, 'hamisi william', NULL, NULL, 'Project Comment', 'this is the test comment', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-12 15:50:16', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(9, 2, 'hamisi william', NULL, NULL, 'Project Comment', 'this is the test comment raila', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-12 15:50:40', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(10, 2, 'hamisi william', NULL, NULL, 'Project Comment', 'magi onge kumadhie', 'approved', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-12 15:51:21', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(11, 2, 'hamisi', NULL, NULL, 'Project Comment', 'raila ruto this is not bad', 'pending', 'medium', 'neutral', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-12 17:24:34', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(12, 2, 'hamisi william', NULL, NULL, 'Project Comment', 'this is the last reply', 'approved', 'medium', 'neutral', 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-12 17:41:49', '2025-07-14 01:49:04', NULL, 'open', NULL, NULL, NULL),
(13, 2, 'hamisi william', 'mJY2gGTbQ5oa1/jGlPyyYqOx76QKkvU3KKzjf4AhXNFu2ItzfWytfIflr+vj7A8vesOwZA7i', NULL, 'Project Feedback', 'testing comment, email to be encrypted', 'pending', 'medium', 'neutral', NULL, 'k6x2y25eG3q2lcraghg/Uh9D5U1OfomVpOf8oqrGPg==', 'RmRPCC8VsG4Qbp4utr1Q26/S56qrK8UvoVu1sWxYeCh4oQZ4RWUDgfM2eEwTtjtF5A256UJ7AulSJWBnWI/9INhO+pEIP7MoQuKH3taGXy9LK4LV82nEVEg7ASgHLb95PLdNab32WS8hHYYoxvTRKP/A+DarlwcjrOyzkUG//nmfY/hwta96l5VvKw==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-14 02:56:03', '2025-07-14 12:51:59', NULL, 'open', NULL, NULL, NULL),
(14, 2, 'hamisi william', '8pm36wi+0nBAV8eTMVjNCKFFjGSBucqhOYez3Iu/XtasMR08kgIzYZuUXpN3rn+n84EKXx9k', NULL, 'Project Feedback', 'testing encryption here', 'pending', 'medium', 'neutral', NULL, 'r7qfap6zNjuMrb/pCRcX8dxo1QiMzvvaAcYBKgN5VQ==', 'rXVdSOhzzQn1XW/5FENYdhMkv1PQvFgegPah1QSHVFctL2Q7r0raUTj7hgo8jUz5DGwj/Nu8adlxOcQ8o33J3zqf+r1NNvpce04jEmDFr0r65nx2E/YYltdg9sZK5BRnReWfKkw37xcWbpmFf2CAQNgNipOsPOqOuSUttCiI2lP5hQA0IIC5tKRPLg==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-14 02:56:48', '2025-07-14 12:51:59', NULL, 'open', NULL, NULL, NULL),
(15, 2, 'name', 'bfp7qassiKd2+7Ex8ElXFYhS7jS6NCAb077+5q/AjCnrJP+40nfp8ckF7My8+RaV6HqTn19j', NULL, 'Project Feedback', 'check for ruto raila shit', 'grievance', 'medium', 'neutral', NULL, 'mlHLT8P6YMHqALz9xWB9Dp2hMPO3BSQpeyah3o0Lkg==', 'ZQYuBcqGOsa60PswBFLMcEJgCZYNaBGBhYslebRHtoEOqmxHQb86DlTpP/P9yOQm2vdnH0B+JaJ3D4bJj2AkT3rpiqnw56nqHg+dqYVfEMIAxdLykoEqCwHuRXCEzyBPS13POofncPcGegJF+XUi6/kP6YcKkZhbSfVnb3JSVefKtIYe79d0yjt8BA==', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-14 02:59:24', '2025-07-14 12:51:59', NULL, 'open', NULL, NULL, NULL),
(16, 2, 'hamisi', 'OJAnH+QL1UZIDRQS+g7HKk3bCbsgAc5M/R5rVvkdpps4FSrPzrVVw35vXvcNgVdCqT2T7efa', NULL, 'Project Feedback', 'too many subscription requests', 'approved', 'medium', 'neutral', NULL, 'PH7dffHkMZbG7pniWZilqUIjtyHl5ja1B/p08yVGpQ==', 'EjXWAxoQjAKjqZlOR8s6n0W3qjo+WC/vrmr5veXd8QyKJJS4RW5IkVsqw8rxDvIV7J016T3qEys5ljhvz+zOURa1t1rv9m8fm+jqocF7IJ4v4HrrmEDDiB2y6QRK3kfzmzPLw+v0C5QXzcAqee2ts9RbXcyE7xaqAUUY4DphmNzm6MgancbT6Z1LMw==', '{\"detected_language\":\"en\",\"reason\":\"clean_content\"}', NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-14 03:15:52', '2025-07-14 12:51:59', NULL, 'open', NULL, NULL, NULL),
(17, 2, 'hamisi', 'tnTcFGZPe0j5B9KKfzP2/9RrEb31Y4kaWNpBPycgwRSu2Rh1KJIKraOARyCkvNBM+8xDZ83v', NULL, 'Project Feedback', 'raila asipo enda', 'responded', 'medium', 'neutral', NULL, 'WD46/HAywlq6XT3qy/hNjb4I9ewhV/UlcYYAaVxBkg==', '/8WQAZ31oryCahrm5Gz8X/Yy+OB85gfxqc/2LxNG+2N8LkM/egVS3/FZkHXDlSCm9h8BYzn6qTdPEpTp7isM++Duys7en2ggfTwEzsRNSTyglikgZoFgEg/+mW8xCS0VJanzUcLuq/M8vsMkfvMnQK+7mlD9JGnSxpTEeZJzvZEryeh6oxcFEK6HOw==', '{\"reason\":\"flagged_words\",\"flagged_words_found\":[\"raila\"]}', 'this response will be sent to the user mail', 1, NULL, NULL, NULL, NULL, 0, 0, NULL, 0, NULL, NULL, '2025-07-14 03:17:38', '2025-07-14 12:51:59', NULL, 'open', NULL, NULL, NULL);

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

--
-- Dumping data for table `import_logs`
--

INSERT INTO `import_logs` (`id`, `filename`, `total_rows`, `successful_imports`, `failed_imports`, `error_details`, `imported_by`, `imported_at`, `updated_at`, `modified_by`, `modified_at`) VALUES
(1, '6838cd091aa11_1748552969.csv', 3, 0, 3, 'Row 2: Column count mismatch\nRow 3: Column count mismatch\nRow 4: Column count mismatch', 1, '2025-05-29 18:09:29', '2025-07-14 09:30:02', NULL, NULL),
(2, 'Migori_Projects_Template (2).csv', 18, 0, 9, '[{\"user_message\":\"Row 2: Project \'Migori County Health Center Construction\' already exists in the system\",\"technical_details\":\"Row 2: Project \'Migori County Health Center Construction\' already exists in the system | Project: Migori County Health Center Construction\"},{\"user_message\":\"Row 3: Project \'Migori-Isebania Road Improvement\' already exists in the system\",\"technical_details\":\"Row 3: Project \'Migori-Isebania Road Improvement\' already exists in the system | Project: Migori-Isebania Road Improvement\"},{\"user_message\":\"Row 4: Project \'Rongo Bus stage Upgrade\' already exists in the system\",\"technical_details\":\"Row 4: Project \'Rongo Bus stage Upgrade\' already exists in the system | Project: Rongo Bus stage Upgrade\"},{\"user_message\":\"Row 5: Project \'Isibania Health Center Extension\' already exists in the system\",\"technical_details\":\"Row 5: Project \'Isibania Health Center Extension\' already exists in the system | Project: Isibania Health Center Extension\"},{\"user_message\":\"Row 6: Project \'Lela Dispensary expansion\' already exists in the system\",\"technical_details\":\"Row 6: Project \'Lela Dispensary expansion\' already exists in the system | Project: Lela Dispensary expansion\"},{\"user_message\":\"Row 7: Project \'Lela market construction\' already exists in the system\",\"technical_details\":\"Row 7: Project \'Lela market construction\' already exists in the system | Project: Lela market construction\"},{\"user_message\":\"Row 8: Project \'Central Sakwa police post construction\' already exists in the system\",\"technical_details\":\"Row 8: Project \'Central Sakwa police post construction\' already exists in the system | Project: Central Sakwa police post construction\"},{\"user_message\":\"Row 9: Project \'South Sakwa Lands, Project\' already exists in the system\",\"technical_details\":\"Row 9: Project \'South Sakwa Lands, Project\' already exists in the system | Project: South Sakwa Lands, Project\"},{\"user_message\":\"Row 10: Project \'North Kamagambo Public Project\' already exists in the system\",\"technical_details\":\"Row 10: Project \'North Kamagambo Public Project\' already exists in the system | Project: North Kamagambo Public Project\"}]', 1, '2025-07-09 08:49:11', '2025-07-14 09:30:02', NULL, NULL),
(3, 'Migori_Projects_Template (2).csv', 18, 0, 9, '[{\"user_message\":\"Row 2: Project \'Migori County Health Center Construction\' already exists in the system\",\"technical_details\":\"Row 2: Project \'Migori County Health Center Construction\' already exists in the system | Project: Migori County Health Center Construction\"},{\"user_message\":\"Row 3: Project \'Migori-Isebania Road Improvement\' already exists in the system\",\"technical_details\":\"Row 3: Project \'Migori-Isebania Road Improvement\' already exists in the system | Project: Migori-Isebania Road Improvement\"},{\"user_message\":\"Row 4: Project \'Rongo Bus stage Upgrade\' already exists in the system\",\"technical_details\":\"Row 4: Project \'Rongo Bus stage Upgrade\' already exists in the system | Project: Rongo Bus stage Upgrade\"},{\"user_message\":\"Row 5: Project \'Isibania Health Center Extension\' already exists in the system\",\"technical_details\":\"Row 5: Project \'Isibania Health Center Extension\' already exists in the system | Project: Isibania Health Center Extension\"},{\"user_message\":\"Row 6: Project \'Lela Dispensary expansion\' already exists in the system\",\"technical_details\":\"Row 6: Project \'Lela Dispensary expansion\' already exists in the system | Project: Lela Dispensary expansion\"},{\"user_message\":\"Row 7: Project \'Lela market construction\' already exists in the system\",\"technical_details\":\"Row 7: Project \'Lela market construction\' already exists in the system | Project: Lela market construction\"},{\"user_message\":\"Row 8: Project \'Central Sakwa police post construction\' already exists in the system\",\"technical_details\":\"Row 8: Project \'Central Sakwa police post construction\' already exists in the system | Project: Central Sakwa police post construction\"},{\"user_message\":\"Row 9: Project \'South Sakwa Lands, Project\' already exists in the system\",\"technical_details\":\"Row 9: Project \'South Sakwa Lands, Project\' already exists in the system | Project: South Sakwa Lands, Project\"},{\"user_message\":\"Row 10: Project \'North Kamagambo Public Project\' already exists in the system\",\"technical_details\":\"Row 10: Project \'North Kamagambo Public Project\' already exists in the system | Project: North Kamagambo Public Project\"}]', 1, '2025-07-10 08:42:30', '2025-07-14 09:30:02', NULL, NULL),
(4, 'Migori_Projects_Template (2).csv', 18, 0, 9, '[{\"user_message\":\"Row 2: Project \'Migori County Health Center Construction\' already exists in the system\",\"technical_details\":\"Row 2: Project \'Migori County Health Center Construction\' already exists in the system | Project: Migori County Health Center Construction\"},{\"user_message\":\"Row 3: Project \'Migori-Isebania Road Improvement\' already exists in the system\",\"technical_details\":\"Row 3: Project \'Migori-Isebania Road Improvement\' already exists in the system | Project: Migori-Isebania Road Improvement\"},{\"user_message\":\"Row 4: Project \'Rongo Bus stage Upgrade\' already exists in the system\",\"technical_details\":\"Row 4: Project \'Rongo Bus stage Upgrade\' already exists in the system | Project: Rongo Bus stage Upgrade\"},{\"user_message\":\"Row 5: Project \'Isibania Health Center Extension\' already exists in the system\",\"technical_details\":\"Row 5: Project \'Isibania Health Center Extension\' already exists in the system | Project: Isibania Health Center Extension\"},{\"user_message\":\"Row 6: Project \'Lela Dispensary expansion\' already exists in the system\",\"technical_details\":\"Row 6: Project \'Lela Dispensary expansion\' already exists in the system | Project: Lela Dispensary expansion\"},{\"user_message\":\"Row 7: Project \'Lela market construction\' already exists in the system\",\"technical_details\":\"Row 7: Project \'Lela market construction\' already exists in the system | Project: Lela market construction\"},{\"user_message\":\"Row 8: Project \'Central Sakwa police post construction\' already exists in the system\",\"technical_details\":\"Row 8: Project \'Central Sakwa police post construction\' already exists in the system | Project: Central Sakwa police post construction\"},{\"user_message\":\"Row 9: Project \'South Sakwa Lands, Project\' already exists in the system\",\"technical_details\":\"Row 9: Project \'South Sakwa Lands, Project\' already exists in the system | Project: South Sakwa Lands, Project\"},{\"user_message\":\"Row 10: Project \'North Kamagambo Public Project\' already exists in the system\",\"technical_details\":\"Row 10: Project \'North Kamagambo Public Project\' already exists in the system | Project: North Kamagambo Public Project\"}]', 1, '2025-07-12 14:57:07', '2025-07-14 09:30:02', NULL, NULL);

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

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`id`, `email`, `attempts`, `last_attempt`, `user_id`, `timestamp`, `status`, `ip_address`, `user_agent`, `failure_reason`, `session_id`) VALUES
(6, 'jenifermuhonja01@gmail.com', 3, '2025-07-14 06:40:30', NULL, '2025-07-14 15:27:31', 'fail', NULL, NULL, NULL, NULL);

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
(4, 'Isibania Health Center Extension', 'Addition of maternity wing and medical equipment procurement', 2, 2024, 1, 2, 5, 'Nyatike Health Center', '-1.218048, 34.482936', '1499-11-30', NULL, NULL, 'ABC Construction LTD', '0702353585', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-09 08:48:32', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471252674.00, 0, 0),
(5, 'Lela Dispensary expansion', 'contruction of ward fercility', 8, 2025, 1, 2, 7, 'Oyani SDA', '-0.975707, 34.241237', '9699-11-30', NULL, NULL, '', 'ABC Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25484648599.00, 0, 0),
(6, 'Lela market construction', 'kaminolewe market improvement to market standards', 7, 2026, 1, 3, 12, 'Kaminolewe market', '-0.941379, 34.432811', '1970-01-01', NULL, NULL, '', 'ABC Construction Ltd', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25473574848.00, 0, 0),
(7, 'Central Sakwa police post construction', 'Implementation of public service management and devolution in Central Sakwa ward under Awendo sub-county.', 13, 2024, 1, 2, 8, 'Central Sakwa Area, Awendo Sub-county', '-1.200886, 34.621639', '1970-01-01', NULL, NULL, '', 'Blue Economy Partners', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25463848848.00, 0, 0),
(8, 'South Sakwa Lands, Project', 'Implementation of lands, housing, physical planning and urban development in South Sakwa ward under Awendo sub-county.', 4, 2023, 1, 1, 3, 'South Sakwa Area, Awendo Sub-county', '-0.904305, 34.528255', '1099-11-30', NULL, NULL, '', 'MajiWorks Kenya', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25475465154.00, 0, 0),
(9, 'North Kamagambo Public Project', 'Implementation of public service management and devolution in North Kamagambo ward under Rongo sub-county.', 9, 2025, 1, 3, 11, 'North Kamagambo Area, Rongo Sub-county', '-0.874096, 34.581813', '1399-11-30', NULL, NULL, '', 'EcoDev Works', 'planning', 'private', 'awaiting', 0.00, 1, 0, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 5.00, 0, 0.00, 0.00, 'not_allocated', 25471163680.00, 0, 0);

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
(3, 1, 'Final Joint Inspection Report', 'Joint inspection report', 'doc_686d5fec5a2a60.76639716.pdf', 'doc_686d5ea955e7e6.34870331.pdf', 'joint inspection report', 'active', 1, NULL, NULL, NULL, NULL, NULL, 1, 37175, 'application/pdf', 1, '2025-07-08 18:14:04');

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
(7, 4, 1, 'Architectural Planning', 'Design maternity wing and plan equipment installation', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(8, 5, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(9, 6, 1, 'Project Planning & Approval', 'Initial project planning, design review, and regulatory approval process', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(10, 7, 1, 'Design and Costing', 'Drafting architectural drawings and estimating costs.', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(11, 8, 1, 'Land Survey', 'Carrying out land demarcation and topographical survey.', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(12, 9, 1, 'Feasibility Study', 'Conducting technical and social feasibility assessment.', 'pending', NULL, NULL, NULL, '2025-07-08 06:48:53', '2025-07-08 06:48:53'),
(13, 2, 2, 'Project Planning and Approval', 'this step involves alot', 'completed', '2025-07-09', NULL, '2025-07-12', '2025-07-08 06:49:55', '2025-07-12 13:54:14'),
(14, 2, 3, 'Procurement of Construction materials', 'procurement of materials', 'completed', '2025-07-12', NULL, '2025-07-14', '2025-07-08 06:50:30', '2025-07-14 11:35:47'),
(15, 2, 4, 'commissioning', 'final reporting about the project', 'in_progress', '2025-07-14', NULL, NULL, '2025-07-08 06:51:10', '2025-07-14 11:35:57');

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
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project_subscriptions`
--

INSERT INTO `project_subscriptions` (`id`, `project_id`, `email`, `subscription_token`, `is_active`, `email_verified`, `verification_token`, `subscribed_at`, `last_notification_sent`, `unsubscribed_at`, `ip_address`, `user_agent`) VALUES
(6, 2, 'xOtqDecf+CZNwIAvLsnKjA4CZBEBTJi3vKUppkYvhWYReDQ7RIyOIXBcIyzpogvyEX+25FVw', 'e6b014854257c7413e00bdd452402fa196a7ba5eb515dc6bcb0403eca32b6e3a', 1, 0, 'a4e3eae3a0546fafd8aab70a3fe6b094a64dc016a265fa5aff09568c5dcf5a79', '2025-07-14 02:53:30', NULL, NULL, 'RGUGrqgOv8eIpPkQO8FlPGIGvd+fljOocOYOeezu3A==', 'neMgQoCWlIf1YrLcXULhuS806WpAYexk+Y0OvSTs4lxZtu9eMGkmVI8HOewYB/6Ca1gN0m9ojBI8iUl8S10pVCeFpbvPTKV4LTRFfi02MGKXK+t6xlAXed4qJ9qTihUhky2OljrxfDU7MWGWhrYiGx/V2COL+vyzuwIfZdNb9D76Upmu2WKFJ5vjWA=='),
(7, 2, 'd37fp+yY0HhJ5xTVWAPTPf/oUJk7WXQnHd0eU+VTcyDNO6t7AtMwkXMD/Ng88v0=', 'e9902c7f6e7ddb0815510512f5df796f8ec85fe883f6728c98ad68fd10b052da', 1, 0, 'b31f4f6db9e82edd9ade359a4f9563571ea23acd24c25361c0299c586f07df9e', '2025-07-14 03:09:09', NULL, NULL, 'axwk4dfdllg8HcJ8w/QqmTXqyQ1+3Zev4ech4LOoFw==', 'GZsBzhjLW5tXLJmj2r475vgqzRh3fdtHovR3t4tWtRr52h03ad0fzpebPUj6LRD4rN2TJkw5aXHIImH8AWS26WzOiqO3QxhwCImCDsmNW1itOi20NosYOsBb+UZyCU3Kk6IMqBOiNEOYNsXVndsvVkDVjTXH/IvzsujQB2FGKvqyvPxv/2Aoa46SPA=='),
(8, 2, 'MwQqV+bi7fF5yZUF8gF4wfapgfS7yuIYQ7BHPX2EkCnsx980Y2KblanbCysyjpcz9LTbd2gd', 'a6a0aace61538dd0393208dd0042a1d7c916ddd6ccc0314aaa9bd13df74d3ef9', 1, 0, 'adf6d4b93d18cbfbd664b901c2d61e0df9212ce15fb59016cb137d087db26491', '2025-07-14 03:14:19', NULL, NULL, 'xkghQwUTtPGzSkq64qRi4fiCoGL6BNmdjvh+Ua2VuA==', 'wqe2JGyOEaH5yHzUug1od09qo2WBNCE9U2ZlRmfK5SWh0lLqnAMu0h9I7dTmu3b+4nj37u6X7+dc6HfQ5+PVvM51Ps9YXUjdLS7CTPm1hG1uPE7uwwbktZJv8BxCe5oWjTxaZVb0qwx6XUPgl/aeC9958vBL41jVslr8nEpeup66IN/95vuo19M+VQ=='),
(9, 2, '++cZobyqxRB4DblnanXs1nutOI7H5KpJIfkJM3GUCxMITuckXy/y2SFcOe6Qd4AROHRcJmXk', '9adf7546774efec764b0227e34edc45ccb705440976f10cbad066b2adb978727', 1, 0, 'ec28933868a94e8cd4dced604cf92276524fcbc64cdcd7832680b369ed01b33c', '2025-07-14 03:14:29', NULL, NULL, 'u5eW+bZXRFOk+zSEnEMmb41rkRhevZKHQWyihy727Q==', 'lrIFmRz58Qq+99xn2OA+x82F2S1zr+3HmnKBECfo1NCs4BYT2R1h1n59Otoz97L1UqyctXmmscS/hCnSTg2NUkau7i8hM3P8Ap5d/gvjLSaLHQQnYs1xGSqxHuZNo73+LK1XRG2h1chXhgl4ay6kssiTlTQDT+YqIvsEHQ8cL4m2oglNsa9Dz3PI4w=='),
(10, 2, 'rE2U7Sba0nMgohkVO3rj01a7dqZ2/JbndKYQkrn9zgpQbmz2cSR51fUgHwRnNcyLry1PhPZX', 'b9d6519d90e13701e86b6f0f402ebc55084dee9183248a4e016a697ceb9599f9', 1, 0, 'cc6b5ae9377d6d71a103b6ba9bf2c0f1a1bc5b39de4e738e6067f957bbc25762', '2025-07-14 03:14:52', NULL, NULL, '/WQzviP/GASn7c5b4Txp6A1eBfqJL3CwvRv8axsJrA==', '0GqM66fOJzhKuTztL+3BiGNL1Eauy8bfHbh8L54Ts7IjzA5N4Cr4YOSJ8eNCXVFAbIL+PcorpIVsjixys3yRxPjg0w72t+A9K+hvBiDzO+3krDUaK0KE2Be8/NPziqoJNNg6YrYYr+g5UmLc2Q1cuGmDKwOBStyn4y+P7O0X8LyCW0d0pjOQBotOQQ==');

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
(6, 1, 'expenditure', 7000000.00, 'Payment to the Constructors', '2025-07-08', 'GSTE534', NULL, NULL, 1, '2025-07-08 18:08:41', '2025-07-08 18:08:41', 'County Development Fund', 'development', 'bank_transfer', '', 'pending', NULL, NULL, 'pending', 'active', NULL, NULL, NULL, NULL, NULL, '', '');

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
(5, 6, 'doc_686d5ea955e7e6.34870331.pdf', 'MIGORI COUNTY HEALTH CENTER CONSTRACTION PAYMENT.pdf', 37175, 'application/pdf', 1, '2025-07-08 18:08:41');

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

--
-- Dumping data for table `publication_logs`
--

INSERT INTO `publication_logs` (`id`, `project_id`, `admin_id`, `attempt_date`, `success`, `errors`, `ip_address`) VALUES
(1, 1, 1, '2025-07-07 21:26:14', 1, '[]', '::1'),
(2, 1, 1, '2025-07-07 22:42:13', 1, '[]', '::1'),
(3, 2, 1, '2025-07-08 09:54:21', 1, '[]', '::1'),
(4, 2, 1, '2025-07-08 09:58:31', 1, '[]', '::1'),
(5, 2, 1, '2025-07-08 21:11:39', 1, '[]', '::1'),
(6, 2, 1, '2025-07-09 00:48:56', 1, '[]', '::1');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
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

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

CREATE TABLE `purchase_order_items` (
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

-- --------------------------------------------------------

--
-- Table structure for table `purchase_requests`
--

CREATE TABLE `purchase_requests` (
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

-- --------------------------------------------------------

--
-- Table structure for table `purchase_request_items`
--

CREATE TABLE `purchase_request_items` (
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
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `security_logs`
--

INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(1, 'page_access', 1, 'DVCgHk6LRoXZ70D0OZ55uif9leApQxTY3is1+zDnGQ==', 'vWRXz/UuB6+Tiizs7I+IA2KAJI1N4viPzargnx0cgYULQBOjl/MA3H46BbCnjJqVJt7xu3maABQnBHkJl/BvZzUu+xYW0qTsbjajOT8NtosXtyQ9zRJSZ+UfbbB1hnf6evRaa3bBaC0ECzXVO+1CR6ab3/uAZH6YgBjn/vfHMV0GjAduNrpQxqqh0Q==', '{\"page\":\"dashboard.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/dashboard.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/\",\"method\":\"GET\",\"timestamp\":1752476758}', '2025-07-14 07:05:58'),
(2, 'page_access', 1, 'fkH05wenZlXATdK4xH4dvUnwaYZb0625mJxOPfK+CA==', 'LXgbzylMAd079ny+pJfB/o2SY7ZFxbBTJgFauMBsDm9b76eE2xP+HgCLtrWn/8YefcoMx8PbLlJJtBzpmLF60G1BrADg2XLz9y0l5c2g8ki9Jn5GypTBiF4W9bWlehLPSkNuwttZ5f8w/CyMCgcUy1R6EKYJ3ncyl+U9jFybAUX8CRUa0MRc/1nlOQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752477130}', '2025-07-14 07:12:10'),
(3, 'page_access', 1, '/tgGXx85I6xtak0C/bXQ6n99Sl27fS5A4wOGtcY53w==', 'f+q2VIw0296zJf2zTSvALSLMSXR0M3lcJ/iAvVFv644iZq/6IGYjFhVufWbHPx6rp7xXSGghhVLJIUXX6/n1eC5qJByj9VIPa3jPz/GEXp6mueSELOnHZQ5KiWIE4+xltUOVmAml8yT3+DlmxY/JWdHYraCzFXN7oytI4TymK2O1HH15avVQmHDmZw==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752477562}', '2025-07-14 07:19:22'),
(4, 'page_access', 1, 'CENvwKcfQwx69+odba3/sQvolRJVqU8IlPfw0Zy4xw==', 'hM6MIULaS6BkccqKNOVjliJ8bn7Rt+uGfCxlWcG6uPe8ZDlfod78AR7Hk5AfG076iI8ZKXsbel6Lc5QBZ5JdFrqd+aVOP7OytSkTzmHgcvZ0PpM8QA4R14FhrU3bSJsacfhlrGgOhfNfhpVHHW2B8CJVZ/todMnIves7Le5Za7OSs3h8S5OtLH3RmA==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"method\":\"POST\",\"timestamp\":1752477621}', '2025-07-14 07:20:21'),
(5, 'page_access', 1, 'JOywVoH7i3F+SByIJCnJKkMcjaTncWv9mC/K/RL60g==', 'Gch4LijZsB8/5ao0acCFL0TPWComyy3m9XdGUAu4YPLyvc8h/qCU66cwQkUPkY0a045Y3YlvXbkteA0Gn6XAnPE+D7g/SAd9hvrfarll/jVRpbK/a1WYFQibuny/BPuqQE3NtuCy+Vdz81ts4oxQN7uqUu5TCAZc//xc90amudN7RJCrM1ricqbJHg==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"method\":\"GET\",\"timestamp\":1752477623}', '2025-07-14 07:20:23'),
(6, 'page_access', 1, '98vbULx2yJszBpkewdM+TrG9vJ8DWX0qhuY7TqdQ8g==', '1HRxjRB/EKsc3UQFJuvLJBkU5lMuZm5sF2ogTqjlxitOovONqpkLvT0ShzJuUodtFZg8fiLIKNNuDUi1gROoXYb9zspsoP2uPHzaFvR5IFw5yTfSDkTUYdIAIvqmsc5G3+1ZWSwkE2locHPvbJFjKyoyzZuL6wGEUnfSlebtKaE0lBX5zrhElotMBg==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"method\":\"GET\",\"timestamp\":1752477769}', '2025-07-14 07:22:49'),
(7, 'page_access', 1, '8shEFiPjPO9QOZ8O2qCj6wC7DogoKbfoV2WPFrFc9Q==', 'Fh8w18RBBfzFJkkGdLE2fmPX3iPZBua9BucWpK3YXiOMEf+rNNxnhs/NiehTuy1jY4TDdjRH/ZFdhUV6GnIFDGZsnCSggisfDM9c2cYX7AUPVe6oLyg6V0lZ/g0YTTeQnN/rhLBNYT84QdTiOhZdY2YG+ISfmAe7JEhFCDWTVl0jTaQRHxr1HO7x0w==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"method\":\"GET\",\"timestamp\":1752477778}', '2025-07-14 07:22:58'),
(8, 'page_access', 1, 'B6tRUHa/UEVFvhZnqHkABVKRgssfdLG5HisLEn86LQ==', 'watYjdG1BaHUHjdW2chqzNeiemwDyKLBHs9NqZP6nSJvAWLjG/SlagVKJrBQop8R6qY0hHfR+ZBWAZqrsSo8klEksYNl4xMOqatnLAS92iHgCl5SIGmoZY2XXx998sMxNKSv63e80GfPm+qWr+rPJ5mGGAnVAk9rrGxUhy4ppC9RArlRiUUGlnbUTw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"method\":\"GET\",\"timestamp\":1752477827}', '2025-07-14 07:23:47'),
(9, 'page_access', 1, 'w1QcjmN70lljodk5SkmDJn3dxwxadp8KPJ6TR+0vvw==', 'uoLu9hUYth/W57w3YO7PU5pNblgaNpA3xyEXXkOFDWDkKPrc8vHiXbyT5SwSaASL+0Jnp5jrRieZlXYOes0vSfK4Zj6LulEl7n518uVHU7nMd//nYKe6gdy7WEHCNowaqSYJRwZ4eWfnD2pDnn5/dhDmw/g90CiLrHTMdfkwO29uXUVksmVv56fn7w==', '{\"page\":\"activityLogs.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/activityLogs.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/dbmonitor.php\",\"method\":\"GET\",\"timestamp\":1752477865}', '2025-07-14 07:24:25'),
(10, 'page_access', 1, 'oI1wBms5nmzdut5O4hfvQzmS5xe7qgUzK6Tp4up7kg==', 'EYGth6s5c36BnEHv1WxIIXUfKCp5v4OLT53G4BaeXDwoP+FEIqpkBV36t0U6irfMg2qtT+96iyLrbxnqoU13blNSDUys7Kq3BuICi5OuuH1EMqruGEmkwgPbtkITTHewKeNVFii5DXwpTROs6SrFv/TECLlE++8maCLyEy/7eXEvE7FL+sPcjlIp4g==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/activityLogs.php\",\"method\":\"GET\",\"timestamp\":1752478008}', '2025-07-14 07:26:48'),
(11, 'page_access', 1, '0gBxAGhI+tjMHhafMVh1D/ixf0uh8aOt/US/QYsLDw==', 'kIJlQC2KGQQUjZhfVgm++urEI+ahgpSlaYcrOqcPqCx8u5tfaY7q457FihGe0c3lxs98J5wYOMmiTaQzkYQACjZmpVgNf8OeNjCqtGBJ7/5fOWcqbS4fOIVFuYP4bUDdxIXgCD8FQV9+sDrMJE+DFQVvIfwoqsOQh85KwMzLLOeFJurnZADcTnlu6w==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752478715}', '2025-07-14 07:38:35'),
(12, 'page_access', 1, 'di4uEm1vVU3SsUZY0JTld4UvHVfO73fH0yf9Hue8xQ==', '7+SLObBptwfCUVEy58DaTNR9enIsx17d/x9DEiRWWw63sVtdkJN13ibdjp6O1vlxMjx92goRwJytHwa6nW+c2SrX5gfXkaiUXHrhfUKc0SjoK4VJWkcSrMvmDbn4GcjQCDddXzVgNL4pzsgvG6tNQpZxBtS+Pd0xnmCzgVz3prIWj4vo86zhgxupig==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752478773}', '2025-07-14 07:39:33'),
(13, 'page_access', 1, 'zxVawMxy7I7YVM7lSLm9jufL33iQtjxaK8OgMYZE+w==', 'ULZ/l+V0HEQa7ALGIfVE+iVX1z+X3FZ+70xFkq2UnwtLQ5uCxE4MXf4yLd9iUbAJnrL5vB4PqBcEtC41yTiIR+mcNHzONt6+Ill7qT4ZvzN7RKte5XdqafSyve8wxNwbR04DAY00KmcDjKY071wKmAHuLF5wBjXSiFNoipbfFraowlaadDmkrLuktw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752478841}', '2025-07-14 07:40:41'),
(14, 'page_access', 1, 'zgfXJKEdfoD0mSZGErvyf1v0sTImhqo3bEOxeL0ISg==', 'ViY1bWWAKSOI2VEkAThygB5+XVqKAyFpKGIxFLT4nRQDKwDLS4qmxD077b+9yp7EbioJQ6yJHCD5VE5xPLnOgsrKEoJLvEsOYswrglixGX2kKUnNDPZ6gXHhbyjv3e+yxvp+laSQ5sKt/P/FQK+KE54ChJNEqpEPK/jYs3pAsxFivZgvRnLgVSY3pw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752478853}', '2025-07-14 07:40:53'),
(15, 'page_access', 1, 'bWZHcE0oyLW+ThLeX1Ih5I70RahhJbfj6GFjMaCzPg==', 'BCQgHDY48YoxgZ17CKGFGxJvfK0AyxLi54U3k/ajbc2xv+c7MeeXpTQ5y0HTmih1BBIpZlc6w7+EeAbFX3/3P+h5rTgAFXxQilATfYFZyXKcFcS5geZHs/G1tVUNxhFvQBNAzxo4485JlhZ2bd3AfURsxzJuRnYmj4wjrlFDJgmPEmCp02fIf8AMxw==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752478855}', '2025-07-14 07:40:55'),
(16, 'page_access', 1, 'Sx5bEASZ1XaotSVhw+/EnNKjnKi9gklpA2FPLKdGnQ==', 'I4w2MsAAggElfScMqbx/rKYo+b2FSh/SJGUW3ZMYDxr28yrht7pgJHe+mndYQzggG3tGPmw32Enr8SVF3WocmA8RSb/XqfOTNXOv53ZS7duXdmga3sogCi4VdlA1aK2NqRMQ3+1QlCtoKZG+mgTSljLRLSHgEGgXjUwZvWBA7La2ivyPPiBIQga85Q==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752479057}', '2025-07-14 07:44:17'),
(17, 'page_access', 1, '8mO5FYHRydMzrfIq6q+9ZJyAjmN0S/IeINPEDZVprQ==', 'F2pk/4zquZ1jKMbFaynHlMZ5m9fkVrfFKWOIOFluNXLL87zneNiWGQccDiRRIWz8DgVsregEZI0/buPnZFt6U/H9EaAzuve43LCH7ZYHiOQLKLHprPo3EQMZW/hlmt9dTJTRLbqw1eppw8YyhigcoQBpVJxz7Qj5pYfZQD6bAy/4ubxU+A+k10eGTA==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752479078}', '2025-07-14 07:44:38'),
(18, 'page_access', 1, '91+DnimmDlqLLRKrboHFq7QrbsRVlc11nsEAeYif/A==', 'd08VfpJwf6H8GHHUx/fHxMKHOm7HcWvjbR7r+DuncTvJbYYpmzAhOwNcvwkUfcnISgdOjLjK6eSNI7/fXnhvB9xY6mOAdUwzjziLUSmYQ1PC2NvRR9l+otyh+jGNN9YbBuyoivG2qtTpdbHaJg9S8NV+jAx/6pzHs3/EZ8dKL6D4iwWCXmIQsazBKQ==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752479238}', '2025-07-14 07:47:18'),
(19, 'page_access', 1, 'LE74qPbbWxsW+UHolTb1Je7BWvDNXDkAV3IOO+CVtA==', 'Shsnm3sjed1P/8sGT7B5+k6wZ91EJVHgNIU24fEe/RTVmVVBwKjV9Kan0uj/FQgw4qbIeCx1tX2dsb3zkv5vrPwgHDmbzZKLByMRFrizgl+1fkayNHVr1TUFHVdCeXhh7nmkdbT9Gwhhip2CgbSF+94Gb6bUU1TLLxkY++M6kVLk9kvAfBTvCe/U7Q==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752479446}', '2025-07-14 07:50:46'),
(20, 'page_access', 1, 'ilHjr02FnbKJkYziKaS3izR3l/eu+F4dkjECnqjxRA==', 'drqrwDgCOESDg1Li6UvIMYz+92U0zVZhGY2y60VhlYE1sP0Rw4O1Ul7dBnbA/fYDv6230m+oxGr9M3aBASzJ71Suywj/NRMbMxRF1DmIzlyChVLUsmUD2FXOQGCX4X5JbFcUHEIFOOY5d0OujIasIHonGGBvdNep+rewHyyZNjEyEyELZHIS9DVSnQ==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752479466}', '2025-07-14 07:51:06'),
(21, 'page_access', 1, 'VTPKkjjxl26T2YW/8W1gvgkMqr4gNImQhQoBXfeaMw==', '9pNbGeQxIv7VOC9+wy3MQtsDMoiyu1G7XXF8ZNS8KSiBxbnvhx1KM93WbP41bYya/lS+dnBdI1tEo8uTLOMWE5+dnrkkD9SUZoRal/6X/gBb4sJrp101395Sy0e3LXHJ8/BirHPoqoF5+or6bxdhIvifzqcHOkkmjYThUYX5BooyCdjcYmXbWnb+1A==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752479587}', '2025-07-14 07:53:07'),
(22, 'page_access', 1, 'EBTvfLMAsGgPuCPFSQjrSCMJMom70WPvN5D+QevVUA==', 'hH3C6vUCmzCQryRG7a3mc348bq88QbYYWZzdfRfKMuAsAV3Qq6wdK2bh0ctpbNjhT367jRQE+9MoBHAkw/DV5QfRtElwn2xFc3nNYkriwxeMZbbQH0F6N0MZPfoclAFyIGnq1Q2eKiXSuXNuKVT6TWAAqBOxADRenGBKHlxRUgd4WpLKlDEo8qCutg==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752479616}', '2025-07-14 07:53:36'),
(23, 'page_access', 1, 'zh0eBo1jtIQE4KBuDdefhoKdBA/YRXPXnivbCGTjVQ==', 'DpFXcTBaLPfQHqqiTkZm0pLM/zVgmTBEd/6aGuiWSrKnSBQJSA45JSvNFXe1mpvz6eaSmKQCRbOGc/EBPsq6CK3+kCpG+F2kfMtLIQsgZ2moeGamKQ7hswE9nrYJA3KxsyBDtGhEzokzl1jDkutdK6zn/TtyvjxQh0uNT2GVPqxDNziJrOGBZFnXTQ==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/profile.php\",\"method\":\"GET\",\"timestamp\":1752479630}', '2025-07-14 07:53:50'),
(24, 'page_access', 1, 'YoQRqqzo5tNlEUdwBJ3KwKsjBSK1/5U0ztRARaJxWQ==', 'izKColf0VPY5ReRs0Z6qto+gbuCzdrSqPdy3A++x8cYWZDEREshYhhUKADFaCoUv+19YAfnKXsVvMgu2Vi+XGz2AnkFNo++2YMb8g77BSGm0JMg3lGYSJIO/Tbyasx29yiP6HIG2LbTALICoONuGwoqvw12elZtexuzxeEgpTUbxeatFmyD54E89hg==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752479646}', '2025-07-14 07:54:06'),
(25, 'page_access', 1, 'KKmTbqE1re/AhpxvzXu3hPZMDya43Ki8ARGui9McZg==', 'PAszvTVCDMPRM1cFplkuTH6LzIq9xiaA3Md4mR6zaoqb30uA/j0FFjnibsp9qmXjK5ix8dXHJ1ClvleE6WRm0pPEPUFgONrcwLWtSjIDtSwAzgoJMddNi15398E9gqb90PUQ7ckrdk/JE9SmDN+nIFBBn5ugUvf+678sEEu5jDF2aspp6aPKu7ubbA==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752479651}', '2025-07-14 07:54:11'),
(26, 'page_access', 1, '8tdmSX79S9OpTCHm9aqMZT5PFOaOytrMbtiy+l3QzQ==', 'o0qOJZL58q0g8+fmrDEeMzrFRTOn6J99o7aFt2WFLkdEmHU2ei8qZVCBbOTftHuKtkbntuPZKKaIQOtkrA7VoETorQD4kdA+fYdD5O+tpquSanAaTEhsS1UQioCAbRIn2QRYQPADVyxzuM1VHmyPduBuPuP4ECDhenfEpIkiTvoB+6yAvEFxRPhbPg==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752479654}', '2025-07-14 07:54:14'),
(27, 'page_access', 1, 'BjkVyg/PwG7N+dLBbqBIMM4/1h6zUxi5RWrry8CzRg==', '0j08ydtgtHYRXYTnvg3EIaEkq/80L5FBBTqxdzovNAQ9gvNoH+6TWMyqguKT4G7+74nsbuJEhqVVLTji1Map1LpsPZnZ/byCHKB3MPGivDLeoHBYa9f/6fR/dORYcivrZReLcnfe9ZDX5ze6IL/48mBlnqihzShVlR99bKQzeFEd7gbkfYThxcpyFw==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752479661}', '2025-07-14 07:54:21'),
(28, 'page_access', 1, 'N9l37mvb0QHZSp5P35u/dZkZoVzS5pq8vdsG8GR+Zg==', 'jmEu+gdQuuaglmUueZjn2xhl6T451ZaMA9U+XzDB3AzK0kX2VEfW9ktUU2HxdFoVqh1LsN3C8xT31/eOXDz33yIgUczodUeH7JURuuRrUbVj7BDhIgW2Het2MQTixess4jpjsC5awQUw7+6iMjD0XMbSAXBgf1JUM9HWEjar8jV7aij6hl8eSlJxSA==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752479661}', '2025-07-14 07:54:21'),
(29, 'page_access', 1, '19/+jSa1sx7dr1lBPECMRsHYc3JO0MEabIQ+4WXKMQ==', 'w5y4lnrRqmSWOQ0curEqVXCM+r6GsqDT9ohcUXirdNyux0xcBf1FDHRBuyzrtfI/1YwuRE2sC+T3syfZndz/9hJHYSrdZLv5PM59Ac8M/W5a11nKXrnB2e9NhRkaXpkwZppA2k/PbNbpHfEIx2Q53I6lwB1Cvup2kTJi/w6N11WC02IQP9sGjUTcrg==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752479669}', '2025-07-14 07:54:29'),
(30, 'page_access', 1, 'Gap5gjDqsjX7ZkJLqauDjg5OSCwfrxGU3LIPStsDkg==', '9YVAi/+oMcXZdTGUYYdpt5I9np/ODHUozDEoTb1yHXTfqcc+jw/17GkjZwM3yB6pZm1yb9Fo288/UChnckHIjNdeKxjZm7tzx/MLDS9KjAHazLvi/C7i5MK0VruM11zECrOerXbzdfIz1Yry7rhhAeCYscOAuQ1O+AszQIzmWOWlv25xbn7C5W/DKg==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752480369}', '2025-07-14 08:06:09'),
(31, 'page_access', 1, 'TYEKn/2BqPkP5+A3zwNZ/hGXnzF8C4SLcaJZlX3s1A==', 'ztUBXYWe68/JheEGpuTlbB1goePdAb4+un3g4XM29G88W3SLrn22H5HQKdKRcAvs6z14SUPdzdobO8NDHNKhOftYRbhlQwFLqtRo5JuesRL6ysGu/+jeahy3JfugCRbelJtnf+hIaTl0jXX9NlgUmIpYr9z3Jcfh7eiCKuAlQkDXpszymLShgYcDgw==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"GET\",\"timestamp\":1752480403}', '2025-07-14 08:06:43'),
(32, 'page_access', 1, 'POUjmvrXr4guF496aEbtg8PNgsALp83Y5cN3HCz5mg==', 'pP6dtCTWg5nwDPqEAf4dOfl/BS5fEsdDZz3imMkRvlkISH9OSfoIxNCBabUNESGk8cCsOLL7O1qubAo1ls3LmHoMwCZfeCWLYu/hnuhgyzdkM3UuquXdd0RJHG8cAC0yOLMNUw635XskkODsyOQbVM8J7W0ZkEyo0giWi4jOQAWgj7vYrX3GGBhKJQ==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752480406}', '2025-07-14 08:06:46'),
(33, 'page_access', 1, 'TiiM+VgZRWsG8gmkEhVpXK1p12pSTpaCQjIEVdy8GQ==', 'VS7uQcZdaNm/I1kZEG1ivNk3YijeNI9Ig2WVFrRDktblueQeHi7dO0vvnsVhVraFhANlkWm56nGV3eBzjdQarchK5DkEGA7gC3HeNq28E0ROLu2SFokuVex9oo67IH8KgV/mWT6HbavXo5IhtpJ1yx3zLSBUWQzM0WV8/+yFxQaBf4ZRdvxCADPkHA==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"POST\",\"timestamp\":1752480448}', '2025-07-14 08:07:28'),
(34, 'page_access', 1, 'O86MmOA3zvzqmAblr7XWoz7XUzocVH2D+TeMe+QFQg==', '5tumAdMAvfByUiEI31O3H6FddyrzrYyQVCekQ7bHFfkvqcK8DAZfB3+pQf9pITmXvM3BvlNV18TzMPqFAX519UxRVUurkCuFKCWbUEv5YcTBRzXR2EnhoXLbbb2wsiz+JXd9BiTQwq1MYe/CufU9UNsGNMtxvjuR4BrMhmb2KpiFanwE0UmXr4DUBw==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"POST\",\"timestamp\":1752480448}', '2025-07-14 08:07:28'),
(35, 'page_access', 1, 'fBCYSGGrvlXgm8rRCBFklg9V2Cta5bcpeTVIpvDzcg==', 'becnovIlY/cTZZQKys/TrtfZ2i3f3L6iAl/J6TVw2IwPvmlHJTHKzho/dlYJoMKxSmXS+l7zdBl2oumzVVn24NXg93fP8xlfG5zqlclIPnnvaAbBxkNgYQiFeIu0seNL+oYQIy61AAqnXL6Tt+rLyyIzGwfVVLDiT6p9RnP8lkUPAMSPGUmegn9U/A==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"GET\",\"timestamp\":1752480448}', '2025-07-14 08:07:28'),
(36, 'page_access', 1, 'GT078FaFtJKNEIKTPua/vhhh6d15YOJ58uVwAzYI6g==', 'NTcaynZJgWvQp0MOqn5UrvqoGuXZ4TAISEet7v0/MABR6NGzW/ElvrPSEHoqcXwkU5cJioMhD72tUQFV5MKm4BKAm1NZDG6yDs4WZ95SXrzeHINKfhetTwset1Vibo2T6Kc8XYXNxexb3wGGPbK/E2754cknJDnYWlySN/r5AZSYtr7j/AbJPsx9zw==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php?info=no_grievances\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"GET\",\"timestamp\":1752480448}', '2025-07-14 08:07:28'),
(37, 'page_access', 1, '2Jb720PABXhMU/0zNXjwIDfzpF81rdqMgBnCEoLXmA==', '9haRnL7d92PcjkHdKQjlOYvN0R12dlobpUHNUglB9iQ5nWqNot3665p10ncn3KT/aHbf/acpzcw/CF3BT5RUO+LdctLowIIvnDS0dlhw8aizMexrzx2YkugijjcBRh05hx6HrWSh7bjKVYR7FVXhgKN35u9zDBz9PcTICQ++6SfhNCoiqJD28G/EbA==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php?info=no_grievances\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"GET\",\"timestamp\":1752480448}', '2025-07-14 08:07:28'),
(38, 'page_access', 1, '14B9rdi91YqV6vhbxaXQCWb3PRdqtSjKroURI4PS7w==', 'rqxDwChUuieTJaRN0JDZ44f/AbiG9jSFY49ue8WledAOcmbK58vmBVMertA4auOuhiW8lc8XOdeO5Xf9eYlh5C4SUjSt72peUL0V8tlaHBW/8wSiLQK68/sEQEM+gHgOE9IDo4kuKjfhXeYB1Wc9cUPIpXuT6G+NUFe3l0uW5xjWkoKMbfUyZIh40g==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752480839}', '2025-07-14 08:13:59'),
(39, 'page_access', 1, 'bHwtFoqnXOswixFUAeWdIPbzm2/mtZ9lw2C6EWbXCg==', 'sWcmw1glt6k1zBFohCFlNW/4IfEPmhmeBdxF2QX6ZBEFk5/MeEzPLugJEKEToT/EtqOHYPbLmgJgwWrd8mcHxHMlpN/odB5Xm6SbfKuSRxlhAsub40ZTxbaCTekcrtaMgxi5qhH4P9PQ0UN8BH3bWrPhujd5SroUaEp6hbZ+fPpEnDDL9b5kL0Acyg==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"POST\",\"timestamp\":1752480869}', '2025-07-14 08:14:29'),
(40, 'page_access', 1, 'L6QqU//kOQ49DnFCT8Orz46ayFgYMWvaVlh8GftFOA==', 'VCMj64vDahIJwGtrKeWKGiza/ZdO9gVtZ24zc3MYnDgiMilWsFeW7q/Zo6yoYZ/Ee7KfzNRJ5bBnyBCcVZ8o53zzOolHgxhfgGKKUEydwMPLCGtagW7iDib7ObAso4Nujjn0k4O6jtXh+mcNJJcVshJOLttUcZR7S1KNyBmj5KyCO+aOrNfSgCbnMQ==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752480869}', '2025-07-14 08:14:29'),
(41, 'page_access', 1, '9zwkHoI0J0NcLRMRDo+igr72k3j1XsdMv1EcBpjp7g==', 'lBnwt/rhk5rVJS0klVJyLxKNLLVFi44ZJEAGQ33LmUkR2kGkozerakIqM+gtVUpTDruSNPjy5DE3IIaqwL3MTDcmAAyjMKHnNWevgrBhU2YQKf/7y0ar5dF2a7dzH3dMguZo6t5NhZl4s8YBQOZeo/NGdUlEumgmsid/+qrKEyjoM2VJum6kZtWFEg==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752480885}', '2025-07-14 08:14:45'),
(42, 'page_access', 1, 'DD6EEOyKDgTlKV+rqrfIbPv74I8YuUI6ywxyu54kJg==', 'F4d6atGfT/QO4VIp0IVchrwnRdvCf6/obuzLSvVlrDhfKzYGLrjGWegQybSTLbcOf5+MvyBStqCnJXwAhuKladDXRXcmngSU74cfd6Zyi++c4ohUkb7Srz6RQHHihB/jF85wDxU2+YJHlpnqTtxEWZnw0n0DFCn5SAtMq0dWt4qCfoxRxDM4Nakrag==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752481097}', '2025-07-14 08:18:17'),
(43, 'page_access', 1, 'trny5uf8ggTObrb7sYU6r5A2Fr9i/18rRHBbBZOIAg==', 'oMJiEt4LHSg49cIt98I4KXfHbv6cZzPbB/cR1vmSyudGMJCtgun7kQR57l4rK143XnGK8RZZFDq41MDe4zaEqleMP9nET+k6Wfd3+ZzJX54x3Ltge8wZmBaJZkqMDMV0o4wzlRnTCyH6aSlEmZW6cQcHIb9Xt0a0LzSd5znzDsGx/1Fpl9N8IwdBRg==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752481098}', '2025-07-14 08:18:18'),
(44, 'page_access', 1, '/lsbmRtEAGr8nLIwUcgyNeiuwu97YGZ6LRwjf/O33Q==', '/l0r8/hxat8hqguWq/jefrM6SJ+gfjce14Z4Jt9Sf3HjlUGO6wThn8d78T7QURHvHGBYBGSzPAT6hYti8/7hiANOCEpSWQnD/RNGaLyxrC/mnYdPVI4hUHD39xP7OKwyZ1Sqq2wMOpmxKr1C3/dWACLFRAbPnqGk3/tCLuKJnJcjxRPCF1FBHVg2tw==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752481204}', '2025-07-14 08:20:04'),
(45, 'page_access', 1, 'CXI8RWk+ATiYUGXw0o1z9Ra+7IjVr/wp0TxpJq1jjQ==', 'O1pS7b+EmjP/sePqiuzPz/onFr2ZPD7DskDEbxyBizdY4JnjgE0WbUdqYvCH04vB3N3WqnyZFE1NTBpuACnPxHddiWDulZVZ/T+8De+bKQZNeuNOyYMygYGZW6olVLWoC/M5q5VD/6hqQpJA5Yba1VqrFPoDiFNQHhDGAJEN/2lqAPRGfaKybbtq2w==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752488010}', '2025-07-14 10:13:30'),
(46, 'page_access', 1, '5W4FffR9qee2wYy6oMm3e3WMQftZewJcFqrgc5CuEA==', 'Wzz9dZtbNiCjOLfuDBPD124JPWEjCzSQHSkzBI4uJ0S5PIJwUjVQzQpiWvw+nbYpAGy/QecbrkyVGzJzb7xJFN7M4A6fTuTbq//gMmPN100JSm/JmDEuuNX6JySD1z0l1kdE1z26tQnAIKsNLy6c4rMuhXVkXFt8UbibkTTvspI+b2QxUiYEDT6vAA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752488030}', '2025-07-14 10:13:50'),
(47, 'page_access', 1, '8/6JGwG6fBfVGk0Htuo34kqChOtgkeMRtbdIH0sdsQ==', 'WYE5XfmqTq/HzK6vG27kclNoINZYQlrV3FjEltOyXveJxaZ6MD/4OkIJj4pAAzgIzOF9UtETSchk44aWRT1MJJb8ujgfhpdRpr07EAhAoNTimf367YcLvORCGhYI4Xy9lJMhfy0TAR9ZfSNsT7Ub8gQaf9QVuylqnVprvPZrGUu0iWoNEM4PeFeZYw==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752488042}', '2025-07-14 10:14:02'),
(48, 'page_access', 1, 'AIiKzNvxTPfUtSiAPLPgIjbsZrKX8SuCkJRWmCU1TQ==', 'kkN+c38K0y0sJ29tDmUP4ncOyAgJlYXsrqWySqMFHgc5/hrSzKaPwNRXZzE4Hf/w5sGsaGMIYC1gvWYO52/IpJIX8KFgdqZNOMfZaVdZmaem/mMzqdxRKTf4ZJgrCBQlYxeOEY1AdCJhBbLmTf5Srv1gp7k35Z6JtU0JOxNsilLGTipq52UYrAeUxw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752488045}', '2025-07-14 10:14:05'),
(49, 'page_access', 1, 'Siu9r52uCGmVi5QwJvXP9Q7hOru0FHH2Few6StzxFQ==', 'Y5Tb4iaSIX7YZR13WFz+1cvkyLI2yDVWlIPizqUYEQrI+jjZWv6BekZLztL5yoF6eVKESYoPlSWmfgQpyUf5zgMlig3A18+ne5TQ4cKvO2V1HJ+hvIieTDC0x9BQWJdvdn+MZSHdhn8LbHW9r5PDUuWVLCbuniXJZqUNjX3HamvQlUM7Wah0SvfWmg==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752488061}', '2025-07-14 10:14:21'),
(50, 'page_access', 1, 'WKrsV0J38dUxEZbrUxw44cCQMwat6mcO+9PsxBgOQw==', 'I9rXLO3ddQ7ZY9U8E32sqTLd/m2A43vNlgRHDqDKpjecEAnf3APEOJKjyl9Tt7DiqfmoI/mT6VGXzUCZC6rrJmOLQXl6uo8YQqQ/Pe5hCRU1bh9/G1ZN5k7TpyKXk5/K2SGWIBv2SRl6VaMBfVIZNbM5F4VXiZgThjwcofM1YC4H3JasztJghtpNsA==', '{\"page\":\"activityLogs.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/activityLogs.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752488064}', '2025-07-14 10:14:24'),
(51, 'page_access', 1, 'B/hy+oHinClr8SGGzZVl0o98BrLvINMAJENSkfYRLQ==', 'VenLD6Tk9rHKQ1421ycs+6qVX0C97LyMgCYNsDZaeEY/GeSmMJ/kdkdM/l+oR7tUD+M6Y2mbtrSEZFEaIO/pb8P7+8TWprC1TXyfOl5QhQtA2A0gWGdHXdYTrSIPqNNnbNzQfbcOzDIC9CFv6Aj6iL/mBb3asHa9q964Ep/p+j3Z0O5nlf9sUczPYw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752488077}', '2025-07-14 10:14:37'),
(52, 'page_access', 1, '11JF9pCUVC/BiNLi/Gie8sUP9EA7d6HhI8hF2PtJsQ==', 'U4onKzyTsi6/Is3t749qktle4cRGFfDavKOb69GeSalWMJLU8DFOvGtDTCfqeg/jH391C7MYtiofw4SP67qt+z167BhiGm8+Jp/JUh90km1Wa8+TaD79ykwpRhDeBjLUUWdhqyjjfwXNFeKlb28NmP1mmMJet251CUMsH4VPQ8PxAmv3Ogj3Eyl+EQ==', '{\"page\":\"importCsv.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752488678}', '2025-07-14 10:24:38'),
(53, 'page_access', 1, 'GPovX/1cRU8+kP5CdID1fmQHhNmr7hboz/Ocz7Hy4A==', 'XtaHSwnxXj1yXe673g6b8uJCHWZ/4f/QfXSyBFHqSxEiKM73wyT/zA9mQgLlBlwW+rYGO2hduYdCKIzRFK2gndIQ25/Lr5+J4kIhe4YoRoRWUi7xBXXarz/ZyZM2pPeOuxjAkuhefLZAjJRLwojWTEVNeXkaCr/udtw7RIPzvp9rrOCuvee1N2hHsQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752488683}', '2025-07-14 10:24:43'),
(54, 'page_access', 1, 'Yf/+9EEGANaDnxQkFL4zuFlbF8TQ8qX05kGEHY28Aw==', 'l4puGSsyxpyXmWxx93LtaEkJpxqA6U68T/R+WIHCu2dGbgB7HXjWLbeoELudfb8FVQ+URdz5Br6udnblktWlJ3nZ96IYRxUjA3hhNGHsKnRocYVFob/TYmVH3mU4imTY3TmLGcBQ26AE4g41W119bTuEeCGTbW+YhcVg4MJFfWkKFNYV0E4QQaihnA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752488688}', '2025-07-14 10:24:48'),
(55, 'page_access', 1, 'ZsW+j0DyS6Ses1QRlPXl4qnaaE4jamb55GDuv5m3BQ==', 'fNXQik/OiVK/Kahsy5eKtWQ1nQ5iI535YqjX8gF0QZyeGGnlc7hi5D3CX7EVS5WbZRSmYi0GUV57rS9HgtyS0sMbsRu/G9yeBMPzn+oPIEB0XLOETh7Weidy/jehamjypa1g+wyUWoTDngXXxtN5kKI7IaIBJEnGhg3FRRK/nDjRXvNo3x3okJPYHw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752488691}', '2025-07-14 10:24:51'),
(56, 'page_access', 1, 'MFkoc/MZ/tOfca4bUa1cYXY7sooho97EWNwM/bosJQ==', 'X83xHpQctfo4m7H6tDgQnbtnZs/NH03qbrI9MK4nEuuT+anhK6wWWPBbdZDNjj7txmULIgRwZaat9wioE+NaC3N/iGtQ5VoozMuk3R6AYQuq1exl1Yw1yyDbfY+XMKh1lFzihpzI0zjhuBwB8kATFwHDq15sJjb0kY4Ki2nrB6fsqD8M9FVzKqBk7Q==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752488697}', '2025-07-14 10:24:57'),
(57, 'page_access', 1, 'C+TUcOiJzHQ1yA8G0yCk207wmlAdduWpwrQUwdYMow==', 'aE7v7dtpshMjecjxxOUkZP+o9y1nVPu8R6E2gn0X0hIBlQYKiDPUKxhboJURK72Ox5A4uA3rBrK9pPvKA7dJbpIQJNm1V7ZxHMtxZo0a7XbiSxE+WStB8BmlzzY9TUtSm9a00ZXbzzmNobbjUGY1nXpPix+ZUUv7tnXPreKu2M/hOZukjPCGIfLhDA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752488879}', '2025-07-14 10:27:59'),
(58, 'page_access', 1, 'VFTWBS9PHTZZg1lGrsZlbhs3496z3Hms0F/6lRio1Q==', 'KEFY8K8qdrUrbSp4qulTCokWgyNz0PRvA8QCcwVuYw4F22ZEWZa/ZQy9oMBMhp0l4XeLj8Ol2IfOfvcUlrLl1uixp/JSXIiUE5LHrWztwwp0LJS4vVOcCPYTcv5vHhCuDk6w2Wm9RHHGtFnOPYDBllEyqT2pyRWagEfGRw+B6dwxdmzMVBnlTxwOVA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752488889}', '2025-07-14 10:28:09'),
(59, 'page_access', 1, 'oBWg8pJVzh8wtxoCQKDIrpFH+Pu+5iBrwsL8ngPGDA==', 'lPpqk9qxx/ESIe0Fpi7atBsysaeWQti0fT/75tfC7/CiZ+lreRLEERspzk6cHALsWARu0NsmLsBcF9vBEBf/PwFIDgDHUaT3RiXLCIeMbFiEokUx6cTM3qfmuSPZM6Zlkh2uEO63W1DkPkRO5Yf0AvEufgGZuk5fLuvMPcgm/5oR9b680Hk5b8NeQQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752489110}', '2025-07-14 10:31:50'),
(60, 'page_access', 1, 'TLLOEtkFTNgOvNIoTG5XTE3XkMI/abJLkmYl4VvUJA==', '+KgLOSd5Cb+mJyTFMACYSH9U5+GBSwCBel2RnTaG06eyCp8PhcNHDwUskFc3D1WL9hRTaKjQDe3msKAfH8/x4Z+7pKD5q+NFRbD0THCeqESty0j2VCjB9JVC7lGClAaKcyCTMNplP5hHfGVY5Rkpjl3pXLpGbWco29cEH3CDumbcOEaQ7/xAP8feCw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752489166}', '2025-07-14 10:32:46'),
(61, 'page_access', 1, 'c6pUN1tlHgyFRqjG1ypV0Z1rjJepQj7neMssQwRHKg==', 'pnlEKC2QEslmd4y/vfGvOdrYRl8lzKpxoZGBEoS2aBtoqsY3M0Z7e5f4Zj3A4GLxeWdN2GOkgBV1SFTwSkFtVZ1WHDg+QKRJSKMN90gtXnmlTBD4LDmV/QhWRxuYRhSkbL+OrJMJyI+UlowiqGDBY//6qX/DRhHQB+lFxqqIbG/i/dL7n4HNZtdFSA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752489167}', '2025-07-14 10:32:47'),
(62, 'page_access', 1, 'd9+gSo94o9b4Rwd/uGzlaTLGvXmbIz21FlRudA7sng==', 'luZ9k+PZwet6T55kO8Ar1LvHR0okVxCF1IHrLGtDhS/Awya1bLk61yeYXia7MPOXitJFlqLv6oE5SnO+tULN+0XRA76CimLRmbfBaRJ9nEu+G4edClvhr0FBRFQ/59nm4SrLFY8Iy83MGq5/t0Q8aG5cJkRxqmfdhuFod/KrXpLq4Dso3HJ+MbPdzQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752489309}', '2025-07-14 10:35:09'),
(63, 'page_access', 1, 'be/hCJVl5/34dqmRDrH3I9+A7tO4sf2zjI16mMSmWg==', 'qg7K1xYLsflaHA8cAMDMkbBY68wzQdVz2ISW4+SOqCx8emUgGsVh9Ux8vP0BYtnHa5M5A7Zp2AmhPFR9NQC+osscvmYj5t9tv7Jc8wcCcnJ2sbdcksOV/8g2emUGE6XdJGbWY+IRsqSSbCjgveOoGCa9AESLU6uIbw4Ech64rZD0/zcJF/A+zsA4Vw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752489311}', '2025-07-14 10:35:11'),
(64, 'page_access', 1, 'TX57oDgKEvpsYKuU75+cZ6FxL3hxPUrDhY3AIwDwOQ==', 'OE9XzGqx9Dm5rEck6uBnp2MBhR3EwyGzmpnvu+j62XvZqOxqurNXfM7NMZOst3/IgfiFU8Hge5w7+JPJlOcBTIpYPEfQbGs3ppn9YIVdWsbcZ/8FBvLgjgs15Qs+Dxm/qOQr94nZT52rTS9wTtvkHld9DmDQnLyqYltrhz3y8DD81rXaGcXO56C+Vg==', '{\"page\":\"auditTrail.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752489313}', '2025-07-14 10:35:13'),
(65, 'page_access', 1, 'V8CvIMpYiV+cXLTHRrONihpSAcl72arYN/lgB63eQA==', 'M+LHhRhd3K2ERhmaUkinG2gqJUYwhTx+hzXM4Fe1gG/qcsDDZBx2xEpTm+AffVAWyk3dm3hVfLGIOWFAxrHoK3kH9WQg6hCQfXSWVItKegbRNL2lzSCD0hDTfXZ0jXNscliB1yFOomcmw53R+Yft2ylMzwPRAEovV2Q3qwnMlns9XyYlwNYAZVsl1w==', '{\"page\":\"runAuditMigration.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/runAuditMigration.php\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752489398}', '2025-07-14 10:36:38'),
(66, 'page_access', 1, 'JvnaqNm24Wqn8GJ18afSdqU+8LJCoxFMf02LPNaCfQ==', 'mCOwujXC0vLUuUBkJz0L5VVOW8kh7m1dTVWL8t8op62XOtArWQL5DbiPfbRq3H4jk0rgHY/odslPTDvqG+Qaw3LSzO+RIxBSH07dbHEnHAF7v6sxII4h80at0iyEuf5ykwqPbasBaF96cMUDN9iYDJPD48WRLBlZoC0ROqFNBainCpmpXFR3YNzZoA==', '{\"page\":\"runAuditMigration.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/runAuditMigration.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/runAuditMigration.php\",\"method\":\"POST\",\"timestamp\":1752489406}', '2025-07-14 10:36:46'),
(67, 'page_access', 1, 'KpTd8UPSaBEm7MSsA8G38ivKiciJPxBD7b1Ln9ay6A==', 'kBPi6mAFZCMy4zlvMz6vzKvTl+DcNLwusL90DvJbQum9ShYdscs6SOfAnklKcc/CJlKklvG7ZV3fhlXqiPYS8f2Mt7LEunLnVvzeI7SWBPUJYgeYdRcQTfFcv4wvraV+23uvS+RUxxwnJmTPtUSOsLA/7LVx01F+nKI36lQ2Kl3LCVUEVF7nggVXcA==', '{\"page\":\"documentManager.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/documentManager.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/runAuditMigration.php\",\"method\":\"GET\",\"timestamp\":1752489457}', '2025-07-14 10:37:37'),
(68, 'page_access', 1, 'VTpJZUfsTPcyg6fO7q8csYUPW6ou6hMtqmOOC8Jhgw==', '12ABXUCZ8ta8ubm8Kqj6Iox8IXByC4R92OidatYJ+I0pqadwZ5EFQVp7Nm6qoFth17zUsTdlLxppSlNFnfLvnoZgBavQg2WisNi9FcYPfSbrgCV0Ji1IY2RzPAxT88cfCejiIh3J0oIE/ypsgQAf0EB+aKNkjIbP4rhn2PnqiiZeHClyRliHjI4f1w==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752489486}', '2025-07-14 10:38:06'),
(69, 'page_access', 1, 'Q9EVpxr4mx5si+Of0VVfKBmvPfzlVl0LKc9MT7sY9A==', 'JyoS5V1NyK0VV9mE5pzxG6VvziSjZtMEzObUhEy9m5Ko2JriMkDPCLSXaE9bm9NlLZeHVF+9/QQ9+FGAURw0tACiJmW+cKh78Azn+BU8RmEVjAoYKhElmYKknNT/i5R4OhbGjghh1IAv1eppzfEmYeioXIrlrpOknyVL4RLlfq2vIpmYv/FtigjNzg==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752489507}', '2025-07-14 10:38:27'),
(70, 'page_access', 1, 'nB0mKOsBNqRQ6iQ2KQjTjfqfw3MiI6+nhG2NjxBnDw==', 'xS/2Fc8a8tDET/0+X9VOxnQW2+dUPo3xrCcV0Fhd24gG4R+Mu40e0lRA0Jd9dQEq9DbtZw/cS/Y5ZRryCxyVmNMgXiHIxIehJIOoNtDv0CWjoTzouTqlJuDN0X8vA4gKtLSNU/DF/B0AFTOCICvtCQ0UEnDAKTi/lSYFW5Y/9c50nmOfdcKoVvcq6g==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/subscriptionManager.php\",\"method\":\"GET\",\"timestamp\":1752492320}', '2025-07-14 11:25:20'),
(71, 'page_access', 1, 'FBiPbYlQKqB7JM5+UTb/xRankddlB3Fxwwo+TgdQ1Q==', '2IUYyfZqFmKLuchFtGuW5Z51L/78TXteo2YwD3rQfNt4qX7YNFjL9cUGbjuVklzsgL8kgSBvkFi6vc5mD5iY23HwHCFo4BCWXkSWXGN4wPRlwTCFYQjRnHC1oKqQ6uuniYjpE9woJTx15b5Z66qwf7gGgqzzaGH3h09Tip9UdOu7lSKEMlACd0CtRA==', '{\"page\":\"importCsv.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752492326}', '2025-07-14 11:25:26'),
(72, 'page_access', 1, 'pqwDyg5N/7EmhNEqe0CJmgo66iI+tDX8G1cNSZ93Xw==', 'kIy+1TVZ1TYo+Sqn7Tc5UsXQFP2SDMvAOZAEySt5M4zkOJNXPsB679yvr1R5vgGXwuXAUeh0n1ebV+Pr02bRhH2crQ5CEtZqSlxP1ppvTYCQmsvR5ueV/wbImeQ5s8BZzFVBQnbAkBz5yvV9BuwiqG3pwtMOUIAC2CY5nkE1qJCLA4Ix0heWPelEpg==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752492328}', '2025-07-14 11:25:28'),
(73, 'page_access', 1, 'lqbQFqSlkxj8m2fxAOQpd7Rgzr8XDt//K9mOseVTNw==', 'e3Yi2XZyzOukPJkKPsnfV77VYxocv+IOMdAv5tBXmx9yez0pkXoTH2PY11qcXLAoQxT87EXukG876ucGytlFzIroD5hIcHpbFZxSl9O9GOUtjWiljgsoaeGblAGuuJ4d9qM05b1Z6hSNjEmzDDKtUe/y3PEbwHXnsDgs+59rjh7sfwmYb/8qzC20wA==', '{\"page\":\"projects.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752492330}', '2025-07-14 11:25:30'),
(74, 'page_access', 1, 'FUqCcMYRwoX0o8KKr0Q6rSC0+rxz6B8N9qOHvvGUmQ==', 'Ra+xXQ4j8MMis6UP+Ul+fNMMg+xX+3SotYyZPzZ9kUWP+MB/t+L2OoC5bMcsICotSIXD6ZaYzJmEx8fy10po8ZyQngxjWqXvnGI7+K9/Mr6+C6rBbkD0J7nc/oMi4jI7M9wWI/z1g4E/cLwp+qa9C5fG+MOe3xcnUyKXUBwM09jfgfBHBRONAWD2Fw==', '{\"page\":\"manageProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=1\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752492337}', '2025-07-14 11:25:37'),
(75, 'page_access', 1, 'IoTh1oX3GKF/fwNfGxYntynfAeB6ek3K21QR88UyGg==', 'h+ca6KSaTGG9MoEclymuMdeKshwNsqD6XE/savbIhxZEtgWM/GK7AQGLTZdIpB2MCoj4xkL5EZ8Mfaf+/JcHljWthK5ZRzBH839NdWvZSosWc8+QqzBt3mv3cn6vxRnMccvgDcWwO0MInEaOmHb+1mD5ABiOjHsS0xNaV9SwurRRhTPbWbRTDNmstg==', '{\"page\":\"projects.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752492357}', '2025-07-14 11:25:57'),
(76, 'page_access', 1, 'wmnaFeemDV6HkVpkgTqYF5+bhrRU9vPpIxBuf8FfYA==', '0wWAVVjxtpD3dMVj6LYt9aHfYKlK+Pb2B2DOcA898wcreySlBKGLspLDi9BjCbIh5X9a8pMn6LQe9ky5o9grE6eie3D5Yee5YM+Uopd9+dWxgTmbidciucGa61bw4ber9REBn+jSZ8m1Udwq+SMt/gsDF3Fl8p4vYojuOvq6j1udc194XMgWUdcdmg==', '{\"page\":\"pmcReports.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/budgetManagement.php\",\"method\":\"GET\",\"timestamp\":1752492363}', '2025-07-14 11:26:03'),
(77, 'page_access', 1, '6tNQRuvC/J7nT7JlpHd7TDa3jbkWHqHspd5hMX5PWA==', 'V7VkPZfi+vjFJnKae4kvFNjztALuUA46Es0As93KBqiudCobuZUQLudIOhPXrMPiWBV7FRMbak2KztPHV6KdA0WeZVpbrsUvupPWfJGnyjJc7Gpq+WoSE8g7eUrFc7mb5AZZgMu6YUWSPwjLN0VJeeYPo3Wtdct1qrF1c6eP2K1gof5auOD14Zh2LQ==', '{\"page\":\"documentManager.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/documentManager.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/pmcReports.php\",\"method\":\"GET\",\"timestamp\":1752492365}', '2025-07-14 11:26:05'),
(78, 'page_access', 1, 'gwYmFRPPB/EGCiI4MIV/vpvHDwRmFlHHy0hZLmo33Q==', 'ZW9A87bVX1OhNGRIQZ0f5D/BQcu780RikIt9ZDK+QFMFPBiLWpst2V9SYIIGRBgD++UHwkG/hK/Og9zBsVTqc7B/azO++9dhONOKnJjlo+ch+gywUYVm0Tge5ve/CDlds066MZGaQPO+mZSueRBYT1FiiQ4zSe4DKVAJ0eRkCH+GKU6vm6UE4v/bCw==', '{\"page\":\"feedback.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/documentManager.php\",\"method\":\"GET\",\"timestamp\":1752492368}', '2025-07-14 11:26:08'),
(79, 'page_access', 1, '36LtLb9jtZgHNzY8XbechYQfVAgiXa99P+TBpG0Dmw==', 'QWIXem221/bKITesH1K1nLM1Eys6z1OWDTddUydVAm0F1ZWrbM+uXSpYHEM6Xm6zoc5naGIMw/k5Ikq5BTl4Jp95cTYzMGjPwsv+mxXaeBVfN9GMuiJY7Mu4LbvVOYSHe2647ti0oPI85tM/u1hQwThfnyIQaNMl6HhWtjyP55OcA7x0k/cdrwk3kg==', '{\"page\":\"grievances.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/feedback.php\",\"method\":\"GET\",\"timestamp\":1752492371}', '2025-07-14 11:26:11'),
(80, 'page_access', 1, 'wlCacd2O4kTi8Nnlp5mWNmvCQgqbzUhmA2CMb5DULg==', '4RKNtIIgxvHFgpNs1xx8JudaG1jBhVSB/qs5f4SowONWZAAVm9hO5Bj6advM5d2YLyPK5u+/SyLgnUPMwJFMbKaZcs5zq95QUmr0x5ZA+CBy3+HQrNVTX5TWEAf1qcDf0ZM0BQ91S133Fgx1v9Z1WAGMu5pASTWljHHz32/Qs0DZ6+bIJP3eUw8ifA==', '{\"page\":\"rolesPermissions.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/grievances.php\",\"method\":\"GET\",\"timestamp\":1752492377}', '2025-07-14 11:26:17'),
(81, 'page_access', 1, 'u09Y5XPqySS3GQ3tNWCmJuxmaw+JOXo7U+bUqO1W2Q==', 'Zv2vGC/Xw5LvbOBU9z3K56gWR2S2oYaif2sibnza7QGDLknCCmYoX9yj97k2Zc6bE8uN33v8VH6/nI2TM2ERRYiOMJ9/5ODzF87w/DWMKzs2PmIi6265I8xAW+HcNIw34efLYMceMIGorazdo30IB9t90Myu5iju3iDp1CS0Pj5NME9nAdR89BnQOw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492384}', '2025-07-14 11:26:24'),
(82, 'page_access', 1, '5nWF1nKBwN0jryA7idSicz1Pf8Y6w4U6qc+WcUA2LA==', '7cQSmiDPnNBCdI1O7LYrRT9d/ECMPD2pmsqsr1FCIQ30VL8xj8hhA9MCDoB1XNPlg3TOMLySyiVD8L+IEv8QX7nL4WBGoRyOLpQbX1EmKivedMlvqk35rOFJVc2zxyj5BgD52c2qErbgWkFg2GKSELzci7F/NkyefDrY0z4Iz8rND2p6wftEY4ULRw==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492388}', '2025-07-14 11:26:28'),
(83, 'page_access', 1, 'mGls2+W9mXpkVclNdZ0k8KaMoLEXcnM/m+L7UtbFag==', 'Eo0CFi0B+ZlFn4ACWEBohdvZBn3PYpPKQKCInIwwr0xunAgTTGGMsCETf9YPbGyRpIAR4mmS2/b09c5D0q5QvlOQDybgIR2XBsrZEQo7jZeLoaQk1qALj7dTPVNStEs1+Y13b9qntX5dWpxGDuJWQlWajcztsDZE0xSO/1tRLbixxkzVQGOgRiNr/Q==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492392}', '2025-07-14 11:26:32'),
(84, 'page_access', 1, '+KRxtkJEhKFCAB7IUIRpr80LBE6kxQffiSF1QDtiGQ==', '5bs7UDycty8Y2Q7XURoFZr1fzDEnPB32p+z/E43AbjRI7hG9iWcAilP89GoEPwAs6lHuxZhlZwvBE4XnJa5MPZzZGa9gU/z38S+r1OqOsq9e9gbdEVyiyT17tWfUxbqU75x5M4EYo2wo4GIf3v4hJKwp2N+WxMz44oSHZW7jImVv5psuLfH4TjEPPA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492397}', '2025-07-14 11:26:37'),
(85, 'page_access', 1, 'rvPi2ptTNatxarH0e+hOCOL+RBD7PdiilaO7E78n4A==', 'Q5+2Sm36hCi2BobXMeC8CcjvS1yHI7FQJvC7o23/kTSFMVnLs3FYIx8xs1DTmBeCd9Ot2BVifUwpVXgs7CD/8ZxV+4Q1T4GwPp3j423ln393grigr+xeAXqexdj7zxXWTy95cy1/kAdq0JtbCj1L5ufmtzoJkzEI48VbUT1jBoDp0/mIqAH8dd0/ZQ==', '{\"page\":\"activityLogs.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/activityLogs.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752492400}', '2025-07-14 11:26:40'),
(86, 'page_access', 1, 'xxvereKHKZoK6Wu3fPdiQjC6ttsDq/umGwWFeabGrw==', '7u8WhhBNPIWK20LX9lF4oW9gfRYjtnBa/uL1F928n+vHnQNfS3i8quFGbVnMADxGOTECwOqbmsJYTPchchDcCb822LLwCCfIWCh4OesC0GzO/1+ke+oS9NFCGCYZGvyUpXUgS8fCXibBMAbuk9vaft+u59YznOcmEq5XG8U7vnqcIYQ6n96TAwBpyQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492406}', '2025-07-14 11:26:46'),
(87, 'page_access', 1, '8CJ7/IQHv+fFmqCjepN0k6Uu0CPepYF5F9tg4mM3pA==', 'X9ICGd9XQ0I5sAQl0cr2TtEElNomYW2UUEGJeVmypsk7NTsNVdphfu5lS7VJv9mvg+QnORRL2uOORB56Yoi9hGov0n2C3pIVWxRmnAUQOMOTgxvoQkRFRW/doS4guEQhlTHgcWX+LHgp+IRv+t7dGG/u/A7zKJRoT/faxnY4LDwOk2BRMUB1o8N5jA==', '{\"page\":\"commentFiltering.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/commentFiltering.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752492409}', '2025-07-14 11:26:49'),
(88, 'page_access', 1, 'bZl13YZqvi1xuOYgp9vA4x6EOSAiFs65uxZLsScqbQ==', 'XfNhEi+QISLoZBfQY0EsidAFZqiZliCfWYAZHFXWaYh8yfVvInSuREXf408QZLd00SHu6SUbC/2wPWkFB0rxq8E+wp80PlDEdygwa+MQvjVXn6tD7F31E6e4sJu7ZLgfd5JgRmsq73w5jKtzX1tEl4bYEHSb8MC4J6e/GF04EfQQ/6b9AupDFch4xg==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492412}', '2025-07-14 11:26:52'),
(89, 'page_access', 1, '+N5Zei8eue06dL6VWS6aWsYaxsSf7slRVkixSnwGyA==', 'J0Z+XB4cpqvT0qTxAB/Pxij6B98RyZM2jb0l5hOVZqJd73gFXQC8jwRKlZoyP7kejCqFYXJtAcXgDX07s/Rct+ZWd0oOSs0dV6LYPe5QuIlZimJYx8QOzu5UOgVYHQBoMN7YPoxdTShB/SfkcDv1NRIZkTrM9mcGvSHwb0gyUA1p4Hv0npsvTJg2nQ==', '{\"page\":\"auditTrail.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752492414}', '2025-07-14 11:26:54'),
(90, 'page_access', 1, 'ESXcRsGjIuPaSgGdb5laPyi3UlPrNlVelHWpUKlv6w==', 'Iw0WvaxYT+AiipTqiK3w0AP9iD/LPvBKrRSASgzNkQ/v+9ufSuoNMDJoRnOAa23ijJK92DeB7N0Nh0Bz0ZayJtFfRgzCPBTHrqdiiVHszmo5iVxir9Z1sC9d+uqK/WBlp/z5gY1kCrY/4w/XfOnETZBMoV2o+oAYYjc2bUKny+66CJ106BfvZXTqhA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/rolesPermissions.php\",\"method\":\"GET\",\"timestamp\":1752492524}', '2025-07-14 11:28:44'),
(91, 'page_access', 1, '7/hsEZ2a+8pNX6vzm+/nA3XS/HR0Qghd38D8EvX1og==', 'PYf4DXyKi4ojCoEbQXdNx8+EgjXPRF4T1kCgeHguttQeaUiIMJlhSWKA+CE6kZBVXVSXLvqzo84HqbHVbpEfycleeO+2XMw3X1btvyc5AdJVHRw0rtAbD0IrgAsRHhzuExWS5YZcqxgLPYqBi1CzbcQ4yub2p2Bwsn38kDbfRbIiw6vcPO2u1kTLbQ==', '{\"page\":\"importCsv.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752492552}', '2025-07-14 11:29:12'),
(92, 'page_access', 1, 'tyEGAuhWDh7t5qzM3yAfqJ8FxMlA9nX5pXAOKm013g==', 's7Iob5giYC0Fti1fYQNEV1uVUQpT2L3fJNU+zhfWvG0UaxndmplW8P43EHyvk+4b8qnflJJ/1PYtUzl26n23YI+p9hntED/hhRx/SJM2RwQZ6qSe4dI3nf6o5jqXt++q1mDHkH2sRFihasbGdb0zJsGiJZFq6xTS9pxrSLwbVt/IAcH/cgF/Zp/vIA==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/importCsv.php\",\"method\":\"GET\",\"timestamp\":1752492556}', '2025-07-14 11:29:16'),
(93, 'page_access', 1, 'ti+LQrxzCoDdOj7Kdw7lI6gXr96uNqEmR7cam3l19w==', 'xg79F4mBnB4rIBsgM79MmV24rpraC9mgoByen0fzPyXKDcxqgUEZOff9gSkMG9tfPqxirmZYP34Z9yf2fLuol9ozzk2dqrHBw0eYckS790yt/32UEfr1ShFwzfeyymc0Rdaag6QPG/ZMqNCMecttavYvF6G+OrraDUaXEMI4JXHVq4KQ/iWTaZDyXA==', '{\"page\":\"projects.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752492557}', '2025-07-14 11:29:17'),
(94, 'page_access', 1, 'TZMUth25BchLfXFeBRnWX3vTzm+0cUqi9w5RXuwZwg==', 'JxwScvaZGM8Zpxtuh2ZiKnczWNyFjrajwXmlCIqbQjNv69r5mmveaKx7pOLBcfMLhQDgL/h/elk3h4JfUL6okuFYuvW6i4sQImmKvbI0jAnypiy8vLk/SXHOF7W2mqxnUQNJzIVuZ1ObzxWGD4+QTR5T0jzNU0+En1cS+qB4WEpHnafZGoMDIFllQg==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752492561}', '2025-07-14 11:29:21'),
(95, 'page_access', 1, '80gksrHHmBc2PncFpmNm5Fw03C+7ZKUf0r6Y6B38Qw==', 'JJ/bkdRn8/9JOrsdQtdQsJEvhjRHM9xHsDBD/rZhoZg5ACNJuFhy3AziMiH72wzSSZoIECrDKlmovX7mKHn/bcSybzt4QoRuwj1vCTM4W7oUthU+ZYApq6lUBpB/g2wuYMhj9Cqst64xqfmsImpaEvQKWB2xI90vjuisZX90VvlSLXnQeiBtgKG2Og==', '{\"page\":\"projects.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752492915}', '2025-07-14 11:35:15'),
(96, 'page_access', 1, 'gro3ayVGs292gdVxVU6EzlSmLr0dvbJFsSxEakhk0Q==', '1T6q0VUDawsB0vbO+ILYmhKbotWLQ4Rzh9+iAOdvuPfPTYNW+SECfdJgPf4PtbnekJWYMPJjrotDdeeTwAhmp+PiTwxnYs5vcS5loEyyHcNM3smypD68jpvf/aX6h71gcFjnPmLWXkC1AzqTR3mI7RAvcN0bJpsl56Y8JN1N3PFelPXkpO6numJpag==', '{\"page\":\"manageProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/projects.php\",\"method\":\"GET\",\"timestamp\":1752492926}', '2025-07-14 11:35:26');
INSERT INTO `security_logs` (`id`, `event_type`, `admin_id`, `ip_address`, `user_agent`, `details`, `created_at`) VALUES
(97, 'page_access', 1, 'c2gKt4vfjhEQfCKcDukC1PxXiJc+FYb4BPlxzRhNTA==', 'l/J7Enuzf36AU5iT1isz6E+UAFcVZ3jnOQXcbsvHvQjObDSGj5J2jbtstN1rf6zQGajail1wX7pgKpA1qLRD4DIhQZQ+nxBuPV6hJFnXbJ62NnCq6w6DMOkBsoAP1FzndVt2sodDqzBvTTqyN0x1rIe57Fb1QQb5a6XwgMA+qx8nkSOAtnaR4Bg2FQ==', '{\"page\":\"manageProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"method\":\"POST\",\"timestamp\":1752492934}', '2025-07-14 11:35:34'),
(98, 'page_access', 1, 'G2Xar0+30k57pP5JYHCMLuxZb3/35JxXGcnMvgLBrQ==', 'zv1zSkEzBxxBRXo32kt6YZV0yp+DdhmyQdS5VYGwiCZ+WmfqomSym03mO0W/fmm3/vBYBhUXO4AonGJPzBicdwE+UZGG+cEvdCh1ZN5HC6ZF42DJVde0wa6dCNMCifAqSBVa1189D6NRTuuO7fu+xxqFIdmSNulfar3eXhV0ytEhv4l3DXziqf+2Kw==', '{\"page\":\"manageProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752492939}', '2025-07-14 11:35:39'),
(99, 'page_access', 1, 'B4PAE/Edq4DJDPgBBBy2ctfyBbgDWdU9SKwJ9xdnAQ==', '5sbFzOGg5TDCXbiTWIYttjR1mi3Nzm7VBvuoJL9WpXuuff20uqusKra5Y1wgRX04kcTZKGy1PH5IQDkKpEZGn6vU62pu+LlZVyoxU9gQQla0ZPjfRSazzXBdMKDF6XsA7I08Z+7meVaIHjHxmIOR+tsEC598e48Xsap+pve+e52JWfA2inetQXhLWw==', '{\"page\":\"manageProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"method\":\"POST\",\"timestamp\":1752492947}', '2025-07-14 11:35:47'),
(100, 'page_access', 1, 'Q+thjcidol41WP/v4ljL8KxxY/G7U0t1WlRCFx3IDg==', 'N5TMyIhL5tLOaTKgdHhVW6Vmz/aE7RyHnBhbfkLDaKoHsguv76dpG1Eokb0ECkttXbyOxS4A63544KcTV0xFGiw0H52XvlwEoLadrdg9tFh0PXI3N4Gtdbdxw6Tt0hAI/gpMSlqylqbCjpo3w25WnAz386O1XRn8Pq6puj/sPB2FMqZjlitN4wfzag==', '{\"page\":\"manageProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/manageProject.php?id=2\",\"method\":\"POST\",\"timestamp\":1752492957}', '2025-07-14 11:35:57'),
(101, 'page_access', 1, 'XR+oRHAlXcRS39Ba97mslBqRdqmS5oEYYogwS4KgUA==', 'aBpzgaPs+XTKbuPq/ZG6XDCSHNgXas5mDecRp9/rxq1NMvNo/2+IrhO5u6OS9A1m2eM6U5Ul75BL9m6rjIWbRqJS8Cd/1PNQijX59yWb0bdHHY6vFbpYV3pHtB6jwKYdNYZSHdJB+PWRsiMMvYAxvJMyELx0DClsZS/zGkQVFr5i8x4AGGSkzMlmJQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/index.php\",\"method\":\"GET\",\"timestamp\":1752493075}', '2025-07-14 11:37:55'),
(102, 'page_access', 1, 'OQt+wNS6em13AQ37cIeZ/fytt2N7YRvIoMROk1m/aQ==', 't5z8KW3bCpZX1Fid7dsJafXIkM3j7yKAGA2NjEpUZWE3bbOx3pxV9BgPppYAdSZUFgdSDP1uetAo2eI0n8HbnnttZhto4YUS/3EC+Beo6YJeqsj/cbazXpQFa97gS8UixqfQH+HevUTz0CpWfRDY+NRgeJxw/ckW5LhgRV1adjcinaNiMDrHgn1jjQ==', '{\"page\":\"auditTrail.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"method\":\"GET\",\"timestamp\":1752493080}', '2025-07-14 11:38:00'),
(103, 'page_access', 1, 'ra+iVcNVpaiUzbtJssy5J+Sh02qDG069/eRfWc7BIA==', '8SZjtRLNJG6/Qow+/SV35Eu2GsEuMr+f+g6npqNpy+O+7VxmI44CuaqahGfPS3Ckr369FUDjZdKfbzyItutgzKyN5e6AMkNlb3+uLEjOxmEHuYTC35KBg7SWE4BZL/Jipw8W9Bm8trSCOPP3nQlKXYn8b9yYR6HtaFltc5WozlBGkrU66SOF1XWSPQ==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1752493195}', '2025-07-14 11:39:55'),
(104, 'page_access', 1, 'YLIYT5H37IMJXHruHjlKRZKywet7RkB+bXkYnfzOfQ==', '51U9n5Y1kZMAOzKaJAFzOk9XUT4LGuzJBL85fls4vQmEJDbZ8j0VmFpx2U8FU9KB8fPwv0OvZI6GhJuR+/tCOkFf1l2+hvSLD4/XdYYGp/iKi7o6VjYK7UAH2w4Y/1fQs33QyHLq7T506xa8op+izYQivCmVxCzn8lEKv0IEMaPZZSlB756u3AxooQ==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1752493482}', '2025-07-14 11:44:42'),
(105, 'page_access', 1, 'uooDpB2/W5Ubrt1SiD/IXssamEUfpE4Gvtq3d9xL1g==', 'p1d0qlSQEGzoIQtj6dgp7ZqAiIZQrK3+UuPKCDpO23+S887J+6pLbUZPDhTdW3bU7NYBAhcQMizZNX7HADkI1c+ZVHkznQI0ytWZm35zaitdHLwTsvoQ0Uu92/VyhXA5qUum5zAihSeJr7n7ioA01O69nTjn1DKYdylcuoXF4QGSYjx3PbMogiMwKg==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php?error=Failed+to+create+project.+Please+try+again.\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752493587}', '2025-07-14 11:46:27'),
(106, 'page_access', 1, '9urkfj7uLxLFVfMIGFVymzS3E/LU0MLpE+VsXGqbww==', 'CUdbNIHNdFNrj5LUus6qKkFf7S+vXXtlViNxpmPea5UDI+jECnEG42XQ6l9vxmg+L55zaP2VyEUMEVHxgPf3309FEdfHAxTR4NClWGlOEZupCWrymuFT01aNjEJ0Rh4Ejh74PZ9gukpHN9Z2y5n1JcImsmuprSOam8Rbd9s/syWYspnzog2ANowNxA==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/auditTrail.php\",\"method\":\"GET\",\"timestamp\":1752493600}', '2025-07-14 11:46:40'),
(107, 'page_access', 1, 'R/78u7RiHLaxW2DWfbltMdNHjyrgzkgNSD3AW5I8/A==', 'SSefWiJIri/zR5E/vdNMokK72dEXKn3fa+7E4LkbTz5xJZa447L1B9ZK83vR4+JioMVnrtgW1Bc0BIlKRj/eZhyBZoENV4s3BaGjf4XkHgHeIZbZU33Vx+vDSKSqmdYbPzYl5zp+G17UFG0GiyrfB88j/vUOL+JBS7aF48nEqFF3SWqzYHENCZ+kgw==', '{\"page\":\"createProject.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/createProject.php?error=Failed+to+create+project.+Please+try+again.\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/createProject.php\",\"method\":\"GET\",\"timestamp\":1752493640}', '2025-07-14 11:47:20'),
(108, 'page_access', 1, '/uqJWOhFfPC0ZmT7mLXc7VOQ66uQOMtshnydUIP80g==', 'kSTfhCHmefZT8gqsGlN4UNI4Vp6rxFyvBVAM1CoD3nBZgCVY/TRIk/eIgxXPbOQ9iIRTu7uXD866ldzZbW+ORqIrB0sH3ssoqz13Coentj6S65Fj68HsFyzE3PGD4PDo7itVXiE6qn/UD1He1VFWcBUo16g3iWIXiuFthY+52KpxVGOAki6scTZCFA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/\",\"method\":\"GET\",\"timestamp\":1752495774}', '2025-07-14 12:22:54'),
(109, 'page_access', 1, '5oCrZJGlSqiUpuFlmBc5XoXm4b/rSkMaw2wL6RZhnw==', 'JZala8pO5CExnNPEkHgOKNnu4VmlyRW94RSQZ75K7z5O+Al7MKUhznsNWAtN9Ly2oMDM6dgG0i0J0Y2HZ7s/KlFIF3OlwDIPj/NdNSVatQZ60NLvdneg7pSQKjK9dklxeXe1Lbb8dYLcFFBliz5h9dmXrYMcvroluwSEFr2rKRP7l7aRG7jxUyR+SQ==', '{\"page\":\"loginattempts.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/loginattempts\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752495942}', '2025-07-14 12:25:42'),
(110, 'page_access', 1, 'CVeH9ryV2ANdJHRl0ONb04v5mpZYjVp4p70q9i6JOA==', 'agqTbA3RMknl+8gdsGzD3CExZbb1eMnIL4rc45WUA1oSZJfJre0wA/PMT+P4JCwSpVA5CtFdXdqup/X5dhUmZNMx/6FuL5tyNUAt4tzPIDjaCY0aheQ5q3qLrwzJ1oNyn6PZQ01IWo/IYdOKjrw2pfze2jIbi0P7fGaRjYQGoASM75g+yOAK8SrpIA==', '{\"page\":\"loginattempts.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/loginattempts\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752496057}', '2025-07-14 12:27:37'),
(111, 'page_access', 1, 'YPfXcO1YlxLUsFjCGApUahMRJb3f66ptiVLs1bK9Sw==', 'q1g9x+VYAQJyfME9s9V4ABE08Wtta4ND47LQmiM5jfGa14ozonBcF9xvnxXMOsWVKKb8rZawqh8o0qKXFDp6OhS4+MHdmRMtWBovvkwaqWYEWQfPSQ0ZV51PpATKYugvPup8eRiTXrEbkubr/cHX3g3WBn4TaD/FLtXMsfX3F3XKb9EliqqPlposvg==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/loginattempts\",\"method\":\"GET\",\"timestamp\":1752496211}', '2025-07-14 12:30:11'),
(112, 'page_access', 1, 'qPGqHsWfHLLAAnOyH1OjiZ+mfxeaPGYU8s4e/ojISw==', '8D8z4qJmS6poewv8UKT+IG8Yh+heU17Aov1vxCZtuW0PYvcnQoW3jsP7H2jBooTXGBNL0cZ7GAhhWybbIe+8efSVcgu+hI/rbTDNL7cb+dqkju1DMayne2DO2thbpnnidU1ZV/AYcUKIR/O6ZDsEg37oscWv2oP060a9xEv1a/3v8AkXZZUYbpulPQ==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/loginattempts\",\"method\":\"GET\",\"timestamp\":1752497364}', '2025-07-14 12:49:24'),
(113, 'page_access', 1, 'EtlK9wzZg2SchfZs+vYxUWX7cy2fg/zodXonNqkkjQ==', 'M19ruRDbxbR7n3GO/qBPB/E73ygSIflvvNOK1FPCJD99vyehIfcf9HVj3QGMaZZ1RbZD0P9n6nKUHkJKuXFPFstoVFXbCx7wRrg2qvQ/OzaES7UBw4Pqtt1X/U4wPD3zGwtUgUIBnvYg1q8qb/AFBXz1+MghLWTuQQqCETxXHeBdYT+OThsnWemhwA==', '{\"page\":\"systemSettings.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/systemSettings.php\",\"referrer\":\"http:\\/\\/localhost\\/migoripmccamelvencrypt\\/admin\\/loginattempts\",\"method\":\"GET\",\"timestamp\":1752497369}', '2025-07-14 12:49:29'),
(114, 'page_access', 1, 'U/MibvEGP9bMDeuEtFMNSRKTypEvwaSZcnD1lwt00A==', '9IKGcuVrh52lqSkcSLVFAoBX8hDZKa9kSxzsN8fC3md8IZVnrNslwNhdiXv6v/hiNWRh3RRnkIAg4SZhE4tjJCED8d1M49yhmhYvzgoj04gQbhCeymjRhTbIG/sj/V3FBqMStWio2mI82Maenu/ErBnnhwAjUFs5av/6TQg0em9WXrtDCCOvWL3qkA==', '{\"page\":\"loginattempts.php\",\"url\":\"\\/migoripmccamelvencrypt\\/admin\\/loginattempts\",\"referrer\":null,\"method\":\"GET\",\"timestamp\":1752497462}', '2025-07-14 12:51:02');

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
(9, 9, 25471163680.00, 'initial', 'County Development Fund', '2025/2026', 'approved', NULL, NULL, NULL, NULL, NULL, 1, '2025-07-08 06:48:53', '2025-07-08 06:48:53', 1, 1, NULL, 'County Development Fund', 'development', NULL, 0.00, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL);

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
-- Table structure for table `transactions_ledger`
--

CREATE TABLE `transactions_ledger` (
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

-- --------------------------------------------------------

--
-- Table structure for table `transaction_cbs_mapping`
--

CREATE TABLE `transaction_cbs_mapping` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `cbs_id` int(11) NOT NULL,
  `allocated_amount` decimal(15,2) NOT NULL,
  `percentage_allocation` decimal(5,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Table structure for table `wbs`
--

CREATE TABLE `wbs` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `cost` decimal(15,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `work_breakdown_structure`
--

CREATE TABLE `work_breakdown_structure` (
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

-- --------------------------------------------------------

--
-- Structure for view `project_financial_summary`
--
DROP TABLE IF EXISTS `project_financial_summary`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `project_financial_summary`  AS SELECT `p`.`id` AS `project_id`, `p`.`project_name` AS `project_name`, `p`.`total_budget` AS `approved_budget`, coalesce(sum(case when `pt`.`transaction_type` = 'budget_increase' and `pt`.`transaction_status` = 'active' then `pt`.`amount` else 0 end),0) AS `budget_increases`, coalesce(sum(case when `pt`.`transaction_type` = 'disbursement' and `pt`.`transaction_status` = 'active' then `pt`.`amount` else 0 end),0) AS `total_disbursed`, coalesce(sum(case when `pt`.`transaction_type` = 'expenditure' and `pt`.`transaction_status` = 'active' then `pt`.`amount` else 0 end),0) AS `total_spent`, `p`.`total_budget`+ coalesce(sum(case when `pt`.`transaction_type` = 'budget_increase' and `pt`.`transaction_status` = 'active' then `pt`.`amount` else 0 end),0) AS `total_allocated`, coalesce(sum(case when `pt`.`transaction_type` = 'disbursement' and `pt`.`transaction_status` = 'active' then `pt`.`amount` else 0 end),0) - coalesce(sum(case when `pt`.`transaction_type` = 'expenditure' and `pt`.`transaction_status` = 'active' then `pt`.`amount` else 0 end),0) AS `remaining_balance` FROM (`projects` `p` left join `project_transactions` `pt` on(`p`.`id` = `pt`.`project_id`)) GROUP BY `p`.`id`, `p`.`project_name`, `p`.`total_budget` ;

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
-- Indexes for table `cbs`
--
ALTER TABLE `cbs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_id` (`project_id`);

--
-- Indexes for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_code` (`account_code`),
  ADD KEY `idx_account_type` (`account_type`),
  ADD KEY `idx_parent_account` (`parent_account_id`);

--
-- Indexes for table `cost_breakdown_structure`
--
ALTER TABLE `cost_breakdown_structure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_cbs_code_per_project` (`project_id`,`cbs_code`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_wbs_id` (`wbs_id`),
  ADD KEY `idx_parent_cbs` (`parent_cbs_id`),
  ADD KEY `idx_cost_category` (`cost_category`),
  ADD KEY `idx_fund_source` (`fund_source_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_cbs_budget` (`project_id`,`budget_allocation`,`actual_expenditure`);

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
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `po_number` (`po_number`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_purchase_request_id` (`purchase_request_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_supplier` (`supplier_name`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_po_date_range` (`created_at`,`status`);

--
-- Indexes for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_purchase_order_id` (`purchase_order_id`);

--
-- Indexes for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pr_number` (`pr_number`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_department_id` (`department_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_requested_by` (`requested_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_pr_date_range` (`created_at`,`status`);

--
-- Indexes for table `purchase_request_items`
--
ALTER TABLE `purchase_request_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_purchase_request_id` (`purchase_request_id`);

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
  ADD KEY `county_id` (`county_id`),
  ADD KEY `fk_sub_counties_created_by` (`created_by`),
  ADD KEY `fk_sub_counties_modified_by` (`modified_by`);

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
-- Indexes for table `transactions_ledger`
--
ALTER TABLE `transactions_ledger`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_transaction_date` (`transaction_date`),
  ADD KEY `idx_account_type` (`account_type`),
  ADD KEY `idx_status` (`transaction_status`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `posted_by` (`posted_by`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `idx_transactions_date_range` (`transaction_date`,`project_id`),
  ADD KEY `idx_transactions_amount` (`debit_amount`,`credit_amount`);

--
-- Indexes for table `transaction_cbs_mapping`
--
ALTER TABLE `transaction_cbs_mapping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_transaction_id` (`transaction_id`),
  ADD KEY `idx_cbs_id` (`cbs_id`);

--
-- Indexes for table `transaction_types`
--
ALTER TABLE `transaction_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type_code` (`type_code`),
  ADD KEY `fk_transaction_types_created_by` (`created_by`),
  ADD KEY `fk_transaction_types_modified_by` (`modified_by`);

--
-- Indexes for table `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_county_id` (`sub_county_id`),
  ADD KEY `fk_wards_created_by` (`created_by`),
  ADD KEY `fk_wards_modified_by` (`modified_by`);

--
-- Indexes for table `wbs`
--
ALTER TABLE `wbs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_project_id` (`project_id`);

--
-- Indexes for table `work_breakdown_structure`
--
ALTER TABLE `work_breakdown_structure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_wbs_code_per_project` (`project_id`,`wbs_code`),
  ADD KEY `idx_project_id` (`project_id`),
  ADD KEY `idx_parent_wbs` (`parent_wbs_id`),
  ADD KEY `idx_wbs_level` (`wbs_level`),
  ADD KEY `idx_responsible_admin` (`responsible_admin`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_wbs_hierarchy` (`project_id`,`parent_wbs_id`,`wbs_level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_activation_tokens`
--
ALTER TABLE `account_activation_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

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
-- AUTO_INCREMENT for table `cbs`
--
ALTER TABLE `cbs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `cost_breakdown_structure`
--
ALTER TABLE `cost_breakdown_structure`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `prepared_responses`
--
ALTER TABLE `prepared_responses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `project_documents`
--
ALTER TABLE `project_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `project_steps`
--
ALTER TABLE `project_steps`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `project_subscriptions`
--
ALTER TABLE `project_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `project_transactions`
--
ALTER TABLE `project_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `project_transaction_documents`
--
ALTER TABLE `project_transaction_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `publication_logs`
--
ALTER TABLE `publication_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchase_request_items`
--
ALTER TABLE `purchase_request_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `security_logs`
--
ALTER TABLE `security_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `total_budget`
--
ALTER TABLE `total_budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions_ledger`
--
ALTER TABLE `transactions_ledger`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_cbs_mapping`
--
ALTER TABLE `transaction_cbs_mapping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_types`
--
ALTER TABLE `transaction_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `wbs`
--
ALTER TABLE `wbs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `work_breakdown_structure`
--
ALTER TABLE `work_breakdown_structure`
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
-- Constraints for table `cbs`
--
ALTER TABLE `cbs`
  ADD CONSTRAINT `cbs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chart_of_accounts`
--
ALTER TABLE `chart_of_accounts`
  ADD CONSTRAINT `chart_of_accounts_ibfk_1` FOREIGN KEY (`parent_account_id`) REFERENCES `chart_of_accounts` (`id`);

--
-- Constraints for table `cost_breakdown_structure`
--
ALTER TABLE `cost_breakdown_structure`
  ADD CONSTRAINT `cost_breakdown_structure_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cost_breakdown_structure_ibfk_2` FOREIGN KEY (`wbs_id`) REFERENCES `work_breakdown_structure` (`id`),
  ADD CONSTRAINT `cost_breakdown_structure_ibfk_3` FOREIGN KEY (`parent_cbs_id`) REFERENCES `cost_breakdown_structure` (`id`),
  ADD CONSTRAINT `cost_breakdown_structure_ibfk_4` FOREIGN KEY (`fund_source_id`) REFERENCES `fund_sources` (`id`),
  ADD CONSTRAINT `cost_breakdown_structure_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`);

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
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_orders_ibfk_2` FOREIGN KEY (`purchase_request_id`) REFERENCES `purchase_requests` (`id`),
  ADD CONSTRAINT `purchase_orders_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD CONSTRAINT `purchase_order_items_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_requests`
--
ALTER TABLE `purchase_requests`
  ADD CONSTRAINT `purchase_requests_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_requests_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  ADD CONSTRAINT `purchase_requests_ibfk_3` FOREIGN KEY (`requested_by`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `purchase_requests_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `purchase_requests_ibfk_5` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `purchase_request_items`
--
ALTER TABLE `purchase_request_items`
  ADD CONSTRAINT `purchase_request_items_ibfk_1` FOREIGN KEY (`purchase_request_id`) REFERENCES `purchase_requests` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `security_logs`
--
ALTER TABLE `security_logs`
  ADD CONSTRAINT `security_logs_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

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
-- Constraints for table `transactions_ledger`
--
ALTER TABLE `transactions_ledger`
  ADD CONSTRAINT `transactions_ledger_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_ledger_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `transactions_ledger_ibfk_3` FOREIGN KEY (`posted_by`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `transactions_ledger_ibfk_4` FOREIGN KEY (`approved_by`) REFERENCES `admins` (`id`);

--
-- Constraints for table `transaction_cbs_mapping`
--
ALTER TABLE `transaction_cbs_mapping`
  ADD CONSTRAINT `transaction_cbs_mapping_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions_ledger` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaction_cbs_mapping_ibfk_2` FOREIGN KEY (`cbs_id`) REFERENCES `cost_breakdown_structure` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaction_types`
--
ALTER TABLE `transaction_types`
  ADD CONSTRAINT `fk_transaction_types_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_transaction_types_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `wards`
--
ALTER TABLE `wards`
  ADD CONSTRAINT `fk_wards_created_by` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_wards_modified_by` FOREIGN KEY (`modified_by`) REFERENCES `admins` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `wbs`
--
ALTER TABLE `wbs`
  ADD CONSTRAINT `wbs_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `work_breakdown_structure`
--
ALTER TABLE `work_breakdown_structure`
  ADD CONSTRAINT `work_breakdown_structure_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `work_breakdown_structure_ibfk_2` FOREIGN KEY (`parent_wbs_id`) REFERENCES `work_breakdown_structure` (`id`),
  ADD CONSTRAINT `work_breakdown_structure_ibfk_3` FOREIGN KEY (`responsible_admin`) REFERENCES `admins` (`id`),
  ADD CONSTRAINT `work_breakdown_structure_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `admins` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
