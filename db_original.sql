-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: bd_ticket
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `id_area` int(11) NOT NULL,
  `nombre_area` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`id_area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES (1,'Soporte Tecnico','Admin','2020-12-01','Admin','2020-12-01'),(2,'Soporte Usuario','Admin','2020-12-01','Admin','2020-12-01'),(3,'Soporte Red','Admin','2020-12-01','Admin','2020-12-01'),(4,'Cliente','Admin','2020-12-01','Admin','2020-12-01');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_empresas`
--

DROP TABLE IF EXISTS `cliente_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente_empresas` (
  `id_empresa` int(11) NOT NULL,
  `nombre_empresa` varchar(100) DEFAULT NULL,
  `id_rubro` int(11) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`id_empresa`),
  KEY `id_rubro` (`id_rubro`),
  CONSTRAINT `cliente_empresas_ibfk_1` FOREIGN KEY (`id_rubro`) REFERENCES `rubro_empresas` (`id_rubro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_empresas`
--

LOCK TABLES `cliente_empresas` WRITE;
/*!40000 ALTER TABLE `cliente_empresas` DISABLE KEYS */;
INSERT INTO `cliente_empresas` VALUES (1,'OP',1,'Admin','2020-12-01','Admin','2020-12-01'),(2,'Hermes',1,'Admin','2020-12-01','Admin','2020-12-01'),(3,'Mibanco',2,'Admin','2020-12-01','Admin','2020-12-01'),(4,'Movistar',3,'Admin','2020-12-01','Admin','2020-12-01'),(5,'Rimac',4,'Admin','2020-12-01','Admin','2020-12-01');
/*!40000 ALTER TABLE `cliente_empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comentarios`
--

DROP TABLE IF EXISTS `comentarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL AUTO_INCREMENT,
  `comentario` varchar(30) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_ticket` int(11) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `estado` varchar(150) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_comentario`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_ticket` (`id_ticket`),
  CONSTRAINT `comentarios_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `comentarios_ibfk_2` FOREIGN KEY (`id_ticket`) REFERENCES `tickets` (`id_ticket`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,'El problema se esta atendiendo',1,1,'2020-01-01',NULL,NULL),(2,'El problema sera escalado a ot',1,1,'2020-01-01',NULL,NULL),(3,'El problema solucionado',1,1,'2020-01-01',NULL,NULL),(5,'xxxxxxx',1,1,'2020-12-03','prueba',NULL),(6,'Comentario.',6,1,'2020-12-03','1',NULL),(7,'Comentario.',6,1,'2020-12-03','1',NULL),(8,'Comentario.',6,1,'2020-12-03','1',NULL),(9,'Comentario.',6,1,'2020-12-03','1',NULL),(10,'Comentario.',6,1,'2020-12-03','1',NULL),(11,'Comentario.',6,1,'2020-12-03','4',NULL),(12,'asdas',6,1,'2020-12-03','5',NULL),(13,'Comentario.asad',6,1,'2020-12-03','3',NULL),(14,'Comentario.',6,1,'2020-12-03',NULL,5),(15,'probando',6,1,'2020-12-03',NULL,6),(16,'Comentario.asss',6,1,'2020-12-03',NULL,2),(17,'jhk,jhkj,',6,1,'2020-12-03',NULL,7),(18,'ppppppppp',7,25,'2020-12-03',NULL,3),(19,'123454',7,26,'2020-12-03',NULL,3),(20,'ok cerrando',7,26,'2020-12-03',NULL,4),(21,'pruebas',1,27,'2020-12-03',NULL,2),(22,'prueba 2',1,27,'2020-12-03',NULL,3),(23,'Comentario.qweqwe',7,28,'2020-12-03',NULL,2),(24,'Comentario.eee',1,28,'2020-12-03',NULL,2);
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_ticket`
--

DROP TABLE IF EXISTS `estado_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_ticket` (
  `id_estado` int(11) NOT NULL,
  `nombre_estado` varchar(30) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`id_estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_ticket`
--

LOCK TABLES `estado_ticket` WRITE;
/*!40000 ALTER TABLE `estado_ticket` DISABLE KEYS */;
INSERT INTO `estado_ticket` VALUES (1,'Generado','Admin','2020-12-01','Admin','2020-12-01'),(2,'Pendiente','Admin','2020-12-01','Admin','2020-12-01'),(3,'En Proceso','Admin','2020-12-01','Admin','2020-12-01'),(4,'Cerrado','Admin','2020-12-01','Admin','2020-12-01'),(5,'Coordinado','Admin','2020-12-01','Admin','2020-12-01'),(6,'Investigando','Admin','2020-12-01','Admin','2020-12-01'),(7,'Escalado','Admin','2020-12-01','Admin','2020-12-01');
/*!40000 ALTER TABLE `estado_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prioridad_ticket`
--

DROP TABLE IF EXISTS `prioridad_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prioridad_ticket` (
  `id_prioridad` int(11) NOT NULL,
  `nombre_prioridad` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_prioridad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prioridad_ticket`
--

LOCK TABLES `prioridad_ticket` WRITE;
/*!40000 ALTER TABLE `prioridad_ticket` DISABLE KEYS */;
INSERT INTO `prioridad_ticket` VALUES (1,'Baja'),(2,'Media'),(3,'Alta');
/*!40000 ALTER TABLE `prioridad_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Administrador','Admin','2020-12-01','Admin','2020-12-01'),(2,'Supervisor','Admin','2020-12-01','Admin','2020-12-01'),(3,'Soporte TI','Admin','2020-12-01','Admin','2020-12-01'),(4,'Cliente','Admin','2020-12-01','Admin','2020-12-01');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rubro_empresas`
--

DROP TABLE IF EXISTS `rubro_empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rubro_empresas` (
  `id_rubro` int(11) NOT NULL,
  `nombre_rubro` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  PRIMARY KEY (`id_rubro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rubro_empresas`
--

LOCK TABLES `rubro_empresas` WRITE;
/*!40000 ALTER TABLE `rubro_empresas` DISABLE KEYS */;
INSERT INTO `rubro_empresas` VALUES (1,'OP','Admin','2020-12-01','Admin','2020-12-01'),(2,'Seguridad','Admin','2020-12-01','Admin','2020-12-01'),(3,'Financiera','Admin','2020-12-01','Admin','2020-12-01'),(4,'Telefonia','Admin','2020-12-01','Admin','2020-12-01'),(5,'Seguros','Admin','2020-12-01','Admin','2020-12-01');
/*!40000 ALTER TABLE `rubro_empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `id_tipo` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_prioridad` int(11) DEFAULT NULL,
  `id_Soporte_ti` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_cierre` date DEFAULT NULL,
  PRIMARY KEY (`id_ticket`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_Soporte_ti` (`id_Soporte_ti`),
  KEY `id_empresa` (`id_empresa`),
  KEY `id_area` (`id_area`),
  KEY `id_prioridad` (`id_prioridad`),
  KEY `id_tipo` (`id_tipo`),
  KEY `id_estado` (`id_estado`),
  CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `tickets_ibfk_2` FOREIGN KEY (`id_Soporte_ti`) REFERENCES `usuarios` (`id_usuario`),
  CONSTRAINT `tickets_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `cliente_empresas` (`id_empresa`),
  CONSTRAINT `tickets_ibfk_4` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`),
  CONSTRAINT `tickets_ibfk_5` FOREIGN KEY (`id_prioridad`) REFERENCES `prioridad_ticket` (`id_prioridad`),
  CONSTRAINT `tickets_ibfk_6` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_ticket` (`id_tipo`),
  CONSTRAINT `tickets_ibfk_7` FOREIGN KEY (`id_estado`) REFERENCES `estado_ticket` (`id_estado`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,'caida de sistema','se presenta problemas en la conectividad',1,1,1,7,1,2,1,'2020-12-01','2020-12-01','2020-12-01'),(2,'xx','as',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(3,'xx','as',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(4,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,'2020-12-01','2020-12-01','2020-12-01'),(5,'asdasd','Describe el ticket.',1,1,1,1,1,1,NULL,'2020-12-01','2020-12-01','2020-12-01'),(6,'asdasd','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(7,'asd','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(8,'as','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(9,'as','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(10,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,1,'2020-12-01','2020-12-01','2020-12-01'),(11,'sad','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(12,'s','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(13,'as','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(14,'asdas','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(15,'12314','1231234',1,3,2,1,2,1,1,'2020-12-01','2020-12-01','2020-12-01'),(16,'pruebaaa','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(17,'registrandooo','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(18,'12312312312312312312312','Describe el ticket.',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(19,'fewrwerw','Describe el ticket.rwerwer',1,1,1,1,1,1,1,'2020-12-01','2020-12-01','2020-12-01'),(20,'asd','Describe el ticket.',1,1,1,1,1,NULL,1,'2020-12-02','2020-12-02','2020-12-02'),(21,'asas','Describe el ticket.',1,1,1,1,1,NULL,1,'2020-12-02','2020-12-02','2020-12-02'),(22,'2323','Describe el ticket.as',1,1,1,1,1,NULL,1,'2020-12-02','2020-12-02','2020-12-02'),(23,'test','Describe el ticket.asd',7,1,1,1,1,4,1,'2020-12-03','2020-12-03','2020-12-03'),(24,'qdqeqwrq','Describe el ticket.',NULL,NULL,1,1,1,NULL,1,'2020-12-03','2020-12-03','2020-12-03'),(25,'asa','Describe el ticket.a',7,1,1,3,1,NULL,1,'2020-12-03','2020-12-03','2020-12-03'),(26,'prueba','asas',7,1,1,4,1,3,1,'2020-12-03','2020-12-03','2020-12-03'),(27,'prueba x','Describe el ticket.',7,3,1,3,1,4,2,'2020-12-03','2020-12-03','2020-12-03'),(28,'qweqwe','Describe el ticket.qweqwe',7,1,1,2,1,3,2,'2020-12-03','2020-12-03','2020-12-03');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_ticket`
--

DROP TABLE IF EXISTS `tipo_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_ticket` (
  `id_tipo` int(11) NOT NULL,
  `nombre_tipo` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id_tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_ticket`
--

LOCK TABLES `tipo_ticket` WRITE;
/*!40000 ALTER TABLE `tipo_ticket` DISABLE KEYS */;
INSERT INTO `tipo_ticket` VALUES (1,'Incidente'),(2,'Requerimiento');
/*!40000 ALTER TABLE `tipo_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `tipo_usuario` varchar(100) DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL,
  `id_area` int(11) DEFAULT NULL,
  `id_empresa` int(11) DEFAULT NULL,
  `estado_contrato` varchar(100) DEFAULT NULL,
  `registrado_por` varchar(100) DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `actualizado_por` varchar(100) DEFAULT NULL,
  `fecha_actualizacion` date DEFAULT NULL,
  `fecha_ultimo_acceso` date DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  KEY `id_rol` (`id_rol`),
  KEY `id_area` (`id_area`),
  KEY `id_empresa` (`id_empresa`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id_area`),
  CONSTRAINT `usuarios_ibfk_3` FOREIGN KEY (`id_empresa`) REFERENCES `cliente_empresas` (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'sanchez@gmail.com','123456','Salvador','Sanchez','Cliente',1,1,1,'Activo','Admin','2020-12-01','Admin','2020-12-01','2020-12-01'),(2,'1@gmail.com','$2y$10$AkAeua05LrfDBo/ItedQvO0WwvKwxKvIWkjyylPM//7w4Hcc/J79e','123','123123','Cliente',3,4,1,'Activado','sanchez@gmail.com','2020-12-02','sanchez@gmail.com','2020-12-02','2020-12-02'),(3,'2@gmail.com','$2y$10$DoZJ.cGP0Wj0R7tp54ZWFud2mAOhWGOeKHxI48EXPH0NWPPgZ/7NC','Juan flores','123123','Cliente',3,4,1,'Activado','sanchez@gmail.com','2020-12-02','sanchez@gmail.com','2020-12-02','2020-12-02'),(4,'3@gmail.com','$2y$10$OseN9wOA55.1QHeKcZPlVuxQUxfs3X2qWEqHdKR/78uN.sygcA0Yi','Renato Campos','as','Cliente',3,4,1,'Activado','sanchez@gmail.com','2020-12-02','sanchez@gmail.com','2020-12-02','2020-12-02'),(5,'01@gmail.com','$2y$10$PyyOAS8dr4Px26J8VySaJOcCbvqqCI58DJMXZIOPEO9uPa66RaX3q','Usuario x','01','Cliente',1,2,1,'Activado','01@gmail.com','2020-12-03','01@gmail.com','2020-12-03','2020-12-03'),(6,'123@gmail.com','$2y$10$nhV8717l6qfhcqLCKmYchevNaLp0A1K/V57FAeNtdg8Q8WhQ/rRVW','usuario x','pruebas','Cliente',2,4,1,'Activado','123@gmail.com','2020-12-03','123@gmail.com','2020-12-03','2020-12-03'),(7,'111@gmail.com','$2y$10$lDGdqWXrnFtmLlu.AerE8ezfOEL6r2eiP0E272L2DarO1pa7Ax8YS','111','111','Cliente',4,4,1,'Activado','111@gmail.com','2020-12-03','111@gmail.com','2020-12-03','2020-12-03');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-03 12:13:56
