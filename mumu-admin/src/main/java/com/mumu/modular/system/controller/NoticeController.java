package com.mumu.modular.system.controller;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.support.RespData;
import com.mumu.modular.system.model.Notice;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 通知相关操作controller
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping(value="/notice")
public class NoticeController {
    
    @RequestMapping(value="/msg", method = RequestMethod.POST)
    @ResponseBody
    public RespData getNoticeMsgs() {
        return RespData.getRespData(HttpStatus.OK.value(), new Notice().selectAll(), "");
    }
}
