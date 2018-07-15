package com.mumu.core.common.constant.state;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  流程状态枚举
 *
 * @author 88396254
 * @date 2018年6月27日 下午7:16:45
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public enum FlowableState {

    SUBMITING(1, "待提交"),
    CHECKING(2, "待审核"),
    PASS(3, "审核通过"),
    UN_PASS(4, "未通过");

    int code;
    String message;

    FlowableState(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static String valueOf(Integer status) {
        if (status == null) {
            return "";
        } else {
            for (FlowableState s : FlowableState.values()) {
                if (s.getCode() == status) {
                    return s.getMessage();
                }
            }
            return "";
        }
    }
}
