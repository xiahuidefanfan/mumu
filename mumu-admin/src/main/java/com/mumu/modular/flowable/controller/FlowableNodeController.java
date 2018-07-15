package com.mumu.modular.flowable.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.plugins.Page;
import com.mumu.core.common.constant.factory.PageFactory;
import com.mumu.core.support.RespData;
import com.mumu.modular.flowable.model.FlowableNode;
import com.mumu.modular.flowable.service.IFlowableNodeService;
import com.mumu.modular.flowable.warpper.FlowableNodeWarpper;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 流程节点配置控制器
 *
 * @author 88396254
 * @date 2018年7月5日 下午5:43:36
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping(value="/flowableNode")
public class FlowableNodeController {
    
    @Autowired
    private IFlowableNodeService flowableNodeService;
    
    /**
     * 获取节点信息列表
     */
    @SuppressWarnings("unchecked")
    @RequestMapping(value="list", method = RequestMethod.POST)
    @ResponseBody
    public RespData list(@RequestParam(required = false) String name) {
        Page<FlowableNode> page = new PageFactory<FlowableNode>().defaultPage();
        List<Map<String, Object>> result = flowableNodeService.selectFlowableNodes(page, name);
        page.setRecords((List<FlowableNode>) new FlowableNodeWarpper(result).warp());
        return RespData.getRespData(HttpStatus.OK.value(), page.getRecords(), "", page.getTotal());
    }
    
    /**
     * 获取可回退的节点
     */
    @RequestMapping(value="targetIds", method = RequestMethod.POST)
    @ResponseBody
    public RespData targetIds(@RequestBody String taskId) {
        return RespData.getRespData(HttpStatus.OK.value(), flowableNodeService.getCanRollBackTaskIds(taskId), "");
    }
    
}   
