package com.mumu.modular.system.warpper;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.util.DateUtil;
import com.mumu.core.util.ToolUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 用户管理的包装类
 *
 * @author 88396254
 * @date 2018年6月1日 下午2:31:20
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class UserWarpper extends BaseControllerWarpper {

    public UserWarpper(List<Map<String, Object>> list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        map.put("sexName", ConstantFactory.me().getSexName((Integer) map.get("sex")));
        map.put("roleName", ConstantFactory.me().getRoleName((String) map.get("roleId")));
        map.put("deptName", ConstantFactory.me().getDeptName(map.get("deptId").toString()));
        map.put("statusName", ConstantFactory.me().getStatusName((Integer) map.get("status")));
        if(ToolUtil.isNotEmpty(map.get("birthday"))) {
            map.put("birthday", DateUtil.formatDate((Date)map.get("birthday"),DateUtil.DAY_FORMAT));
        }
        if(ToolUtil.isNotEmpty(map.get("createtime"))) {
            map.put("createtimeFormat", DateUtil.formatDate((Date)map.get("createtime"),DateUtil.DAY_FORMAT));
        }
    }

}
