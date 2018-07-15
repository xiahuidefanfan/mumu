package com.mumu.modular.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.mumu.modular.system.condition.UserSerachCondition;
import com.mumu.modular.system.model.User;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  用户操作dao
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Mapper
public interface UserMapper extends BaseMapper<User>{
    
    User getByAccount(@Param("account") String account);
    
    List<Map<String, Object>> getByRoleId(@Param("roleId") String roleId);
    
    List<Map<String, Object>> selectUsers(@Param("page")Page<User> page,@Param("condition")UserSerachCondition condition);
    
    /**
     * 修改用户状态
     */
    int setStatus(@Param("userId") String userId, @Param("status") int status);

    /**
     * 修改密码
     */
    int changePwd(@Param("userId") String userId, @Param("pwd") String pwd);


    /**
     * 设置用户的角色
     */
    int setRoles(@Param("userId") String userId, @Param("roleIds") String roleIds);

}
