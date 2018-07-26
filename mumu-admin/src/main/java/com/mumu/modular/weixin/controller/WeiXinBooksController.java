package com.mumu.modular.weixin.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mumu.core.support.RespData;

@Controller
@RestController
@RequestMapping(value="weixin",method=RequestMethod.GET)
public class WeiXinBooksController {
    
   /* @RequestMapping(value="splashBooks", method=RequestMethod.GET)
    public RespData splashBooks() {
        TestModel model = new TestModel();
        model.setAge(11);
        model.setName("testname");
        return RespData.getRespData(HttpStatus.OK.value(), model, "");
    }*/
}
