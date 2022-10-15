-- Adminer 4.8.1 MySQL 8.0.31 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP DATABASE IF EXISTS `BarBaridadeApp`;
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

INSERT INTO `Characteristics` (`id`, `createdAt`, `title`, `description`) VALUES
(1,	'2022-10-05 16:14:54',	'Vegano',	'Não possui nenhum derivado de animais'),
(2,	'2022-10-05 16:15:17',	'Sem lactose',	'Nao possui lactose, derivdos, leite, queijo'),
(3,	'2022-10-05 16:16:01',	'Sem ovo',	'Não possui ovo na composição'),
(4,	'2022-10-05 16:16:01',	'Sem açúcar',	'Não possui açũcar, mas pode possuir adoçantes');

DROP TABLE IF EXISTS `CharacteristicsProducts`;
CREATE TABLE `CharacteristicsProducts` (
  `characteristicsId` bigint NOT NULL,
  `productsId` bigint NOT NULL,
  KEY `CharacteristicsProducts_FK` (`productsId`),
  KEY `CharacteristicsProducts_FK_1` (`characteristicsId`),
  CONSTRAINT `CharacteristicsProducts_FK` FOREIGN KEY (`productsId`) REFERENCES `Products` (`id`),
  CONSTRAINT `CharacteristicsProducts_FK_1` FOREIGN KEY (`characteristicsId`) REFERENCES `Characteristics` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `CharacteristicsProducts` (`characteristicsId`, `productsId`) VALUES
(1,	106),
(1,	108),
(2,	110),
(2,	111),
(1,	112),
(3,	117),
(1,	118),
(4,	118),
(1,	119),
(4,	119),
(1,	123),
(3,	130);

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

INSERT INTO `Customers` (`id`, `createdAt`, `name`, `email`, `phoneNumber`, `tenantId`) VALUES
(64,	'2022-09-03 06:52:03',	'Brenden Lee',	'congue.turpis.in@protonmail.com',	'1-817-903-7436',	1),
(65,	'2022-09-03 06:52:03',	'Kane Bowen',	'erat.vivamus.nisi@icloud.couk',	'1-202-595-1858',	1),
(66,	'2022-09-03 06:52:03',	'Nehru Clay',	'purus.sapien@hotmail.couk',	'1-726-129-5628',	1),
(67,	'2022-09-03 06:52:03',	'Tashya Welch',	'vitae@aol.com',	'(383) 802-1857',	1),
(68,	'2022-09-03 06:52:03',	'Iola Frazier',	'molestie.pharetra.nibh@hotmail.net',	'(114) 979-1443',	1);

DROP TABLE IF EXISTS `Orders`;
CREATE TABLE `Orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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

INSERT INTO `Orders` (`id`, `createdAt`, `customerId`, `closedAt`, `pricePaid`, `howManyPeople`, `tableId`, `waiterId`, `tip`, `tenantId`) VALUES
(32,	'2022-09-23 06:05:18',	66,	NULL,	27.61,	1,	5,	14,	3.65,	1),
(33,	'2022-09-23 06:05:18',	66,	NULL,	60.45,	0,	7,	6,	18.7,	1),
(34,	'2022-09-23 06:05:18',	66,	NULL,	75.73,	0,	9,	13,	15.69,	1),
(35,	'2022-09-23 06:05:18',	67,	NULL,	64.75,	1,	8,	19,	9.81,	1),
(36,	'2022-09-23 06:05:18',	65,	NULL,	3.22,	0,	8,	10,	14.59,	1),
(37,	'2022-09-23 06:05:18',	66,	NULL,	10.16,	0,	6,	6,	7.09,	1),
(38,	'2022-09-23 06:05:18',	66,	NULL,	16.71,	0,	5,	9,	12.87,	1),
(39,	'2022-09-23 06:05:18',	65,	NULL,	47.32,	0,	8,	12,	6.23,	1),
(40,	'2022-09-23 06:05:18',	66,	NULL,	38.31,	0,	2,	13,	9.79,	1),
(41,	'2022-09-23 06:05:18',	68,	NULL,	85.41,	0,	7,	2,	15.89,	1),
(42,	'2022-09-25 15:42:31',	64,	NULL,	44.25,	1,	5,	18,	25.56,	1),
(43,	'2022-09-25 15:42:31',	64,	NULL,	66.22,	0,	6,	9,	3.88,	1),
(44,	'2022-09-25 15:42:31',	65,	NULL,	50.1,	1,	7,	18,	20.64,	1),
(45,	'2022-09-25 15:42:31',	66,	NULL,	48.4,	1,	5,	7,	26.45,	1),
(46,	'2022-09-25 15:42:31',	64,	NULL,	4.71,	0,	6,	14,	28.84,	1),
(47,	'2022-09-25 15:42:31',	65,	NULL,	5.38,	1,	6,	6,	6.67,	1),
(48,	'2022-09-25 15:42:31',	67,	NULL,	91,	0,	8,	11,	23.97,	1),
(49,	'2022-09-25 15:42:31',	64,	NULL,	39.33,	1,	3,	12,	4.61,	1),
(50,	'2022-09-25 15:42:31',	66,	NULL,	99.01,	0,	8,	4,	2.13,	1),
(51,	'2022-09-25 15:42:31',	64,	NULL,	54.01,	0,	3,	13,	18.17,	1),
(52,	'2022-10-01 21:10:46',	64,	NULL,	50,	1,	NULL,	13,	20,	1);

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
  KEY `OrdersProducts_FK_2` (`orderProductId`),
  KEY `OrdersProducts_FK_1` (`productId`),
  CONSTRAINT `OrdersProducts_FK` FOREIGN KEY (`orderId`) REFERENCES `Orders` (`id`),
  CONSTRAINT `OrdersProducts_FK_1` FOREIGN KEY (`productId`) REFERENCES `Products` (`id`),
  CONSTRAINT `OrdersProducts_FK_2` FOREIGN KEY (`orderProductId`) REFERENCES `OrdersProducts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `OrdersProducts` (`id`, `createdAt`, `orderId`, `productId`, `quantity`, `price`, `observation`, `orderProductId`) VALUES
(1,	'2022-09-23 17:02:18',	33,	119,	20,	1,	'in magna. Phasellus dolor elit,',	NULL),
(2,	'2022-09-23 17:02:18',	39,	138,	19,	10,	'Aliquam ultrices iaculis odio. Nam',	NULL),
(3,	'2022-09-23 17:02:18',	38,	146,	1,	4,	'id, ante. Nunc mauris sapien,',	NULL),
(4,	'2022-09-23 17:02:18',	40,	110,	12,	6,	'est, mollis non, cursus non,',	NULL),
(5,	'2022-09-23 17:02:18',	35,	116,	8,	8,	'vitae, orci. Phasellus dapibus quam',	NULL),
(6,	'2022-09-23 17:02:18',	41,	127,	4,	7,	'elit. Etiam laoreet, libero et',	NULL),
(7,	'2022-09-23 17:02:18',	39,	128,	7,	9,	'eget nisi dictum augue malesuada',	NULL),
(8,	'2022-09-23 17:02:18',	33,	110,	19,	8,	'et, rutrum non, hendrerit id,',	NULL),
(9,	'2022-09-23 17:02:18',	34,	136,	4,	3,	'Aliquam vulputate ullamcorper magna. Sed',	NULL),
(10,	'2022-09-23 17:02:18',	35,	150,	8,	1,	'Nam ac nulla. In tincidunt',	NULL),
(11,	'2022-09-23 17:03:02',	40,	131,	14,	3,	'lacinia mattis. Integer eu lacus.',	NULL),
(12,	'2022-09-23 17:03:02',	35,	139,	15,	6,	'lectus pede, ultrices a, auctor',	NULL),
(13,	'2022-09-23 17:03:02',	33,	125,	7,	7,	'eu tempor erat neque non',	NULL),
(14,	'2022-09-23 17:03:02',	41,	115,	8,	4,	'natoque penatibus et magnis dis',	NULL),
(15,	'2022-09-23 17:03:02',	36,	125,	19,	2,	'placerat eget, venenatis a, magna.',	NULL),
(16,	'2022-09-23 17:03:02',	36,	111,	15,	9,	'nec, imperdiet nec, leo. Morbi',	NULL),
(17,	'2022-09-23 17:03:02',	41,	143,	7,	5,	'turpis egestas. Aliquam fringilla cursus',	NULL),
(18,	'2022-09-23 17:03:02',	34,	134,	8,	9,	'pretium aliquet, metus urna convallis',	NULL),
(19,	'2022-09-23 17:03:02',	36,	143,	7,	6,	'aliquet libero. Integer in magna.',	NULL),
(20,	'2022-09-23 17:03:02',	38,	129,	9,	6,	'sollicitudin orci sem eget massa.',	NULL),
(21,	'2022-09-23 17:03:17',	33,	122,	14,	7,	'accumsan sed, facilisis vitae, orci.',	NULL),
(22,	'2022-09-23 17:03:17',	32,	123,	1,	5,	'vestibulum lorem, sit amet ultricies',	NULL),
(23,	'2022-09-23 17:03:17',	39,	118,	1,	9,	'malesuada fames ac turpis egestas.',	NULL),
(24,	'2022-09-23 17:03:17',	39,	151,	17,	4,	'ut, pharetra sed, hendrerit a,',	NULL),
(25,	'2022-09-23 17:03:17',	36,	136,	3,	2,	'diam. Sed diam lorem, auctor',	NULL),
(26,	'2022-09-23 17:03:17',	36,	114,	8,	3,	'metus. In lorem. Donec elementum,',	NULL),
(27,	'2022-09-23 17:03:17',	40,	126,	20,	7,	'tortor. Integer aliquam adipiscing lacus.',	NULL),
(28,	'2022-09-23 17:03:17',	34,	112,	18,	8,	'semper auctor. Mauris vel turpis.',	NULL),
(29,	'2022-09-23 17:03:17',	34,	148,	11,	10,	'et, lacinia vitae, sodales at,',	NULL),
(30,	'2022-09-23 17:03:17',	33,	116,	9,	7,	'mollis. Duis sit amet diam',	NULL);

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
(106,	'2022-09-03 16:08:44',	27.92,	'Hopper',	38,	1,	1),
(107,	'2022-09-03 16:08:44',	28.05,	'Pate',	35,	1,	1),
(108,	'2022-09-03 16:08:44',	23.61,	'Parrish',	34,	1,	0),
(109,	'2022-09-03 16:08:44',	22.47,	'Guy',	28,	1,	1),
(110,	'2022-09-03 16:08:44',	33.47,	'Craig',	13,	1,	1),
(111,	'2022-09-03 16:08:44',	29.1,	'Banks',	9,	1,	0),
(112,	'2022-09-03 16:08:44',	26.16,	'Mccoy',	43,	1,	0),
(113,	'2022-09-03 16:08:44',	16.08,	'Wynn',	30,	1,	1),
(114,	'2022-09-03 16:08:44',	15.9,	'Holmes',	26,	1,	0),
(115,	'2022-09-03 16:08:44',	19.36,	'Juarez',	30,	1,	1),
(116,	'2022-09-03 16:08:44',	30.62,	'Bentley',	43,	1,	1),
(117,	'2022-09-03 16:08:44',	27.72,	'Simpson',	11,	1,	1),
(118,	'2022-09-03 16:08:44',	19.21,	'Howell',	49,	1,	0),
(119,	'2022-09-03 16:08:44',	19.46,	'Cummings',	31,	1,	1),
(120,	'2022-09-03 16:08:44',	18.19,	'Mccoy',	30,	1,	1),
(121,	'2022-09-03 16:08:44',	23.69,	'Herrera',	6,	1,	1),
(122,	'2022-09-03 16:08:44',	21.71,	'Willis',	17,	1,	1),
(123,	'2022-09-03 16:08:44',	23.11,	'Wilder',	18,	1,	1),
(124,	'2022-09-03 16:08:44',	25.94,	'Newman',	11,	1,	0),
(125,	'2022-09-03 16:08:44',	19.75,	'Salazar',	13,	1,	1),
(126,	'2022-09-03 16:08:44',	25.37,	'Carey',	50,	1,	1),
(127,	'2022-09-03 16:08:44',	18.11,	'Guthrie',	26,	1,	0),
(128,	'2022-09-03 16:08:44',	19.89,	'Nolan',	20,	1,	0),
(129,	'2022-09-03 16:08:44',	22.9,	'Mercado',	44,	1,	1),
(130,	'2022-09-03 16:08:44',	27.83,	'Tucker',	6,	1,	1),
(131,	'2022-09-03 16:08:44',	26.05,	'Tillman',	14,	1,	0),
(132,	'2022-09-03 16:08:44',	24.55,	'Adkins',	40,	1,	1),
(133,	'2022-09-03 16:08:44',	16.9,	'Beard',	21,	1,	1),
(134,	'2022-09-03 16:08:44',	20.76,	'Kirkland',	29,	1,	1),
(135,	'2022-09-03 16:08:44',	40.57,	'Todd',	31,	1,	0),
(136,	'2022-09-03 16:08:44',	20.96,	'Mcmillan',	13,	1,	1),
(137,	'2022-09-03 16:08:44',	40.57,	'Underwood',	7,	1,	0),
(138,	'2022-09-03 16:08:44',	20.91,	'Tyson',	18,	1,	1),
(139,	'2022-09-03 16:08:44',	17.73,	'Hopkins',	36,	1,	0),
(140,	'2022-09-03 16:08:44',	32.13,	'Williams',	19,	1,	0),
(141,	'2022-09-03 16:08:44',	36.12,	'Hickman',	17,	1,	1),
(142,	'2022-09-03 16:08:44',	24.11,	'Wilkerson',	31,	1,	0),
(143,	'2022-09-03 16:08:44',	31.13,	'Acevedo',	16,	1,	0),
(144,	'2022-09-03 16:08:44',	27.84,	'Miles',	7,	1,	1),
(145,	'2022-09-03 16:08:44',	40.57,	'Silva',	42,	1,	0),
(146,	'2022-09-03 16:08:44',	33.87,	'Diaz',	29,	1,	0),
(147,	'2022-09-03 16:08:44',	30.1,	'Langley',	10,	1,	0),
(148,	'2022-09-03 16:08:44',	17.91,	'Battle',	16,	1,	1),
(149,	'2022-09-03 16:08:44',	14.72,	'Farley',	7,	1,	1),
(150,	'2022-09-03 16:08:44',	25.01,	'Phillips',	24,	1,	0),
(151,	'2022-09-03 16:08:44',	18.97,	'Holt',	17,	1,	1),
(152,	'2022-09-03 16:08:44',	19.28,	'Nieves',	18,	1,	1),
(153,	'2022-09-03 16:08:44',	21.6,	'Walker',	28,	1,	0),
(154,	'2022-09-03 16:08:44',	33.29,	'Head',	34,	1,	0),
(155,	'2022-09-03 16:08:44',	40.57,	'Dennis',	44,	1,	0);

DROP TABLE IF EXISTS `ProductsProducts`;
CREATE TABLE `ProductsProducts` (
  `primaryProductId` bigint NOT NULL,
  `secondaryProductId` bigint NOT NULL,
  KEY `ProductsProducts_FK` (`primaryProductId`),
  KEY `ProductsProducts_FK_1` (`secondaryProductId`),
  CONSTRAINT `ProductsProducts_FK` FOREIGN KEY (`primaryProductId`) REFERENCES `Products` (`id`),
  CONSTRAINT `ProductsProducts_FK_1` FOREIGN KEY (`secondaryProductId`) REFERENCES `Products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


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

INSERT INTO `Tables` (`id`, `createdAt`, `tableNumber`, `limitPeople`, `isAvailable`, `tenantId`) VALUES
(1,	'2022-09-23 05:20:11',	8,	4,	0,	1),
(2,	'2022-09-23 05:20:11',	22,	17,	1,	1),
(3,	'2022-09-23 05:20:11',	1,	7,	1,	1),
(4,	'2022-09-23 05:20:11',	21,	12,	1,	1),
(5,	'2022-09-23 05:20:11',	33,	3,	1,	1),
(6,	'2022-09-23 05:20:11',	17,	9,	1,	1),
(7,	'2022-09-23 05:20:11',	20,	13,	0,	1),
(8,	'2022-09-23 05:20:11',	12,	13,	1,	1),
(9,	'2022-09-23 05:20:11',	10,	3,	0,	1),
(10,	'2022-09-23 05:20:11',	23,	13,	0,	1);

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

INSERT INTO `Waiters` (`id`, `createdAt`, `name`, `age`, `gender`, `email`, `phoneNumber`, `tenantId`) VALUES
(1,	'2022-09-21 20:33:05',	'Germane Figueiredo',	52,	'female',	'erat@outlook.couk',	'(94) 68777-4814',	1),
(2,	'2022-09-21 20:33:05',	'Miranda Candido',	84,	'female',	'molestie.dapibus.ligula@protonmail.ca',	'(34) 65276-5637',	1),
(3,	'2022-09-21 20:33:05',	'Hedley Braga',	64,	'female',	'quis@outlook.edu',	'(17) 35257-9433',	1),
(4,	'2022-09-21 20:33:05',	'Anika Macedo',	48,	'male',	'interdum.ligula@google.net',	'(72) 87789-4683',	1),
(5,	'2022-09-21 20:33:05',	'Dolan de Brito',	57,	'female',	'aliquet.odio@yahoo.ca',	'(12) 68254-6598',	1),
(6,	'2022-09-21 20:33:05',	'Abel Bezerra',	47,	'male',	'placerat@outlook.couk',	'(24) 88559-6468',	1),
(7,	'2022-09-21 20:33:05',	'Ramona Guedes',	22,	'male',	'sed.orci@aol.edu',	'(82) 48779-1235',	1),
(8,	'2022-09-21 20:33:05',	'Tucker Teles',	74,	'female',	'ac@hotmail.ca',	'(45) 83234-3585',	1),
(9,	'2022-09-21 20:33:05',	'Henry de Abreu',	46,	'male',	'enim.nunc@icloud.ca',	'(77) 75383-5885',	1),
(10,	'2022-09-21 20:33:05',	'Kyra Cavalcante',	72,	'female',	'a.sollicitudin@outlook.edu',	'(33) 68247-5937',	1),
(11,	'2022-09-21 20:33:05',	'Germane Figueiredo',	52,	'female',	'erat@outlook.couk',	'(94) 68777-4814',	1),
(12,	'2022-09-21 20:33:05',	'Miranda Candido',	84,	'female',	'molestie.dapibus.ligula@protonmail.ca',	'(34) 65276-5637',	1),
(13,	'2022-09-21 20:33:05',	'Hedley Braga',	64,	'female',	'quis@outlook.edu',	'(17) 35257-9433',	1),
(14,	'2022-09-21 20:33:05',	'Anika Macedo',	48,	'male',	'interdum.ligula@google.net',	'(72) 87789-4683',	1),
(15,	'2022-09-21 20:33:05',	'Dolan de Brito',	57,	'female',	'aliquet.odio@yahoo.ca',	'(12) 68254-6598',	1),
(16,	'2022-09-21 20:33:05',	'Abel Bezerra',	47,	'male',	'placerat@outlook.couk',	'(24) 88559-6468',	1),
(17,	'2022-09-21 20:33:05',	'Ramona Guedes',	22,	'male',	'sed.orci@aol.edu',	'(82) 48779-1235',	1),
(18,	'2022-09-21 20:33:05',	'Tucker Teles',	74,	'female',	'ac@hotmail.ca',	'(45) 83234-3585',	1),
(19,	'2022-09-21 20:33:05',	'Henry de Abreu',	46,	'male',	'enim.nunc@icloud.ca',	'(77) 75383-5885',	1),
(20,	'2022-09-21 20:33:05',	'Kyra Cavalcante',	72,	'female',	'a.sollicitudin@outlook.edu',	'(33) 68247-5937',	1);

DROP DATABASE IF EXISTS `BoriBiudi`;
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


DROP DATABASE IF EXISTS `BusaApp`;
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

DROP DATABASE IF EXISTS `ECommerce`;
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

DROP DATABASE IF EXISTS `FaceGram`;
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


DROP DATABASE IF EXISTS `FamilyTree`;
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

DROP DATABASE IF EXISTS `MuteFlix`;
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

DROP DATABASE IF EXISTS `NoisSobrevive`;
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

DROP DATABASE IF EXISTS `SchoolProjects`;
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

DROP DATABASE IF EXISTS `University`;
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

-- 2022-10-15 13:16:24
