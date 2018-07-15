package com.mumu.modular.flowable.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.flowable.model.FlowableNode;

public interface IFlowableNodeService extends IService<FlowableNode>{

    /**
     * 获取节点信息
     */
    List<Map<String, Object>> selectFlowableNodes(Page<FlowableNode> page, String name);
    
    /**
     * 根据任务id获取可回退到的节点信息
     */
    List<Map<String, Object>> getCanRollBackTaskIds(String taskId);
    
    /**
     * 根据流程定义和节点key获取节点信息
     */
    Map<String, Object> getFlowableNode(String procDefId, String nodeCode);
}
