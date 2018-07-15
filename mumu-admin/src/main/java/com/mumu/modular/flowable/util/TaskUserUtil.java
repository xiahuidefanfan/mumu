package com.mumu.modular.flowable.util;

import java.util.List;
import java.util.Map;

import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.shiro.ShiroUser;
import com.mumu.core.util.SpringContextHolder;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.service.IRoleService;
import com.mumu.modular.system.service.IUserService;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 获取任务处理人帮助类
 *
 * @author 88396254
 * @date 2018年7月10日 下午5:07:43
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class TaskUserUtil {
    private static IRoleService roleService = SpringContextHolder.getBean(IRoleService.class);
    private static IUserService userService = SpringContextHolder.getBean(IUserService.class);
    
    /**
     * 获取上级审核人
     */
    public static String getLeaderAduitUser() {
        ShiroUser shiroUser = ShiroKit.getUser();
        String roleId = shiroUser.getRoleList().get(0);
        String pRoleId = roleService.selectById(roleId).getPid();
        List<Map<String, Object>> userMap = userService.getByRoleId(pRoleId);
        if(ToolUtil.isEmpty(userMap)) {
            throw new MumuException(BizExceptionEnum.TASK_HAS_NO_ASSIGNEE);
        }
        return String.valueOf(userMap.get(0).get("id")); 
    }
    
}
