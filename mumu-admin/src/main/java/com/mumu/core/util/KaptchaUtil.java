package com.mumu.core.util;

import com.mumu.config.properties.MumuProperties;

/**
 * 验证码工具类
 */
public class KaptchaUtil {

    /**
     * 获取验证码开关
     */
    public static Boolean getKaptchaOnOff() {
        return SpringContextHolder.getBean(MumuProperties.class).getKaptchaOpen();
    }
}