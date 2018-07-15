package com.mumu.modular.flowable.model;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 报销任务vo
 *
 * @author 88396254
 * @date 2018年6月29日 下午5:43:43
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class ExpenseVo {

    private String id;

    private String name;

    private String createTimeFormat;
    
    private String assigneeName;

    private Object money;
    
    private String expenseDesc;
    
    private boolean selfFlag; // 是否是自己的任务
    
    private boolean canSubmit; // 是否是待提交状态
    
    private boolean canRollBack; // 当前节点是否可以做回退操作 1：可以 0：不可以
    
    public ExpenseVo() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object getMoney() {
        return money;
    }

    public void setMoney(Object money) {
        this.money = money;
    }

    public String getCreateTimeFormat() {
        return createTimeFormat;
    }

    public String getAssigneeName() {
        return assigneeName;
    }

    public void setCreateTimeFormat(String createTimeFormat) {
        this.createTimeFormat = createTimeFormat;
    }

    public void setAssigneeName(String assigneeName) {
        this.assigneeName = assigneeName;
    }

    public boolean isSelfFlag() {
        return selfFlag;
    }

    public void setSelfFlag(boolean selfFlag) {
        this.selfFlag = selfFlag;
    }

    public boolean isCanSubmit() {
        return canSubmit;
    }

    public void setCanSubmit(boolean canSubmit) {
        this.canSubmit = canSubmit;
    }
    
    public boolean isCanRollBack() {
        return canRollBack;
    }

    public void setCanRollBack(boolean canRollBack) {
        this.canRollBack = canRollBack;
    }

    public String getExpenseDesc() {
        return expenseDesc;
    }

    public void setExpenseDesc(String expenseDesc) {
        this.expenseDesc = expenseDesc;
    }

}
