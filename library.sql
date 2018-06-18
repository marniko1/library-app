-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 18, 2018 at 08:01 PM
-- Server version: 5.7.21
-- PHP Version: 7.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `CLOSE_RENTAL`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CLOSE_RENTAL` (`_rental_id` INT(11), `_client_id` INT(11))  begin
	declare num_of_films_at_rental int;

	select count(*) from rentals_films where id_rental = _rental_id into num_of_films_at_rental;

	update rentals set opened = 'no', due = now() where id = _rental_id;
	update clients set stock = stock - num_of_films_at_rental where id = _client_id;
	update films set current_stock = current_stock + 1 where id in (select id_film from rentals_films where id_rental = _rental_id);

	end$$

DROP PROCEDURE IF EXISTS `INSERT_RENTAL`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `INSERT_RENTAL` (`_client` VARCHAR(45), `_title_1` VARCHAR(45), `_title_2` VARCHAR(45), `_title_3` VARCHAR(45), `_title_4` VARCHAR(45), `_title_5` VARCHAR(45))  begin
	declare client_id int;
	declare rental_id int;
	declare curr_client_stock int;


	select id from clients where concat(first_name, " ", last_name) = _client into client_id;
	select stock from clients where concat(first_name, " ", last_name) = _client into curr_client_stock;
	
	set @client_stock = curr_client_stock;
	set @totals = 0;


	insert into rentals values (null, client_id, 0, now(), now() + interval 7 day, 'yes');

	set @max_rentals_id = (select max(id) from rentals);
	
	

	if _title_1 != '' then
		set @id_film = (select id from films where title = _title_1);
		set @film_price = (select price from films where title = _title_1);
		insert into rentals_films values (null, @max_rentals_id, @id_film);
		set @totals = @totals + @film_price;
		set @client_stock = @client_stock + 1;
		set @current_film_stock = (select current_stock from films where title = _title_1);
		set @current_film_stock = @current_film_stock - 1;
		update films set current_stock = @current_film_stock where title = _title_1;
	end if;
	if _title_2 != '' then
		set @id_film = (select id from films where title = _title_2);
		set @film_price = (select price from films where title = _title_2);
		insert into rentals_films values (null, @max_rentals_id, @id_film);
		set @totals = @totals + @film_price;
		set @client_stock = @client_stock + 1;
		set @current_film_stock = (select current_stock from films where title = _title_2);
		set @current_film_stock = @current_film_stock - 1;
		update films set current_stock = @current_film_stock where title = _title_2;
	end if;
	if _title_3 != '' then
		set @id_film = (select id from films where title = _title_3);
		set @film_price = (select price from films where title = _title_3);
		insert into rentals_films values (null, @max_rentals_id, @id_film);
		set @totals = @totals + @film_price;
		set @client_stock = @client_stock + 1;
		set @current_film_stock = (select current_stock from films where title = _title_3);
		set @current_film_stock = @current_film_stock - 1;
		update films set current_stock = @current_film_stock where title = _title_3;
	end if;
	if _title_4 != '' then
		set @id_film = (select id from films where title = _title_4);
		set @film_price = (select price from films where title = _title_4);
		insert into rentals_films values (null, @max_rentals_id, @id_film);
		set @totals = @totals + @film_price;
		set @client_stock = @client_stock + 1;
		set @current_film_stock = (select current_stock from films where title = _title_4);
		set @current_film_stock = @current_film_stock - 1;
		update films set current_stock = @current_film_stock where title = _title_4;
	end if;
	if _title_5 != '' then
		set @id_film = (select id from films where title = _title_5);
		set @film_price = (select price from films where title = _title_5);
		insert into rentals_films values (null, @max_rentals_id, @id_film);
		set @totals = @totals + @film_price;
		set @client_stock = @client_stock + 1;
		set @current_film_stock = (select current_stock from films where title = _title_5);
		set @current_film_stock = @current_film_stock - 1;
		update films set current_stock = @current_film_stock where title = _title_5;
	end if;
	
	update rentals set totals = @totals where id = @max_rentals_id;
	update clients set stock = @client_stock where concat(first_name, " ", last_name) = _client;

	end$$

DROP PROCEDURE IF EXISTS `NUM_OF_FILMS_AT_CLIENT`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `NUM_OF_FILMS_AT_CLIENT` (`_client` VARCHAR(45))  begin
	declare client_id int;

	select id from clients where concat(first_name, " ", last_name) = _client into client_id;

	select count(*) as num_of_films_at_client from rentals_films where id_rental in (select id from rentals where id_client = client_id and opened = 'yes');

	end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
CREATE TABLE IF NOT EXISTS `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `description` longtext,
  `genre` varchar(255) DEFAULT NULL,
  `writer_id` int(11) NOT NULL,
  `current_stock` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `active` varchar(45) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `description`, `genre`, `writer_id`, `current_stock`, `stock`, `active`) VALUES
