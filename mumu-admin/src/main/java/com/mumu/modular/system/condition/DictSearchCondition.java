package com.mumu.modular.system.condition;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  字典查询条件设置
 *
 * @author 88396254
 * @date 2018年7月26日 上午10:11:40
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class DictSearchCondition {
    
    /**
     * 字典名称
     */
    private String name;

    /**
     * 字典编码
     */
    private String code;

    public String getName() {
        return name;
    }

    public String getCode() {
        return code;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
