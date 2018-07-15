package com.mumu.modular.flowable.service.impl;

import java.util.List;
import java.util.Map;

import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.HistoryService;
import org.flowable.engine.ManagementService;
import org.flowable.engine.ProcessEngine;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mumu.modular.flowable.command.RollbackCmd;
import com.mumu.modular.flowable.service.IWorkFlowService;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 工作流实现类
 *
 * @author 88396254
 * @date 2018年6月29日 下午2:53:16
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Service
public class WorkFlowServiceImpl implements IWorkFlowService{

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService;

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private ProcessEngine processEngine;
    
    @Autowired
    private HistoryService historyService;
    
    @Autowired
    private ManagementService managementService;
    
    @Override
    public ProcessInstance startProcessInstance(String processDefinitionKey, String businessKey, 
            Map<String, Object> variables) {
        return runtimeService.startProcessInstanceByKey(processDefinitionKey, businessKey, variables);
    }
    
    @Override
    public ProcessInstance queryProcessInstance(String processInstanceId){
        return runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
    }
    
    @Override
    public void deleteProcessInstance(String processInstanceId, String message) {
        
        runtimeService.deleteProcessInstance(processInstanceId, message);
    }
    
    @Override
    public Execution queryRunTimeExecutionById(String executionId){
        return runtimeService.createExecutionQuery().executionId(executionId).singleResult();
    }
    
    @Override
    public List<Execution> queryRunTimeExecutionByProcId(String processInstanceId){
        return runtimeService.createExecutionQuery().processInstanceId(processInstanceId).list();
    }
    
    @Override
    public List<HistoricTaskInstance> queryHistoryTask(String taskKey){
        return historyService.createHistoricTaskInstanceQuery().taskDefinitionKey(taskKey).desc().list();
    }
    
    
    @Override
    public Object getVariable(String executionId, String key) {
        return runtimeService.getVariable(executionId, key);
    }
    
    @Override
    public void setVariables(String executionId,  Map<String, Object> variables) {
        runtimeService.setVariables(executionId, variables);
    }
    
    
    @Override
    public List<Task> queryTaskByProcessInstanceId(String processInstanceId) {
       return taskService.createTaskQuery().processInstanceId(processInstanceId).list();
    }
    
    @Override
    public Task querySingleTaskByProcessInstanceId(String processInstanceId) {
       return taskService.createTaskQuery().processInstanceId(processInstanceId).singleResult();
    }
    
    @Override
    public List<Task> getTaskListByUserId(String userId){
        return taskService.createTaskQuery().taskAssignee(userId).list();
    }
    
    @Override
    public Task getTaskByTaskId(String taskId){
        return taskService.createTaskQuery().taskId(taskId).singleResult();
    }
    
    @Override
    public List<String> getActiveActivityIds(String executionId){
        return runtimeService.getActiveActivityIds(executionId);   
    }
    
    @Override
    public ProcessEngineConfiguration getProcessEngineConfiguration() {
        return processEngine.getProcessEngineConfiguration();
    }
    
    @Override
    public BpmnModel getBpmnModel(String processInstanceId) {
       return repositoryService.getBpmnModel(processInstanceId);
    }
    
    @Override
    public void complete(String taskId, Map<String, Object> variables) {
        taskService.complete(taskId, variables);
    }
    
    @Override
    public void complete(String taskId, Map<String, Object> variables, boolean localScope) {
        taskService.complete(taskId, variables, localScope);
    }
    
    @Override
    public void taskRollback(String taskId, String targeKey){
        managementService.executeCommand(new RollbackCmd(taskId, targeKey));
    }
    
}
