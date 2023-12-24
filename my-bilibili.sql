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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户基本信息表';

DROP TABLE IF EXISTS `t_following_group`;
CREATE TABLE `t_following_group` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `name` varchar(50) DEFAULT NULL COMMENT '关注分组名称',
    `type` varchar(5) DEFAULT NULL COMMENT '关注分组类型：0特别关注 1悄悄关注 2默认分组 3自定义',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户关注分组表';

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户关注表';

DROP TABLE IF EXISTS `t_user_moments`;
CREATE TABLE `t_user_moments` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `type` varchar(5) DEFAULT NULL COMMENT '动态类型：0视频 1直播 2专栏',
    `contentId` bigint DEFAULT NULL COMMENT '内容详情id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户动态表';

DROP TABLE IF EXISTS `t_auth_element_operation`;
CREATE TABLE `t_auth_element_operation` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `elementName` varchar(255) DEFAULT NULL COMMENT '页面元素名称',
    `elementCode` varchar(50) DEFAULT NULL COMMENT '页面元素唯一编码',
    `operationType` varchar(5) DEFAULT NULL COMMENT '操作类型：0可点击  1可见',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限控制--页面元素操作表';

DROP TABLE IF EXISTS `t_auth_menu`;
CREATE TABLE `t_auth_menu` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) DEFAULT NULL COMMENT '菜单项目名称',
    `code` varchar(50) DEFAULT NULL COMMENT '唯一编码',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限控制-页面访问表';

DROP TABLE IF EXISTS `t_auth_role`;
CREATE TABLE `t_auth_role` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `name` varchar(255) DEFAULT NULL COMMENT '角色名称',
    `code` varchar(50) DEFAULT NULL COMMENT '角色唯一编码',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限控制--角色表';

DROP TABLE IF EXISTS `t_auth_role_element_operation`;
CREATE TABLE `t_auth_role_element_operation` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `roleId` bigint DEFAULT NULL COMMENT '角色id',
    `elementOperationId` bigint DEFAULT NULL COMMENT '元素操作id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限控制--角色与元素操作关联表';

DROP TABLE IF EXISTS `t_auth_role_menu`;
CREATE TABLE `t_auth_role_menu` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `roleId` bigint DEFAULT NULL COMMENT '角色id',
    `menuId` bigint DEFAULT NULL COMMENT '页面菜单id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='权限控制--角色页面菜单关联表';

DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
    `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
    `userId` bigint DEFAULT NULL COMMENT '用户id',
    `roleId` bigint DEFAULT NULL COMMENT '角色id',
    `createTime` datetime DEFAULT NULL COMMENT '创建时间',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户角色关联表';

