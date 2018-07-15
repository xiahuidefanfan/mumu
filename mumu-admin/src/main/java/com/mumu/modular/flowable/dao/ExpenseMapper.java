package com.mumu.modular.flowable.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.mumu.modular.flowable.model.Expense;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 报销流程详情
 *
 * @author 88396254
 * @date 2018年6月27日 下午5:49:05
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public interface ExpenseMapper extends BaseMapper<Expense> {
    
    /**
     * 
     * 根据流程实例id获取报销单信息
     *
     * @param processId
     * @return
     */
    Map<String, Object> getExpenseByProcessId(@Param("processId")String processId);
}