package com.mumu.modular.flowable.model;

import java.util.Date;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  报销流程节点
 *
 * @author 88396254
 * @date 2018年7月5日 下午2:16:21
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class FlowableNode {
    
    private String id;// 主键id
    private String procDefId;// 流程定义id 
    private String position;// 节点位置
    private String canBackTo;// 后续节点是否可以回退到该节点
    private String canRollBack; // 当前节点是否可以做回退操作 1：可以 0：不可以
    private String nodeCode;// 节点编码
    private String nodeName;// 节点名称
    private String orderNum;// 节点排序
    private Date createime;// 创建时间
    private String nodeDesc;// 备注
    public String getId() {
        return id;
    }
    public String getProcDefId() {
        return procDefId;
    }
    public void setProcDefId(String procDefId) {
        this.procDefId = procDefId;
    }
    public String getNodeName() {
        return nodeName;
    }
    public String getNodeDesc() {
        return nodeDesc;
    }
    public void setId(String id) {
        this.id = id;
    }
    public void setNodeName(String nodeName) {
        this.nodeName = nodeName;
    }
    public void setNodeDesc(String nodeDesc) {
        this.nodeDesc = nodeDesc;
    }
    public Date getCreateime() {
        return createime;
    }
    public void setCreateime(Date createime) {
        this.createime = createime;
    }
    public String getNodeCode() {
        return nodeCode;
    }
    public String getOrderNum() {
        return orderNum;
    }
    public void setNodeCode(String nodeCode) {
        this.nodeCode = nodeCode;
    }
    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }
    public String getPosition() {
        return position;
    }
    public String getCanBackTo() {
        return canBackTo;
    }
    public void setPosition(String position) {
        this.position = position;
    }
    public void setCanBackTo(String canBackTo) {
        this.canBackTo = canBackTo;
    }
    public String getCanRollBack() {
        return canRollBack;
    }
    public void setCanRollBack(String canRollBack) {
        this.canRollBack = canRollBack;
    }
}

