package com.mumu.modular.weixin.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.mumu.modular.weixin.dao.RecommendMapper;
import com.mumu.modular.weixin.model.Recommend;
import com.mumu.modular.weixin.service.IRecommendService;

@Service
@Transactional
public class RecommendServiceImpl extends ServiceImpl<RecommendMapper, Recommend> implements IRecommendService{
    @Override
    public List<Map<String, Object>> list(int size) {
        return this.baseMapper.list(size);
    }
}
