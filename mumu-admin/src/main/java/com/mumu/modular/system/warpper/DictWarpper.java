package com.mumu.modular.system.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.modular.system.model.Dict;
import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.util.ToolUtil;

import java.util.List;
import java.util.Map;

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
        StringBuffer detail = new StringBuffer();
        Integer id = (Integer) map.get("id");
        List<Dict> dicts = ConstantFactory.me().findInDict(id);
        if(dicts != null){
            for (Dict dict : dicts) {
                detail.append(dict.getNum() + ":" +dict.getName() + ",");
            }
            map.put("detail", ToolUtil.removeSuffix(detail.toString(),","));
        }
    }

}
