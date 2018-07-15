package com.mumu.modular.system.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.system.model.Dept;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  部门操作service
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public interface IDeptService extends IService<Dept> {

    /**
     * 删除部门
     */
    void deleteDept(Integer deptId);

    /**
     * 获取部门列表
     */
    List<Map<String, Object>> list(@Param("condition") String condition);
    
    /**
     * 根据部门名称获取部门信息
     */
    Dept selectDeptByName(String simplename);
    
}
