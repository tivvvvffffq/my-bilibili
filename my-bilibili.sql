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
