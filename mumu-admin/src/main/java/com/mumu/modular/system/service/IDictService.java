package com.mumu.modular.system.service;

import java.util.List;
import java.util.Map;


import com.mumu.modular.system.model.Dict;

/**
 * 
 * @description 字典service
 * @author xiahui
 * @date 2018年7月24日 上午12:08:56
 */
public interface IDictService {
	
	/**
     * 根据编码获取词典列表
     */
    List<Dict> selectByCode(String code);

    /**
     * 查询字典列表
     */
    List<Map<String, Object>> list(String condition);
}
