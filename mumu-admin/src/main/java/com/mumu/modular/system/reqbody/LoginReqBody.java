package com.mumu.modular.system.reqbody;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  登陆请求入参请求体封装
 *  
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class LoginReqBody {

    /**
     * 账号
     */
    private String account;
    /**
     * 密码
     */
    private String password;
    
    /**
     * 是否记住
     */
    private String remember;
    
    /**
     * 验证码
     */
    private String kaptcha;

    public String getAccount() {
        return account;
    }

    public String getPassword() {
        return password;
    }

    public String getRemember() {
        return remember;
    }

    public String getKaptcha() {
        return kaptcha;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRemember(String remember) {
        this.remember = remember;
    }

    public void setKaptcha(String kaptcha) {
        this.kaptcha = kaptcha;
    }
    
}
