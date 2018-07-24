package com.mumu.modular.system.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.modular.system.dao.DictMapper;
import com.mumu.modular.system.model.Dict;
import com.mumu.modular.system.service.IDictService;

/**
 * 
 * @description 字典service实现类
 * @author xiahui
 * @date 2018年7月24日 上午12:10:20
 */
@Service
@Transactional
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict> implements IDictService{

	@Resource
    private DictMapper dictMapper;

	@Override
	public List<Dict> selectByCode(String code) {
		 return this.baseMapper.selectByCode(code);
	}

	@Override
	public List<Map<String, Object>> list(String condition) {
		return this.baseMapper.list(condition);
	}
	

}
