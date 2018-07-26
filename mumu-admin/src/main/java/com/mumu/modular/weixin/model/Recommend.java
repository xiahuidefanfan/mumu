package com.mumu.modular.weixin.model;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  推荐位置
 *
 * @author 88396254
 * @date 2018年7月26日 下午4:13:31
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@TableName("weixin_recommend")
public class Recommend {
    
    /**
     * 主键
     */
    @TableId(value="id", type= IdType.AUTO)
    private String id;
    
    /**
     * 书籍id
     */
    private String bookId;
    
    /**
     * 位置编码
     */
    private String positionCode;
    
    /**
     * 创建时间
     */
    private Date createTime;
    
    public String getId() {
        return id;
    }

    public String getBookId() {
        return bookId;
    }

    public String getPositionCode() {
        return positionCode;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public void setPositionCode(String positionCode) {
        this.positionCode = positionCode;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}
