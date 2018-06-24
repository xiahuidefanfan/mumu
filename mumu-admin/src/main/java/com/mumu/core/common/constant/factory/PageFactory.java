package com.mumu.core.common.constant.factory;

import javax.servlet.http.HttpServletRequest;

import com.baomidou.mybatisplus.plugins.Page;
import com.mumu.core.common.constant.state.Order;
import com.mumu.core.support.HttpKit;
import com.mumu.core.util.ToolUtil;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  默认的分页参数创建
 *
 * @author 88396254
 * @date 2018年6月4日 上午9:35:37
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class PageFactory<T> {

    public Page<T> defaultPage() {
        HttpServletRequest request = HttpKit.getRequest();
        int limit = Integer.valueOf(request.getParameter("limit"));     //每页多少条数据
        int page = Integer.valueOf(request.getParameter("page"));   // 页码
        String sort = request.getParameter("sort");         //排序字段名称
        String order = request.getParameter("order");       //asc或desc(升序或降序)
        if (ToolUtil.isEmpty(sort)) {
            Page<T> pageObj = new Page<>(page, limit);
            pageObj.setOpenSort(false);
            return pageObj;
        } else {
            Page<T> pageObj = new Page<>(page, limit, sort);
            if (Order.ASC.getDes().equals(order)) {
                pageObj.setAsc(true);
            } else {
                pageObj.setAsc(false);
            }
            return pageObj;
        }
    }
}
