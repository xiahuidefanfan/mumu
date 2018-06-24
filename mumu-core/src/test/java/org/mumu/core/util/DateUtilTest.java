package org.mumu.core.util;

import java.util.Date;

import org.junit.Test;

import com.mumu.core.util.DateUtil;

public class DateUtilTest {
    
    /**
     * 格式化日期
     */
    @Test
    public void formatDate() {
        System.out.println(DateUtil.formatDate(new Date(Long.parseLong("1528287188000")),"yyyy-MM-dd"));
    }


}
