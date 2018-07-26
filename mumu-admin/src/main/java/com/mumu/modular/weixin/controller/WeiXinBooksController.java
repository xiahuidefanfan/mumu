package com.mumu.modular.weixin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mumu.core.support.RespData;
import com.mumu.modular.weixin.service.IRecommendService;

@Controller
@RestController
@RequestMapping(value="weixin",method=RequestMethod.GET)
public class WeiXinBooksController {
	
	/**
	 * 首页轮播数量
	 */
	private static final int CAROUSEL_SIZE = 3;
	
	@Autowired
    private IRecommendService recommendService;
    
    @RequestMapping(value="recommendCarousel", method=RequestMethod.GET)
    public RespData recommendCarousel() {
        return RespData.getRespData(HttpStatus.OK.value(), recommendService.list(CAROUSEL_SIZE), "");
    }
}
