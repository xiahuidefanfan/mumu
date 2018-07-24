package com.mumu.modular.system.controller;

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
import com.mumu.modular.system.service.IDictService;
import com.mumu.modular.system.warpper.DictWarpper;
/**
 * 
 * @description 字典controller
 * @author xiahui
 * @date 2018年7月24日 上午12:06:35
 */
@Controller
@RequestMapping(value="/dict")
public class DictController {

	@Autowired
    private IDictService dictService;
    
    @RequestMapping(value="/list", method = RequestMethod.POST)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData list(@RequestParam(required = false) String name) {
        List<Map<String, Object>> list = this.dictService.list(name);
        return RespData.getRespData(HttpStatus.OK.value(), new DictWarpper(list).warp(), "");
    }
}