(1, 'All Quiet on the Western Front', 'This is the testament of Paul BÃ¤umer, who enlists with his classmates in the German army of World War I. These young men become enthusiastic soldiers, but their world of duty, culture, and progress breaks into pieces under the first bombardment in the trenches.', 'Classics', 4, 1, 2, 'yes'),
(2, 'The Fellowship of the Ring', 'In ancient times the Rings of Power were crafted by the Elven-smiths, and Sauron, The Dark Lord, forged the One Ring, filling it with his own power so that he could rule all others. But the One Ring was taken from him, and though he sought it throughout Middle-earth, it remained lost to him. After many ages it fell into the hands of Bilbo Baggins, as told in The Hobbit.', 'Classics, Fantasy', 1, 1, 1, 'yes'),
(3, 'Selected Poems', 'Described as mad, bad and dangerous to know by one of his lovers, Lady Caroline Lamb, Lord Byron was the quintessential Romantic. Flamboyant, charismatic and brilliant, he remains almost as notorious for his life - as a political revolutionary, sexual adventurer and traveller - as he does for his literary work. Yet he produced some of the most daring and exuberant poetry', 'Classics, Poetry', 13, 4, 4, 'yes'),
(4, 'Kad su cvetale tikve', 'PriÄa o momku koji je odrastao na DuÅ¡anovcu, preÅ¾iveo rat, osetio posleratnu nemaÅ¡tinu, snagu Informbiroa, iznenadne smrti u porodici, Å¾ivot u emigraciji...Ljuba Å ampion je rastao u kraju gde se sve temeljilo na principu jaÄeg. Nasilje je bilo jedini moguÄ‡i uslov opstanka. Bavio se boksom, postizao uspehe, muvao devojke. Prekretnica u njegovom Å¾ivotu je bilo sestrino stradanje. Znao je da je mora osvetiti, da mora kazniti krivca, to je bilo pitanje Äasti. Nema moralne dileme, samo Äeka pravi trenutak...', 'Classics', 14, 4, 4, 'yes'),
(5, 'Srpska Trilogija', 'Istorijski roman o Balkanskim ratovima i o Prvom svetskom ratu.', 'Classics\r\n', 11, 4, 4, 'yes'),
(6, 'Before I Go to Sleep', 'Memories define us.\r\n\r\nSo what if you lost yours every time you went to sleep?\r\n\r\nYour name, your identity, your past, even the people you loveâ€”all forgotten overnight.', 'Fantasy, Mystery, Thriller', 12, 1, 1, 'yes'),
(7, 'Murder on the Orient Express', 'What more can a mystery addict desire than a much-loathed murder victim found aboard the luxurious Orient Express with multiple stab wounds, thirteen likely suspects, an incomparably brilliant detective in Hercule Poirot, and the most ingenious crime ever conceived?', ' Mystery, Classics, Thriller', 5, 1, 1, 'yes'),
(8, 'Kosingas - Red Zmaja', 'Knjiga koja slobodno moÅ¾e da se nazove srpskom verzijom â€žGospodara prstenovaâ€. Monah Gavrilo, odnosno kosingas, vitez reda Zmaja, upoznaje Marka KraljeviÄ‡a i sa njim kreÄ‡e u pohod po Srbiji. Prvi zadatak im je da savladaju aÅ¾daju na Jezeru lutajuÄ‡eg ostrva i tako osvoje kasnije toliko Äuven Markov buzdovan.', 'Fantasy', 10, 1, 1, 'yes'),
(9, 'The Good Earth', 'This tells the poignant tale of a Chinese farmer and his family in old agrarian China. The humble Wang Lung glories in the soil he works, nurturing the land as it nurtures him and his family. Nearby, the nobles of the House of Hwang consider themselves above the land and its workers; but they will soon meet their own downfall.', 'Classics', 2, 1, 1, 'yes'),
(10, 'The Mysterious Island', 'Five Union prisoners escape from the siege of Richmond in a balloon, are blown off course and crash on an uncharted island. They must learn to rebuild a society for themselves while awaiting rescue.', 'Classics, Fantasy, Travel', 15, 3, 3, 'yes'),
(11, 'Titan', 'A military family takes part in a ground-breaking experiment of genetic evolution and space exploration.', ' Sci-Fi, Thriller', 260, 1, 1, 'yes'),
(12, 'The Outsider', 'An eleven-year-old boy is found in a town park, hideously assaulted and murdered. The fingerprints (and later DNA) are unmistakably those of the townâ€™s most popular baseball coach, Terry Maitland, a man of impeccable reputation.', 'Horror, Thriller, Mystery', 16, 4, 4, 'yes'),
(13, 'Wyrd Sisters', 'Kingdoms wobble, crowns topple and knives flash on the magical Discworld as the statutory three witches meddle in royal politics. The wyrd sisters battle against frightful odds to put the rightful king on the throne.', 'Comedy, Fantasy', 6, 3, 3, 'yes'),
(14, 'Everything We Keep', 'A luminous debut with unexpected twists, Everything We Keep explores the devastation of loss, the euphoria of finding love again, and the pulse-racing repercussions of discovering the truth about the ones we hold dear and the lengths they will go to protect us.', ' Fantasy, Mystery,\r\nRomance', 150, 3, 3, 'yes'),
(15, 'The Kite Runner', 'Amir is the son of a wealthy Kabul merchant, a member of the ruling caste of Pashtuns. Hassan, his servant and constant companion, is a Hazara, a despised and impoverished caste.', 'Classics', 3, 4, 4, 'yes'),
(16, 'Shards of Honor', 'When Cordelia Naismith and her survey crew are attacked by a renegade group from Barrayar, she is taken prisoner by Aral Vorkosigan, commander of the Barrayan ship that has been taken over by an ambitious and ruthless crew member. Aral and Cordelia survive countless mishaps while their mutual admiration and even stronger feelings emerge.', 'Sci-Fi', 300, 3, 3, 'yes'),
(17, 'The Hobbit', 'In a hole in the ground there lived a hobbit. Not a nasty, dirty, wet hole, filled with the ends of worms and an oozy smell, nor yet a dry, bare, sandy hole with nothing in it to sit down on or to eat: it was a hobbit-hole, and that means comfort.', 'Fantasy, Classics', 1, 5, 5, 'yes'),
(21, 'The Personal Memoirs of Joffre', 'Marshal Joseph Jacques CÃ©saire Joffre, was a French general who served as Commander-in-Chief of French forces on the Western Front from the start of World War I until the end of 1916. He is best known for regrouping the retreating allied armies to defeat the Germans at the strategically decisive First Battle of the Marne in September 1914', 'Memoir', 159, 3, 3, 'yes'),
(22, 'Clementine', 'Maria Isabella Boydâ€™s success as a Confederate spy has made her too famous for further espionage work, and now her employment options are slim. Exiled, widowed, and on the brink of povertyâ€¦she reluctantly goes to work for the Pinkerton National Detective Agency in Chicago.', 'Sci-Fi, Fantasy', 300, 4, 4, 'yes'),
(23, 'Romeo and Juliet', 'In Romeo and Juliet, Shakespeare creates a world of violence and generational conflict in which two young people fall in love and die because of that love. The story is rather extraordinary in that the normal problems faced by young lovers are here so very large.', 'Classics, Romance', 149, 3, 3, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `books_genres`
--

DROP TABLE IF EXISTS `books_genres`;
CREATE TABLE IF NOT EXISTS `books_genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_books_genres_genres_idx` (`genre_id`),
  KEY `fk_books_genres_books_idx` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT '0',
  `active` varchar(45) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `first_name`, `last_name`, `email`, `address`, `stock`, `active`) VALUES
