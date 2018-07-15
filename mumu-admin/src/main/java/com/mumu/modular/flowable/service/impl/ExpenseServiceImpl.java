package com.mumu.modular.flowable.service.impl;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.flowable.bpmn.model.BpmnModel;
import org.flowable.engine.ProcessEngineConfiguration;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.image.ProcessDiagramGenerator;
import org.flowable.task.api.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.core.common.constant.CommConst;
import com.mumu.core.common.constant.enums.ExpenseStateEnum;
import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.common.constant.state.FlowableState;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.shiro.ShiroUser;
import com.mumu.core.support.HttpKit;
import com.mumu.core.util.DateUtil;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.flowable.condition.RollBackCondition;
import com.mumu.modular.flowable.dao.ExpenseMapper;
import com.mumu.modular.flowable.model.Expense;
import com.mumu.modular.flowable.model.ExpenseVo;
import com.mumu.modular.flowable.service.IExpenseService;
import com.mumu.modular.flowable.service.IFlowableNodeService;
import com.mumu.modular.flowable.util.MumuDefaultProcessDiagramGenerator;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  报销表 服务实现类
 *
 * @author 88396254
 * @date 2018年7月2日 下午3:06:09
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Service
public class ExpenseServiceImpl extends ServiceImpl<ExpenseMapper, Expense> implements IExpenseService {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(ExpenseServiceImpl.class);
    
    @Autowired
    private ExpenseMapper expenseMapper;

    @Autowired
    private WorkFlowServiceImpl workFlowService;

    
    @Autowired
    private IFlowableNodeService flowableNodeService;
    
