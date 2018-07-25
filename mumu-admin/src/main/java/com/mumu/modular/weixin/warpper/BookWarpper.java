package com.mumu.modular.weixin.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.util.DateUtil;
import com.mumu.core.util.ToolUtil;

import java.util.Date;
import java.util.List;
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

public class BookWarpper extends BaseControllerWarpper {
    private List<Map<String, Object>> dicts = ConstantFactory.me().getDicts();
    
    public BookWarpper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        for(Map<String, Object> dict : dicts) {
            if(ToolUtil.equals(dict.get("code"), map.get("deleteFlag"))){
                map.put("deleteFlagName", dict.get("name"));
            }
            
            if(ToolUtil.equals(dict.get("code"), map.get("isUpper"))){
                map.put("isUpperName", dict.get("name"));
            }
        }
        if(ToolUtil.isNotEmpty(map.get("createTime"))) {
            map.put("createTimeFormat", DateUtil.formatDate((Date)map.get("createTime"),DateUtil.SECOND_FORMAT));
        }
        if(ToolUtil.isNotEmpty(map.get("updateTime"))) {
            map.put("updateTimeFormat", DateUtil.formatDate((Date)map.get("updateTime"),DateUtil.SECOND_FORMAT));
        }
    }

}
