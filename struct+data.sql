-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: daw
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias_productos`
--

DROP TABLE IF EXISTS `categorias_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias_productos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias_productos`
--

/*!40000 ALTER TABLE `categorias_productos` DISABLE KEYS */;
INSERT INTO `categorias_productos` VALUES
(1,'Sin categoría'),
(2,'Marroquí'),
(3,'Exteriores'),
(4,'Animales');
/*!40000 ALTER TABLE `categorias_productos` ENABLE KEYS */;

--
-- Table structure for table `com_contacto`
--

DROP TABLE IF EXISTS `com_contacto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `com_contacto` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `nombre` varchar(255) NOT NULL,
  `apellido` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `comentario` varchar(1000) NOT NULL,
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `com_contacto`
--

/*!40000 ALTER TABLE `com_contacto` DISABLE KEYS */;
INSERT INTO `com_contacto` VALUES
(2,'Pierre','Dupond','my@digit.es','La tienda es genial !!!!!','2024-04-27 20:32:48');
/*!40000 ALTER TABLE `com_contacto` ENABLE KEYS */;

--
-- Table structure for table `detalle`
--

DROP TABLE IF EXISTS `detalle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalle` (
  `codigo_pedido` int(11) NOT NULL,
  `codigo_producto` int(11) NOT NULL,
  `unidades` int(11) DEFAULT NULL,
  `precio_unitario` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`codigo_pedido`,`codigo_producto`),
  KEY `contiene` (`codigo_producto`),
  CONSTRAINT `contiene` FOREIGN KEY (`codigo_producto`) REFERENCES `productos` (`codigo`),
  CONSTRAINT `referentea` FOREIGN KEY (`codigo_pedido`) REFERENCES `pedidos` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle`
--

/*!40000 ALTER TABLE `detalle` DISABLE KEYS */;
INSERT INTO `detalle` VALUES
(1,1,2,10.00),
(1,2,12,20.00),
(1,3,9,30.00),
(1,8,2,80.00),
(1,14,2,140.00),
(2,8,1,80.00),
(2,10,1,100.00),
(2,11,1,110.00),
(3,6,1,60.00),
(3,7,2,70.00),
(3,9,1,90.00),
(3,14,1,140.00),
(3,15,1,150.00),
(4,1,1,10.00),
(5,5,1,50.00),
(5,6,1,60.00),
(5,7,1,70.00),
(5,8,1,80.00);
/*!40000 ALTER TABLE `detalle` ENABLE KEYS */;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estados` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES
(1,'Pendiente'),
(2,'Enviado'),
(3,'Entregado'),
(4,'Cancelado');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedidos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `importe` decimal(8,2) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `pedidopor` (`persona`),
  KEY `enestado` (`estado`),
  CONSTRAINT `enestado` FOREIGN KEY (`estado`) REFERENCES `estados` (`codigo`),
  CONSTRAINT `pedidopor` FOREIGN KEY (`persona`) REFERENCES `usuarios` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES
(1,1,'2024-04-27 17:59:50',970.00,2),
(2,1,'2024-04-27 18:00:33',290.00,1),
(3,2,'2024-04-27 18:03:13',580.00,3),
(4,2,'2024-04-27 18:03:43',10.00,4),
(5,2,'2024-04-27 18:03:55',260.00,1);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  `precio` decimal(8,2) DEFAULT NULL,
  `existencias` int(11) DEFAULT NULL,
  `imagen1` varchar(255) DEFAULT NULL,
  `imagen2` varchar(255) DEFAULT NULL,
  `imagen3` varchar(255) DEFAULT NULL,
  `categoria` int(11) unsigned DEFAULT 4,
  PRIMARY KEY (`codigo`),
  KEY `categoria` (`categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES
(1,'Dinosaurio',10.00,7,'1/1.jpg','1/2.jpg','1/3.jpg',4),
(2,'Oso',20.00,11,'2/1.jpg','2/2.jpg','2/3.jpg',4),
(3,'Pollito',30.00,2,'3/1.jpg','3/2.jpg','3/3.jpg',4),
(4,'La boca',40.00,0,'4/1.jpg','4/2.jpg','4/3.jpg',1),
(5,'Jean-Mi',50.00,11,'5/1.jpg','5/2.jpg','5/3.jpg',1),
(6,'Vidrio',60.00,98,'6/1.jpg','6/2.jpg','6/3.jpg',1),
(7,'Billar',70.00,42,'7/1.jpg','7/2.jpg','7/3.jpg',1),
(8,'Maya',80.00,30,'8/1.jpg','8/2.jpg','8/3.jpg',1),
(9,'Lucas',90.00,97,'9/1.jpg','9/2.jpg','9/3.jpg',3),
(10,'Rachid',100.00,18,'10/1.jpg','10/2.jpg','10/3.jpg',2),
(11,'Gertrude',110.00,33,'11/1.jpg','11/2.jpg','11/3.jpg',2),
(12,'Casino',120.00,23,'12/1.jpg','12/2.jpg','12/3.jpg',3),
(13,'Thé',130.00,16,'13/1.jpg','13/2.jpg','13/3.jpg',2),
(14,'Basurita',140.00,22,'14/1.jpg','14/2.jpg','14/3.jpg',3),
(15,'Buzón',150.00,38,'15/1.jpg','15/2.jpg','15/3.jpg',3);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

--
-- Table structure for table `tarjeta_bancaria`
--

DROP TABLE IF EXISTS `tarjeta_bancaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tarjeta_bancaria` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `persona` int(11) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `exp_date` varchar(5) DEFAULT NULL,
  `cvv` varchar(3) DEFAULT NULL,
  `card_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `pertenece` (`persona`),
  CONSTRAINT `pertenece` FOREIGN KEY (`persona`) REFERENCES `usuarios` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tarjeta_bancaria`
--

/*!40000 ALTER TABLE `tarjeta_bancaria` DISABLE KEYS */;
INSERT INTO `tarjeta_bancaria` VALUES
(1,2,'1234123412341234','12/09','123','Visa Caixa'),
(2,2,'5445766778879009','01/07','999','Caja del mar'),
(3,1,'0990788756654334','05/12','463','Mastercard N26'),
(4,1,'3434565412216528','06/02','196','Visa Revolut');
/*!40000 ALTER TABLE `tarjeta_bancaria` ENABLE KEYS */;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `activo` int(11) DEFAULT 1,
  `admin` int(11) DEFAULT 0,
  `clave` varchar(65) DEFAULT NULL,
  `nombre` varchar(64) DEFAULT NULL,
  `apellidos` varchar(128) DEFAULT NULL,
  `domicilio` varchar(128) DEFAULT NULL,
  `poblacion` varchar(64) DEFAULT NULL,
  `pais` varchar(32) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `telefono` char(9) DEFAULT NULL,
  `fechaNac` date DEFAULT NULL,
  `correo` varchar(255) NOT NULL,
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `correo` (`correo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(1,1,0,'21417d8d58e022f87bd849fe4aefa423125a99f39f21c2646fc31f25a3b019ed','Pierre','Dupond','25 av Champs Élysée','Paris','France','75004','123456789','1994-06-08','pierre.dupond@gmail.com'),
(2,1,0,'6b22e1ecc56d82aab6c1feaa02d0dd169c1e4689e9a2cf9a9af60db4ca46d32d','Juan','García','21 calle Maria','Madrid','España','28001','999999999','2001-02-14','juan.garcia@digi.es');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

--
-- Dumping routines for database 'daw'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-27 22:33:04
