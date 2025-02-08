-- MySQL dump 10.13  Distrib 5.7.24, for osx10.9 (x86_64)
--
-- Host: localhost    Database: vida_segura
-- ------------------------------------------------------
-- Server version	9.0.1

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
-- Current Database: `vida_segura`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `vida_segura` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `vida_segura`;
--
-- Table structure for table `ciudad`
--

DROP TABLE IF EXISTS `ciudad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ciudad` (
  `id_ciudad` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  `poblacion_total` int unsigned NOT NULL DEFAULT '0',
  `poblacion_m` int unsigned NOT NULL DEFAULT '0',
  `poblacion_h` int unsigned NOT NULL DEFAULT '0',
  `poblacion_menor18` int unsigned NOT NULL DEFAULT '0',
  `poblacion_mayor18` int unsigned NOT NULL DEFAULT '0',
  `id_pais` int unsigned NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  KEY `FK_pais_ciudad` (`id_pais`),
  CONSTRAINT `FK_pais_ciudad` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ciudad`
--

LOCK TABLES `ciudad` WRITE;
/*!40000 ALTER TABLE `ciudad` DISABLE KEYS */;
INSERT INTO `ciudad` VALUES (1,'Ciudad de México',9000000,4500000,4500000,2000000,7000000,1),(2,'Los Ángeles',4000000,2000000,2000000,1000000,3000000,2),(3,'Toronto',2800000,1400000,1400000,600000,2200000,3),(4,'Sao Paulo',12000000,6000000,6000000,2500000,9500000,4),(5,'Buenos Aires',3000000,1500000,1500000,700000,2300000,5),(6,'Berlín',3700000,1850000,1850000,500000,3200000,6),(7,'París',2200000,1100000,1100000,400000,1800000,7),(8,'Madrid',3200000,1600000,1600000,700000,2500000,8),(9,'Roma',2800000,1400000,1400000,500000,2300000,9),(10,'Tokio',14000000,7000000,7000000,2000000,12000000,10),(11,'Pekín',21000000,10500000,10500000,4000000,17000000,11),(12,'Bombay',20000000,10000000,10000000,5000000,15000000,12),(13,'Moscú',12500000,6250000,6250000,2000000,10500000,13),(14,'Ciudad del Cabo',4300000,2150000,2150000,1000000,3300000,14),(15,'Sídney',5000000,2500000,2500000,1000000,4000000,15),(16,'Londres',8900000,4450000,4450000,1500000,7400000,16),(17,'Seúl',9600000,4800000,4800000,1500000,8100000,17),(18,'Lagos',14000000,7000000,7000000,4000000,10000000,18),(19,'El Cairo',9900000,4950000,4950000,3500000,6400000,19),(20,'Bogotá',7800000,3900000,3900000,2200000,5600000,20),(21,'Santiago',5400000,2700000,2700000,1200000,4200000,21),(22,'Lima',9600000,4800000,4800000,3500000,6100000,22),(23,'Caracas',2900000,1450000,1450000,900000,2000000,23),(24,'Riyadh',6800000,3400000,3400000,2000000,4800000,24),(25,'Istanbul',15000000,7500000,7500000,4000000,11000000,25),(26,'Amsterda',9000000,4500000,4500000,2000000,7000000,26),(27,'Wellington',4000000,2000000,2000000,1000000,3000000,27),(28,'Oslo',2800000,1400000,1400000,600000,2200000,28),(29,'Estocolmo',12000000,6000000,6000000,2500000,9500000,29),(30,'Helsinki',3000000,1500000,1500000,700000,2300000,30),(31,'Copenhague',3700000,1850000,1850000,500000,3200000,31),(32,'Quito',2200000,1100000,1100000,400000,1800000,32),(33,'Berna',3200000,1600000,1600000,700000,2500000,33),(34,'Viena',2800000,1400000,1400000,500000,2300000,34),(35,'Lisboa',14000000,7000000,7000000,2000000,12000000,35),(36,'Dublin',21000000,10500000,10500000,4000000,17000000,36),(37,'Praga',20000000,10000000,10000000,5000000,15000000,37),(38,'Budapest',12500000,6250000,6250000,2000000,10500000,38),(39,'Bucarest',4300000,2150000,2150000,1000000,3300000,39),(40,'Varsovia',5000000,2500000,2500000,1000000,4000000,40),(41,'Jerusalén',8900000,4450000,4450000,1500000,7400000,41),(42,'Riad',9600000,4800000,4800000,1500000,8100000,42),(43,'Kuala Lumpur',14000000,7000000,7000000,4000000,10000000,43),(44,'Bangkok',9900000,4950000,4950000,3500000,6400000,44),(45,'Hanoi',7800000,3900000,3900000,2200000,5600000,45),(46,'Santiago',5400000,2700000,2700000,1200000,4200000,46),(47,'Manila',9600000,4800000,4800000,3500000,6100000,47),(48,'Yakarta',2900000,1450000,1450000,900000,2000000,48),(49,'Kiev',6800000,3400000,3400000,2000000,4800000,49),(50,'Ulán Bator',15000000,7500000,7500000,4000000,11000000,50),(51,'Pyongyang',5400000,2700000,2700000,1200000,4200000,51),(52,'Kampong Glam',7800000,3900000,3900000,2200000,5600000,52),(53,'Dilijan',2200000,1100000,1100000,400000,1800000,53),(54,'San José',4000000,2000000,2000000,1000000,3000000,4),(55,'La Habana',2100000,1050000,1050000,600000,1500000,55),(56,'Haifa',880000,440000,440000,300000,580000,41),(57,'Montevideo',1300000,650000,650000,300000,1000000,57),(58,'Asunción',5500000,2750000,2750000,1400000,4100000,8),(59,'Sucre',300000,150000,150000,50000,250000,59),(60,'Tegucigalpa',1200000,600000,600000,300000,900000,60),(61,'San Salvador',2500000,1250000,1250000,600000,1900000,61),(62,'Guatemala',1200000,600000,600000,300000,900000,62),(63,'Santo Domingo',3000000,1500000,1500000,700000,2300000,63),(64,'Kingston',670000,335000,335000,150000,520000,64),(65,'Puerto España',140000,70000,70000,30000,110000,65),(66,'Paramaribo',250000,125000,125000,60000,190000,66),(67,'Georgetown',250000,125000,125000,60000,190000,67),(68,'Bridgetown',110000,55000,55000,20000,90000,68),(69,'Nassau',250000,125000,125000,50000,200000,69),(70,'Belmopan',20000,10000,10000,5000,15000,70),(71,'Lilongüe',1000000,500000,500000,300000,700000,71),(72,'Lusaka',2200000,1100000,1100000,700000,1500000,72),(73,'Nairobi',5000000,2500000,2500000,1200000,3800000,73),(74,'Dodoma',400000,200000,200000,100000,300000,74),(75,'Jartum',5000000,2500000,2500000,1500000,3500000,75),(76,'Brisbane',2500000,1330000,1170000,500000,2000000,15),(77,'Melbourne',5000000,2500000,2500000,1200000,3800000,15),(78,'Durban',3400000,1700000,1700000,1200000,2200000,76),(79,'Vancouver',675000,335000,340000,150000,525000,3),(80,'São Luís',1100000,560000,540000,400000,700000,4),(81,'Recife',1600000,800000,800000,500000,1100000,4),(82,'Guayaquil',2700000,1350000,1350000,700000,2000000,32),(83,'Lyon',530000,265000,265000,100000,430000,7),(84,'Marseille',870000,435000,435000,200000,670000,7),(85,'Lille',230000,115000,115000,50000,180000,7),(86,'Edinburgh',500000,250000,250000,100000,400000,16),(87,'Porto',215000,107500,107500,50000,165000,35),(88,'Hamburgo',1800000,900000,900000,400000,1400000,6),(89,'Munich',1500000,750000,750000,300000,1200000,6),(90,'Napoli',960000,480000,480000,200000,760000,9),(91,'Florencia',380000,190000,190000,80000,300000,9),(92,'Valencia',800000,400000,400000,150000,650000,8),(93,'Zúrich',430000,215000,215000,90000,340000,33),(94,'Fukuoka',1600000,800000,800000,300000,1300000,10),(95,'Auckland',1700000,850000,850000,400000,1300000,27),(96,'Barranquilla',1200000,600000,600000,400000,800000,20),(97,'Santa Cruz',1700000,850000,850000,500000,1200000,59),(98,'Rosario',1200000,600000,600000,300000,900000,5),(99,'Guadalajara',1500000,750000,750000,400000,1100000,1),(100,'Maracaibo',1600000,800000,800000,500000,1100000,23);
/*!40000 ALTER TABLE `ciudad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enf_prod`
--

DROP TABLE IF EXISTS `enf_prod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enf_prod` (
  `id_enfermedad` int unsigned NOT NULL,
  `id_producto` int unsigned NOT NULL,
  PRIMARY KEY (`id_enfermedad`,`id_producto`),
  KEY `id_producto` (`id_producto`),
  CONSTRAINT `enf_prod_ibfk_1` FOREIGN KEY (`id_enfermedad`) REFERENCES `enfermedad` (`id_enfermedad`),
  CONSTRAINT `enf_prod_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto_actuarial` (`id_producto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enf_prod`
--

LOCK TABLES `enf_prod` WRITE;
/*!40000 ALTER TABLE `enf_prod` DISABLE KEYS */;
INSERT INTO `enf_prod` VALUES (1,1),(23,1),(2,2),(32,2),(33,2),(34,2),(35,2),(53,2),(3,3),(56,3),(4,4),(37,4),(65,4),(5,6),(55,6),(6,7),(62,7),(7,8),(8,9),(57,9),(9,10),(40,10),(41,10),(42,10),(43,10),(44,10),(45,10),(48,10),(10,11),(11,12),(25,12),(30,12),(60,12),(12,13),(63,13),(13,14),(58,14),(14,15),(64,15),(15,16),(66,16),(16,17),(67,17),(17,18),(68,18),(18,19),(19,20),(59,20),(20,21),(50,21),(21,22),(52,23),(12,24),(63,24),(36,25),(54,25),(38,26),(51,26),(22,28),(24,28),(26,28),(27,28),(39,28),(61,28),(9,29),(40,29),(41,29),(42,29),(43,29),(44,29),(45,29),(48,29),(2,30),(32,30),(33,30),(34,30),(35,30),(53,30),(4,32),(37,32),(65,32),(21,33),(2,34),(32,34),(33,34),(34,34),(35,34),(53,34),(5,35),(55,35),(36,36),(54,36),(9,37),(40,37),(41,37),(42,37),(43,37),(44,37),(45,37),(48,37),(10,38),(2,39),(32,39),(33,39),(34,39),(35,39),(53,39),(11,40),(25,40),(30,40),(60,40),(12,41),(63,41),(11,42),(25,42),(30,42),(60,42),(46,43),(47,43),(38,45),(51,45),(1,46),(23,46),(18,47),(28,48),(29,48),(31,48),(8,49),(57,49),(1,50),(23,50),(4,52),(37,52),(65,52),(13,53),(58,53),(14,54),(64,54);
/*!40000 ALTER TABLE `enf_prod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enfermedad`
--

DROP TABLE IF EXISTS `enfermedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enfermedad` (
  `id_enfermedad` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(40) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `id_tipo_enf` int unsigned NOT NULL,
  PRIMARY KEY (`id_enfermedad`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_tipo_enfermedad` (`id_tipo_enf`),
  CONSTRAINT `FK_tipo_enfermedad` FOREIGN KEY (`id_tipo_enf`) REFERENCES `tipo_enfermedad` (`id_tipo_enf`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enfermedad`
--

LOCK TABLES `enfermedad` WRITE;
/*!40000 ALTER TABLE `enfermedad` DISABLE KEYS */;
INSERT INTO `enfermedad` VALUES (1,'Neumonía','Inflamación de los pulmones',1),(2,'Infarto','Bloqueo del flujo sanguíneo',2),(3,'Gastritis','Irritación del estómago',3),(4,'Migraña','Dolor intenso de cabeza',4),(5,'Diabetes','Altos niveles de glucosa en sangre',6),(6,'Lupus','Enfermedad autoinmune',7),(7,'Artritis','Inflamación de las articulaciones',8),(8,'Fibrosis Quística','Enfermedad genética',9),(9,'Cáncer','Crecimiento descontrolado de células',10),(10,'Depresión','Trastorno del estado de ánimo',11),(11,'COVID-19','Enfermedad viral respiratoria',12),(12,'Hipotiroidismo','Producción insuficiente de hormonas tiroideas',13),(13,'Leucemia','Cáncer de la sangre',14),(14,'Osteoporosis','Debilitamiento de los huesos',15),(15,'Enfisema','Deterioro pulmonar',18),(16,'Insuficiencia Renal','Pérdida de función renal',19),(17,'Cistitis','Inflamación de la vejiga',20),(18,'Trombosis','Formación de coágulos en los vasos sanguíneos',22),(19,'Hepatitis','Inflamación del hígado',23),(20,'Alergias','Reacciones exageradas del sistema inmune',24),(21,'Caries','Destrucción del esmalte dental',25),(22,'Colitis','Inflamación del Colón',31),(23,'Asma','Inflamación de las vías respiratorias de los pulmones',1),(24,'Pancreatitis','Inflamación del pancreas',31),(25,'Diverticulitis','Infección de diverticulos en el Colón',12),(26,'Apendicitis','Inflamación del apendice',31),(27,'Peritonitis','Perforación intestinal',31),(28,'VIH','Enfermedad que ataca el sistema inmunológico del cuerpo humano',21),(29,'VPH','Desarrollo de verrugas genitales y ciertos tipos de cáncer,',21),(30,'Candidiasis','infección causada por un hongo del género Candida',12),(31,'Sifilis','enfermedad causada por la bacteria Treponema pallidum.',21),(32,'Arritmia','Alteraciones en el ritmo cardíaco, que pueden incluir taquicardia y bradicardia',2),(33,'Pericarditis','Inflamación del pericardio, la membrana que rodea el corazón',2),(34,'Aneurisma aórtico','Una dilatación anormal en la aorta',2),(35,'Enfermedad coronaria','Acumulación de placa en las arterias coronarias',2),(36,'Alzheimer','Demencia que afecta la memoria, el pensamiento y el comportamiento',27),(37,'Parkinson','Trastorno neurodegenerativo que afecta el movimiento',4),(38,'Esclerosis múltiple','Una enfermedad autoinmune que afecta el sistema nervioso central, provocando daño en la mielina',28),(39,'Encefalitis','Inflamación del cerebro',31),(40,'Cáncer de páncreas',' Cáncer que se origina en los tejidos del páncreas',10),(41,'Cancer de mama','Se desarrolla en las células del tejido mamario.',10),(42,'Cancer colorrectal','Se desarrolla en el colon o el recto y puede comenzar como pólipos',10),(43,'Cáncer de próstata','Cáncer que se forma en la glándula prostática en hombre',10),(44,'Cáncer de piel','Se desarrolla en las células de la piel.',10),(45,'Linfoma','Cáncer que se origina en el sistema linfático',10),(46,'Endometriosis','Trastorno en el que el tejido similar al endometrio crece fuera del útero',32),(47,'Síndrome de Ovario Poliquístico','Trastorno hormonal que afecta los ovarios, provocando quistes y problemas hormonales',32),(48,'Cáncer de cuello uterino','Cáncer que se desarrolla en el cuello del útero',10),(49,'Hemorroides','Inflamación de las venas en el recto o el ano',33),(50,'Rinitis Alérgica','Inflamación de las vías nasales causada por alérgenos',24),(51,'Esclerodermia','Enfermedad autoinmune que endurece la piel y órganos internos',28),(52,'Colangitis','Inflamación de los conductos biliares',26),(53,'Aneurisma cerebral','Dilatación anormal de un vaso sanguíneo en el cerebro',2),(54,'Enfermedad de Huntington','Trastorno neurodegenerativo hereditario que afecta el control motor',27),(55,'Enfermedad de Addison','Trastorno endocrino donde las glándulas suprarrenales no producen suficientes hormonas',6),(56,'Síndrome del Intestino Irritable','Trastorno gastrointestinal crónico que afecta el intestino grueso',3),(57,'Fenilcetonuria','Trastorno genético que impide metabolizar fenilalanina',9),(58,'Anemia aplásica','Trastorno en el que la médula ósea no produce suficientes células sanguíneas',14),(59,'Cirrosis','Cicatrización crónica del hígado debido a daño prolongado',23),(60,'Varicela','Infección viral que causa erupciones en la piel y fiebre',12),(61,'Enfermedad de Crohn','Enfermedad inflamatoria crónica que afecta el tracto gastrointestinal',31),(62,'Síndrome de Guillain-Barré','Trastorno en el cual el sistema inmune ataca los nervios periféricos',7),(63,'Hiperlipidemia','Niveles elevados de lípidos en sangre',13),(64,'Espina bífida','Defecto de nacimiento que afecta la columna vertebral',15),(65,'Hipoacusia súbita','Pérdida repentina de la audición',4),(66,'Fibrosis Pulmonar','Formación de tejido cicatricial en los pulmones',18),(67,'Nefritis','Inflamación de los riñones',19),(68,'Pielonefritis','Infección bacteriana que afecta a los riñones',20);
/*!40000 ALTER TABLE `enfermedad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mortalidad`
--

DROP TABLE IF EXISTS `mortalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mortalidad` (
  `id_persona` int unsigned NOT NULL,
  `fecha_fallecimiento` date NOT NULL,
  `edad_fallecimiento` tinyint unsigned NOT NULL,
  `causa` varchar(300) DEFAULT NULL,
  `id_enfermedad` int unsigned NOT NULL,
  `id_lugar_fallecimiento` int unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `FK_enfermedad_mortalidad` (`id_enfermedad`),
  KEY `FK_lugar_mortalidad` (`id_lugar_fallecimiento`),
  CONSTRAINT `FK_enfermedad_mortalidad` FOREIGN KEY (`id_enfermedad`) REFERENCES `enfermedad` (`id_enfermedad`),
  CONSTRAINT `FK_lugar_mortalidad` FOREIGN KEY (`id_lugar_fallecimiento`) REFERENCES `ciudad` (`id_ciudad`),
  CONSTRAINT `FK_persona_mortalidad` FOREIGN KEY (`id_persona`) REFERENCES `persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mortalidad`
--

LOCK TABLES `mortalidad` WRITE;
/*!40000 ALTER TABLE `mortalidad` DISABLE KEYS */;
INSERT INTO `mortalidad` VALUES (1,'2020-02-18',34,'Neumonía',1,1),(2,'2019-09-07',29,'Infarto',2,2),(3,'2021-05-30',32,'Gastritis',3,3),(4,'2020-12-11',27,'Migraña',4,4),(5,'2019-07-03',40,'Diabetes',5,5),(6,'2022-04-22',39,'Diabetes',5,6),(7,'2018-10-16',31,'Lupus',6,7),(8,'2021-11-05',35,'Artritis',7,8),(9,'2020-06-28',25,'Fibrosis Quística',8,9),(10,'2017-09-14',30,'Cáncer',9,10),(11,'2019-02-01',37,'Depresión',10,11),(12,'2020-08-19',36,'COVID-19',11,12),(13,'2021-03-15',40,'Hipotiroidismo',12,13),(14,'2018-05-24',29,'Leucemia',13,14),(15,'2019-01-07',41,'Osteoporosis',14,15),(16,'2021-07-31',31,'Enfisema',15,18),(17,'2019-04-16',34,'Insuficiencia Renal',16,19),(18,'2022-01-10',37,'Cistitis',17,20),(19,'2020-03-14',40,'Trombosis',18,22),(20,'2021-05-17',30,'Hepatitis',19,23),(21,'2020-09-28',38,'Caries',21,25),(23,'2024-10-31',27,'Cancer pancreas',40,26),(24,'2024-06-26',54,'Infarto',2,27),(25,'2024-11-11',51,'Hepatitis',19,28),(26,'2024-08-18',30,'Migraña',4,29),(27,'2024-09-21',27,'VPH',29,30),(28,'2023-06-16',25,'Diabetes',5,31),(29,'2023-12-01',23,'Encefalitits',39,32),(30,'2023-09-03',30,'Alzheimer',36,33),(31,'2023-08-03',53,'Fibrosis Quística',8,34),(32,'2023-11-07',24,'Peritonitis',27,35),(33,'2022-06-17',22,'Depresión',10,36),(34,'2022-08-21',28,'COVID-19',11,37),(35,'2022-04-14',19,'Cancer de mama',41,38),(36,'2022-12-23',18,'Leucemia',13,39),(37,'2021-01-07',21,'Infarto',2,40),(38,'2020-11-21',50,'VPH',29,42),(39,'2021-07-31',45,'Enfisema',15,43),(40,'2019-04-16',39,'Insuficiencia Renal',16,44),(41,'2022-01-10',25,'Arritmia',32,45),(42,'2020-03-14',32,'Trombosis',18,47),(43,'2021-05-17',36,'Hepatitis',19,48),(44,'2019-10-08',30,'Alergias',20,49),(45,'2020-09-28',16,'Caries',21,50),(46,'2023-10-15',45,'Osteoporosis',14,25),(47,'2023-11-12',33,'Insuficiencia Renal',16,51),(48,'2023-10-20',29,'Cáncer',9,75),(49,'2024-01-05',38,'Hepatitis',19,72),(50,'2023-12-15',41,'Anemia aplásica',59,16),(51,'2023-11-20',39,'Parkinson',37,17),(52,'2024-02-28',34,'Cáncer de piel',44,19),(53,'2024-03-10',25,'Gastritis',3,20),(54,'2024-02-14',40,'Lupus',6,60),(55,'2024-03-22',31,'Esclerosis múltiple',38,48),(56,'2024-01-18',26,'Artritis',7,62),(57,'2024-04-01',55,'Colitis',22,68),(58,'2024-03-30',28,'Diabetes',5,32),(59,'2024-02-25',42,'Sifilis',31,23),(60,'2024-01-22',30,'Enfermedad coronaria',35,50),(61,'2023-12-10',37,'Fibrosis Pulmonar',67,25),(62,'2024-03-05',44,'Síndrome del Intestino Irritable',57,36),(63,'2024-01-15',26,'Anemia',59,31),(64,'2024-02-20',48,'Endometriosis',46,27),(65,'2024-03-17',29,'Varicela',61,18),(66,'2024-01-29',50,'VIH',28,19),(67,'2024-03-15',52,'Síndrome de Guillain-Barré',67,34),(68,'2024-02-12',35,'Cancer',9,74),(69,'2024-01-30',47,'Cirrosis',60,75);
/*!40000 ALTER TABLE `mortalidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `natalidad`
--

DROP TABLE IF EXISTS `natalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `natalidad` (
  `id_natalidad` int unsigned NOT NULL AUTO_INCREMENT,
  `anio` int unsigned NOT NULL,
  `edad_madre` tinyint unsigned NOT NULL,
  `numero_nacimientos` int unsigned NOT NULL,
  `tasa_natalidad` decimal(5,2) NOT NULL,
  `id_lugar` int unsigned NOT NULL,
  PRIMARY KEY (`id_natalidad`),
  KEY `FK_lugar_natalidad` (`id_lugar`),
  CONSTRAINT `FK_lugar_natalidad` FOREIGN KEY (`id_lugar`) REFERENCES `ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `natalidad`
--

LOCK TABLES `natalidad` WRITE;
/*!40000 ALTER TABLE `natalidad` DISABLE KEYS */;
INSERT INTO `natalidad` VALUES (1,2020,25,3000,35.50,1),(2,2019,28,2800,30.00,2),(3,2021,30,3200,40.25,3),(4,2018,32,2900,32.10,4),(5,2022,24,3100,37.00,5),(6,2019,26,2700,29.50,6),(7,2020,29,3500,43.20,7),(8,2021,27,3400,36.75,8),(9,2022,31,3600,41.50,9),(10,2019,33,2800,30.60,10),(11,2021,25,3000,33.00,11),(12,2020,28,3100,38.20,12),(13,2018,26,3300,35.10,13),(14,2022,30,3500,42.00,14),(15,2019,32,3200,31.90,15),(16,2020,27,2900,33.40,16),(17,2021,29,3100,36.90,17),(18,2022,24,3300,38.50,18),(19,2018,31,3400,41.00,19),(20,2020,26,3000,34.80,20),(21,2021,30,3300,39.20,21),(22,2019,27,2800,32.50,22),(23,2022,29,3100,37.70,23),(24,2021,25,3500,44.30,24),(25,2020,33,3200,31.40,25),(26,2022,26,3400,36.00,26),(27,2021,29,3600,39.80,27),(28,2022,31,3200,34.50,28),(29,2020,31,3200,37.50,29),(30,2020,30,3000,33.90,30),(31,2019,28,3100,38.00,31),(32,2021,32,3500,41.20,32),(33,2022,27,3300,36.75,33),(34,2020,25,2900,32.80,34),(35,2021,29,2800,30.50,35),(36,2022,30,3000,35.60,36),(37,2019,33,3200,37.90,37),(38,2021,28,3100,40.10,38),(39,2020,24,3500,42.30,39),(40,2018,35,2900,34.10,40),(41,2022,26,3400,38.50,41),(42,2019,31,3600,44.00,42),(43,2021,29,3000,39.90,43),(44,2018,27,3200,36.25,44),(45,2020,32,3100,40.40,45),(46,2021,30,3300,41.80,46),(47,2019,28,3500,43.00,47),(48,2022,25,2800,32.00,48),(49,2021,34,3400,36.80,49),(50,2018,29,3100,38.20,50),(51,2020,36,3000,35.50,51),(52,2019,28,2800,30.00,52),(53,2021,30,3200,40.25,53),(54,2018,32,2900,32.10,54),(55,2022,36,3100,37.00,55),(56,2019,26,2700,29.50,56),(57,2020,29,3500,43.20,57),(58,2021,37,3400,36.75,58),(59,2022,31,3600,41.50,59),(60,2019,33,2800,30.60,60),(61,2021,37,3000,33.00,61),(62,2020,28,3100,38.20,62),(63,2018,26,3300,35.10,63),(64,2022,30,3500,42.00,64),(65,2019,38,3200,31.90,65),(66,2020,38,2900,33.40,66),(67,2021,29,3100,36.90,67),(68,2022,38,3300,38.50,68),(69,2018,31,3400,41.00,69),(70,2020,26,3000,34.80,70),(71,2021,39,3300,39.20,71),(72,2019,28,2800,32.50,72),(73,2022,29,3100,37.70,73),(74,2021,25,3500,44.30,74),(75,2020,38,3200,31.40,75),(76,2022,26,3400,36.00,76),(77,2021,29,3600,39.80,77),(78,2022,39,3200,34.50,78),(79,2020,31,3200,37.50,79),(80,2020,30,3000,33.90,80),(81,2019,28,3100,38.00,81),(82,2021,32,3500,41.20,82),(83,2022,27,3300,36.75,83),(84,2020,40,2900,32.80,84),(85,2021,29,2800,30.50,85),(86,2023,30,3000,35.60,86),(87,2023,40,3200,37.90,87),(88,2023,28,3100,40.10,88),(89,2023,24,3500,42.30,89),(90,2023,35,2900,34.10,90),(91,2023,26,3400,38.50,91),(92,2023,40,3600,44.00,92),(93,2023,29,3000,39.90,93),(94,2023,27,3200,36.25,94),(95,2023,32,3100,40.40,95),(96,2023,30,3300,41.80,96),(97,2023,40,3500,43.00,97),(98,2023,25,2800,32.00,98),(99,2023,40,3400,36.80,99),(100,2023,40,3100,38.20,100);
/*!40000 ALTER TABLE `natalidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `id_pais` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) NOT NULL,
  `poblacion_total` int unsigned NOT NULL DEFAULT '0',
  `poblacion_m` int unsigned NOT NULL DEFAULT '0',
  `poblacion_h` int unsigned NOT NULL DEFAULT '0',
  `poblacion_menor18` int unsigned NOT NULL DEFAULT '0',
  `poblacion_mayor18` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pais`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'México',127000000,63500000,63500000,40000000,87000000),(2,'Estados Unidos',331000000,160000000,171000000,74000000,257000000),(3,'Canadá',38000000,18500000,19500000,10000000,28000000),(4,'Brasil',213000000,108000000,105000000,60000000,153000000),(5,'Argentina',45000000,22000000,23000000,13000000,32000000),(6,'Alemania',83000000,40000000,43000000,15000000,68000000),(7,'Francia',67000000,32000000,35000000,12000000,55000000),(8,'España',47000000,23000000,24000000,10000000,37000000),(9,'Italia',60000000,29000000,31000000,11000000,49000000),(10,'Japón',126000000,62000000,64000000,16000000,110000000),(11,'China',1400000000,720000000,680000000,300000000,1100000000),(12,'India',1390000000,710000000,680000000,350000000,1040000000),(13,'Rusia',144000000,68000000,76000000,25000000,119000000),(14,'Sudáfrica',60000000,29000000,31000000,18000000,42000000),(15,'Australia',25000000,12500000,12500000,6000000,19000000),(16,'Reino Unido',67000000,33000000,34000000,15000000,52000000),(17,'Corea del Sur',52000000,26000000,26000000,9000000,43000000),(18,'Nigeria',206000000,103000000,103000000,70000000,136000000),(19,'Egipto',104000000,51000000,53000000,38000000,66000000),(20,'Colombia',50800000,25500000,25300000,17000000,33800000),(21,'Panamá',19000000,9500000,9500000,4000000,15000000),(22,'Perú',33000000,16500000,16500000,12000000,21000000),(23,'Venezuela',28000000,14000000,14000000,9000000,19000000),(24,'Arabia Saudita',35000000,17500000,17500000,12000000,23000000),(25,'Turquía',85000000,42500000,42500000,28000000,57000000),(26,'Holanda',127000000,63500000,63500000,40000000,87000000),(27,'Nueva Zelanda',331000000,160000000,171000000,74000000,257000000),(28,'Noruega',38000000,18500000,19500000,10000000,28000000),(29,'Suecia',213000000,108000000,105000000,60000000,153000000),(30,'Finlandia',45000000,22000000,23000000,13000000,32000000),(31,'Dinamarca',83000000,40000000,43000000,15000000,68000000),(32,'Ecuador',67000000,32000000,35000000,12000000,55000000),(33,'Suiza',47000000,23000000,24000000,10000000,37000000),(34,'Austria',60000000,29000000,31000000,11000000,49000000),(35,'Portugal',126000000,62000000,64000000,16000000,110000000),(36,'Irlanda',1400000000,720000000,680000000,300000000,1100000000),(37,'República Checa',1390000000,710000000,680000000,350000000,1040000000),(38,'Hungría',144000000,68000000,76000000,25000000,119000000),(39,'Rumania',60000000,29000000,31000000,18000000,42000000),(40,'Polonia',25000000,12500000,12500000,6000000,19000000),(41,'Israel',67000000,33000000,34000000,15000000,52000000),(42,'Sri Lanka',52000000,26000000,26000000,9000000,43000000),(43,'Malasia',206000000,103000000,103000000,70000000,136000000),(44,'Tailandia',104000000,51000000,53000000,38000000,66000000),(45,'Vietnam',50800000,25500000,25300000,17000000,33800000),(46,'Chile',19000000,9500000,9500000,4000000,15000000),(47,'Filipinas',33000000,16500000,16500000,12000000,21000000),(48,'Indonesia',28000000,14000000,14000000,9000000,19000000),(49,'Ucrania',35000000,17500000,17500000,12000000,23000000),(50,'Mongolia',85000000,42500000,42500000,28000000,57000000),(51,'Corea del Norte',19100000,9500000,9600000,4200000,14900000),(52,'Singapur',50500000,25000000,25500000,18000000,32500000),(53,'Armenia',18000000,9000000,9000000,4000000,14000000),(54,'Costa Rica',5100000,2500000,2600000,1200000,3900000),(55,'Cuba',11300000,5700000,5600000,3000000,8300000),(56,'Islandia',4500000,2200000,2300000,1000000,3500000),(57,'Uruguay',3500000,1700000,1800000,800000,2700000),(58,'Paraguay',7000000,3500000,3500000,2000000,5000000),(59,'Bolivia',11500000,5800000,5700000,3000000,8500000),(60,'Honduras',10000000,4900000,5100000,2600000,7400000),(61,'El Salvador',6500000,3200000,3300000,1500000,5000000),(62,'Guatemala',19000000,9500000,9500000,5000000,14000000),(63,'República Dominicana',11000000,5400000,5600000,2500000,8500000),(64,'Jamaica',2900000,1400000,1500000,600000,2200000),(65,'Trinidad y Tobago',1400000,700000,700000,300000,1100000),(66,'Surinam',600000,300000,300000,150000,450000),(67,'Guyana',790000,390000,400000,180000,610000),(68,'Barbados',280000,140000,140000,60000,220000),(69,'Belice',400000,200000,200000,80000,320000),(70,'Bahamas',400000,200000,200000,80000,320000),(71,'Malawi',21000000,10500000,10500000,12000000,9000000),(72,'Zambia',19000000,9500000,9500000,10000000,9000000),(73,'Kenia',54000000,27000000,27000000,18000000,36000000),(74,'Tanzania',59000000,29000000,30000000,20000000,39000000),(75,'Sudán',44000000,22000000,22000000,13000000,31000000),(76,'Kazajistán',62000000,31000000,31000000,15500000,46500000);
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persona` (
  `id_persona` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre1` varchar(15) NOT NULL,
  `nombre2` varchar(15) DEFAULT NULL,
  `apellido_p` varchar(15) NOT NULL,
  `apellido_m` varchar(15) NOT NULL,
  `fecha_nac` date DEFAULT NULL,
  `sexo` enum('M','F') DEFAULT NULL,
  `estado_civil` varchar(15) DEFAULT NULL,
  `id_lugar_residencia` int unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `FK_lugar_persona` (`id_lugar_residencia`),
  CONSTRAINT `FK_lugar_persona` FOREIGN KEY (`id_lugar_residencia`) REFERENCES `ciudad` (`id_ciudad`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Juan','Carlos','Perez','Garcia','1985-07-16','M','Soltero',1),(2,'Maria','Fernanda','Lopez','Hernandez','1990-05-22','F','Casada',2),(3,'John','Michael','Smith','Johnson','1988-11-11','M','Casado',3),(4,'Sofia','Isabella','Martinez','Ramirez','1993-02-14','F','Soltera',4),(5,'Pedro','Miguel','Gonzalez','Sanchez','1979-08-03','M','Soltero',5),(6,'Lucia','Valentina','Rodriguez','Vargas','1982-09-21','F','Casada',6),(7,'Luis','Felipe','Torres','Flores','1991-12-01','M','Soltero',7),(8,'Emily','Grace','Brown','Taylor','1986-03-30','F','Soltera',8),(9,'Carlos','Eduardo','Garcia','Morales','1995-07-19','M','Soltero',9),(10,'Anna','Maria','Martinez','Gomez','1987-10-25','F','Soltera',10),(11,'David','Paul','Hernandez','Ortiz','1992-06-17','M','Casado',11),(12,'Alex','Benjamin','Jones','Reyes','1984-01-10','M','Soltero',12),(13,'Viktor','Sergey','Ivanov','Petrov','1981-04-14','M','Casado',13),(14,'Chloe','Olivia','Taylor','Martinez','1989-12-23','F','Soltera',14),(15,'George','Alexander','Wilson','Thompson','1978-02-09','M','Casado',15),(16,'Sara','Nicole','Mendoza','Navarro','1994-11-29','F','Soltera',16),(17,'Fernando','David','Ruiz','Salinas','1983-06-05','M','Soltero',17),(18,'Isabel','Elena','Vega','Castillo','1976-09-12','F','Casada',18),(19,'Omar','Andres','Ramirez','Padilla','1980-03-22','M','Casado',19),(20,'Luz','Andrea','Perez','Cabrera','1997-10-13','F','Soltera',20),(21,'Hugo','Enrique','Diaz','Luna','1990-08-08','M','Soltero',21),(22,'Patricia','Gabriela','Ortiz','Hernandez','1988-04-18','F','Casada',22),(23,'Miguel','Angel','Marquez','Galindo','1985-12-20','M','Soltero',23),(24,'Julieta','Camila','Moreno','Torres','1989-03-09','F','Soltera',24),(25,'Francisco','Ignacio','Ramos','Medina','1982-11-07','M','Casado',25),(26,'Jair',NULL,'Hernández','Torres','1997-10-31','M','Soltero',26),(27,'Claudia',NULL,'Torres','Perez','1970-06-26','F','Casada',27),(28,'Mario',NULL,'Hernández','Miranda','1973-11-11','M','Casado',28),(29,'Amayrani',NULL,'Hernández','Torres','1994-08-18','F','Soltera',29),(30,'Karen','Saradeli','Briones','Hernandez','1997-09-21','F','Soltera',30),(31,'Diego',NULL,'Noriega','Hernández','1998-06-16','M','Casado',31),(32,'David',NULL,'Rosendo','Ferrer','2000-12-01','M','Soltero',32),(33,'María','Aurora','De Los Angeles','García','1993-09-03','F','Casada',33),(34,'Sergio',NULL,'Fernandez','Fernandez','1970-08-03','M','Casado',34),(35,'José','Guadalupe','Serrano','Hernandez','1999-11-07','M','Soltero',35),(36,'Karime',NULL,'Garcia','Lopez','2000-06-17','F','Casada',36),(37,'Alejandro',NULL,'Rodriguez','Barrón','1994-08-21','M','Casado',37),(38,'Paulina','Maria','Estrada','Fuentes','2003-04-14','F','Soltera',38),(39,'Merit',NULL,'Morales','Martinez','2004-12-23','F','Soltera',39),(40,'Emiliano',NULL,'Patlan','Hernandez','2000-02-09','M','Casado',40),(41,'Levi',NULL,'Hernández','Jimenez','1994-11-29','M','Soltera',41),(42,'Fernando',NULL,'Hernánez','Miranda','1980-06-05','M','Soltero',42),(43,'María','Fernanda','Patraca','Fernandez','1976-09-12','F','Casada',43),(44,'Samuek',NULL,'Moreno','Hernandez','1980-03-22','M','soltero',44),(45,'Luis','Fernando','Rojas','Linares','1997-10-13','M','Soltero',45),(46,'Liliana',NULL,'Diaz','Carbajal','1990-08-08','F','Soltera',46),(47,'Ana','Gabriela','Ochoa','Hernandez','1988-04-18','F','Casada',47),(48,'Daniela',NULL,'Morales','Garcia','1985-12-20','F','Soltero',48),(49,'Juan','Daniel','Lopez','Lopez','1989-03-09','M','Solter0',49),(50,'María','Fernanda','Moctezuma','Barrios','2004-03-17','F','Soltera',50),(51,'Luis',NULL,'Jimenez','Salas','1980-12-01','M','Casado',25),(52,'Patricia',NULL,'Gonzalez','Mora','1992-01-15','F','Soltera',51),(53,'Carlos',NULL,'Salinas','Rivas','1995-05-05','M','Soltero',75),(54,'Nadia',NULL,'Blanco','Muñoz','1987-03-30','F','Casada',5),(55,'Miguel',NULL,'Rojas','López','1991-06-20','M','Soltero',55),(56,'Veronica',NULL,'Hernandez','Gonzalez','1988-08-08','F','Casada',56),(57,'Fernando',NULL,'Lopez','Martinez','1993-11-02','M','Soltero',57),(58,'Jessica',NULL,'Martinez','Garcia','1994-09-17','F','Soltera',58),(59,'Arturo',NULL,'Soto','Cruz','1979-07-25','M','Casado',59),(60,'Claudia',NULL,'Cordero','Reyes','1982-10-11','F','Soltera',60),(61,'Jorge',NULL,'Pérez','Maldonado','1976-05-05','M','Casado',61),(62,'Lorena',NULL,'Diaz','Hernandez','1990-04-12','F','Soltera',62),(63,'Oscar',NULL,'Ramirez','Pacheco','1983-02-22','M','Casado',63),(64,'Sandra',NULL,'Garcia','Sánchez','1996-12-30','F','Soltera',64),(65,'Isaac','Adolfo','Aguilar','Ávila','1981-01-09','M','Soltero',65),(66,'Karla',NULL,'López','Valenzuela','1985-11-20','F','Casada',50),(67,'Adrian',NULL,'Cervantes','Salinas','1994-08-01','M','Soltero',25),(68,'Isabel',NULL,'Pérez','Flores','1989-03-03','F','Soltera',36),(69,'Marco',NULL,'Velasco','Hernandez','1992-10-10','M','Casado',31),(70,'Julia','Elena','Serrano','Téllez','1984-09-19','F','Soltera',27),(71,'Alberto','Luis','Gutiérrez','Ponce','1980-07-17','M','Soltero',18),(72,'Renata','Sofia','Ramos','Loera','1991-04-04','F','Casada',19),(73,'Felipe','Javier','Moreno','Bermudez','1986-06-06','M','Soltero',34),(74,'Martha','Lucia','Palacios','Ceballos','1995-03-22','F','Soltera',74),(75,'Joaquín',NULL,'Aguirre','Serrano','1982-01-31','M','Casado',75),(76,'Andres','Felipe','Paredes','Mendoza','1992-04-15','M','Soltero',76),(77,'Carolina','Andrea','Rojas','Figueroa','1990-07-23','F','Casada',77),(78,'Miguel','Angel','Castillo','Fernandez','1986-11-05','M','Casado',78),(79,'Raul','Ignacio','Diaz','Soto','1985-12-30','M','Soltero',79),(80,'Valeria','Sofia','Garcia','Vargas','1993-09-25','F','Soltera',80),(81,'Roberto','Carlos','Ramirez','Gomez','1991-03-19','M','Casado',81),(82,'Gabriela','Mariana','Hernandez','Lopez','1990-08-07','F','Soltera',82),(83,'Daniel','Enrique','Martinez','Perez','1995-05-18','M','Soltero',83),(84,'Javier','David','Sanchez','Torres','1987-02-11','M','Casado',84),(85,'Mariana','Elena','Lopez','Cruz','1984-06-29','F','Casada',85),(86,'Paola','Isabel','Mendoza','Reyes','1989-03-10','F','Soltera',86),(87,'Fernando','Eduardo','Santos','Naranjo','1991-09-17','M','Casado',87),(88,'Luis','Alberto','Morales','Gomez','1993-11-06','M','Soltero',88),(89,'Natalia','Beatriz','Flores','Quintero','1994-01-14','F','Soltera',89),(90,'Diego',NULL,'Gutierrez','Diaz','1988-04-25','M','Soltero',90),(91,'Claudia','Lorena','Vega','Garcia','1985-02-09','F','Casada',91),(92,'Oscar','Manuel','Zamora','Hernandez','1990-07-30','M','Casado',92),(93,'Sofia','Camila','Nunez','Paredes','1995-08-14','F','Soltera',93),(94,'Antonio','Ricardo','Lara','Castillo','1983-12-05','M','Casado',94),(95,'Alejandra','Victoria','Ruiz','Montoya','1987-10-22','F','Soltera',95),(96,'David','Leonardo','Espinosa','Jimenez','1986-05-28','M','Soltero',96),(97,'Monica','Patricia','Ortiz','Rojas','1992-07-13','F','Casada',97),(98,'Francisco','Javier','Rivas','Suarez','1981-03-08','M','Casado',98),(99,'Marcela','Fernanda','Aguilar','Vargas','1984-09-17','F','Casada',99),(100,'Jorge','Emmanuel','Castro','Lopez','1990-06-15','M','Soltero',100);
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto_actuarial`
--

DROP TABLE IF EXISTS `producto_actuarial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto_actuarial` (
  `id_producto` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(70) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto_actuarial`
--

LOCK TABLES `producto_actuarial` WRITE;
/*!40000 ALTER TABLE `producto_actuarial` DISABLE KEYS */;
INSERT INTO `producto_actuarial` VALUES (1,'Seguro de Salud Respiratoria','Cobertura integral para el tratamiento y diagnóstico de enfermedades respiratorias, incluyendo afecciones pulmonares y respiratorias crónicas.'),(2,'Seguro de Vida','Cobertura que protege frente a los riesgos asociados a enfermedades cardiovasculares, ofreciendo atención médica y apoyo financiero ante eventos como infartos o accidentes cerebrovasculares.'),(3,'Cobertura Médica','Cobertura para enfermedades gastrointestinales, brindando acceso a tratamientos médicos y quirúrgicos para afecciones digestivas y metabólicas.'),(4,'Protección Neurológica','Cobertura destinada a enfermedades neurológicas, que incluye atención para trastornos cerebrales, neuropatías y otras condiciones del sistema nervioso.'),(5,'Plan Dermatológico','Cobertura especializada en el diagnóstico y tratamiento de enfermedades dermatológicas, desde afecciones comunes hasta condiciones crónicas de la piel.'),(6,'Asistencia Médica Endócrina','Cobertura médica enfocada en enfermedades endocrinas, incluyendo trastornos hormonales, diabetes y otros problemas metabólicos relacionados con glándulas endocrinas.'),(7,'Asistencia Médica Inmunológica','Cobertura para enfermedades inmunológicas, incluyendo trastornos autoinmunes, alergias y deficiencias del sistema inmunológico que afectan la salud general.'),(8,'Protección Reumatológica','Cobertura destinada a la prevención y tratamiento de enfermedades reumatológicas, como artritis y otras afecciones del sistema musculoesquelético y articular.'),(9,'Seguro Genético','Cobertura especializada en enfermedades genéticas, ofreciendo diagnóstico, tratamiento y seguimiento para afecciones hereditarias o predisposiciones genéticas.'),(10,'Plan Oncológico','Cobertura integral para el tratamiento del cáncer, que incluye diagnóstico temprano, tratamientos médicos, quirúrgicos y de rehabilitación para pacientes oncológicos.'),(11,'Seguro Psiquiátrico','Cobertura diseñada para enfermedades mentales y psiquiátricas, brindando apoyo psicológico, psiquiátrico y servicios terapéuticos especializados.'),(12,'Asistencia Médica Infecciosa','Cobertura para enfermedades infecciosas, incluyendo tratamiento y prevención de infecciones bacterianas, virales y parasitarias.'),(13,'Asistencia Médica Metabólica','Cobertura que abarca trastornos metabólicos, como la obesidad, la diabetes y otros desequilibrios en el sistema metabólico del cuerpo.'),(14,'Plan Hematológico','Cobertura especializada en el diagnóstico y tratamiento de enfermedades hematológicas, como anemias, leucemias y trastornos sanguíneos.'),(15,'Protección Musculoesquelética','Cobertura que abarca enfermedades del sistema musculoesquelético, incluyendo afecciones articulares, musculares y óseas, tanto traumáticas como degenerativas.'),(16,'Protección Pulmonar','Cobertura para enfermedades pulmonares crónicas y agudas, incluyendo afecciones como la EPOC, el asma y otras enfermedades respiratorias.'),(17,'Plan Renal','Cobertura integral para el diagnóstico, tratamiento y manejo de enfermedades renales, desde insuficiencia renal hasta otras afecciones relacionadas con los riñones.'),(18,'Protección Urológica','Cobertura para enfermedades urológicas, incluyendo trastornos de los riñones, vejiga y sistema urinario, como infecciones y cálculos renales.'),(19,'Asistencia Médica Vascular','Cobertura enfocada en enfermedades vasculares, tales como problemas en arterias, venas y otros trastornos circulatorios, ofreciendo atención integral para afecciones cardíacas y vasculares.'),(20,'Protección Hepática','Cobertura para enfermedades hepáticas, proporcionando diagnóstico y tratamiento para afecciones del hígado, como cirrosis, hepatitis y otras condiciones hepáticas.'),(21,'Cobertura Alergológica','Cobertura para diagnóstico y tratamiento de enfermedades alérgicas, incluyendo reacciones respiratorias, cutáneas y alimentarias. Incluye pruebas de alergia, consultas médicas y tratamientos farmacológicos.'),(22,'Plan Odontológico','Cobertura integral para el cuidado dental, que incluye prevención, diagnóstico y tratamiento de afecciones como caries, gingivitis y periodontitis. Cubre consultas, limpiezas, endodoncia y ortodoncia.'),(23,'Protección Biliar','Cobertura para enfermedades del sistema biliar, como cálculos biliares y colecistitis. Incluye diagnóstico, cirugía y tratamientos médicos para trastornos hepáticos y biliares.'),(24,'Plan Metabólico','Cobertura para enfermedades metabólicas como diabetes, dislipidemia y síndrome metabólico. Cubre consultas médicas, análisis de sangre, medicamentos y seguimiento a largo plazo.'),(25,'Cobertura Crónicodegenerativa','Cobertura para enfermedades crónicodegenerativas como esclerosis múltiple o Alzheimer. Incluye tratamientos médicos, terapias de rehabilitación y cuidados paliativos.'),(26,'Asistencia Médica Autoinmune','Cobertura para enfermedades autoinmunes como lupus y artritis reumatoide. Ofrece tratamientos inmunosupresores, seguimiento médico y atención especializada.'),(27,'Asistencia Médica Sanguínea','Cobertura para trastornos sanguíneos como leucemia y hemofilia. Cubre diagnósticos, transfusiones, quimioterapia y tratamientos médicos para afecciones hematológicas.'),(28,'Asistencia Médica Inflamatoria','Cobertura para enfermedades inflamatorias crónicas como artritis o enfermedad de Crohn. Incluye tratamiento con medicamentos inmunosupresores y seguimiento médico.'),(29,'Seguro de Cáncer Infantil','Cobertura para diagnóstico y tratamiento de cáncer en niños. Incluye quimioterapia, cirugía, radioterapia y atención paliativa para pacientes pediátricos.'),(30,'Protección Geriátrica','Cobertura para enfermedades en la vejez, como demencia y osteoporosis. Incluye atención médica preventiva, consultas geriátricas y tratamiento para trastornos en la tercera edad.'),(31,'Cobertura de Enfermedades Raras','Cobertura para diagnóstico y tratamiento de enfermedades raras, incluyendo trastornos genéticos y metabólicos poco comunes. Ofrece acceso a tratamientos especializados.'),(32,'Asistencia Médica para Adolescentes','Cobertura para enfermedades en adolescentes, incluyendo trastornos hormonales y problemas de salud mental. Incluye atención médica preventiva y seguimiento especializado.'),(33,'Plan de Salud Dental','Cobertura integral de salud dental que incluye limpieza, endodoncias, ortodoncia y tratamientos de emergencia para mantener una salud bucodental óptima.'),(34,'Protección Cardiaca Preventiva','Cobertura para la prevención de enfermedades cardíacas. Incluye chequeos regulares, análisis preventivos y asesoramiento sobre hábitos saludables para el corazón.'),(35,'Seguro de Diabetes','Cobertura para diagnóstico, monitoreo y tratamiento de la diabetes, incluyendo medicamentos y seguimiento para el control de la enfermedad y prevención de complicaciones.'),(36,'Asistencia Médica para Enfermedades Crónicas','Cobertura para enfermedades crónicas como hipertensión y diabetes. Cubre consultas, medicamentos y hospitalizaciones para el manejo continuo de estas afecciones.'),(37,'Protección Oncológica Preventiva','Cobertura preventiva para la detección y tratamiento de cáncer. Incluye exámenes periódicos, mamografías y análisis genéticos para la prevención del cáncer.'),(38,'Cobertura de Salud Mental Infantil','Cobertura para salud mental infantil, incluyendo tratamiento de trastornos como ansiedad y depresión. Ofrece consultas con psicólogos y psiquiatras infantiles.'),(39,'Plan de Rehabilitación Cardíaca','Cobertura para rehabilitación post-enfermedad cardíaca. Incluye terapia física, seguimiento médico y programas de prevención para la recuperación del corazón.'),(40,'Protección en Emergencias Médicas','Cobertura para emergencias médicas como accidentes y enfermedades repentinas. Ofrece atención inmediata, hospitalización y tratamientos para emergencias graves.'),(41,'Asistencia Médica para Trastornos Alimentarios','Cobertura para trastornos alimentarios como anorexia y bulimia. Incluye tratamiento psicológico, nutrición y seguimiento médico especializado.'),(42,'Seguro de Enfermedades Infectocontagiosas','Cobertura para enfermedades infecciosas como VIH, hepatitis y enfermedades transmitidas por vectores. Incluye diagnóstico, tratamiento y seguimiento médico.'),(43,'Plan de Salud para Embarazadas','Cobertura para la salud durante el embarazo, incluyendo consultas prenatales, análisis, ultrasonidos y atención médica para el parto.'),(44,'Protección en Salud Laboral','Cobertura de salud relacionada con el trabajo, como accidentes laborales y enfermedades profesionales. Incluye consultas médicas, pruebas y tratamientos relacionados con el entorno laboral.'),(45,'Asistencia Médica para Síndromes','Cobertura para síndromes raros y complejos. Ofrece diagnóstico, tratamiento especializado y seguimiento médico continuo para afecciones poco comunes.'),(46,'Seguro de Salud para Estudiantes','Cobertura médica para estudiantes que incluye atención general, emergencias y servicios especializados, promoviendo el bienestar durante su etapa educativa.'),(47,'Plan de Asistencia Médica para Viajeros','Cobertura médica para viajeros, que incluye emergencias médicas, atención en el extranjero, hospitalización y repatriación en caso de enfermedad o accidente.'),(48,'Protección en Salud Reproductiva','Cobertura integral para el cuidado de la salud reproductiva, incluyendo consultas ginecológicas, planificación familiar, tratamientos para infertilidad y atención durante el embarazo.'),(49,'Seguro de Enfermedades Cardíacas Hereditarias','Cobertura especializada para enfermedades cardíacas hereditarias, como arritmias y cardiopatías familiares. Incluye diagnóstico, tratamiento y seguimiento de condiciones genéticas del corazón.'),(50,'Asistencia Médica para Enfermedades Respiratorias Crónicas','Cobertura para el tratamiento y manejo de enfermedades respiratorias crónicas, como EPOC y asma. Incluye consultas, medicación, terapia respiratoria y monitoreo continuo.'),(51,'Protección de Salud Holística','Cobertura que integra enfoques holísticos para la salud, como terapias alternativas, medicina preventiva y bienestar general, abordando cuerpo y mente en un enfoque integral.'),(52,'Cobertura de Salud para Veteranos','Cobertura médica para veteranos, que incluye atención para lesiones de combate, trastornos postraumáticos y cuidados preventivos. Incluye tratamiento médico y psicológico especializado.'),(53,'Plan de Cuidado Paliativo','Cobertura para cuidados paliativos, que incluye alivio del dolor y manejo de síntomas en enfermedades terminales. Ofrece apoyo médico, emocional y psicológico tanto para el paciente como para la familia.'),(54,'Seguro de Salud para Personas con Discapacidad','Cobertura integral para personas con discapacidad, que incluye tratamiento médico, fisioterapia, psicoterapia y asistencia en la integración social y laboral de los pacientes.');
/*!40000 ALTER TABLE `producto_actuarial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_enfermedad`
--

DROP TABLE IF EXISTS `tipo_enfermedad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_enfermedad` (
  `id_tipo_enf` int unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) NOT NULL,
  PRIMARY KEY (`id_tipo_enf`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_enfermedad`
--

LOCK TABLES `tipo_enfermedad` WRITE;
/*!40000 ALTER TABLE `tipo_enfermedad` DISABLE KEYS */;
INSERT INTO `tipo_enfermedad` VALUES (24,'Alergológica'),(28,'Autoinmune'),(26,'Biliar'),(2,'Cardiovascular'),(27,'Crónicodegenerativa'),(5,'Dermatológica'),(6,'Endocrina'),(3,'Gastrointestinal'),(9,'Genética'),(32,'Ginecológica'),(14,'Hematológica'),(23,'Hepática'),(12,'Infecciosa'),(31,'Inflamatoria'),(7,'Inmunológica'),(13,'Metabólica'),(15,'Musculoesquelética'),(4,'Neurológica'),(25,'Odontológica'),(16,'Oftalmológica'),(10,'Oncológica'),(17,'Otorrinolaringológica'),(33,'Proctológica'),(11,'Psiquiátrica'),(18,'Pulmonar'),(19,'Renal'),(1,'Respiratoria'),(8,'Reumatológica'),(29,'Sanguinea'),(21,'Sexual'),(30,'Sistémica'),(20,'Urológica'),(22,'Vascular');
/*!40000 ALTER TABLE `tipo_enfermedad` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-30 20:12:25
