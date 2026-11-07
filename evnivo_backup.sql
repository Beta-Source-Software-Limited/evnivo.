-- MySQL dump 10.13  Distrib 8.4.13, for Linux (aarch64)
--
-- Host: localhost    Database: evnivo
-- ------------------------------------------------------
-- Server version	8.4.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add Token',7,'add_token'),(26,'Can change Token',7,'change_token'),(27,'Can delete Token',7,'delete_token'),(28,'Can view Token',7,'view_token'),(29,'Can add Token',8,'add_tokenproxy'),(30,'Can change Token',8,'change_tokenproxy'),(31,'Can delete Token',8,'delete_tokenproxy'),(32,'Can view Token',8,'view_tokenproxy'),(33,'Can add category',9,'add_category'),(34,'Can change category',9,'change_category'),(35,'Can delete category',9,'delete_category'),(36,'Can view category',9,'view_category'),(37,'Can add event',10,'add_event'),(38,'Can change event',10,'change_event'),(39,'Can delete event',10,'delete_event'),(40,'Can view event',10,'view_event'),(41,'Can add booking',11,'add_booking'),(42,'Can change booking',11,'change_booking'),(43,'Can delete booking',11,'delete_booking'),(44,'Can view booking',11,'view_booking'),(45,'Can add ticket',12,'add_ticket'),(46,'Can change ticket',12,'change_ticket'),(47,'Can delete ticket',12,'delete_ticket'),(48,'Can view ticket',12,'view_ticket'),(49,'Can add ticket type',13,'add_tickettype'),(50,'Can change ticket type',13,'change_tickettype'),(51,'Can delete ticket type',13,'delete_tickettype'),(52,'Can view ticket type',13,'view_tickettype');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1000000$OiZjTW8NFOqEt9gkuHsAXF$JScAdO7Y3S5AEvUFs+aHs4wYDJmrCJ+3m+IQWbXr3Wg=',NULL,0,'sagar','sagar','','contact@sagarroy.com',0,1,'2026-11-07 16:10:39.631555');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
INSERT INTO `authtoken_token` VALUES ('65f84e5d546c7d090aeb29043005d1e0f5d92143','2026-11-07 16:10:39.752469',1);
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(7,'authtoken','token'),(8,'authtoken','tokenproxy'),(5,'contenttypes','contenttype'),(11,'events','booking'),(9,'events','category'),(10,'events','event'),(12,'events','ticket'),(13,'events','tickettype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-11-07 16:09:21.285491'),(2,'auth','0001_initial','2026-11-07 16:09:21.373585'),(3,'admin','0001_initial','2026-11-07 16:09:21.397110'),(4,'admin','0002_logentry_remove_auto_add','2026-11-07 16:09:21.399317'),(5,'admin','0003_logentry_add_action_flag_choices','2026-11-07 16:09:21.401237'),(6,'contenttypes','0002_remove_content_type_name','2026-11-07 16:09:21.418242'),(7,'auth','0002_alter_permission_name_max_length','2026-11-07 16:09:21.427679'),(8,'auth','0003_alter_user_email_max_length','2026-11-07 16:09:21.432349'),(9,'auth','0004_alter_user_username_opts','2026-11-07 16:09:21.434321'),(10,'auth','0005_alter_user_last_login_null','2026-11-07 16:09:21.443529'),(11,'auth','0006_require_contenttypes_0002','2026-11-07 16:09:21.443979'),(12,'auth','0007_alter_validators_add_error_messages','2026-11-07 16:09:21.445931'),(13,'auth','0008_alter_user_username_max_length','2026-11-07 16:09:21.457649'),(14,'auth','0009_alter_user_last_name_max_length','2026-11-07 16:09:21.468283'),(15,'auth','0010_alter_group_name_max_length','2026-11-07 16:09:21.471921'),(16,'auth','0011_update_proxy_permissions','2026-11-07 16:09:21.475109'),(17,'auth','0012_alter_user_first_name_max_length','2026-11-07 16:09:21.485600'),(18,'authtoken','0001_initial','2026-11-07 16:09:21.498369'),(19,'authtoken','0002_auto_20160226_1747','2026-11-07 16:09:21.504519'),(20,'authtoken','0003_tokenproxy','2026-11-07 16:09:21.505155'),(21,'authtoken','0004_alter_tokenproxy_options','2026-11-07 16:09:21.506195'),(22,'events','0001_initial','2026-11-07 16:09:21.597600'),(23,'sessions','0001_initial','2026-11-07 16:09:21.603635');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_booking`
--

DROP TABLE IF EXISTS `events_booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reference` char(32) NOT NULL,
  `quantity` smallint unsigned NOT NULL,
  `total` decimal(12,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int NOT NULL,
  `event_id` bigint NOT NULL,
  `ticket_type_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference` (`reference`),
  KEY `events_booking_ticket_type_id_12168215_fk_events_tickettype_id` (`ticket_type_id`),
  KEY `events_booking_user_id_aab162a7_fk_auth_user_id` (`user_id`),
  KEY `events_booking_event_id_e3561e88_fk_events_event_id` (`event_id`),
  CONSTRAINT `events_booking_event_id_e3561e88_fk_events_event_id` FOREIGN KEY (`event_id`) REFERENCES `events_event` (`id`),
  CONSTRAINT `events_booking_ticket_type_id_12168215_fk_events_tickettype_id` FOREIGN KEY (`ticket_type_id`) REFERENCES `events_tickettype` (`id`),
  CONSTRAINT `events_booking_user_id_aab162a7_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `events_booking_chk_1` CHECK ((`quantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_booking`
--

LOCK TABLES `events_booking` WRITE;
/*!40000 ALTER TABLE `events_booking` DISABLE KEYS */;
INSERT INTO `events_booking` VALUES (1,'b95e0c71b5d84b3cb6932a2e045ffceb',1,1800.00,'demo_confirmed','2026-11-07 16:10:48.541437',1,1,1);
/*!40000 ALTER TABLE `events_booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_category`
--

DROP TABLE IF EXISTS `events_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `icon` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_category`
--

LOCK TABLES `events_category` WRITE;
/*!40000 ALTER TABLE `events_category` DISABLE KEYS */;
INSERT INTO `events_category` VALUES (1,'Music','music','🎵'),(2,'Technology','technology','💻'),(3,'Festivals','festivals','🎉'),(4,'Sports','sports','🏆'),(5,'Arts & Culture','arts','🎨'),(6,'Business','business','💼');
/*!40000 ALTER TABLE `events_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_event`
--

DROP TABLE IF EXISTS `events_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_event` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `slug` varchar(230) NOT NULL,
  `summary` varchar(280) NOT NULL,
  `description` longtext NOT NULL,
  `venue` varchar(180) NOT NULL,
  `city` varchar(90) NOT NULL,
  `address` varchar(250) NOT NULL,
  `start_at` datetime(6) NOT NULL,
  `end_at` datetime(6) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `image_url` varchar(200) NOT NULL,
  `featured` tinyint(1) NOT NULL,
  `published` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `events_event_category_id_01d3a3ab_fk_events_category_id` (`category_id`),
  CONSTRAINT `events_event_category_id_01d3a3ab_fk_events_category_id` FOREIGN KEY (`category_id`) REFERENCES `events_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_event`
--

LOCK TABLES `events_event` WRITE;
/*!40000 ALTER TABLE `events_event` DISABLE KEYS */;
INSERT INTO `events_event` VALUES (1,'Dhaka Soundwave Festival','dhaka-soundwave-festival','Live music, lights, and unforgettable performances.','Experience a spectacular night of local and international artists, creative stage design, and unforgettable energy.','Army Stadium','Dhaka','','2026-11-21 16:09:21.996597','2026-11-21 20:09:21.996600','','https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=1200&q=85',1,1,'2026-11-07 16:09:21.997207','2026-11-07 16:09:21.997211',1),(2,'Future Forward Tech Summit','future-forward-tech-summit','Ideas and innovation come together.','Hear from builders, engineers, and entrepreneurs. Enjoy thoughtful talks, hands-on demos, and networking.','BICC Convention Center','Dhaka','','2026-12-05 16:09:21.999627','2026-12-05 20:09:21.999631','','https://images.unsplash.com/photo-1540575467063-178a50c2df87?w=1200&q=85',1,1,'2026-11-07 16:09:21.999943','2026-11-07 16:09:21.999946',2),(3,'Colors of Bangladesh','colors-of-bangladesh','Celebrate art, culture, and community.','A colorful celebration of culture with live music, food, performances, and creative activities.','City Convention Hall','Sylhet','','2026-12-12 16:09:22.001617','2026-12-12 20:09:22.001619','','https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=1200&q=85',1,1,'2026-11-07 16:09:22.001871','2026-11-07 16:09:22.001874',3),(4,'Live Music Under the Stars','live-music-under-the-stars','An open-air night of incredible music.','Join us for an inspiring open-air evening with fantastic live performances and a welcoming crowd.','Open Air Arena','Chattogram','','2026-12-19 16:09:22.003327','2026-12-19 20:09:22.003330','','https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=1200&q=85',1,1,'2026-11-07 16:09:22.003579','2026-11-07 16:09:22.003582',1),(5,'Champions Sports Night','champions-sports-night','Be part of the live sporting atmosphere.','Enjoy thrilling live sport and an unforgettable fan experience.','Sports Complex','Dhaka','','2026-12-26 16:09:22.005098','2026-12-26 20:09:22.005100','','https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=1200&q=85',1,1,'2026-11-07 16:09:22.005368','2026-11-07 16:09:22.005371',4),(6,'The Creative Arts Expo','the-creative-arts-expo','Discover extraordinary creative talent.','Explore paintings, contemporary art, installations, and inspiring conversations with artists.','National Art Gallery','Dhaka','','2027-01-02 16:09:22.006712','2027-01-02 20:09:22.006714','','https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=1200&q=85',1,1,'2026-11-07 16:09:22.006967','2026-11-07 16:09:22.006970',5);
/*!40000 ALTER TABLE `events_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_ticket`
--

DROP TABLE IF EXISTS `events_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_ticket` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` char(32) NOT NULL,
  `checked_in_at` datetime(6) DEFAULT NULL,
  `booking_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `events_ticket_booking_id_82b963b0_fk_events_booking_id` (`booking_id`),
  CONSTRAINT `events_ticket_booking_id_82b963b0_fk_events_booking_id` FOREIGN KEY (`booking_id`) REFERENCES `events_booking` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_ticket`
--

LOCK TABLES `events_ticket` WRITE;
/*!40000 ALTER TABLE `events_ticket` DISABLE KEYS */;
INSERT INTO `events_ticket` VALUES (1,'ce57e4ffe55a4033be8976bc735b30ae',NULL,1);
/*!40000 ALTER TABLE `events_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_tickettype`
--

DROP TABLE IF EXISTS `events_tickettype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_tickettype` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `capacity` int unsigned NOT NULL,
  `sold` int unsigned NOT NULL,
  `active` tinyint(1) NOT NULL,
  `event_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `events_tickettype_event_id_name_84cc8305_uniq` (`event_id`,`name`),
  CONSTRAINT `events_tickettype_event_id_9ef8a4b2_fk_events_event_id` FOREIGN KEY (`event_id`) REFERENCES `events_event` (`id`),
  CONSTRAINT `events_tickettype_chk_1` CHECK ((`capacity` >= 0)),
  CONSTRAINT `events_tickettype_chk_2` CHECK ((`sold` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_tickettype`
--

LOCK TABLES `events_tickettype` WRITE;
/*!40000 ALTER TABLE `events_tickettype` DISABLE KEYS */;
INSERT INTO `events_tickettype` VALUES (1,'General Admission',1800.00,250,1,1,1),(2,'VIP',3600.00,60,0,1,1),(3,'General Admission',2500.00,250,0,1,2),(4,'VIP',5000.00,60,0,1,2),(5,'General Admission',850.00,250,0,1,3),(6,'VIP',1700.00,60,0,1,3),(7,'General Admission',1200.00,250,0,1,4),(8,'VIP',2400.00,60,0,1,4),(9,'General Admission',600.00,250,0,1,5),(10,'VIP',1200.00,60,0,1,5),(11,'General Admission',500.00,250,0,1,6),(12,'VIP',1000.00,60,0,1,6);
/*!40000 ALTER TABLE `events_tickettype` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-07 18:36:00
