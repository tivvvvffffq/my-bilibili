package com.nxj.bilibili.service;

import com.nxj.bilibili.dao.AuthRoleElementOperationDao;
import com.nxj.bilibili.domain.auth.AuthRoleElementOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
public class AuthRoleElementOperationService {
    @Autowired
    private AuthRoleElementOperationDao authRoleElementOperationDao;
    public List<AuthRoleElementOperation> getRoleElementOperationByRoleIds(Set<Long> roleIdSet) {
        return authRoleElementOperationDao.getRoleElementOperationByRoleIds(roleIdSet);
    }
}
