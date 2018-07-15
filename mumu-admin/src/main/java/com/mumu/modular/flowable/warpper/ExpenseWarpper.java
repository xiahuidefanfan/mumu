package com.mumu.modular.flowable.warpper;

import java.util.Date;
import java.util.Map;

import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.common.constant.enums.ExpenseStateEnum;
import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.util.DateUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  报销列表包装
 *
 * @author 88396254
 * @date 2018年7月2日 上午11:10:13
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */

public class ExpenseWarpper extends BaseControllerWarpper {

    public ExpenseWarpper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        Integer state = (Integer) map.get("state");
        map.put("stateName", ExpenseStateEnum.valueOf(state));
        String userName = ConstantFactory.me().getUserNameById(String.valueOf(map.get("userId")));
        map.put("applicant", userName);
        map.put("createtimeFormat", DateUtil.formatDate((Date)map.get("createtime"),DateUtil.SECOND_FORMAT));
        map.put("canSubmit", (map.get("state") == ExpenseStateEnum.IS_SUBMIT.getState()) || 
                map.get("state") == ExpenseStateEnum.IS_REJECT.getState());
        map.put("isEnd", map.get("state") == ExpenseStateEnum.IS_PASS.getState());
    }

}
