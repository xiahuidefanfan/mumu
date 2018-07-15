/*
SQLyog Ultimate v12.3.1 (64 bit)
MySQL - 5.7.20-log : Database - mumu
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mumu` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `mumu`;

/*Table structure for table `act_evt_log` */

DROP TABLE IF EXISTS `act_evt_log`;

CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_evt_log` */

/*Table structure for table `act_ge_bytearray` */

DROP TABLE IF EXISTS `act_ge_bytearray`;

CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_bytearray` */

insert  into `act_ge_bytearray`(`ID_`,`REV_`,`NAME_`,`DEPLOYMENT_ID_`,`BYTES_`,`GENERATED_`) values 
('2',1,'E:\\xiahui\\tools\\eclipse\\workspace\\mumu-parent\\mumu-admin\\target\\classes\\processes\\ExpenseProcess.bpmn20.xml','1','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:flowable=\"http://flowable.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" typeLanguage=\"http://www.w3.org/2001/XMLSchema\" expressionLanguage=\"http://www.w3.org/1999/XPath\" targetNamespace=\"http://www.flowable.org/processdef\">\n  <process id=\"Expense\" name=\"ExpenseProcess\" isExecutable=\"true\">\n    <documentation>Êä•ÈîÄÊµÅÁ®ã</documentation>\n    <startEvent id=\"start\" name=\"ÂºÄÂßã \"></startEvent>\n    <userTask id=\"task_apply\" name=\"Êä•ÈîÄÁî≥ËØ∑\" flowable:assignee=\"${taskUser}\">\n      <extensionElements>\n        <modeler:initiator-can-complete xmlns:modeler=\"http://flowable.org/modeler\"><![CDATA[false]]></modeler:initiator-can-complete>\n      </extensionElements>\n    </userTask>\n    <exclusiveGateway id=\"judgeTask\"></exclusiveGateway>\n    <userTask id=\"financial_aduit\" name=\"Ë¥¢Âä°ÂÆ°Êâπ\">\n      <extensionElements>\n        <flowable:taskListener event=\"create\" class=\"com.mumu.modular.flowable.handler.FinancialManagerTaskHandler\"></flowable:taskListener>\n      </extensionElements>\n    </userTask>\n    <userTask id=\"boss_aduit\" name=\"ËÄÅÊùøÂÆ°Êâπ\">\n      <extensionElements>\n        <flowable:taskListener event=\"create\" class=\"com.mumu.modular.flowable.handler.BossTaskHandler\"></flowable:taskListener>\n      </extensionElements>\n    </userTask>\n    <endEvent id=\"end\" name=\"ÁªìÊùü\"></endEvent>\n    <sequenceFlow id=\"flow1\" sourceRef=\"start\" targetRef=\"task_apply\"></sequenceFlow>\n    <sequenceFlow id=\"directorNotPassFlow\" name=\"È©≥Âõû\" sourceRef=\"financial_aduit\" targetRef=\"task_apply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${check==\'unpass\'}]]></conditionExpression>\n    </sequenceFlow>\n    <userTask id=\"leader_aduit\" name=\"‰∏äÁ∫ßÂÆ°Êâπ\">\n      <extensionElements>\n        <flowable:taskListener event=\"create\" class=\"com.mumu.modular.flowable.handler.LeaderTaskHandler\"></flowable:taskListener>\n      </extensionElements>\n    </userTask>\n    <sequenceFlow id=\"bossPassFlow\" name=\"ÈÄöËøá\" sourceRef=\"boss_aduit\" targetRef=\"end\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${check==\'pass\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"directorPassFlow\" name=\"ÈÄöËøá\" sourceRef=\"financial_aduit\" targetRef=\"end\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${check==\'pass\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"bossNotPassFlow\" name=\"È©≥Âõû\" sourceRef=\"boss_aduit\" targetRef=\"task_apply\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${check==\'unpass\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-40CA5399-C2F3-4010-BC55-D9C614BCB804\" sourceRef=\"task_apply\" targetRef=\"leader_aduit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${check == \'pass\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sid-41991491-BDF9-4E17-A47A-662FFD8D4302\" sourceRef=\"leader_aduit\" targetRef=\"judgeTask\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${check == \'pass\'}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"judgeMore\" name=\"Â§ß‰∫é500ÂÖÉ\" sourceRef=\"judgeTask\" targetRef=\"boss_aduit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${money > 500}]]></conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"judgeLess\" name=\"Â∞è‰∫é500ÂÖÉ\" sourceRef=\"judgeTask\" targetRef=\"financial_aduit\">\n      <conditionExpression xsi:type=\"tFormalExpression\"><![CDATA[${money <= 500}]]></conditionExpression>\n    </sequenceFlow>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_Expense\">\n    <bpmndi:BPMNPlane bpmnElement=\"Expense\" id=\"BPMNPlane_Expense\">\n      <bpmndi:BPMNShape bpmnElement=\"start\" id=\"BPMNShape_start\">\n        <omgdc:Bounds height=\"30.0\" width=\"30.0\" x=\"135.0\" y=\"130.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"task_apply\" id=\"BPMNShape_task_apply\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"255.0\" y=\"105.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"judgeTask\" id=\"BPMNShape_judgeTask\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"585.0\" y=\"125.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"financial_aduit\" id=\"BPMNShape_financial_aduit\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"735.0\" y=\"105.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"boss_aduit\" id=\"BPMNShape_boss_aduit\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"555.0\" y=\"240.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"end\" id=\"BPMNShape_end\">\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"771.0\" y=\"266.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape bpmnElement=\"leader_aduit\" id=\"BPMNShape_leader_aduit\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"420.0\" y=\"105.0\"></omgdc:Bounds>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge bpmnElement=\"flow1\" id=\"BPMNEdge_flow1\">\n        <omgdi:waypoint x=\"164.94999923927443\" y=\"145.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"254.9999999999684\" y=\"145.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-40CA5399-C2F3-4010-BC55-D9C614BCB804\" id=\"BPMNEdge_sid-40CA5399-C2F3-4010-BC55-D9C614BCB804\">\n        <omgdi:waypoint x=\"354.94999999998356\" y=\"145.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"419.99999999998465\" y=\"145.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"judgeLess\" id=\"BPMNEdge_judgeLess\">\n        <omgdi:waypoint x=\"624.9444614102993\" y=\"145.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"735.0\" y=\"145.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"directorNotPassFlow\" id=\"BPMNEdge_directorNotPassFlow\">\n        <omgdi:waypoint x=\"785.0\" y=\"105.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"785.0\" y=\"37.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"305.0\" y=\"37.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"305.0\" y=\"105.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"bossPassFlow\" id=\"BPMNEdge_bossPassFlow\">\n        <omgdi:waypoint x=\"654.9499999999999\" y=\"280.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"771.0\" y=\"280.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"judgeMore\" id=\"BPMNEdge_judgeMore\">\n        <omgdi:waypoint x=\"605.0\" y=\"164.9426165803109\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"605.0\" y=\"240.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"directorPassFlow\" id=\"BPMNEdge_directorPassFlow\">\n        <omgdi:waypoint x=\"785.0\" y=\"184.95\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"785.0\" y=\"266.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"bossNotPassFlow\" id=\"BPMNEdge_bossNotPassFlow\">\n        <omgdi:waypoint x=\"554.9999999999452\" y=\"280.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"305.0\" y=\"280.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"305.0\" y=\"184.95\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge bpmnElement=\"sid-41991491-BDF9-4E17-A47A-662FFD8D4302\" id=\"BPMNEdge_sid-41991491-BDF9-4E17-A47A-662FFD8D4302\">\n        <omgdi:waypoint x=\"519.95\" y=\"145.0\"></omgdi:waypoint>\n        <omgdi:waypoint x=\"585.0\" y=\"145.0\"></omgdi:waypoint>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',0),
('2504',1,'hist.var-money',NULL,'¨Ì\0sr\0java.math.BigDecimalT«W˘Å(O\0I\0scaleL\0intValt\0Ljava/math/BigInteger;xr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0sr\0java.math.BigIntegerå¸ü©;˚\0I\0bitCountI\0	bitLengthI\0firstNonzeroByteNumI\0lowestSetBitI\0signum[\0	magnitudet\0[Bxq\0~\0ˇˇˇˇˇˇˇˇˇˇˇ˛ˇˇˇ˛\0\0\0ur\0[B¨Û¯T‡\0\0xp\0\0\0,xx',NULL),
('28',1,'hist.var-money',NULL,'¨Ì\0sr\0java.math.BigDecimalT«W˘Å(O\0I\0scaleL\0intValt\0Ljava/math/BigInteger;xr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0sr\0java.math.BigIntegerå¸ü©;˚\0I\0bitCountI\0	bitLengthI\0firstNonzeroByteNumI\0lowestSetBitI\0signum[\0	magnitudet\0[Bxq\0~\0ˇˇˇˇˇˇˇˇˇˇˇ˛ˇˇˇ˛\0\0\0ur\0[B¨Û¯T‡\0\0xp\0\0\0Mxx',NULL),
('3',1,'E:\\xiahui\\tools\\eclipse\\workspace\\mumu-parent\\mumu-admin\\target\\classes\\processes\\ExpenseProcess.Expense.png','1','âPNG\r\n\Z\n\0\0\0\rIHDR\0\0M\0\0J\0\0\0¡ô¥Ω\0\0\'IDATx⁄Ì›MlTÁΩ`Z±»¢ã,∫»¢ãH7“≠‘E6,≤Ë¬™∫`A’Hç5å«MF4≤€BRL)¢í¥®§®Bu+%®TU⁄‹B!ì:\\úÿ>äA–D	%B	\\ì`O∞M;ÖxL¿>˜º»Mç«ﬂcüÒ<èÙä÷c\'—ô?øw~>sŒ,[\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0@r≠^Ω:≤,À≤,k·óW!\0Tö\0∞ˇ ¥¿˛Ä–\0˚/\0B\0Ïø\0m\0∞ˇ ¥¿˛Ä–\0Ïø\0B\0∞ˇm\0¿˛ ¥\0˚/\0B\0Ïø\0m\0∞ˇ ¥¿˛Ä–\0˚/\0B\0Ïø\0m\0∞ˇ⁄Ñ6\0`ˇ⁄\0Ä˝@h\0ˆ_\0°\r\0ÿ⁄\0`ˇ@hÄ˝\0°\r\0ˆ_\0Ñ6\0ÿ⁄\0`ˇ@h\0ˆ_\0°\r\0ÿÑ6\0`ˇ⁄\0Ä˝\0°\r\0ˆ_\0Ñ6\0ÿ⁄\0`ˇ@hÄ˝\0°\r\0ˆ_\0Ñ6\0ÿ\0°\r\0ÿÑ6\0`ˇ⁄\0Ä˝@h\0ˆ_\0Ñ6\0ÿ⁄\0`ˇ@hÄ˝\0°\r\0ˆ_\0Ñ6\0ÿ⁄\0Ä˝@h\0ˆ_\0°\r\0ÿÑ6\0`ˇ@hÄ˝\0°\r\0ˆ_\0Ñ6\0ÿ⁄\0PÒ˙˙˙~–‹‹≈{›éÄ“\0â¢ËéO?˝t 544ºÍà\0(M\0@ëÓÓÓøDc:;;sÈt˙~G@i\0b◊Æ]ªwddd4*≤uÎ÷Ól6{ß£†4@’ÎÌÌÌä∆ÏÕd2øut\0î&\0®jó.]⁄ï–“““Ô«+%Äd§÷Pí¶Xß)\0ò?q/∫kxx¯ãR•ittÙzSS”ôöööÂé¿‚ó¶Ò∫1YiJ•R´)\0ò?===\'¢)tuuuß”Èıé@2ä”ÅIJ”	øÂÄ˘u¸¯Ò©:SîœÁáΩ8õÕﬁ·à,~iZQ™4πÌ)\0ÃøßûzjÌdoœùi„∆çs¶	 Y≈i¢kõN;À\0Â±gœû˜J5¶.º‡›\0…+M∑]€‰Z&\0(ü⁄⁄⁄{‚rîü‡&g3ôÃYwœH†∏$µ8À\0g˚ˆÌøãK“Hqi⁄µk◊„=yá£êÃ“t_—µL+\0(Ø ∂∂∂˛¢∂˝kºüœf≥w::\0	U∏∂…Y&\0XÎ÷≠˚Œ¿¿¿pº¢ÜÜÜ7aH~i∫u\'=G\0ŒŒù;477áÎâ[\r`Iã¢hyWW◊À\'Oû9x`‘ﬁﬁ^ë+î¶J˝oÔËËàé=˙qºÍM‰“ô…J^fd›t÷˛˝˚oÌø{˜Óïu¿“˚ÿ±cQt˝˙ukë÷ï+W¢#Gé|¯f“LöIêuï≤rπú¨ñæ./N‹◊€€€œôI3i&A÷Y≤Hêñ\0Åôúáˆ\r3i&Õ$»:K÷	ﬁ”+,⁄ëô4ìfdù%ÎÄ\nÌkÉó£Æ”äﬁÌxˆ÷\nˇ;|M–\nm3i&Y\'ÎÄ™Ì´πËÏkõ£wˆ?Ò+|-<&lÖ∂ô4ìÄ¨ìu@Uáv˜ªø-∞´Á›Va+¥Õ§ôdù¨™;¥œΩÒ\\…–è	[°m&Õ$ ÎdP’°}∂˝Èí°∂B€LöI@÷…:@hm°m&Õ$ Îd ¥\'^·n=•B;<&lÖ∂ô4ìÄ¨ìu@Uáˆ˘„ø/⁄·1a+¥Õ§ôdù¨™:¥?…ùâŒææÂˆ∑ƒ_è	[°m&Õ$ ÎdP’°÷≈˛˘∂–_¥B€LöI@÷…:@hGÁ;üø˝≠Ò◊¬c¬VhõI3	»:YTmháOˇ¯ÔJæß:<ÊS…Ö∂ô4ìÄ¨ìu@ıÖˆpt˘¸°Ë_mKvaÖÔ	ﬂÎ∑^B€LöI@÷…:†*B{™ﬂn˘≠ó–6ìfêu≤®Í–ûŒo∑&˚≠ó⁄f“L2©;dù¨*<¥gÿÖ%|Ö∂ô4ìî¥2^—ÿü»:Y\'ÎÄJ\rmKhõIÀLñ≈w„5ØcÆrHdù%Î\0°m	m3i&˘œ¬T(J·L”≈I÷Y≤⁄ñ–6ìfí€”T_G÷Y≤⁄ñ–6ìf≤j¨ú¢wçì¨≥dK]Ewú9s¶Ò≈_<≤m€∂œ}Ù—Ÿl6ZΩzuT__?˙ìü¸‰˙œ˛ÛÆÁû{Ó•x˝∑#&¥-°m&Õd¶©\në3N≤Œíu,ı≤¥wÔﬁ?ˇ‚ø∏±~˝˙hÁŒù—…ì\'£\\.ÂÛ˘(ˆ˜˜Goæ˘fó™Ëg?˚ŸhSS”\r\r\r;ÇB€⁄f“L.Qﬂ]6≥3H3˝~dù%Î®q9ZÛÀ_˛r¯â\'û∏UànﬁºM◊€oø=˘‰ì7œ’÷÷ﬁ„h\nmKhõI3π”™Y¸‹U≈I÷Y≤é% Ó<À_yÂïC?˛Òè£÷÷÷ï•Ò⁄⁄⁄¢5k÷9Î$¥-°m&Õdï¶˘˙ydù%ÎHBa:|¯©Gy$zˇ˝˜£˘¡Dqz¯·á◊:¬B[hm3i&+ÿT7}XË≤Œíu,ÜpÜ)¶pç“|\nˇºÜÜÜ´Èt∫ﬁQ⁄B€Lö3Y¡ÖiæﬁZÁåì¨≥dï(\\√ﬁí7_gò&:„Ù‡Éƒ≈Èõé∂–⁄f“2ìd¸MæØá∆˛úâÒ?ÁÊ≤ŒíuTípóºgü}ˆz∏Ü©úˆÔﬂ?î…dN8‚B[hõIÀLVXaZUT|˛∂Œ±?ß[úJ˝ú‚$Î,YG•hii˘üpóº/æ¯\"*∑ü˛ÙßΩﬁ¶\'¥Ö∂ô¥Ãd¶ecgä¢¢5ù‚T\\ò\nÎ¡¢«]„$Î,YG%úe\nü√n+æﬁyÁùÎŒ6	m°=±öööÂf“2ìâP™»LTÄ&+N}ˇÆ	æﬂ5N≤ŒRöH≤3gŒ4Üõ?ÃÂ÷‚3µfÕöﬁ’´WﬂÌËœ^:ùnè◊∑Öˆ“Ì¯Ø≈]===\'é?m⁄¥È±J|°j&Õd•Œ‰$ÖiÂä–D≈i∫Öi|qÚV=Yg)M$Õã/æxd◊Æ]—B⁄±c«€qiz‹—üΩ¯¯EaÖN•R˜	Ì \rÌKó.mŒÁÛ7\n?Üááøÿ≥gœ˘µk◊~ÀLZf≤¸39À‚2Uqöia*˛˜_q∆I÷YJ	≥m€∂œNû<π†•©≥≥ÛÉ8pZ˝πáv—:0—oæÑvrC˚⁄µk˜ˆıı}PÍÔ…≈ãÛÒﬂœ≤ŸÏf“2ìÂõ…	\n”tK©‚Ù’Y¶Òg∫\'Yg)M$≈£è>z„ÚÂÀZöz{{˚„êÈvÙÁ5¥ø¸ÕWqxÌ‰Öv∏é∞ªª˚/###£S˝]ikk˚∏©©È{f“2ìÂô…Y¶…ä”{s(Ls˝ÔA÷YJÂêÕf£|>ø†•)¸˚‚Ä…;˙Û⁄≈ø˘\no⁄…ZßNùä?õÈﬂôÅÅÅ·Áü˛`º!›LZfr~grŒÏLTúÊRò∆\'◊8…:Ki\"	˘√4B«öá%¥ì≥rπ\\‘‹‹^lF≥xÅzÎgÕ§e&À≥‚Ìp«∑”ØNpÜÈΩ±Øœ≈{ô¨≥î&‡°á\Z]Ë3MCCCΩŒ4ïÌ7]ßS©‘™¬ùÆÑv≤÷æ}˚¢ÜÜÜW;;;/èééNÎñïÉÉÉmll|#~^[í|◊I3i&+u&óM}∑ºπúiö…‡:”dˇµî&íÍëGπæ–◊4}Ù—GÔπ¶iﬁC{¸ãÄeIÌ/*ÏÒ§Ñv:ùæˇôgûÈËü‰⁄ë≥;wÓ¸C¸‹ûﬂo&Õ§ô,œLî´À sM”läìködù¨SöHíÕõ7ü_ËªÁΩˆ⁄kˇÎÓyÛ⁄\'¬ãóRü°íƒ–ûÏkÂ~<I°][[˚µL&Û€Ω{˜ˆèåå_ˆw·¬Ö‚«Œ∆Òél6{ßô4ìf≤|39á3;•n+>—›ÛfRú‹=O÷…:•â§Ÿæ}˚ÆÖ˛ú¶-[∂Ï˜9MsÌ…~c*¥+(¥„ÁrESS”ôÆÆÆ‹–––ëç7˛-l∆·Îf“Lö…Úœ‰,œLı9L”˝\0‹Ò¬1ˆ9M≤N÷)M$Õ¶Mõ˛k›∫u#7oﬁ\\∞õÁ’’’˝_íﬂøîÌ Ì∞˘¶”Èıc∑≠]?√yf“Lö…˘5’ôûÈ~pÌLãS·-Ç˜€Ωdù¨SöH†\r6\\xÛÕ7Í≠y/≈õ1G]hÌâ_®öI3i&°‘ßÈ¶ôß¬øOaíu≤Ni\"©~Ù£’>ˆÿc7‡l”@]]›[Èt∫ﬁQ⁄B€LöI3Ygú∆øUÓ°e3ˇ¶âä”É38≥Ö¨ìu≤é§hll<”⁄⁄Z÷∆Æü\ngô™¯7óB[h+Mf“LV^q*æ9Dqö…◊ñ˙9∑óu≤N÷QI¬5Fk÷¨zˇ˝˜ÀRòŒú9ÛJ¸Ô∏úNßøÈhWwh/sÀS3i&ÕdeˇVΩØåù)öÈmƒ«ˇ‹\\?\nY\'Îdã°ææ>”ÿÿ¯yˇº¶ûûû‘’’}ËmyB€áÎ	m3i&óHqö´âﬁ˙á¨≥dï\"ì…¨ihh∏:_gú¬¶PòR©‘ìéÆ–⁄B€LöI≈…◊ :K÷±$ƒgu}}˝g˚ˆÌª6áõC¸Ê7ø˘SxK^º≤é™–∂Ñ∂ô4ìK¿\\ﬂRÁ-y≤Œíu,%·\Zß∫∫∫ÉçççΩoΩı÷–L>áÈı◊_ﬂóÆ”·¶Æa⁄ñ–6ìfrâßôû)r”Yg…:ñpyz îßl6€øm€∂wˇÒè|òÀÂ.ÁÛ˘[\rihh®˜£è>zØ££„’ßü~˙@&ìÈ\ne)ú]ró<°m	m3i&ó®ôæ≈Œ[Údù%Î®q˙∆ÿß√øØãÒ áOä˚≥;^≠Òz<ú°r¥Ñ∂%¥Õ§ôTúæ¥\"^Wó˘‡ZYg…:@h[B€Lö…*¥r¨≠ú‰Ò+\nì¨≥d ¥-°m&Õd5+u∆…[Údù%Î\0°m	m3i&)Qê&Y\'cd ¥-°m&Õ$%ä”Ö	Y\'Î\0°m	m3i&ôÿ pì§en+nˇïu≤⁄ñ–6ìfíâçï&dùåëuÄ–∂Ñ∂ô4ì(M»:YmKhõI3â“Ñ¨ìuÄ–∂Ñ∂ô4ì(M»:YmKhõIÀL*M»:Y ¥Ö∂ô¥Ã§“Ñ¨≥d ¥Ö∂ô¥Ã§“Ñ¨≥d ¥Ö∂ô¥Ã§“Ñ¨≥d ¥Ö∂ô¥Ã§“Ñ¨≥d ¥-°m&Õ§“Ñ¨≥d ¥-°m&Õ$J≤N÷B€⁄f“L¢4!Îd ¥-°m&Õ$J≤N÷B€⁄f“2ìJ≤N÷m°m&-3©4!Î,Ym°m&-3©4!Î,YÃ⁄¡ÉÖerV>Ìf“LöI•	Yg…: Aé=zπøø_`&`Ârπ=qhü3ìf“L*M»:K÷	rË–°Ô>|x∞ØØoHp.ﬁo∏B`wtt|ØÃ§ô4ìJ≤ÆÇ\ná¨™C´⁄€€OáS”·=Ωï∂vÔﬁÖ!ï¯ﬂ>∂¬q?\'∞óŒL.Åe&ï&d›îÎ‘©SQsss‘““\"Î\0*‡HkxRSS≥‹—\0î&(ø(äÓ¯Ù”ObQCC√´é@Ç•R©˚‚ 7¬ãêt:Ω“î&(øÓÓÓøDc:;;sÒ|ø£ê‹“‘^Äå≠”é†4Ay]ªvÌﬁëëë—®»÷≠[ª≥ŸÏùé@Ú^x¨(úe*¨∏D≠rd\0•	 ß∑∑∑+\Zgpp∞7ì…¸÷—Hﬁè÷‚¬T8€‰⁄&@iÇÚ∏tÈ“Ê®ÑñññﬁMG	 9/:n;ÀTXﬁW\r(M0ˇ‚^t◊•J”ËËËı¶¶¶3~y	êú&*LcÎÑ#(M0øzzzNDSËÍÍÍNß”Î-Ä≈¡QÚ,ìkõ\0•	 „¯Ò„Su¶(üœ3ûÕfÔpƒ\0˜GÎdÖ…ùÙ\0•	ÊﬂSO=µv≤∑ÁÖŒ¥q„∆ø9”‡EÄº¢jÌŸ≥ÁΩRçÈ¬Ö/Ñ∑»ª¶	¿ã\0yE’™≠≠Ω\'.G˘	nq6ì…úu˜<\0/B\0‰Uo˚ˆÌøãK“Hqi⁄µk◊S©‘G¿ã\0yE’oøkkkÎ/˙`€ø∆s}>õÕﬁÈË\0x Ø ∂n›∫Ô«+jhhËâ\0^Ñ\0»+gÁŒùöõõ√«|¥8\Z\0^Ñ\0»+\'º/Ãs∏9Ñ£‡EÄºÛ ¥‰òg\0°\r Ø¿<m\0yÊ\0°\r»+0œ\0m@^Åy@hÚ\nÃ3\0B@^aû⁄\0Ú\nÛÄ–êW`ûÑ6ÄºÛ ¥‰òg\0°\r Ø¿<m°\r»+0œ\0m@^Åy@hÚ\nÃ3\0BêW`û⁄\0Ú\nÛÄ–êWòg\0Ñ6ÄºÛ ¥‰òg\0°\r Ø¿<m\0yÊ\0°\r»+0œ\0m@^Åy@hÚ\nÃ3\0B@^aû⁄\0Ú\nÛÄ–ò^6µÜ|öbùv§∞ˇ ¥ÅjÕ¶Ò∫1YiJ•R´)Ïø\0m†öÛÈ¿$•ÈDMMÕrG	˚/\0B®Ê|ZQ™4•”È˚!Ïø\0m@FM|m”igô∞ˇ ¥ñM|mìkô∞ˇ ¥äƒ%©≈Y&Ïø\0mÄ“•Èæ¢kôV:\"ÿ⁄\0∑g’≠kõúe¬˛Ä–ò8´V»+Ïø\0m†,¢(Zﬁ’’ıÚ…ì\'G<µ∑∑[º:::¢£Gè~Øzâ˝@h	\n”±c«¢˛˛˛Ë˙ıÎ÷\"≠+WÆDGé˘,.PòJÏø\0BHêpÜIaJLq∫ﬁﬁﬁ~ŒTbˇ⁄@ÇÑ∑‰),…Yqi∫a*±ˇm A¬55 J¢Jì‹≈˛ ¥ÅJ,M◊/G]ßˇΩ€ÒÏ≠˛w¯ö¢£4aˇ⁄@’ó¶´πËÏkõ£wˆ?Ò+|-<¶Ï(MÿÑ6P’•©˚›øﬂVò\n´Á›VeGi¬˛ ¥ÅÍ.MÁﬁxÆdi\nè);Jˆ_\0°\rTui:€˛t…“Svî&Ïø\0BPöî&•	˚/\0Bî¶âW∏[^©“Svî&Ïø\0B®Í“t˛¯ÔKñ¶ò≤£4aˇ⁄@Uó¶Org¢≥Øoπ˝≠yÒ◊¬c é“Ñ˝@hU]ö¬∫¯œ?ﬂVö¬◊•	˚/Ä–î¶··Ë|ÁÛ∑ø5/˛ZxLŸQö∞ˇm†jK”’Å\\Ù˛Òﬂïº¶)<æG·Qöòı^€\Zˆ€)÷iG\n@iíVöÜá£ÀÁEˇj€X≤0V¯ûΩŒ:)MÃjØ]Øìï¶T*µ ëPöÄï¶©Œ.9Î§41Ô˚ÌÅIJ”âöööÂéÄ“$®4MÁÏ“dgùî•âÔ∑+Jï¶t:}ø#†4	+M≥-LÖ•¸(MÃjœùË⁄¶”Œ2(M@Kì•4±({Óm◊6πñ	@iî&Ki¢H\\íZúePö\0•…Rö(]öÓ+∫ñi•#†4Jì•4q˚ﬁ{Î⁄&gô\0î&@i≤î&bôLÊ©Tj]ºÁæØÛÒ˙|ÏlS>^«ﬁ≤˜x¯>G@iî&•Ii™\Z·V‚Òjè◊ı…>ÿv‹z#˛˛zG@iî&•â•º∑ﬁü∂•â÷±⁄⁄⁄{M\0•	Pöî&ñîT*µ∫ÆÆÓ”‚î…d¢_˝ÍW—°Cá¢Kó.Eˇ˛˜ø£‡Ûœ?èrπ\\t¸¯Òh«é—¯√Ò≈È™≥N\0J†4)M,•¬¥*.97ãÀ“K/Ωı˜˜G”100pÎ˚√œóß¯ü˘∞£†4Jì“D•¶’≈Öi√Ü\r∑Œ*ÕF¯π\'ûxb|qr∆	@iî&•âä›KÔ.~Kﬁñ-[æ|ﬁlÖ∑Óm›∫u¸[ıæÈh(MÄ“§4Qq‚¬‘Q|ÜiÆÖ©∏8ç;„tÃ—Pö\0•Ii¢¢Ñ€ä_√4€∑‰MˆVΩ‚kúºM@if°¶¶fπ“¥tJ”Tœ\'â+MÌÖBn‚PªwÔv∂	@if#~-uWOOœâpª‚Mõ6=VÍ≈∂“T•i∫œ\'WÜ‚ıÌ…æ\'ì…|£pÛáp6ËìO>)Ki\nw’w;Úª=C\0J0ÖKó.mŒÁÛ7\n/™Üááøÿ≥gœ˘µk◊~Ki™º“4ìÁìÖ€«ﬁ◊ûJ•ÓõË{‚ØØ+|ﬂØ˝Î®ú¬Á8ï¶«=C\0JP¬µk◊ÓÌÎÎ˚†‘´ã/Ê∑m€ˆB6õΩCiJ~iöÕÛ…¬ñ¶¢u`¸ôß¯k/?|¯pYKS8YÙﬂ“ÍPöÄq‚◊Lwtwwˇedddt™W£££#mmm755}OiJfiöÀÛ…¢ï¶/œ< S¸ˇœæ>ﬂ7Ä/óÀˇwt{Ü\0î&†H__ﬂ?õ≈u√œ?ˇ¸¡÷÷Ve%AÎ‘©S—\\ûœ¯˚◊˝≠Xº“T|Ê)^CÖˇ?_∑üÏˆ„EˇÓºg YõÇeYãºöõõo]>õã«√œÜF¯-µ¬≤¯+<ÛÒ|Z…[°¯ﬂÁ\0@ëpáÆÜÜÜW;;;/èééﬁúŒã´¡¡¡ø666æëJ•Zb\nKÇ÷æ}˚¢π<üÓú∂ËøT<?´¬›\r„ˇ}’ô&\0Ä	¢˘Ã3œtÙOr˝ÀŸù;w˛!\\kæ?¸\\“Æiäˇì&\\ıxRn1€ÁìE+M_ñ•¢ÔqM\0@“‘÷÷~-ì…¸vÔﬁΩ˝###CEØ©Ú.\\x!~Ïl¸¬nG6õΩ≥3I,Mì}≠‹è\'ÈÓy≥y>Y“t\"÷â>7À›Û\0\0í˝ÇnESS”ôÆÆÆ‹–––ëç7˛-º∏_ˇΩJSrK”lûOÏÔÿmgñ∆Û9M\0\0	^Ã•”Èıc∑A^_Í≈ù“î¸“4ìÁì‰◊∆œ◊çú≈ˇ;˙‰ìO Rò¬M@ÍÎÎGãJ”›é>\0¿À”dè+MïQö¶˚|í,·sõ\neÊ•ó^*Ki⁄Ω{wÒY¶cé:\0¿<Sö*´4Qq•È˛B°	gõÊ˚Ü·üWWW7ZÙ·∫ıé:\0Ä“§4QQ‚2ÛF°‘lÿ∞aﬁn?n3˛ÿcè›,>À‰L$\0@ïî¶en9Œ“*Mw«ÎJ°‹lŸ≤eŒ≈)¶≠[∑_«t5ùN”—\0®Ç“TÌKiZöR©‘Í¬M!\ngúf˚VΩs„Œ0y[\0Ä“§4Q˘‚rì-.N·\Zßpsàp˜ªÈﬁ%/‹Ù°¯\Z¶∞‚Bˆ§£\0†4)M,	·åSºäKO(O·sú¬‡Ü≥HÖ∑ÓÖ∑‡Ârπ[\\€‹‹=Ù–C#≈?ﬁíäò£\n\0†4)M,)·\Zß‚[ëœrs\r\0Ä“§4±‘À”cÂÈ∆L R8ª‰.y\0\0Jì“D’»d2ﬂàÀ”˙∏ΩØãÒ è§gwºZ„ıx8CÂh\0(MJì“\0\0Jì•4\0Ä“d)M\0\0†4YJ\0\0(Mñ“\0\0Jì•4\0\0Jì“\0\0(MJ\0\0†4)M\0\0Ä“§4\0\0Jì•4\0Ä“d)M\0\0†4YJ\0\0(Mñ“\0\0Jì•4\0\0Jì“\0\0(MJ\0\0†4)M\0\0Ä“§4\0\0Jì“d*\0@i≤î&\0\0®TVí≥Úqi∫a*\0 Aé=zπøø_aI¿ Âr{‚“tŒT\0@Ç:tË˚áÏÎÎR\\ÔS(L∆ÎS	\0\0	øP_’ﬁﬁ~:º5,\\Sc-¯\n«˝ú¬\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0TçˇJx’rJ®˝1\0\0\0\0IENDÆB`Ç',1),
('8',1,'hist.var-money',NULL,'¨Ì\0sr\0java.math.BigDecimalT«W˘Å(O\0I\0scaleL\0intValt\0Ljava/math/BigInteger;xr\0java.lang.NumberÜ¨ïî‡ã\0\0xp\0\0\0\0sr\0java.math.BigIntegerå¸ü©;˚\0I\0bitCountI\0	bitLengthI\0firstNonzeroByteNumI\0lowestSetBitI\0signum[\0	magnitudet\0[Bxq\0~\0ˇˇˇˇˇˇˇˇˇˇˇ˛ˇˇˇ˛\0\0\0ur\0[B¨Û¯T‡\0\0xp\0\0\0Áxx',NULL);

