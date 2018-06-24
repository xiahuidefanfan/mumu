package com.mumu.core.exception;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 封装mumu异常
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class MumuException extends RuntimeException {

    /**
     */
    private static final long serialVersionUID = 1L;

    private Integer code;

    private String message;

    public MumuException(ServiceExceptionEnum serviceExceptionEnum) {
        this.code = serviceExceptionEnum.getCode();
        this.message = serviceExceptionEnum.getMessage();
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
