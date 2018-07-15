package com.mumu;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * SpringBoot方式启动类
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@SpringBootApplication
@ComponentScan
public class MumuApplication {

    private final static Logger logger = LoggerFactory.getLogger(MumuApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(MumuApplication.class, args);
        logger.info("MumuApplication is success!");
    }
}
