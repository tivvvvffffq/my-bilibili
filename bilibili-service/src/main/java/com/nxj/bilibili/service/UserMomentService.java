package com.nxj.bilibili.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.nxj.bilibili.dao.UserMomentDao;
import com.nxj.bilibili.domain.UserMoment;
import com.nxj.bilibili.domain.constant.UserRoutingConstant;
import com.nxj.bilibili.service.util.RabbitMQUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
public class UserMomentService {
    @Autowired
    private UserMomentDao userMomentDao;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private RabbitMQUtil rabbitMQUtil;

    public void addUserMoments(UserMoment userMoment) {
        userMoment.setCreateTime(new Date());
        userMomentDao.addUserMoments(userMoment);
        rabbitMQUtil.produce(UserRoutingConstant.MOMENTS, JSONObject.toJSONString(userMoment));
    }

    public List<UserMoment> getUserSubscribedMoments(Long userId) {
        String key = UserRoutingConstant.REDIS_SUBSCRIBE + userId;
        String listStr = redisTemplate.opsForValue().get(key);
        return JSONArray.parseArray(listStr, UserMoment.class);
    }
}