/*Table structure for table `act_ge_property` */

DROP TABLE IF EXISTS `act_ge_property`;

CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ge_property` */

insert  into `act_ge_property`(`NAME_`,`VALUE_`,`REV_`) values 
('cfg.execution-related-entities-count','false',1),
('cfg.task-related-entities-count','false',1),
('common.schema.version','6.2.0.0',1),
('identitylink.schema.version','6.2.0.0',1),
('job.schema.version','6.2.0.0',1),
('next.dbid','5001',3),
('schema.history','create(6.2.0.0)',1),
('schema.version','6.2.0.0',1),
('task.schema.version','6.2.0.0',1),
('variable.schema.version','6.2.0.0',1);

/*Table structure for table `act_hi_actinst` */

DROP TABLE IF EXISTS `act_hi_actinst`;

CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_actinst` */

insert  into `act_hi_actinst`(`ID_`,`REV_`,`PROC_DEF_ID_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`ACT_ID_`,`TASK_ID_`,`CALL_PROC_INST_ID_`,`ACT_NAME_`,`ACT_TYPE_`,`ASSIGNEE_`,`START_TIME_`,`END_TIME_`,`DURATION_`,`DELETE_REASON_`,`TENANT_ID_`) values 
('11',1,'Expense:1:4','5','10','start',NULL,NULL,'ÂºÄÂßã ','startEvent',NULL,'2018-07-11 19:33:07.775','2018-07-11 19:33:07.778',3,NULL,''),
('12',2,'Expense:1:4','5','10','task_apply','13',NULL,'Êä•ÈîÄÁî≥ËØ∑','userTask','134','2018-07-11 19:33:07.779','2018-07-11 19:34:42.822',95043,NULL,''),
('23',2,'Expense:1:4','5','10','leader_aduit','24',NULL,'‰∏äÁ∫ßÂÆ°Êâπ','userTask',NULL,'2018-07-11 19:34:42.822','2018-07-12 09:24:44.193',49801371,'ÂèñÊ∂àÊä•ÈîÄ',''),
('2507',1,'Expense:1:4','2501','2506','start',NULL,NULL,'ÂºÄÂßã ','startEvent',NULL,'2018-07-12 09:25:24.816','2018-07-12 09:25:24.826',10,NULL,''),
('2508',2,'Expense:1:4','2501','2506','task_apply','2509',NULL,'Êä•ÈîÄÁî≥ËØ∑','userTask','134','2018-07-12 09:25:24.829','2018-07-12 09:25:26.895',2066,NULL,''),
('2513',2,'Expense:1:4','2501','2506','leader_aduit','2514',NULL,'‰∏äÁ∫ßÂÆ°Êâπ','userTask',NULL,'2018-07-12 09:25:26.902','2018-07-12 09:26:55.608',88706,NULL,''),
('2515',1,'Expense:1:4','2501','2506','judgeTask',NULL,NULL,NULL,'exclusiveGateway',NULL,'2018-07-12 09:26:55.608','2018-07-12 09:26:55.612',4,NULL,''),
('2516',2,'Expense:1:4','2501','2506','financial_aduit','2517',NULL,'Ë¥¢Âä°ÂÆ°Êâπ','userTask',NULL,'2018-07-12 09:26:55.612','2018-07-12 09:27:21.399',25787,NULL,''),
('2518',1,'Expense:1:4','2501','2506','end',NULL,NULL,'ÁªìÊùü','endEvent',NULL,'2018-07-12 09:27:21.399','2018-07-12 09:27:21.451',52,NULL,''),
('31',1,'Expense:1:4','25','30','start',NULL,NULL,'ÂºÄÂßã ','startEvent',NULL,'2018-07-11 19:34:58.040','2018-07-11 19:34:58.040',0,NULL,''),
('32',2,'Expense:1:4','25','30','task_apply','33',NULL,'Êä•ÈîÄÁî≥ËØ∑','userTask','134','2018-07-11 19:34:58.040','2018-07-12 09:24:44.346',49786306,'ÂèñÊ∂àÊä•ÈîÄ','');

/*Table structure for table `act_hi_attachment` */

DROP TABLE IF EXISTS `act_hi_attachment`;

CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_attachment` */

/*Table structure for table `act_hi_comment` */

DROP TABLE IF EXISTS `act_hi_comment`;

CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_comment` */

/*Table structure for table `act_hi_detail` */

DROP TABLE IF EXISTS `act_hi_detail`;

CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_detail` */

/*Table structure for table `act_hi_identitylink` */

DROP TABLE IF EXISTS `act_hi_identitylink`;

CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_identitylink` */

insert  into `act_hi_identitylink`(`ID_`,`GROUP_ID_`,`TYPE_`,`USER_ID_`,`TASK_ID_`,`CREATE_TIME_`,`PROC_INST_ID_`) values 
('14',NULL,'assignee','134','13','2018-07-11 19:33:07.806',NULL),
('15',NULL,'participant','134',NULL,NULL,'5'),
('2510',NULL,'assignee','134','2509','2018-07-12 09:25:24.854',NULL),
('2511',NULL,'participant','134',NULL,NULL,'2501'),
('34',NULL,'assignee','134','33','2018-07-11 19:34:58.040',NULL),
('35',NULL,'participant','134',NULL,NULL,'25');

/*Table structure for table `act_hi_procinst` */

DROP TABLE IF EXISTS `act_hi_procinst`;

CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_procinst` */

insert  into `act_hi_procinst`(`ID_`,`REV_`,`PROC_INST_ID_`,`BUSINESS_KEY_`,`PROC_DEF_ID_`,`START_TIME_`,`END_TIME_`,`DURATION_`,`START_USER_ID_`,`START_ACT_ID_`,`END_ACT_ID_`,`SUPER_PROCESS_INSTANCE_ID_`,`DELETE_REASON_`,`TENANT_ID_`,`NAME_`,`CALLBACK_ID_`,`CALLBACK_TYPE_`) values 
('25',2,'25',NULL,'Expense:1:4','2018-07-11 19:34:58.039','2018-07-12 09:24:44.408',49786369,NULL,'start',NULL,NULL,'ÂèñÊ∂àÊä•ÈîÄ','',NULL,NULL,NULL),
('2501',2,'2501',NULL,'Expense:1:4','2018-07-12 09:25:24.789','2018-07-12 09:27:21.477',116688,NULL,'start','end',NULL,NULL,'',NULL,NULL,NULL),
('5',2,'5',NULL,'Expense:1:4','2018-07-11 19:33:07.762','2018-07-12 09:24:44.247',49896485,NULL,'start',NULL,NULL,'ÂèñÊ∂àÊä•ÈîÄ','',NULL,NULL,NULL);

/*Table structure for table `act_hi_taskinst` */

DROP TABLE IF EXISTS `act_hi_taskinst`;

CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_taskinst` */

insert  into `act_hi_taskinst`(`ID_`,`REV_`,`PROC_DEF_ID_`,`TASK_DEF_KEY_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`SCOPE_ID_`,`SUB_SCOPE_ID_`,`SCOPE_TYPE_`,`SCOPE_DEFINITION_ID_`,`NAME_`,`PARENT_TASK_ID_`,`DESCRIPTION_`,`OWNER_`,`ASSIGNEE_`,`START_TIME_`,`CLAIM_TIME_`,`END_TIME_`,`DURATION_`,`DELETE_REASON_`,`PRIORITY_`,`DUE_DATE_`,`FORM_KEY_`,`CATEGORY_`,`TENANT_ID_`,`LAST_UPDATED_TIME_`) values 
('13',2,'Expense:1:4','task_apply','5','10',NULL,NULL,NULL,NULL,'Êä•ÈîÄÁî≥ËØ∑',NULL,NULL,NULL,'134','2018-07-11 19:33:07.803',NULL,'2018-07-11 19:34:42.816',95013,NULL,50,NULL,NULL,NULL,'','2018-07-11 19:34:42.816'),
('24',2,'Expense:1:4','leader_aduit','5','10',NULL,NULL,NULL,NULL,'‰∏äÁ∫ßÂÆ°Êâπ',NULL,NULL,NULL,NULL,'2018-07-11 19:34:42.823',NULL,'2018-07-12 09:24:44.182',49801359,'ÂèñÊ∂àÊä•ÈîÄ',50,NULL,NULL,NULL,'','2018-07-12 09:24:44.182'),
('2509',2,'Expense:1:4','task_apply','2501','2506',NULL,NULL,NULL,NULL,'Êä•ÈîÄÁî≥ËØ∑',NULL,NULL,NULL,'134','2018-07-12 09:25:24.851',NULL,'2018-07-12 09:25:26.887',2036,NULL,50,NULL,NULL,NULL,'','2018-07-12 09:25:26.887'),
('2514',2,'Expense:1:4','leader_aduit','2501','2506',NULL,NULL,NULL,NULL,'‰∏äÁ∫ßÂÆ°Êâπ',NULL,NULL,NULL,NULL,'2018-07-12 09:25:26.903',NULL,'2018-07-12 09:26:55.602',88699,NULL,50,NULL,NULL,NULL,'','2018-07-12 09:26:55.602'),
('2517',2,'Expense:1:4','financial_aduit','2501','2506',NULL,NULL,NULL,NULL,'Ë¥¢Âä°ÂÆ°Êâπ',NULL,NULL,NULL,NULL,'2018-07-12 09:26:55.612',NULL,'2018-07-12 09:27:21.395',25783,NULL,50,NULL,NULL,NULL,'','2018-07-12 09:27:21.395'),
('33',2,'Expense:1:4','task_apply','25','30',NULL,NULL,NULL,NULL,'Êä•ÈîÄÁî≥ËØ∑',NULL,NULL,NULL,'134','2018-07-11 19:34:58.040',NULL,'2018-07-12 09:24:44.340',49786300,'ÂèñÊ∂àÊä•ÈîÄ',50,NULL,NULL,NULL,'','2018-07-12 09:24:44.340');

