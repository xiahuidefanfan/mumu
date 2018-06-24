package com.mumu.modular.system.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.core.util.Convert;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.dao.RelationMapper;
import com.mumu.modular.system.dao.RoleMapper;
import com.mumu.modular.system.model.Relation;
import com.mumu.modular.system.model.Role;
import com.mumu.modular.system.service.IRoleService;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RelationMapper relationMapper;

    @Override
    @Transactional(readOnly = false)
    public void setAuthority(Integer roleId, String ids) {

        // 删除该角色所有的权限
        this.roleMapper.deleteRolesById(roleId);
        
        if(ToolUtil.isNotEmpty(ids)) {
            String[] idArr = Convert.toStrArray(",", ids);
            // 添加新的权限
            for (String id : idArr) {
                Relation relation = new Relation();
                relation.setRoleid(roleId);
                relation.setMenuid(Long.valueOf(id));
                this.relationMapper.insert(relation);
            }
        }
    }

    @Override
    @Transactional(readOnly = false)
    public void delRoleById(Integer roleId) {
        //删除角色
        this.roleMapper.deleteById(roleId);

        // 删除该角色所有的权限
        this.roleMapper.deleteRolesById(roleId);
    }

    @Override
    public List<Map<String, Object>> selectRoles(String condition) {
        return this.baseMapper.selectRoles(condition);
    }

    @Override
    public int deleteRolesById(Integer roleId) {
        return this.baseMapper.deleteRolesById(roleId);
    }

    
    /**
     * 根据角色名称获取角色信息
     */
    public Role selectRoleByName(String name) {
        return this.baseMapper.selectRoleByName(name);
    }

}
