package com.nxj.bilibili.api;

import com.nxj.bilibili.api.support.UserSupport;
import com.nxj.bilibili.domain.FollowingGroup;
import com.nxj.bilibili.domain.JsonResponse;
import com.nxj.bilibili.domain.UserFollowing;
import com.nxj.bilibili.service.UserFollowingService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class UserFollowingApi {

    @Autowired
    private UserFollowingService userFollowingService;

    @Autowired
    private UserSupport userSupport;

    @ApiOperation("关注用户")
    @PostMapping("/user-followings")
    public JsonResponse<String> addUserFollowings(@RequestBody UserFollowing userFollowing) {
        Long userId = userSupport.getCurrentUserId();
        userFollowing.setUserId(userId);
        userFollowingService.addUserFollowings(userFollowing);
        return JsonResponse.success();
    }

    @ApiOperation("获取关注分组列表")
    @ApiImplicitParam(name = "token", value = "用户认证令牌", required = true, dataType = "String", paramType = "header")
    @GetMapping("/user-followings")
    public JsonResponse<List<FollowingGroup>> getUserFollowings() {
        Long userId = userSupport.getCurrentUserId();
        List<FollowingGroup> result = userFollowingService.getUserFollowings(userId);
        return new JsonResponse<>(result);
    }

    @ApiOperation("获取粉丝列表")
    @ApiImplicitParam(name = "token", value = "用户认证令牌", required = true, dataType = "String", paramType = "header")
    @GetMapping("/user-fans")
    public JsonResponse<List<UserFollowing>> getUserFans() {
        Long userId = userSupport.getCurrentUserId();
        List<UserFollowing> result = userFollowingService.getUserFans(userId);
        return new JsonResponse<>(result);
    }
}
