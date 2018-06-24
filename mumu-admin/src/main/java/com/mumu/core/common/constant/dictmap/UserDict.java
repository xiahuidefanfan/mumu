package com.mumu.core.common.constant.dictmap;

import com.mumu.core.common.constant.dictmap.base.AbstractDictMap;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  用户的字典
 *
 * @author 88396254
 * @date 2018年6月13日 下午12:08:57
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class UserDict extends AbstractDictMap {

    @Override
    public void init() {
        put("userId","账号");
        put("avatar","头像");
        put("account","账号");
        put("name","名字");
        put("birthday","生日");
        put("sex","性别");
        put("email","电子邮件");
        put("phone","电话");
        put("roleid","角色名称");
        put("deptid","部门名称");
        put("roleIds","角色名称集合");
    }

    @Override
    protected void initBeWrapped() {
        putFieldWrapperMethodName("sex","getSexName");
        putFieldWrapperMethodName("deptid","getDeptName");
        putFieldWrapperMethodName("roleid","getRoleName");
        putFieldWrapperMethodName("userId","getUserAccountById");
    }
}
