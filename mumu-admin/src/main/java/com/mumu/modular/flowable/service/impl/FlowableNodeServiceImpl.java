package com.mumu.modular.flowable.service.impl;

import java.util.List;
import java.util.Map;

import org.flowable.task.api.Task;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.flowable.dao.FlowableNodeMapper;
import com.mumu.modular.flowable.model.FlowableNode;
import com.mumu.modular.flowable.service.IFlowableNodeService;

@Service
@Transactional
public class FlowableNodeServiceImpl extends ServiceImpl<FlowableNodeMapper, FlowableNode> implements IFlowableNodeService{
    
    private static final Logger LOGGER = LoggerFactory.getLogger(FlowableNodeServiceImpl.class);
    
    @Autowired
    private WorkFlowServiceImpl workFlowService;
    
    @Override
    public List<Map<String, Object>> selectFlowableNodes(Page<FlowableNode> page, String name){
        return this.baseMapper.selectFlowableNodes(page, name);
    }

    @Override
    public List<Map<String, Object>> getCanRollBackTaskIds(String taskId) {
        // 1.先检查任务是否存在
        Task task = workFlowService.getTaskByTaskId(taskId);
        if(ToolUtil.isEmpty(task)) {
            LOGGER.info(task.getId()  + ":任务不存在！");
            throw new MumuException(BizExceptionEnum.TASK_IS_NOT_EXISTED);
        }
        String procDefId = task.getProcessDefinitionId();
        String nodeCode = task.getTaskDefinitionKey();
        return this.baseMapper.getCanRollBackTaskIds(nodeCode,procDefId);
    }
    
    @Override
    public Map<String, Object> getFlowableNode(String procDefId, String nodeCode){
        return this.baseMapper.getFlowableNode(procDefId,nodeCode);
    }
}
