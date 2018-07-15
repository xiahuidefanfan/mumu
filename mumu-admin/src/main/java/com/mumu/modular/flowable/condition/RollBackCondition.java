package com.mumu.modular.flowable.condition;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 回退请求入参封装
 *
 * @author 88396254
 * @date 2018年7月4日 下午5:19:13
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class RollBackCondition {
    /**
     * 当前任务id
     */
    private String taskId; 
    
    /**
     *  回退到的节点key
     */
    private String targetKey; 
    
    public String getTaskId() {
        return taskId;
    }
    public String getTargetKey() {
        return targetKey;
    }
    public void setTaskId(String taskId) {
        this.taskId = taskId;
    }
    public void setTargetKey(String targetKey) {
        this.targetKey = targetKey;
    }
}
