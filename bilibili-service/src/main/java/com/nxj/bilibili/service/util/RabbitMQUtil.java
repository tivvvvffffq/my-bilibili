package com.nxj.bilibili.service.util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.nxj.bilibili.domain.Danmu;
import com.nxj.bilibili.domain.UserFollowing;
import com.nxj.bilibili.domain.UserMoment;
import com.nxj.bilibili.domain.constant.UserRoutingConstant;
import com.nxj.bilibili.service.DanmuService;
import com.nxj.bilibili.service.UserFollowingService;
import com.nxj.bilibili.service.config.RabbitMQConfig;
import com.nxj.bilibili.service.websocket.WebSocketService;
import io.netty.util.internal.StringUtil;
import org.bytedeco.javacpp.presets.opencv_core;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
public class RabbitMQUtil {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @Autowired
    private StringRedisTemplate redisTemplate;

    @Autowired
    private UserFollowingService userFollowingService;

    @Autowired
    private DanmuService danmuService;

    //同步发送消息
    public void produce(String key, Object payload) {
        rabbitTemplate.convertAndSend(
                RabbitMQConfig.EXCHANGE_MSG,
                UserRoutingConstant.ROUTING + key,
                payload);
        System.out.println("同步发消息");
    }

    //异步发送消息
    @Async
    public void asyncProduce(String key, Object payload) {
        rabbitTemplate.convertAndSend(
                RabbitMQConfig.EXCHANGE_MSG,
                UserRoutingConstant.ROUTING + key,
                payload);
        System.out.println("异步发消息");
    }

    // 消费
    @RabbitListener(queues = {RabbitMQConfig.QUEUE_SYS_MSG})
    public void consume(String payload, Message message) {
        String routingKey = message.getMessageProperties().getReceivedRoutingKey();
        if(routingKey.equalsIgnoreCase(UserRoutingConstant.ROUTING + UserRoutingConstant.MOMENTS)) {
            UserMoment userMoment = JSONObject.toJavaObject(JSONObject.parseObject(payload), UserMoment.class);
            Long userId = userMoment.getUserId();
            List<UserFollowing>fanList = userFollowingService.getUserFans(userId);
            for(UserFollowing fan: fanList) {
                String key = UserRoutingConstant.REDIS_SUBSCRIBE + fan.getUserId();
                String subscribedListStr = redisTemplate.opsForValue().get(key);
                List<UserMoment> subscribedList;
                if (StringUtil.isNullOrEmpty(subscribedListStr)) {
                    subscribedList = new ArrayList<>();
                } else {
                    subscribedList = JSONArray.parseArray(subscribedListStr, UserMoment.class);
                }
                subscribedList.add(userMoment);
                redisTemplate.opsForValue().set(key, JSONObject.toJSONString(subscribedList));
            }
        }else if(routingKey.equalsIgnoreCase(UserRoutingConstant.ROUTING + UserRoutingConstant.DANMUS)) {
            JSONObject o = JSONObject.parseObject(payload, JSONObject.class);
            String messageStr = o.getString("message");
            String sessionId = o.getString("sessionId");
            WebSocketService webSocketService = WebSocketService.WEBSOCKET_MAP.get(sessionId);
            if(webSocketService.getSession().isOpen()){
                try {
                    webSocketService.sendMessage(messageStr);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }else if(routingKey.equalsIgnoreCase(UserRoutingConstant.ROUTING + UserRoutingConstant.DANMUSAVE)) {
            Danmu danmu = JSONObject.toJavaObject(JSONObject.parseObject(payload), Danmu.class);
            danmuService.asyncAddDanmu(danmu);
            danmuService.addDanmusToRedis(danmu);
        }
    }


}