/*Table structure for table `act_hi_varinst` */

DROP TABLE IF EXISTS `act_hi_varinst`;

CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_hi_varinst` */

insert  into `act_hi_varinst`(`ID_`,`REV_`,`PROC_INST_ID_`,`EXECUTION_ID_`,`TASK_ID_`,`NAME_`,`VAR_TYPE_`,`SCOPE_ID_`,`SUB_SCOPE_ID_`,`SCOPE_TYPE_`,`BYTEARRAY_ID_`,`DOUBLE_`,`LONG_`,`TEXT_`,`TEXT2_`,`CREATE_TIME_`,`LAST_UPDATED_TIME_`) values 
('22',0,'5','5',NULL,'check','string',NULL,NULL,NULL,NULL,NULL,NULL,'pass',NULL,'2018-07-11 19:34:42.808','2018-07-11 19:34:42.808'),
('2503',0,'2501','2501',NULL,'money','serializable',NULL,NULL,NULL,'2504',NULL,NULL,NULL,NULL,'2018-07-12 09:25:24.814','2018-07-12 09:25:24.814'),
('2505',0,'2501','2501',NULL,'taskUser','string',NULL,NULL,NULL,NULL,NULL,NULL,'134',NULL,'2018-07-12 09:25:24.814','2018-07-12 09:25:24.814'),
('2512',2,'2501','2501',NULL,'check','string',NULL,NULL,NULL,NULL,NULL,NULL,'pass',NULL,'2018-07-12 09:25:26.880','2018-07-12 09:27:21.388'),
('27',0,'25','25',NULL,'money','serializable',NULL,NULL,NULL,'28',NULL,NULL,NULL,NULL,'2018-07-11 19:34:58.040','2018-07-11 19:34:58.040'),
('29',0,'25','25',NULL,'taskUser','string',NULL,NULL,NULL,NULL,NULL,NULL,'134',NULL,'2018-07-11 19:34:58.040','2018-07-11 19:34:58.040'),
('7',0,'5','5',NULL,'money','serializable',NULL,NULL,NULL,'8',NULL,NULL,NULL,NULL,'2018-07-11 19:33:07.773','2018-07-11 19:33:07.773'),
('9',0,'5','5',NULL,'taskUser','string',NULL,NULL,NULL,NULL,NULL,NULL,'134',NULL,'2018-07-11 19:33:07.773','2018-07-11 19:33:07.773');

/*Table structure for table `act_id_bytearray` */

DROP TABLE IF EXISTS `act_id_bytearray`;

CREATE TABLE `act_id_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_bytearray` */

/*Table structure for table `act_id_group` */

DROP TABLE IF EXISTS `act_id_group`;

CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_group` */

