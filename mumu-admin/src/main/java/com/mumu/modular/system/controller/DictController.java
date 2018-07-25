package com.mumu.modular.system.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.common.constant.dictmap.DictMap;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.model.Dict;
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
    public RespData list(@RequestParam(required = false) String code) {
        List<Map<String, Object>> list = this.dictService.list(code);
        return RespData.getRespData(HttpStatus.OK.value(), new DictWarpper(list).warp(), "");
    }
    
    /**
     * 新增字典
     */
    @RequestMapping(value = "/add")
    @BussinessLog(value = "新增字典", key = "name", dict = DictMap.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData add(@RequestBody Dict dict) {
        if (ToolUtil.isEmpty(dict)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        dict.insert();
        LogObjectHolder.me().set(dict);
        return RespData.getRespData(HttpStatus.OK.value(), "", "添加字典成功！");
    }
    
    /**
     * 更新字典
     */
    @RequestMapping(value = "/update")
    @BussinessLog(value = "更新字典", key = "name", dict = DictMap.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData update(@RequestBody Dict dict) {
        if (ToolUtil.isEmpty(dict)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        dict.updateById();
        LogObjectHolder.me().set(dict);
        return RespData.getRespData(HttpStatus.OK.value(), "", "更新字典成功！");
    }
    
    /**
     * 删除菜单
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/delete")
    @BussinessLog(value = "删除字典", key = "name", dict = DictMap.class)
    @ResponseBody
    public RespData delete(@RequestBody List<String> dictIds) {
        if (ToolUtil.isEmpty(dictIds)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        //用于记录日志
        LogObjectHolder.me().set(dictService.selectBatchIds(dictIds));
        this.dictService.deleteBatchIds(dictIds);
        return RespData.getRespData(HttpStatus.OK.value(), "", "删除字典成功！");
        
    }
}
