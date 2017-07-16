-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: guangtai
-- ------------------------------------------------------
-- Server version	5.7.16-log

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
-- Table structure for table `c3p0testtable`
--

DROP TABLE IF EXISTS `c3p0testtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `c3p0testtable` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c3p0testtable`
--

LOCK TABLES `c3p0testtable` WRITE;
/*!40000 ALTER TABLE `c3p0testtable` DISABLE KEYS */;
/*!40000 ALTER TABLE `c3p0testtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certificate`
--

DROP TABLE IF EXISTS `certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '证件名称',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='证件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate`
--

LOCK TABLES `certificate` WRITE;
/*!40000 ALTER TABLE `certificate` DISABLE KEYS */;
INSERT INTO `certificate` VALUES (1,'身份证','2017-07-15 08:29:17','测试');
/*!40000 ALTER TABLE `certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `name` varchar(50) DEFAULT NULL COMMENT '单位名称',
  `address` varchar(200) DEFAULT NULL COMMENT '单位地址',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='来宾单位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES (1,'苏宁','苏州苏宁','2017-07-15 08:22:43','测试');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='部门';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'财务部','2017-07-15 09:06:27','测试');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interviewee`
--

DROP TABLE IF EXISTS `interviewee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interviewee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `departmentid` int(11) DEFAULT NULL COMMENT '部门id,外键',
  `name` varchar(50) DEFAULT NULL COMMENT '被访人名称',
  `telephone` varchar(50) DEFAULT NULL COMMENT '被访人电话',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `fk_interviewee_departmentid_idx` (`departmentid`),
  CONSTRAINT `fk_interviewee_departmentid` FOREIGN KEY (`departmentid`) REFERENCES `department` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='被访人';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interviewee`
--

LOCK TABLES `interviewee` WRITE;
/*!40000 ALTER TABLE `interviewee` DISABLE KEYS */;
INSERT INTO `interviewee` VALUES (1,1,'小张','13655208270','2017-07-15 09:24:56','测试');
/*!40000 ALTER TABLE `interviewee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `icon` varchar(2000) DEFAULT NULL COMMENT '菜单图标',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(2000) DEFAULT NULL COMMENT '菜单链接',
  `parentid` int(11) DEFAULT NULL,
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='菜单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'','预约管理','',0,NULL,'预约管理'),(2,'icon-order.png','录单','/ForGround/InsertOrder',1,NULL,'录单'),(3,'icon-operateorder.png','操作','/ForGround/OperateOrder',1,NULL,'操作'),(4,'icon-auditing.png','审核','/ForGround/CheckOrder',1,NULL,'审核'),(5,NULL,'访客管理','',0,NULL,'访客管理'),(6,'icon-factory.png','来宾管理','/BackGround/Visitor',5,NULL,'来宾管理'),(7,'icon-area.png','来宾单位管理','/BackGround/Company',5,NULL,'来宾单位管理'),(8,'icon-supplier.png','证件管理','/BackGround/Certificate',5,NULL,'证件管理'),(9,'','受访管理','',0,NULL,'受访管理'),(10,'icon-costtype.png','被访人管理','/BasicManage/Interviewee',9,NULL,'被访人管理'),(11,'icon-balanceunit.png','部门管理','/BasicManage/DepartMent',9,NULL,'部门管理'),(12,NULL,'账户管理','',0,'2017-07-16 20:31:41','账户管理'),(13,'icon-user.png','用户管理','/AccountManage/User',12,NULL,'用户管理'),(14,'icon-role.png','角色管理','/AccountManage/Role',12,NULL,'角色管理'),(15,'icon-user.png','菜单管理','/AccountManage/Menu',12,NULL,'菜单管理'),(16,'icon-rolemenu.png','权限管理','/AccountManage/RoleMenu',12,NULL,'权限管理');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `visitorid` int(11) DEFAULT NULL COMMENT '来访人id,外键',
  `intervieweeid` int(11) DEFAULT NULL COMMENT '被访人id,外键',
  `reason` varchar(2000) DEFAULT NULL COMMENT '来访事由',
  `retinue` varchar(200) DEFAULT NULL COMMENT '随行人员',
  `belongings` varchar(200) DEFAULT NULL COMMENT '携带物品',
  `transport` varchar(50) DEFAULT NULL COMMENT '交通工具',
  `replacement` varchar(50) DEFAULT NULL COMMENT '换证物品',
  `visitornumber` varchar(50) DEFAULT NULL COMMENT '访客证号',
  `ordertime` datetime DEFAULT NULL COMMENT '预约时间',
  `interviewtime` datetime DEFAULT NULL COMMENT '访问时间',
  `cometime` datetime DEFAULT NULL COMMENT '进厂时间',
  `leavetime` datetime DEFAULT NULL COMMENT '出厂时间',
  `operatorid` int(11) DEFAULT NULL COMMENT '操作人员id,外键',
  `operatetime` datetime DEFAULT NULL COMMENT '操作时间',
  `state` int(11) DEFAULT NULL COMMENT '状态：0、已预约，1、未审核,2、已审核',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='访客单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (2,2,1,'朋友看望','小王妹妹','一箱苹果','自驾','无','无','2017-07-15 21:36:03','2017-07-15 21:36:05','2017-07-15 21:36:10','2017-07-15 21:36:12',NULL,'2017-07-16 21:41:02',0,'测试'),(3,2,1,'23123','123232','423432','23423','432423','423432','2017-07-16 18:30:16','2017-07-16 18:30:16','2017-07-16 22:08:33','2017-07-16 18:30:16',NULL,'2017-07-16 22:09:02',1,'213213'),(4,2,1,'123123','12312','12312','31232','12312','3123123','2017-07-16 18:31:54','2017-07-16 18:31:55','2017-07-16 18:31:58','2017-07-16 18:32:01',NULL,'2017-07-16 22:10:24',1,'123123');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'管理员','2017-07-15 09:52:22','测试'),(2,'业务',NULL,NULL),(3,'门卫',NULL,NULL),(5,'操作工','2017-07-15 09:52:51','测试');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolemenu`
--

DROP TABLE IF EXISTS `rolemenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rolemenu` (
  `roleid` int(11) NOT NULL COMMENT '角色id,外键',
  `menuid` int(11) NOT NULL COMMENT '菜单id,外键',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`roleid`,`menuid`),
  KEY `fk_rolemenu_menuid_idx` (`menuid`),
  CONSTRAINT `fk_rolemenu_menuid` FOREIGN KEY (`menuid`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolemenu_roleid` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolemenu`
--

LOCK TABLES `rolemenu` WRITE;
/*!40000 ALTER TABLE `rolemenu` DISABLE KEYS */;
INSERT INTO `rolemenu` VALUES (1,1,NULL,NULL),(1,2,NULL,NULL),(1,3,NULL,NULL),(1,4,NULL,NULL),(1,5,NULL,NULL),(1,6,NULL,NULL),(1,7,NULL,NULL),(1,8,NULL,NULL),(1,9,NULL,NULL),(1,10,NULL,NULL),(1,11,NULL,NULL),(1,12,NULL,NULL),(1,13,NULL,NULL),(1,14,NULL,NULL),(1,15,NULL,NULL),(1,16,NULL,NULL),(2,2,'2017-07-15 16:13:29','管理员授权'),(2,5,'2017-07-15 16:13:30','管理员授权'),(2,6,'2017-07-15 16:13:30','管理员授权'),(2,7,'2017-07-15 16:13:30','管理员授权'),(2,8,'2017-07-15 16:13:31','管理员授权'),(2,9,'2017-07-15 16:13:31','管理员授权'),(2,10,'2017-07-15 16:13:31','管理员授权'),(2,11,'2017-07-15 16:13:32','管理员授权');
/*!40000 ALTER TABLE `rolemenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `roleid` int(11) DEFAULT NULL COMMENT '角色id,外键',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `password` varchar(200) DEFAULT NULL COMMENT '密码',
  `telephone` varchar(50) DEFAULT NULL COMMENT '用户电话',
  `updatetime` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `fk_uer_roleid_idx` (`roleid`),
  CONSTRAINT `fk_uer_roleid` FOREIGN KEY (`roleid`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'13815345341','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413','13815345341','2017-07-16 22:34:57','13815345341'),(2,2,'小王','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',NULL,NULL,NULL),(3,1,'admin','3c9909afec25354d551dae21590bb26e38d53f2173b8d3dc3eee4c047e7ab1c1eb8b85103e3be7ba613b31bb5c9c36214dc9f14a42fd7a2fdb84856bca5c44c2','123','2017-07-16 22:37:42','123');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitor`
--

DROP TABLE IF EXISTS `visitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id,自增',
  `certificateid` int(11) DEFAULT NULL COMMENT '证件id,外键',
  `companyid` int(11) DEFAULT NULL COMMENT '单位id,外键',
  `name` varchar(50) DEFAULT NULL COMMENT '来宾名称',
  `certificatenumber` varchar(50) DEFAULT NULL COMMENT '证件号码',
  `transport` varchar(50) DEFAULT NULL COMMENT '交通工具',
  `carnumber` varchar(50) DEFAULT NULL COMMENT '车牌号码',
  `visitornumber` varchar(50) DEFAULT NULL COMMENT '访客证号',
  `telephone` varchar(50) DEFAULT NULL COMMENT '访客电话',
  `cometime` datetime DEFAULT NULL COMMENT '进厂时间',
  `leavetime` datetime DEFAULT NULL COMMENT '出厂时间',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `fk_visitor_certificateid_idx` (`certificateid`),
  KEY `fk_visitor_companyid_idx` (`companyid`),
  CONSTRAINT `fk_visitor_certificateid` FOREIGN KEY (`certificateid`) REFERENCES `certificate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_visitor_companyid` FOREIGN KEY (`companyid`) REFERENCES `company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='访客表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
INSERT INTO `visitor` VALUES (2,1,1,'小王','32072419921119631X','自行车','无','无','13655208270','2017-07-15 00:00:00','2017-07-15 00:00:00',NULL);
/*!40000 ALTER TABLE `visitor` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-16 22:39:23
