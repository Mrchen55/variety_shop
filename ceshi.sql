
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
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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

SET FOREIGN_KEY_CHECKS = 1;
