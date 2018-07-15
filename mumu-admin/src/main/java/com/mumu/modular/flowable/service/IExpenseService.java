package com.mumu.modular.flowable.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.flowable.condition.RollBackCondition;
import com.mumu.modular.flowable.model.Expense;
import com.mumu.modular.flowable.model.ExpenseVo;

/**
 * <p>
 * 报销表 服务类
 * </p>
 *
 * @author stylefeng
 * @since 2017-12-04
 */
public interface IExpenseService extends IService<Expense> {

    /**
     * 新增一个报销单
     */
    void add(Expense expense);

    /**
     * 删除一个报销单
     */
    void delete(List<String> expenseIds);
    
    /**
     * 启动报销流程
     */
    void execute(String processId);

    /**
     * 通过审批
     */
    void pass(String taskId);

    /**
     * 通过审批
     */
    void unPass(String taskId);
    
    /**
     *任务回退
     */
    void taskRollback(RollBackCondition rollBackCondition);
    
    /**
     * 根据流程实例id获取报销单
     */
    Map<String, Object> getExpenseByProcessId(String processId);

    /**
     * 获取审批列表
     */
    List<ExpenseVo> getProcessList();

    /**
     * 绘画当前流程图
     */
    void printProcessImage(String id) throws IOException;

}
