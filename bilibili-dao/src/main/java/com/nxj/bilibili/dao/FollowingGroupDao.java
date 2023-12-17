package com.nxj.bilibili.dao;

import com.nxj.bilibili.domain.FollowingGroup;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FollowingGroupDao {
    FollowingGroup getByType(String type);

    FollowingGroup getById(Long id);
}
