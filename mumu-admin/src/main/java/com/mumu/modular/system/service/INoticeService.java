package com.mumu.modular.system.service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.service.IService;
import com.mumu.modular.system.model.Notice;

/**
 * <p>
 * 通知表 服务类
 * </p>
 *
 * @author stylefeng123
 * @since 2018-02-22
 */
public interface INoticeService extends IService<Notice> {

    /**
     * 获取通知列表
     */
    List<Map<String, Object>> list(String condition);
}
