package com.nxj.bilibili.service;

import com.nxj.bilibili.dao.UserFollowingDao;
import com.nxj.bilibili.domain.FollowingGroup;
import com.nxj.bilibili.domain.User;
import com.nxj.bilibili.domain.UserFollowing;
import com.nxj.bilibili.domain.constant.UserConstant;
import com.nxj.bilibili.domain.exception.ConditionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
public class UserFollowingService {

    @Autowired
    private UserFollowingDao userFollowingDao;

    @Autowired
    private FollowingGroupService followingGroupService;

    @Autowired
    private UserService userService;

    @Transactional
    public void addUserFollowings(UserFollowing userFollowing) {
        Long groupId = userFollowing.getGroupId();
        if(groupId == null) {
            FollowingGroup followingGroup = followingGroupService.getByType(UserConstant.USER_FOLLOWING_GROUP_TYPE_DEFAULT);
            userFollowing.setGroupId(followingGroup.getId());
        }else {
            FollowingGroup followingGroup = followingGroupService.getById(groupId);
            if(followingGroup == null) {
                throw new ConditionException("关注分组不存在！");
            }
        }
        Long followingId = userFollowing.getFollowingId();
        User user = userService.getUserById(followingId);
        if(user == null) {
            throw new ConditionException("关注用户不存在！");
        }
        userFollowing.setCreateTime(new Date());

        userFollowingDao.deleteUserFollowing(userFollowing.getUserId(), followingId);
        userFollowingDao.addUserFollowing(userFollowing);
    }
}
