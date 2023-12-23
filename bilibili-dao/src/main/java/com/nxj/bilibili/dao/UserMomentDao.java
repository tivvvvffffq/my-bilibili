package com.nxj.bilibili.dao;

import com.nxj.bilibili.domain.UserMoment;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMomentDao {
    Integer addUserMoments(UserMoment userMoment);
}
