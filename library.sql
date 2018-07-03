CREATE DATABASE  IF NOT EXISTS `library` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `library`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `description` longtext,
  `writer_id` int(11) NOT NULL,
  `current_stock` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `active` varchar(45) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'All Quiet on the Western Front','This is the testament of Paul Bäumer, who enlists with his classmates in the German army of World War I. These young men become enthusiastic soldiers, but their world of duty, culture, and progress breaks into pieces under the first bombardment in the trenches.',4,2,2,'yes'),(2,'The Fellowship of the Ring','In ancient times the Rings of Power were crafted by the Elven-smiths, and Sauron, The Dark Lord, forged the One Ring, filling it with his own power so that he could rule all others. But the One Ring was taken from him, and though he sought it throughout Middle-earth, it remained lost to him. After many ages it fell into the hands of Bilbo Baggins, as told in The Hobbit.',1,1,1,'yes'),(3,'Selected Poems','Described as mad, bad and dangerous to know by one of his lovers, Lady Caroline Lamb, Lord Byron was the quintessential Romantic. Flamboyant, charismatic and brilliant, he remains almost as notorious for his life - as a political revolutionary, sexual adventurer and traveller - as he does for his literary work. Yet he produced some of the most daring and exuberant poetry',13,4,4,'yes'),(4,'Kad su cvetale tikve','Priča o momku koji je odrastao na Dušanovcu, preživeo rat, osetio posleratnu nemaštinu, snagu Informbiroa, iznenadne smrti u porodici, život u emigraciji...Ljuba Šampion je rastao u kraju gde se sve temeljilo na principu jačeg. Nasilje je bilo jedini mogući uslov opstanka. Bavio se boksom, postizao uspehe, muvao devojke. Prekretnica u njegovom životu je bilo sestrino stradanje. Znao je da je mora osvetiti, da mora kazniti krivca, to je bilo pitanje časti. Nema moralne dileme, samo čeka pravi trenutak...',14,4,4,'yes'),(5,'Srpska Trilogija','Istorijski roman o Balkanskim ratovima i o Prvom svetskom ratu.',11,4,4,'yes'),(6,'Before I Go to Sleep','Christine wakes up every morning in an unfamiliar bed with an unfamiliar man. She looks in the mirror and sees an unfamiliar, middle-aged face. And every morning, the man she has woken up with must explain that he is Ben, he is her husband, she is forty-seven years old, and a terrible accident two decades earlier decimated her ability to form new memories.',12,1,1,'yes'),(7,'Murder on the Orient Express','What more can a mystery addict desire than a much-loathed murder victim found aboard the luxurious Orient Express with multiple stab wounds, thirteen likely suspects, an incomparably brilliant detective in Hercule Poirot, and the most ingenious crime ever conceived?',5,1,1,'yes'),(8,'Kosingas - Red Zmaja','Knjiga koja slobodno može da se nazove srpskom verzijom „Gospodara prstenova”. Monah Gavrilo, odnosno kosingas, vitez reda Zmaja, upoznaje Marka Kraljevića i sa njim kreće u pohod po Srbiji. Prvi zadatak im je da savladaju aždaju na Jezeru lutajućeg ostrva i tako osvoje kasnije toliko čuven Markov buzdovan.',10,1,1,'yes'),(9,'The Good Earth','This tells the poignant tale of a Chinese farmer and his family in old agrarian China. The humble Wang Lung glories in the soil he works, nurturing the land as it nurtures him and his family. Nearby, the nobles of the House of Hwang consider themselves above the land and its workers; but they will soon meet their own downfall.',2,1,1,'yes'),(10,'The Mysterious Island','Five Union prisoners escape from the siege of Richmond in a balloon, are blown off course and crash on an uncharted island. They must learn to rebuild a society for themselves while awaiting rescue.',15,3,3,'yes'),(11,'Hamlet','Among Shakespeare\'s plays, \"Hamlet\" is considered by many his masterpiece. Among actors, the role of Hamlet, Prince of Denmark, is considered the jewel in the crown of a triumphant theatrical career.',21,1,1,'yes'),(12,'The Outsider','An eleven-year-old boy is found in a town park, hideously assaulted and murdered. The fingerprints (and later DNA) are unmistakably those of the townâ€™s most popular baseball coach, Terry Maitland, a man of impeccable reputation.',16,4,4,'yes'),(13,'Wyrd Sisters','Kingdoms wobble, crowns topple and knives flash on the magical Discworld as the statutory three witches meddle in royal politics. The wyrd sisters battle against frightful odds to put the rightful king on the throne.',6,3,3,'yes'),(14,'Everything We Keep','A luminous debut with unexpected twists, Everything We Keep explores the devastation of loss, the euphoria of finding love again, and the pulse-racing repercussions of discovering the truth about the ones we hold dear and the lengths they will go to protect us.',17,3,3,'yes'),(15,'The Kite Runner','Amir is the son of a wealthy Kabul merchant, a member of the ruling caste of Pashtuns. Hassan, his servant and constant companion, is a Hazara, a despised and impoverished caste.',3,4,4,'yes'),(16,'Shards of Honor','When Cordelia Naismith and her survey crew are attacked by a renegade group from Barrayar, she is taken prisoner by Aral Vorkosigan, commander of the Barrayan ship that has been taken over by an ambitious and ruthless crew member. Aral and Cordelia survive countless mishaps while their mutual admiration and even stronger feelings emerge.',18,3,3,'yes'),(17,'The Hobbit','In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to eat: it was a hobbit-hole, and that means comfort.',1,5,5,'yes'),(21,'The Personal Memoirs of Joffre','Marshal Joseph Jacques Césaire Joffre, was a French general who served as Commander-in-Chief of French forces on the Western Front from the start of World War I until the end of 1916. He is best known for regrouping the retreating allied armies to defeat the Germans at the strategically decisive First Battle of the Marne in September 1914',19,3,3,'yes'),(22,'Clementine','Maria Isabella Boyd’s success as a Confederate spy has made her too famous for further espionage work, and now her employment options are slim. Exiled, widowed, and on the brink of poverty…she reluctantly goes to work for the Pinkerton National Detective Agency in Chicago.',20,4,4,'yes'),(23,'Romeo and Juliet','In Romeo and Juliet, Shakespeare creates a world of violence and generational conflict in which two young people fall in love and die because of that love. The story is rather extraordinary in that the normal problems faced by young lovers are here so very large.',21,3,3,'yes'),(28,'Anna Karenina','Acclaimed by many as the world\'s greatest novel, Anna Karenina provides a vast panorama of contemporary life in Russia and of humanity in general. In it Tolstoy uses his intense imaginative insight to create some of the most memorable characters in literature.',22,2,2,'yes'),(29,'War and Peace','War and Peace broadly focuses on Napoleon’s invasion of Russia in 1812 and follows three of the most well-known characters in literature: Pierre Bezukhov, the illegitimate son of a count who is fighting for his inheritance and yearning for spiritual fulfillment; Prince Andrei Bolkonsky, who leaves his family behind to fight in the war against Napoleon; and Natasha Rostov, the beautiful young daughter of a nobleman who intrigues both men.',22,3,3,'yes');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books_genres`
--

DROP TABLE IF EXISTS `books_genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_genres_genres_idx` (`genre_id`),
  KEY `fk_books_genres_books_idx` (`book_id`),
  CONSTRAINT `fk_books_genres_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_books_genres_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books_genres`
--

LOCK TABLES `books_genres` WRITE;
/*!40000 ALTER TABLE `books_genres` DISABLE KEYS */;
INSERT INTO `books_genres` VALUES (5,2,9),(6,2,1),(7,2,33),(8,3,1),(9,3,18),(10,4,1),(11,4,31),(12,4,35),(13,5,30),(14,5,1),(15,6,25),(16,6,15),(17,6,10),(18,7,1),(19,7,15),(20,7,25),(21,8,37),(22,8,9),(23,9,1),(24,9,11),(25,10,1),(26,10,9),(27,10,26),(28,11,1),(29,11,27),(30,11,39),(31,12,12),(32,12,15),(33,12,10),(34,13,9),(35,13,2),(36,14,10),(37,14,15),(38,14,21),(39,15,10),(40,15,11),(41,16,23),(42,16,40),(43,17,9),(44,17,1),(45,17,33),(46,21,13),(47,21,12),(48,21,30),(49,22,23),(50,23,1),(51,23,39),(52,23,21),(60,28,1),(61,28,21),(62,29,1),(63,29,11),(64,29,30),(107,1,1),(108,1,31),(109,1,30);
/*!40000 ALTER TABLE `books_genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `active` varchar(45) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Mitar','Miric','tarmiricmi@zamproduction.com','Batajnicki drum bb',0,'yes'),(2,'Mile','Kitic','kiticm@grand.com','Put za Ovcu bb',0,'yes'),(3,'Sinan','Sakic','sinan@tss.com','Marinkova bara',0,'yes'),(4,'Srecko','Sojic','srele@samsvojgazda.gov.rs','Put za Avalu bb',0,'yes'),(5,'Miki','Mecava','samodasebeli@lobetina.com','Kolumbijskih polja 2',0,'yes'),(6,'Zika','Sarenica','zikaseljak@selo.co.rs','Lajkovacka pruga 1',0,'yes'),(7,'Zeljko','Mitrovic','dirigentwannabe@pink.rs','Simanovci bb',0,'yes'),(8,'Bili','Piton','ludisesirdzija@maratonci.com','Grobljanska 10',0,'yes'),(9,'Al','Kapone','maliali@kozanostra.com','Vice Avenue 1',0,'yes'),(10,'Marko','Kraljevic','marebatica@pravisrpskijunak.rs','Mrnjavcevic Marka 10',0,'no'),(11,'Marko','Nikolic','zmajeviognjenogvuka@gmail.com','Strumicka 98',0,'yes');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,'Classics'),(2,'Comedy'),(3,'Art'),(4,'Biography'),(5,'Children\'s'),(6,'Comics'),(7,'Cookbooks'),(8,'Crime'),(9,'Fantasy'),(10,'Fiction'),(11,'History'),(12,'Horror'),(13,'Memoir'),(14,'Music'),(15,'Mystery'),(16,'Paranormal'),(17,'Philosophy'),(18,'Poetry'),(19,'Psychology'),(20,'Religion'),(21,'Romance'),(22,'Science'),(23,'Sci-Fi'),(24,'Sports'),(25,'Thriller'),(26,'Travel'),(27,'Drama'),(30,'War'),(31,'Literature'),(33,'Adventure'),(35,'Novels'),(36,'Academic'),(37,'Mythology'),(39,'Plays'),(40,'Space');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_client` int(11) NOT NULL,
  `created` datetime NOT NULL DEFAULT '2018-03-27 14:24:53',
  `due` datetime NOT NULL DEFAULT '2018-04-02 14:24:53',
  `opened` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `fk_rentals_clients_idx` (`id_client`),
  CONSTRAINT `fk_rentals_clients` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (1,1,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(2,1,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(3,4,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(4,4,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(5,2,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(6,2,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(7,3,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(8,3,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(9,5,'2018-03-27 14:24:53','2018-04-02 14:24:53','no'),(10,3,'2018-05-09 18:56:42','2018-05-09 19:00:12','no'),(12,3,'2018-05-10 02:17:01','2018-05-10 02:18:28','no'),(13,11,'2018-05-13 13:55:17','2018-05-13 13:55:47','no'),(14,10,'2018-05-13 13:56:49','2018-05-16 00:40:32','no'),(15,10,'2018-05-13 13:57:10','2018-05-16 00:40:38','no'),(16,9,'2018-05-13 17:55:31','2018-05-14 15:26:43','no'),(17,11,'2018-05-14 00:18:21','2018-05-16 00:40:44','no'),(18,9,'2018-05-14 00:29:08','2018-05-16 00:40:24','no'),(19,10,'2018-05-19 21:57:12','2018-05-19 22:31:24','no'),(20,11,'2018-05-20 11:58:06','2018-05-23 00:13:51','no'),(21,10,'2018-05-20 12:01:30','2018-05-23 00:03:34','no'),(23,11,'2018-06-29 14:41:16','2018-06-29 14:49:15','no'),(24,9,'2018-06-29 14:51:36','2018-06-29 15:54:01','no');
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals_books`
--

