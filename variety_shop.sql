/*
 Navicat Premium Data Transfer

 Source Server         : 123
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : variety_shop

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 17/07/2022 16:24:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `merchant` char(15) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `goodsName` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `goodsNumber` char(150) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `goodsPrice` double(20, 2) NULL DEFAULT NULL,
  `goodsDate` char(15) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsClassify` char(15) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsPicture` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsIntroduce` varchar(5000) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsMade` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsAmount` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`goodsNumber`) USING BTREE,
  INDEX `merchant`(`merchant`) USING BTREE,
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`merchant`) REFERENCES `user` (`merchant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('商家一号', '商品三号', '1215', 25.00, '2020', '零食类', '1591774163254.jpg', '使得否', '使得否', 324);
INSERT INTO `goods` VALUES ('商家一号', '商品一号', '1235sdf', 100.00, '2020-05-10', '运动类', '1591774304198.jpg', '一二三', '这里', 19);
INSERT INTO `goods` VALUES ('商家二号', '商品四号', '153', 3515.00, '531', '生活用品类', '1591774146620.jpg', '531', '大是大非', 50);
INSERT INTO `goods` VALUES ('333', 'wei23', '32', 23.00, '23', '运动类', '1593336525296.jpg', '32', '32', 33);
INSERT INTO `goods` VALUES ('333', '4fdw3', '3244df', 345.00, 'fg', '运动类', 'a.jpg', 'dfg', '4fdg', 44);
INSERT INTO `goods` VALUES ('333', 'wei', '333ee', 33.00, 'ewr', '运动类', '微信图片_20201216215040.png', 'wer', 'wer', 43);
INSERT INTO `goods` VALUES ('商家一号', '设计', '6125时代', 31151.00, '使得否', '生活用品类', '1591094172276.jpg', '使得否', '时代', 33);
INSERT INTO `goods` VALUES ('商家一号', '商品二号', '65464d', 330.00, '2020-10-01', '运动类', '1591094196340.jpg', '读书法', '第三方', 29);
INSERT INTO `goods` VALUES ('333', '342', 'ds32', 234.00, 'dsf32', '运动类', '1.jpg', '23fds', '324', 333);
INSERT INTO `goods` VALUES ('333', '12gffd', 'sdf', 43.00, '34g', '运动类', '批注 2019-09-06 113956.png', 'dfgfd', 'dfgf', 343);
INSERT INTO `goods` VALUES ('333', 'sdfsd手动阀手动阀', 's地方胜多负少', 334.00, '读书法', '运动类', '1591091342477.jpg', 'sd发', 'f方法', 34);
INSERT INTO `goods` VALUES ('333', 'd是树算法', '地方上33', 34.00, '倒数', '运动类', '1591088919124.jpg', 'ds发', '使得否', 332);
INSERT INTO `goods` VALUES ('333', '房贷首付是', '时代', 434.00, '3发', '运动类', '1591774304198.jpg', '倒数f', '是发', 34);
INSERT INTO `goods` VALUES ('333', '现场v出现说得到f', '时代分四段3', 554.00, '读书法', '生活用品类', '1591094371172.jpg', 's的发', '时代发', 445);

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message`  (
  `number` int(0) NOT NULL AUTO_INCREMENT,
  `username` char(15) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `merchant` char(20) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `mess` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`number`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 92 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES (46, '222', 'sdfds', '222:sddd');
INSERT INTO `message` VALUES (47, '222', 'sdfds', '222:cdscdsd');
INSERT INTO `message` VALUES (48, '222', 'sdfds', '222:sdsd');
INSERT INTO `message` VALUES (49, '222', 'sdfds', '222:fdgsfd');
INSERT INTO `message` VALUES (50, '222', '333', '222:hahahah');
INSERT INTO `message` VALUES (51, '222', '333', '222:sdfsd ');
INSERT INTO `message` VALUES (55, '222', '333', '222:傻逼\r\n');
INSERT INTO `message` VALUES (56, '222', '333', '222:sdsfds 是否是s');
INSERT INTO `message` VALUES (57, '222', '333', '222:sdfsdf ');
INSERT INTO `message` VALUES (58, '222', '333', '222:手动阀手动阀');
INSERT INTO `message` VALUES (59, '222', '333', '333:？？？嘲讽我？？');
INSERT INTO `message` VALUES (60, '222', '333', '222:xzc');
INSERT INTO `message` VALUES (61, '222', 'sdfds', '222:fdg  fdg fd');
INSERT INTO `message` VALUES (62, '222', 'sdfds', '222:撒旦发射点收到f收到');
INSERT INTO `message` VALUES (63, '222', '333', '222:热TV二TV娥');
INSERT INTO `message` VALUES (64, '222', 'sdfds', '222:方法');
INSERT INTO `message` VALUES (65, '222', '333', '222:订单');
INSERT INTO `message` VALUES (66, '客户一号', '商家一号', '客户一号:麻烦快点发货！');
INSERT INTO `message` VALUES (67, '客户一号', '商家一号', '商家一号:好的，马上发货');
INSERT INTO `message` VALUES (68, '客户一号', '商家一号', '客户一号:麻溜点');
INSERT INTO `message` VALUES (69, '客户一号', '商家二号', '客户一号:你好');
INSERT INTO `message` VALUES (70, '客户二号', '商家二号', '客户二号:我是客户二号');
INSERT INTO `message` VALUES (71, '222', 'sdfds', '222:使得否');
INSERT INTO `message` VALUES (72, '222', 'sdfds', '222:使得否');
INSERT INTO `message` VALUES (73, '222', 'sdfds', '222:使得否');
INSERT INTO `message` VALUES (74, '222', 'sdfds', '222:使得否');
INSERT INTO `message` VALUES (75, '222', '333', '333:读书法');
INSERT INTO `message` VALUES (79, '222', 'sdfds', '222:时代');
INSERT INTO `message` VALUES (80, '222', 'sdfds', '222:放大');
INSERT INTO `message` VALUES (81, '222', 'sdfds', '222:的v');
INSERT INTO `message` VALUES (82, '222', '333', '222:发给');
INSERT INTO `message` VALUES (90, '222', '333', '222:请尽快发货');
INSERT INTO `message` VALUES (91, '222', '333', '222:感谢');
INSERT INTO `message` VALUES (92, '客户一号', '商家一号', '客户一号:jhfk s\r\n');

-- ----------------------------
-- Table structure for orderform
-- ----------------------------
DROP TABLE IF EXISTS `orderform`;
CREATE TABLE `orderform`  (
  `userName` char(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `orderID` int(0) NOT NULL AUTO_INCREMENT,
  `goodsNumber` char(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsName` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsAmount` int(0) NULL DEFAULT NULL,
  `goodsPrice` double(255, 2) NULL DEFAULT NULL,
  `useraddress` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `userPhone` int(0) NULL DEFAULT NULL,
  `merchant` char(15) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `status` varchar(20) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderID`) USING BTREE,
  INDEX `merchant`(`merchant`) USING BTREE,
  CONSTRAINT `orderform_ibfk_1` FOREIGN KEY (`merchant`) REFERENCES `user` (`merchant`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderform
-- ----------------------------
INSERT INTO `orderform` VALUES ('客户一号', 23, '1235sdf', '商品一号', 1, 100.00, '玫瑰楼', 516543, '商家一号', '已完成');
INSERT INTO `orderform` VALUES ('客户一号', 24, '1215', '商品三号', 2, 25.00, '玫瑰楼', 516543, '商家一号', '已完成');
INSERT INTO `orderform` VALUES ('客户一号', 25, '65464d', '商品二号', 1, 330.00, '玫瑰楼', 516543, '商家一号', '已完成');
INSERT INTO `orderform` VALUES ('222', 30, 'dsf', 'sdfsdf', 1, 43.00, '6154', 1645, '333', '已完成');
INSERT INTO `orderform` VALUES ('222', 31, 'er223', 'were', 1, 33.00, '6154', 1645, '333', '已完成');
INSERT INTO `orderform` VALUES ('222', 32, '地方上33', 'd是树算法', 2, 34.00, '6154', 1645, '333', '已完成');

-- ----------------------------
-- Table structure for shoppingform
-- ----------------------------
DROP TABLE IF EXISTS `shoppingform`;
CREATE TABLE `shoppingform`  (
  `userName` char(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `goodsNumber` char(150) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsName` varchar(100) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `goodsPrice` double(20, 2) NULL DEFAULT NULL,
  `goodsAmount` int(0) NULL DEFAULT NULL,
  INDEX `userName`(`userName`) USING BTREE,
  CONSTRAINT `shoppingform_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shoppingform
-- ----------------------------
INSERT INTO `shoppingform` VALUES ('sdf', '151', '哈哈', 562.00, 2);
INSERT INTO `shoppingform` VALUES ('sdf', 'd', 'd', 3.00, 13);
INSERT INTO `shoppingform` VALUES ('222', '1215', '商品三号', 25.00, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `WaterNumber` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NOT NULL,
  `password` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` int(0) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `username` char(10) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  `merchant` char(15) CHARACTER SET gb2312 COLLATE gb2312_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`WaterNumber`) USING BTREE,
  INDEX `username`(`username`) USING BTREE,
  INDEX `username_2`(`username`, `merchant`) USING BTREE,
  INDEX `merchant`(`merchant`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('0', '333', 46, 'sdf', NULL, '333');
INSERT INTO `user` VALUES ('1', '111', 15313, 'gdskf', '111', NULL);
INSERT INTO `user` VALUES ('1235ss', '123', 516543, '玫瑰楼', '客户一号', NULL);
INSERT INTO `user` VALUES ('15153', 'sss', 111, 'dsss', NULL, 'sss');
INSERT INTO `user` VALUES ('2554d', '123', 12345678, '五邑大学', NULL, '商家一号');
INSERT INTO `user` VALUES ('4', '222', 1645, '6154', '222', NULL);
INSERT INTO `user` VALUES ('513', '123', 1351, '5313', NULL, '商家二号');
INSERT INTO `user` VALUES ('531', '2222', 515, '351', 'sdf', NULL);
INSERT INTO `user` VALUES ('ds', '123', 651121, 'sdf', '客户二号', NULL);
INSERT INTO `user` VALUES ('sss', 'sss', 0, 'sss', NULL, 'sss');

SET FOREIGN_KEY_CHECKS = 1;
