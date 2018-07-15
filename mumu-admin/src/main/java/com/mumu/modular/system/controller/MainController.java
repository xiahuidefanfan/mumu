package com.mumu.modular.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.common.constant.CommConst;
import com.mumu.core.node.MenuNode;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ApiMenuFilter;
import com.mumu.modular.system.model.User;
import com.mumu.modular.system.service.IMenuService;
import com.mumu.modular.system.service.IUserService;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 首页初始化controller
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
public class MainController {
    
    @Autowired
    private IMenuService menuService;

    @Autowired
    private IUserService userService;
    
    @RequestMapping("/initMain")
    @ResponseBody
    public RespData initMain() {
        List<String> roleList = ShiroKit.getUser().getRoleList();
        // 根据权限获取菜单列表
        List<MenuNode> menus = menuService.getMenusByRoleIds(roleList);
        List<MenuNode> titles = MenuNode.buildTitle(menus);
        titles = ApiMenuFilter.build(titles);
        
        // 获取用户信息
        String id = ShiroKit.getUser().getId();
        User user = userService.selectById(id);
        String avatar = user.getAvatar();
        
        // 封装返回
        Map<String, Object> dataMap = new HashMap<String, Object>(CommConst.DEFAULT_MAP_SIZE);
        dataMap.put("avatar", avatar);
        dataMap.put("titles", titles);
        dataMap.put("shiroUser", ShiroKit.getUser());
        
        return RespData.getRespData(HttpStatus.OK.value(), dataMap, "");
        
    }

}
