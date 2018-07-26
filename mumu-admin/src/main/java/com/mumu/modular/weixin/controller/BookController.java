package com.mumu.modular.weixin.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mumu.core.common.annotion.BussinessLog;
import com.mumu.core.common.annotion.Permission;
import com.mumu.core.common.constant.Const;
import com.mumu.core.common.constant.dictmap.BookDict;
import com.mumu.core.common.exception.BizExceptionEnum;
import com.mumu.core.exception.MumuException;
import com.mumu.core.log.LogObjectHolder;
import com.mumu.core.support.RespData;
import com.mumu.core.util.ToolUtil;
import com.mumu.modular.weixin.model.Book;
import com.mumu.modular.weixin.model.Recommend;
import com.mumu.modular.weixin.service.IBookService;
import com.mumu.modular.weixin.service.IRecommendService;
import com.mumu.modular.weixin.warpper.BookWarpper;

/**
 * 
 * @description 书籍管理控制器
 * @author xiahui
 * @date 2018年7月24日 下午11:12:11
 */
@Controller
@RequestMapping(value="/book")
public class BookController {
    
    /**
     * 轮播位置码
     */
    private static final String BOOK_POSITION_CODE = "BOOK_POSITION_CAROUSEL";
	
	@Autowired
    private IBookService bookService;
	
	@Autowired
	private IRecommendService recommendService;
	
    @RequestMapping(value="/list", method = RequestMethod.POST)
    @ResponseBody
    @Permission(Const.ADMIN_NAME)
    public RespData list(@RequestParam(required = false) String name) {
        List<Map<String, Object>> list = this.bookService.list(name);
        return RespData.getRespData(HttpStatus.OK.value(), new BookWarpper(list).warp(), "");
    }

    /**
     * 新增书籍
     */
    @RequestMapping(value = "/add")
    @BussinessLog(value = "新增书籍", key = "bookName", dict = BookDict.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData add(@RequestBody Book book) {
        if (ToolUtil.isEmpty(book)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        book.setCreateTime(new Date());
        book.setUpdateTime(new Date());
        book.insert();
        LogObjectHolder.me().set(book);
        return RespData.getRespData(HttpStatus.OK.value(), "", "添加书籍成功！");
    }
    
    /**
     * 更新书籍
     */
    @RequestMapping(value = "/update")
    @BussinessLog(value = "更新书籍", key = "name", dict = BookDict.class)
    @Permission(Const.ADMIN_NAME)
    @ResponseBody
    public RespData update(@RequestBody Book book) {
        if (ToolUtil.isEmpty(book)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        book.updateById();
        LogObjectHolder.me().set(book);
        return RespData.getRespData(HttpStatus.OK.value(), "", "更新书籍成功！");
    }
    
    /**
     * 删除书籍
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/delete")
    @BussinessLog(value = "删除书籍", key = "name", dict = BookDict.class)
    @ResponseBody
    public RespData delete(@RequestBody List<String> bookIds) {
        if (ToolUtil.isEmpty(bookIds)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        //用于记录日志
        LogObjectHolder.me().set(bookService.selectBatchIds(bookIds));
        this.bookService.deleteBatchIds(bookIds);
        return RespData.getRespData(HttpStatus.OK.value(), "", "删除书籍成功！");
        
    }
    
    /**
     * 推荐书籍到轮播
     */
    @Permission(Const.ADMIN_NAME)
    @RequestMapping(value = "/recommendCarousel")
    @ResponseBody
    public RespData recommendCarousel(@RequestBody List<String> bookIds) {
        if (ToolUtil.isEmpty(bookIds)) {
            throw new MumuException(BizExceptionEnum.REQUEST_NULL);
        }
        List<Recommend> recommends = new ArrayList<Recommend>();
        // 生成推荐对象
        for(String bookId : bookIds) {
            Recommend recommend = new Recommend();
            recommend.setBookId(bookId);
            recommend.setCreateTime(new Date());
            recommend.setPositionCode(BOOK_POSITION_CODE);
            recommends.add(recommend);
        }
        this.recommendService.insertBatch(recommends);
        return RespData.getRespData(HttpStatus.OK.value(), "", "推荐轮播成功！");
        
    }
}
