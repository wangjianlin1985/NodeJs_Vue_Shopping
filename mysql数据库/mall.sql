-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.28 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 mall 的数据库结构
CREATE DATABASE IF NOT EXISTS `mall` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mall`;

-- 导出  表 mall.addresses 结构
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT '收件人姓名',
  `phone` varchar(255) DEFAULT NULL COMMENT '收件人电话',
  `is_default` tinyint(1) DEFAULT '1' COMMENT '是否是默认地址',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL COMMENT '收件人详细地址',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.addresses 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` (`id`, `name`, `phone`, `is_default`, `created_at`, `updated_at`, `user_id`, `address`) VALUES
	(3, '王五', '13545678900', 0, '2021-03-15 19:03:28', '2021-03-15 19:57:17', 2, '北京市朝阳区'),
	(5, '李四', '13445678900', 1, '2021-03-15 19:30:04', '2021-03-15 19:57:17', 2, '北京市海淀区'),
	(8, '测试地址', '13633663366', 1, '2021-03-16 11:31:18', '2021-03-16 11:31:18', 4, '北京');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;

-- 导出  表 mall.carts 结构
CREATE TABLE IF NOT EXISTS `carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `count` int DEFAULT '1' COMMENT '商品数量',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.carts 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
INSERT INTO `carts` (`id`, `count`, `created_at`, `updated_at`, `user_id`, `product_id`) VALUES
	(52, 1, '2022-03-29 05:22:58', '2022-03-29 05:22:58', 5, 14);
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;

-- 导出  表 mall.collections 结构
CREATE TABLE IF NOT EXISTS `collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `collections_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.collections 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` (`id`, `created_at`, `updated_at`, `user_id`, `product_id`) VALUES
	(6, '2021-03-12 16:57:12', '2021-03-12 16:57:12', 2, 2),
	(7, '2021-03-15 20:36:17', '2021-03-15 20:36:17', 2, 18),
	(8, '2021-03-16 11:30:29', '2021-03-16 11:30:29', 4, 2);
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;

-- 导出  表 mall.comments 结构
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` int DEFAULT NULL COMMENT '评分',
  `content` text COMMENT '内容',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.comments 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` (`id`, `score`, `content`, `created_at`, `updated_at`, `order_id`, `product_id`, `user_id`) VALUES
	(9, 5, '五星好评', '2021-03-15 22:11:36', '2021-03-15 22:11:36', 39, 15, 2),
	(10, 1, '产品不是很满意', '2021-03-15 22:12:46', '2021-03-15 22:12:46', 39, 15, 2),
	(11, 2, '还可以', '2021-03-16 11:31:46', '2021-03-16 11:31:46', 40, 18, 4);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- 导出  表 mall.companies 结构
CREATE TABLE IF NOT EXISTS `companies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL COMMENT '主图',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `brief` varchar(255) DEFAULT NULL COMMENT '产品简介',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.companies 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` (`id`, `image_url`, `title`, `brief`, `created_at`, `updated_at`) VALUES
	(6, '/upload/20210302/a8dbefc0-7afe-11eb-85c7-55b83ce40e52.jpg', '香水公司', '香水公司', '2021-03-02 02:26:29', '2021-03-03 07:54:24');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;

