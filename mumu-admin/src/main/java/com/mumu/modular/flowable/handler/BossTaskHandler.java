package com.mumu.modular.flowable.handler;

import java.util.List;
import java.util.Map;

import org.flowable.engine.delegate.TaskListener;
import org.flowable.task.service.delegate.DelegateTask;

import com.mumu.core.common.constant.enums.RoleTipsEnum;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.util.SpringContextHolder;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.model.Role;
import com.mumu.modular.system.service.IRoleService;
import com.mumu.modular.system.service.IUserService;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 生成给老板处理的任务时，执行该Listener
 *
 * @author 88396254
 * @date 2018年7月12日 上午10:03:13
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class BossTaskHandler implements TaskListener {

    private static final long serialVersionUID = 1L;
    private IRoleService roleService = SpringContextHolder.getBean(IRoleService.class);
    private IUserService userService = SpringContextHolder.getBean(IUserService.class);

    @Override
    public void notify(DelegateTask delegateTask) {
        if(ToolUtil.isEmpty(delegateTask.getAssignee())){
            String roleTip = RoleTipsEnum.BOSS.getCode();
            Role role = roleService.selectRoleByTip(roleTip);
            
            // 1.老板角色不存在，任务将无处理人
            if(ToolUtil.isEmpty(role)) {
                throw new MumuException(BizExceptionEnum.TASK_HAS_NO_ASSIGNEE);
            }
            // 2.获取老板角色的用户
            String roleId = role.getId();
            List<Map<String, Object>> userMap = userService.getByRoleId(roleId);
            
            // 3.老板角色的用户工不存在，任务将无处理人
            if(ToolUtil.isEmpty(userMap)) {
                throw new MumuException(BizExceptionEnum.TASK_HAS_NO_ASSIGNEE);
            }
            
            // 4.设置任务处理人
            delegateTask.setAssignee(String.valueOf(userMap.get(0).get("id")));
        }
    }

}
