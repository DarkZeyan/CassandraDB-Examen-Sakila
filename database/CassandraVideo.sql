CREATE DATABASE  IF NOT EXISTS `shortek` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `shortek`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: shortek
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(150) NOT NULL,
  `address_line_2` varchar(100) DEFAULT NULL,
  `city` varchar(60) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(60) NOT NULL,
  `postal_code` varchar(8) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_user`
--

DROP TABLE IF EXISTS `admin_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_user` (
  `admin_id` int NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(64) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_user`
--

LOCK TABLES `admin_user` WRITE;
/*!40000 ALTER TABLE `admin_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `status` enum('Pending','Awaiting Payment','Sent','Completed') NOT NULL,
  `order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modification_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `order_id` int NOT NULL,
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `subtotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `fk_order_detail_order1_idx` (`order_id`),
  KEY `fk_order_detail_product1_idx` (`product_id`),
  CONSTRAINT `fk_order_detail_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `fk_order_detail_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_user_address`
--

DROP TABLE IF EXISTS `order_user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_user_address` (
  `order_id` int NOT NULL,
  `user_id` int NOT NULL,
  `address_id` int NOT NULL,
  PRIMARY KEY (`order_id`,`user_id`,`address_id`),
  KEY `fk_order_has_user_has_address_user_has_address1_idx` (`user_id`,`address_id`),
  KEY `fk_order_has_user_has_address_order1_idx` (`order_id`),
  CONSTRAINT `fk_order_has_user_has_address_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`),
  CONSTRAINT `fk_order_has_user_has_address_user_has_address1` FOREIGN KEY (`user_id`, `address_id`) REFERENCES `user_address` (`user_id`, `address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_user_address`
--

LOCK TABLES `order_user_address` WRITE;
/*!40000 ALTER TABLE `order_user_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `pm_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`pm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `description` varchar(640) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  `image` blob,
  PRIMARY KEY (`product_id`),
  KEY `fk_product_product_category_idx` (`category_id`),
  CONSTRAINT `fk_product_product_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_category`
--

DROP TABLE IF EXISTS `product_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(70) NOT NULL,
  `image` blob,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_category`
--

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_review`
--

DROP TABLE IF EXISTS `product_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_review` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `rating` tinyint NOT NULL,
  `title` varchar(60) NOT NULL,
  `commentary` varchar(255) DEFAULT NULL,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`review_id`),
  KEY `fk_product_review_user1_idx` (`user_id`),
  KEY `fk_product_review_product1_idx` (`product_id`),
  CONSTRAINT `fk_product_review_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_product_review_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_review`
--

LOCK TABLES `product_review` WRITE;
/*!40000 ALTER TABLE `product_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `promotion_id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(12) NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  `start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`promotion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(320) NOT NULL,
  `password` varchar(120) NOT NULL,
  `name` varchar(80) NOT NULL,
  `last_name` varchar(120) NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_address`
--

DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_address` (
  `user_id` int NOT NULL,
  `address_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`address_id`),
  KEY `fk_user_has_address_address1_idx` (`address_id`),
  KEY `fk_user_has_address_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_address_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  CONSTRAINT `fk_user_has_address_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_address`
--

LOCK TABLES `user_address` WRITE;
/*!40000 ALTER TABLE `user_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_payment_method`
--

DROP TABLE IF EXISTS `user_payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_payment_method` (
  `user_id` int NOT NULL,
  `method_pm_id` int NOT NULL,
  `card_number` varchar(16) DEFAULT NULL,
  `ccv` varchar(3) DEFAULT NULL,
  `valid_thru` date DEFAULT NULL,
  PRIMARY KEY (`user_id`,`method_pm_id`),
  KEY `fk_user_has_payment_method_payment_method1_idx` (`method_pm_id`),
  KEY `fk_user_has_payment_method_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_has_payment_method_payment_method1` FOREIGN KEY (`method_pm_id`) REFERENCES `payment_method` (`pm_id`),
  CONSTRAINT `fk_user_has_payment_method_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_payment_method`
--

LOCK TABLES `user_payment_method` WRITE;
/*!40000 ALTER TABLE `user_payment_method` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishing_list`
--

DROP TABLE IF EXISTS `wishing_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishing_list` (
  `list_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  PRIMARY KEY (`list_id`),
  KEY `fk_shopping_cart_user1_idx` (`user_id`),
  CONSTRAINT `fk_shopping_cart_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishing_list`
--

LOCK TABLES `wishing_list` WRITE;
/*!40000 ALTER TABLE `wishing_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishing_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishing_list_detail`
--

DROP TABLE IF EXISTS `wishing_list_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishing_list_detail` (
  `list_id` int NOT NULL,
  `detail_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`detail_id`),
  KEY `fk_shopping_cart_detail_product1_idx` (`product_id`),
  KEY `fk_wishing_list_detail_wishing_list1_idx` (`list_id`),
  CONSTRAINT `fk_shopping_cart_detail_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `fk_wishing_list_detail_wishing_list1` FOREIGN KEY (`list_id`) REFERENCES `wishing_list` (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishing_list_detail`
--

LOCK TABLES `wishing_list_detail` WRITE;
/*!40000 ALTER TABLE `wishing_list_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishing_list_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-19 14:14:31
