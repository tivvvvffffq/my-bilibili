package com.nxj;

import org.springframework.context.ApplicationContext;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Bilibili {
    public static void main(String[] args) {
        ApplicationContext app = SpringApplication.run(Bilibili.class, args);
    }
}
