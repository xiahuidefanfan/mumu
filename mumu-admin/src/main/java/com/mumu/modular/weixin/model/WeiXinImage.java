package com.mumu.modular.weixin.model;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  微信图片
 *
 * @author 88396254
 * @date 2018年7月27日 上午10:19:08
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@TableName("weixin_image")
public class WeiXinImage {
    
    /**
     * 主键
     */
    @TableId(value="id", type= IdType.AUTO)
    private String id;
    
    /**
     * 业务id
     */
    private String businessId;
    
    /**
     * 小图
     */
    private String smallImageUrl;
    
    /**
     * 中图
     */
    private String normalImageUrl;
    
    /**
     * 大图
     */
    private String bigImageUrl;

    public String getId() {
        return id;
    }

    public String getBusinessId() {
        return businessId;
    }

    public String getSmallImageUrl() {
        return smallImageUrl;
    }

    public String getNormalImageUrl() {
        return normalImageUrl;
    }

    public String getBigImageUrl() {
        return bigImageUrl;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setBusinessId(String businessId) {
        this.businessId = businessId;
    }

    public void setSmallImageUrl(String smallImageUrl) {
        this.smallImageUrl = smallImageUrl;
    }

    public void setNormalImageUrl(String normalImageUrl) {
        this.normalImageUrl = normalImageUrl;
    }

    public void setBigImageUrl(String bigImageUrl) {
        this.bigImageUrl = bigImageUrl;
    }
    
}
