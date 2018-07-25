/*
SQLyog Ultimate v12.3.1 (64 bit)
MySQL - 5.7.20-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `sys_dict` (
	`id` int (11),
	`num` int (11),
	`pid` int (11),
	`name` varchar (765),
	`code` varchar (150),
	`tips` varchar (765)
); 
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('16','0','0','状态','STATUS','全局状态');
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('17','1','16','启用','STATUS_ON',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('18','2','16','禁用','STATUS_OFF',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('29','0','0','性别','SEX','性别字典');
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('30','1','29','男','SEX_MAN',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('31','2','29','女','MAN_WOMAN',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('35','0','0','账号状态','ACCOUNT_STATUS','账号状态');
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('36','1','35','启用','ACCOUNT_STATUS_ON',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('37','2','35','冻结','ACCOUNT_STATUS_freeze',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('38','3','35','已删除','ACCOUNT_STATUS_DELETE',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('42','0',NULL,'书籍上下架','BOOK_UPPER','是否上架 1：上架 0：未上架');
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('47','2','42','上架','BOOK_UPPER_ON',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('48','2','42','下架','BOOK_UPPER_OFF',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('49','0',NULL,'删除状态','DELETE',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('50','2','49','未删除','DELETE_NO',NULL);
insert into `sys_dict` (`id`, `num`, `pid`, `name`, `code`, `tips`) values('51','2','49','已删除','DELETE_YES',NULL);
