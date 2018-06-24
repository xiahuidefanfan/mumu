package com.mumu.modular.system.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.mumu.core.common.constant.CommConst;
import com.mumu.core.common.constant.Const;
import com.mumu.core.common.constant.dictmap.RoleDict;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.model.Role;
import com.mumu.modular.system.service.IMenuService;
import com.mumu.modular.system.service.IRoleService;
import com.mumu.modular.system.warpper.RoleWarpper;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  角色控制器
 *
 * @author 88396254
 * @date 2018年6月5日 上午9:52:07
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */

@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

    @Autowired
    private IRoleService roleService;
    
    @Autowired
    private IMenuService menuService;


    /**
     * 获取角色列表
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/list")
    @ResponseBody
    public RespData list(@RequestParam(required = false) String name) {
        List<Map<String, Object>> roles = this.roleService.selectRoles(name);
        return RespData.getRespData(HttpStatus.OK.value(), super.warpObject(new RoleWarpper(roles)), "");
    }
    
    /**
     * 添加角色信息
     */
    @Permission(Const.ADMIN_NAME)
    @BussinessLog(value = "添加角色", key = "name", dict = RoleDict.class)
    @RequestMapping(value = "/add")
    @ResponseBody
    public RespData add(@RequestBody Role role) {
        if (ToolUtil.isEmpty(role)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        role.insert();
        return RespData.getRespData(HttpStatus.OK.value(), null, "添加角色成功！");
    }
    
    /**
     * 修改角色信息
     */
    @Permission(Const.ADMIN_NAME)
    @BussinessLog(value = "修改角色", key = "name", dict = RoleDict.class)
    @RequestMapping(value = "/update")
    @ResponseBody
    public RespData update(@RequestBody Role role) {
        if (ToolUtil.isEmpty(role)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        
        // 查重
        Role theRole = roleService.selectRoleByName(role.getName());
        Role oldRole = role.selectById();
        if (oldRole != null && !theRole.getId().equals(oldRole.getId())) {
            throw new MumuException(BizExceptionEnum.ROLE_ALREADY_EXISTED);
        }
        // 用于记录日志
        LogObjectHolder.me().set(oldRole);
        role.updateById();
        return RespData.getRespData(HttpStatus.OK.value(), null, "修改角色成功！");
    }

    /**
     * 删除角色信息
     */
    @Permission(Const.ADMIN_NAME)
    @BussinessLog(value = "删除角色", key = "name", dict = RoleDict.class)
    @RequestMapping(value = "/delete")
    @ResponseBody
    public RespData delete(@RequestBody String id) {
        if (ToolUtil.isEmpty(id)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        LogObjectHolder.me().set(roleService.selectById(id));
        roleService.deleteById(id);
        return RespData.getRespData(HttpStatus.OK.value(), null, "删除角色成功！");
    }
    
    /**
     * 获取权限信息
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/authority")
    @ResponseBody
    public RespData authority(@RequestBody Role role) {
        if (ToolUtil.isEmpty(role)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        // 所有的菜单：这里的菜单列表也就是权限列表
        List<Map<String, Object>> menus = menuService.selectMenus(null, null);
        // 当前待修改权限角色已有的权限，用于前端设置权限树的checked属性
        List<String> authorities = this.menuService.getMenuIdsByRoleId(role.getId());
        Map<String, Object> data = new HashMap<String,Object>(CommConst.DEFAULT_MAP_SIZE);
        data.put("menus", menus);
        data.put("authorities", authorities);
        return RespData.getRespData(HttpStatus.OK.value(), data, "");
    }
    
    /**
     * 配置权限
     */
    @RequestMapping("/setAuthority")
    @BussinessLog(value = "配置权限", key = "name", dict = RoleDict.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData setAuthority(@RequestBody AuthorityBody body) {
        if (ToolUtil.isOneEmpty(body.getRoleId())) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
         }
        this.roleService.setAuthority(Integer.parseInt(body.getRoleId()), body.getIds());
        return RespData.getRespData(HttpStatus.OK.value(), null, "设置权限成功！");
    }
    
    /**
     * 权限配置入参封装
     */
     static class AuthorityBody{
        private String roleId;
        private String ids;
        
        public String getRoleId() {
            return roleId;
        }
        public String getIds() {
            return ids;
        }
        public void setRoleId(String roleId) {
            this.roleId = roleId;
        }
        public void setIds(String ids) {
            this.ids = ids;
        }
    }
}
