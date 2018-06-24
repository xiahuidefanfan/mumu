package com.mumu.modular.system.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.system.condition.UserSerachCondition;
import com.mumu.modular.system.model.User;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 用户service接口
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public interface IUserService extends IService<User>{
    /**
     * 通过账号获取用户
     */
    User getByAccount(String account);
    
    /**
     * 根据条件查询用户列表
     */
    List<Map<String, Object>> selectUsers(Page<User> page, UserSerachCondition condition);
    
    /**
     * 修改用户状态
     */
    int setStatus(String userId, int status);

    /**
     * 修改密码
     */
    int changePwd(String userId, String pwd);

    /**
     * 设置用户的角色
     */
    int setRoles(String userId, String roleIds);


}
