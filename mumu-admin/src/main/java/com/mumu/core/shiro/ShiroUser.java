package com.mumu.core.shiro;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  用户的登录名外还可以携带更多信息
 *
 * @author 88396254
 * @date 2018年6月27日 上午11:17:36
 */
public class ShiroUser implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;          // 主键ID
    private String account;      // 账号
    private String name;         // 姓名
    private String deptId;      // 部门id
    private List<String> roleList; // 角色集
    private String deptName;        // 部门名称
    private List<String> roleNames; // 角色名称集


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDeptId() {
        return deptId;
    }

    public void setDeptId(String deptId) {
        this.deptId = deptId;
    }

    public List<String> getRoleList() {
        return roleList;
    }

    public void setRoleList(List<String> roleList) {
        this.roleList = roleList;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public List<String> getRoleNames() {
        return roleNames;
    }

    public void setRoleNames(List<String> roleNames) {
        this.roleNames = roleNames;
    }

}
