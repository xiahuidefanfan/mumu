package com.mumu.modular.flowable.warpper;

import java.util.Date;
import java.util.Map;

import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.common.constant.enums.FlowableNodePositionEnum;
import com.mumu.core.util.DateUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 工作流节点包装
 *
 * @author 88396254
 * @date 2018年7月5日 下午7:22:30
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class FlowableNodeWarpper extends BaseControllerWarpper{

    public FlowableNodeWarpper(Object list) {
        super(list);
    }
    
    @Override
    protected void warpTheMap(Map<String, Object> map) {
        map.put("positionMsg",FlowableNodePositionEnum.valueOf(Integer.parseInt(map.get("position").toString())));
        map.put("canBackToMsg", map.get("canBackTo").equals("1")? "是" : "否");
        map.put("createtimeFormat", DateUtil.formatDate((Date)map.get("createtime"),DateUtil.SECOND_FORMAT));
    }

}
