package com.mumu.modular.system.warpper;

import java.util.Map;

import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.util.ToolUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  字典列表的包装
 *
 * @author 88396254
 * @date 2018年6月13日 上午10:44:39
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */

public class DictWarpper extends BaseControllerWarpper {

    public DictWarpper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        Integer pId = (Integer) map.get("pId");
        if (ToolUtil.isEmpty(pId) || pId.equals(0)) {
            map.put("pName", "--");
        }
    }

}
