package com.mumu.modular.flowable.command;

import java.util.ArrayList;
import java.util.List;

import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.FlowableEngineAgenda;
import org.flowable.engine.common.impl.interceptor.Command;
import org.flowable.engine.common.impl.interceptor.CommandContext;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.util.ProcessDefinitionUtil;
import org.flowable.task.service.impl.persistence.entity.HistoricTaskInstanceEntity;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.util.ToolUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 流程回退实现
 *
 * @author 88396254
 * @date 2018年7月3日 下午3:56:15
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class RollbackCmd implements Command<ExecutionEntity>{
    private static final Logger LOGGER = LoggerFactory.getLogger(RollbackCmd.class);
    /**
     *  当前任务id
     */
    private String taskId; 
    
    /**
     *  目标节点key
     */
    private String targeKey; 
    
    public RollbackCmd(String taskId, String targeKey) {
        this.taskId = taskId;
        this.targeKey = targeKey;
    }

    @Override
    public ExecutionEntity execute(CommandContext commandContext) {
        TaskEntity currentTaskEntity = org.flowable.task.service.impl.util.CommandContextUtil.getTaskEntityManager().
                findById(taskId); 
        ExecutionEntity executionEntity = org.flowable.engine.impl.util.CommandContextUtil.getExecutionEntityManager().
                findById(currentTaskEntity.getExecutionId());
        Process process = ProcessDefinitionUtil.getProcess(executionEntity.getProcessDefinitionId());
        FlowElement targetFlowElement = process.getFlowElement(targeKey);
        UserTask targetTask = (UserTask)targetFlowElement;
        // 获取任务处理人
        String assigner = getHisAssign(executionEntity.getProcessInstanceId());
        if(ToolUtil.isEmpty(assigner)) {
            LOGGER.info("任务id：" + taskId + "回退到" + targeKey + "节点是未找到任务处理人！");
            throw new MumuException(BizExceptionEnum.TASK_HAS_NO_ASSIGNEE);
        }
        targetTask.setAssignee(assigner);
        executionEntity.setCurrentFlowElement(targetFlowElement);
        FlowableEngineAgenda agenda = org.flowable.engine.impl.util.CommandContextUtil.getAgenda();
        agenda.planContinueProcessInCompensation(executionEntity);
        
        // 不能删除当前正在执行的任务，所以要先清除掉关联
        currentTaskEntity.setExecutionId(null);
        // 删除当前任务
        org.flowable.task.service.impl.util.CommandContextUtil.getTaskEntityManager().delete(currentTaskEntity);
        return executionEntity;
    }
    
    /**
     * 获取历史任务中目标节点处理人
     */
    private String getHisAssign(String processId) {
        List<HistoricTaskInstanceEntity> hisEntitys = org.flowable.task.service.impl.util.CommandContextUtil.
                getHistoricTaskInstanceEntityManager().findHistoricTasksByProcessInstanceId(processId);
        List<HistoricTaskInstanceEntity> hisTargetKeyEntitys = new ArrayList<HistoricTaskInstanceEntity>();
        for(HistoricTaskInstanceEntity hisEntity : hisEntitys) {
            if(hisEntity.getTaskDefinitionKey().equals(targeKey)) {
                hisTargetKeyEntitys.add(hisEntity);
            }
        }
        HistoricTaskInstanceEntity targetEntity = null;
        for(HistoricTaskInstanceEntity hisTargetKeyEntity : hisTargetKeyEntitys) {
            if(ToolUtil.isEmpty(hisTargetKeyEntity.getEndTime())){
                continue;  
            }
            if(ToolUtil.isEmpty(targetEntity)) {
                targetEntity = hisTargetKeyEntity;
            }
            if(hisTargetKeyEntity.getEndTime().getTime() > targetEntity.getEndTime().getTime()) {
                targetEntity = hisTargetKeyEntity;
            }
        }
  
        String assigner = targetEntity.getAssignee();
        LOGGER.info("流程实例：" + processId + "找到的任务处理人是：" + assigner);
        return  assigner;
    }
}
