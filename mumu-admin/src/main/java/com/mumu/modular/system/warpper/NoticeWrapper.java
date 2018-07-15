package com.mumu.modular.system.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.base.warpper.BaseControllerWarpper;

import java.util.Map;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  部门列表的包装
 *
 * @author 88396254
 * @date 2018年6月13日 上午10:44:08
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class NoticeWrapper extends BaseControllerWarpper {

    public NoticeWrapper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        String creater = (String) map.get("creater");
        map.put("createrName", ConstantFactory.me().getUserNameById(creater));
    }

}
