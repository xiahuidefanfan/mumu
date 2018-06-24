package com.mumu.modular.system.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.util.ToolUtil;

import java.util.Map;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  部门列表的包装
 *
 * @author 88396254
 * @date 2018年6月4日 上午9:16:53
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */

public class DeptWarpper extends BaseControllerWarpper {

    public DeptWarpper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {

        String pid = map.get("pid").toString();

        if (ToolUtil.isEmpty(pid) || pid.equals(0)) {
            map.put("pName", "--");
        } else {
            map.put("pName", ConstantFactory.me().getDeptName(pid));
        }
    }

}
