package com.mumu.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

/**
 * spring session配置
 * @EnableRedisHttpSession(maxInactiveIntervalInSeconds = 1800)
 * @author fengshuonan
 * @date 2017-07-13 21:05
 */
@ConditionalOnProperty(prefix = "guns", name = "spring-session-open", havingValue = "true")
public class SpringSessionConfig {

}
