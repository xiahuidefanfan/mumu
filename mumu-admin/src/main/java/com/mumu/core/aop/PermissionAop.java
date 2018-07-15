/**
 * Copyright (c) 2015-2017, Chill Zhuang 庄骞 (smallchill@163.com).
 * <p>
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * http://www.apache.org/licenses/LICENSE-2.0
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.mumu.core.aop;

import java.lang.reflect.Method;

import javax.naming.NoPermissionException;

import org.apache.shiro.authc.AuthenticationException;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.mumu.core.common.annotion.Permission;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.shiro.check.PermissionCheckManager;
import com.mumu.core.util.ToolUtil;

/**
 * AOP 权限自定义检查
 */
@Aspect
@Component
@Order(200)
public class PermissionAop {

    @Pointcut(value = "@annotation(com.mumu.core.common.annotion.Permission)")
    private void cutPermission() {

    }

    @Around("cutPermission()")
    public Object doPermission(ProceedingJoinPoint point) throws Throwable {
        // 先检查是否登录
        if(ToolUtil.isEmpty(ShiroKit.getUser())) {
            throw new AuthenticationException();
        }
        MethodSignature ms = (MethodSignature) point.getSignature();
        Method method = ms.getMethod();
        Permission permission = method.getAnnotation(Permission.class);
        Object[] permissions = permission.value();
        boolean result = false;
        if (permissions == null || permissions.length == 0) {
            //检查全体角色
            result = PermissionCheckManager.checkAll();
        } else {
            //检查指定角色
            result = PermissionCheckManager.check(permissions);
        }
        if (result) {
            return point.proceed();
        } else {
            throw new NoPermissionException();
        }

    }

}
