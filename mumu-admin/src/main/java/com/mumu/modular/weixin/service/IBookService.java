package com.mumu.modular.weixin.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.weixin.model.Book;

/**
 * 
 * @description 书籍service
 * @author xiahui
 * @date 2018年7月24日 下午10:54:47
 */
public interface IBookService extends IService<Book> {
	
	/**
	 * 根据条件获取书籍列表
	 * @param condition
	 * @return
	 */
	List<Map<String, Object>> list(String name);
}
