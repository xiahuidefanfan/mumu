package com.mumu.modular.system.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.plugins.Page;
import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.common.constant.dictmap.UserDict;
import com.mumu.core.common.constant.factory.PageFactory;
import com.mumu.core.common.constant.state.ManagerStatus;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.shiro.ShiroKit;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.condition.UserSerachCondition;
import com.mumu.modular.system.model.User;
import com.mumu.modular.system.service.IUserService;
import com.mumu.modular.system.warpper.UserWarpper;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  系统管理员控制器
 *
 * @author 88396254
 * @date 2018年6月4日 上午9:29:14
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping("/mgr")
public class UserMgrController extends BaseController {

    @Autowired
    private IUserService userService;


    /**
     * 查询管理员列表
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/list")
    @Permission
    @ResponseBody
    public RespData list(UserSerachCondition condition) {
        Page<User> page = new PageFactory<User>().defaultPage();
        List<Map<String, Object>> result = userService.selectUsers(page, condition);
        page.setRecords((List<User>) new UserWarpper(result).warp());
        return RespData.getRespData(HttpStatus.OK.value(), page.getRecords(), "", page.getTotal());
    }
    
    /**
     * 添加用户
     */
    @RequestMapping("/add")
    @BussinessLog(value = "添加用户", key = "account", dict = UserDict.class)
    @Permission
    @ResponseBody
    public RespData add(@RequestBody User user) {
        assertAuth(user.getId());
        // 判断账号是否重复
        User theUser = userService.getByAccount(user.getAccount());
        if (theUser != null) {
            throw new MumuException(BizExceptionEnum.USER_ALREADY_REG);
        }
        user.setSalt(ShiroKit.getRandomSalt(5));
        user.setPassword(ShiroKit.md5(user.getPassword(), user.getSalt()));
        user.setStatus(ManagerStatus.OK.getCode());
        user.setCreatetime(new Date());
        user.insert();
        return RespData.getRespData(HttpStatus.OK.value(), null, "添加用户成功！");
    }
    
    /**
     * 修改用户
     */
    @RequestMapping("/update")
    @BussinessLog(value = "修改用户", key = "account", dict = UserDict.class)
    @Permission
    @ResponseBody
    public RespData update(@RequestBody User user) {
        
        if (ToolUtil.isEmpty(user)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        assertAuth(user.getId());
        // 查重
        User theUser = userService.getByAccount(user.getAccount());
        User oldUser = user.selectById();
        if (theUser != null && !theUser.getId().equals(oldUser.getId())) {
            throw new MumuException(BizExceptionEnum.USER_ALREADY_REG);
        }
        // 用于记录日志
        LogObjectHolder.me().set(oldUser);
        if(ToolUtil.isEmpty(user.getPassword())){
            // 修改时没有填写密码，以旧密码为准
            user.setPassword(oldUser.getPassword());
            user.setCreatetime(oldUser.getCreatetime());
        }else {
            // 修改时填写了新密码
            user.setSalt(ShiroKit.getRandomSalt(5));
            user.setPassword(ShiroKit.md5(user.getPassword(), user.getSalt()));
        }
        user.setStatus(ManagerStatus.OK.getCode());
        user.updateById();
        return RespData.getRespData(HttpStatus.OK.value(), null, "修改用户成功！");
    }
    
    /**
     * 删除用户:支持批量删除
     */
    @RequestMapping("/delete")
    @BussinessLog(value = "删除用户", key = "account", dict = UserDict.class)
    @Permission
    @ResponseBody
    public RespData delete(@RequestBody List<String> ids) {
        for(String id : ids) {
            //不能删除超级管理员
            if (id.equals(Const.ADMIN_ID)) {
                throw new MumuException(BizExceptionEnum.CANT_DELETE_ADMIN);
            }
            assertAuth(id);
        }
        // 用于记录日志
        LogObjectHolder.me().set(userService.selectBatchIds(ids));
        userService.deleteBatchIds(ids);
        return RespData.getRespData(HttpStatus.OK.value(), null, "删除用户成功！");
    }
    
    /**
     * 重置管理员的密码
     */
    @RequestMapping("/reset")
    @BussinessLog(value = "重置用户密码", key = "account", dict = UserDict.class)
    @Permission
    @ResponseBody
    public RespData reset(@RequestBody String id) {
        if (ToolUtil.isEmpty(id)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        assertAuth(id);
        User user = userService.selectById(id);
        user.setSalt(ShiroKit.getRandomSalt(5));
        user.setPassword(ShiroKit.md5(Const.DEFAULT_PWD, user.getSalt()));
        this.userService.updateById(user);
        // 用于记录日志
        LogObjectHolder.me().set(userService.selectById(id));
        return RespData.getRespData(HttpStatus.OK.value(), null, "重置用户密码成功！");
    }

    /**
     * 冻结用户
     */
    @RequestMapping("/freeze")
    @BussinessLog(value = "冻结用户", key = "account", dict = UserDict.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData freeze(@RequestBody String id) {
        if (ToolUtil.isEmpty(id)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        //不能冻结超级管理员
        if (id.equals(Const.ADMIN_ID)) {
            throw new MumuException(BizExceptionEnum.CANT_FREEZE_ADMIN);
        }
        this.userService.setStatus(id, ManagerStatus.FREEZED.getCode());
        // 用于记录日志
        LogObjectHolder.me().set(userService.selectById(id));
        return RespData.getRespData(HttpStatus.OK.value(), null, "冻结用户成功！");
    }

    /**
     * 解除冻结用户
     */
    @RequestMapping("/unfreeze")
    @BussinessLog(value = "解除冻结用户", key = "account", dict = UserDict.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData unfreeze(@RequestBody String id) {
        if (ToolUtil.isEmpty(id)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        this.userService.setStatus(id, ManagerStatus.OK.getCode());
        // 用于记录日志
        LogObjectHolder.me().set(userService.selectById(id));
        return RespData.getRespData(HttpStatus.OK.value(), null, "解除冻结用户成功！");
    }

    /**
     * 判断当前登录的用户是否有操作这个用户的权限
     */
    private void assertAuth(String userId) {
        if (ShiroKit.isAdmin()) {
            return;
        }
        List<String> deptDataScope = ShiroKit.getDeptDataScope();
        User user = this.userService.selectById(userId);
        String deptid = user.getDeptId();
        if (deptDataScope.contains(deptid)) {
            return;
        } else {
            throw new MumuException(BizExceptionEnum.NO_PERMITION);
        }

    }
}
