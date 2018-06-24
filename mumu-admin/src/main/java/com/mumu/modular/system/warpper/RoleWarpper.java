package com.mumu.modular.system.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.base.warpper.BaseControllerWarpper;

import java.util.List;
import java.util.Map;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  角色列表的包装类
 *
 * @author 88396254
 * @date 2018年6月13日 上午10:43:49
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class RoleWarpper extends BaseControllerWarpper {

    public RoleWarpper(List<Map<String, Object>> list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        map.put("pName", ConstantFactory.me().getSingleRoleName((Integer) map.get("pid")));
    }

}
