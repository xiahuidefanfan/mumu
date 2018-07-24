package com.mumu.modular.weixin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.mumu.modular.weixin.model.Book;

/**
 * 
 * @description 书籍dao
 * @author xiahui
 * @date 2018年7月24日 下午10:54:30
 */
public interface BookMapper extends BaseMapper<Book>{
	
	/**
	 * 根据条件获取书籍列表
	 * @param condition
	 * @return
	 */
	List<Map<String, Object>> list(@Param("condition")String condition);
}
