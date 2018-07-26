package com.mumu.modular.weixin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.mumu.modular.weixin.model.Recommend;

public interface RecommendMapper extends BaseMapper<Recommend>{
    /**
     * 根据条件获取推荐书籍列表
     * @param condition
     * @return
     */
    List<Map<String, Object>> list(@Param("size")int size);
}
