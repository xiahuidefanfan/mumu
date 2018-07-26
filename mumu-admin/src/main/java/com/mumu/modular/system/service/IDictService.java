package com.mumu.modular.system.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.system.condition.DictSearchCondition;
import com.mumu.modular.system.model.Dict;

/**
 * 
 * @description 字典service
 * @author xiahui
 * @date 2018年7月24日 上午12:08:56
 */
public interface IDictService extends IService<Dict>{
	
	/**
     * 根据编码获取词典列表
     */
    List<Dict> selectByCode(@Param("code") String code);

    /**
     * 查询字典列表
     */
    List<Map<String, Object>> list(@Param("condition") DictSearchCondition condition);
}
