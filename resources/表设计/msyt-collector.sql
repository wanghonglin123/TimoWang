/*
Navicat MySQL Data Transfer

Source Server         : 172.16.50.242
Source Server Version : 50505
Source Host           : 172.16.50.242:13306
Source Database       : msyt-collector

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2017-12-25 15:13:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_attribute_group
-- ----------------------------
DROP TABLE IF EXISTS `tb_attribute_group`;
CREATE TABLE `tb_attribute_group` (
  `idx` bigint(19) NOT NULL COMMENT '属性组主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `name` varchar(23) DEFAULT NULL COMMENT '组名称，最多10个字符，不能重复，不可以为null##@NotNull(message = "组名称不能为空")@Size(min = 2, max = 10, message = "组名称，最少2个字符，最多10个字符")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_ag_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_ag_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性组表';

-- ----------------------------
-- Table structure for tb_attribute_group_attribute
-- ----------------------------
DROP TABLE IF EXISTS `tb_attribute_group_attribute`;
CREATE TABLE `tb_attribute_group_attribute` (
  `idx` bigint(19) NOT NULL COMMENT '属性组属性主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `attribute_group_idx` bigint(19) DEFAULT NULL COMMENT '属性组主键idx，不可以为null，必须手动设置为0##@NotNull(message = "属性组不能为空")##',
  `attribute_idx` bigint(19) DEFAULT NULL COMMENT '属性主键idx，不可以为null，必须手动设置为0##@NotNull(message = "属性不能为空")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_aga_attribute_group` (`attribute_group_idx`) USING BTREE,
  KEY `index_aga_attribute` (`attribute_idx`) USING BTREE,
  KEY `index_aga_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_aga_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性组属性表';

-- ----------------------------
-- Table structure for tb_attribute_p
-- ----------------------------
DROP TABLE IF EXISTS `tb_attribute_p`;
CREATE TABLE `tb_attribute_p` (
  `idx` bigint(19) NOT NULL COMMENT '属性主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `pidx` bigint(19) DEFAULT NULL COMMENT '父级属性主键idx，不可以为null，必须手动设置为0',
  `pidx_code` bigint(19) DEFAULT NULL COMMENT 'pidx code 全局唯一性，解决pidx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "pidxCode")##',
  `name` varchar(31) DEFAULT NULL COMMENT '属性名称，最多10个字符，不可重复，不可以为null##@NotNull(message = "属性不能为空")@Size(min = 2, max = 10, message = "属性名称，最少2个字符，最多10个字符")##',
  `attribute_alias` varchar(60) DEFAULT NULL COMMENT '属性别名，最多60个字符##@Length(max = 60, message = "属性别名最多60个字符")##',
  `attribute_sequence` int(10) DEFAULT NULL COMMENT '属性序号，输入的序号必须为大于0的整数，前端商城显示顺序按此排列。序号越大排序越靠前，相同序号的按照修改时间排序，即排序规则为“顺序+时间”。##@Range(min = 1, max = 2147483647, message = "属性序号需要设置1-2147483647")##',
  `is_select` tinyint(1) DEFAULT NULL COMMENT '是否选项框，1：是，0：否，取值范围为0-9，不可以为null，必须手动设置默认值为0##@NotNull(message = "请选择是否选项框")@Range(min = 0, max = 9, message = "是否选项框取值区间0-9")##',
  `is_show` tinyint(1) DEFAULT NULL COMMENT '是否显示，1：是，0：否，取值范围为0-9，不可以为null，必须手动设置默认值为0##@NotNull(message = "请选择是否显示")@Range(min = 0, max = 9, message = "是否显示取值区间0-9")##',
  `is_key` tinyint(1) DEFAULT NULL COMMENT '是否关键属性，1：是，0：否，取值范围为0-9，不可以为null，必须手动设置默认值为0##@NotNull(message = "请选择是否关键属性")@Range(min = 0, max = 9, message = "是否关键属性取值区间0-9")##',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注，最多50个字符##@Length(max = 50, message = "备注最大50个字符")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_attribute_parent` (`pidx`) USING BTREE,
  KEY `index_attribute_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_attribute_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='属性表';

-- ----------------------------
-- Table structure for tb_category_attribute_group
-- ----------------------------
DROP TABLE IF EXISTS `tb_category_attribute_group`;
CREATE TABLE `tb_category_attribute_group` (
  `idx` bigint(19) NOT NULL COMMENT '分类与属性组关联表主键idx，分布式架构，全局唯一递增##@Search(module="msyt-collector")##',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `category_idx` bigint(19) DEFAULT NULL COMMENT '类目主键idx，不可以为null，必须手动设置为0##@NotNull(message = "类目不能为空")##',
  `attribute_group_idx` bigint(19) DEFAULT NULL COMMENT '属性组主键idx，不可以为null，必须手动设置为0##@NotNull(message = "权限组不能为空")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tb_item
-- ----------------------------
DROP TABLE IF EXISTS `tb_item`;
CREATE TABLE `tb_item` (
  `idx` bigint(19) NOT NULL COMMENT '商品主键idx，分布式架构，全局唯一递增##@Search(module="msyt-collector")##',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_state_idx` bigint(19) DEFAULT NULL COMMENT '状态主键idx，不可以为null，必须手动设置为0##@NotNull(message = "商品状态不能为空")@SearchExclusion##',
  `item_ext_idx` bigint(19) DEFAULT NULL COMMENT '商品扩展主键idx，不可以为null，全局唯一递增',
  `item_no` varchar(30) DEFAULT NULL COMMENT '货号，根据类目与仓库类型来自动生成货号，不可重复，不可以为null##@NotNull(message = "货号不能为空")@Length(max = 30, message = "货号最多30位字符")##',
  `barcode` varchar(20) DEFAULT NULL COMMENT '条形码，最多20个字符，不可以为null##@NotNull(message = "条形码不能为空")@Length(max = 20, message = "条形码最多20个字符")##',
  `cn_name` varchar(200) DEFAULT NULL COMMENT '中文名称，最多200位字符，不可以为null##@NotNull(message = "中文名称不能为空")@Length(max = 200, message = "中文名称最多200位字符")@Modified##',
  `en_name` varchar(200) DEFAULT NULL COMMENT '英文名称，最多200个字符，不可以为null##@NotNull(message = "英文名称不能为空")@Length(max = 200, message = "英文名称最多200个字符")##',
  `brand_idx` bigint(19) DEFAULT NULL COMMENT '品牌主键idx，不可以为null，必须手动设置为0##@NotNull(message = "品牌不能为空")##',
  `origin_idx` bigint(19) DEFAULT NULL COMMENT '产地主键idx，不可以为null，必须手动设置为0##@NotNull(message = "产地不能为空")##',
  `category_idx` bigint(19) DEFAULT NULL COMMENT '类目主键idx，不可以为null，必须手动设置为0##@NotNull(message = "类目不能为空")##',
  `specification` varchar(100) DEFAULT NULL COMMENT '商品规格，最多100个字符##@Length(max = 100, message = "商品规格最多100个字符")##',
  `warehouse_type_idx` bigint(19) DEFAULT NULL COMMENT '仓库类型主键idx，不可以为null，必须手动设置为0##@NotNull(message = "仓库类型不能为空")@DynamicS##',
  `batch` int(5) DEFAULT NULL COMMENT '批次，取值范围0-99999，不可以为null，必须手动设置为0##@NotNull(message = "批次不能为空")@Range(min = 0, max = 99999, message = "批次取值区间0-99999")##',
  `weight` bigint(19) DEFAULT NULL COMMENT '权重，决定前端商品的排列顺序，不可以为null，必须手动设置为0##@NotNull(message = "权重不能为空")##',
  `collection_remark` varchar(500) DEFAULT NULL COMMENT '采集备注，最多500个字符##@Length(max = 500, message = "采集备注最多500个字符")##',
  `image_small` varchar(100) DEFAULT NULL COMMENT '商品小图文件##@DynamicS##',
  `image_middle` varchar(100) DEFAULT NULL COMMENT '商品中图文件##@DynamicS##',
  `image_big` varchar(100) DEFAULT NULL COMMENT '商品大图文件##@DynamicS##',
  `purchase_status` smallint(1) DEFAULT NULL COMMENT '采购状态，1：未确认采购，2：确认采购，取值范围0-9，不可以为null，必须手动设置默认值为1##@NotNull(message = "采购状态不能为空")@Range(min = 0, max = 9, message = "采购状态取值区间0-9")##',
  `collection_status` smallint(1) DEFAULT NULL COMMENT '采集状态，1：未采集，2：采集完成，3：编辑完成，4：文案通过，取值范围0-9，不可以为null，必须手动设置默认值为1##@NotNull(message = "采集状态不能为空")@Range(min = 0, max = 9, message = "采集状态取值区间0-9")##',
  `publish_status` smallint(1) DEFAULT NULL COMMENT '发布状态，0-未发布 1-已发布',
  `is_sync_erp` smallint(1) DEFAULT NULL COMMENT '同步ERP状态，1、未同步 2、已同步 3、同步出错  默认值为1，不能为空，##@NotNull(message = "同步ERP状态不能为空")@Range(min = 0, max = 9, message = "同步ERP状态取值区间0-9")##',
  `sync_error` varchar(50) DEFAULT NULL COMMENT '同步出错描述##)@Length(max = 50, message = "同步出错描述最多50个字符")##',
  `purchase_limitation_count` int(11) DEFAULT NULL COMMENT '限购数，默认为3',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间，每一次修改都要更新时间##@EnYyyyMMddHHmmss##',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_item_brand` (`brand_idx`) USING BTREE,
  KEY `index_item_origin` (`origin_idx`) USING BTREE,
  KEY `index_item_category` (`category_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品表';

-- ----------------------------
-- Table structure for tb_item_attribute
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_attribute`;
CREATE TABLE `tb_item_attribute` (
  `idx` bigint(19) NOT NULL COMMENT '商品属性值主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置默认值为0',
  `attribute_idx` bigint(19) DEFAULT NULL COMMENT '属性主键idx， 不可以为null，必须手动设置默认值为0',
  `attribute_value` varchar(500) DEFAULT NULL COMMENT '属性值，最多500个字符',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注，最多200个字符',
  `edit_type` smallint(1) DEFAULT NULL COMMENT '编辑类型，1：一次编辑，2：二次编辑，取值范围1-9，不可以为null',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员，第一次新增时创建，后期不可以更改',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员，每一次修改都要记录',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，新增时赋值当前时间，不可以更改',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品属性值表';

-- ----------------------------
-- Table structure for tb_item_attribute_image
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_attribute_image`;
CREATE TABLE `tb_item_attribute_image` (
  `idx` bigint(19) NOT NULL COMMENT '商品属性图片主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置默认值为0',
  `attribute_idx` bigint(19) DEFAULT NULL COMMENT '属性主键idx， 不可以为null，必须手动设置默认值为0',
  `image_small` varchar(200) DEFAULT NULL COMMENT '商品属性小图文件##@DynamicS##',
  `image_middle` varchar(200) DEFAULT NULL COMMENT '商品属性中图文件##@DynamicS##',
  `image_big` varchar(200) DEFAULT NULL COMMENT '商品属性大图文件##@DynamicS##',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注，最多200个字符',
  `edit_type` smallint(1) DEFAULT NULL COMMENT '编辑类型，1：一次编辑，2：二次编辑，取值范围1-9，不可以为null',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员，第一次新增时创建，后期不可以更改',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员，每一次修改都要记录',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，新增时赋值当前时间，不可以更改',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品属性图片表';

-- ----------------------------
-- Table structure for tb_item_barcode
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_barcode`;
CREATE TABLE `tb_item_barcode` (
  `idx` bigint(19) NOT NULL COMMENT '商品条形码主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置默认值为0',
  `barcode` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '条形码，最多20个字符，不可以为null##@NotNull(message = "条形码不能为空")@Length(max = 20, message = "条形码最多20个字符")##',
  `publish_status` smallint(1) DEFAULT NULL COMMENT '发布状态，0-未发布 1-已发布',
  `remark` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注，最多200个字符',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员，第一次新增时创建，后期不可以更改',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员，每一次修改都要记录',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，新增时赋值当前时间，不可以更改',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '修改时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='商品条形码表';

-- ----------------------------
-- Table structure for tb_item_bidding
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_bidding`;
CREATE TABLE `tb_item_bidding` (
  `idx` bigint(19) NOT NULL COMMENT '商品竞价主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0',
  `amazon_price` int(10) DEFAULT NULL COMMENT '亚马逊售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "亚马逊售价不能为空")@Range(min = 0, max = 2147483647, message = "亚马逊售价需要设置0-2147483647")@$2@Modified##',
  `tmall_price` int(10) DEFAULT NULL COMMENT '天猫售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "天猫售价不能为空")@Range(min = 0, max = 2147483647, message = "天猫售价需要设置0-2147483647")@$2@Modified##',
  `jd_price` int(10) DEFAULT NULL COMMENT '京东售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "京东售价不能为空")@Range(min = 0, max = 2147483647, message = "京东售价需要设置0-2147483647")@$2@Modified##',
  `red_price` int(10) DEFAULT NULL COMMENT '小红书售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "小红书售价不能为空")@Range(min = 0, max = 2147483647, message = "小红书售价需要设置0-2147483647")@$2@Modified##',
  `abroad_price` int(10) DEFAULT NULL COMMENT '国外官网售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "国外官网售价不能为空")@Range(min = 0, max = 2147483647, message = "国外官网售价需要设置0-2147483647")@$2@Modified##',
  `domestic_price` int(10) DEFAULT NULL COMMENT '国内官网售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "国内官网售价不能为空")@Range(min = 0, max = 2147483647, message = "国内官网售价需要设置0-2147483647")@$2@Modified##',
  `origin_country_price` int(10) DEFAULT NULL COMMENT '原产国售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "原产国售价不能为空")@Range(min = 0, max = 2147483647, message = "原产国售价需要设置0-2147483647")@$2@Modified##',
  `koala_price` int(10) DEFAULT NULL COMMENT '考拉售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "考拉售价不能为空")@Range(min = 0, max = 2147483647, message = "考拉售价需要设置0-2147483647")@$2@Modified##',
  `jumei_price` int(10) DEFAULT NULL COMMENT '聚美售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "聚美售价不能为空")@Range(min = 0, max = 2147483647, message = "聚美售价需要设置0-2147483647")@$2@Modified##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null##@DynamicS##',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_bidding_item` (`item_idx`) USING BTREE,
  KEY `index_bidding_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_bidding_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品竞价表';

-- ----------------------------
-- Table structure for tb_item_brand
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_brand`;
CREATE TABLE `tb_item_brand` (
  `idx` bigint(19) NOT NULL COMMENT '商品品牌主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `code` varchar(20) DEFAULT NULL COMMENT '编码，最多20个字符，规则为BR00001-BR99999顺序的编号，不可重复##@NotNull(message = "编码不能为空")@Length(max = 20, message = "编码最大20个字符")##',
  `brand_name` varchar(100) DEFAULT NULL COMMENT '品牌名称，最多100位字符，不可重复##@Length(max = 100, message = "品牌名称最多100位字符")##',
  `state` varchar(20) DEFAULT NULL COMMENT '所属国，最多20个字符，不可以为null##@NotNull(message = "所属国不能为空")@Length(max = 20, message = "所属国最大20个字符")##',
  `logo_small` varchar(100) DEFAULT NULL COMMENT 'logo小图文件##@DynamicS##',
  `logo_middle` varchar(100) DEFAULT NULL COMMENT 'logo中图文件##@DynamicS##',
  `logo_big` varchar(100) DEFAULT NULL COMMENT 'logo大图文件##@DynamicS##',
  `introduce` varchar(800) DEFAULT NULL COMMENT '品牌介绍，最多800个字符##@Length(max = 800, message = "品牌介绍最大800个字符")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_brand_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_brand_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品品牌表';

-- ----------------------------
-- Table structure for tb_item_brand_images_sync
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_brand_images_sync`;
CREATE TABLE `tb_item_brand_images_sync` (
  `idx` bigint(19) NOT NULL COMMENT '商品品牌图片同步主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题',
  `brand_code` varchar(20) DEFAULT NULL COMMENT '编码，最多20个字符，规则为BR00001-BR99999顺序的编号，不可重复',
  `brand_name` varchar(100) DEFAULT NULL COMMENT '品牌名称，最多100位字符，不可重复##@Length(max = 100, message = "品牌名称最多100位字符")##',
  `brand_logo` varchar(100) DEFAULT NULL COMMENT '品牌logo',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注，0-100字符，不可以为null，必须手动设置为空字符串',
  `result_status` smallint(1) DEFAULT NULL COMMENT '处理结果状态，0：系统处理中，1：处理成功，2：处理失败，取值范围为0-9，不可以为null',
  `result_describe` varchar(200) DEFAULT NULL COMMENT '系统处理结果，处理成功为空，处理失败，存处理失败结果',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间##@EnYyyyMMddHHmmss##',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_ibis_brand` (`brand_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品品牌图片同步表';

-- ----------------------------
-- Table structure for tb_item_category_p
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_category_p`;
CREATE TABLE `tb_item_category_p` (
  `idx` bigint(19) NOT NULL COMMENT '商品类目主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `pidx` bigint(19) DEFAULT NULL COMMENT '父级类目主键idx，不可以为null，必须手动设置为0',
  `pidx_code` bigint(19) DEFAULT NULL COMMENT 'pidx code 全局唯一性，解决pidx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "pidxCode")##',
  `top_idx` bigint(19) DEFAULT NULL COMMENT '顶级idx，记录最顶级的主键idx，如果自己是顶级那么这里录入自己的idx',
  `code` varchar(10) DEFAULT NULL COMMENT '类目编码，最多10个字符，不能重复，不可以为null',
  `name` varchar(10) DEFAULT NULL COMMENT '类目简称，最多10个字符，不可以为null##@NotNull(message = "简称不能为空")@Length(max = 10, message = "简称最大10个字符")##',
  `full_name` varchar(10) DEFAULT NULL COMMENT '类目全称，最多10个字符，不可以为null##@Length(max = 10, message = "全称最大10个字符")##',
  `image_small` varchar(100) DEFAULT NULL COMMENT '小图文件##@DynamicS##',
  `image_middle` varchar(100) DEFAULT NULL COMMENT '中图文件##@DynamicS##',
  `image_big` varchar(100) DEFAULT NULL COMMENT '大图文件##@DynamicS##',
  `attribute_group_idx` bigint(19) DEFAULT NULL COMMENT '属性组主键idx，不可以为null，必须手动设置为0##@NotNull(message = "权限组不能为空")##',
  `purchase_limit` smallint(1) DEFAULT NULL COMMENT '限购数，0：不限购，1-9表示具体限购数量，取值范围为0-9，不可以为null，必须手动设置默认值为3##@NotNull(message = "限购数量不能为空")@Range(min = 0, max = 9, message = "限购数量区间0-9")##',
  `level_num` smallint(1) DEFAULT NULL COMMENT '类目级别，1：第一类目，2：第二类目，3：第三类目，取值范围1-9，不可以为null，必须手动设置默认值为1##@NotNull(message = "类目级别不能为空")@Range(min = 1, max = 9, message = "类目级别取值区间1-9")##',
  `category_sequence` int(10) DEFAULT NULL COMMENT '类目序号，输入的序号必须为大于0的整数，前端商城分类显示顺序按此排列。序号越大排序越靠前，相同序号的类目按照修改时间排序，即排序规则为“顺序+时间”。##@Range(min = 1, max = 2147483647, message = "类目序号需要设置1-2147483647")##',
  `publish_channel` smallint(6) DEFAULT NULL COMMENT '发布渠道，0：全部；1：洋桃；2：洋葱',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_category_parent` (`pidx`) USING BTREE,
  KEY `index_category_attribute_group` (`attribute_group_idx`) USING BTREE,
  KEY `index_category_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_category_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品类目表';

-- ----------------------------
-- Table structure for tb_item_collection
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_collection`;
CREATE TABLE `tb_item_collection` (
  `idx` bigint(19) NOT NULL COMMENT '商品采集主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0##@NotNull(message = "商品不能为空")##',
  `selling_point` varchar(20) DEFAULT NULL COMMENT '卖点，最多20个字符##@Length(max = 20, message = "卖点最多20个字符")##',
  `slogan` varchar(50) DEFAULT NULL COMMENT '广告语，最多50个字符##@Length(max = 50, message = "广告语最多50个字符")##',
  `shopping_guide` varchar(300) DEFAULT NULL COMMENT '导购语，最多300个字符##@Length(max = 300, message = "导购语最多300个字符")##',
  `editor_idx` bigint(19) DEFAULT NULL COMMENT '采编主键idx，不可以为null，必须手动设置为0##@NotNull(message = "采编不能为空")##',
  `search_keywords` varchar(100) DEFAULT NULL COMMENT '搜索关键词，最多100个字符##@Length(max = 100, message = "搜索关键词最多100个字符")##',
  `attachment_id` bigint(19) DEFAULT NULL COMMENT '附件文件messageid##@DynamicS##',
  `video_link` varchar(200) DEFAULT NULL COMMENT '视频链接，最多200个字符',
  `edit_type` smallint(1) DEFAULT NULL COMMENT '编辑类型，1：一次编辑，2：二次编辑，取值范围1-9，不可以为null',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  `publish_status` smallint(1) DEFAULT NULL COMMENT '发布状态，0-未发布 1-已发布',
  PRIMARY KEY (`idx`),
  KEY `index_collection_item` (`item_idx`) USING BTREE,
  KEY `index_collection_editor` (`editor_idx`) USING BTREE,
  KEY `index_collection_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_collection_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品采集表';

-- ----------------------------
-- Table structure for tb_item_content
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_content`;
CREATE TABLE `tb_item_content` (
  `idx` bigint(19) NOT NULL COMMENT '商品内容主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0##@NotNull(message = "商品不能为空")##',
  `image_paste_area` varchar(12000) DEFAULT NULL COMMENT '图片粘贴区，最多12000个字符，存储富文本编辑器内容',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的，激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品内容表';

-- ----------------------------
-- Table structure for tb_item_editor
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_editor`;
CREATE TABLE `tb_item_editor` (
  `idx` bigint(19) NOT NULL COMMENT '商品采编主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `name` varchar(20) DEFAULT NULL COMMENT '采编名称，最多20个字符，不可以为null##@NotNull(message = "采编名称不能为空")@Length(max = 20, message = "采编名称最多20个字符")##',
  `head_img_small` varchar(100) DEFAULT NULL COMMENT '头像小图##@DynamicS##',
  `head_img_middle` varchar(100) DEFAULT NULL COMMENT '头像中图##@DynamicS##',
  `head_img_big` varchar(100) DEFAULT NULL COMMENT '头像大图##@DynamicS##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_editor_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_editor_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品采编表';

-- ----------------------------
-- Table structure for tb_item_ext
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_ext`;
CREATE TABLE `tb_item_ext` (
  `idx` bigint(19) NOT NULL COMMENT '商品扩展主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `home_show` smallint(1) DEFAULT NULL COMMENT '首页显示，1：在首页显示，0：默认值，不在首页显示，取值范围为0-9，不可以为null##@NotNull(message = "首页显示不能为空")@Range(min = 0, max = 9, message = "首页显示取值区间0-9")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '上下架状态，1：上架，2：下架，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注，0-100字符，不可以为null，必须手动设置为空字符串',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_idx_code` (`idx_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品扩展表';

-- ----------------------------
-- Table structure for tb_item_formal_image_library
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_formal_image_library`;
CREATE TABLE `tb_item_formal_image_library` (
  `idx` bigint(19) NOT NULL COMMENT '商品正式图库主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0##@NotNull(message = "商品不能为空")##',
  `white_background_image_small` varchar(150) DEFAULT NULL COMMENT '白底小图文件##@DynamicS##',
  `white_background_image_middle` varchar(150) DEFAULT NULL COMMENT '白底中图文件##@DynamicS##',
  `white_background_image_big` varchar(150) DEFAULT NULL COMMENT '白底大图文件##@DynamicS##',
  `main_push_image_small` varchar(150) DEFAULT NULL COMMENT '主推小图文件##@DynamicS##',
  `main_push_image_middle` varchar(150) DEFAULT NULL COMMENT '主推中图文件##@DynamicS##',
  `main_push_image_big` varchar(150) DEFAULT NULL COMMENT '主推大图文件##@DynamicS##',
  `detail_page_main_image_small` varchar(150) DEFAULT NULL COMMENT '详情页主小图文件详情页主小图文件messageid##@DynamicS####@DynamicS##',
  `detail_page_main_image_middle` varchar(150) DEFAULT NULL COMMENT '详情页主中图文件##@DynamicS##',
  `detail_page_main_image_big` varchar(150) DEFAULT NULL COMMENT '详情页主大图文件##@DynamicS##',
  `content_info` varchar(12000) DEFAULT NULL COMMENT '详情##@Length(max = 12000, message = "详情最多12000个字符")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_fpl_item` (`item_idx`) USING BTREE,
  KEY `index_fpl_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_fpl_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品正式图库表';

-- ----------------------------
-- Table structure for tb_item_history
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_history`;
CREATE TABLE `tb_item_history` (
  `idx` bigint(19) NOT NULL COMMENT '商品历史主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0',
  `platform_idx` bigint(19) DEFAULT NULL COMMENT '平台主键idx，不可以为null，必须手动设置为0##@NotNull(message = "所属平台不能为空")##',
  `item_state_idx` bigint(19) DEFAULT NULL COMMENT '状态主键idx，不可以为null，必须手动设置为0##@NotNull(message = "商品状态不能为空")##',
  `cn_name` varchar(50) DEFAULT NULL COMMENT '中文名称，最多50个字符，不可以为null##@NotNull(message = "中文名称不能为空")@Length(max = 50, message = "中文名称最多50个字符")##',
  `en_name` varchar(200) DEFAULT NULL COMMENT '英文名称，最多200个字符，不可以为null##@NotNull(message = "英文名称不能为空")@Length(max = 200, message = "英文名称最多200个字符")##',
  `brand_idx` bigint(19) DEFAULT NULL COMMENT '品牌主键idx，不可以为null，必须手动设置为0##@NotNull(message = "品牌不能为空")##',
  `origin_idx` bigint(19) DEFAULT NULL COMMENT '产地主键idx，不可以为null，必须手动设置为0##@NotNull(message = "产地不能为空")##',
  `category_idx` bigint(19) DEFAULT NULL COMMENT '类目主键idx，不可以为null，必须手动设置为0##@NotNull(message = "类目不能为空")##',
  `specification` varchar(100) DEFAULT NULL COMMENT '商品规格，最多100个字符##@Length(max = 100, message = "商品规格最多100个字符")##',
  `warehouse_type_idx` bigint(19) DEFAULT NULL COMMENT '仓库类型主键idx，不可以为null，必须手动设置为0##@NotNull(message = "仓库类型不能为空")##',
  `batch` int(5) DEFAULT NULL COMMENT '批次，取值范围0-99999，不可以为null，必须手动设置为0##@NotNull(message = "批次不能为空")@Range(min = 0, max = 99999, message = "批次取值区间0-99999")##',
  `collection_remark` varchar(500) DEFAULT NULL COMMENT '采集备注，最多500个字符##@Length(max = 500, message = "采集备注最多500个字符")##',
  `purchase_status` smallint(1) DEFAULT NULL COMMENT '采购状态，1：未确认采购，2：确认采购，取值范围0-9，不可以为null，必须手动设置默认值为1##@NotNull(message = "采购状态不能为空")@Range(min = 0, max = 9, message = "采购状态取值区间0-9")##',
  `collection_status` smallint(1) DEFAULT NULL COMMENT '采集状态，1：未采集，2：采集完成，3：编辑完成，4：文案通过，取值范围0-9，不可以为null，必须手动设置默认值为1##@NotNull(message = "采集状态不能为空")@Range(min = 0, max = 9, message = "采集状态取值区间0-9")##',
  `home_show` smallint(1) DEFAULT NULL COMMENT '首页显示，1：在首页显示，0：默认值，不在首页显示，取值范围为0-9，不可以为null##@NotNull(message = "首页显示不能为空")@Range(min = 0, max = 9, message = "首页显示取值区间0-9")##',
  `weight` bigint(19) DEFAULT NULL COMMENT '权重，决定前端商品的排列顺序，不可以为null，必须手动设置为0##@NotNull(message = "权重不能为空")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '上下架状态，1：上架，2：下架，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_history_brand` (`brand_idx`) USING BTREE,
  KEY `index_history_origin` (`origin_idx`) USING BTREE,
  KEY `index_history_category` (`category_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品历史表';

-- ----------------------------
-- Table structure for tb_item_images_sync
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_images_sync`;
CREATE TABLE `tb_item_images_sync` (
  `idx` bigint(19) NOT NULL COMMENT '商品图片同步主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题',
  `item_no` varchar(30) DEFAULT NULL COMMENT '货号，根据类目与仓库类型来自动生成货号，不可重复，不可以为null##@NotNull(message = "货号不能为空")@Length(max = 30, message = "货号最多30位字符")##',
  `item_white_background_image` varchar(150) DEFAULT NULL COMMENT '商品白底图',
  `item_main_push_image` varchar(150) DEFAULT NULL COMMENT '商品主推图',
  `item_detail_page_image` varchar(8000) DEFAULT NULL COMMENT '商品详情图',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注，0-100字符，不可以为null，必须手动设置为空字符串',
  `result_status` smallint(1) DEFAULT NULL COMMENT '处理结果状态，0：系统处理中，1：处理成功，2：处理失败，取值范围为0-9，不可以为null',
  `result_describe` varchar(200) DEFAULT NULL COMMENT '系统处理结果，处理成功为空，处理失败，存处理失败结果',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间##@EnYyyyMMddHHmmss##',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  `cn_name` varchar(200) DEFAULT NULL COMMENT '中文名称，最多200位字符，不可以为null##@NotNull(message = "中文名称不能为空")@Length(max = 200, message = "中文名称最多200位字符")##',
  `en_name` varchar(200) DEFAULT NULL COMMENT '英文名称，最多200位字符，不可以为null##@NotNull(message = "英文名称不能为空")@Length(max = 200, message = "英文名称最多200位字符")##',
  PRIMARY KEY (`idx`),
  KEY `index_iis_item` (`item_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品图片同步表';

-- ----------------------------
-- Table structure for tb_item_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_log`;
CREATE TABLE `tb_item_log` (
  `idx` bigint(19) NOT NULL COMMENT '商品日志主键idx，分布式框架，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0##@NotNull(message = "关联ID不能为空")##',
  `modify_location` smallint(2) DEFAULT NULL COMMENT '修改位置，即修改了什么内容，比如：分类、货号、供货价、发货系数等等##@DynamicS@NotNull(message = "修改位置不能为空")@Range(min = 1, max = 50, message = "修改位置需要设置1-50")##',
  `origin_value` varchar(100) DEFAULT NULL COMMENT '原始值，也就是修改前的值##@NotNull(message = "原始值不能为空")@Length(max = 100, message = "原始值最多100个字符")##',
  `new_value` varchar(100) DEFAULT NULL COMMENT '新值，也就是修改后的值##@NotNull(message = "新值不能为空")@Length(max = 100, message = "原始值最多100个字符")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null##@DynamicS##',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品日志表';

-- ----------------------------
-- Table structure for tb_item_origin
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_origin`;
CREATE TABLE `tb_item_origin` (
  `idx` bigint(19) NOT NULL COMMENT '商品产地主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `origin_code` char(4) DEFAULT NULL COMMENT '产地编码，4位字符，不可以为null，必须手动设置为空字符串##@NotNull(message = "产地编码不能为空")@Length(min = 4, max = 4, message = "产地编码为4个字符")##',
  `customs_code` char(3) DEFAULT NULL COMMENT '海关编码，3位字符，不可以为null，必须手动设置为空字符串##@NotNull(message = "海关编码不能为空")@Length(min = 3, max = 3, message = "海关编码为3个字符")##',
  `cn_name` varchar(10) DEFAULT NULL COMMENT '中文名称，最多10个字符，不可以为null，必须手动设置为空字符串##@NotNull(message = "中文名称不能为空")@Length(max = 10, message = "中文名称最多10个字符")##',
  `en_name` varchar(30) DEFAULT NULL COMMENT '英文名称，最多30个字符，不可以为null，必须手动设置为空字符串##@NotNull(message = "英文名称不能为空")@Length(max = 30, message = "英文名称最多30个字符")##',
  `national_flag_image_small` varchar(100) DEFAULT NULL COMMENT '国旗小图文件##@DynamicS##',
  `national_flag_image_middle` varchar(100) DEFAULT NULL COMMENT '国旗中图文件##@DynamicS##',
  `national_flag_image_big` varchar(100) DEFAULT NULL COMMENT '国旗大图文件##@DynamicS##',
  `image_small` varchar(100) DEFAULT NULL COMMENT '产地小图文件##@DynamicS##',
  `image_middle` varchar(100) DEFAULT NULL COMMENT '产地中图文件##@DynamicS##',
  `image_big` varchar(100) DEFAULT NULL COMMENT '产地大图文件##@DynamicS##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_origin_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_origin_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品产地表';

-- ----------------------------
-- Table structure for tb_item_price
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_price`;
CREATE TABLE `tb_item_price` (
  `idx` bigint(19) NOT NULL COMMENT '商品价格主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `item_idx` bigint(19) DEFAULT NULL COMMENT '商品主键idx，不可以为null，必须手动设置为0##@NotNull(message = "商品不能为空")##',
  `market_price` int(10) DEFAULT NULL COMMENT '市场价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "市场价不能为空")@Range(min = 0, max = 2147483647, message = "市场价需要设置0-2147483647")@$2@Modified##',
  `selling_price` int(10) DEFAULT NULL COMMENT '售价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "售价不能为空")@Range(min = 0, max = 2147483647, message = "售价需要设置0-2147483647")@$2@Modified##',
  `supply_price` int(10) DEFAULT NULL COMMENT '供货价，以分为单位，而不是以元为单位，取值范围0-2147483647，不可以为null##@NotNull(message = "供货价不能为空")@Range(min = 0, max = 2147483647, message = "供货价需要设置0-2147483647")@$2@Modified##',
  `publish_status` smallint(1) DEFAULT NULL COMMENT '发布状态，0-未发布 1-已发布',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null##@DynamicS##',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间##@EnYyyyMMddHHmmss##',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的、激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_price_item` (`item_idx`) USING BTREE,
  KEY `index_price_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_price_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品价格表';

-- ----------------------------
-- Table structure for tb_item_state
-- ----------------------------
DROP TABLE IF EXISTS `tb_item_state`;
CREATE TABLE `tb_item_state` (
  `idx` bigint(19) NOT NULL COMMENT '商品状态主键idx，分布式架构，全局唯一递增',
  `idx_code` bigint(19) DEFAULT NULL COMMENT 'idx code 全局唯一性，解决idx可以通过递增1猜测出来，潜在安全问题##@Long2S(targetField = "idxCode")##',
  `name` varchar(20) DEFAULT NULL COMMENT '状态名称，最多20个字符，不可以为null##@NotNull(message = "状态名称不能为空")@Length(max = 20, message = "状态名称最多20个字符")##',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注，最多50个字符##@Length(max = 50, message = "备注最多50个字符")##',
  `create_by_member_idx` bigint(19) DEFAULT NULL COMMENT '创建成员idx，不可以为null',
  `update_by_member_idx` bigint(19) DEFAULT NULL COMMENT '修改成员idx，不可以为null',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间，第一次创建时间，后续不可以修改时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间，每一次修改都要更新时间',
  `status` smallint(1) DEFAULT NULL COMMENT '状态，1：可用的，激活的，2：未激活，0：删除，取值范围为0-9，不可以为null',
  `version` bigint(19) DEFAULT NULL COMMENT '版本号，高并发，乐观锁的解决方案',
  `ext` varchar(100) DEFAULT NULL COMMENT '扩展，0-100字符，不可以为null，必须手动设置为空字符串',
  PRIMARY KEY (`idx`),
  KEY `index_state_create_member` (`create_by_member_idx`) USING BTREE,
  KEY `index_state_update_member` (`update_by_member_idx`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品状态表';
