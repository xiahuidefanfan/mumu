package com.mumu.modular.flowable.warpper;

import java.util.Map;

import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.common.constant.state.FlowableState;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  流程基本信息包装
 *
 * @author 88396254
 * @date 2018年6月27日 下午7:14:33
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class FlowableWarpper extends BaseControllerWarpper {

    public FlowableWarpper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        Integer state = (Integer) map.get("state");
        map.put("stateName", FlowableState.valueOf(state));
        String userId = ConstantFactory.me().getUserNameById((String) map.get("userid"));
        map.put("userId", userId);
    }

}
