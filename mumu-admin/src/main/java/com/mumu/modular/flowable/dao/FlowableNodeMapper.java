package com.mumu.modular.flowable.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.mumu.modular.flowable.model.FlowableNode;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 流程节点信息
 *
 * @author 88396254
 * @date 2018年7月5日 下午6:01:16
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public interface FlowableNodeMapper extends BaseMapper<FlowableNode>{
    
    /**
     * 
     * 获取节点信息
     *
     * @param page
     * @param name 
     * @return
     */
    List<Map<String, Object>> selectFlowableNodes(@Param("page")Page<FlowableNode> page, @Param("name")String name);
    
    
    /**
     * 
     * 根据任务id获取可回退到的节点信息
     *
     * @param nodeCode
     * @param procDefId
     * @return
     */
    List<Map<String, Object>> getCanRollBackTaskIds(@Param("nodeCode")String nodeCode, @Param("procDefId")String procDefId);
    
    /**
     * 
     * 根据流程定义和节点key获取节点信息
     *
     * @param procDefId
     * @param nodeCode
     * @return
     */
    Map<String, Object> getFlowableNode(@Param("procDefId")String procDefId, @Param("nodeCode")String nodeCode);
}
