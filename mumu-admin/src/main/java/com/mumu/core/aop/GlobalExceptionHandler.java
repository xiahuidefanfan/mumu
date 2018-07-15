package com.mumu.core.aop;

import static com.mumu.core.support.HttpKit.getIp;
import static com.mumu.core.support.HttpKit.getRequest;

import java.lang.reflect.UndeclaredThrowableException;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.CredentialsException;
import org.apache.shiro.authc.DisabledAccountException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.common.exception.InvalidKaptchaException;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogManager;
import com.mumu.core.log.factory.LogTaskFactory;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.support.RespData;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  全局的的异常拦截器（拦截所有的控制器）（带有@RequestMapping注解的方法上都会拦截）
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */

@ControllerAdvice
@Order(-1)
public class GlobalExceptionHandler extends BaseController{

    private Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * 拦截业务异常
     */
    @ExceptionHandler(MumuException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ResponseBody
    public RespData notFount(MumuException e) {
        LogManager.me().executeLog(LogTaskFactory.exceptionLog(ShiroKit.getUser().getId(), e));
        getRequest().setAttribute("tip", e.getMessage());
        log.error("业务异常:", e);
        return RespData.getRespData(HttpStatus.INTERNAL_SERVER_ERROR.value(), null , e.getMessage());
    }

    /**
     * 用户未登录异常
     */
    @ExceptionHandler(AuthenticationException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ResponseBody
    public RespData unAuth(AuthenticationException e) {
        log.error("用户未登陆：", e);
        return RespData.getRespData(HttpStatus.UNAUTHORIZED.value(), null , "用户未登陆！");
    }

    /**
     * 账号被冻结异常
     */
    @ExceptionHandler(DisabledAccountException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public RespData accountLocked(DisabledAccountException e, Model model) {
        String username = getRequest().getParameter("username");
        LogManager.me().executeLog(LogTaskFactory.loginLog(username, "账号被冻结", getIp()));
        model.addAttribute("tips", "账号被冻结");
        return RespData.getRespData(HttpStatus.UNAUTHORIZED.value(), null , "账号被冻结！");
    }

    /**
     * 账号密码错误异常
     */
    @ExceptionHandler(CredentialsException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ResponseBody
    public RespData credentials(CredentialsException e, Model model) {
        String username = getRequest().getParameter("username");
        LogManager.me().executeLog(LogTaskFactory.loginLog(username, "账号密码错误", getIp()));
        model.addAttribute("tips", "账号密码错误");
        return RespData.getRespData(HttpStatus.UNAUTHORIZED.value(), null, "用户名或密码错误！");
    }

    /**
     * 验证码错误异常
     */
    @ExceptionHandler(InvalidKaptchaException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public RespData credentials(InvalidKaptchaException e, Model model) {
        String username = getRequest().getParameter("username");
        LogManager.me().executeLog(LogTaskFactory.loginLog(username, "验证码错误", getIp()));
        model.addAttribute("tips", "验证码错误");
        return RespData.getRespData(HttpStatus.BAD_REQUEST.value(), null, "验证码错误！");
    }

    /**
     * 无权访问该资源异常
     */
    @ExceptionHandler(UndeclaredThrowableException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    @ResponseBody
    public RespData credentials(UndeclaredThrowableException e) {
        log.error("权限异常!", e);
        return RespData.getRespData(HttpStatus.UNAUTHORIZED.value(), null, 
                BizExceptionEnum.NO_PERMITION.getMessage());
    }

    /**
     * 拦截未知的运行时异常
     */
    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    @ResponseBody
    public RespData notFount(RuntimeException e) {
        LogManager.me().executeLog(LogTaskFactory.exceptionLog(ShiroKit.getUser().getId(), e));
        getRequest().setAttribute("tip", "服务器未知运行时异常");
        log.error("运行时异常:", e);
        return RespData.getRespData(HttpStatus.INTERNAL_SERVER_ERROR.value(), null, 
                BizExceptionEnum.SERVER_ERROR.getMessage());
    }
}
