/*
 Navicat Premium Data Transfer

 Source Server         : mysql8.0
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : mall

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 05/11/2022 13:46:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for addresses
-- ----------------------------
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人姓名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人电话',
  `is_default` tinyint(1) NULL DEFAULT 1 COMMENT '是否是默认地址',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人详细地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of addresses
-- ----------------------------
INSERT INTO `addresses` VALUES (3, '王五', '13545678900', 0, '2021-03-15 19:03:28', '2021-03-15 19:57:17', 2, '北京市朝阳区');
INSERT INTO `addresses` VALUES (5, '李四', '13445678900', 1, '2021-03-15 19:30:04', '2021-03-15 19:57:17', 2, '北京市海淀区');
INSERT INTO `addresses` VALUES (8, '测试地址', '13633663366', 1, '2021-03-16 11:31:18', '2021-03-16 11:31:18', 4, '北京');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `count` int(11) NULL DEFAULT 1 COMMENT '商品数量',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 53 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES (52, 1, '2022-03-29 05:22:58', '2022-03-29 05:22:58', 5, 14);
INSERT INTO `carts` VALUES (53, 1, '2022-11-04 16:54:54', '2022-11-04 16:54:54', 6, 17);

-- ----------------------------
-- Table structure for collections
-- ----------------------------
DROP TABLE IF EXISTS `collections`;
CREATE TABLE `collections`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `collections_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collections
-- ----------------------------
INSERT INTO `collections` VALUES (6, '2021-03-12 16:57:12', '2021-03-12 16:57:12', 2, 2);
INSERT INTO `collections` VALUES (7, '2021-03-15 20:36:17', '2021-03-15 20:36:17', 2, 18);
INSERT INTO `collections` VALUES (8, '2021-03-16 11:30:29', '2021-03-16 11:30:29', 4, 2);

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NULL DEFAULT NULL COMMENT '评分',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `order_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (9, 5, '五星好评', '2021-03-15 22:11:36', '2021-03-15 22:11:36', 39, 15, 2);
INSERT INTO `comments` VALUES (10, 1, '产品不是很满意', '2021-03-15 22:12:46', '2021-03-15 22:12:46', 39, 15, 2);
INSERT INTO `comments` VALUES (11, 2, '还可以', '2021-03-16 11:31:46', '2021-03-16 11:31:46', 40, 18, 4);

-- ----------------------------
-- Table structure for companies
-- ----------------------------
DROP TABLE IF EXISTS `companies`;
CREATE TABLE `companies`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主图',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `brief` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品简介',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of companies
-- ----------------------------
INSERT INTO `companies` VALUES (6, '/upload/20210302/a8dbefc0-7afe-11eb-85c7-55b83ce40e52.jpg', '香水公司', '香水公司', '2021-03-02 02:26:29', '2021-03-03 07:54:24');

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` smallint(6) NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `publisher` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Admin',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES (1, 1, '内地全方位援港抗疫，区议员：香港也要争气，不能拖国家后退', '观察者网', '/upload/20220329/254a6630-af75-11ec-8513-1527696b1ea6.jpg', '2022-03-29 20:07:46', '2022-03-29 20:29:50');
INSERT INTO `news` VALUES (2, 2, '\"70后\"刘强主政济南 成全国最年轻副省级城市\"一把手\"', '上观新闻', '/upload/20220329/254a6630-af75-11ec-8513-1527696b1ea6.jpg', '2022-03-29 20:08:38', '2022-03-29 15:49:30');
INSERT INTO `news` VALUES (3, 2, '姚明回应NBA球员涉华不实言论:希望邀请他来中国看看', '环球网', '/upload/20220329/254a6630-af75-11ec-8513-1527696b1ea6.jpg', '2022-03-29 20:09:41', '2022-03-29 20:29:55');

-- ----------------------------
-- Table structure for newslists
-- ----------------------------
DROP TABLE IF EXISTS `newslists`;
CREATE TABLE `newslists`  (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of newslists
-- ----------------------------
INSERT INTO `newslists` VALUES (1, '军事', '2022-03-29 20:29:33', '2022-03-29 20:29:34');
INSERT INTO `newslists` VALUES (2, '影视1', '2022-03-29 20:29:35', '2022-03-29 14:48:24');

-- ----------------------------
-- Table structure for order_goods
-- ----------------------------
DROP TABLE IF EXISTS `order_goods`;
CREATE TABLE `order_goods`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `good_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品标题',
  `good_image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品主图',
  `good_price` float NULL DEFAULT NULL COMMENT '产品价格',
  `good_num` int(11) NULL DEFAULT NULL COMMENT '产品数量',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `order_id` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `order_goods_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order_goods_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_goods
-- ----------------------------
INSERT INTO `order_goods` VALUES (24, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 18:41:16', '2021-03-14 18:41:16', 27, 18);
INSERT INTO `order_goods` VALUES (25, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 18:43:12', '2021-03-14 18:43:12', 28, 18);
INSERT INTO `order_goods` VALUES (26, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 18:58:19', '2021-03-14 18:58:19', 29, 2);
INSERT INTO `order_goods` VALUES (27, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:08:04', '2021-03-14 19:08:04', 30, 2);
INSERT INTO `order_goods` VALUES (28, '女性香水', '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', 188.88, 1, '2021-03-14 19:44:07', '2021-03-14 19:44:07', 34, 17);
INSERT INTO `order_goods` VALUES (29, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:44:07', '2021-03-14 19:44:07', 34, 18);
INSERT INTO `order_goods` VALUES (30, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:44:17', '2021-03-14 19:44:17', 35, 18);
INSERT INTO `order_goods` VALUES (31, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:44:23', '2021-03-14 19:44:23', 36, 18);
INSERT INTO `order_goods` VALUES (33, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-15 19:57:49', '2021-03-15 19:57:49', 38, 18);
INSERT INTO `order_goods` VALUES (34, '女性香水', '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', 188.88, 1, '2021-03-15 20:32:01', '2021-03-15 20:32:01', 39, 15);
INSERT INTO `order_goods` VALUES (35, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-16 11:31:25', '2021-03-16 11:31:25', 40, 18);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '订单号',
  `total_price` float NULL DEFAULT NULL COMMENT '总价格',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `user_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人手机',
  `user_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收货人地址',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_num`(`order_num`) USING BTREE,
  UNIQUE INDEX `order_num_2`(`order_num`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (27, '1615747276509780451', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 18:41:16', '2021-03-14 18:41:16', 2);
INSERT INTO `orders` VALUES (28, '1615747392127138687', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 18:43:12', '2021-03-14 18:43:12', 2);
INSERT INTO `orders` VALUES (29, '1615748299542146953', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 18:58:19', '2021-03-14 18:58:19', 2);
INSERT INTO `orders` VALUES (30, '1615748884272373773', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:08:04', '2021-03-14 19:08:04', 2);
INSERT INTO `orders` VALUES (34, '1615751047459318229', 876.88, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:44:07', '2021-03-14 19:44:07', 2);
INSERT INTO `orders` VALUES (35, '1615751057508126012', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:44:17', '2021-03-14 19:44:17', 2);
INSERT INTO `orders` VALUES (36, '1615751063603795221', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:44:23', '2021-03-14 19:44:23', 2);
INSERT INTO `orders` VALUES (38, '1615838269183991766', 688, '李四', '13445678900', '北京市海淀区', '2021-03-15 19:57:49', '2021-03-15 19:57:49', 2);
INSERT INTO `orders` VALUES (39, '1615840321891446490', 188.88, '李四', '13445678900', '北京市海淀区', '2021-03-15 20:32:01', '2021-03-15 20:32:01', 2);
INSERT INTO `orders` VALUES (40, '161589428520773746', 688, '测试地址', '13633663366', '北京', '2021-03-16 11:31:25', '2021-03-16 11:31:25', 4);

-- ----------------------------
-- Table structure for perfumes
-- ----------------------------
DROP TABLE IF EXISTS `perfumes`;
CREATE TABLE `perfumes`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主图',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `brief` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品简介',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of perfumes
-- ----------------------------
INSERT INTO `perfumes` VALUES (1, '/upload/20210303/1efbecd0-7bf6-11eb-b270-a3d7f0227ffa.jpg', '男香', '男士香水根据拉丁文\"perfumum\"衍生而来，意思是\"穿透烟雾\"。旧约《圣经》提到香水，通常指一种香料形成，这与拉丁文定义相符。一般上，男性香水可分为四大类，即香精、香水、淡香水及古龙水。', '2021-03-03 00:00:00', '2021-03-03 00:00:00');
INSERT INTO `perfumes` VALUES (2, '/upload/20210303/1efbecd0-7bf6-11eb-b270-a3d7f0227ffa.jpg', '女香', '男士香水根据拉丁文\"perfumum\"衍生而来，意思是\"穿透烟雾\"。旧约《圣经》提到香水，通常指一种香料形成，这与拉丁文定义相符。一般上，男性香水可分为四大类，即香精、香水、淡香水及古龙水。', '2021-03-03 00:00:00', '2021-03-03 00:00:00');
INSERT INTO `perfumes` VALUES (3, '/upload/20210303/1efbecd0-7bf6-11eb-b270-a3d7f0227ffa.jpg', '中性香', '男士香水根据拉丁文\"perfumum\"衍生而来，意思是\"穿透烟雾\"。旧约《圣经》提到香水，通常指一种香料形成，这与拉丁文定义相符。一般上，男性香水可分为四大类，即香精、香水、淡香水及古龙水。', '2021-03-03 00:00:00', '2021-03-03 00:00:00');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品主图',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品标题',
  `price` float NULL DEFAULT NULL COMMENT '产品价格',
  `brief` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品简介',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '产品状态true上架false下架',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  `company_id` int(11) NULL DEFAULT NULL,
  `perfume_id` int(11) NULL DEFAULT NULL,
  `spicer_id` int(11) NULL DEFAULT NULL,
  `hot` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '首页热门',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `company_id`(`company_id`) USING BTREE,
  INDEX `perfume_id`(`perfume_id`) USING BTREE,
  INDEX `spicer_id`(`spicer_id`) USING BTREE,
  CONSTRAINT `products_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_5` FOREIGN KEY (`perfume_id`) REFERENCES `perfumes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_6` FOREIGN KEY (`spicer_id`) REFERENCES `spicers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (2, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1);
INSERT INTO `products` VALUES (3, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (4, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (5, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (6, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1);
INSERT INTO `products` VALUES (7, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (8, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (9, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (10, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1);
INSERT INTO `products` VALUES (11, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (12, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (13, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (14, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1);
INSERT INTO `products` VALUES (15, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (16, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (17, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1);
INSERT INTO `products` VALUES (18, '/upload/20220329/f0742a90-af42-11ec-b534-1ff929867bdb.mp4', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2022-03-29 09:31:02', 6, 2, 1, 1);

-- ----------------------------
-- Table structure for spicers
-- ----------------------------
DROP TABLE IF EXISTS `spicers`;
CREATE TABLE `spicers`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主图',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `brief` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品简介',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of spicers
-- ----------------------------
INSERT INTO `spicers` VALUES (1, '/upload/20210302/351e7610-7aff-11eb-85c7-55b83ce40e52.jpg', '植物香料', '植物香料', '2021-03-02 02:30:23', '2021-03-03 07:54:04');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户密码',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `is_admin` tinyint(1) NULL DEFAULT 0 COMMENT '是否为管理员',
  `created_at` datetime(0) NOT NULL,
  `updated_at` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 1, '2020-02-23 00:00:00', '2021-03-12 17:48:52');
INSERT INTO `users` VALUES (2, 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', '张三', '男', 0, '2020-02-23 00:00:00', '2021-03-16 10:41:28');
INSERT INTO `users` VALUES (3, 'yy0609', 'f66866a19bf12f4bcc4b9dbb6b0575e1', '花花', '女', 0, '2021-03-05 11:24:58', '2021-03-05 11:26:00');
INSERT INTO `users` VALUES (4, 'user01', 'e10adc3949ba59abbe56e057f20f883e', '用户一', '女', 0, '2021-03-16 10:53:38', '2021-03-16 11:02:12');
INSERT INTO `users` VALUES (5, 'test', 'cc03e747a6afbbcbf8be7668acfebee5', '张晓彤', '女', 0, '2022-03-29 05:17:46', '2022-03-29 05:17:46');
INSERT INTO `users` VALUES (6, 'user1', 'e10adc3949ba59abbe56e057f20f883e', '王晓丽', '女', 0, '2022-11-04 16:54:43', '2022-11-05 05:45:29');

SET FOREIGN_KEY_CHECKS = 1;
