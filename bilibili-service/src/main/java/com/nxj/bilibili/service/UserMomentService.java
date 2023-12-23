package com.nxj.bilibili.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.nxj.bilibili.dao.UserMomentDao;
import com.nxj.bilibili.domain.UserMoment;
import com.nxj.bilibili.domain.constant.UserRoutingConstant;
import com.nxj.bilibili.service.util.RabbitMQUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
public class UserMomentService {
    @Autowired
    private UserMomentDao userMomentDao;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    private RedisTemplate redisTemplate;

    @Autowired
    private RabbitMQUtil rabbitMQUtil;

    public void addUserMoments(UserMoment userMoment) throws Exception {
        userMoment.setCreateTime(new Date());
        userMomentDao.addUserMoments(userMoment);
        rabbitMQUtil.produce(UserRoutingConstant.MOMENTS, JSONObject.toJSONString(userMoment));
    }

    public List<UserMoment> getUserSubscribedMoments(Long userId) {
        String key = "subscribed-" + userId;
        String listStr = (String) redisTemplate.opsForValue().get(key);
        return JSONArray.parseArray(listStr, UserMoment.class);
    }
}
