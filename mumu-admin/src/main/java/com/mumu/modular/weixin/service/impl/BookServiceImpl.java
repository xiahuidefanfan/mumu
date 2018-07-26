package com.mumu.modular.weixin.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.modular.weixin.dao.BookMapper;
import com.mumu.modular.weixin.model.Book;
import com.mumu.modular.weixin.service.IBookService;

/**
 * 
 * @description 书籍service实现
 * @author xiahui
 * @date 2018年7月24日 下午10:55:15
 */
@Service
@Transactional
public class BookServiceImpl extends ServiceImpl<BookMapper, Book> implements IBookService {
	
	@Override
    public List<Map<String, Object>> list(String name) {
        return this.baseMapper.list(name);
    }
}
