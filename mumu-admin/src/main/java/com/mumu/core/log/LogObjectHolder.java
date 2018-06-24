package com.mumu.core.log;

import java.io.Serializable;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import com.mumu.core.util.SpringContextHolder;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 被修改的bean临时存放的地方
 *
 * @author 88396254
 * @date 2018年6月13日 下午2:09:05
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */

@Component
@Scope(scopeName = WebApplicationContext.SCOPE_SESSION)
public class LogObjectHolder implements Serializable{

    /**
     */
    private static final long serialVersionUID = 1L;
    
    private Object object = null;

    public void set(Object obj) {
        this.object = obj;
    }

    public Object get() {
        return object;
    }

    public static LogObjectHolder me(){
        LogObjectHolder bean = SpringContextHolder.getBean(LogObjectHolder.class);
        return bean;
    }
}
