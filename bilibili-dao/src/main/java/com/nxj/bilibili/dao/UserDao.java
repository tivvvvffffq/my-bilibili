package com.nxj.bilibili.dao;

import com.nxj.bilibili.domain.User;
import com.nxj.bilibili.domain.UserInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Set;

@Mapper
public interface UserDao {
    User getUserByPhone(String phone);

    Integer addUser(User user);

    void addUserInfo(UserInfo userInfo);

    User getUserById(Long id);

    UserInfo getUserInfoByUserId(Long userId);

    Integer updateUsers(User user);

    User getUserByPhoneOrEmail(String phoneOrEmail);

    Integer updateUserInfos(UserInfo userInfo);

    List<UserInfo> getUserInfoByUserIds(Set<Long> userIdSet);
}
