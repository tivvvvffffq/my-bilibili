package com.nxj.bilibili.api;

import com.nxj.bilibili.api.support.UserSupport;
import com.nxj.bilibili.domain.JsonResponse;
import com.nxj.bilibili.domain.UserMoment;
import com.nxj.bilibili.domain.annotation.ApiLimitedRole;
import com.nxj.bilibili.domain.annotation.DataLimited;
import com.nxj.bilibili.domain.constant.AuthRoleConstant;
import com.nxj.bilibili.service.UserMomentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "用户动态接口")
@RequestMapping("moment")
@RestController
public class UserMomentApi {
    @Autowired
    private UserMomentService userMomentService;

    @Autowired
    private UserSupport userSupport;

    @ApiLimitedRole(limitedRoleCodeList = {AuthRoleConstant.ROLE_LV0})
    @DataLimited
    @ApiOperation("发布动态")
    @ApiImplicitParam(name = "token", value = "用户认证令牌", required = true, dataType = "String", paramType = "header")
    @PostMapping("/user-moments")
    public JsonResponse<String> addUserMoments(@RequestBody UserMoment userMoment) throws Exception {
        Long userId = userSupport.getCurrentUserId();
        userMoment.setUserId(userId);
        userMomentService.addUserMoments(userMoment);
        return JsonResponse.success();
    }

    @ApiOperation("获取订阅动态")
    @ApiImplicitParam(name = "token", value = "用户认证令牌", required = true, dataType = "String", paramType = "header")
    @GetMapping("/user-subscribed-moments")
    public JsonResponse<List<UserMoment>> getUserSubscribedMoments() {
        Long userId = userSupport.getCurrentUserId();
        List<UserMoment> list = userMomentService.getUserSubscribedMoments(userId);
        return new JsonResponse<>(list);
    }
}
