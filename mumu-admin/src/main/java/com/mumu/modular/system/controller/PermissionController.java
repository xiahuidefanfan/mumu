package com.mumu.modular.system.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.support.RespData;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  权限控制器
 *
 * @author 88396254
 * @date 2018年6月19日 上午11:06:46
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
public class PermissionController {
    
    /**
     * 权限控制
     */
    @RequestMapping(value = "/permission")
    @ResponseBody
    public RespData permission(@RequestBody String[] uris) {
        Map<String,Boolean> permissionMap = new HashMap<String, Boolean>();
        for(String uri : uris) {
             String buttton = uri.substring(uri.lastIndexOf("/") + 1);
            if(ShiroKit.hasPermission(uri)) {
                permissionMap.put(buttton, true);
            }else {
                permissionMap.put(buttton, false);
            }
        }
        return RespData.getRespData(HttpStatus.OK.value(), permissionMap, "");
    }

}