DROP TABLE IF EXISTS `rentals_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentals_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_rental` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rentals_films_rentals_idx` (`id_rental`),
  KEY `fk_rentals_films_films_idx` (`id_book`),
  CONSTRAINT `fk_rentals_books_books` FOREIGN KEY (`id_book`) REFERENCES `books` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rentals_books_rentals` FOREIGN KEY (`id_rental`) REFERENCES `rentals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals_books`
--

LOCK TABLES `rentals_books` WRITE;
/*!40000 ALTER TABLE `rentals_books` DISABLE KEYS */;
INSERT INTO `rentals_books` VALUES (1,1,6),(2,1,1),(3,2,2),(4,3,7),(5,3,8),(6,4,3),(7,4,4),(8,5,3),(9,5,8),(10,6,7),(11,6,5),(12,7,3),(13,8,9),(14,8,7),(15,9,1),(16,9,2),(17,9,3),(18,10,16),(19,12,1),(20,12,21),(21,12,17),(22,13,23),(23,13,16),(24,13,17),(25,14,17),(26,15,16),(27,16,9),(28,17,7),(29,18,1),(30,19,9),(31,19,8),(32,20,7),(33,21,1),(34,21,1),(35,23,22),(36,24,29),(37,24,8);
/*!40000 ALTER TABLE `rentals_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `full_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `priviledge` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'marniko','Marko Nikolic','12345','admin'),(2,'pera','Pera Peric','54321','user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writers`
--

DROP TABLE IF EXISTS `writers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `writers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writers`
--

LOCK TABLES `writers` WRITE;
/*!40000 ALTER TABLE `writers` DISABLE KEYS */;
INSERT INTO `writers` VALUES (1,'J.','R. R. Tolkien'),(2,'Pearl S.','Buck'),(3,'Khaled','Hosseini'),(4,'Erich Maria','Remarque'),(5,'Agatha','Christie'),(6,'Terry','Pratchett'),(10,'Aleksandar','Tešić'),(11,'Stevan','Jakovljević'),(12,'S.J.','Watson'),(13,'George Gordon','Byron'),(14,'Dragoslav','Mihailović'),(15,'Jules','Verne'),(16,'Stephen','King'),(17,'Kerry','Lonsdale'),(18,'Lois','McMaster Bujold'),(19,'Joseph','Joffre'),(20,'Cherie','Priest'),(21,'William','Shakespeare'),(22,'Leo','Tolstoy');
/*!40000 ALTER TABLE `writers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'library'
--

--
-- Dumping routines for database 'library'
--
/*!50003 DROP PROCEDURE IF EXISTS `CLOSE_RENTAL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CLOSE_RENTAL`(_rental_id int(11), _client_id int(11))
begin
	declare num_of_books_at_rental int;

	select count(*) from rentals_books where id_rental = _rental_id into num_of_books_at_rental;

	update rentals set opened = 'no', due = now() where id = _rental_id;
	update clients set stock = stock - num_of_books_at_rental where id = _client_id;
	update books set current_stock = current_stock + 1 where id in (select id_book from rentals_books where id_rental = _rental_id);

	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EDIT_BOOK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `EDIT_BOOK`(_title varchar(45), _description longtext, _writer varchar(45), _stock int(11), _current_stock int(11), _genre_id_1 int(11), _genre_id_2 int(11), _genre_id_3 int(11), _id_book int(11))
begin
	declare id_writer int;

	select id from writers where concat(first_name, ' ', last_name) = _writer into id_writer;

	update books set title = _title, description = _description, writer_id = id_writer, current_stock = _current_stock, stock = _stock where id = _id_book;

	delete from books_genres where book_id = _id_book;

	insert into books_genres values (null, _id_book, _genre_id_1);

	if _genre_id_2 != 0 then
		insert into books_genres values (null, _id_book, _genre_id_2);
	end if;
	if _genre_id_3 != 0 then
		insert into books_genres values (null, _id_book, _genre_id_3);
	end if;

	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_NEW_BOOK` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_NEW_BOOK`(_title varchar(45), _description longtext, _writer varchar(45), _stock int(11), _genre_id_1 int(11), _genre_id_2 int(11), _genre_id_3 int(11))
begin
	declare writer_id int;
	declare book_id int;

	select id from writers where concat(first_name, ' ', last_name) = _writer into writer_id;

	insert into books values (null, _title, _description, writer_id, _stock, _stock, default);

	select max(id) from books into book_id;

	
	insert into books_genres values (null, book_id, _genre_id_1);

	if _genre_id_2 != 0 then
		insert into books_genres values (null, book_id, _genre_id_2);
	end if;
	if _genre_id_3 != 0 then
		insert into books_genres values (null, book_id, _genre_id_3);
	end if;

	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INSERT_RENTAL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_RENTAL`(_client varchar(45), _title_1 varchar(45), _title_2 varchar(45), _title_3 varchar(45), _title_4 varchar(45), _title_5 varchar(45))
begin
	declare client_id int;
	declare rental_id int;
	declare curr_client_stock int;


	select id from clients where concat(first_name, " ", last_name) = _client into client_id;
	select stock from clients where concat(first_name, " ", last_name) = _client into curr_client_stock;
	
	set @client_stock = curr_client_stock;


	insert into rentals values (null, client_id, now(), now() + interval 7 day, 'yes');

	set @max_rentals_id = (select max(id) from rentals);
	
	

	if _title_1 != '' then
		set @id_book = (select id from books where title = _title_1);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_1);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_1;
	end if;
	if _title_2 != '' then
		set @id_book = (select id from books where title = _title_2);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_2);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_2;
	end if;
	if _title_3 != '' then
		set @id_book = (select id from books where title = _title_3);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_3);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_3;
	end if;
	if _title_4 != '' then
		set @id_book = (select id from books where title = _title_4);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_4);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_4;
	end if;
	if _title_5 != '' then
		set @id_book = (select id from books where title = _title_5);
		insert into rentals_books values (null, @max_rentals_id, @id_book);
		set @client_stock = @client_stock + 1;
		set @current_book_stock = (select current_stock from books where title = _title_5);
		set @current_book_stock = @current_book_stock - 1;
		update books set current_stock = @current_book_stock where title = _title_5;
	end if;
	
	update clients set stock = @client_stock where concat(first_name, " ", last_name) = _client;

	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `NUM_OF_FILMS_AT_CLIENT` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NUM_OF_FILMS_AT_CLIENT`(`_client` VARCHAR(45))
begin
	declare client_id int;

	select id from clients where concat(first_name, " ", last_name) = _client into client_id;

	select count(*) as num_of_films_at_client from rentals_films where id_rental in (select id from rentals where id_client = client_id and opened = 'yes');

	end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-03 16:28:03
