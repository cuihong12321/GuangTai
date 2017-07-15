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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='证件表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificate`
--

LOCK TABLES `certificate` WRITE;
/*!40000 ALTER TABLE `certificate` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='来宾单位';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='部门';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='被访人';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interviewee`
--

LOCK TABLES `interviewee` WRITE;
/*!40000 ALTER TABLE `interviewee` DISABLE KEYS */;
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
INSERT INTO `menu` VALUES (1,'icon-order.png','录单','/ForGround/OrderPage',NULL,NULL,'录单'),(2,'icon-operateorder.png','订单操作','/ForGround/OperateOrderPage',NULL,NULL,'订单操作'),(3,'icon-dispatch.png','派单','/ForGround/DispatchPage',NULL,NULL,'派单'),(4,'icon-auditing.png','审核','/ForGround/AuditingPage',NULL,NULL,'审核'),(5,'icon-factory.png','工厂管理','/BackGround/Factory',NULL,NULL,'工厂管理'),(6,'icon-role.png','权限管理','/AccountManage/Role',NULL,NULL,'权限管理'),(7,'icon-supplier.png','供应商管理','/BackGround/Supplier',NULL,NULL,'供应商管理'),(8,'icon-area.png','区域管理','/BackGround/Area',NULL,NULL,'区域管理'),(9,'icon-balanceunit.png','支付单位管理','/BackGround/Balanceunit',NULL,NULL,'支付单位管理'),(10,'icon-costtype.png','费用类型管理','/BackGround/CostType',NULL,NULL,'费用类型管理'),(11,'icon-currency.png','支付货币货币管理','/BackGround/Currency',NULL,NULL,'支付货币货币管理'),(12,'icon-customer.png','客户信息管理','/BackGround/Customer',NULL,NULL,'客户信息管理'),(13,'icon-user.png','用户管理','/AccountManage/User',NULL,NULL,'用户管理'),(14,'icon-containertype.png','箱型管理','/BackGround/ContainerType',NULL,NULL,'箱型管理'),(15,'icon-driver.png','司机管理','/BackGround/Driver',NULL,NULL,'司机管理'),(16,'icon-rolemenu.png','权限菜单管理','/AccountManage/RoleMenu',NULL,NULL,'权限菜单管理'),(17,'icon-bulkorder.png','散货录单','/BulkCargo/Order',NULL,NULL,'录单'),(18,'icon-bulkoperateorder.png','散货订单操作','/BulkCargo/OperateOrder',NULL,NULL,'订单操作'),(19,'icon-bulkdispatch.png','散货派单','/BulkCargo/Dispatch',NULL,NULL,'派单'),(20,'icon-bulkauditing.png','散货审核','/BulkCargo/Auditing',NULL,NULL,'审核'),(21,'icon-commdity.png','货物类型管理','/BackGround/Commdity',NULL,NULL,'货物类型管理'),(22,'icon-daigong.png','应付对账导出','/ForGround/Report',NULL,NULL,'应付对账导出'),(23,'icon-user.png','账户管理','/AccountManage/Menu',NULL,NULL,'菜单管理');
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
  `companyid` int(11) DEFAULT NULL COMMENT '来访单位id,外键',
  `visitorid` int(11) DEFAULT NULL COMMENT '来访人id,外键',
  `certificateid` int(11) DEFAULT NULL COMMENT '证件id,外键',
  `reason` varchar(2000) DEFAULT NULL COMMENT '来访事由',
  `departmentid` int(11) DEFAULT NULL COMMENT '被访部门id,外键',
  `intervieweeid` int(11) DEFAULT NULL COMMENT '被访人id,外键',
  `ordertime` datetime DEFAULT NULL COMMENT '预约时间',
  `interviewtime` datetime DEFAULT NULL COMMENT '访问时间',
  `operatorid` int(11) DEFAULT NULL COMMENT '操作人员id,外键',
  `operatetime` datetime DEFAULT NULL COMMENT '操作时间',
  `state` int(11) DEFAULT NULL COMMENT '状态：0、未审核，1、已审核',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访客单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'管理员',NULL,NULL),(2,'业务',NULL,NULL),(3,'门卫',NULL,NULL),(4,'操作员',NULL,NULL);
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
INSERT INTO `rolemenu` VALUES (1,1,NULL,NULL),(1,2,NULL,NULL),(1,3,NULL,NULL),(1,4,NULL,NULL),(1,5,NULL,NULL),(1,6,NULL,NULL),(1,7,NULL,NULL),(1,8,NULL,NULL),(1,9,NULL,NULL),(1,10,NULL,NULL),(1,11,NULL,NULL),(1,12,NULL,NULL),(1,13,NULL,NULL),(1,14,NULL,NULL),(1,15,NULL,NULL),(1,16,NULL,NULL),(1,17,NULL,NULL),(1,18,NULL,NULL),(1,19,NULL,NULL),(1,20,NULL,NULL),(1,21,NULL,NULL),(1,22,NULL,NULL),(2,3,NULL,NULL),(2,15,NULL,NULL),(3,1,NULL,NULL),(3,2,NULL,NULL),(3,5,NULL,NULL),(3,7,NULL,NULL),(3,8,NULL,NULL),(3,9,NULL,NULL),(3,10,NULL,NULL),(3,11,NULL,NULL),(3,12,NULL,NULL),(3,14,NULL,NULL),(3,17,NULL,NULL),(3,18,NULL,NULL),(4,1,NULL,NULL),(4,2,NULL,NULL),(4,3,NULL,NULL),(4,4,NULL,NULL),(4,5,NULL,NULL),(4,7,NULL,NULL),(4,8,NULL,NULL),(4,9,NULL,NULL),(4,10,NULL,NULL),(4,11,NULL,NULL),(4,12,NULL,NULL),(4,14,NULL,NULL),(4,15,NULL,NULL),(4,17,NULL,NULL),(4,18,NULL,NULL),(4,19,NULL,NULL),(4,20,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,1,'13815345341','ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413',NULL,NULL,NULL);
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
  `retinue` varchar(200) DEFAULT NULL COMMENT '随行人员',
  `belongings` varchar(200) DEFAULT NULL COMMENT '携带物品',
  `certificatenumber` varchar(50) DEFAULT NULL COMMENT '证件号码',
  `transport` varchar(50) DEFAULT NULL COMMENT '交通工具',
  `carnumber` varchar(50) DEFAULT NULL COMMENT '车牌号码',
  `replacement` varchar(50) DEFAULT NULL COMMENT '换证物品',
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='访客表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitor`
--

LOCK TABLES `visitor` WRITE;
/*!40000 ALTER TABLE `visitor` DISABLE KEYS */;
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

-- Dump completed on 2017-07-15  5:52:00
