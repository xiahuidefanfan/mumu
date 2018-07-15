package com.mumu.modular.flowable.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.enums.ExpenseStateEnum;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.flowable.condition.RollBackCondition;
import com.mumu.modular.flowable.model.Expense;
import com.mumu.modular.flowable.model.ExpenseVo;
import com.mumu.modular.flowable.service.IExpenseService;
import com.mumu.modular.flowable.warpper.ExpenseWarpper;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  报销管理控制器
 *
 * @author 88396254
 * @date 2018年7月2日 上午11:32:59
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
 
@Controller
@RequestMapping("/expense")
public class ExpenseController extends BaseController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(ExpenseController.class);

    @Autowired
    private IExpenseService expenseService;

    /**
     * 获取报销管理列表
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    @Permission
    public RespData list(String condition) {
        EntityWrapper<Expense> expenseEntityWrapper = new EntityWrapper<>();
        expenseEntityWrapper.eq("userId", ShiroKit.getUser().getId());
        List<Map<String, Object>> stringObjectMap = expenseService.selectMaps(expenseEntityWrapper);
        return RespData.getRespData(HttpStatus.OK.value(), super.warpObject(new ExpenseWarpper(stringObjectMap)), "");
    }

    /**
     * 新增报销流程
     */
    @RequestMapping(value = "/add")
    @ResponseBody
    public RespData add(@RequestBody Expense expense) {
        if (ToolUtil.isEmpty(expense)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        expenseService.add(expense);
        return RespData.getRespData(HttpStatus.OK.value(), "", "添加报销申请成功！");
    }

    /**
     * 删除报销信息
     */
    @RequestMapping(value = "/delete")
    @ResponseBody
    public RespData delete(@RequestBody List<String> expenseIds) {
        if (ToolUtil.isEmpty(expenseIds)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        expenseService.delete(expenseIds);
        return RespData.getRespData(HttpStatus.OK.value(), "", "删除报销申请成功！");
    }
    
    /**
     * 修改报销信息
     */
    @RequestMapping(value = "/update")
    @ResponseBody
    public RespData update(@RequestBody Expense expense) {
        Expense oldExpense = expense.selectById(); 
        if(oldExpense.getState() != ExpenseStateEnum.IS_SUBMIT.getState()) {
            // 如果流程已经启动，将不能被修改
            throw new MumuException(BizExceptionEnum.TASK_CAN_NOT_UPDATE);
        }
        expenseService.updateById(expense);
        return RespData.getRespData(HttpStatus.OK.value(), "", "报销申请修改成功！");
    }
    
    /**
     * 提交报销流程
     */
    @RequestMapping(value = "/execute")
    @ResponseBody
    public RespData execute(@RequestBody String processId) {
        if (ToolUtil.isEmpty(processId)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        expenseService.execute(processId);
        return RespData.getRespData(HttpStatus.OK.value(), "", "提交报销申请成功！");
    }
    
    /**
     * 获取审核列表：即处理人是当前登录者
     */
    @RequestMapping(value = "/taskList")
    @ResponseBody
    public RespData taskList() {
        return RespData.getRespData(HttpStatus.OK.value(),  expenseService.getProcessList(), "");
    }
    
    /**
     * 报销任务审核通过
     */
    @RequestMapping(value = "/pass")
    @ResponseBody
    public RespData pass(@RequestBody ExpenseVo expenseVo) {
        if (ToolUtil.isEmpty(expenseVo)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        expenseService.pass(expenseVo.getId());
        return RespData.getRespData(HttpStatus.OK.value(), "", "审核成功！");
    }
    
    /**
     * 报销任务审核通过：驳回
     */
    @RequestMapping(value = "/unPass")
    @ResponseBody
    public RespData unPass(@RequestBody ExpenseVo expenseVo) {
        if (ToolUtil.isEmpty(expenseVo)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        expenseService.unPass(expenseVo.getId());
        return RespData.getRespData(HttpStatus.OK.value(), "", "驳回成功！");
    }
    
    /**
     * 任务回退到指定节点
     */
    @RequestMapping(value = "/rollback")
    @ResponseBody
    public RespData rollback(@RequestBody RollBackCondition rollBackCondition) {
        if(ToolUtil.isEmpty(rollBackCondition)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        expenseService.taskRollback(rollBackCondition);
        return RespData.getRespData(HttpStatus.OK.value(), "", "回退成功！");
    }
    
    /**
     * 查看当前流程图
     */
    @RequestMapping(value = "/expenseView/{id}")
    public void expenseView(@PathVariable String id) {
        try {
            expenseService.printProcessImage(id);
        } catch (IOException e) {
            LOGGER.error("任务：" + id + "生成流程图异常！");
            e.printStackTrace();
        }
    }
}
