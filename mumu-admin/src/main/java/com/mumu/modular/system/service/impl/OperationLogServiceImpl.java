package com.mumu.modular.system.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.modular.system.condition.LogSearchCondition;
import com.mumu.modular.system.dao.OperationLogMapper;
import com.mumu.modular.system.model.OperationLog;
import com.mumu.modular.system.service.IOperationLogService;

/**
 * <p>
 * 操作日志 服务实现类
 * </p>
 *
 * @author stylefeng123
 * @since 2018-02-22
 */
@Service
public class OperationLogServiceImpl extends ServiceImpl<OperationLogMapper, OperationLog> implements IOperationLogService {

    @Override
    public List<Map<String, Object>> getOperationLogs(Page<OperationLog> page,LogSearchCondition condition) {
        return this.baseMapper.getOperationLogs(page, condition);
    }
}