/*Table structure for table `act_id_info` */

DROP TABLE IF EXISTS `act_id_info`;

CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_info` */

/*Table structure for table `act_id_membership` */

DROP TABLE IF EXISTS `act_id_membership`;

CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_membership` */

/*Table structure for table `act_id_priv` */

DROP TABLE IF EXISTS `act_id_priv`;

CREATE TABLE `act_id_priv` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_priv` */

/*Table structure for table `act_id_priv_mapping` */

DROP TABLE IF EXISTS `act_id_priv_mapping`;

CREATE TABLE `act_id_priv_mapping` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`),
  KEY `ACT_IDX_PRIV_USER` (`USER_ID_`),
  KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_priv_mapping` */

/*Table structure for table `act_id_property` */

DROP TABLE IF EXISTS `act_id_property`;

CREATE TABLE `act_id_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_property` */

insert  into `act_id_property`(`NAME_`,`VALUE_`,`REV_`) values 
('schema.version','6.2.0.0',1);

/*Table structure for table `act_id_token` */

DROP TABLE IF EXISTS `act_id_token`;

CREATE TABLE `act_id_token` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATE_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_token` */

/*Table structure for table `act_id_user` */

DROP TABLE IF EXISTS `act_id_user`;

CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_id_user` */

/*Table structure for table `act_procdef_info` */

DROP TABLE IF EXISTS `act_procdef_info`;

CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_procdef_info` */

/*Table structure for table `act_re_deployment` */

DROP TABLE IF EXISTS `act_re_deployment`;

CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_deployment` */

insert  into `act_re_deployment`(`ID_`,`NAME_`,`CATEGORY_`,`KEY_`,`TENANT_ID_`,`DEPLOY_TIME_`,`ENGINE_VERSION_`) values 
('1','SpringAutoDeployment',NULL,NULL,'','2018-07-11 19:32:23.194',NULL);

/*Table structure for table `act_re_model` */

DROP TABLE IF EXISTS `act_re_model`;

CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_model` */

/*Table structure for table `act_re_procdef` */

DROP TABLE IF EXISTS `act_re_procdef`;

CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_re_procdef` */

insert  into `act_re_procdef`(`ID_`,`REV_`,`CATEGORY_`,`NAME_`,`KEY_`,`VERSION_`,`DEPLOYMENT_ID_`,`RESOURCE_NAME_`,`DGRM_RESOURCE_NAME_`,`DESCRIPTION_`,`HAS_START_FORM_KEY_`,`HAS_GRAPHICAL_NOTATION_`,`SUSPENSION_STATE_`,`TENANT_ID_`,`ENGINE_VERSION_`) values 
('Expense:1:4',1,'http://www.flowable.org/processdef','ExpenseProcess','Expense',1,'1','E:\\xiahui\\tools\\eclipse\\workspace\\mumu-parent\\mumu-admin\\target\\classes\\processes\\ExpenseProcess.bpmn20.xml','E:\\xiahui\\tools\\eclipse\\workspace\\mumu-parent\\mumu-admin\\target\\classes\\processes\\ExpenseProcess.Expense.png','Êä•ÈîÄÊµÅÁ®ã',0,1,1,'',NULL);

/*Table structure for table `act_ru_deadletter_job` */

DROP TABLE IF EXISTS `act_ru_deadletter_job`;

CREATE TABLE `act_ru_deadletter_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_deadletter_job` */

/*Table structure for table `act_ru_event_subscr` */

DROP TABLE IF EXISTS `act_ru_event_subscr`;

CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_event_subscr` */

/*Table structure for table `act_ru_execution` */

DROP TABLE IF EXISTS `act_ru_execution`;

CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
  `TASK_COUNT_` int(11) DEFAULT NULL,
  `JOB_COUNT_` int(11) DEFAULT NULL,
  `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
  `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_execution` */

/*Table structure for table `act_ru_history_job` */

DROP TABLE IF EXISTS `act_ru_history_job`;

CREATE TABLE `act_ru_history_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_history_job` */

/*Table structure for table `act_ru_identitylink` */

DROP TABLE IF EXISTS `act_ru_identitylink`;

CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_identitylink` */

/*Table structure for table `act_ru_job` */

DROP TABLE IF EXISTS `act_ru_job`;

CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_job` */

/*Table structure for table `act_ru_suspended_job` */

DROP TABLE IF EXISTS `act_ru_suspended_job`;

CREATE TABLE `act_ru_suspended_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_suspended_job` */

/*Table structure for table `act_ru_task` */

DROP TABLE IF EXISTS `act_ru_task`;

CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_task` */

/*Table structure for table `act_ru_timer_job` */

DROP TABLE IF EXISTS `act_ru_timer_job`;

CREATE TABLE `act_ru_timer_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_TIMER_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_timer_job` */

/*Table structure for table `act_ru_variable` */

DROP TABLE IF EXISTS `act_ru_variable`;

CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Data for the table `act_ru_variable` */

/*Table structure for table `sys_dept` */

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆid',
  `num` int(11) DEFAULT NULL COMMENT 'ÊéíÂ∫è',
  `pid` int(11) DEFAULT NULL COMMENT 'Áà∂ÈÉ®Èó®id',
  `pids` varchar(255) DEFAULT NULL COMMENT 'Áà∂Á∫ßids',
  `simplename` varchar(45) DEFAULT NULL COMMENT 'ÁÆÄÁß∞',
  `fullname` varchar(255) DEFAULT NULL COMMENT 'ÂÖ®Áß∞',
  `tips` varchar(255) DEFAULT NULL COMMENT 'ÊèêÁ§∫',
  `version` int(11) DEFAULT NULL COMMENT 'ÁâàÊú¨Ôºà‰πêËßÇÈîÅ‰øùÁïôÂ≠óÊÆµÔºâ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COMMENT='ÈÉ®Èó®Ë°®';

/*Data for the table `sys_dept` */

insert  into `sys_dept`(`id`,`num`,`pid`,`pids`,`simplename`,`fullname`,`tips`,`version`) values 
(24,1,0,'[0],[24],','ÊÄªÂÖ¨Âè∏','ÊÄªÂÖ¨Âè∏','ÊÄªÂÖ¨Âè∏Â∞±ÊòØÂ•ΩÂïä',NULL),
(25,1,24,'[0],[24],[24],','ÂºÄÂèëÈÉ®','ÂºÄÂèëÈÉ®','Á®ãÂ∫èÂºÄÂèëÈÉ®',NULL),
(28,2,24,'[0],[24],[24],','ËøêÁª¥ÈÉ®','ÂºÄÂèëÊäÄÊúØËøêÁª¥ÈÉ®','‰∏ªË¶ÅÁª¥Êä§Áé∞ÁΩëÁ®≥ÂÆöÁöÑ',NULL),
(75,3,25,'[0],[24],[24],[25],','CËØ≠Ë®ÄÂºÄÂèëÈÉ®','CËØ≠Ë®ÄÂºÄÂèëÈÉ®','CËØ≠Ë®ÄÂºÄÂèëÈÉ®',NULL),
(76,3,25,'[0],[24],[24],[25],','JAVAÂºÄÂèëÈÉ®','JAVAÂºÄÂèëÈÉ®','JAVAÂºÄÂèëÈÉ®',NULL),
(77,2,24,'[0],[24],[24],','Ë¥¢Âä°ÈÉ®','ÈááË¥≠ÈÉ®','Ë¥üË¥£Ë¥¢Âä°ÁªìÁÆó',NULL),
(78,2,24,'[0],[24],[24],','ÈááË¥≠ÈÉ®','ÈááË¥≠ÈÉ®','ÈááË¥≠ÈÉ®',NULL);