(1, 'Mitar', 'Miric', 'tarmiricmi@zamproduction.com', 'Batajnicki drum bb', 0, 'yes'),
(2, 'Mile', 'Kitic', 'kiticm@grand.com', 'Put za Ovcu bb', 0, 'yes'),
(3, 'Sinan', 'Sakic', 'sinan@tss.com', 'Marinkova bara', 0, 'yes'),
(4, 'Srecko', 'Sojic', 'srele@samsvojgazda.gov.rs', 'Put za Avalu bb', 0, 'yes'),
(5, 'Miki', 'Mecava', 'samodasebeli@lobetina.com', 'Kolumbijskih polja 2', 0, 'yes'),
(6, 'Zika', 'Sarenica', 'zikaseljak@selo.co.rs', 'Lajkovacka pruga 1', 0, 'yes'),
(7, 'Zeljko', 'Mitrovic', 'dirigentwannabe@pink.rs', 'Simanovci bb', 0, 'yes'),
(8, 'Bili', 'Piton', 'ludisesirdzija@maratonci.com', 'Grobljanska 10', 0, 'yes'),
(9, 'Al', 'Kapone', 'maliali@kozanostra.com', 'Vice Avenue 1', 0, 'yes'),
(10, 'Marko', 'Kraljevic', 'marebatica@pravisrpskijunak.rs', 'Mrnjavcevic Marka 10', 0, 'no'),
(11, 'Marko', 'Nikolic', 'zmajeviognjenogvuka@gmail.com', 'Strumicka 98', 0, 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
CREATE TABLE IF NOT EXISTS `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `title`) VALUES
(1, 'Classics'),
(2, 'Comedy'),
(3, 'Art'),
(4, 'Biography'),
(5, 'Children\\\'s'),
(6, 'Comics'),
(7, 'Cookbooks'),
(8, 'Crime'),
(9, 'Fantasy'),
(10, 'Fiction'),
(11, 'History'),
(12, 'Horror'),
(13, 'Memoir'),
(14, 'Music'),
(15, 'Mystery'),
(16, 'Paranormal'),
(17, 'Philosophy'),
(18, 'Poetry'),
(19, 'Psychology'),
(20, 'Religion'),
(21, 'Romance'),
(22, 'Science'),
(23, 'Sci-Fi'),
(24, 'Sports'),
(25, 'Thriller'),
(26, 'Travel');

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
CREATE TABLE IF NOT EXISTS `rentals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_client` int(11) NOT NULL,
  `totals` decimal(6,2) NOT NULL,
  `created` datetime NOT NULL DEFAULT '2018-03-27 14:24:53',
  `due` datetime NOT NULL DEFAULT '2018-04-02 14:24:53',
  `opened` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`),
  KEY `fk_rentals_clients_idx` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rentals`
--

INSERT INTO `rentals` (`id`, `id_client`, `totals`, `created`, `due`, `opened`) VALUES
(1, 1, '435.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(2, 1, '260.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(3, 4, '430.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(4, 4, '550.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(5, 2, '485.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(6, 2, '325.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(7, 3, '270.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(8, 3, '500.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(9, 5, '750.00', '2018-03-27 14:24:53', '2018-04-02 14:24:53', 'no'),
(10, 3, '200.00', '2018-05-09 18:56:42', '2018-05-09 19:00:12', 'no'),
(12, 3, '579.48', '2018-05-10 02:17:01', '2018-05-10 02:18:28', 'no'),
(13, 11, '549.48', '2018-05-13 13:55:17', '2018-05-13 13:55:47', 'no'),
(14, 10, '199.99', '2018-05-13 13:56:49', '2018-05-16 00:40:32', 'no'),
(15, 10, '200.00', '2018-05-13 13:57:10', '2018-05-16 00:40:38', 'no'),
(16, 9, '285.00', '2018-05-13 17:55:31', '2018-05-14 15:26:43', 'no'),
(17, 11, '215.00', '2018-05-14 00:18:21', '2018-05-16 00:40:44', 'no'),
(18, 9, '220.00', '2018-05-14 00:29:08', '2018-05-16 00:40:24', 'no'),
(19, 10, '500.00', '2018-05-19 21:57:12', '2018-05-19 22:31:24', 'no'),
(20, 11, '215.00', '2018-05-20 11:58:06', '2018-05-23 00:13:51', 'no'),
(21, 10, '440.00', '2018-05-20 12:01:30', '2018-05-23 00:03:34', 'no');

-- --------------------------------------------------------

--
-- Table structure for table `rentals_books`
--

DROP TABLE IF EXISTS `rentals_books`;
CREATE TABLE IF NOT EXISTS `rentals_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_rental` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rentals_films_rentals_idx` (`id_rental`),
  KEY `fk_rentals_films_films_idx` (`id_book`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rentals_books`
--

INSERT INTO `rentals_books` (`id`, `id_rental`, `id_book`) VALUES
(1, 1, 6),
(2, 1, 1),
(3, 2, 2),
(4, 3, 7),
(5, 3, 8),
(6, 4, 3),
(7, 4, 4),
(8, 5, 3),
(9, 5, 8),
(10, 6, 7),
(11, 6, 5),
(12, 7, 3),
(13, 8, 9),
(14, 8, 7),
(15, 9, 1),
(16, 9, 2),
(17, 9, 3),
(18, 10, 16),
(19, 12, 1),
(20, 12, 21),
(21, 12, 17),
(22, 13, 23),
(23, 13, 16),
(24, 13, 17),
(25, 14, 17),
(26, 15, 16),
(27, 16, 9),
(28, 17, 7),
(29, 18, 1),
(30, 19, 9),
(31, 19, 8),
(32, 20, 7),
(33, 21, 1),
(34, 21, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `full_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `priviledge` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `full_name`, `password`, `priviledge`) VALUES
(1, 'marniko', 'Marko Nikolic', '12345', 'admin'),
(2, 'pera', 'Pera Peric', '54321', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `writers`
--

DROP TABLE IF EXISTS `writers`;
CREATE TABLE IF NOT EXISTS `writers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `writers`
--

INSERT INTO `writers` (`id`, `first_name`, `last_name`) VALUES
(1, 'John Ronald Reuel', 'Tolkien'),
(2, 'Pearl S.', 'Buck'),
(3, 'Khaled', 'Hosseini'),
(4, 'Erich Maria', 'Remarque'),
(5, 'Agatha', 'Christie'),
(6, 'Terry', 'Pratchett'),
(10, 'Aleksandar', 'Tešić'),
(11, 'Stevan', 'Jakovljević'),
(12, 'S.J.', 'Watson'),
(13, 'George Gordon', 'Byron'),
(14, 'Dragoslav', 'Mihailović'),
(15, 'Jules', 'Verne'),
(16, 'Stephen', 'King');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books_genres`
--
ALTER TABLE `books_genres`
  ADD CONSTRAINT `fk_books_genres_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_books_genres_genres` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rentals`
--
ALTER TABLE `rentals`
  ADD CONSTRAINT `fk_rentals_clients` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rentals_books`
--
ALTER TABLE `rentals_books`
  ADD CONSTRAINT `fk_rentals_books_books` FOREIGN KEY (`id_book`) REFERENCES `books` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_rentals_books_rentals` FOREIGN KEY (`id_rental`) REFERENCES `rentals` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
