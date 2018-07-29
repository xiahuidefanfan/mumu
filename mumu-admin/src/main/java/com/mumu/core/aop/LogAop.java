package com.mumu.core.aop;

import java.lang.reflect.Method;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.constant.dictmap.base.AbstractDictMap;
import com.mumu.core.log.LogManager;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.log.factory.LogTaskFactory;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.shiro.ShiroUser;
import com.mumu.core.util.Contrast;
import com.mumu.core.util.ToolUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  日志记录
 *
 * @author 88396254
 * @date 2018年6月13日 下午7:04:38
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Aspect
@Component
public class LogAop {

    private Logger log = LoggerFactory.getLogger(this.getClass());
    
    private static final String UPDATE = "修改";
    
    private static final String EDIT = "编辑";

    @Pointcut(value = "@annotation(com.mumu.core.common.annotion.BussinessLog)")
    public void cutService() {
    }

    @Around("cutService()")
    public Object recordSysLog(ProceedingJoinPoint point) throws Throwable {

        //先执行业务
        Object result = point.proceed();

        try {
            handle(point);
        } catch (Exception e) {
            log.error("日志记录出错!", e);
        }

        return result;
    }

    @SuppressWarnings("rawtypes")
    private void handle(ProceedingJoinPoint point) throws Exception {
        Object[] objNews = point.getArgs();
        if(ToolUtil.isEmpty(objNews)) {
            return;
        }
        
        //获取拦截的方法名
        Signature sig = point.getSignature();
        MethodSignature msig = null;
        if (!(sig instanceof MethodSignature)) {
            throw new IllegalArgumentException("该注解只能用于方法");
        }
        msig = (MethodSignature) sig;
        Object target = point.getTarget();
        Method currentMethod = target.getClass().getMethod(msig.getName(), msig.getParameterTypes());
        String methodName = currentMethod.getName();

        //如果当前用户未登录，不做日志
        ShiroUser user = ShiroKit.getUser();
        if (null == user) {
            return;
        }

        //获取拦截方法的参数
        String className = point.getTarget().getClass().getName();
        
        //获取操作名称
        BussinessLog annotation = currentMethod.getAnnotation(BussinessLog.class);
        String bussinessName = annotation.value();
        String key = annotation.key();
        Class dictClass = annotation.dict();
        Object objOld = LogObjectHolder.me().get();
        //如果涉及到修改,比对变化
        String msg;
        if (bussinessName.indexOf(UPDATE) != -1 || bussinessName.indexOf(EDIT) != -1) {
            msg = Contrast.contrastObj(dictClass, key, objOld, objNews[0]);
        } else {
            AbstractDictMap dictMap = (AbstractDictMap) dictClass.newInstance();
            msg = Contrast.parseKey(dictMap,key, objNews[0]);
        }

        LogManager.me().executeLog(LogTaskFactory.bussinessLog(user.getId(), bussinessName, className, methodName, msg));
    }
}