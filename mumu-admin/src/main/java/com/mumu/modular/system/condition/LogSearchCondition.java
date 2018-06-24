package com.mumu.modular.system.condition;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 业务日志查询请求体封装
 *
 * @author 88396254
 * @date 2018年6月12日 下午7:29:06
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class LogSearchCondition {
    private String page; // 页码
    private String limit; // 每页条数
    private String beginTime;
    private String endTime;
    private String logName;
    private String logType;
    public String getBeginTime() {
        return beginTime;
    }
    public String getEndTime() {
        return endTime;
    }
    public String getLogName() {
        return logName;
    }
    public String getLogType() {
        return logType;
    }
    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    public void setLogName(String logName) {
        this.logName = logName;
    }
    public void setLogType(String logType) {
        this.logType = logType;
    }
    
    public String getPage() {
        return page;
    }
    public String getLimit() {
        return limit;
    }
    public void setPage(String page) {
        this.page = page;
    }
    public void setLimit(String limit) {
        this.limit = limit;
    }
    @Override
    public String toString() {
        return "LogSearchCondition [page=" + page + ", limit=" + limit + ", beginTime=" + beginTime + ", endTime="
                + endTime + ", logName=" + logName + ", logType=" + logType + "]";
    }
}
