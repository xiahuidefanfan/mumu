package com.mumu.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  spring session配置
 *
 * @author 88396254
 * @date 2018年7月11日 下午3:07:25
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@ConditionalOnProperty(prefix = "guns", name = "spring-session-open", havingValue = "true")
public class SpringSessionConfig {

}
