-- MySQL dump 10.13  Distrib 5.1.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: miniconomy
-- ------------------------------------------------------
-- Server version	5.1.41-3ubuntu12.9

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
-- Table structure for table `ShopsData`
--

DROP TABLE IF EXISTS `ShopsData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShopsData` (
  `city` varchar(30) DEFAULT NULL,
  `street` varchar(30) DEFAULT NULL,
  `shopname` varchar(30) DEFAULT NULL,
  `shopnumber` smallint(6) DEFAULT NULL,
  `ownername` varchar(30) DEFAULT NULL,
  `qt` smallint(6) DEFAULT NULL,
  `pd` varchar(30) DEFAULT NULL,
  `px` decimal(6,2) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShopsData`
--

LOCK TABLES `ShopsData` WRITE;
/*!40000 ALTER TABLE `ShopsData` DISABLE KEYS */;
INSERT INTO `ShopsData` VALUES ('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',52,'Screwdriver','42.00'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',108,'Saw','27.30'),('Kronenburg','Hoofdstraat','Draain KB',10,'Draaiers MV ',40,'Screwdriver','18.38'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',10,'Pump','210.00'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',250,'Plastic','10.50'),('Kronenburg','Hoofdstraat','Pompen of Verzuipen',2,'Car-Dealertje  ',18,'Pump','73.50'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',10,'Oven','525.00'),('Kronenburg','Hoofdstraat','Plastic - Machines',4,'Plastic dame  ',310,'Plastic','5.25'),('Kronenburg','Hoofdstraat','Plastic - Machines',4,'Plastic dame  ',1000,'Oil','1.00'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',8,'Machine','577.50'),('Kronenburg','Hoofdstraat','Drop Shop',11,'Droppert  ',213,'Oil','0.80'),('Kronenburg','Hoofdstraat','Plastic - Machines',4,'Plastic dame  ',1,'Machine','288.75'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',77,'Iron','15.75'),('Kronenburg','Hoofdstraat','Drop Shop',11,'Droppert  ',1,'Glass','36.75'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',494,'Glass','63.00'),('Kronenburg','Zijstraat','joeys store',1,'joey123  ',2,'Gold','6.50'),('Kronenburg','Hoofdstraat','special mix',6,'zwabber ',51,'Gas','3.57'),('Kronenburg','Hoofdstraat','KB Benz Olie Goud',9,'martijn5  ',80,'Gas','2.63'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',9340,'Wood','1.31'),('Centropolis','A Road','byterwood',12,'bytertje  ',743,'Wood','0.56'),('Centropolis','A Road','Shop CP',7,'alecto  ',1,'Tree','15.00'),('Centropolis','A Road','byterwood',12,'bytertje  ',77,'Tree','15.00'),('Centropolis','C Road','Merkator',1,'Marko Polo ',100,'Wood','0.49'),('Centropolis','C Road','Merkur',2,'Marko Polo ',100,'Wood','0.49'),('Centropolis','A Road','Independence',3,'Kitten Schneider  ',14,'Screwdriver','21.00'),('Centropolis','A Road','CP Sale',13,'billdazerr ',40,'Shovel','21.00'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',237,'Shovel','27.30'),('Centropolis','A Road','General Stuff',6,'martinko ',47,'Screwdriver','13.65'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',236,'Saw','27.30'),('Centropolis','A Road','Independence',3,'Kitten Schneider  ',13,'Pump','84.00'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',230,'Plastic','10.50'),('Centropolis','A Road','Kat Plastic',5,'gelaarsdekat  ',123,'Plastic','4.94'),('Centropolis','A Road','Bricks Centro',14,'voetbalfan19 ',80,'Plastic','8.40'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',10,'Oven','525.00'),('Centropolis','A Road','CP Sale',13,'billdazerr ',1,'Oven','315.00'),('Centropolis','A Road','Kat Plastic',5,'gelaarsdekat  ',132,'Oil','1.00'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',8,'Machine','577.50'),('Centropolis','A Road','Schneider Gas',9,'KSGas MV ',1,'Machine','430.50'),('Centropolis','A Road','Kat Plastic',5,'gelaarsdekat  ',1,'Machine','325.50'),('Centropolis','A Road','small and big',10,'mixer ',1,'Machine','313.95'),('Centropolis','B Road','the shop',1,'dayynn ',20,'Iron Ore','5.00'),('Centropolis','E Road','GOLD RUSH',1,'Stevebb ',30,'Gold','6.50'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',130,'Iron','15.75'),('Centropolis','A Road','CP shopping',2,'R3knowAL  ',112,'Iron','11.55'),('Centropolis','A Road','Shell',8,'filno619 ',2,'Gold','5.00'),('Centropolis','A Road','Bricks Centro',14,'voetbalfan19 ',20,'Glass','25.20'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',479,'Glass','63.00'),('Centropolis','A Road','small and big',10,'mixer ',13,'Glass','21.00'),('Centropolis','A Road','Great Oils CP',4,'Manuel The Great  ',77,'Gas','1.89'),('Centropolis','A Road','OO Store CP',11,'marnixoo ',14,'Chip','38.85'),('Centropolis','A Road','small and big',10,'mixer ',2,'Alarm','315.00'),('Centropolis','A Road','OO Store CP',11,'marnixoo ',6,'Alarm','315.00'),('Centropolis','C Road','Merkur',2,'Marko Polo ',1,'Brick','3.26'),('Centropolis','A Road','OO Store CP',11,'marnixoo ',272,'Brick','5.04'),('Centropolis','A Road','byterwood',12,'bytertje  ',233,'Brick','6.04'),('Centropolis','A Road','FES Centropolis',1,'Federal Government  ',2278,'Brick','9.45'),('Centropolis','A Road','small and big',10,'mixer ',16,'Bulletproof Vest','111.30'),('Centropolis','A Road','Cameras',15,'Camera MV ',6,'Camera','273.00'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',2353,'Brick','9.45'),('Kronenburg','Hoofdstraat','GK steen KB',5,'gelaarsdekat1  ',29,'Brick','5.24'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',3849,'Wood','1.38'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',245,'Shovel','28.60'),('Eurodam','Hoofdstraat','wood and trees ED',6,'tycoonfreak  ',250,'Wood','0.58'),('Eurodam','Hoofdstraat','Paradiso',4,'Vincent - Turner ',14,'Shovel','18.70'),('Eurodam','Hoofdstraat','Shop Eurodam',2,'The Eye  ',70,'Shovel','11.00'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',71,'Screwdriver','44.00'),('Eurodam','Hoofdstraat','Kat Steen',3,'gelaarsdekat1  ',1,'Screwdriver','13.20'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',5,'Pump','220.00'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',230,'Saw','28.60'),('Eurodam','Hoofdstraat','Pompen en Motoren ED',7,'mattn ',20,'Plastic','6.05'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',3,'Plastic','11.00'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',10,'Oven','550.00'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',524,'Iron','16.50'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',4,'Machine','605.00'),('Eurodam','Hoofdstraat','Pompen en Motoren',5,'G,G ',8,'Engine','69.30'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',493,'Glass','66.00'),('Eurodam','Hoofdstraat','Kat Steen',3,'gelaarsdekat1  ',1,'Diamond drill','275.00'),('Eurodam','Hoofdstraat','Kat Steen',3,'gelaarsdekat1  ',47,'Diamond','15.00'),('Eurodam','Hoofdstraat','FES Eurodam',1,'Federal Government  ',2475,'Brick','9.90'),('Eurodam','Hoofdstraat','Kat Steen',3,'gelaarsdekat1  ',496,'Brick','5.23'),('Nasdaqar','Main Street','Schneider Machines',7,'Schneider MV ',3,'Wood','0.79'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',9842,'Wood','1.31'),('Nasdaqar','Main Street','My Wood 2',16,'Tashar ',500,'Wood','0.42'),('Nasdaqar','Main Street','My Wood',15,'Tashar ',180,'Wood','0.40'),('Nasdaqar','Main Street','Chippies Nsq',2,'viraxje  ',39,'Tree','9.00'),('Nasdaqar','Main Street','Lumber Mill',17,'ProxDox ',3,'Tree','30.00'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',245,'Shovel','27.30'),('Nasdaqar','Clubs and Houses','shovels n saws',2,'salesman10 ',14,'Shovel','16.80'),('Nasdaqar','Main Street','Shovels NSQ',9,'Ronald  ',75,'Shovel','13.65'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',98,'Screwdriver','42.00'),('Nasdaqar','Main Street','screw-drivers',11,'SD3E MV ',80,'Screwdriver','22.05'),('Nasdaqar','Main Street','Royal Electronics',12,'White Queen  ',3,'Screwdriver','23.10'),('Nasdaqar','Main Street','ScrewDrivers NSQ',8,'martinko ',41,'Screwdriver','13.65'),('Nasdaqar','Main Street','Saws NSQ',6,'martinko ',27,'Screwdriver','13.65'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',185,'Saw','27.30'),('Nasdaqar','Main Street','Saws NSQ',6,'martinko ',39,'Saw','9.45'),('Nasdaqar','Main Street','Bricks Nasdaqar',4,'the hawk  ',10,'Brick','5.25'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',2469,'Brick','9.45'),('Nasdaqar','Main Street','Headquarters NSQ',13,'martinko ',1,'Camera','278.25'),('Nasdaqar','Main Street','Chippies Nsq',2,'viraxje  ',2,'Chip','32.55'),('Nasdaqar','Main Street','Glass nsq',10,'alecto  ',22,'Clay','2.00'),('Nasdaqar','Main Street','Great Oils NSQ',3,'Manuel The Great  ',160,'Gas','1.89'),('Nasdaqar','Main Street','Royal Electronics',12,'White Queen  ',52,'Gas','2.68'),('Nasdaqar','Golden Road','And the last',1,'viraxje  ',1,'Gas','8.40'),('Nasdaqar','Golden Road','Haay!',2,'viraxje  ',1,'Gas','8.40'),('Nasdaqar','Golden Road','Virbird',3,'viraxje  ',1,'Gas','8.40'),('Nasdaqar','Golden Road','Virry',4,'viraxje  ',1,'Gas','8.40'),('Nasdaqar','Golden Road','Yoehoeee',5,'viraxje  ',1,'Gas','8.40'),('Nasdaqar','Main Street','Royal Electronics',12,'White Queen  ',1,'Glass','36.75'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',476,'Glass','63.00'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',250,'Iron','15.75'),('Nasdaqar','Main Street','cherS shop',18,'cher ',101,'Iron','18.90'),('Nasdaqar','Main Street','Emty my Warehouse',14,'LMI Taxi MV ',3,'Iron','21.00'),('Nasdaqar','Main Street','Saws NSQ',6,'martinko ',1,'Machine','441.00'),('Nasdaqar','Clubs and Houses','Miscellaneous NSQ',1,'martinko ',3,'Machine','441.00'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',8,'Machine','577.50'),('Nasdaqar','Main Street','oven shovel',5,'Likemyitem ',2,'Oven','220.50'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',10,'Oven','525.00'),('Nasdaqar','Main Street','Royal Electronics',12,'White Queen  ',20,'Plastic','6.30'),('Nasdaqar','Main Street','Plastic - Oil NSQ',19,'(Brendan)  ',85,'Plastic','6.30'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',225,'Plastic','10.50'),('Nasdaqar','Main Street','FES Nasdaqar',1,'Federal Government  ',6,'Pump','210.00'),('Kronenburg','Hoofdstraat','Pompen of Verzuipen',2,'Car-Dealertje  ',50,'Engine','68.25'),('Cashington','1Tuned Topmost Trail','Shop for sale II',8,'Crusader1109 ',1,'Wood','2.10'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',9708,'Wood','1.31'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',249,'Shovel','27.30'),('Cashington','2 Viraxje Vertical','Viraxje Ore',5,'Viraxje MV  ',8,'Shovel','10.50'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',100,'Screwdriver','42.00'),('Cashington','1Tuned Topmost Trail','Easy-Note 2',7,'Duups  ',18,'Screwdriver','22.58'),('Cashington','1Tuned Topmost Trail','ScrewDrivers CASH',3,'martinko ',5,'Screwdriver','13.65'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',222,'Saw','27.30'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',10,'Pump','210.00'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',250,'Plastic','10.50'),('Cashington','1Tuned Topmost Trail','LMI Plastic',10,'LMI Plastic MV ',108,'Plastic','6.30'),('Cashington','2 Viraxje Vertical','Machines Plastic Oil',2,'gelaarsdekat  ',78,'Plastic','5.57'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',10,'Oven','525.00'),('Cashington','1Tuned Topmost Trail','Schneider Cash',12,'iHockey Schneider  ',2,'Oven','262.50'),('Cashington','1Tuned Topmost Trail','Oven - Shovel - Cash',2,'Likemyitem ',1,'Oven','231.00'),('Cashington','2 Viraxje Vertical','Machines Plastic Oil',2,'gelaarsdekat  ',65,'Oil','1.20'),('Cashington','1Tuned Topmost Trail','Shovels Ovens',5,'billdazerr ',12,'Oven','220.50'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',10,'Machine','577.50'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',499,'Glass','63.00'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',519,'Iron','15.75'),('Cashington','2 Viraxje Vertical','Dikken L Zouk',3,'rayan akiki ',3,'Glass','42.00'),('Cashington','2 Viraxje Vertical','Best Glass Shop',4,'MCTrader ',3,'Glass','37.28'),('Cashington','1Tuned Topmost Trail','Cheapest Glass',11,'agfortne ',1,'Glass','36.23'),('Cashington','1Tuned Topmost Trail','CASHington Glass',6,'Refund ',12,'Glass','29.40'),('Cashington','2 Viraxje Vertical','MultiShop',1,'Vandroy ',7,'Glass','28.25'),('Cashington','1Tuned Topmost Trail','Cheapest Glass',11,'agfortne ',1,'Gas','6.30'),('Cashington','1Tuned Topmost Trail','1984',9,'dirkloots ',4,'Gas','4.20'),('Cashington','1Tuned Topmost Trail','Great Oils Cash',4,'Manuel The Great  ',152,'Gas','1.89'),('Cashington','2 Viraxje Vertical','Viraxje Ore',5,'Viraxje MV  ',34,'Gas','2.10'),('Cashington','1Tuned Topmost Trail','FES Cashington',1,'Federal Government  ',2418,'Brick','9.45'),('Cashington','2 Viraxje Vertical','Dikken L Zouk',3,'rayan akiki ',33,'Clay','2.00'),('Kronenburg','Hoofdstraat','The Eye KB',3,'The Eye  ',56,'Shovel','11.99'),('Kronenburg','Hoofdstraat','Schep en Oven KB',12,'Gustav Andersson ',28,'Shovel','17.22'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',206,'Shovel','27.30'),('Kronenburg','Hoofdstraat','bastie__b verkoop',7,'Gekke Boom MV  ',1,'Tree','13.00'),('Kronenburg','Hoofdstraat','Podje KB',8,'Podje  ',3,'Wood','1.05'),('Kronenburg','Hoofdstraat','FES Kronenburg',1,'Federal Government  ',6717,'Wood','1.31'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',5742,'Wood','1.50'),('Roebelarendsveen','Hoofdstraat','Hout RV',10,'cami  ',2,'Wood','0.65'),('Roebelarendsveen','Hoofdstraat','olie en meer',2,'Caren Avenue  ',3,'Telephone','324.00'),('Roebelarendsveen','Hoofdstraat','Boompjes',11,'To The Rescue MV ',2,'Tree','12.50'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',211,'Shovel','31.20'),('Roebelarendsveen','Hoofdstraat','zagen en scheppen RV',14,'IkbenBen19 ',71,'Shovel','17.40'),('Roebelarendsveen','Hoofdstraat','Schoppe!xD',8,'Schoppen MV ',3,'Shovel','13.21'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',227,'Saw','31.20'),('Roebelarendsveen','Hoofdstraat','Chips Ave',16,'Ammonia Avenue ',3,'Screwdriver','20.40'),('Roebelarendsveen','Hoofdstraat','Draaiers!',12,'Caren MV ',5,'Screwdriver','22.80'),('Roebelarendsveen','Hoofdstraat','Plastic Ave',15,'Ammonia Avenue ',22,'Plastic','8.40'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',9,'Pump','240.00'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',233,'Plastic','12.00'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',9,'Oven','600.00'),('Roebelarendsveen','Hoofdstraat','Ovens RV',13,'Pedro is terug MV ',1,'Oven','168.00'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',8,'Machine','660.00'),('Roebelarendsveen','Hoofdstraat','olie en meer',2,'Caren Avenue  ',960,'Oil','1.20'),('Roebelarendsveen','Hoofdstraat','olie en meer',2,'Caren Avenue  ',27,'Machine','510.00'),('Roebelarendsveen','Hoofdstraat','Golres Erts',9,'Golres ',139,'Iron Ore','3.99'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',537,'Iron','18.00'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',2382,'Brick','9.45'),('Zwollar','ZwollarseStraatWeg','Glas Zw',3,'axedry  ',1,'Glass','36.75'),('Zwollar','ZwollarseStraatWeg','machines007',4,'stuart007 ',1,'Glass','52.50'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',500,'Glass','63.00'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',430,'Iron','15.75'),('Zwollar','ZwollarseStraatWeg','Te koop 3',2,'Chiara Alvarez  ',48,'Iron Ore','4.00'),('Zwollar','ZwollarseStraatWeg','Frietkot Plastic',6,'Plastic dame  ',1,'Machine','288.75'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',10,'Machine','577.50'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',10,'Oven','525.00'),('Zwollar','ZwollarseStraatWeg','Frietkot Plastic',6,'Plastic dame  ',590,'Plastic','5.25'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',250,'Plastic','10.50'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',9,'Pump','210.00'),('Zwollar','ZwollarseStraatWeg','Zwollar Zagen',5,'Dada Life MV ',18,'Saw','13.65'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',192,'Saw','27.30'),('Zwollar','ZwollarseStraatWeg','Draain',9,'Draaiers MV ',27,'Screwdriver','18.69'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',88,'Screwdriver','42.00'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',250,'Shovel','27.30'),('Zwollar','ZwollarseStraatWeg','BOOM',8,'Gekke Boom MV  ',20,'Tree','10.50'),('Zwollar','ZwollarseStraatWeg','Hou',7,'Podje Hout MV ',402,'Wood','0.64'),('Zwollar','ZwollarseStraatWeg','FES Zwollar',1,'Federal Government  ',9105,'Wood','1.31'),('Roebelarendsveen','Hoofdstraat','weet ijzer-r',3,'R3knowAL  ',4,'Iron','11.70'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',496,'Glass','72.00'),('Roebelarendsveen','Hoofdstraat','Glas Rv',4,'axedry  ',13,'Glass','40.80'),('Roebelarendsveen','Hoofdstraat','Martijn5 RV',7,'martijn5  ',1,'Gas','3.00'),('Roebelarendsveen','Hoofdstraat','olie en meer',2,'Caren Avenue  ',4,'Camera','360.00'),('Roebelarendsveen','Hoofdstraat','Thomas SHOP II',6,'Car-Dealertje  ',2,'Engine','66.00'),('Roebelarendsveen','Hoofdstraat','FES Roebelarendsveen',1,'Federal Government  ',2334,'Brick','10.80'),('Roebelarendsveen','Hoofdstraat','Kat Steen RV',5,'gelaarsdekat1  ',5,'Brick','5.99');
/*!40000 ALTER TABLE `ShopsData` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShopsGeneral`
--

DROP TABLE IF EXISTS `ShopsGeneral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShopsGeneral` (
  `idshop` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `idcity` tinyint(3) unsigned DEFAULT NULL,
  `url` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`idshop`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShopsGeneral`
--

LOCK TABLES `ShopsGeneral` WRITE;
/*!40000 ALTER TABLE `ShopsGeneral` DISABLE KEYS */;
/*!40000 ALTER TABLE `ShopsGeneral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShopsProducts`
--

DROP TABLE IF EXISTS `ShopsProducts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ShopsProducts` (
  `idshop` tinyint(4) NOT NULL,
  `idprod` tinyint(3) unsigned DEFAULT NULL,
  `price` decimal(10,0) DEFAULT NULL,
  `qty` smallint(5) unsigned DEFAULT NULL,
  `freespace` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`idshop`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShopsProducts`
--

LOCK TABLES `ShopsProducts` WRITE;
/*!40000 ALTER TABLE `ShopsProducts` DISABLE KEYS */;
/*!40000 ALTER TABLE `ShopsProducts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-05-29 22:24:00
