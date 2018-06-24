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

import com.mumu.core.base.controller.BaseController;
import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.common.constant.dictmap.DeptDict;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.system.model.Dept;
import com.mumu.modular.system.service.IDeptService;
import com.mumu.modular.system.warpper.DeptWarpper;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 部门管理controller
 *
 * @author 88396254
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@Controller
@RequestMapping(value="/dept")
public class DeptController extends BaseController{

    @Autowired
    private IDeptService deptService;
    

    @RequestMapping(value="/list", method = RequestMethod.POST)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData list(@RequestParam(required = false) String name) {
        List<Map<String, Object>> list = this.deptService.list(name);
        return RespData.getRespData(HttpStatus.OK.value(), new DeptWarpper(list).warp(), "");
    }
    
    @RequestMapping(value="/add", method = RequestMethod.POST)
    @BussinessLog(value = "添加部门", key = "simplename", dict = DeptDict.class)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData add(@RequestBody Dept dept) {
        if (ToolUtil.isEmpty(dept)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        deptSetPids(dept);
        dept.insert();
        return RespData.getRespData(HttpStatus.OK.value(), null, "添加部门成功！");
    }
    
    @RequestMapping(value="/update", method = RequestMethod.POST)
    @BussinessLog(value = "修改部门", key = "simplename", dict = DeptDict.class)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData update(@RequestBody Dept dept) {
        if (ToolUtil.isEmpty(dept)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        // 查重
        Dept theDept = deptService.selectDeptByName(dept.getSimplename());
        Dept oldDept = dept.selectById();
        if (oldDept != null && !theDept.getId().equals(oldDept.getId())) {
            throw new MumuException(BizExceptionEnum.DEPT_ALREADY_EXISTED);
        }
        
        // 用于记录日志
        LogObjectHolder.me().set(oldDept);
        deptSetPids(dept);
        dept.updateById();
        return RespData.getRespData(HttpStatus.OK.value(), null, "修改部门成功！");
    }
    
    @RequestMapping(value="/delete", method = RequestMethod.POST)
    @BussinessLog(value = "删除部门", key = "simplename", dict = DeptDict.class)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData delete(@RequestBody String id) {
        if (ToolUtil.isEmpty(id)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        LogObjectHolder.me().set(deptService.selectById(id));
        deptService.deleteById(id);;
        return RespData.getRespData(HttpStatus.OK.value(), null, "删除部门成功！");
    }
    
    private void deptSetPids(Dept dept) {
        if (ToolUtil.isEmpty(dept.getPid()) || dept.getPid().equals(0)) {
            dept.setPid(0);
            dept.setPids("[0],");
        } else {
            int pid = dept.getPid();
            Dept temp = deptService.selectById(pid);
            String pids = temp.getPids();
            dept.setPid(pid);
            dept.setPids(pids + "[" + pid + "],");
        }
    }
    
    
}
