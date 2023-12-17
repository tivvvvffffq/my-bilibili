package com.nxj.bilibili.api;

import com.nxj.bilibili.domain.JsonResponse;
import com.nxj.bilibili.domain.User;
import com.nxj.bilibili.service.UserService;
import com.nxj.bilibili.service.util.RSAUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "用户信息接口")
@RequestMapping("/user")
@RestController
public class UserApi {
    @Autowired
    private UserService userService;

    @ApiOperation("获取公共key")
    @GetMapping("/rsa-pks")
    public JsonResponse<String> getRsaPublicKey() {
        String pk = RSAUtil.getPublicKeyStr();
        return new JsonResponse<>(pk);
    }

    @ApiOperation("注册用户")
    @PostMapping("/users")
    public JsonResponse<String> addUser(@RequestBody User user) {
        userService.addUser(user);
        return JsonResponse.success();
    }

    @ApiOperation("获取用户token")
    @PostMapping("/user-tokens")
    public JsonResponse<String> login(@RequestBody User user) {
        String token = userService.login(user);
        return new JsonResponse(token);
    }

}
