package com.mumu.modular.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.modular.system.condition.UserSerachCondition;
import com.mumu.modular.system.dao.UserMapper;
import com.mumu.modular.system.model.User;
import com.mumu.modular.system.service.IUserService;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  用户servic实现
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Override
    public User getByAccount(String account) {
        return this.baseMapper.getByAccount(account);
    }

    @Override
    public List<Map<String, Object>> selectUsers(Page<User> page, UserSerachCondition condition) {
        return this.baseMapper.selectUsers(page, condition);
    }
    
    @Override
    public int setStatus(String userId, int status) {
        return this.baseMapper.setStatus(userId, status);
    }

    @Override
    public int changePwd(String userId, String pwd) {
        return this.baseMapper.changePwd(userId, pwd);
    }

    @Override
    public int setRoles(String userId, String roleIds) {
        return this.baseMapper.setRoles(userId, roleIds);
    }


}
