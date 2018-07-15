package com.mumu.core.common.constant.enums;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  角色枚举
 *
 * @author 88396254
 * @date 2018年7月2日 下午8:14:26
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public enum RoleTipsEnum {
    
    FINANCIAL_MANAGER("financial_manager","财务经理"), BOSS("boss","老板");;
    
    private String code;

    private String message;
    
    RoleTipsEnum(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }
    public String getMessage() {
        return message;
    }

}
