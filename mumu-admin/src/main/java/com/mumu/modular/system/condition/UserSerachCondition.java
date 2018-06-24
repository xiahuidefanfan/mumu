package com.mumu.modular.system.condition;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 用户查询条件
 *
 * @author 88396254
 * @date 2018年6月1日 下午4:59:17
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class UserSerachCondition {
    private String page; // 页码
    private String limit; // 每页条数
    private String name;// 名称
    private String beginTime; // 开始时间
    private String endTime;// 结束时间
    private String deptid;// 部门编号
    
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
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getBeginTime() {
        return beginTime;
    }
    public String getEndTime() {
        return endTime;
    }
    public String getDeptid() {
        return deptid;
    }
    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    public void setDeptid(String deptid) {
        this.deptid = deptid;
    }
    @Override
    public String toString() {
        return "UserSerachCondition [page=" + page + ", limit=" + limit + ", name=" + name + ", beginTime=" + beginTime
                + ", endTime=" + endTime + ", deptid=" + deptid + "]";
    }
    
}
