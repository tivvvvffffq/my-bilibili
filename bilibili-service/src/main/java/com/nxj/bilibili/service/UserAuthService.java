package com.nxj.bilibili.service;

import com.nxj.bilibili.domain.auth.AuthRoleElementOperation;
import com.nxj.bilibili.domain.auth.AuthRoleMenu;
import com.nxj.bilibili.domain.auth.UserAuthorities;
import com.nxj.bilibili.domain.auth.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserAuthService {

    @Autowired
    private UserRoleService userRoleService;

    @Autowired
    private AuthRoleService authRoleService;

    public UserAuthorities getUserAuthorities(Long userId) {
        List<UserRole> userRoleList = userRoleService.getUserRoleByUserId(userId);
        Set<Long> roleIdSet = userRoleList.stream().map(UserRole :: getRoleId).collect(Collectors.toSet());
        List<AuthRoleElementOperation> roleElementOperationList = authRoleService.getRoleElementOperationByRoleIds(roleIdSet);
        List<AuthRoleMenu> authRoleMenuList = authRoleService.getAuthRoleMenusByRoleIds(roleIdSet);
        UserAuthorities userAuthorities = new UserAuthorities();
        userAuthorities.setRoleElementOperationList(roleElementOperationList);
        userAuthorities.setRoleMenuList(authRoleMenuList);
        return userAuthorities;
    }
}
