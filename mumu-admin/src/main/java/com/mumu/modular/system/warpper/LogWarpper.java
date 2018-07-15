package com.mumu.modular.system.warpper;

import com.mumu.core.common.constant.factory.ConstantFactory;
import com.mumu.core.base.warpper.BaseControllerWarpper;
import com.mumu.core.util.Contrast;
import com.mumu.core.util.DateUtil;
import com.mumu.core.util.ToolUtil;

import java.util.Date;
import java.util.Map;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  日志列表的包装类
 *
 * @author 88396254
 * @date 2018年6月13日 上午10:43:34
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class LogWarpper extends BaseControllerWarpper {

    public LogWarpper(Object list) {
        super(list);
    }

    @Override
    public void warpTheMap(Map<String, Object> map) {
        String message = (String) map.get("message");

        String userid = String.valueOf(map.get("userid"));
        map.put("userName", ConstantFactory.me().getUserNameById(userid));

        //如果信息过长,则只截取前100位字符串
        if (ToolUtil.isNotEmpty(message) && message.length() >= 100) {
            String subMessage = message.substring(0, 100) + "...";
            map.put("message", subMessage);
        }

        //如果信息中包含分割符号;;;   则分割字符串返给前台
        if (ToolUtil.isNotEmpty(message) && message.indexOf(Contrast.SEPARATOR) != -1) {
            String[] msgs = message.split(Contrast.SEPARATOR);
            map.put("regularMessage",msgs);
        }else{
            map.put("regularMessage",message);
        }
        
        map.put("createtime", DateUtil.formatDate((Date)map.get("createtime"),DateUtil.SECOND_FORMAT));
    }

}
