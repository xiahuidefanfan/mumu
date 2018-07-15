package com.mumu.modular.system.controller;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.common.constant.dictmap.MenuDict;
import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.common.constant.state.MenuStatus;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.model.Menu;
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
    @RequestMapping(value = "/list")
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData list(@RequestParam(value="condition",required=false) String condition, 
                         @RequestParam(value="level",required=false) String level ) {
        List<Map<String, Object>> menus = menuService.selectMenus(condition, level);
        return RespData.getRespData(HttpStatus.OK.value(), super.warpObject(new MenuWarpper(menus)), "");
    }
    
    /**
     * 新增菜单
     */
    
    @RequestMapping(value = "/add")
    @BussinessLog(value = "添加菜单", key = "name", dict = MenuDict.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData add(@RequestBody Menu menu) {
        if (ToolUtil.isEmpty(menu)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }

        //判断是否存在该编号
        String existedMenuName = ConstantFactory.me().getMenuNameByCode(menu.getCode());
        if (ToolUtil.isNotEmpty(existedMenuName)) {
            throw new MumuException(BizExceptionEnum.EXISTED_THE_MENU);
        }

        //设置父级菜单编号
        menuSetPcode(menu);
        menu.setStatus(MenuStatus.ENABLE.getCode());
        this.menuService.insert(menu);
        //用于记录日志
        LogObjectHolder.me().set(menu);
        return RespData.getRespData(HttpStatus.OK.value(), "", "添加菜单成功！");
    }

    /**
     * 删除菜单
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/delete")
    @BussinessLog(value = "删除菜单", key = "name", dict = MenuDict.class)
    @ResponseBody
    public RespData delete(@RequestBody String menuId) {
        if (ToolUtil.isEmpty(menuId)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }

        //用于记录日志
        LogObjectHolder.me().set(menuService.selectById(menuId));
        this.menuService.delMenuContainSubMenus(menuId);
        return RespData.getRespData(HttpStatus.OK.value(), "", "删除菜单成功！");
        
    }

    /**
     * 修该菜单
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/update")
    @BussinessLog(value = "修改菜单", key = "name", dict = MenuDict.class)
    @ResponseBody
    public RespData edit(@RequestBody Menu menu) {
        if (ToolUtil.isEmpty(menu)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        //设置父级菜单编号
        menuSetPcode(menu);
        //用于记录日志
        LogObjectHolder.me().set(menuService.selectById(menu.getId()));
        this.menuService.updateById(menu);
        return RespData.getRespData(HttpStatus.OK.value(), "", "修改菜单成功！");
    }

    /**
     * 根据请求的父级菜单编号设置pcode和层级
     */
    private void menuSetPcode(@Valid Menu menu) {
        if (ToolUtil.isEmpty(menu.getPcode()) || menu.getPcode().equals("0")) {
            menu.setPcode("0");
            menu.setPcodes("[0],");
            menu.setLevels(1);
        } else {
            Menu pMenu = menuService.selectMenuByCode(menu.getPcode());
            Integer pLevels = pMenu.getLevels();
            menu.setPcode(pMenu.getCode());

            //如果编号和父编号一致会导致无限递归
            if (menu.getCode().equals(menu.getPcode())) {
                throw new MumuException(BizExceptionEnum.MENU_PCODE_COINCIDENCE);
            }

            menu.setLevels(pLevels + 1);
            menu.setPcodes(pMenu.getPcodes() + "[" + pMenu.getCode() + "],");
        }
    }


}
