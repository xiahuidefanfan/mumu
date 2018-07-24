package com.mumu.modular.weixin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.support.RespData;
import com.mumu.modular.weixin.service.IBookService;

/**
 * 
 * @description 书籍管理控制器
 * @author xiahui
 * @date 2018年7月24日 下午11:12:11
 */
@Controller
@RequestMapping(value="/book")
public class BookController {
	
	@Autowired
    private IBookService bookService;
    
    @RequestMapping(value="/list", method = RequestMethod.POST)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData list(@RequestParam(required = false) String condition) {
        List<Map<String, Object>> list = this.bookService.list(condition);
        return RespData.getRespData(HttpStatus.OK.value(), list, "");
    }

}
