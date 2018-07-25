/*
SQLyog Ultimate v12.3.1 (64 bit)
MySQL - 5.7.20-log 
*********************************************************************
*/
/*!40101 SET NAMES utf8 */;

create table `weixin_book` (
	`id` int (15),
	`bookName` varchar (90),
	`price` double ,
	`owner` varchar (90),
	`type` varchar (765),
	`deleteFlag` varchar (90),
	`isUpper` varchar (90),
	`createTime` datetime ,
	`updateTime` datetime ,
	`tips` varchar (900)
); 
insert into `weixin_book` (`id`, `bookName`, `price`, `owner`, `type`, `deleteFlag`, `isUpper`, `createTime`, `updateTime`, `tips`) values('1','深入理解JVM虚拟机','10.5','夏辉','技术','DELETE_NO','BOOK_UPPER_ON','2018-07-25 09:30:45','2018-07-25 09:30:47','学习JVM必读书籍');
insert into `weixin_book` (`id`, `bookName`, `price`, `owner`, `type`, `deleteFlag`, `isUpper`, `createTime`, `updateTime`, `tips`) values('2','四人组','5.5','夏辉','技术','DELETE_NO','BOOK_UPPER_ON','2018-07-25 19:49:42','2018-07-25 19:49:45','设计模式');
insert into `weixin_book` (`id`, `bookName`, `price`, `owner`, `type`, `deleteFlag`, `isUpper`, `createTime`, `updateTime`, `tips`) values('3','java编程思想','7.5','夏辉','技术','DELETE_NO','BOOK_UPPER_ON','2018-07-25 19:51:14','2018-07-25 19:51:14','最好的java提升书籍');
