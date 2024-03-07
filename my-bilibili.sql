DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `phone` varchar(100) DEFAULT NULL COMMENT '手机号',
    `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
    `password` varchar(255) DEFAULT NULL COMMENT '密码',
    `salt` varchar(50) DEFAULT NULL COMMENT '盐值',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='用户表';

DROP TABLE IF EXISTS `t_user_info`;
CREATE TABLE `t_user_info` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `nick` varchar(100) DEFAULT NULL COMMENT '昵称',
    `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
    `sign` text COMMENT '签名',
    `gender` varchar(2) DEFAULT NULL COMMENT '性别：0男 1女 2未知',
    `birth` varchar(20) DEFAULT NULL COMMENT '生日',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='用户基本信息表';

DROP TABLE IF EXISTS `t_following_group`;
CREATE TABLE `t_following_group` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `name` varchar(50) DEFAULT NULL COMMENT '关注分组名称',
    `type` varchar(5) DEFAULT NULL COMMENT '关注分组类型：0特别关注 1悄悄关注 2默认分组 3自定义',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='用户关注分组表';

INSERT INTO `t_following_group` (`userId`, `name`, `type`, `createTime`, `updateTime`)
VALUES
    (NULL, '特别关注', '0', NULL, NULL),
    (NULL, '悄悄关注', '1', NULL, NULL),
    (NULL, '默认分组', '2', NULL, NULL);

DROP TABLE IF EXISTS `t_user_following`;
CREATE TABLE `t_user_following` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `followingId` bigint DEFAULT NULL COMMENT '关注用户id',
    `groupId` bigint DEFAULT NULL COMMENT '关注分组id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT='用户关注表';

DROP TABLE IF EXISTS `t_user_moments`;
CREATE TABLE `t_user_moments` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `type` varchar(5) DEFAULT NULL COMMENT '动态类型：0视频 1直播 2专栏',
    `contentId` bigint DEFAULT NULL COMMENT '内容详情id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='用户动态表';

DROP TABLE IF EXISTS `t_auth_element_operation`;
CREATE TABLE `t_auth_element_operation` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `elementName` varchar(255) DEFAULT NULL COMMENT '页面元素名称',
    `elementCode` varchar(50) DEFAULT NULL COMMENT '页面元素唯一编码',
    `operationType` varchar(5) DEFAULT NULL COMMENT '操作类型：0可点击  1可见',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='权限控制--页面元素操作表';

INSERT INTO `t_auth_element_operation` (`elementName`, `elementCode`, `operationType`, `createTime`, `updateTime`)
VALUES
    ('视频投稿按钮', 'postVideoButton', 0, NULL, NULL);

DROP TABLE IF EXISTS `t_auth_menu`;
CREATE TABLE `t_auth_menu` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) DEFAULT NULL COMMENT '菜单项目名称',
    `code` varchar(50) DEFAULT NULL COMMENT '唯一编码',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='权限控制-页面访问表';

DROP TABLE IF EXISTS `t_auth_role`;
CREATE TABLE `t_auth_role` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) DEFAULT NULL COMMENT '角色名称',
    `code` varchar(50) DEFAULT NULL COMMENT '角色唯一编码',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT='权限控制--角色表';

INSERT INTO `t_auth_role` (`name`, `code`, `createTime`, `updateTime`)
VALUES
    ('等级0', 'Lv0', NULL, NULL),
    ('等级1', 'Lv1', NULL, NULL),
    ('等级2', 'Lv2', NULL, NULL),
    ('等级3', 'Lv3', NULL, NULL),
    ('等级4', 'Lv4', NULL, NULL),
    ('等级5', 'Lv5', NULL, NULL);

DROP TABLE IF EXISTS `t_auth_role_element_operation`;
CREATE TABLE `t_auth_role_element_operation` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `roleId` bigint DEFAULT NULL COMMENT '角色id',
    `elementOperationId` bigint DEFAULT NULL COMMENT '元素操作id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT='权限控制--角色与元素操作关联表';

INSERT INTO `t_auth_role_element_operation` (`roleId`, `elementOperationId`, `createTime`)
VALUES
    ('2', '1', NULL),
    ('3', '1', NULL),
    ('4', '1', NULL),
    ('5', '1', NULL),
    ('6', '1', NULL);

DROP TABLE IF EXISTS `t_auth_role_menu`;
CREATE TABLE `t_auth_role_menu` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `roleId` bigint DEFAULT NULL COMMENT '角色id',
    `menuId` bigint DEFAULT NULL COMMENT '页面菜单id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT='权限控制--角色页面菜单关联表';

DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `roleId` bigint DEFAULT NULL COMMENT '角色id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT='用户角色关联表';

DROP TABLE IF EXISTS `t_refresh_token`;
CREATE TABLE `t_refresh_token` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `refreshToken` varchar(500) DEFAULT NULL COMMENT '刷新令牌',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT='刷新令牌记录表';

