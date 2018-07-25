package com.mumu.core.common.constant.dictmap;

import com.mumu.core.common.constant.dictmap.base.AbstractDictMap;

/**
 * 
 * 〈一句话功能简述〉<br> 
 * 书籍对象字段名-中文对照
 *
 * @author 88396254
 * @date 2018年7月25日 下午7:32:41
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
public class BookDict extends AbstractDictMap{
    @Override
    public void init() {
        put("bookName","书籍名称");
    }

    @Override
    protected void initBeWrapped() {

    }
}
