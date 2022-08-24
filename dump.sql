-- Adminer 4.8.1 MySQL 8.0.29 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

CREATE DATABASE `BarBaridadeApp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `BarBaridadeApp`;

DROP TABLE IF EXISTS `Characteristics`;
CREATE TABLE `Characteristics` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `CharacteristicsProducts`;
CREATE TABLE `CharacteristicsProducts` (
  `characteristicsId` bigint NOT NULL,
  `productsId` bigint NOT NULL,
  KEY `CharacteristicsProducts_FK` (`productsId`),
  KEY `CharacteristicsProducts_FK_1` (`characteristicsId`),
  CONSTRAINT `CharacteristicsProducts_FK` FOREIGN KEY (`productsId`) REFERENCES `Products` (`id`),
  CONSTRAINT `CharacteristicsProducts_FK_1` FOREIGN KEY (`characteristicsId`) REFERENCES `Characteristics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Customers`;
CREATE TABLE `Customers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) NOT NULL,
  `phoneNumber` varchar(100) NOT NULL,
  `tenantId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Customers_FK` (`tenantId`),
  CONSTRAINT `Customers_FK` FOREIGN KEY (`tenantId`) REFERENCES `Tenants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) NOT NULL,
  `customerId` bigint DEFAULT NULL,
  `closedAt` datetime DEFAULT NULL,
  `pricePaid` float DEFAULT NULL,
  `howManyPeople` int NOT NULL,
  `tableId` bigint DEFAULT NULL,
  `waiterId` bigint DEFAULT NULL,
  `tip` float DEFAULT NULL,
  `tenantId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Orders_FK` (`customerId`),
  KEY `Orders_FK_1` (`tableId`),
  KEY `Orders_FK_2` (`waiterId`),
  KEY `Orders_FK_3` (`tenantId`),
  CONSTRAINT `Orders_FK` FOREIGN KEY (`customerId`) REFERENCES `Customers` (`id`),
  CONSTRAINT `Orders_FK_1` FOREIGN KEY (`tableId`) REFERENCES `Tables` (`id`),
  CONSTRAINT `Orders_FK_2` FOREIGN KEY (`waiterId`) REFERENCES `Waiters` (`id`),
  CONSTRAINT `Orders_FK_3` FOREIGN KEY (`tenantId`) REFERENCES `Tenants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Orders` (`id`, `createdAt`, `title`, `customerId`, `closedAt`, `pricePaid`, `howManyPeople`, `tableId`, `waiterId`, `tip`, `tenantId`) VALUES
(1,	'2022-08-24 21:37:15',	'Abobrinha',	NULL,	NULL,	NULL,	2,	NULL,	NULL,	NULL,	1);

DROP TABLE IF EXISTS `OrdersProducts`;
CREATE TABLE `OrdersProducts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orderId` bigint NOT NULL,
  `productId` bigint NOT NULL,
  `quantity` int NOT NULL,
  `price` float NOT NULL,
  `observation` varchar(100) DEFAULT NULL,
  `orderProductId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `OrdersProducts_FK` (`orderId`),
  KEY `OrdersProducts_FK_1` (`productId`),
  KEY `OrdersProducts_FK_2` (`orderProductId`),
  CONSTRAINT `OrdersProducts_FK` FOREIGN KEY (`orderId`) REFERENCES `Orders` (`id`),
  CONSTRAINT `OrdersProducts_FK_1` FOREIGN KEY (`productId`) REFERENCES `Products` (`id`),
  CONSTRAINT `OrdersProducts_FK_2` FOREIGN KEY (`orderProductId`) REFERENCES `OrdersProducts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `OrdersProducts` (`id`, `createdAt`, `orderId`, `productId`, `quantity`, `price`, `observation`, `orderProductId`) VALUES
(1,	'2022-08-24 21:39:29',	1,	4,	1,	30,	NULL,	NULL),
(2,	'2022-08-24 21:40:34',	1,	3,	1,	3,	NULL,	1),
(3,	'2022-08-24 21:53:53',	1,	2,	1,	30,	NULL,	NULL),
(4,	'2022-08-24 21:53:53',	1,	3,	1,	3,	NULL,	3),
(5,	'2022-08-24 22:02:47',	1,	5,	1,	3,	NULL,	1);

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price` float NOT NULL,
  `title` varchar(100) NOT NULL,
  `stock` bigint NOT NULL,
  `tenantId` bigint NOT NULL,
  `isPrimary` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `Products_FK` (`tenantId`),
  CONSTRAINT `Products_FK` FOREIGN KEY (`tenantId`) REFERENCES `Tenants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Products` (`id`, `createdAt`, `price`, `title`, `stock`, `tenantId`, `isPrimary`) VALUES
