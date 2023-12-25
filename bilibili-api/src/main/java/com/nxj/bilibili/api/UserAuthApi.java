package com.nxj.bilibili.api;

import com.nxj.bilibili.api.support.UserSupport;
import com.nxj.bilibili.domain.JsonResponse;
import com.nxj.bilibili.domain.auth.UserAuthorities;
import com.nxj.bilibili.service.UserAuthService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Api(tags = "用户权限接口")
@RestController
@RequestMapping("auth")
public class UserAuthApi {

    @Autowired
    private UserSupport userSupport;

    @Autowired
    private UserAuthService userAuthService;

    @ApiOperation("获取用户权限")
    @ApiImplicitParam(name = "token", value = "用户认证令牌", required = true, dataType = "String", paramType = "header")
    @GetMapping("/user-authorities")
    public JsonResponse<UserAuthorities> getUserAuthorities() {
        Long userId = userSupport.getCurrentUserId();
        UserAuthorities userAuthorities = userAuthService.getUserAuthorities(userId);
        return new JsonResponse<>(userAuthorities);
    }

}
