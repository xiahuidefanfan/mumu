package com.mumu.modular.flowable.handler;

import java.util.List;
import java.util.Map;

import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.service.delegate.DelegateTask;

import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.util.SpringContextHolder;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.service.IRoleService;
import com.mumu.modular.system.service.IUserService;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  流程发起后，都先有其直接领导审批
 *
 * @author 88396254
 * @date 2018年7月2日 下午2:33:13
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class LeaderTaskHandler implements TaskListener{
    
    private static final long serialVersionUID = 1L;
    private IRoleService roleService = SpringContextHolder.getBean(IRoleService.class);
    private IUserService userService = SpringContextHolder.getBean(IUserService.class);
    
    /**
     * 1.根据当前用户的角色获取其上级角色，
     * 2.根据上级角色获取到上级员工,普通员工只会有一个父级角色  
     * 3.如未取到，则返回流程无处理人异常，流程驱动失败
     */
    @Override
    public void notify(DelegateTask delegateTask) {
        if(ToolUtil.isEmpty(delegateTask.getAssignee())){
            // 1.通过当前登录者角色获取到其上级领导用户
            String roleId =  ShiroKit.getUser().getRoleList().get(0);
            String pRoleId = roleService.selectById(roleId).getPid();
            List<Map<String, Object>> userMap = userService.getByRoleId(pRoleId);
            if(ToolUtil.isEmpty(userMap)) {
                throw new MumuException(BizExceptionEnum.TASK_HAS_NO_ASSIGNEE);
            }
            
            // 2.设置任务处理人
            delegateTask.setAssignee(String.valueOf(userMap.get(0).get("id")));
        }
    }
    
}
