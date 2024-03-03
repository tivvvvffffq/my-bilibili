package com.nxj.bilibili.dao;

import com.nxj.bilibili.domain.auth.UserRole;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface UserRoleDao {
    public List<UserRole> getUserRoleByUserId(Long userId);


    void addUserRole(UserRole userRole);
}