(2,	'2022-08-24 21:25:56',	30,	'Hambúrguer',	50,	1,	1),
(3,	'2022-08-24 21:26:22',	3,	'Bacon',	34,	1,	0),
(4,	'2022-08-24 21:28:09',	30,	'X-Tudo',	50,	1,	1),
(5,	'2022-08-24 21:57:43',	3,	'Queijo',	56,	1,	0);

DROP TABLE IF EXISTS `ProductsProducts`;
CREATE TABLE `ProductsProducts` (
  `primaryProductId` bigint NOT NULL,
  `secondaryProductId` bigint NOT NULL,
  KEY `ProductsProducts_FK` (`primaryProductId`),
  KEY `ProductsProducts_FK_1` (`secondaryProductId`),
  CONSTRAINT `ProductsProducts_FK` FOREIGN KEY (`primaryProductId`) REFERENCES `Products` (`id`),
  CONSTRAINT `ProductsProducts_FK_1` FOREIGN KEY (`secondaryProductId`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `ProductsProducts` (`primaryProductId`, `secondaryProductId`) VALUES
(2,	3),
(4,	3),
(2,	5),
(4,	5);

DROP TABLE IF EXISTS `Tables`;
CREATE TABLE `Tables` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tableNumber` bigint NOT NULL,
  `limitPeople` int NOT NULL,
  `isAvailable` tinyint NOT NULL,
  `tenantId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Tables_FK` (`tenantId`),
  CONSTRAINT `Tables_FK` FOREIGN KEY (`tenantId`) REFERENCES `Tenants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Tenants`;
CREATE TABLE `Tenants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Tenants` (`id`, `createdAt`, `name`, `email`) VALUES
(1,	'2022-08-24 21:25:47',	'Bar do Alemão',	'alemao@lemao.com');

DROP TABLE IF EXISTS `Waiters`;
CREATE TABLE `Waiters` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tenantId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Waiters_FK` (`tenantId`),
  CONSTRAINT `Waiters_FK` FOREIGN KEY (`tenantId`) REFERENCES `Tenants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DATABASE `BoriBiudi` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `BoriBiudi`;

DROP TABLE IF EXISTS `Activities`;
CREATE TABLE `Activities` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `set` varchar(100) NOT NULL,
  `load` bigint NOT NULL,
  `trainingId` bigint NOT NULL,
  `exerciseId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Activities_FK` (`trainingId`),
  KEY `Activities_FK_1` (`exerciseId`),
  CONSTRAINT `Activities_FK` FOREIGN KEY (`trainingId`) REFERENCES `Trainings` (`id`),
  CONSTRAINT `Activities_FK_1` FOREIGN KEY (`exerciseId`) REFERENCES `Exercises` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Exercises`;
CREATE TABLE `Exercises` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `GymPlans`;
CREATE TABLE `GymPlans` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) NOT NULL,
  `price` int NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `InAndOut`;
CREATE TABLE `InAndOut` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `userId` bigint NOT NULL,
  `registerType` enum('in','out') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `InAndOut_FK` (`userId`),
  CONSTRAINT `InAndOut_FK` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Trainings`;
CREATE TABLE `Trainings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `title` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `userId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Trainings_FK` (`userId`),
  CONSTRAINT `Trainings_FK` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `firstName` varchar(100) NOT NULL,
  `surname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `gymPlansId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Users_FK` (`gymPlansId`),
  CONSTRAINT `Users_FK` FOREIGN KEY (`gymPlansId`) REFERENCES `GymPlans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DATABASE `BusaApp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `BusaApp`;

DROP TABLE IF EXISTS `Cities`;
CREATE TABLE `Cities` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `cityName` varchar(100) NOT NULL,
  `stateId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Cities_FK` (`stateId`),
  CONSTRAINT `Cities_FK` FOREIGN KEY (`stateId`) REFERENCES `States` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Colors`;
CREATE TABLE `Colors` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `opacity` varchar(100) DEFAULT NULL,
  `matte` tinyint(1) DEFAULT NULL,
  `colorName` varchar(100) DEFAULT NULL,
  `plated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Countries`;
CREATE TABLE `Countries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `countryName` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Itineraries`;
CREATE TABLE `Itineraries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vehicleId` bigint NOT NULL,
  `departureAt` datetime NOT NULL,
  `arrivalTime` datetime NOT NULL,
  `departureCityId` bigint NOT NULL,
  `arrivalCityId` bigint NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Itineraries_FK` (`vehicleId`),
  KEY `Itineraries_FK_1` (`departureCityId`),
  KEY `Itineraries_FK_2` (`arrivalCityId`),
  CONSTRAINT `Itineraries_FK` FOREIGN KEY (`vehicleId`) REFERENCES `Vehicles` (`id`),
  CONSTRAINT `Itineraries_FK_1` FOREIGN KEY (`departureCityId`) REFERENCES `Cities` (`id`),
  CONSTRAINT `Itineraries_FK_2` FOREIGN KEY (`arrivalCityId`) REFERENCES `Cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Owners`;
CREATE TABLE `Owners` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) DEFAULT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `idNumber` varchar(100) DEFAULT NULL,
  `birthDate` varchar(100) DEFAULT NULL,
  `gender` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `States`;
CREATE TABLE `States` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `stateName` varchar(100) NOT NULL,
  `countryId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `States_FK` (`countryId`),
  CONSTRAINT `States_FK` FOREIGN KEY (`countryId`) REFERENCES `Countries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Tickets`;
CREATE TABLE `Tickets` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` float NOT NULL,
  `discountCategory` enum('student','senior','organ donor') NOT NULL,
  `userId` bigint NOT NULL,
  `itineraryId` bigint NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `Tickets_FK` (`userId`),
  KEY `Tickets_FK_1` (`itineraryId`),
  CONSTRAINT `Tickets_FK` FOREIGN KEY (`userId`) REFERENCES `Users` (`id`),
  CONSTRAINT `Tickets_FK_1` FOREIGN KEY (`itineraryId`) REFERENCES `Itineraries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `name` varchar(100) DEFAULT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `phoneNumber` varchar(100) DEFAULT NULL,
  `emailAddress` varchar(100) DEFAULT NULL,
  `profilePicture` varchar(100) DEFAULT NULL,
  `addressNumber` varchar(100) DEFAULT NULL,
  `addressStreet` varchar(100) DEFAULT NULL,
  `addressDistrict` varchar(100) DEFAULT NULL,
  `addressCity` varchar(100) DEFAULT NULL,
  `addressCountry` varchar(100) DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `VehicleTypes`;
CREATE TABLE `VehicleTypes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `VehicleTypes` (`id`, `title`) VALUES
(1,	'Car'),
(2,	'Bus'),
(3,	'Van'),
(4,	'Tuktuk');

DROP TABLE IF EXISTS `Vehicles`;
CREATE TABLE `Vehicles` (
  `color` varchar(100) DEFAULT NULL,
  `licensePlate` varchar(100) DEFAULT NULL,
  `model` varchar(100) DEFAULT NULL,
  `year` bigint DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `maxPassengers` bigint DEFAULT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `owner` varchar(100) DEFAULT NULL,
  `chassisNumber` varchar(100) DEFAULT NULL,
  `hasAirConditioner` tinyint(1) DEFAULT NULL,
  `hasWifi` tinyint(1) DEFAULT NULL,
  `hasToilet` tinyint(1) DEFAULT NULL,
  `hasRefrigerator` tinyint(1) DEFAULT NULL,
  `vehicleTypeId` bigint DEFAULT NULL,
  `ownerId` bigint DEFAULT NULL,
  `colorId` bigint DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `cityId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Vehicles_FK` (`vehicleTypeId`),
  KEY `Vehicles_FK_1` (`ownerId`),
  KEY `Vehicles_FK_2` (`colorId`),
  KEY `Vehicles_FK_3` (`cityId`),
  CONSTRAINT `Vehicles_FK` FOREIGN KEY (`vehicleTypeId`) REFERENCES `VehicleTypes` (`id`),
  CONSTRAINT `Vehicles_FK_1` FOREIGN KEY (`ownerId`) REFERENCES `Owners` (`id`),
  CONSTRAINT `Vehicles_FK_2` FOREIGN KEY (`colorId`) REFERENCES `Colors` (`id`),
  CONSTRAINT `Vehicles_FK_3` FOREIGN KEY (`cityId`) REFERENCES `Cities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Vehicles` (`color`, `licensePlate`, `model`, `year`, `brand`, `maxPassengers`, `id`, `owner`, `chassisNumber`, `hasAirConditioner`, `hasWifi`, `hasToilet`, `hasRefrigerator`, `vehicleTypeId`, `ownerId`, `colorId`, `city`, `cityId`) VALUES
('Magenta',	'GHI8978',	'XPTO',	2007,	'Mercedes',	40,	1,	'Ozymandias',	'NJNDA72',	1,	1,	1,	1,	2,	NULL,	NULL,	NULL,	NULL);

CREATE DATABASE `ECommerce` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ECommerce`;

DROP TABLE IF EXISTS `Categories`;
CREATE TABLE `Categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `parentCategoryId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Categories_FK` (`parentCategoryId`),
  CONSTRAINT `Categories_FK` FOREIGN KEY (`parentCategoryId`) REFERENCES `Categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Categories` (`id`, `title`, `parentCategoryId`) VALUES
(1,	'Higiene Pessoal',	NULL),
(2,	'Infantil',	NULL),
(3,	'Informática',	NULL),
(4,	'Impressoras',	3),
(5,	'Tinteiros',	4),
(6,	'Tinteiros A Laser',	5),
(7,	'Eletrodomésticos',	NULL),
(8,	'Frigoríficos',	7),
(9,	'Amarelos',	6);

DROP TABLE IF EXISTS `Products`;
CREATE TABLE `Products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Products` (`id`, `title`) VALUES
(1,	'Fralda Pampers');

DROP TABLE IF EXISTS `ProductsCategories`;
CREATE TABLE `ProductsCategories` (
  `productId` bigint NOT NULL,
  `categoryId` bigint NOT NULL,
  KEY `ProductsCategories_FK` (`productId`),
  KEY `ProductsCategories_FK_1` (`categoryId`),
  CONSTRAINT `ProductsCategories_FK` FOREIGN KEY (`productId`) REFERENCES `Products` (`id`),
  CONSTRAINT `ProductsCategories_FK_1` FOREIGN KEY (`categoryId`) REFERENCES `Categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `ProductsCategories` (`productId`, `categoryId`) VALUES
(1,	1),
(1,	2);

CREATE DATABASE `FaceGram` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `FaceGram`;

DROP TABLE IF EXISTS `Companies`;
CREATE TABLE `Companies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Events`;
CREATE TABLE `Events` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Photos`;
CREATE TABLE `Photos` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `postId` bigint NOT NULL,
  `eventId` bigint NOT NULL,
  `companyId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Photos_FK` (`postId`),
  KEY `Photos_FK_1` (`companyId`),
  KEY `Photos_FK_2` (`eventId`),
  CONSTRAINT `Photos_FK` FOREIGN KEY (`postId`) REFERENCES `Posts` (`id`),
  CONSTRAINT `Photos_FK_1` FOREIGN KEY (`companyId`) REFERENCES `Companies` (`id`),
  CONSTRAINT `Photos_FK_2` FOREIGN KEY (`eventId`) REFERENCES `Events` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Posts`;
CREATE TABLE `Posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE DATABASE `FamilyTree` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `FamilyTree`;

DROP TABLE IF EXISTS `People`;
CREATE TABLE `People` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) NOT NULL,
  `momId` bigint DEFAULT NULL,
  `dadId` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Parents_FK_1` (`momId`),
  KEY `Parents_FK_2` (`dadId`),
  CONSTRAINT `Parents_FK_1` FOREIGN KEY (`momId`) REFERENCES `People` (`id`),
  CONSTRAINT `Parents_FK_2` FOREIGN KEY (`dadId`) REFERENCES `People` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `People` (`id`, `createdAt`, `name`, `momId`, `dadId`) VALUES
(1,	'2022-08-06 21:00:46',	'João',	NULL,	NULL),
(2,	'2022-08-06 21:00:46',	'Maria',	NULL,	NULL),
(4,	'2022-08-06 21:17:26',	'Joãozinho',	2,	1),
(5,	'2022-08-06 21:19:54',	'José',	NULL,	NULL),
(6,	'2022-08-06 21:20:28',	'Josézinho',	2,	5);

CREATE DATABASE `MuteFlix` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `MuteFlix`;

DROP TABLE IF EXISTS `Genres`;
CREATE TABLE `Genres` (
  `id` bigint NOT NULL,
  `createdAt` bigint NOT NULL,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Movies`;
CREATE TABLE `Movies` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `year` bigint NOT NULL,
  `director` varchar(100) NOT NULL,
  `cast` varchar(100) NOT NULL,
  `colored` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `trailerURL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `posterURL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `genreId` bigint NOT NULL,
  `synopsis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Movies_FK` (`genreId`),
  CONSTRAINT `Movies_FK` FOREIGN KEY (`genreId`) REFERENCES `Genres` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Ratings`;
CREATE TABLE `Ratings` (
  `id` bigint NOT NULL,
  `createdAt` datetime NOT NULL,
  `rateValue` int DEFAULT NULL,
  `hasRecommended` tinyint(1) DEFAULT NULL,
  `hasWatched` tinyint NOT NULL,
  `movieId` bigint NOT NULL,
  `userId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Rating_FK` (`movieId`),
  KEY `Rating_FK_1` (`userId`),
  CONSTRAINT `Rating_FK` FOREIGN KEY (`movieId`) REFERENCES `Movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Recommendations`;
CREATE TABLE `Recommendations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `userFromId` bigint NOT NULL,
  `userToId` bigint NOT NULL,
  `movieId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Recommendations_FK` (`userFromId`),
  KEY `Recommendations_FK_1` (`userToId`),
  KEY `Recommendations_FK_2` (`movieId`),
  CONSTRAINT `Recommendations_FK_2` FOREIGN KEY (`movieId`) REFERENCES `Movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `firstName` varchar(100) NOT NULL,
  `surName` varchar(100) NOT NULL,
  `birthDate` date NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `profilePictureURL` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Users` (`id`, `createdAt`, `firstName`, `surName`, `birthDate`, `gender`, `email`, `password`, `profilePictureURL`) VALUES
(1,	'2022-07-26 14:14:01',	'Wesley',	'Snipes',	'1987-07-30',	'male',	'lorem@gmail.com',	'lorem',	'lorem.jpg');

CREATE DATABASE `NoisSobrevive` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `NoisSobrevive`;

DROP TABLE IF EXISTS `Bands`;
CREATE TABLE `Bands` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `genre` varchar(100) NOT NULL,
  `historyDescription` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Bands` (`id`, `name`, `genre`, `historyDescription`) VALUES
(1,	'Metallica',	'Rock',	'Lorem Ipsum');

DROP TABLE IF EXISTS `Concerts`;
CREATE TABLE `Concerts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `bandId` bigint NOT NULL,
  `stageId` bigint NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `Concerts_FK` (`stageId`),
  KEY `Concerts_FK_1` (`bandId`),
  CONSTRAINT `Concerts_FK` FOREIGN KEY (`stageId`) REFERENCES `Stages` (`id`),
  CONSTRAINT `Concerts_FK_1` FOREIGN KEY (`bandId`) REFERENCES `Bands` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Concerts` (`id`, `startTime`, `endTime`, `bandId`, `stageId`, `createdAt`) VALUES
(1,	'2022-07-23 19:00:00',	'2022-07-23 21:00:00',	1,	1,	'2022-07-23 18:49:01');

DROP TABLE IF EXISTS `Stages`;
CREATE TABLE `Stages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `lengthInMeters` bigint NOT NULL,
  `heightInMeters` bigint NOT NULL,
  `color` varchar(100) NOT NULL,
  `specialEffects` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Stages` (`id`, `name`, `lengthInMeters`, `heightInMeters`, `color`, `specialEffects`) VALUES
(1,	'Heineken',	100,	5,	'Cyan',	1);

CREATE DATABASE `SchoolProjects` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `SchoolProjects`;

DROP TABLE IF EXISTS `Courses`;
CREATE TABLE `Courses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `coordinatorId` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Courses_FK` (`coordinatorId`),
  CONSTRAINT `Courses_FK` FOREIGN KEY (`coordinatorId`) REFERENCES `Employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Courses` (`id`, `createdAt`, `coordinatorId`, `name`) VALUES
(1,	'2022-08-06 22:12:25',	1,	'Matemática'),
(2,	'2022-08-06 22:12:32',	2,	'Matemática'),
(3,	'2022-08-06 22:19:37',	1,	'Física'),
(4,	'2022-08-06 22:22:13',	3,	'Engenharia Electromecánica');

DROP TABLE IF EXISTS `Disciplines`;
CREATE TABLE `Disciplines` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `courseId` bigint NOT NULL,
  `employeeId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Disciplines_FK` (`courseId`),
  KEY `Disciplines_FK_1` (`employeeId`),
  CONSTRAINT `Disciplines_FK` FOREIGN KEY (`courseId`) REFERENCES `Courses` (`id`),
  CONSTRAINT `Disciplines_FK_1` FOREIGN KEY (`employeeId`) REFERENCES `Employees` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `DisciplinesProjects`;
CREATE TABLE `DisciplinesProjects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `disciplineId` bigint NOT NULL,
  `projectId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `DisciplinesProjects_FK` (`disciplineId`),
  KEY `DisciplinesProjects_FK_1` (`projectId`),
  CONSTRAINT `DisciplinesProjects_FK` FOREIGN KEY (`disciplineId`) REFERENCES `Disciplines` (`id`),
  CONSTRAINT `DisciplinesProjects_FK_1` FOREIGN KEY (`projectId`) REFERENCES `Projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Employees`;
CREATE TABLE `Employees` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isTeacher` tinyint NOT NULL,
  `tenantId` bigint NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Employees_FK` (`tenantId`),
  CONSTRAINT `Employees_FK` FOREIGN KEY (`tenantId`) REFERENCES `Tenants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Employees` (`id`, `createdAt`, `isTeacher`, `tenantId`, `name`) VALUES
(1,	'2022-08-06 22:10:56',	1,	1,	'João'),
(2,	'2022-08-06 22:11:04',	1,	2,	'Maria'),
(3,	'2022-08-06 22:21:27',	1,	1,	'Manuel');

DROP TABLE IF EXISTS `Projects`;
CREATE TABLE `Projects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Students`;
CREATE TABLE `Students` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `courseId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Students_FK` (`courseId`),
  CONSTRAINT `Students_FK` FOREIGN KEY (`courseId`) REFERENCES `Courses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `StudentsProjects`;
CREATE TABLE `StudentsProjects` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `studentId` bigint NOT NULL,
  `ProjectId` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `StudentsProjects_FK` (`studentId`),
  KEY `StudentsProjects_FK_1` (`ProjectId`),
  CONSTRAINT `StudentsProjects_FK` FOREIGN KEY (`studentId`) REFERENCES `Students` (`id`),
  CONSTRAINT `StudentsProjects_FK_1` FOREIGN KEY (`ProjectId`) REFERENCES `Projects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `Tenants`;
CREATE TABLE `Tenants` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Tenants` (`id`, `createdAt`, `name`, `email`) VALUES
(1,	'2022-08-06 22:05:55',	'ISEC',	'isec@gmail.com'),
(2,	'2022-08-06 22:10:08',	'UNICAMP',	'unicamp@gmail.com');

CREATE DATABASE `University` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `University`;

DROP TABLE IF EXISTS `Students`;
CREATE TABLE `Students` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `surname` varchar(100) DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `birthCountry` varchar(100) DEFAULT NULL,
  `isVaccinated` tinyint(1) DEFAULT NULL,
  `vaccinationDate` date DEFAULT NULL,
  `job` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(19) DEFAULT NULL,
  `emailAddress` varchar(100) DEFAULT NULL,
  `allergies` varchar(100) DEFAULT NULL,
  `mothersName` varchar(100) DEFAULT NULL,
  `fathersName` varchar(100) DEFAULT NULL,
  `weightKG` float DEFAULT NULL,
  `heightMeters` float DEFAULT NULL,
  `pictureUrl` varchar(256) DEFAULT NULL,
  `socialDocument` varchar(100) DEFAULT NULL COMMENT 'CPF',
  `passportNumber` varchar(100) DEFAULT NULL,
  `socialSecurityNumber` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Students` (`id`, `firstName`, `birthDate`, `gender`, `surname`, `nationality`, `birthCountry`, `isVaccinated`, `vaccinationDate`, `job`, `phoneNumber`, `emailAddress`, `allergies`, `mothersName`, `fathersName`, `weightKG`, `heightMeters`, `pictureUrl`, `socialDocument`, `passportNumber`, `socialSecurityNumber`) VALUES
(1,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'19992460411',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `Teachers`;
CREATE TABLE `Teachers` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `Teachers` (`id`, `name`, `birthDate`, `gender`) VALUES
(1,	'Jorge',	'1920-02-12',	'male'),
(2,	'Maria',	'1999-09-19',	'female'),
(3,	'Grizelda',	'1980-08-18',	'female'),
(4,	NULL,	NULL,	NULL);

-- 2022-08-24 22:52:36