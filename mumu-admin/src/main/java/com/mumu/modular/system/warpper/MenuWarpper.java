package com.mumu.modular.system.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.common.constant.state.IsMenu;
import com.mumu.core.base.warpper.BaseControllerWarpper;

import java.util.List;
import java.util.Map;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  菜单列表的包装类
 *
 * @author 88396254
 * @date 2018年6月13日 上午10:44:21
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class MenuWarpper extends BaseControllerWarpper {

    public MenuWarpper(List<Map<String, Object>> list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        map.put("statusName", ConstantFactory.me().getMenuStatusName((Integer) map.get("status")));
        map.put("isMenuName", IsMenu.valueOf((Integer) map.get("ismenu")));
        map.put("pcodeName", ConstantFactory.me().getMenuNameByCode((String) map.get("pcode")));
    }

}
