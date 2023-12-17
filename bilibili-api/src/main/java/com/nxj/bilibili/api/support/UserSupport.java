package com.nxj.bilibili.api.support;

import com.nxj.bilibili.domain.exception.ConditionException;
import com.nxj.bilibili.service.util.TokenUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class UserSupport {
    public Long getCurrentUserId() {
        //获取http请求
        ServletRequestAttributes servletRequestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        //从请求头中获取token
        String token = servletRequestAttributes.getRequest().getHeader("token");
        Long userId = TokenUtil.verifyToken(token);
        if(userId < 0) {
            throw new ConditionException("非法用户！");
        }
        return userId;
    }
}
