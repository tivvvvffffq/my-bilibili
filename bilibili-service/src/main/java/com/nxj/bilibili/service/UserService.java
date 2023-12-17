package com.nxj.bilibili.service;

import com.mysql.jdbc.StringUtils;
import com.nxj.bilibili.dao.UserDao;
import com.nxj.bilibili.domain.User;
import com.nxj.bilibili.domain.constant.UserConstant;
import com.nxj.bilibili.domain.exception.ConditionException;
import com.nxj.bilibili.domain.UserInfo;
import com.nxj.bilibili.service.util.MD5Util;
import com.nxj.bilibili.service.util.RSAUtil;
import com.nxj.bilibili.service.util.TokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class UserService {
    @Autowired
    private UserDao userDao;

    public void addUser(User user) {
        String phone = user.getPhone();
        if(StringUtils.isNullOrEmpty(phone)) {
            throw new ConditionException("手机号不能为空！");
        }
        User dbUser = this.getUserByPhone(phone);
        if (dbUser != null) {
            throw new ConditionException("该手机号已经被注册！");
        }

        Date now = new Date();
        String salt = String.valueOf(now.getTime());
        String password = user.getPassword();
        String rawPassword;
        try {
            //前端传到后端的密码经过了RSA加密
            rawPassword = RSAUtil.decrypt(password);
        } catch (Exception e) {
            throw new ConditionException("密码解密失败！");
        }
        //解密后的密码经过md5加密保存到数据库
        String md5Password = MD5Util.sign(rawPassword, salt, "UTF-8");
        user.setSalt(salt);
        user.setPassword(md5Password);
        user.setCreateTime(now);
        userDao.addUser(user);

        //用户信息表
        UserInfo userInfo = new UserInfo();
        userInfo.setUserId(user.getId());
        userInfo.setNick(UserConstant.DEFAULT_NICK);
        userInfo.setBirth(UserConstant.DEFAULT_BIRTH);
        userInfo.setGender(UserConstant.GENDER_UNKNOWN);
        userInfo.setCreateTime(now);
        userDao.addUserInfo(userInfo);
    }

    public User getUserByPhone(String phone) {
        return userDao.getUserByPhone(phone);
    }

    public String login(User user) throws Exception {
        String phone = user.getPhone();
        if(StringUtils.isNullOrEmpty(phone)) {
            throw new ConditionException("手机号不能为空！");
        }

        User dbUser = this.getUserByPhone(phone);
        if (dbUser == null) {
            throw new ConditionException("用户不存在！");
        }

        String password = user.getPassword();
        String rawPassword;
        try {
            rawPassword = RSAUtil.decrypt(password);
        } catch (Exception e) {
            throw new ConditionException("密码解密失败！");
        }

        String salt = dbUser.getSalt();
        String md5Password = MD5Util.sign(rawPassword, salt, "UTF-8");

        if(!md5Password.equals(dbUser.getPassword())) {
            throw new ConditionException("密码错误！");
        }

        //获取token
        return TokenUtil.generateToken(dbUser.getId());
    }

    public User getUserInfo(Long userId) {
        User user = userDao.getUserById(userId);
        UserInfo userInfo = userDao.getUserInfoByUserId(userId);
        user.setUserInfo(userInfo);
        return user;
    }
}