/*Table structure for table `sys_dict` */

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆid',
  `num` int(11) DEFAULT NULL COMMENT 'ÊéíÂ∫è',
  `pid` int(11) DEFAULT NULL COMMENT 'Áà∂Á∫ßÂ≠óÂÖ∏',
  `name` varchar(255) DEFAULT NULL COMMENT 'ÂêçÁß∞',
  `tips` varchar(255) DEFAULT NULL COMMENT 'ÊèêÁ§∫',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8 COMMENT='Â≠óÂÖ∏Ë°®';

/*Data for the table `sys_dict` */

insert  into `sys_dict`(`id`,`num`,`pid`,`name`,`tips`) values 
(16,0,0,'Áä∂ÊÄÅ',NULL),
(17,1,16,'ÂêØÁî®',NULL),
(18,2,16,'Á¶ÅÁî®',NULL),
(29,0,0,'ÊÄßÂà´',NULL),
(30,1,29,'Áî∑',NULL),
(31,2,29,'Â•≥',NULL),
(35,0,0,'Ë¥¶Âè∑Áä∂ÊÄÅ',NULL),
(36,1,35,'ÂêØÁî®',NULL),
(37,2,35,'ÂÜªÁªì',NULL),
(38,3,35,'Â∑≤Âà†Èô§',NULL);

/*Table structure for table `sys_expense` */

DROP TABLE IF EXISTS `sys_expense`;

