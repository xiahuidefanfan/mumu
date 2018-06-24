package com.mumu.modular.system.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.system.condition.LogSearchCondition;
import com.mumu.modular.system.model.OperationLog;

/**
 * <p>
 * 操作日志 服务类
 * </p>
 *
 * @author stylefeng123
 * @since 2018-02-22
 */
public interface IOperationLogService extends IService<OperationLog> {

    /**
     * 获取操作日志列表
     */
    List<Map<String, Object>> getOperationLogs(Page<OperationLog> page, LogSearchCondition condition);
}