    /**
     * 节点是否可以做驳回操作 1：可以
     */
    private static final String CAN_ROLL_BACK = "1";
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void add(Expense expense) {
        LOGGER.info("添加" + expense.getExpenseDesc() + "报销流程开始！");
        
        //启动流程
        HashMap<String, Object> map = new HashMap<>(CommConst.DEFAULT_MAP_SIZE);
        map.put("taskUser", ShiroKit.getUser().getId());
        map.put("money", expense.getMoney());
        ProcessInstance processInstance = workFlowService.startProcessInstance("Expense",null, map);
        
        //保存业务数据
        expense.setUserId(ShiroKit.getUser().getId());
        expense.setState(FlowableState.SUBMITING.getCode());
        expense.setProcessId(processInstance.getId());
        this.insert(expense);
        LOGGER.info("添加报销流程成功！流程实例id：" + expense.getProcessId());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(List<String> expenseIds) {
        for(String expenseId : expenseIds) {
            Expense expense = this.selectById(expenseId);
            ProcessInstance processId = workFlowService.queryProcessInstance(expense.getProcessId());
            if(ToolUtil.isNotEmpty(processId)) {
                workFlowService.deleteProcessInstance(processId.getProcessInstanceId(), "取消报销");
            }
            this.deleteById(expenseId);
            LOGGER.info("删除报销单" + expense.getId() + "成功！");
        }
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void execute(String processId) {
        
        LOGGER.info(processId + ":启动开始！");
        // 检查任务是否还存在
        Task task = workFlowService.querySingleTaskByProcessInstanceId(processId);
        if(ToolUtil.isEmpty(task)) {
            LOGGER.info(processId  + ":流程实例的任务不存在！");
            throw new MumuException(BizExceptionEnum.TASK_IS_NOT_EXISTED);
        }
        
        // 判断当前任务处理人是否正确
        ShiroUser user= ShiroKit.getUser();
        String userId = user.getId();
        if(!task.getAssignee().equals(userId)) {
            LOGGER.info(task.getId() + ":任务处理人是" + task.getAssignee());
            throw new MumuException(BizExceptionEnum.NO_PERMITION);
        }
        
        // 工作流驱动
        Map<String, Object> variables = new HashMap<String, Object>(CommConst.DEFAULT_MAP_SIZE);
        variables.put("check", "pass");
        workFlowService.complete(task.getId(), variables);
        
        // 将新生成的任务信息回写到报销单信息中
        Task newTask = workFlowService.querySingleTaskByProcessInstanceId(processId);
        Wrapper<Expense> wrapper = new EntityWrapper<Expense>().eq("processId", processId);
        Expense expense = this.selectOne(wrapper);
        expense.setState(ExpenseStateEnum.getStateByTaskName(newTask.getTaskDefinitionKey()));
        expense.updateById();
        
        LOGGER.info(processId + ":启动成功！");
    }
    
    @Override
    public List<ExpenseVo> getProcessList() {
        // 获取处理人是当前登录的任务集合
        String userId = ShiroKit.getUser().getId();
        List<Task> list = workFlowService.getTaskListByUserId(userId);
        
        // 封装任务信息为页面展示的效果
        ArrayList<ExpenseVo> expenseVos = new ArrayList<>();
        for (Task task : list) {
            ExpenseVo vo = new ExpenseVo();
            Object money = workFlowService.getVariable(task.getExecutionId(), "money");
            String applyUserId = (String) workFlowService.getVariable(task.getExecutionId(), "taskUser");
            vo.setId(task.getId());
            vo.setName(task.getName());
            vo.setCreateTimeFormat(DateUtil.formatDate(task.getCreateTime(),DateUtil.SECOND_FORMAT));
            vo.setMoney(money);
            vo.setAssigneeName( ConstantFactory.me().getUserNameById(applyUserId));
            vo.setSelfFlag(applyUserId.equals(userId));
            Wrapper<Expense> wrapper  = new EntityWrapper<Expense>().eq("processId", task.getProcessInstanceId());
            Expense expense = this.selectOne(wrapper);
            if(ToolUtil.isNotEmpty(expense)) {
                vo.setExpenseDesc(expense.getExpenseDesc());
                vo.setCanSubmit(canSubmit(expense));
            }
            // 获取当前节点是否可以做驳回操作
            Map<String,Object> flowableNodeInofo = flowableNodeService.getFlowableNode(task.getProcessDefinitionId(), 
                    task.getTaskDefinitionKey());
            if(ToolUtil.isNotEmpty(flowableNodeInofo)) {
                vo.setCanRollBack(flowableNodeInofo.get("canRollBack").equals(CAN_ROLL_BACK));
            }
            expenseVos.add(vo);
        }
        return expenseVos;
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pass(String taskId) {
        Map<String, Object> variables = new HashMap<String, Object>(CommConst.DEFAULT_MAP_SIZE);
        variables.put("check", "pass");
        doAduit(taskId,variables,null);
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void unPass(String taskId) {
        Map<String, Object> variables = new HashMap<String, Object>(CommConst.DEFAULT_MAP_SIZE);
        variables.put("check", "unpass");
        doAduit(taskId,variables, ExpenseStateEnum.IS_REJECT.getState());
    }
    
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void taskRollback(RollBackCondition rollBackCondition){
        String taskId = rollBackCondition.getTaskId();
        String targetKey = rollBackCondition.getTargetKey();
        LOGGER.info("任务：" + taskId + "回退到" + targetKey + "任务开始!");
        
        // 1.检查任务是否还存在
        Task task = workFlowService.getTaskByTaskId(taskId);
        if(ToolUtil.isEmpty(task)) {
            LOGGER.info(rollBackCondition.getTaskId() + ":任务不存在！");
            throw new MumuException(BizExceptionEnum.TASK_IS_NOT_EXISTED);
        }
        
        // 2.判断当前任务处理人是否正确
        String userId = ShiroKit.getUser().getId();
        if(!userId.equals(task.getAssignee())) {
            LOGGER.info(task.getId() + ":任务处理人是" + task.getAssignee());
            throw new MumuException(BizExceptionEnum.NO_PERMITION);
        }
        
        // 3.工作流驱动回退
        workFlowService.taskRollback(taskId,targetKey);
        
        // 4.修改单据信息
        String processId = task.getProcessInstanceId();
        Wrapper<Expense> wrapper  = new EntityWrapper<Expense>().eq("processId", processId);
        Expense expense = this.selectOne(wrapper);
        expense.setState(ExpenseStateEnum.getStateByTaskName(targetKey));
        expense.updateById();
        
        LOGGER.info("任务：" + rollBackCondition.getTaskId() + "回退成功！");
    }
    
    @Override
    public Map<String, Object> getExpenseByProcessId(String processId){
        return expenseMapper.getExpenseByProcessId(processId);
    }
        
    
    /**
     * 审核实现方法
     * 1.工作流完成任务
     * 2.设置业务信息
     *  2.1如果业务信息出错，工作流回退
     */
    private void doAduit(String taskId, Map<String, Object> variables, Integer state) {
        // 1.检查任务是否还存在
        Task task = workFlowService.getTaskByTaskId(taskId);
        if(ToolUtil.isEmpty(task)) {
            LOGGER.info(task.getId()  + ":任务不存在！");
            throw new MumuException(BizExceptionEnum.TASK_IS_NOT_EXISTED);
        }
        
        // 2.判断当前任务处理人是否正确
        String userId = ShiroKit.getUser().getId();
        if(!userId.equals(task.getAssignee())) {
            LOGGER.info(task.getId() + ":任务处理人是" + task.getAssignee());
            throw new MumuException(BizExceptionEnum.NO_PERMITION);
        }
        
        // 3.工作流驱动流程
        workFlowService.complete(task.getId(), variables); 
        
        // 4.修改单据信息
        Wrapper<Expense> wrapper  = new EntityWrapper<Expense>().eq("processId", task.getProcessInstanceId());
        Expense expense = this.selectOne(wrapper);
        if(ToolUtil.isNotEmpty(state)) {
            expense.setState(state);
        }else if(ToolUtil.isEmpty(workFlowService.queryProcessInstance(task.getProcessInstanceId()))) {
             // 判断流程是否结束,结束之后修改状态
             // 如果运行时流程实例不存在，则审批完成
            expense.setState(ExpenseStateEnum.IS_PASS.getState());
        }else {
            // 串行任务只会有一条任务
            Task nowTask = workFlowService.querySingleTaskByProcessInstanceId(task.getProcessInstanceId());
            expense.setState(ExpenseStateEnum.getStateByTaskName(nowTask.getTaskDefinitionKey()));
        }
        expense.updateById();
        
        LOGGER.info(task.getId() + ":任务审核成功！");
    }
    
    /**
     * 根据task得到当前流程状态是否是待提交
     */
    private boolean canSubmit(Expense expense) {
        if(ToolUtil.isNotEmpty(expense) && expense.getState() == ExpenseStateEnum.
                IS_SUBMIT.getState()){
            return true;
        }
        return false;
    }
    
    @Override
    public void printProcessImage(String id) throws IOException {
        String processId;
        Expense expense = this.selectById(id);
        if(ToolUtil.isEmpty(expense)) {
            processId = workFlowService.getTaskByTaskId(id).getProcessInstanceId();
        }else {
            processId = expense.getProcessId();
        }
        ProcessInstance pi = workFlowService.queryProcessInstance(processId);

        //流程走完的不显示图
        if (pi == null) {
            return;
        }

        List<Execution> executions = workFlowService.queryRunTimeExecutionByProcId(processId);

        //得到正在执行的Activity的Id
        List<String> activityIds = new ArrayList<>();
        List<String> flows = new ArrayList<>();
        for (Execution exe : executions) {
            List<String> ids = workFlowService.getActiveActivityIds(exe.getId());
            activityIds.addAll(ids);
        }

        //获取流程图
        BpmnModel bpmnModel = workFlowService.getBpmnModel(pi.getProcessDefinitionId());
        ProcessEngineConfiguration engconf = workFlowService.getProcessEngineConfiguration();
        ProcessDiagramGenerator diagramGenerator = new MumuDefaultProcessDiagramGenerator();
        InputStream in = diagramGenerator.generateDiagram(bpmnModel, "png", activityIds, flows, "宋体", "宋体", engconf.getAnnotationFontName(), engconf.getClassLoader(), 1.0);
        OutputStream out = null;
        byte[] buf = new byte[1024];
        int legth = 0;
        try {
            out = HttpKit.getResponse().getOutputStream();
            while ((legth = in.read(buf)) != -1) {
                out.write(buf, 0, legth);
            }
        } finally {
            if (in != null) {
                in.close();
            }
            if (out != null) {
                out.close();
            }
        }
    }

}