-- 导出  表 mall.news 结构
CREATE TABLE IF NOT EXISTS `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` smallint NOT NULL,
  `title` varchar(50) NOT NULL DEFAULT '0',
  `publisher` varchar(50) DEFAULT 'Admin',
  `img_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  mall.news 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `type`, `title`, `publisher`, `img_url`, `created_at`, `updated_at`) VALUES
	(1, 1, '内地全方位援港抗疫，区议员：香港也要争气，不能拖国家后退', '观察者网', '/upload/20220329/254a6630-af75-11ec-8513-1527696b1ea6.jpg', '2022-03-29 20:07:46', '2022-03-29 20:29:50'),
	(2, 2, '"70后"刘强主政济南 成全国最年轻副省级城市"一把手"', '上观新闻', '/upload/20220329/254a6630-af75-11ec-8513-1527696b1ea6.jpg', '2022-03-29 20:08:38', '2022-03-29 15:49:30'),
	(3, 2, '姚明回应NBA球员涉华不实言论:希望邀请他来中国看看', '环球网', '/upload/20220329/254a6630-af75-11ec-8513-1527696b1ea6.jpg', '2022-03-29 20:09:41', '2022-03-29 20:29:55');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- 导出  表 mall.newslists 结构
CREATE TABLE IF NOT EXISTS `newslists` (
  `id` smallint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  mall.newslists 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `newslists` DISABLE KEYS */;
INSERT INTO `newslists` (`id`, `title`, `created_at`, `updated_at`) VALUES
	(1, '军事', '2022-03-29 20:29:33', '2022-03-29 20:29:34'),
	(2, '影视1', '2022-03-29 20:29:35', '2022-03-29 14:48:24');
/*!40000 ALTER TABLE `newslists` ENABLE KEYS */;

-- 导出  表 mall.orders 结构
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_num` varchar(255) DEFAULT NULL COMMENT '订单号',
  `total_price` float DEFAULT NULL COMMENT '总价格',
  `username` varchar(255) DEFAULT NULL COMMENT '收货人姓名',
  `user_phone` varchar(255) DEFAULT NULL COMMENT '收货人手机',
  `user_addr` varchar(255) DEFAULT NULL COMMENT '收货人地址',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_num` (`order_num`),
  UNIQUE KEY `order_num_2` (`order_num`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.orders 的数据：~10 rows (大约)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` (`id`, `order_num`, `total_price`, `username`, `user_phone`, `user_addr`, `created_at`, `updated_at`, `user_id`) VALUES
	(27, '1615747276509780451', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 18:41:16', '2021-03-14 18:41:16', 2),
	(28, '1615747392127138687', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 18:43:12', '2021-03-14 18:43:12', 2),
	(29, '1615748299542146953', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 18:58:19', '2021-03-14 18:58:19', 2),
	(30, '1615748884272373773', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:08:04', '2021-03-14 19:08:04', 2),
	(34, '1615751047459318229', 876.88, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:44:07', '2021-03-14 19:44:07', 2),
	(35, '1615751057508126012', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:44:17', '2021-03-14 19:44:17', 2),
	(36, '1615751063603795221', 688, '大黑哥', '18816881688', '深南大道1111号无名摩登大厦6楼A2', '2021-03-14 19:44:23', '2021-03-14 19:44:23', 2),
	(38, '1615838269183991766', 688, '李四', '13445678900', '北京市海淀区', '2021-03-15 19:57:49', '2021-03-15 19:57:49', 2),
	(39, '1615840321891446490', 188.88, '李四', '13445678900', '北京市海淀区', '2021-03-15 20:32:01', '2021-03-15 20:32:01', 2),
	(40, '161589428520773746', 688, '测试地址', '13633663366', '北京', '2021-03-16 11:31:25', '2021-03-16 11:31:25', 4);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- 导出  表 mall.order_goods 结构
CREATE TABLE IF NOT EXISTS `order_goods` (
  `id` int NOT NULL AUTO_INCREMENT,
  `good_title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `good_image_url` varchar(255) DEFAULT NULL COMMENT '产品主图',
  `good_price` float DEFAULT NULL COMMENT '产品价格',
  `good_num` int DEFAULT NULL COMMENT '产品数量',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `order_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_goods_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `order_goods_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.order_goods 的数据：~7 rows (大约)
/*!40000 ALTER TABLE `order_goods` DISABLE KEYS */;
INSERT INTO `order_goods` (`id`, `good_title`, `good_image_url`, `good_price`, `good_num`, `created_at`, `updated_at`, `order_id`, `product_id`) VALUES
	(24, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 18:41:16', '2021-03-14 18:41:16', 27, 18),
	(25, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 18:43:12', '2021-03-14 18:43:12', 28, 18),
	(26, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 18:58:19', '2021-03-14 18:58:19', 29, 2),
	(27, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:08:04', '2021-03-14 19:08:04', 30, 2),
	(28, '女性香水', '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', 188.88, 1, '2021-03-14 19:44:07', '2021-03-14 19:44:07', 34, 17),
	(29, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:44:07', '2021-03-14 19:44:07', 34, 18),
	(30, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:44:17', '2021-03-14 19:44:17', 35, 18),
	(31, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-14 19:44:23', '2021-03-14 19:44:23', 36, 18),
	(33, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-15 19:57:49', '2021-03-15 19:57:49', 38, 18),
	(34, '女性香水', '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', 188.88, 1, '2021-03-15 20:32:01', '2021-03-15 20:32:01', 39, 15),
	(35, '暮星传奇浓香水', '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', 688, 1, '2021-03-16 11:31:25', '2021-03-16 11:31:25', 40, 18);
/*!40000 ALTER TABLE `order_goods` ENABLE KEYS */;

-- 导出  表 mall.perfumes 结构
CREATE TABLE IF NOT EXISTS `perfumes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL COMMENT '主图',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `brief` varchar(255) DEFAULT NULL COMMENT '产品简介',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.perfumes 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `perfumes` DISABLE KEYS */;
INSERT INTO `perfumes` (`id`, `image_url`, `title`, `brief`, `created_at`, `updated_at`) VALUES
	(1, '/upload/20210303/1efbecd0-7bf6-11eb-b270-a3d7f0227ffa.jpg', '男香', '男士香水根据拉丁文"perfumum"衍生而来，意思是"穿透烟雾"。旧约《圣经》提到香水，通常指一种香料形成，这与拉丁文定义相符。一般上，男性香水可分为四大类，即香精、香水、淡香水及古龙水。', '2021-03-03 00:00:00', '2021-03-03 00:00:00'),
	(2, '/upload/20210303/1efbecd0-7bf6-11eb-b270-a3d7f0227ffa.jpg', '女香', '男士香水根据拉丁文"perfumum"衍生而来，意思是"穿透烟雾"。旧约《圣经》提到香水，通常指一种香料形成，这与拉丁文定义相符。一般上，男性香水可分为四大类，即香精、香水、淡香水及古龙水。', '2021-03-03 00:00:00', '2021-03-03 00:00:00'),
	(3, '/upload/20210303/1efbecd0-7bf6-11eb-b270-a3d7f0227ffa.jpg', '中性香', '男士香水根据拉丁文"perfumum"衍生而来，意思是"穿透烟雾"。旧约《圣经》提到香水，通常指一种香料形成，这与拉丁文定义相符。一般上，男性香水可分为四大类，即香精、香水、淡香水及古龙水。', '2021-03-03 00:00:00', '2021-03-03 00:00:00');
/*!40000 ALTER TABLE `perfumes` ENABLE KEYS */;

-- 导出  表 mall.products 结构
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL COMMENT '产品主图',
  `title` varchar(255) DEFAULT NULL COMMENT '产品标题',
  `price` float DEFAULT NULL COMMENT '产品价格',
  `brief` varchar(255) DEFAULT NULL COMMENT '产品简介',
  `status` tinyint(1) DEFAULT '0' COMMENT '产品状态true上架false下架',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `company_id` int DEFAULT NULL,
  `perfume_id` int DEFAULT NULL,
  `spicer_id` int DEFAULT NULL,
  `hot` tinyint unsigned DEFAULT '0' COMMENT '首页热门',
  PRIMARY KEY (`id`),
  KEY `company_id` (`company_id`),
  KEY `perfume_id` (`perfume_id`),
  KEY `spicer_id` (`spicer_id`),
  CONSTRAINT `products_ibfk_4` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_5` FOREIGN KEY (`perfume_id`) REFERENCES `perfumes` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `products_ibfk_6` FOREIGN KEY (`spicer_id`) REFERENCES `spicers` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.products 的数据：~18 rows (大约)
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` (`id`, `image_url`, `title`, `price`, `brief`, `status`, `created_at`, `updated_at`, `company_id`, `perfume_id`, `spicer_id`, `hot`) VALUES
	(1, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(2, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1),
	(3, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(4, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(5, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(6, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1),
	(7, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(8, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(9, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(10, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1),
	(11, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(12, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(13, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(14, '/upload/20210304/c84230d0-7c49-11eb-b882-fd0f6cb5a5f1.jpg', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2021-03-12 16:42:03', 6, 2, 1, 1),
	(15, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(16, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(17, '/upload/20210303/8aa12870-7bfa-11eb-9b22-43fe59a31ec1.jpg', '女性香水', 188.88, '一款充满冒险和自由的真正浓香水，通过演绎环游世界的旅程，展现出精致典雅的阳刚气质、男士风度和魅力。', 1, '2021-03-03 08:29:42', '2021-03-12 16:53:45', NULL, 2, 1, 1),
	(18, '/upload/20220329/f0742a90-af42-11ec-b534-1ff929867bdb.mp4', '暮星传奇浓香水', 688, 'Legend Night是传奇系列香水的全新演绎成果，令使用这款充满感官诱惑的木香香水的男士展现其无穷的个人魅力。这款香水的前调是令人振奋的佛手柑和芬芳的鼠尾草的混合香气。中调以香根草的香气萦绕着紫罗兰的芬芳。后调中的雪松木和紫罗兰的香味为这款香水更添优雅和非凡特质。Legend Night香水瓶的设计灵感源自一款珍贵的名酒，亮黑色与热烈温暖的干邑色相互交融。', 1, '2021-03-03 17:56:52', '2022-03-29 09:31:02', 6, 2, 1, 1);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

-- 导出  表 mall.spicers 结构
CREATE TABLE IF NOT EXISTS `spicers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL COMMENT '主图',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `brief` varchar(255) DEFAULT NULL COMMENT '产品简介',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.spicers 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `spicers` DISABLE KEYS */;
INSERT INTO `spicers` (`id`, `image_url`, `title`, `brief`, `created_at`, `updated_at`) VALUES
	(1, '/upload/20210302/351e7610-7aff-11eb-85c7-55b83ce40e52.jpg', '植物香料', '植物香料', '2021-03-02 02:30:23', '2021-03-03 07:54:04');
/*!40000 ALTER TABLE `spicers` ENABLE KEYS */;

-- 导出  表 mall.users 结构
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '用户密码',
  `name` varchar(100) DEFAULT NULL COMMENT '姓名',
  `gender` varchar(30) DEFAULT NULL COMMENT '性别',
  `is_admin` tinyint(1) DEFAULT '0' COMMENT '是否为管理员',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  mall.users 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `name`, `gender`, `is_admin`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 1, '2020-02-23 00:00:00', '2021-03-12 17:48:52'),
	(2, 'zhangsan', '4297f44b13955235245b2497399d7a93', '张三', '男', 0, '2020-02-23 00:00:00', '2021-03-16 10:41:28'),
	(3, 'yy0609', 'f66866a19bf12f4bcc4b9dbb6b0575e1', '花花', '女', 0, '2021-03-05 11:24:58', '2021-03-05 11:26:00'),
	(4, 'user01', 'e10adc3949ba59abbe56e057f20f883e', '用户一', '女', 0, '2021-03-16 10:53:38', '2021-03-16 11:02:12'),
	(5, 'test', 'cc03e747a6afbbcbf8be7668acfebee5', NULL, NULL, 0, '2022-03-29 05:17:46', '2022-03-29 05:17:46');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
