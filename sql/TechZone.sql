-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 29, 2025 at 02:42 PM
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

-- --------------------------------------------------------

--
-- Table structure for table `Article_Panier`
--

CREATE TABLE `Article_Panier` (
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `cart_quantity` int(11) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `Article_Souhaits`
--

CREATE TABLE `Article_Souhaits` (
  `client_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `Categorie`
--

CREATE TABLE `Categorie` (
  `category_id` int(11) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `cat_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CLIENT`
--

CREATE TABLE `CLIENT` (
  `client_id` int(11) NOT NULL,
  `cl_username` varchar(50) NOT NULL,
  `cl_email` varchar(100) NOT NULL,
  `cl_pass_word` varchar(50) NOT NULL,
  `cl_first_name` varchar(50) DEFAULT NULL,
  `cl_last_name` varchar(50) DEFAULT NULL,
  `cl_phone_number` varchar(20) DEFAULT NULL,
  `cl_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `default_address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Commande`
--

CREATE TABLE `Commande` (
  `order_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `order_status` varchar(50) DEFAULT 'Pending',
  `address_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Fabricant`
--

CREATE TABLE `Fabricant` (
  `manufacturer_id` int(11) NOT NULL,
  `fab_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Historique_De_Recherche`
--

CREATE TABLE `Historique_De_Recherche` (
  `search_id` int(11) NOT NULL,
  `search_text` text NOT NULL,
  `search_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `client_id` int(11) NOT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `Produit`
--

CREATE TABLE `Produit` (
  `product_id` int(11) NOT NULL,
  `prd_name` varchar(50) NOT NULL,
  `prd_description` text DEFAULT NULL,
  `prd_price` decimal(10,2) NOT NULL,
  `prd_image_url` varchar(255) NOT NULL,
  `prd_added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `manufacturer_id` int(11) NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `Tag`
--

CREATE TABLE `Tag` (
  `tag_id` int(11) NOT NULL,
  `tag_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  ADD KEY `FK_Article_Souhaits_Product` (`product_id`);

--
-- Indexes for table `Avis`
--
ALTER TABLE `Avis`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `FK_Avis_Client` (`client_id`),
  ADD KEY `FK_Avis_Product` (`product_id`);

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
  ADD KEY `FK_Commande_Client` (`client_id`),
  ADD KEY `FK_Commande_Address` (`address_id`);

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
  ADD KEY `FK_Historique_De_Recherche_Client` (`client_id`),
  ADD KEY `FK_Historique_De_Recherche_Category` (`tag_id`),
  ADD KEY `FK_Historique_De_Recherche_Tag` (`category_id`);

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
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Avis`
--
ALTER TABLE `Avis`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Categorie`
--
ALTER TABLE `Categorie`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CLIENT`
--
ALTER TABLE `CLIENT`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Commande`
--
ALTER TABLE `Commande`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Fabricant`
--
ALTER TABLE `Fabricant`
  MODIFY `manufacturer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Historique_De_Recherche`
--
ALTER TABLE `Historique_De_Recherche`
  MODIFY `search_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT;

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
  ADD CONSTRAINT `FK_Article_Panier_Client` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`),
  ADD CONSTRAINT `FK_Article_Panier_Product` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `Article_Souhaits`
--
ALTER TABLE `Article_Souhaits`
  ADD CONSTRAINT `FK_Article_Souhaits_Client` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`),
  ADD CONSTRAINT `FK_Article_Souhaits_Product` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `Avis`
--
ALTER TABLE `Avis`
  ADD CONSTRAINT `FK_Avis_Client` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`),
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
  ADD CONSTRAINT `FK_Commande_Client` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`);

--
-- Constraints for table `Historique_De_Recherche`
--
ALTER TABLE `Historique_De_Recherche`
  ADD CONSTRAINT `FK_Historique_De_Recherche_Category` FOREIGN KEY (`tag_id`) REFERENCES `Tag` (`tag_id`),
  ADD CONSTRAINT `FK_Historique_De_Recherche_Client` FOREIGN KEY (`client_id`) REFERENCES `Client` (`client_id`),
  ADD CONSTRAINT `FK_Historique_De_Recherche_Tag` FOREIGN KEY (`category_id`) REFERENCES `Categorie` (`category_id`);

--
-- Constraints for table `Offre`
--
ALTER TABLE `Offre`
  ADD CONSTRAINT `FK_Offre` FOREIGN KEY (`product_id`) REFERENCES `Produit` (`product_id`);

--
-- Constraints for table `Produit`
--
ALTER TABLE `Produit`
  ADD CONSTRAINT `FK_Produit_Manufacturer` FOREIGN KEY (`manufacturer_id`) REFERENCES `Fabricants` (`manufacturer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
