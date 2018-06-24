package com.mumu.core.support;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 请求返回封装
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class RespData {
    
    private int statusCode;

    private Object data;

    private String message;
    
    // 分页时的记录总数
    private int dataCount; 


    public Object getData() {
        return data;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getDataCount() {
        return dataCount;
    }

    public void setDataCount(int dataCount) {
        this.dataCount = dataCount;
    }

    /**
     * dataCount：分页时使用，不分页时，该数值返回默认值0
     */
    public static RespData getRespData( int statusCode, Object data, String message, int... dataCount){
        RespData respData = new RespData();
        respData.setData(data);
        if(dataCount.length > 0) {
            respData.setDataCount(dataCount[0]);
        }
        respData.setStatusCode(statusCode);
        respData.setMessage(message);
        return respData;
    }
    
}
