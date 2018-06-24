package com.mumu.modular.system.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.support.RespData;
import com.mumu.modular.system.service.IMenuService;
import com.mumu.modular.system.warpper.MenuWarpper;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  菜单控制器
 *
 * @author 88396254
 * @date 2018年6月11日 下午7:44:53
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {

    @Autowired
    private IMenuService menuService;
    
    /**
     * 获取角色列表
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/list")
    @ResponseBody
    public RespData list(@RequestParam(value="condition",required=false) String condition, 
                         @RequestParam(value="level",required=false) String level ) {
        List<Map<String, Object>> menus = menuService.selectMenus(condition, level);
        return RespData.getRespData(HttpStatus.OK.value(), super.warpObject(new MenuWarpper(menus)), "");
    }


}
