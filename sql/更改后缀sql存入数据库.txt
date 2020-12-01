/*
Navicat MySQL Data Transfer

Source Server         : test
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : forum

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2020-12-01 21:26:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `tb_album`
-- ----------------------------
DROP TABLE IF EXISTS `tb_album`;
CREATE TABLE `tb_album` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '相册表id',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `picture` varchar(255) DEFAULT NULL COMMENT '封面图片',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_album
-- ----------------------------
INSERT INTO `tb_album` VALUES ('20', '秋', 'xc.jpg', '2018-04-28 11:57:30', '12');
INSERT INTO `tb_album` VALUES ('27', '大明星', '20180504113333.jpg', '2018-05-04 11:33:33', '24');
INSERT INTO `tb_album` VALUES ('30', '游戏', '20180504131323.jpg', '2018-05-04 13:13:23', '11');
INSERT INTO `tb_album` VALUES ('31', '学习', '20180504143731.jpg', '2018-05-04 14:37:31', '11');
INSERT INTO `tb_album` VALUES ('32', '同学', '20180505115945.jpg', '2018-05-05 11:59:45', '11');
INSERT INTO `tb_album` VALUES ('34', '联欢会', '20180508103814.jpg', '2018-05-08 10:38:14', '44');
INSERT INTO `tb_album` VALUES ('35', '123123123', '20180511232111.jpg', '2018-05-11 23:21:11', '33');
INSERT INTO `tb_album` VALUES ('36', '123123123', '20180511232134.jpg', '2018-05-11 23:21:34', '33');
INSERT INTO `tb_album` VALUES ('37', '额', '20180512105353.jpg', '2018-05-12 10:53:53', '11');
INSERT INTO `tb_album` VALUES ('38', '123', '20180808212609.jpg', '2018-08-08 21:26:09', '11');
INSERT INTO `tb_album` VALUES ('39', '落日有感', '20201118202409.jpg', '2020-11-18 20:24:09', '11');

-- ----------------------------
-- Table structure for `tb_argument`
-- ----------------------------
DROP TABLE IF EXISTS `tb_argument`;
CREATE TABLE `tb_argument` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '言论表id',
  `property` varchar(10) DEFAULT NULL COMMENT '言论属性：1.提问，2.分享',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `publishTime` datetime DEFAULT NULL COMMENT '发表时间',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_argument
-- ----------------------------
INSERT INTO `tb_argument` VALUES ('1', '1', '量里子学', '123123', '2018-05-01 20:45:37', '30');
INSERT INTO `tb_argument` VALUES ('2', '2', '哲学的魅力', '123', '2018-04-01 20:45:37', '9');
INSERT INTO `tb_argument` VALUES ('3', '1', '微观世界', '123', '2018-04-21 20:45:37', '11');
INSERT INTO `tb_argument` VALUES ('4', '2', '狭义相对论', '狭义相对论（Special Theory of Relativity）是阿尔伯特·爱因斯坦在1905年发表的题为 《论动体的电动力学》一文中提出的区别于牛顿时空观的新的平直时空理论。', '2018-04-06 20:45:37', '11');
INSERT INTO `tb_argument` VALUES ('5', '1', '地球引力', '3121', '2018-05-02 20:45:37', '18');
INSERT INTO `tb_argument` VALUES ('6', '2', '英雄联盟', '23123', '2018-04-06 20:45:37', '17');
INSERT INTO `tb_argument` VALUES ('9', '1', '科学的力量', '123', '2018-04-01 20:45:37', '11');
INSERT INTO `tb_argument` VALUES ('10', '2', '敬畏生命', '123', '2018-03-30 20:45:37', '11');
INSERT INTO `tb_argument` VALUES ('11', '2', '人类和平', '人来和平，自由民主', '2018-03-26 11:22:49', '11');
INSERT INTO `tb_argument` VALUES ('16', '1', '良好营商环境', '党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。', '2018-03-28 12:03:08', '11');
INSERT INTO `tb_argument` VALUES ('17', '2', '132', '1231312312312313123123', '2018-05-02 14:37:47', '11');
INSERT INTO `tb_argument` VALUES ('18', '2', '论当代社会的科技发展情况', '当代科技发展之快，整的是无人能比的上，由于互联网的进步。', '2018-05-02 14:41:46', '11');
INSERT INTO `tb_argument` VALUES ('19', '2', '论当代社会的科技发展情况', '当代科技发展之快，整的是无人能比的上，由于互联网的进步。', '2018-05-02 14:44:12', '11');
INSERT INTO `tb_argument` VALUES ('20', '1', '123', '13123123123123123123123', '2018-05-04 11:41:43', '24');
INSERT INTO `tb_argument` VALUES ('21', '1', '而特', '的滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答滴滴答答的', '2018-05-04 14:36:38', '11');
INSERT INTO `tb_argument` VALUES ('22', '2', '赤峰红山文化', '赤峰红山文化博大精深111111111111111111111111111111111111', '2018-05-08 10:37:37', '44');
INSERT INTO `tb_argument` VALUES ('23', '1', '为什么天蓝的', '切切切切切切切切切切切切切切切切切切切切切切切切切切切切切切', '2018-05-08 10:42:49', '44');
INSERT INTO `tb_argument` VALUES ('24', '2', '132', '123123123123123', '2020-11-18 20:21:52', '11');

-- ----------------------------
-- Table structure for `tb_comment`
-- ----------------------------
DROP TABLE IF EXISTS `tb_comment`;
CREATE TABLE `tb_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '讨论表id',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `dateTimes` datetime DEFAULT NULL COMMENT '时间',
  `argumentId` int(11) DEFAULT NULL COMMENT '言论id',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_comment
-- ----------------------------
INSERT INTO `tb_comment` VALUES ('1', '哈哈哈哈哈', '2018-03-28 14:17:08', '10', '9');
INSERT INTO `tb_comment` VALUES ('3', '这种情况下，你可以为控件添加 aria-label 属性。', '2018-04-27 14:17:15', '16', '30');
INSERT INTO `tb_comment` VALUES ('4', '不错', '2018-04-27 15:39:54', '4', '9');
INSERT INTO `tb_comment` VALUES ('5', '客观评价', '2018-04-27 15:40:52', '4', '17');
INSERT INTO `tb_comment` VALUES ('6', '非常好的论文', '2018-04-27 16:52:13', '4', '18');
INSERT INTO `tb_comment` VALUES ('9', '这是干什么。。。。。一堆数字', '2018-05-02 14:44:44', '5', '11');
INSERT INTO `tb_comment` VALUES ('10', '写的不错', '2018-05-04 11:44:19', '20', '11');
INSERT INTO `tb_comment` VALUES ('11', '请问', '2018-05-05 16:54:22', '11', '11');
INSERT INTO `tb_comment` VALUES ('12', '请问', '2018-05-05 16:54:39', '21', '11');
INSERT INTO `tb_comment` VALUES ('13', '这个咋说了，看不懂。。。❤', '2018-05-07 11:10:21', '19', '11');
INSERT INTO `tb_comment` VALUES ('14', '好，厉害了', '2018-05-08 10:37:56', '22', '44');
INSERT INTO `tb_comment` VALUES ('15', '请问权威', '2018-05-08 10:48:46', '23', '44');
INSERT INTO `tb_comment` VALUES ('16', '123', '2018-05-08 11:15:17', '23', '44');
INSERT INTO `tb_comment` VALUES ('17', '微巨塔防', '2018-05-12 10:51:56', '23', '11');

-- ----------------------------
-- Table structure for `tb_friend`
-- ----------------------------
DROP TABLE IF EXISTS `tb_friend`;
CREATE TABLE `tb_friend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '朋友表id',
  `friendId` int(11) DEFAULT NULL COMMENT '用户id',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `dateTimes` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_friend
-- ----------------------------

-- ----------------------------
-- Table structure for `tb_information`
-- ----------------------------
DROP TABLE IF EXISTS `tb_information`;
CREATE TABLE `tb_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '新闻资讯表id',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `picture` varchar(255) DEFAULT NULL COMMENT '图片',
  `link` varchar(255) DEFAULT NULL COMMENT '链接',
  `dateTimes` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_information
-- ----------------------------
INSERT INTO `tb_information` VALUES ('1', '坚决贯彻落实', '党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。这是在新的历史起点上，以习近平同志为核心的党中央对简政放权改革作出的重大部署，为下一步持续转变政府职能、建设人民满意的服务型政府指明了方向、提供了行动指南。我们要深刻学习领会、坚决贯彻落实。 ', '20180425100350.jpg', null, '2018-04-04 13:32:55');
INSERT INTO `tb_information` VALUES ('2', '我们要深刻学习领会', '党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。这是在新的历史起点上，以习近平同志为核心的党中央对简政放权改革作出的重大部署，为下一步持续转变政府职能、建设人民满意的服务型政府指明了方向、提供了行动指南。我们要深刻学习领会、坚决贯彻落实。 ', '20180425100350.jpg', null, '2018-04-13 13:32:58');
INSERT INTO `tb_information` VALUES ('3', '十九届三中全会', '												党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。这是在新的历史起点上', 'new.jpg', 'https://www.baidu.com/', '2018-04-21 13:33:01');
INSERT INTO `tb_information` VALUES ('4', '放权改革', '党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。这是在新的历史起点上，以习近平同志为核心的党中央对简政放权改革作出的重大部署，为下一步持续转变政府职能、建设人民满意的服务型政府指明了方向、提供了行动指南。我们要深刻学习领会、坚决贯彻落实。 ', 'new.jpg', null, '2018-04-06 13:33:04');
INSERT INTO `tb_information` VALUES ('5', '历史起点上', '党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。这是在新的历史起点上，以习近平同志为核心的党中央对简政放权改革作出的重大部署，为下一步持续转变政府职能、建设人民满意的服务型政府指明了方向、提供了行动指南。我们要深刻学习领会、坚决贯彻落实。 ', 'new.jpg', null, '2018-03-31 13:33:07');
INSERT INTO `tb_information` VALUES ('6', '大幅降低制度性交易成本', '党的十九届三中全会审议通过的《中共中央关于深化党和国家机构改革的决定》指出，要深入推进简政放权，提高资源配置效率和公平性，大幅降低制度性交易成本，营造良好营商环境。这是在新的历史起点上，以习近平同志为核心的党中央对简政放权改革作出的重大部署，为下一步持续转变政府职能、建设人民满意的服务型政府指明了方向、提供了行动指南。我们要深刻学习领会、坚决贯彻落实。 ', 'new.jpg', null, '2018-04-04 13:33:10');
INSERT INTO `tb_information` VALUES ('13', '赤峰学院', '赤峰学院是2003年4月16日经国家教育部批准，由赤峰民族师范高等专科学校、赤峰教育学院、内蒙古广播电视大学赤峰分校三所专科层次的高校合并，同时并入赤峰卫校、内蒙古幼儿师范学校的部分资源组建的一所多学科、综合性普通本科高等学校。', '1.jpg', 'http://web.cfxy.cn/cfxy/', '2018-05-04 15:07:59');

-- ----------------------------
-- Table structure for `tb_manager`
-- ----------------------------
DROP TABLE IF EXISTS `tb_manager`;
CREATE TABLE `tb_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `name` varchar(50) DEFAULT NULL COMMENT '管理员名字',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `picture` varchar(255) DEFAULT NULL COMMENT '头像',
  `dateTimes` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_manager
-- ----------------------------
INSERT INTO `tb_manager` VALUES ('1', 'admin', '123123', null, '2018-05-03 15:27:44');
INSERT INTO `tb_manager` VALUES ('2', '123', '123', null, null);

-- ----------------------------
-- Table structure for `tb_photo`
-- ----------------------------
DROP TABLE IF EXISTS `tb_photo`;
CREATE TABLE `tb_photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '相片id',
  `picture` varchar(255) DEFAULT NULL COMMENT '相片url',
  `createDate` datetime DEFAULT NULL COMMENT '创建时间',
  `albumId` int(11) DEFAULT NULL COMMENT '相册id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_photo
-- ----------------------------
INSERT INTO `tb_photo` VALUES ('1', '20180428103422.jpg', '2018-04-07 11:44:37', '19');
INSERT INTO `tb_photo` VALUES ('2', '20180422142946.jpg', '2018-04-28 11:44:40', '17');
INSERT INTO `tb_photo` VALUES ('3', '20180428103114.jpg', '2018-04-28 11:44:43', '18');
INSERT INTO `tb_photo` VALUES ('4', '20180305110154.png', '2018-03-29 18:33:54', '17');
INSERT INTO `tb_photo` VALUES ('5', '0501456.jpg', '2018-04-27 18:33:48', '19');
INSERT INTO `tb_photo` VALUES ('6', '20180501104243.jpg', '2018-04-28 13:53:04', '19');
INSERT INTO `tb_photo` VALUES ('8', '20180428153734.jpg', '2018-04-28 15:37:34', '18');
INSERT INTO `tb_photo` VALUES ('9', '20180428155923.jpg', '2018-04-13 15:59:23', '2');
INSERT INTO `tb_photo` VALUES ('13', '20180502151644.jpg', '2018-05-02 15:16:44', '26');
INSERT INTO `tb_photo` VALUES ('14', '20180504113346.jpg', '2018-05-04 11:33:46', '27');
INSERT INTO `tb_photo` VALUES ('15', '20180504144413.jpg', '2018-05-04 14:44:13', '31');
INSERT INTO `tb_photo` VALUES ('16', '20180505120107.jpg', '2018-05-05 12:01:07', '32');
INSERT INTO `tb_photo` VALUES ('17', '20180505120303.jpg', '2018-05-05 12:03:03', '32');
INSERT INTO `tb_photo` VALUES ('18', '20180505120929.jpg', '2018-05-05 12:09:29', '20');
INSERT INTO `tb_photo` VALUES ('19', '20180505130050.jpg', '2018-05-05 13:00:50', '20');
INSERT INTO `tb_photo` VALUES ('20', '20180505130102.jpg', '2018-05-05 13:01:02', '32');
INSERT INTO `tb_photo` VALUES ('21', '20180505154824.jpg', '2018-05-05 15:48:24', '32');
INSERT INTO `tb_photo` VALUES ('22', '20180507132818.jpg', '2018-05-07 13:28:18', '33');
INSERT INTO `tb_photo` VALUES ('23', '20180508103828.jpg', '2018-05-08 10:38:28', '34');
INSERT INTO `tb_photo` VALUES ('24', '20180512105420.jpg', '2018-05-12 10:54:20', '37');
INSERT INTO `tb_photo` VALUES ('25', '20180808212628.jpg', '2018-08-08 21:26:28', '38');
INSERT INTO `tb_photo` VALUES ('26', '20190417221526.txt', '2019-04-17 22:15:26', '37');
INSERT INTO `tb_photo` VALUES ('27', '20190417221553.docx', '2019-04-17 22:15:53', '37');
INSERT INTO `tb_photo` VALUES ('28', '20190417221639.jpg', '2019-04-17 22:16:39', '37');
INSERT INTO `tb_photo` VALUES ('29', '20190417221822.jpg', '2019-04-17 22:18:22', '37');
INSERT INTO `tb_photo` VALUES ('30', '20190417222104.jpg', '2019-04-17 22:21:04', '38');

-- ----------------------------
-- Table structure for `tb_photocomment`
-- ----------------------------
DROP TABLE IF EXISTS `tb_photocomment`;
CREATE TABLE `tb_photocomment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '相片id',
  `content` varchar(255) DEFAULT NULL COMMENT '评论内容',
  `commentDate` datetime DEFAULT NULL COMMENT '评论时间',
  `photoId` int(11) DEFAULT NULL COMMENT '相片id',
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_photocomment
-- ----------------------------
INSERT INTO `tb_photocomment` VALUES ('1', '123', '2018-04-29 21:55:48', '1', '16');
INSERT INTO `tb_photocomment` VALUES ('2', '123', '2018-04-04 21:55:51', '1', '16');
INSERT INTO `tb_photocomment` VALUES ('3', '13', '2018-03-29 21:55:54', '1', '11');
INSERT INTO `tb_photocomment` VALUES ('4', '123', '2018-04-12 21:55:57', '5', '11');
INSERT INTO `tb_photocomment` VALUES ('5', '123', '2018-04-05 21:56:01', '5', '32');
INSERT INTO `tb_photocomment` VALUES ('6', '123', '2018-04-05 21:56:04', '5', '30');
INSERT INTO `tb_photocomment` VALUES ('7', '标致，端庄，贤惠', '2018-04-28 15:26:44', '6', '11');
INSERT INTO `tb_photocomment` VALUES ('11', '123', '2018-05-02 15:17:53', '13', '11');
INSERT INTO `tb_photocomment` VALUES ('12', '好看', '2018-05-04 11:34:04', '14', '24');
INSERT INTO `tb_photocomment` VALUES ('13', '123', '2018-05-05 12:01:16', '16', '11');
INSERT INTO `tb_photocomment` VALUES ('14', '请问', '2018-05-05 15:35:13', '20', '11');
INSERT INTO `tb_photocomment` VALUES ('15', '阿斯达', '2018-05-05 15:35:23', '20', '11');
INSERT INTO `tb_photocomment` VALUES ('16', '请问现在v水电费', '2018-05-05 15:47:54', '20', '11');
INSERT INTO `tb_photocomment` VALUES ('17', '请问', '2018-05-05 15:56:10', '21', '11');
INSERT INTO `tb_photocomment` VALUES ('18', '123', '2018-05-05 15:56:22', '21', '11');
INSERT INTO `tb_photocomment` VALUES ('19', '全球切切切切切切切切切切切切切切切', '2018-05-05 16:57:15', '15', '11');
INSERT INTO `tb_photocomment` VALUES ('20', '123', '2018-05-07 13:27:24', '19', '11');
INSERT INTO `tb_photocomment` VALUES ('21', '132', '2018-05-07 13:28:26', '22', '11');
INSERT INTO `tb_photocomment` VALUES ('22', '这个美女', '2018-05-08 10:38:44', '23', '44');
INSERT INTO `tb_photocomment` VALUES ('23', '谁啊\r\n', '2018-05-08 10:44:06', '23', '44');
INSERT INTO `tb_photocomment` VALUES ('24', '请问', '2018-05-08 10:48:33', '23', '44');

-- ----------------------------
-- Table structure for `tb_user`
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `name` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `mobile` varchar(50) DEFAULT NULL COMMENT '电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `age` varchar(10) DEFAULT NULL COMMENT '年龄',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `address` varchar(100) DEFAULT NULL COMMENT '地址',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别：1.男，2.女',
  `picture` varchar(255) DEFAULT NULL COMMENT '头像',
  `describes` varchar(255) DEFAULT NULL COMMENT '描述',
  `registerDate` datetime DEFAULT NULL COMMENT '注册时间',
  `loginDate` datetime DEFAULT NULL COMMENT '登录时间',
  `dateTimes` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('11', '赵敏', '4297f44b13955235245b2497399d7a93', '15244555544', '121123233@163.com', '23', '2018-12-27', '啦啦啦123', '2', '20201118202349.jpg', '123', '2018-04-29 11:46:02', '2020-11-18 21:03:09', null);
INSERT INTO `tb_user` VALUES ('12', '周芷若', '4297f44b13955235245b2497399d7a93', '15266565859', '123123@163.com', null, null, '123', null, '20180503123454.jpg', null, '2018-04-14 11:46:05', '2018-04-28 11:56:53', null);
INSERT INTO `tb_user` VALUES ('17', '白展堂', '4297f44b13955235245b2497399d7a93', '15266565859', '123123@163.com1', null, null, '1231', null, '20180425100350.jpg', null, '2018-03-30 11:46:08', '2018-03-28 00:00:00', null);
INSERT INTO `tb_user` VALUES ('18', '佟湘玉', '4297f44b13955235245b2497399d7a93', '15266565859', '123123@163.com', null, '2018-05-08', '23123', null, '20180503145030.jpg', null, '2018-04-27 11:46:10', '2018-05-03 14:48:52', null);
INSERT INTO `tb_user` VALUES ('20', '令狐冲', '4297f44b13955235245b2497399d7a93', '15266565859', 'qq@qq.com', null, null, '123', null, '20180503123454.jpg', null, '2018-04-10 11:46:13', '2018-03-31 00:00:00', null);
INSERT INTO `tb_user` VALUES ('24', '任盈盈', '4297f44b13955235245b2497399d7a93', '18747690100', '123@163.com', null, '2018-05-16', '2313', null, '20180503151957.jpg', null, '2018-04-12 11:46:16', '2018-05-04 11:40:20', null);
INSERT INTO `tb_user` VALUES ('25', '小翠', '4297f44b13955235245b2497399d7a93', '15244232720', '123@qq.com', null, null, '1', null, '20180503123454.jpg', null, '2018-05-04 11:46:19', '2018-04-02 00:00:00', null);
INSERT INTO `tb_user` VALUES ('30', '小七', '4297f44b13955235245b2497399d7a93', '15244232720', '123@qq.com', null, null, '1231', null, '20180503123454.jpg', null, '2018-06-10 11:46:22', '2018-03-30 00:00:00', null);
INSERT INTO `tb_user` VALUES ('32', '张三', '4297f44b13955235245b2497399d7a93', '15266565859', '123123@163.com', null, null, '3', null, '20180503123454.jpg', null, null, '2018-04-02 14:25:02', null);
INSERT INTO `tb_user` VALUES ('33', '123', '4297f44b13955235245b2497399d7a93', '15266565859', '123123@163.com', null, null, null, null, '20180503123454.jpg', null, null, '2018-05-11 23:20:40', null);
INSERT INTO `tb_user` VALUES ('35', '123123123', '4297f44b13955235245b2497399d7a93', '18747690100', '1@123.com', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('36', '123111111', 'e11170b8cbd2d74102651cb967fa28e5', '18747690100', '123123@163.com', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('37', '111', '96e79218965eb72c92a549dd5a330112', '18747690100', '111@111', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('38', '122333', '9c7cc2cde1939666d314378b18857721', '18747690100', '123@123', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('39', '12312313', 'f5bb0c8de146c67b44babbf4e6584cc0', '18747690100', '123@123', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('40', '222', 'e3ceb5881a0a1fdaad01296d7554868d', '18747690100', '222@222', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('41', '222', 'e3ceb5881a0a1fdaad01296d7554868d', '18747690100', '222@222', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('42', '222', 'e3ceb5881a0a1fdaad01296d7554868d', '18747690100', '222@222', null, null, null, null, '20180503123454.jpg', null, null, null, null);
INSERT INTO `tb_user` VALUES ('43', '  ', '4297f44b13955235245b2497399d7a93', '123', '123123@163.com', null, null, null, null, '20180422141151.jpg', null, '2018-05-05 10:53:19', null, null);
INSERT INTO `tb_user` VALUES ('44', '六耳', 'd0970714757783e6cf17b26fb8e2298f', '18747690100', '123123@163.com', null, '2004-04-12', '赤峰学院', '1', '20180508103529.jpg', '帅哥一枚', '2018-05-08 10:24:38', '2018-05-08 10:46:10', null);
INSERT INTO `tb_user` VALUES ('45', '123', '123', null, '12313@123', null, null, null, null, null, null, null, null, null);
INSERT INTO `tb_user` VALUES ('46', '123456', '123', null, '132@123123', null, null, null, null, null, null, null, null, null);
INSERT INTO `tb_user` VALUES ('47', '111', '111', null, null, null, null, null, null, null, null, null, null, null);