DROP TABLE IF EXISTS `t_collection_group`;
CREATE TABLE `t_collection_group`  (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `name` varchar(50) DEFAULT NULL COMMENT '关注分组名称',
    `type` varchar(5) DEFAULT NULL COMMENT '关注分组类型：0默认分组  1用户自定义分组',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT = '收藏分组表';

DROP TABLE IF EXISTS `t_danmu`;
CREATE TABLE `t_danmu`  (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `videoId` bigint DEFAULT NULL COMMENT '视频Id',
    `content` text NOT NULL COMMENT '弹幕内容',
    `danmuTime` varchar(50) DEFAULT NULL COMMENT '弹幕出现时间',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT = '弹幕记录表';

DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file`  (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `url` varchar(500) DEFAULT NULL COMMENT '文件存储路径',
    `type` varchar(50) DEFAULT NULL COMMENT '文件类型',
    `md5` varchar(500) DEFAULT NULL COMMENT '文件md5唯一标识串',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) COMMENT = '文件表';

DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) DEFAULT NULL COMMENT '标签名称',
    `createTime` datetime DEFAULT NULL,
    PRIMARY KEY (`id`)
) COMMENT = '标签表';

DROP TABLE IF EXISTS `t_video`;
CREATE TABLE `t_video`  (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint NOT NULL COMMENT '用户id',
    `url` varchar(500) NOT NULL COMMENT '视频链接',
    `thumbnail` varchar(500) NOT NULL COMMENT '封面链接',
    `title` varchar(255) NOT NULL COMMENT '视频标题',
    `type` varchar(5) NOT NULL COMMENT '视频类型：0原创 1转载',
    `duration` varchar(255) NOT NULL COMMENT '视频时长',
    `area` varchar(255) NOT NULL COMMENT '所在分区：0鬼畜 1音乐 2电影',
    `description` text DEFAULT NULL COMMENT '视频简介',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT = '视频投稿记录表';

DROP TABLE IF EXISTS `t_video_coin`;
CREATE TABLE `t_video_coin`  (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '视频投稿id',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `videoId` bigint DEFAULT NULL COMMENT '视频投稿id',
    `amount` int DEFAULT NULL COMMENT '投币数',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) COMMENT = '视频硬币表';

DROP TABLE IF EXISTS `t_video_collection`;
CREATE TABLE `t_video_collection`  (
     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
     `videoId` bigint DEFAULT NULL COMMENT '视频投稿id',
     `userId` bigint DEFAULT NULL COMMENT '用户id',
     `groupId` bigint DEFAULT NULL COMMENT '收藏分组id',
     `createTime` datetime DEFAULT NULL COMMENT '创建时间',
     PRIMARY KEY (`id`)
) COMMENT = '视频收藏记录表';

DROP TABLE IF EXISTS `t_video_comment`;
CREATE TABLE `t_video_comment`  (
     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
     `videoId` bigint NOT NULL COMMENT '视频id',
     `userId` bigint NOT NULL COMMENT '用户id',
     `comment` text NOT NULL COMMENT '评论',
     `replyUserId` bigint DEFAULT NULL COMMENT '回复用户id',
     `rootId` bigint DEFAULT NULL COMMENT '根节点评论id',
     `createTime` datetime DEFAULT NULL COMMENT '创建时间',
     `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
     PRIMARY KEY (`id`)
) COMMENT = '视频评论表';

DROP TABLE IF EXISTS `t_video_like`;
CREATE TABLE `t_video_like`  (
     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
     `userId` bigint NOT NULL COMMENT '用户id',
     `videoId` bigint NOT NULL COMMENT '视频投稿id',
     `createTime` datetime DEFAULT NULL COMMENT '创建时间',
     PRIMARY KEY (`id`)
) COMMENT = '视频点赞记录表';

DROP TABLE IF EXISTS `t_video_tag`;
CREATE TABLE `t_video_tag`  (
     `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
     `videoId` bigint NOT NULL COMMENT '视频id',
     `tagId` bigint NOT NULL COMMENT '标签id',
     `createTime` datetime DEFAULT NULL COMMENT '创建时间',
     PRIMARY KEY (`id`) USING BTREE
) COMMENT = '视频标签关联表';

DROP TABLE IF EXISTS `t_video_binary_picture`;
CREATE TABLE `t_video_binary_picture` (
      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
      `videoId` bigint DEFAULT NULL COMMENT '视频id',
      `frameNo` int DEFAULT NULL COMMENT '帧数',
      `url` varchar(255) DEFAULT NULL COMMENT '图片链接',
      `videoTimestamp` bigint DEFAULT NULL COMMENT '视频时间戳',
      `createTime` datetime DEFAULT NULL,
      PRIMARY KEY (`id`)
) COMMENT='视频二值图记录表';

DROP TABLE IF EXISTS `t_video_operation`;
CREATE TABLE `t_video_operation` (
      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
      `userId` bigint DEFAULT NULL COMMENT '用户id',
      `videoId` bigint DEFAULT NULL COMMENT '视频id',
      `operationType` varchar(5) DEFAULT NULL COMMENT '操作类型：0点赞、1收藏、2投币',
      `createTime` datetime DEFAULT NULL COMMENT '创建时间',
      PRIMARY KEY (`id`)
) COMMENT='视频操作表';

DROP TABLE IF EXISTS `t_video_view`;
CREATE TABLE `t_video_view` (
      `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键id',
      `videoId` bigint NOT NULL COMMENT '视频id',
      `userId` bigint DEFAULT NULL COMMENT '用户id',
      `clientId` varchar(500) DEFAULT NULL COMMENT '客户端id',
      `ip` varchar(50) DEFAULT NULL COMMENT 'ip',
      `createTime` datetime DEFAULT NULL COMMENT '创建时间',
      PRIMARY KEY (`id`)
) COMMENT='视频观看记录表';