CREATE TABLE `sys_expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `money` decimal(20,2) DEFAULT NULL COMMENT 'Êä•ÈîÄÈáëÈ¢ù',
  `expenseDesc` varchar(255) DEFAULT '' COMMENT 'ÊèèËø∞',
  `createtime` datetime DEFAULT CURRENT_TIMESTAMP,
  `state` int(11) DEFAULT NULL COMMENT 'Áä∂ÊÄÅ: 1.ÂæÖÊèê‰∫§  2:ÂæÖÂÆ°Ê†∏   3.ÂÆ°Ê†∏ÈÄöËøá 4:È©≥Âõû',
  `userId` int(11) DEFAULT NULL COMMENT 'Áî®Êà∑id',
  `processId` varchar(255) DEFAULT NULL COMMENT 'ÊµÅÁ®ãÂÆö‰πâid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='Êä•ÈîÄË°®';

/*Data for the table `sys_expense` */

insert  into `sys_expense`(`id`,`money`,`expenseDesc`,`createtime`,`state`,`userId`,`processId`) values 
(71,300.00,'ÊµÅÁ®ãÂÖ®ÈáèÊµãËØï','2018-07-12 09:25:24',5,134,'2501');

/*Table structure for table `sys_flowable_node` */

DROP TABLE IF EXISTS `sys_flowable_node`;

CREATE TABLE `sys_flowable_node` (
  `id` tinyint(4) NOT NULL COMMENT '‰∏ªÈîÆ',
  `procDefId` varchar(30) NOT NULL COMMENT 'ÊµÅÁ®ãÂÆö‰πâid',
  `nodeName` varchar(30) DEFAULT NULL COMMENT 'ËäÇÁÇπÂêçÁß∞',
  `nodeCode` varchar(20) DEFAULT NULL COMMENT 'ËäÇÁÇπÁºñÁ†Å',
  `orderNum` tinyint(4) DEFAULT NULL COMMENT 'ËäÇÁÇπÈ°∫Â∫èÔºåË∂äÂ∞èË∂äÈù†Ââç',
  `canBackTo` char(1) DEFAULT NULL COMMENT 'ÂêéÁª≠ËäÇÁÇπÊòØÂê¶ÂèØ‰ª•ÂõûÈÄÄÂà∞ËØ•ËäÇÁÇπ',
  `position` char(1) DEFAULT NULL COMMENT '1Ôºö‰∏≤Ë°åËäÇÁÇπ 2ÔºöÂπ∂Ë°åËäÇÁÇπ 3ÔºöÁΩëÂÖ≥ÂàÜÊîØ',
  `createtime` datetime DEFAULT NULL COMMENT 'ÂàõÂª∫Êó∂Èó¥',
  `nodeDesc` varchar(200) DEFAULT NULL COMMENT 'Â§áÊ≥®',
  `canRollBack` char(1) DEFAULT NULL COMMENT 'ÂΩìÂâçËäÇÁÇπÊòØÂê¶ÂèØ‰ª•ÂÅöÂõûÈÄÄÊìç‰Ωú 1ÔºöÂèØ‰ª• 0Ôºö‰∏çÂèØ‰ª•',
  PRIMARY KEY (`id`),
  KEY `sys_flowable_node_procdefId_index` (`procDefId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sys_flowable_node` */

insert  into `sys_flowable_node`(`id`,`procDefId`,`nodeName`,`nodeCode`,`orderNum`,`canBackTo`,`position`,`createtime`,`nodeDesc`,`canRollBack`) values 
(1,'Expense:1:4','Êä•ÈîÄÁî≥ËØ∑','task_apply',1,'1','1','2018-07-05 17:47:48','2018Âπ¥7Êúà5Êó•Êä•ÈîÄÊµÅÁ®ãÊ∑ªÂä†Êä•ÈîÄÁî≥ËØ∑ËäÇÁÇπ','0'),
(2,'Expense:1:4','‰∏äÁ∫ßÂÆ°Êâπ','leader_aduit',2,'1','1','2018-07-05 17:47:50','2018Âπ¥7Êúà5Êó•Êä•ÈîÄÊµÅÁ®ãÊ∑ªÂä†‰∏äÁ∫ßÂÆ°ÊâπËäÇÁÇπ','0'),
(3,'Expense:1:4','Ë¥¢Âä°ÂÆ°Êâπ','financial_aduit',3,'0','3','2018-07-05 17:47:52','2018Âπ¥7Êúà5Êó•Êä•ÈîÄÊµÅÁ®ãÊ∑ªÂä†Ë¥¢Âä°ÂÆ°ÊâπËäÇÁÇπ','1'),
(4,'Expense:1:4','ËÄÅÊùøÂÆ°Êâπ','boss_aduit',3,'0','3','2018-07-05 17:47:54','2018Âπ¥7Êúà5Êó•Êä•ÈîÄÊµÅÁ®ãÊ∑ªÂä†ËÄÅÊùøÂÆ°ÊâπËäÇÁÇπ','1');

/*Table structure for table `sys_login_log` */

DROP TABLE IF EXISTS `sys_login_log`;

CREATE TABLE `sys_login_log` (
  `id` int(65) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆ',
  `logname` varchar(255) DEFAULT NULL COMMENT 'Êó•ÂøóÂêçÁß∞',
  `userid` int(65) DEFAULT NULL COMMENT 'ÁÆ°ÁêÜÂëòid',
  `createtime` datetime DEFAULT NULL COMMENT 'ÂàõÂª∫Êó∂Èó¥',
  `succeed` varchar(255) DEFAULT NULL COMMENT 'ÊòØÂê¶ÊâßË°åÊàêÂäü',
  `message` text COMMENT 'ÂÖ∑‰ΩìÊ∂àÊÅØ',
  `ip` varchar(255) DEFAULT NULL COMMENT 'ÁôªÂΩïip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1370 DEFAULT CHARSET=utf8 COMMENT='ÁôªÂΩïËÆ∞ÂΩï';

/*Data for the table `sys_login_log` */

insert  into `sys_login_log`(`id`,`logname`,`userid`,`createtime`,`succeed`,`message`,`ip`) values 
(1356,'ÁôªÂΩïÊó•Âøó',134,'2018-07-11 19:32:51','ÊàêÂäü',NULL,'127.0.0.1'),
(1357,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:08:06','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1358,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:08:06','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1359,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:17:16','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1360,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:17:16','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1361,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:17:16','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1362,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:20:31','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1363,'ÁôªÂΩïÊó•Âøó',1,'2018-07-12 09:20:31','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1364,'ÈÄÄÂá∫Êó•Âøó',1,'2018-07-12 09:21:16','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1365,'ÁôªÂΩïÊó•Âøó',134,'2018-07-12 09:21:19','ÊàêÂäü',NULL,'0:0:0:0:0:0:0:1'),
(1366,'ÁôªÂΩïÊó•Âøó',133,'2018-07-12 09:26:03','ÊàêÂäü',NULL,'127.0.0.1'),
(1367,'ÁôªÂΩïÊó•Âøó',133,'2018-07-12 09:26:04','ÊàêÂäü',NULL,'127.0.0.1'),
(1368,'ÈÄÄÂá∫Êó•Âøó',133,'2018-07-12 09:27:05','ÊàêÂäü',NULL,'127.0.0.1'),
(1369,'ÁôªÂΩïÊó•Âøó',136,'2018-07-12 09:27:09','ÊàêÂäü',NULL,'127.0.0.1');

/*Table structure for table `sys_menu` */

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆid',
  `code` varchar(255) DEFAULT NULL COMMENT 'ËèúÂçïÁºñÂè∑',
  `pcode` varchar(255) DEFAULT NULL COMMENT 'ËèúÂçïÁà∂ÁºñÂè∑',
  `pcodes` varchar(255) DEFAULT NULL COMMENT 'ÂΩìÂâçËèúÂçïÁöÑÊâÄÊúâÁà∂ËèúÂçïÁºñÂè∑',
  `name` varchar(255) DEFAULT NULL COMMENT 'ËèúÂçïÂêçÁß∞',
  `icon` varchar(255) DEFAULT NULL COMMENT 'ËèúÂçïÂõæÊ†á',
  `url` varchar(255) DEFAULT NULL COMMENT 'urlÂú∞ÂùÄ',
  `route` varchar(255) DEFAULT NULL COMMENT 'Ë∑ØÁî±Âú∞ÂùÄ',
  `num` int(65) DEFAULT NULL COMMENT 'ËèúÂçïÊéíÂ∫èÂè∑',
  `levels` int(65) DEFAULT NULL COMMENT 'ËèúÂçïÂ±ÇÁ∫ß',
  `ismenu` int(11) DEFAULT NULL COMMENT 'ÊòØÂê¶ÊòØËèúÂçïÔºà1ÔºöÊòØ  0Ôºö‰∏çÊòØÔºâ',
  `tips` varchar(255) DEFAULT NULL COMMENT 'Â§áÊ≥®',
  `status` int(65) DEFAULT NULL COMMENT 'ËèúÂçïÁä∂ÊÄÅ :  1:ÂêØÁî®   0:‰∏çÂêØÁî®',
  `isopen` int(11) DEFAULT NULL COMMENT 'ÊòØÂê¶ÊâìÂºÄ:    1:ÊâìÂºÄ   0:‰∏çÊâìÂºÄ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=178 DEFAULT CHARSET=utf8 COMMENT='ËèúÂçïË°®';

/*Data for the table `sys_menu` */

insert  into `sys_menu`(`id`,`code`,`pcode`,`pcodes`,`name`,`icon`,`url`,`route`,`num`,`levels`,`ismenu`,`tips`,`status`,`isopen`) values 
(105,'system','0','[0],','Á≥ªÁªüÁÆ°ÁêÜ','fa-user','#','#',4,1,1,NULL,1,1),
(106,'mgr','system','[0],[system],','Áî®Êà∑ÁÆ°ÁêÜ','','/mgr','.mgr',1,2,1,NULL,1,0),
(107,'mgr_add','mgr','[0],[system],[mgr],','Ê∑ªÂä†Áî®Êà∑','‰øÆÊîπÊµãËØï','/mgr/add','',1,3,0,NULL,1,0),
(108,'mgr_edit','mgr','[0],[system],[mgr],','‰øÆÊîπÁî®Êà∑',NULL,'/mgr/update','',2,3,0,NULL,1,0),
(109,'mgr_delete','mgr','[0],[system],[mgr],','Âà†Èô§Áî®Êà∑',NULL,'/mgr/delete','',3,3,0,NULL,1,0),
(110,'mgr_reset','mgr','[0],[system],[mgr],','ÈáçÁΩÆÂØÜÁ†Å',NULL,'/mgr/reset','',4,3,0,NULL,1,0),
(111,'mgr_freeze','mgr','[0],[system],[mgr],','ÂÜªÁªìÁî®Êà∑',NULL,'/mgr/freeze','',5,3,0,NULL,1,0),
(112,'mgr_unfreeze','mgr','[0],[system],[mgr],','Ëß£Èô§ÂÜªÁªìÁî®Êà∑',NULL,'/mgr/unfreeze','',6,3,0,NULL,1,0),
(114,'role','system','[0],[system],','ËßíËâ≤ÁÆ°ÁêÜ',NULL,'/role','.role',2,2,1,NULL,1,0),
(115,'role_add','role','[0],[system],[role],','Ê∑ªÂä†ËßíËâ≤',NULL,'/role/add','',1,3,0,NULL,1,0),
(116,'role_edit','role','[0],[system],[role],','‰øÆÊîπËßíËâ≤',NULL,'/role/update','',2,3,0,NULL,1,0),
(117,'role_delete','role','[0],[system],[role],','Âà†Èô§ËßíËâ≤',NULL,'/role/delete','',3,3,0,NULL,1,0),
(118,'role_setAuthority','role','[0],[system],[role],','ÈÖçÁΩÆÊùÉÈôê',NULL,'/role/setAuthority','',4,3,0,NULL,1,0),
(119,'menu','system','[0],[system],','ËèúÂçïÁÆ°ÁêÜ',NULL,'/menu','.menu',4,2,1,NULL,1,0),
(120,'menu_add','menu','[0],[system],[menu],','Ê∑ªÂä†ËèúÂçï',NULL,'/menu/add','',1,3,0,NULL,1,0),
(121,'menu_update','menu','[0],[system],[menu],','‰øÆÊîπËèúÂçï',NULL,'/menu/update','',2,3,0,NULL,1,0),
(122,'menu_delete','menu','[0],[system],[menu],','Âà†Èô§ËèúÂçï',NULL,'/menu/delete','',3,3,0,NULL,1,0),
(128,'log','system','[0],[system],','‰∏öÂä°Êó•Âøó',NULL,'/log','.log',6,2,1,NULL,1,0),
(130,'druid','system','[0],[system],','ÁõëÊéßÁÆ°ÁêÜ',NULL,'/druid','.druid',7,2,1,NULL,1,NULL),
(131,'dept','system','[0],[system],','ÈÉ®Èó®ÁÆ°ÁêÜ',NULL,'/dept','.dept',3,2,1,NULL,1,NULL),
(132,'dict','system','[0],[system],','Â≠óÂÖ∏ÁÆ°ÁêÜ',NULL,'/dict','.dict',4,2,1,NULL,1,NULL),
(133,'loginLog','system','[0],[system],','ÁôªÂΩïÊó•Âøó',NULL,'/loginLog','.loginLog',6,2,1,NULL,1,NULL),
(134,'log_deleteAll','log','[0],[system],[log],','Ê∏ÖÁ©∫Êó•Âøó',NULL,'/log/deleteAll','',3,3,0,NULL,1,NULL),
(135,'dept_add','dept','[0],[system],[dept],','Ê∑ªÂä†ÈÉ®Èó®',NULL,'/dept/add','',1,3,0,NULL,1,NULL),
(136,'dept_update','dept','[0],[system],[dept],','‰øÆÊîπÈÉ®Èó®',NULL,'/dept/update','',1,3,0,NULL,1,NULL),
(137,'dept_delete','dept','[0],[system],[dept],','Âà†Èô§ÈÉ®Èó®',NULL,'/dept/delete','',1,3,0,NULL,1,NULL),
(138,'dict_add','dict','[0],[system],[dict],','Ê∑ªÂä†Â≠óÂÖ∏',NULL,'/dict/add','',1,3,0,NULL,1,NULL),
(139,'dict_update','dict','[0],[system],[dict],','‰øÆÊîπÂ≠óÂÖ∏',NULL,'/dict/update','',1,3,0,NULL,1,NULL),
(140,'dict_delete','dict','[0],[system],[dict],','Âà†Èô§Â≠óÂÖ∏',NULL,'/dict/delete','',1,3,0,NULL,1,NULL),
(141,'notice','system','[0],[system],','ÈÄöÁü•ÁÆ°ÁêÜ',NULL,'/notice','.notice',9,2,1,NULL,1,NULL),
(142,'notice_add','notice','[0],[system],[notice],','Ê∑ªÂä†ÈÄöÁü•',NULL,'/notice/add','',1,3,0,NULL,1,NULL),
(143,'notice_update','notice','[0],[system],[notice],','‰øÆÊîπÈÄöÁü•',NULL,'/notice/update','',2,3,0,NULL,1,NULL),
(144,'notice_delete','notice','[0],[system],[notice],','Âà†Èô§ÈÄöÁü•',NULL,'/notice/delete','',3,3,0,NULL,1,NULL),
(145,'hello','0','[0],','ÈÄöÁü•','fa-rocket','/notice/msg','.notice_msg',1,1,1,NULL,1,NULL),
(148,'code','0','[0],','‰ª£Á†ÅÁîüÊàê','fa-code','/code','.code',3,1,1,NULL,1,NULL),
(149,'api_mgr','0','[0],','Êé•Âè£ÊñáÊ°£','fa-leaf','/swagger-ui','.swagger_ui',2,1,1,NULL,1,NULL),
(151,'menu_list','menu','[0],[system],[menu],','ËèúÂçïÂàóË°®','','/menu/list','',5,3,0,NULL,1,NULL),
(153,'dept_list','dept','[0],[system],[dept],','ÈÉ®Èó®ÂàóË°®','','/dept/list','',5,3,0,NULL,1,NULL),
(154,'dept_detail','dept','[0],[system],[dept],','ÈÉ®Èó®ËØ¶ÊÉÖ','','/dept/detail','',6,3,0,NULL,1,NULL),
(156,'dict_list','dict','[0],[system],[dict],','Â≠óÂÖ∏ÂàóË°®','','/dict/list','',5,3,0,NULL,1,NULL),
(157,'dict_detail','dict','[0],[system],[dict],','Â≠óÂÖ∏ËØ¶ÊÉÖ','','/dict/detail','',6,3,0,NULL,1,NULL),
(159,'log_detail','log','[0],[system],[log],','Êó•ÂøóËØ¶ÊÉÖ','','/log/detail','',3,3,0,NULL,1,NULL),
(160,'del_login_log','loginLog','[0],[system],[loginLog],','Ê∏ÖÁ©∫ÁôªÂΩïÊó•Âøó','','/loginLog/delLoginLog','',1,3,0,NULL,1,NULL),
(161,'login_log_list','loginLog','[0],[system],[loginLog],','ÁôªÂΩïÊó•ÂøóÂàóË°®','','/loginLog/list','',2,3,0,NULL,1,NULL),
(164,'role_list','role','[0],[system],[role],','ËßíËâ≤ÂàóË°®','','/role/list','',7,3,0,NULL,1,NULL),
(167,'mgr_list','mgr','[0],[system],[mgr],','Áî®Êà∑ÂàóË°®','','/mgr/list','',10,3,0,NULL,1,NULL),
(168,'floable','0','[0],','ÊµÅÁ®ãÁÆ°ÁêÜ','fa-clone','#','#',5,1,1,NULL,1,NULL),
(169,'expense_list','floable','[0],[floable],','Êä•ÈîÄÊµÅÁ®ã','','/expense/list','.expense',1,2,1,NULL,1,NULL),
(170,'expense_progress','floable','[0],[floable],','Êä•ÈîÄÂÆ°Êâπ','','/expenseProcess','.expense_progress',2,2,1,NULL,1,NULL),
(175,'log_delete','log','[0],[system],[log],','Êó•ÂøóÂà†Èô§',NULL,'/log/delete','',NULL,3,0,NULL,1,NULL),
(176,'log_list','log','[0],[system],[log],','Êó•ÂøóÂàóË°®',NULL,'/log/list','',NULL,3,0,NULL,1,NULL),
(177,'flowable_node','floable','[0],[floable],','ÊµÅÁ®ãËäÇÁÇπ',NULL,'/flowableNode/list','.flowable_node',NULL,2,1,NULL,1,NULL);

/*Table structure for table `sys_notice` */

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆ',
  `title` varchar(255) DEFAULT NULL COMMENT 'Ê†áÈ¢ò',
  `type` int(11) DEFAULT NULL COMMENT 'Á±ªÂûã',
  `content` text COMMENT 'ÂÜÖÂÆπ',
  `createtime` datetime DEFAULT NULL COMMENT 'ÂàõÂª∫Êó∂Èó¥',
  `creater` int(11) DEFAULT NULL COMMENT 'ÂàõÂª∫‰∫∫',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='ÈÄöÁü•Ë°®';

/*Data for the table `sys_notice` */

insert  into `sys_notice`(`id`,`title`,`type`,`content`,`createtime`,`creater`) values 
(6,'‰∏ñÁïå',10,'Ê¨¢Ëøé‰ΩøÁî®mumuÁÆ°ÁêÜÁ≥ªÁªü','2017-01-11 08:53:20',1),
(8,'‰Ω†Â•Ω',NULL,'‰Ω†Â•Ω','2017-05-10 19:28:57',1);

/*Table structure for table `sys_operation_log` */

DROP TABLE IF EXISTS `sys_operation_log`;

CREATE TABLE `sys_operation_log` (
  `id` int(65) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆ',
  `logtype` varchar(255) DEFAULT NULL COMMENT 'Êó•ÂøóÁ±ªÂûã',
  `logname` varchar(255) DEFAULT NULL COMMENT 'Êó•ÂøóÂêçÁß∞',
  `userid` int(65) DEFAULT NULL COMMENT 'Áî®Êà∑id',
  `classname` varchar(255) DEFAULT NULL COMMENT 'Á±ªÂêçÁß∞',
  `method` text COMMENT 'ÊñπÊ≥ïÂêçÁß∞',
  `createtime` datetime DEFAULT NULL COMMENT 'ÂàõÂª∫Êó∂Èó¥',
  `succeed` varchar(255) DEFAULT NULL COMMENT 'ÊòØÂê¶ÊàêÂäü',
  `message` text COMMENT 'Â§áÊ≥®',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=782 DEFAULT CHARSET=utf8 COMMENT='Êìç‰ΩúÊó•Âøó';

/*Data for the table `sys_operation_log` */

insert  into `sys_operation_log`(`id`,`logtype`,`logname`,`userid`,`classname`,`method`,`createtime`,`succeed`,`message`) values 
(773,'ÂºÇÂ∏∏Êó•Âøó','',134,NULL,NULL,'2018-07-11 19:32:59','Â§±Ë¥•','java.lang.NullPointerException\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.delete(ExpenseServiceImpl.java:103)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptorT1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:282)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTTbc9ca91b.delete(<generated>)\r\n	at com.mumu.modular.flowable.controller.ExpenseController.delete(ExpenseController.java:84)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTFastClassBySpringCGLIBTTbf4a8a53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTEnhancerBySpringCGLIBTT1add13b5.delete(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n'),
(774,'ÂºÇÂ∏∏Êó•Âøó','',134,NULL,NULL,'2018-07-11 19:33:10','Â§±Ë¥•','org.flowable.engine.common.api.FlowableException: Exception while invoking TaskListener: Exception while invoking TaskListener: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.flowable.engine.impl.bpmn.listener.ListenerNotificationHelper.executeTaskListeners(ListenerNotificationHelper.java:127)\r\n	at org.flowable.engine.impl.bpmn.listener.ListenerNotificationHelper.executeTaskListeners(ListenerNotificationHelper.java:106)\r\n	at org.flowable.engine.impl.bpmn.behavior.UserTaskActivityBehavior.execute(UserTaskActivityBehavior.java:215)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.executeActivityBehavior(ContinueProcessOperation.java:248)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.executeSynchronous(ContinueProcessOperation.java:154)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.continueThroughFlowNode(ContinueProcessOperation.java:111)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.continueThroughSequenceFlow(ContinueProcessOperation.java:295)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.run(ContinueProcessOperation.java:77)\r\n	at org.flowable.engine.impl.interceptor.CommandInvoker.executeOperation(CommandInvoker.java:88)\r\n	at org.flowable.engine.impl.interceptor.CommandInvoker.executeOperations(CommandInvoker.java:72)\r\n	at org.flowable.engine.impl.interceptor.CommandInvoker.execute(CommandInvoker.java:56)\r\n	at org.flowable.engine.impl.interceptor.BpmnOverrideContextInterceptor.execute(BpmnOverrideContextInterceptor.java:25)\r\n	at org.flowable.engine.common.impl.interceptor.TransactionContextInterceptor.execute(TransactionContextInterceptor.java:53)\r\n	at org.flowable.engine.common.impl.interceptor.CommandContextInterceptor.execute(CommandContextInterceptor.java:72)\r\n	at org.flowable.spring.SpringTransactionInterceptorT1.doInTransaction(SpringTransactionInterceptor.java:49)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:133)\r\n	at org.flowable.spring.SpringTransactionInterceptor.execute(SpringTransactionInterceptor.java:46)\r\n	at org.flowable.engine.common.impl.interceptor.LogInterceptor.execute(LogInterceptor.java:30)\r\n	at org.flowable.engine.common.impl.cfg.CommandExecutorImpl.execute(CommandExecutorImpl.java:56)\r\n	at org.flowable.engine.common.impl.cfg.CommandExecutorImpl.execute(CommandExecutorImpl.java:51)\r\n	at org.flowable.engine.impl.TaskServiceImpl.complete(TaskServiceImpl.java:215)\r\n	at com.mumu.modular.flowable.service.impl.WorkFlowServiceImpl.complete(WorkFlowServiceImpl.java:136)\r\n	at com.mumu.modular.flowable.service.impl.WorkFlowServiceImplTTFastClassBySpringCGLIBTT871632f2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.WorkFlowServiceImplTTEnhancerBySpringCGLIBTT8cdf8e3f.complete(<generated>)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.execute(ExpenseServiceImpl.java:132)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptorT1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:282)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTTbc9ca91b.execute(<generated>)\r\n	at com.mumu.modular.flowable.controller.ExpenseController.execute(ExpenseController.java:97)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTFastClassBySpringCGLIBTTbf4a8a53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTEnhancerBySpringCGLIBTT1add13b5.execute(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: org.flowable.engine.common.api.FlowableException: Exception while invoking TaskListener: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.flowable.engine.impl.bpmn.helper.ClassDelegate.notify(ClassDelegate.java:124)\r\n	at org.flowable.engine.impl.delegate.invocation.TaskListenerInvocation.invoke(TaskListenerInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DelegateInvocation.proceed(DelegateInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DefaultDelegateInterceptor.handleInvocation(DefaultDelegateInterceptor.java:26)\r\n	at org.flowable.engine.impl.bpmn.listener.ListenerNotificationHelper.executeTaskListeners(ListenerNotificationHelper.java:125)\r\n	... 135 more\r\nCaused by: org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:77)\r\n	at org.mybatis.spring.SqlSessionTemplateTSqlSessionInterceptor.invoke(SqlSessionTemplate.java:446)\r\n	at com.sun.proxy.TProxy87.selectOne(Unknown Source)\r\n	at org.mybatis.spring.SqlSessionTemplate.selectOne(SqlSessionTemplate.java:166)\r\n	at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:82)\r\n	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:59)\r\n	at com.sun.proxy.TProxy100.getExpenseByProcessId(Unknown Source)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.getExpenseByProcessId(ExpenseServiceImpl.java:225)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTTbc9ca91b.getExpenseByProcessId(<generated>)\r\n	at com.mumu.modular.flowable.handler.LeaderTaskHandler.notify(LeaderTaskHandler.java:42)\r\n	at org.flowable.engine.impl.delegate.invocation.TaskListenerInvocation.invoke(TaskListenerInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DelegateInvocation.proceed(DelegateInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DefaultDelegateInterceptor.handleInvocation(DefaultDelegateInterceptor.java:26)\r\n	at org.flowable.engine.impl.bpmn.helper.ClassDelegate.notify(ClassDelegate.java:122)\r\n	... 139 more\r\nCaused by: org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.selectOne(DefaultSqlSession.java:81)\r\n	at sun.reflect.GeneratedMethodAccessor100.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.mybatis.spring.SqlSessionTemplateTSqlSessionInterceptor.invoke(SqlSessionTemplate.java:433)\r\n	... 158 more\r\n'),
(775,'ÂºÇÂ∏∏Êó•Âøó','',134,NULL,NULL,'2018-07-11 19:34:15','Â§±Ë¥•','org.flowable.engine.common.api.FlowableException: Exception while invoking TaskListener: Exception while invoking TaskListener: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.flowable.engine.impl.bpmn.listener.ListenerNotificationHelper.executeTaskListeners(ListenerNotificationHelper.java:127)\r\n	at org.flowable.engine.impl.bpmn.listener.ListenerNotificationHelper.executeTaskListeners(ListenerNotificationHelper.java:106)\r\n	at org.flowable.engine.impl.bpmn.behavior.UserTaskActivityBehavior.execute(UserTaskActivityBehavior.java:215)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.executeActivityBehavior(ContinueProcessOperation.java:248)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.executeSynchronous(ContinueProcessOperation.java:154)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.continueThroughFlowNode(ContinueProcessOperation.java:111)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.continueThroughSequenceFlow(ContinueProcessOperation.java:295)\r\n	at org.flowable.engine.impl.agenda.ContinueProcessOperation.run(ContinueProcessOperation.java:77)\r\n	at org.flowable.engine.impl.interceptor.CommandInvoker.executeOperation(CommandInvoker.java:88)\r\n	at org.flowable.engine.impl.interceptor.CommandInvoker.executeOperations(CommandInvoker.java:72)\r\n	at org.flowable.engine.impl.interceptor.CommandInvoker.execute(CommandInvoker.java:56)\r\n	at org.flowable.engine.impl.interceptor.BpmnOverrideContextInterceptor.execute(BpmnOverrideContextInterceptor.java:25)\r\n	at org.flowable.engine.common.impl.interceptor.TransactionContextInterceptor.execute(TransactionContextInterceptor.java:53)\r\n	at org.flowable.engine.common.impl.interceptor.CommandContextInterceptor.execute(CommandContextInterceptor.java:72)\r\n	at org.flowable.spring.SpringTransactionInterceptorT1.doInTransaction(SpringTransactionInterceptor.java:49)\r\n	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:133)\r\n	at org.flowable.spring.SpringTransactionInterceptor.execute(SpringTransactionInterceptor.java:46)\r\n	at org.flowable.engine.common.impl.interceptor.LogInterceptor.execute(LogInterceptor.java:30)\r\n	at org.flowable.engine.common.impl.cfg.CommandExecutorImpl.execute(CommandExecutorImpl.java:56)\r\n	at org.flowable.engine.common.impl.cfg.CommandExecutorImpl.execute(CommandExecutorImpl.java:51)\r\n	at org.flowable.engine.impl.TaskServiceImpl.complete(TaskServiceImpl.java:215)\r\n	at com.mumu.modular.flowable.service.impl.WorkFlowServiceImpl.complete(WorkFlowServiceImpl.java:136)\r\n	at com.mumu.modular.flowable.service.impl.WorkFlowServiceImplTTFastClassBySpringCGLIBTT871632f2.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.WorkFlowServiceImplTTEnhancerBySpringCGLIBTT8cdf8e3f.complete(<generated>)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.execute(ExpenseServiceImpl.java:124)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptorT1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:282)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTTbc9ca91b.execute(<generated>)\r\n	at com.mumu.modular.flowable.controller.ExpenseController.execute(ExpenseController.java:97)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTFastClassBySpringCGLIBTTbf4a8a53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTEnhancerBySpringCGLIBTT1add13b5.execute(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\nCaused by: org.flowable.engine.common.api.FlowableException: Exception while invoking TaskListener: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.flowable.engine.impl.bpmn.helper.ClassDelegate.notify(ClassDelegate.java:124)\r\n	at org.flowable.engine.impl.delegate.invocation.TaskListenerInvocation.invoke(TaskListenerInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DelegateInvocation.proceed(DelegateInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DefaultDelegateInterceptor.handleInvocation(DefaultDelegateInterceptor.java:26)\r\n	at org.flowable.engine.impl.bpmn.listener.ListenerNotificationHelper.executeTaskListeners(ListenerNotificationHelper.java:125)\r\n	... 135 more\r\nCaused by: org.mybatis.spring.MyBatisSystemException: nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:77)\r\n	at org.mybatis.spring.SqlSessionTemplateTSqlSessionInterceptor.invoke(SqlSessionTemplate.java:446)\r\n	at com.sun.proxy.TProxy87.selectOne(Unknown Source)\r\n	at org.mybatis.spring.SqlSessionTemplate.selectOne(SqlSessionTemplate.java:166)\r\n	at org.apache.ibatis.binding.MapperMethod.execute(MapperMethod.java:82)\r\n	at org.apache.ibatis.binding.MapperProxy.invoke(MapperProxy.java:59)\r\n	at com.sun.proxy.TProxy100.getExpenseByProcessId(Unknown Source)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.getExpenseByProcessId(ExpenseServiceImpl.java:216)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTTbc9ca91b.getExpenseByProcessId(<generated>)\r\n	at com.mumu.modular.flowable.handler.LeaderTaskHandler.notify(LeaderTaskHandler.java:42)\r\n	at org.flowable.engine.impl.delegate.invocation.TaskListenerInvocation.invoke(TaskListenerInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DelegateInvocation.proceed(DelegateInvocation.java:35)\r\n	at org.flowable.engine.impl.delegate.invocation.DefaultDelegateInterceptor.handleInvocation(DefaultDelegateInterceptor.java:26)\r\n	at org.flowable.engine.impl.bpmn.helper.ClassDelegate.notify(ClassDelegate.java:122)\r\n	... 139 more\r\nCaused by: org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2\r\n	at org.apache.ibatis.session.defaults.DefaultSqlSession.selectOne(DefaultSqlSession.java:81)\r\n	at sun.reflect.GeneratedMethodAccessor100.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.mybatis.spring.SqlSessionTemplateTSqlSessionInterceptor.invoke(SqlSessionTemplate.java:433)\r\n	... 158 more\r\n'),
(776,'ÂºÇÂ∏∏Êó•Âøó','',134,NULL,NULL,'2018-07-11 19:35:00','Â§±Ë¥•','com.mumu.core.exception.MumuException: ÂΩìÂâçÁî®Êà∑Êó†Êìç‰ΩúÊùÉÈôê\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.execute(ExpenseServiceImpl.java:132)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptorT1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:282)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTTbc9ca91b.execute(<generated>)\r\n	at com.mumu.modular.flowable.controller.ExpenseController.execute(ExpenseController.java:97)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTFastClassBySpringCGLIBTTbf4a8a53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.GeneratedMethodAccessor120.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTEnhancerBySpringCGLIBTT1add13b5.execute(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n'),
(777,'ÂºÇÂ∏∏Êó•Âøó','',1,NULL,NULL,'2018-07-12 09:08:09','Â§±Ë¥•','java.lang.NullPointerException\r\n	at java.util.Calendar.setTime(Calendar.java:1770)\r\n	at org.apache.commons.lang3.time.FastDatePrinter.format(FastDatePrinter.java:472)\r\n	at org.apache.commons.lang3.time.FastDateFormat.format(FastDateFormat.java:439)\r\n	at org.apache.commons.lang3.time.DateFormatUtils.format(DateFormatUtils.java:388)\r\n	at org.apache.commons.lang3.time.DateFormatUtils.format(DateFormatUtils.java:272)\r\n	at com.mumu.core.util.DateUtil.formatDate(DateUtil.java:113)\r\n	at com.mumu.modular.flowable.warpper.FlowableNodeWarpper.warpTheMap(FlowableNodeWarpper.java:30)\r\n	at com.mumu.core.base.warpper.BaseControllerWarpper.warp(BaseControllerWarpper.java:25)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeController.list(FlowableNodeController.java:48)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeControllerTTFastClassBySpringCGLIBTT736007.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeControllerTTEnhancerBySpringCGLIBTT4d313def.list(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n'),
(778,'ÂºÇÂ∏∏Êó•Âøó','',1,NULL,NULL,'2018-07-12 09:10:45','Â§±Ë¥•','java.lang.NullPointerException\r\n	at java.util.Calendar.setTime(Calendar.java:1770)\r\n	at org.apache.commons.lang3.time.FastDatePrinter.format(FastDatePrinter.java:472)\r\n	at org.apache.commons.lang3.time.FastDateFormat.format(FastDateFormat.java:439)\r\n	at org.apache.commons.lang3.time.DateFormatUtils.format(DateFormatUtils.java:388)\r\n	at org.apache.commons.lang3.time.DateFormatUtils.format(DateFormatUtils.java:272)\r\n	at com.mumu.core.util.DateUtil.formatDate(DateUtil.java:113)\r\n	at com.mumu.modular.flowable.warpper.FlowableNodeWarpper.warpTheMap(FlowableNodeWarpper.java:30)\r\n	at com.mumu.core.base.warpper.BaseControllerWarpper.warp(BaseControllerWarpper.java:25)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeController.list(FlowableNodeController.java:48)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeControllerTTFastClassBySpringCGLIBTT736007.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeControllerTTEnhancerBySpringCGLIBTT4d313def.list(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n'),
(779,'ÂºÇÂ∏∏Êó•Âøó','',1,NULL,NULL,'2018-07-12 09:11:15','Â§±Ë¥•','java.lang.NullPointerException\r\n	at java.util.Calendar.setTime(Calendar.java:1770)\r\n	at org.apache.commons.lang3.time.FastDatePrinter.format(FastDatePrinter.java:472)\r\n	at org.apache.commons.lang3.time.FastDateFormat.format(FastDateFormat.java:439)\r\n	at org.apache.commons.lang3.time.DateFormatUtils.format(DateFormatUtils.java:388)\r\n	at org.apache.commons.lang3.time.DateFormatUtils.format(DateFormatUtils.java:272)\r\n	at com.mumu.core.util.DateUtil.formatDate(DateUtil.java:113)\r\n	at com.mumu.modular.flowable.warpper.FlowableNodeWarpper.warpTheMap(FlowableNodeWarpper.java:30)\r\n	at com.mumu.core.base.warpper.BaseControllerWarpper.warp(BaseControllerWarpper.java:25)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeController.list(FlowableNodeController.java:48)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeControllerTTFastClassBySpringCGLIBTT736007.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.FlowableNodeControllerTTEnhancerBySpringCGLIBTT4d313def.list(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n'),
(780,'ÂºÇÂ∏∏Êó•Âøó','',134,NULL,NULL,'2018-07-12 09:21:25','Â§±Ë¥•','java.lang.NullPointerException\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.delete(ExpenseServiceImpl.java:95)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptorT1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:282)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTT68d69d64.delete(<generated>)\r\n	at com.mumu.modular.flowable.controller.ExpenseController.delete(ExpenseController.java:84)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTFastClassBySpringCGLIBTTbf4a8a53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.GeneratedMethodAccessor115.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTEnhancerBySpringCGLIBTTef0572ad.delete(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n'),
(781,'ÂºÇÂ∏∏Êó•Âøó','',134,NULL,NULL,'2018-07-12 09:21:28','Â§±Ë¥•','java.lang.NullPointerException\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImpl.delete(ExpenseServiceImpl.java:95)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTFastClassBySpringCGLIBTTc29259a1.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at com.alibaba.druid.support.spring.stat.DruidStatInterceptor.invoke(DruidStatInterceptor.java:72)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptorT1.proceedWithInvocation(TransactionInterceptor.java:99)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:282)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.service.impl.ExpenseServiceImplTTEnhancerBySpringCGLIBTT68d69d64.delete(<generated>)\r\n	at com.mumu.modular.flowable.controller.ExpenseController.delete(ExpenseController.java:84)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTFastClassBySpringCGLIBTTbf4a8a53.invoke(<generated>)\r\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\r\n	at org.springframework.aop.framework.CglibAopProxyTCglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:738)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\r\n	at org.springframework.aop.aspectj.MethodInvocationProceedingJoinPoint.proceed(MethodInvocationProceedingJoinPoint.java:85)\r\n	at com.mumu.core.intercept.SessionHolderInterceptor.sessionKit(SessionHolderInterceptor.java:30)\r\n	at sun.reflect.GeneratedMethodAccessor115.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethodWithGivenArgs(AbstractAspectJAdvice.java:629)\r\n	at org.springframework.aop.aspectj.AbstractAspectJAdvice.invokeAdviceMethod(AbstractAspectJAdvice.java:618)\r\n	at org.springframework.aop.aspectj.AspectJAroundAdvice.invoke(AspectJAroundAdvice.java:70)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\r\n	at org.springframework.aop.framework.CglibAopProxyTDynamicAdvisedInterceptor.intercept(CglibAopProxy.java:673)\r\n	at com.mumu.modular.flowable.controller.ExpenseControllerTTEnhancerBySpringCGLIBTTef0572ad.delete(<generated>)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\r\n	at java.lang.reflect.Method.invoke(Method.java:498)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:133)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:97)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:827)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:738)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:85)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:967)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:901)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:970)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:872)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:661)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:846)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:742)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:52)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:61)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.executeChain(AdviceFilter.java:108)\r\n	at org.apache.shiro.web.servlet.AdviceFilter.doFilterInternal(AdviceFilter.java:137)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.shiro.web.servlet.ProxiedFilterChain.doFilter(ProxiedFilterChain.java:66)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.executeChain(AbstractShiroFilter.java:449)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilterT1.call(AbstractShiroFilter.java:365)\r\n	at org.apache.shiro.subject.support.SubjectCallable.doCall(SubjectCallable.java:90)\r\n	at org.apache.shiro.subject.support.SubjectCallable.call(SubjectCallable.java:83)\r\n	at org.apache.shiro.subject.support.DelegatingSubject.execute(DelegatingSubject.java:387)\r\n	at org.apache.shiro.web.servlet.AbstractShiroFilter.doFilterInternal(AbstractShiroFilter.java:362)\r\n	at org.apache.shiro.web.servlet.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:125)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.mumu.core.xss.XssFilter.doFilter(XssFilter.java:31)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at com.alibaba.druid.support.http.WebStatFilter.doFilter(WebStatFilter.java:123)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HttpPutFormContentFilter.doFilterInternal(HttpPutFormContentFilter.java:108)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:81)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:197)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:199)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:478)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:140)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:81)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:87)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:342)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:803)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocolTConnectionHandler.process(AbstractProtocol.java:868)\r\n	at org.apache.tomcat.util.net.NioEndpointTSocketProcessor.doRun(NioEndpoint.java:1459)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1142)\r\n	at java.util.concurrent.ThreadPoolExecutorTWorker.run(ThreadPoolExecutor.java:617)\r\n	at org.apache.tomcat.util.threads.TaskThreadTWrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Thread.java:745)\r\n');

/*Table structure for table `sys_relation` */

DROP TABLE IF EXISTS `sys_relation`;

CREATE TABLE `sys_relation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆ',
  `menuid` bigint(11) DEFAULT NULL COMMENT 'ËèúÂçïid',
  `roleid` int(11) DEFAULT NULL COMMENT 'ËßíËâ≤id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4501 DEFAULT CHARSET=utf8 COMMENT='ËßíËâ≤ÂíåËèúÂçïÂÖ≥ËÅîË°®';

