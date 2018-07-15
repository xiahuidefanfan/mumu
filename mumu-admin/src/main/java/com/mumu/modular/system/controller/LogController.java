package com.mumu.modular.system.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.SqlRunner;
import com.baomidou.mybatisplus.plugins.Page;
import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.factory.PageFactory;
import com.mumu.core.common.constant.state.BizLogType;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.condition.LogSearchCondition;
import com.mumu.modular.system.model.OperationLog;
import com.mumu.modular.system.service.IOperationLogService;
import com.mumu.modular.system.warpper.LogWarpper;

/**
 * 日志管理的控制器
 *
 * @author fengshuonan
 * @Date 2017年4月5日 19:45:36
 */
@Controller
@RequestMapping("/log")
public class LogController extends BaseController {

    @Autowired
    private IOperationLogService operationLogService;

    /**
     * 查询操作日志列表
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/list")
    @ResponseBody
    @Permission
    public RespData list(LogSearchCondition condition) {
        Page<OperationLog> page = new PageFactory<OperationLog>().defaultPage();
        condition.setLogType(BizLogType.valueOf(Integer.parseInt(condition.getLogType())));
        List<Map<String, Object>> result = operationLogService.getOperationLogs(page, condition);
        page.setRecords((List<OperationLog>) new LogWarpper(result).warp());
        return RespData.getRespData(HttpStatus.OK.value(), page.getRecords(), "", page.getTotal());
    }

    /**
     * 删除日志，支持批量删除
     */
    @RequestMapping("/delete")
    @ResponseBody
    @Permission
    public RespData delete(@RequestBody List<String> ids) {
        if (ToolUtil.isEmpty(ids)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        operationLogService.deleteBatchIds(ids);
        return RespData.getRespData(HttpStatus.OK.value(), null, "删除日志成功！");
    }

    /**
     * 清空日志
     */
    @BussinessLog(value = "清空日志")
    @RequestMapping("/deleteAll")
    @ResponseBody
    @Permission
    public RespData deleteAll() {
        SqlRunner.db().delete("delete from sys_operation_log");
        return RespData.getRespData(HttpStatus.OK.value(), null, "删除日志成功！");
    }
}
