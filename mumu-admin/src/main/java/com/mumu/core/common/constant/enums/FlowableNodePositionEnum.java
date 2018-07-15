package com.mumu.core.common.constant.enums;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 工作流节点位置枚举
 *
 * @author 88396254
 * @date 2018年7月6日 上午10:09:38
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public enum FlowableNodePositionEnum {
    
    SERIAL(1,"串行节点"),PARALLEL(2,"并行节点"),GATEWAY_BRANCH(3,"网关分支");
    
    private Integer position;
    private String message;
    
    private FlowableNodePositionEnum(Integer position, String message) {
        this.position = position;
        this.message = message;
    }

    public Integer getPosition() {
        return position;
    }

    public String getMessage() {
        return message;
    }
    
    public static String valueOf(Integer position) {
        for (FlowableNodePositionEnum elem : FlowableNodePositionEnum.values()) {
            if (elem.getPosition() == position) {
                return elem.getMessage();
            }
        }
        return "";
    }
}
