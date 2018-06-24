package com.mumu.modular.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.mumu.modular.system.model.Role;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  角色表 Mapper
 *
 * @author 88396254
 * @date 2018年6月14日 下午12:26:43
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public interface RoleMapper extends BaseMapper<Role> {

    /**
     * 根据条件查询角色列表
     *
     * @return
     * @date 2017年2月12日 下午9:14:34
     */
    List<Map<String, Object>> selectRoles(@Param("condition") String condition);

    /**
     * 删除某个角色的所有权限
     *
     * @param roleId 角色id
     * @return
     * @date 2017年2月13日 下午7:57:51
     */
    int deleteRolesById(@Param("roleId") Integer roleId);
    
    /**
     * 根据角色名称获取角色信息
     */
    Role selectRoleByName(@Param("name") String name);

}