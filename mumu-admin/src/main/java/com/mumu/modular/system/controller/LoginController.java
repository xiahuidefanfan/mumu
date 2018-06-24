package com.mumu.modular.system.controller;

import static com.mumu.core.support.HttpKit.getIp;

import java.io.IOException;

import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.base.controller.BaseController;
import com.mumu.core.exception.MumuException;
import com.mumu.core.exception.MumuExceptionEnum;
import com.mumu.core.log.LogManager;
import com.mumu.core.log.factory.LogTaskFactory;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.shiro.ShiroUser;
import com.mumu.core.support.RespData;
import com.mumu.modular.system.reqbody.LoginReqBody;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  登录控制器
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
public class LoginController extends BaseController{
    
    private static final String REMEMBER_ON = "on";

    /**
     * 点击登录执行的动作
     * @throws IOException 
     */
    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    @ResponseBody
    public RespData doLogin(@RequestBody LoginReqBody loginReqBody) throws IOException {

        if(null == loginReqBody) {
            throw new MumuException(MumuExceptionEnum.REQUEST_NULL);
        }
        
        /**
         * shiro验证并登陆
         */
        Subject currentUser = ShiroKit.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(loginReqBody.getAccount(), loginReqBody.
                getPassword().toCharArray());
        if (REMEMBER_ON.equals(loginReqBody.getRemember())) {
            token.setRememberMe(true);
        } else {
            token.setRememberMe(false);
        }
        currentUser.login(token);
        ShiroUser shiroUser = ShiroKit.getUser();
        super.getSession().setAttribute("shiroUser", shiroUser);
        super.getSession().setAttribute("username", shiroUser.getAccount());
        LogManager.me().executeLog(LogTaskFactory.loginLog(shiroUser.getId(), getIp()));
        ShiroKit.getSession().setAttribute("sessionFlag", true);
        
        // 返回成功
        return RespData.getRespData(HttpStatus.OK.value(), null, "");
    }
    
    /**
     * 退出登录
     */
    @RequestMapping(value = "/doLogout", method = RequestMethod.POST)
    @ResponseBody
    public RespData logOut() {
        LogManager.me().executeLog(LogTaskFactory.exitLog(ShiroKit.getUser().getId(), getIp()));
        ShiroKit.getSubject().logout();
        return RespData.getRespData(HttpStatus.OK.value(), null, "");
    }
}
