package com.mumu.core.common.constant.enums;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 报销流程状态枚举
 *
 * @author 88396254
 * @date 2018年7月2日 下午12:14:41
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public enum ExpenseStateEnum {

    IS_SUBMIT(1,"task_apply","待提交"),LEADER_ADUIT(2,"leader_aduit","上级审批"),MANAGER_ADUIT(3,"financial_aduit","财务审批"),
    BOSS_ADUIT(4,"boss_aduit","老板审批"),IS_PASS(5,"","审核通过"),IS_REJECT(6,"","驳回");
    
    ExpenseStateEnum(int state, String taskCode, String message) {
        this.state = state;
        this.taskCode = taskCode;
        this.message = message;
    }
    
    private Integer state;
    
    private String taskCode;

    private String message;

    public Integer getState() {
        return state;
    }
    
    public String getTaskCode() {
        return taskCode;
    }

    public String getMessage() {
        return message;
    }
    
    public static String valueOf(Integer state) {
        for (ExpenseStateEnum elem : ExpenseStateEnum.values()) {
            if (elem.getState() == state) {
                return elem.getMessage();
            }
        }
        return "";
    }
    
    public static Integer getStateByTaskName(String taskCode) {
        for (ExpenseStateEnum elem : ExpenseStateEnum.values()) {
            if (elem.getTaskCode().equals(taskCode)) {
                return elem.getState();
            }
        }
        return -1;
    }
}
