package com.nxj.bilibili.dao;

import com.nxj.bilibili.domain.auth.AuthRoleElementOperation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

@Mapper
public interface AuthRoleElementOperationDao {
    List<AuthRoleElementOperation> getRoleElementOperationByRoleIds(@Param("roleIdSet") Set<Long> roleIdSet);
}
