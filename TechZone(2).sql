-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 24, 2025 at 11:06 AM
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
-- Database: `TechZone`
--

-- --------------------------------------------------------

--
-- Table structure for table `Address`
--

CREATE TABLE `Address` (
  `address_id` int(11) NOT NULL,
  `ad_street_address` varchar(255) NOT NULL,
  `ad_city` varchar(50) NOT NULL,
  `ad_zip_code` varchar(20) NOT NULL,
  `ad_country` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Address`
--

INSERT INTO `Address` (`address_id`, `ad_street_address`, `ad_city`, `ad_zip_code`, `ad_country`, `client_id`) VALUES
(2, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(3, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(4, 'ain mariem', 'bizerte', '7000', 'Tunisia', 5),
(5, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(6, 'ain mariem', 'bizerte', '7000', 'United States', 5),
(7, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(8, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(9, 'ain mariem', 'b', '7000', 'Canada', 5),
(10, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(11, 'ain mariem', 'b', '7000', 'Canada', 5),
(12, 'ain mariem', 'b', '7000', 'United States', 5),
(13, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(14, 'ain mariem', 'b', '7000', 'Canada', 5),
(15, 'ain mariem', 'bizerte', '7000', 'Tunisia', 5),
(16, 'ain mariem', 'b', '7000', 'Tunisia', 5),
(17, 'ain mariem', 'bizerte', '7000', 'Tunisia', 5),
(18, 'ain mariem', 'b', '100', 'Canada', 5),
(19, 'ain mariem', 'bizerte', '7000', 'Canada', 5),
(20, 'ain mariem', 'b', '7000', 'Canada', 5),
(21, 'ain draham', 'paris', '1000', 'France', 8),
(22, 'cooper square', 'new york', '4411', 'United States', 8);

-- --------------------------------------------------------

--
-- Table structure for table `Article_Commande`
--

CREATE TABLE `Article_Commande` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cd_quantity` int(11) NOT NULL,
  `cd_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Article_Commande`
--

INSERT INTO `Article_Commande` (`order_id`, `product_id`, `cd_quantity`, `cd_price`) VALUES
(13, 1, 1, 1699.99),
(14, 5, 12, 76.45),
(14, 8, 7, 36.99),
(15, 3, 14, 100.00),
(21, 1, 4, 1699.99),
(21, 3, 5, 100.00),
(21, 4, 17, 999.00),
(22, 24, 1, 199.00),
(23, 24, 1, 189.00);

-- --------------------------------------------------------

--
-- Table structure for table `Article_Panier`
--

CREATE TABLE `Article_Panier` (
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cart_quantity` int(11) NOT NULL
) ;

--
-- Dumping data for table `Article_Panier`
--

INSERT INTO `Article_Panier` (`client_id`, `product_id`, `cart_quantity`) VALUES
(1, 3, 7),
(1, 5, 10);

-- --------------------------------------------------------

--
-- Table structure for table `Article_Souhaits`
--

CREATE TABLE `Article_Souhaits` (
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Article_Souhaits`
--

INSERT INTO `Article_Souhaits` (`client_id`, `product_id`) VALUES
(1, 1),
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Avis`
--

CREATE TABLE `Avis` (
  `review_id` int(11) NOT NULL,
  `rev_rating` int(11) NOT NULL,
  `rev_comment` text DEFAULT NULL,
  `rev_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `Avis`
--

INSERT INTO `Avis` (`review_id`, `rev_rating`, `rev_comment`, `rev_created_at`, `client_id`, `product_id`) VALUES
(2, 2, 'd', '2025-12-16 07:07:20', 1, 1),
(3, 4, 'e', '2025-12-16 07:07:33', 1, 1),
(4, 5, 'q', '2025-12-16 07:07:39', 1, 1),
(5, 1, 'q', '2025-12-16 07:08:25', 1, 1),
(6, 2, 'qqa', '2025-12-16 07:14:56', 1, 1),
(7, 5, 'cccccccccccccccccccc', '2025-12-16 07:15:11', 1, 1),
(8, 4, 'kkkkkkk', '2025-12-16 07:15:27', 1, 1),
(9, 5, 'wwww', '2025-12-16 08:26:17', 1, 5),
(10, 2, 'q', '2025-12-16 08:55:00', 1, 3),
(11, 2, 'ooooo', '2025-12-16 09:14:59', 1, 5),
(12, 5, 'amazing product', '2025-12-21 16:56:39', 5, 4),
(13, 4, 'i like this product', '2025-12-23 19:00:16', 1, 11),
(14, 1, 'dont buy this product its not good', '2025-12-23 19:01:11', 5, 11),
(15, 3, 'I wouldn\'t recommend it to anyone since there are better deals out there, but it\'s not that bad of a choice', '2025-12-23 19:03:20', 9, 11);

-- --------------------------------------------------------

--
-- Table structure for table `Categorie`
--

CREATE TABLE `Categorie` (
  `category_id` int(11) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `cat_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Categorie`
--

INSERT INTO `Categorie` (`category_id`, `cat_name`, `cat_description`) VALUES
(1, 'Laptops', 'High-performance computing devices and accessories.'),
(2, 'Peripherals', 'External devices like keyboards, mice, and monitors.'),
(3, 'Wearables', 'Smart watches, fitness trackers, and other body-worn tech.'),
(16, 'Computers', 'A section dedicated to computers'),
(17, 'Phones', 'A section dedicates for phones');

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `client_id` int(11) NOT NULL,
  `cl_username` varchar(50) NOT NULL,
  `cl_email` varchar(100) NOT NULL,
  `cl_pass_word` varchar(255) NOT NULL,
  `cl_first_name` varchar(50) DEFAULT NULL,
  `cl_last_name` varchar(50) DEFAULT NULL,
  `cl_phone_number` varchar(20) DEFAULT NULL,
  `cl_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `default_address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CLIENT`
--

INSERT INTO `CLIENT` (`client_id`, `cl_username`, `cl_email`, `cl_pass_word`, `cl_first_name`, `cl_last_name`, `cl_phone_number`, `cl_created_at`, `default_address_id`) VALUES
(1, 'ilyes belkahia', 'ilyesbelkahia@gmail.com', '$2y$10$ReO4TLIxVQWDdO6Gk2KtGetB8Lg04lT2jro/w.yft4NRPDSnxXTrS', 'ilyes', 'belkahia', '54544545', '2025-11-30 17:35:08', NULL),
(2, 'ilyes belkahi', 'bennor@gmail.com', '$2y$10$QuT7HJBdgIrXpz4ZwgSMQ.6JriXuy7slS7fiTgDuVREHSSt5Icjb6', 'ilyes', 'belkahia', '44', '2025-11-30 17:37:09', NULL),
(3, 'd', 'dfsdfdsf@gmail.com', '$2y$10$ul8L0tMDX0A1GQadE05qceOrtSuOr..LlQeJeMyzlfTVwfrseUVBa', 'd', 'd', '7', '2025-11-30 17:38:32', NULL),
(4, 'p', 'benor@gmail.com', '$2y$10$BCheN8K.E1Y3SHRU50GAKujk4yXLPTi6FdcLY51w8aPjXZXVIpIvu', 'p', 'p', '7', '2025-11-30 17:39:25', NULL),
(5, 'eya geusmi', 'eyageusmi@gmail.com', '$2y$10$8c/f1R5bOWFE9zECnx0gyeCjKSNIlE7DORXbDrbxC8YMl8HB9Bhpq', 'eya', 'geusmi', '111111111', '2025-12-16 09:12:11', NULL),
(8, 'd d', 'dfsdfdss@gmail.com', '$2y$10$Oo4f2Y4VH/YajmZm5g7yl.Z3TbhL1SM/OZYOEna7HC0in7JGD0p5K', 'd', 'd', '1', '2025-12-22 06:25:53', NULL),
(9, 'yessin nefzi', 'yessinNefzi@gmail.com', '$2y$10$zDHk2tJFtW3rb8UEBoNbO.AzP/5st8H2oSKVtCZIdeBrxOhollXqO', 'yessin', 'nefzi', '111111', '2025-12-23 19:02:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Commande`
--

CREATE TABLE `Commande` (
  `order_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_status` varchar(50) NOT NULL DEFAULT 'pending',
  `address_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `Commande`
--

INSERT INTO `Commande` (`order_id`, `client_id`, `order_date`, `order_status`, `address_id`) VALUES
(13, 5, '2025-12-16 16:03:40', 'arrived', 15),
(14, 5, '2025-12-16 16:05:31', 'pending', 16),
(15, 5, '2025-12-17 08:59:02', 'pending', 17),
(19, 3, '2025-12-19 14:13:16', 'arrived', 8),
(20, 5, '2025-12-17 08:59:02', 'pending', 17),
(21, 5, '2025-12-19 15:03:32', 'pending', 20),
(22, 8, '2025-12-23 08:30:39', 'pending', 21),
(23, 8, '2025-12-23 08:33:41', 'pending', 22);

-- --------------------------------------------------------

--
-- Table structure for table `Fabricant`
--

CREATE TABLE `Fabricant` (
  `manufacturer_id` int(11) NOT NULL,
  `fab_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Fabricant`
--

INSERT INTO `Fabricant` (`manufacturer_id`, `fab_name`) VALUES
(103, 'AeroTech Electronics'),
(302, 'Apex Gaming'),
(111, 'Elite Peripheral Group'),
(107, 'Nova Logic'),
(109, 'Pinnacle Electronics'),
(102, 'Quantum Systems'),
(104, 'Silverline Computing'),
(101, 'TechCorp Electronics'),
(106, 'Titan Hardware');

-- --------------------------------------------------------

--
-- Table structure for table `Historique_De_Recherche`
--

CREATE TABLE `Historique_De_Recherche` (
  `search_id` int(11) NOT NULL,
  `search_text` text NOT NULL,
  `search_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Historique_De_Recherche`
--

INSERT INTO `Historique_De_Recherche` (`search_id`, `search_text`, `search_date`, `client_id`, `category_id`) VALUES
(59, 'hello world iam searching for this account', '2025-12-22 06:40:50', 8, NULL),
(60, '', '2025-12-22 06:43:32', 8, NULL),
(61, '', '2025-12-22 06:44:12', 8, NULL),
(62, '', '2025-12-22 06:44:17', 8, NULL),
(63, '', '2025-12-22 06:44:19', 8, NULL),
(64, '', '2025-12-22 06:52:59', 8, NULL),
(65, '', '2025-12-22 06:53:28', 8, NULL),
(66, '', '2025-12-22 06:54:32', 8, NULL),
(67, '', '2025-12-22 06:59:43', 8, NULL),
(68, '', '2025-12-22 06:59:48', 8, NULL),
(69, '', '2025-12-22 07:00:27', 8, NULL),
(70, '', '2025-12-22 07:00:30', 8, NULL),
(71, '', '2025-12-22 07:02:57', 8, NULL),
(72, '', '2025-12-22 07:07:00', 8, NULL),
(73, '', '2025-12-22 07:08:23', 8, NULL),
(74, '', '2025-12-22 07:09:35', 8, NULL),
(75, '', '2025-12-22 07:10:01', 8, NULL),
(78, '', '2025-12-22 07:24:09', NULL, NULL),
(79, '', '2025-12-22 07:25:25', NULL, NULL),
(80, '', '2025-12-22 07:25:32', NULL, NULL),
(81, '', '2025-12-22 07:25:39', NULL, NULL),
(82, '', '2025-12-22 07:26:18', NULL, NULL),
(83, '', '2025-12-22 07:28:03', NULL, NULL),
(84, '', '2025-12-22 07:28:26', NULL, NULL),
(85, '', '2025-12-22 07:28:33', NULL, NULL),
(86, '', '2025-12-22 07:29:12', NULL, NULL),
(87, '', '2025-12-22 11:06:13', 8, 2),
(88, '', '2025-12-22 11:06:39', 8, 2),
(89, '', '2025-12-22 11:06:49', 8, 2),
(90, '', '2025-12-22 11:06:56', 8, NULL),
(91, '', '2025-12-22 11:06:58', 8, NULL),
(92, '', '2025-12-22 11:29:55', 8, NULL),
(93, '', '2025-12-22 11:29:57', 8, NULL),
(94, '', '2025-12-22 11:30:01', 8, NULL),
(95, '', '2025-12-22 11:30:05', 8, NULL),
(96, '', '2025-12-22 11:30:08', 8, NULL),
(97, '', '2025-12-22 11:30:13', 8, NULL),
(98, '', '2025-12-22 11:30:17', 8, NULL),
(99, '', '2025-12-22 11:30:20', 8, NULL),
(100, '', '2025-12-22 11:30:23', 8, NULL),
(101, '', '2025-12-22 11:30:26', 8, NULL),
(102, '', '2025-12-22 11:30:40', 8, NULL),
(103, '', '2025-12-22 11:30:52', 8, NULL),
(104, '', '2025-12-22 11:30:58', 8, NULL),
(105, '', '2025-12-22 11:31:03', 8, NULL),
(106, '', '2025-12-22 11:32:40', 8, NULL),
(107, '', '2025-12-22 11:32:53', 8, NULL),
(108, '', '2025-12-22 11:32:57', 8, NULL),
(109, '', '2025-12-22 11:33:01', 8, NULL),
(110, '', '2025-12-22 11:33:08', 8, NULL),
(111, '', '2025-12-22 11:33:12', 8, NULL),
(112, '', '2025-12-22 11:33:47', 8, NULL),
(113, '', '2025-12-22 11:33:51', 8, NULL),
(114, '', '2025-12-22 11:34:02', 8, NULL),
(115, '', '2025-12-22 11:34:23', 8, NULL),
(116, '', '2025-12-22 11:34:26', 8, NULL),
(117, '', '2025-12-22 11:34:29', 8, NULL),
(118, '', '2025-12-23 08:29:59', 8, NULL),
(119, '', '2025-12-23 08:30:15', 8, NULL),
(120, '', '2025-12-23 18:55:25', 1, NULL),
(121, 'hehe', '2025-12-23 18:56:13', 1, NULL),
(122, 'phone', '2025-12-23 18:56:23', 1, NULL),
(123, '', '2025-12-23 18:59:53', 1, NULL),
(124, '', '2025-12-23 19:00:30', 5, NULL),
(125, '', '2025-12-23 19:02:24', 9, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Offre`
--

CREATE TABLE `Offre` (
  `deal_id` int(11) NOT NULL,
  `off_discount_amount` decimal(10,2) NOT NULL,
  `off_start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `off_end_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `product_id` int(11) NOT NULL
) ;

--
-- Dumping data for table `Offre`
--

INSERT INTO `Offre` (`deal_id`, `off_discount_amount`, `off_start_date`, `off_end_date`, `product_id`) VALUES
(1, 200.00, '2025-11-30 23:00:00', '2025-12-30 23:00:00', 1),
(3, 25.00, '2025-11-30 23:00:00', '2026-01-30 23:00:00', 3),
(4, 100.00, '2025-11-30 23:00:00', '2025-12-06 23:00:00', 4),
(5, 13.50, '2025-11-30 23:00:00', '2026-02-27 23:00:00', 5),
(6, 150.00, '2025-12-21 23:00:00', '2026-01-15 22:59:59', 11),
(7, 300.00, '2025-12-21 23:00:00', '2026-01-05 22:59:59', 14),
(8, 15.00, '2025-12-21 23:00:00', '2026-01-31 22:59:59', 17),
(9, 20.00, '2025-12-21 23:00:00', '2026-01-10 22:59:59', 20),
(10, 10.50, '2025-12-21 23:00:00', '2026-02-28 22:59:59', 23),
(11, 120.00, '2025-12-21 23:00:00', '2026-01-01 22:59:59', 26),
(12, 250.00, '2025-12-21 23:00:00', '2026-01-20 22:59:59', 29),
(13, 10.00, '2025-12-23 08:32:10', '2026-01-24 08:31:33', 24),
(14, 10.00, '2025-12-23 08:32:12', '2026-01-24 08:31:33', 24);

-- --------------------------------------------------------

--
-- Table structure for table `Produit`
--

CREATE TABLE `Produit` (
  `product_id` int(11) NOT NULL,
  `prd_name` varchar(50) NOT NULL,
  `prd_description` text DEFAULT NULL,
  `prd_price` decimal(10,2) NOT NULL,
  `prd_image_url` text NOT NULL,
  `prd_added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `manufacturer_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `prd_stock` int(11) NOT NULL DEFAULT 0
) ;

--
-- Dumping data for table `Produit`
--

INSERT INTO `Produit` (`product_id`, `prd_name`, `prd_description`, `prd_price`, `prd_image_url`, `prd_added_at`, `manufacturer_id`, `category_id`, `prd_stock`) VALUES
(1, 'UltraBook Pro X1', 'The latest generation of our flagship ultra-portable laptop. Features 32GB RAM and 1TB SSD. Perfect for professional use.', 1899.99, 'data:image/jpeg;base64,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', '2025-11-29 16:13:18', 101, 1, 10),
(3, 'Ergo Mechanical Keyboard', NULL, 125.00, 'data:image/jpeg;base64,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', '2025-11-29 16:13:18', 101, 2, 5),
(4, 'Aura X Smartphone', 'Flagship 6.7-inch device with triple camera array and all-day battery life.', 999.00, 'data:image/jpeg;base64,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', '2025-11-29 16:13:18', 101, 1, 37),
(5, 'Wireless Gaming Headset Nova Pro', 'Premium wireless gaming headset with lossless audio, active noise cancellation, and a retractable bidirectional microphone. Compatible with PC, PlayStation, and mobile devices.', 89.95, 'data:image/jpeg;base64,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', '2025-11-29 16:13:18', 302, 2, 3),
(7, 'V-Series Smart Watch', 'Tracks heart rate, sleep, and GPS. Water-resistant design.', 249.50, 'data:image/jpeg;base64,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', '2025-11-29 16:13:18', 101, 3, 3);
INSERT INTO `Produit` (`product_id`, `prd_name`, `prd_description`, `prd_price`, `prd_image_url`, `prd_added_at`, `manufacturer_id`, `category_id`, `prd_stock`) VALUES
(8, 'Apex Gaming mouse V13', 'A lightweigth gaming mouse that is designed for gamers', 36.99, 'data:image/jpeg;base64,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', '2025-12-16 07:59:01', 302, 2, 3),
(11, 'TechCorp Workstation Z1', 'High-end desktop for professional creators.', 1499.99, 'https://images.unsplash.com/photo-1593640408182-31c70c8268f5', '2025-12-22 06:47:05', 101, 16, 15),
(12, 'TechCorp Mobility Pro', 'Ultra-slim 14-inch laptop for travelers.', 1199.00, 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8', '2025-12-22 06:47:05', 101, 1, 20),
(13, 'TechCorp Silent Click', 'Ergonomic wireless mouse with silent buttons.', 29.99, 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46', '2025-12-22 06:47:05', 101, 2, 50),
(14, 'Apex Titan Desktop', 'Ultimate gaming PC with liquid cooling.', 2499.99, 'https://images.unsplash.com/photo-1587202372775-e229f172b9d7', '2025-12-22 06:47:05', 302, 16, 8),
(15, 'Apex Renegade Laptop', '17-inch gaming powerhouse with 240Hz screen.', 1899.00, 'https://images.unsplash.com/photo-1603302576837-37561b2e2302', '2025-12-22 06:47:05', 302, 1, 12),
(16, 'Apex Fusion Mechanical', 'Mechanical keyboard with customizable RGB.', 149.99, 'https://images.unsplash.com/photo-1511467687858-23d96c32e4ae', '2025-12-22 06:47:05', 302, 2, 25),
(17, 'AeroFlow PC Case', 'Optimized airflow computer tower.', 89.99, 'https://images.unsplash.com/photo-1591488320449-011701bb6704', '2025-12-22 06:47:05', 103, 16, 30),
(18, 'AeroTech Precision Monitor', '27-inch 4K color-accurate display.', 450.00, 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf', '2025-12-22 06:47:05', 103, 2, 15),
(19, 'AeroTech Cloud Headset', 'Spatial audio gaming headphones.', 110.00, 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e', '2025-12-22 06:47:05', 103, 2, 40),
(20, 'Elite Pro Webcam', '1080p 60fps streaming camera.', 79.99, 'data:image/jpeg;base64,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', '2025-12-22 06:47:05', 111, 2, 60),
(22, 'Elite Macro Pad', 'Programmable 12-key macro board.', 55.00, 'https://images.unsplash.com/photo-1595225476474-87563907a212', '2025-12-22 06:47:05', 111, 2, 20),
(23, 'Nova Smart Band 5', 'Fitness tracker with heart rate and SPO2.', 49.99, 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6', '2025-12-22 06:47:05', 107, 3, 75),
(24, 'Nova Pulse Watch', 'Advanced health tracking smartwatch.', 199.00, 'https://images.unsplash.com/photo-1523275335684-37898b6baf30', '2025-12-22 06:47:05', 107, 3, 28),
(25, 'Nova Logic Desktop Mini', 'Compact PC for office productivity.', 599.00, 'data:image/jpeg;base64,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', '2025-12-22 06:47:05', 107, 16, 18),
(26, 'Pinnacle Edge Smartphone', 'High-performance phone with pro camera.', 899.99, 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9', '2025-12-22 06:47:05', 109, 17, 25),
(27, 'Pinnacle View Tablet', '12-inch tablet for design and media.', 650.00, 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0', '2025-12-22 06:47:05', 109, 17, 15),
(28, 'Pinnacle Nano Earbuds', 'Noise-canceling true wireless buds.', 129.00, 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df', '2025-12-22 06:47:05', 109, 3, 45),
(29, 'Quantum Q1 Laptop', 'Next-gen processing power in a portable frame.', 1350.00, 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853', '2025-12-22 06:47:05', 102, 1, 10),
(30, 'Quantum Link Router', 'High-speed Wi-Fi 6 mesh node.', 180.00, 'https://images.unsplash.com/photo-1544197150-b99a580bb7a8', '2025-12-22 06:47:05', 102, 2, 22),
(31, 'Quantum Hub Pro', '10-in-1 USB-C docking station.', 95.00, 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6', '2025-12-22 06:47:05', 102, 2, 35),
(32, 'Silverline S-Book', 'Reliable laptop for education and work.', 750.00, 'https://images.unsplash.com/photo-1498050108023-c5249f4df085', '2025-12-22 06:47:05', 104, 1, 40),
(33, 'Silverline Core Desktop', 'Value-focused desktop for home use.', 499.00, 'https://images.unsplash.com/photo-1555066931-4365d14bab8c', '2025-12-22 06:47:05', 104, 16, 20),
(34, 'Silverline Air Smartwatch', 'Lightweight watch with basic notifications.', 89.00, 'data:image/jpeg;base64,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', '2025-12-22 06:47:05', 104, 3, 55);
INSERT INTO `Produit` (`product_id`, `prd_name`, `prd_description`, `prd_price`, `prd_image_url`, `prd_added_at`, `manufacturer_id`, `category_id`, `prd_stock`) VALUES
(35, 'Titan Rugged Phone', 'Waterproof and drop-tested smartphone.', 599.00, 'data:image/jpeg;base64,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', '2025-12-22 06:47:05', 106, 17, 15),
(36, 'Titan Armor Case', 'Heavy-duty protection for 15-inch laptops.', 45.00, 'data:image/jpeg;base64,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', '2025-12-22 06:47:05', 106, 1, 80),
(37, 'Titan Stealth Tracker', 'Discreet GPS fitness wearable.', 120.00, 'https://images.unsplash.com/photo-1551816230-ef5deaed4a26', '2025-12-22 06:47:05', 106, 3, 40);

-- --------------------------------------------------------

--
-- Table structure for table `Tag`
--

CREATE TABLE `Tag` (
  `tag_id` int(11) NOT NULL,
  `tag_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Tag`
--

INSERT INTO `Tag` (`tag_id`, `tag_name`) VALUES
(2, 'Best Rated'),
(5, 'Gaming'),
(1, 'New'),
(6, 'Sale');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`address_id`),
  ADD KEY `FK_Address_Client` (`client_id`);

--
-- Indexes for table `Article_Commande`
--
ALTER TABLE `Article_Commande`
  ADD PRIMARY KEY (`order_id`,`product_id`),
  ADD KEY `FK_Article_Commande_Product` (`product_id`);

--
-- Indexes for table `Article_Panier`
--
ALTER TABLE `Article_Panier`
  ADD PRIMARY KEY (`client_id`,`product_id`),
  ADD KEY `FK_Article_Panier_Product` (`product_id`);

--
-- Indexes for table `Article_Souhaits`
--
ALTER TABLE `Article_Souhaits`
  ADD PRIMARY KEY (`client_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `Avis`
--
ALTER TABLE `Avis`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `FK_Avis_Product` (`product_id`),
  ADD KEY `FK_Avis_Client` (`client_id`);

--
-- Indexes for table `Categorie`
--
ALTER TABLE `Categorie`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `cat_name` (`cat_name`);

--
-- Indexes for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD PRIMARY KEY (`client_id`),
  ADD UNIQUE KEY `cl_username` (`cl_username`),
  ADD UNIQUE KEY `cl_email` (`cl_email`),
  ADD KEY `FK_Client_Default_Address` (`default_address_id`);

--
-- Indexes for table `Commande`
--
ALTER TABLE `Commande`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `FK_Commande_Address` (`address_id`),
  ADD KEY `FK_Commande_Client` (`client_id`);

--
-- Indexes for table `Fabricant`
--
ALTER TABLE `Fabricant`
  ADD PRIMARY KEY (`manufacturer_id`),
  ADD UNIQUE KEY `fab_name` (`fab_name`);

--
-- Indexes for table `Historique_De_Recherche`
--
ALTER TABLE `Historique_De_Recherche`
  ADD PRIMARY KEY (`search_id`),
  ADD KEY `FK_Historique_De_Recherche_Tag` (`category_id`),
  ADD KEY `FK_Historique_De_Recherche_Client` (`client_id`);

--
-- Indexes for table `Offre`
--
ALTER TABLE `Offre`
  ADD PRIMARY KEY (`deal_id`),
  ADD KEY `FK_Offre` (`product_id`);

--
-- Indexes for table `Produit`
--
ALTER TABLE `Produit`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `FK_Produit_Category` (`category_id`),
  ADD KEY `FK_Produit_Manufacturer` (`manufacturer_id`);

--
-- Indexes for table `Tag`
--
ALTER TABLE `Tag`
  ADD PRIMARY KEY (`tag_id`),
  ADD UNIQUE KEY `tag_name` (`tag_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `Avis`
--
ALTER TABLE `Avis`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Categorie`
--
ALTER TABLE `Categorie`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `CLIENT`
--
ALTER TABLE `CLIENT`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Commande`
--
ALTER TABLE `Commande`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Fabricant`
--
ALTER TABLE `Fabricant`
  MODIFY `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=508;

--
-- AUTO_INCREMENT for table `Historique_De_Recherche`
--
ALTER TABLE `Historique_De_Recherche`
  MODIFY `search_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `Offre`
--
ALTER TABLE `Offre`
  MODIFY `deal_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Produit`
--
ALTER TABLE `Produit`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Tag`
--
ALTER TABLE `Tag`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Address`
--
ALTER TABLE `Address`
  ADD CONSTRAINT `FK_Address_Client` FOREIGN KEY (`client_id`) REFERENCES `CLIENT` (`client_id`);

--
-- Constraints for table `Article_Commande`
--
ALTER TABLE `Article_Commande`
  ADD CONSTRAINT `FK_Article_Commande_Commande` FOREIGN KEY (`order_id`) REFERENCES `Commande` (`order_id`),
  ADD CONSTRAINT `FK_Article_Commande_Product` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `Article_Panier`
--
ALTER TABLE `Article_Panier`
  ADD CONSTRAINT `FK_ARTICLE_PANIER_CLIENT` FOREIGN KEY (`client_id`) REFERENCES `CLIENT` (`client_id`),
  ADD CONSTRAINT `FK_Article_Panier_Product` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `Article_Souhaits`
--
ALTER TABLE `Article_Souhaits`
  ADD CONSTRAINT `FK_ArticleSouhaits_client_ID` FOREIGN KEY (`client_id`) REFERENCES `CLIENT` (`client_id`),
  ADD CONSTRAINT `FK_Article_Souhaits_Product` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `Avis`
--
ALTER TABLE `Avis`
  ADD CONSTRAINT `FK_Avis_Client` FOREIGN KEY (`client_id`) REFERENCES `CLIENT` (`client_id`),
  ADD CONSTRAINT `FK_Avis_Product` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `CLIENT`
--
ALTER TABLE `CLIENT`
  ADD CONSTRAINT `FK_Client_Default_Address` FOREIGN KEY (`default_address_id`) REFERENCES `Address` (`address_id`);

--
-- Constraints for table `Commande`
--
ALTER TABLE `Commande`
  ADD CONSTRAINT `FK_Commande_Address` FOREIGN KEY (`address_id`) REFERENCES `Address` (`address_id`),
  ADD CONSTRAINT `FK_Commande_Client` FOREIGN KEY (`client_id`) REFERENCES `CLIENT` (`client_id`);

--
-- Constraints for table `Historique_De_Recherche`
--
ALTER TABLE `Historique_De_Recherche`
  ADD CONSTRAINT `FK_Historique_De_Recherche_Client` FOREIGN KEY (`client_id`) REFERENCES `CLIENT` (`client_id`),
  ADD CONSTRAINT `FK_Historique_De_Recherche_Tag` FOREIGN KEY (`category_id`) REFERENCES `Categorie` (`category_id`);

--
-- Constraints for table `Offre`
--
ALTER TABLE `Offre`
  ADD CONSTRAINT `FK_Offre` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`) ON DELETE CASCADE;

--
-- Constraints for table `Produit`
--
ALTER TABLE `Produit`
  ADD CONSTRAINT `FK_Produit_Category` FOREIGN KEY (`category_id`) REFERENCES `Categorie` (`category_id`),
  ADD CONSTRAINT `FK_Produit_Manufacturer` FOREIGN KEY (`manufacturer_id`) REFERENCES `Fabricant` (`manufacturer_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