/*Data for the table `sys_relation` */

insert  into `sys_relation`(`id`,`menuid`,`roleid`) values 
(3377,105,5),
(3378,106,5),
(3379,107,5),
(3380,108,5),
(3381,109,5),
(3382,110,5),
(3383,111,5),
(3384,112,5),
(3385,113,5),
(3386,114,5),
(3387,115,5),
(3388,116,5),
(3389,117,5),
(3390,118,5),
(3391,119,5),
(3392,120,5),
(3393,121,5),
(3394,122,5),
(3395,150,5),
(3396,151,5),
(4343,105,12),
(4344,128,12),
(4345,134,12),
(4346,159,12),
(4347,175,12),
(4348,176,12),
(4349,130,12),
(4350,141,12),
(4351,142,12),
(4352,143,12),
(4353,144,12),
(4354,145,12),
(4355,148,12),
(4356,149,12),
(4357,168,12),
(4358,169,12),
(4359,105,10),
(4360,141,10),
(4361,142,10),
(4362,143,10),
(4363,144,10),
(4364,145,10),
(4365,168,10),
(4366,169,10),
(4367,170,10),
(4368,105,1),
(4369,106,1),
(4370,107,1),
(4371,108,1),
(4372,109,1),
(4373,110,1),
(4374,111,1),
(4375,112,1),
(4376,167,1),
(4377,114,1),
(4378,115,1),
(4379,116,1),
(4380,117,1),
(4381,118,1),
(4382,164,1),
(4383,119,1),
(4384,120,1),
(4385,121,1),
(4386,122,1),
(4387,151,1),
(4388,128,1),
(4389,134,1),
(4390,159,1),
(4391,175,1),
(4392,176,1),
(4393,130,1),
(4394,131,1),
(4395,135,1),
(4396,136,1),
(4397,137,1),
(4398,153,1),
(4399,154,1),
(4400,132,1),
(4401,138,1),
(4402,139,1),
(4403,140,1),
(4404,156,1),
(4405,157,1),
(4406,133,1),
(4407,160,1),
(4408,161,1),
(4409,141,1),
(4410,142,1),
(4411,143,1),
(4412,144,1),
(4413,145,1),
(4414,148,1),
(4415,149,1),
(4416,168,1),
(4417,169,1),
(4418,170,1),
(4419,177,1),
(4420,105,6),
(4421,128,6),
(4422,134,6),
(4423,159,6),
(4424,175,6),
(4425,176,6),
(4426,130,6),
(4427,133,6),
(4428,160,6),
(4429,161,6),
(4430,141,6),
(4431,142,6),
(4432,143,6),
(4433,144,6),
(4434,145,6),
(4435,148,6),
(4436,149,6),
(4437,168,6),
(4438,169,6),
(4439,170,6),
(4471,105,13),
(4472,106,13),
(4473,107,13),
(4474,108,13),
(4475,109,13),
(4476,110,13),
(4477,111,13),
(4478,112,13),
(4479,167,13),
(4480,114,13),
(4481,115,13),
(4482,116,13),
(4483,117,13),
(4484,118,13),
(4485,164,13),
(4486,130,13),
(4487,131,13),
(4488,135,13),
(4489,136,13),
(4490,137,13),
(4491,153,13),
(4492,154,13),
(4493,141,13),
(4494,142,13),
(4495,143,13),
(4496,144,13),
(4497,145,13),
(4498,168,13),
(4499,169,13),
(4500,170,13);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆid',
  `num` int(11) DEFAULT NULL COMMENT 'Â∫èÂè∑',
  `pid` int(11) DEFAULT NULL COMMENT 'Áà∂ËßíËâ≤id',
  `name` varchar(255) DEFAULT NULL COMMENT 'ËßíËâ≤ÂêçÁß∞',
  `tips` varchar(255) DEFAULT NULL COMMENT 'ÊèêÁ§∫',
  `version` int(11) DEFAULT NULL COMMENT '‰øùÁïôÂ≠óÊÆµ(ÊöÇÊó∂Ê≤°Áî®Ôºâ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='ËßíËâ≤Ë°®';

/*Data for the table `sys_role` */

insert  into `sys_role`(`id`,`num`,`pid`,`name`,`tips`,`version`) values 
(1,1,0,'Ë∂ÖÁ∫ßÁÆ°ÁêÜÂëò','administrator',1),
(5,2,1,'‰∏¥Êó∂Áî®Êà∑','temp',NULL),
(6,3,14,'ÂºÄÂèëÈÉ®ÈÉ®Èïø','devMinister',NULL),
(8,3,10,'Ë¥¢Âä°‰∏ìÂëò','finance_specialist',NULL),
(10,2,14,'Ë¥¢Âä°ÁªèÁêÜ','financial_manager',NULL),
(12,2,6,'JavaÂ∑•Á®ãÂ∏à','java_developer',NULL),
(13,2,0,'È¶ñÂ∏≠Ëë£‰∫ãÈïø','boss',NULL),
(14,1,13,'ÊÄªÁªèÁêÜ','general_manager',NULL),
(15,3,14,'ËøêÁª¥ÈÉ®ÈÉ®Èïø','operation_minister',NULL),
(16,4,15,'ËøêÁª¥Â∑•Á®ãÂ∏à','operation_developer',NULL),
(17,4,6,'CËØ≠Ë®ÄÂ∑•Á®ãÂ∏à','c_developer',NULL),
(18,3,14,'ÈááË¥≠ÈÉ®Èïø','purchasing_manager',NULL),
(19,3,14,'ÂêéÂã§ÈÉ®ÈÉ®Èïø','logistics_director',NULL),
(20,4,18,'ÈááË¥≠‰∏ìÂëò','purchasing_officer',NULL),
(21,3,14,'‰∫∫‰∫ãÈÉ®ÈÉ®Èïø','personnel_minister',NULL),
(22,4,21,'‰∫∫‰∫ã‰∏ìÂëò','personnel_officer',NULL);

/*Table structure for table `sys_user` */

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '‰∏ªÈîÆid',
  `avatar` varchar(255) DEFAULT NULL COMMENT 'Â§¥ÂÉè',
  `account` varchar(45) DEFAULT NULL COMMENT 'Ë¥¶Âè∑',
  `password` varchar(45) DEFAULT NULL COMMENT 'ÂØÜÁ†Å',
  `salt` varchar(45) DEFAULT NULL COMMENT 'md5ÂØÜÁ†ÅÁõê',
  `name` varchar(45) DEFAULT NULL COMMENT 'ÂêçÂ≠ó',
  `birthday` datetime DEFAULT NULL COMMENT 'ÁîüÊó•',
  `sex` int(11) DEFAULT NULL COMMENT 'ÊÄßÂà´Ôºà1ÔºöÁî∑ 2ÔºöÂ•≥Ôºâ',
  `email` varchar(45) DEFAULT NULL COMMENT 'ÁîµÂ≠êÈÇÆ‰ª∂',
  `phone` varchar(45) DEFAULT NULL COMMENT 'ÁîµËØù',
  `roleId` varchar(255) DEFAULT NULL COMMENT 'ËßíËâ≤id',
  `deptId` int(11) DEFAULT NULL COMMENT 'ÈÉ®Èó®id',
  `status` int(11) DEFAULT NULL COMMENT 'Áä∂ÊÄÅ(1ÔºöÂêØÁî®  2ÔºöÂÜªÁªì  3ÔºöÂà†Èô§Ôºâ',
  `createtime` datetime DEFAULT NULL COMMENT 'ÂàõÂª∫Êó∂Èó¥',
  `version` int(11) DEFAULT NULL COMMENT '‰øùÁïôÂ≠óÊÆµ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 COMMENT='ÁÆ°ÁêÜÂëòË°®';

/*Data for the table `sys_user` */

insert  into `sys_user`(`id`,`avatar`,`account`,`password`,`salt`,`name`,`birthday`,`sex`,`email`,`phone`,`roleId`,`deptId`,`status`,`createtime`,`version`) values 
(1,'E:/xiahui/fileUpload/707b5d50-57b2-40db-b56f-2bac3f4f37db.jpg','xiahui','2453a99d654c84f56ce6c794239b34c4','jc9qf','Â§èËæâ','1991-02-04 08:00:00',1,'1398145235@qq.com','18751907450','1',25,1,'2018-07-07 10:08:17',25),
(133,NULL,'huangyongjian','68cb2bb63c1b1aca9c7f646cf5b01fed','hxbwo','ÈªÑÊ∞∏ÂÅ•',NULL,1,NULL,NULL,'6',25,1,'2018-07-02 21:43:52',NULL),
(134,NULL,'jiduorui','c1985d4344784b979ebb35a3c72bc4d1','he7q8','Á∫™Â§öÁëû','1992-07-01 08:00:00',1,NULL,NULL,'12',76,1,'2018-07-02 22:02:15',NULL),
(136,NULL,'chenhaitao','83b1cf6c24691e8cf8b9280446ac7efa','rz6w8','ÈôàÊµ∑Ê∂õ','1987-07-08 09:00:00',1,NULL,NULL,'10',77,1,'2018-07-02 22:57:56',NULL),
(137,NULL,'xiadaoquan','38c80f0bb4db98e07d6186774594c905','ls0bt','Â§èÈÅìÂÖ®','1964-09-17 08:00:00',1,NULL,NULL,'13',24,1,'2018-07-03 10:20:58',NULL),
(139,NULL,'fanfan','530262c76303192ab5cc5436e4bbc5d9','itg4j','ËåÉÂ∏Ü','1991-01-05 08:00:00',2,NULL,NULL,'1',25,1,'2018-07-11 10:11:04',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
