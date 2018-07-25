package com.mumu.modular.system.model;

import java.io.Serializable;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  字典表
 *
 * @author 88396254
 * @date 2018年6月14日 下午12:30:02
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@TableName("sys_dict")
public class Dict extends Model<Dict> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Integer id;
    /**
     * 排序
     */
	private Integer num;
    /**
     * 父级字典
     */
	private Integer pId;
    /**
     * 名称
     */
	private String name;
	
	/**
	 * 编码
	 */
	private String code;
	
    /**
     * 提示
     */
	private String tips;


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }

    public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTips() {
		return tips;
	}

	public void setTips(String tips) {
		this.tips = tips;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Dict{" +
			"id=" + id +
			", num=" + num +
			", pId=" + pId +
			", name=" + name +
			", tips=" + tips +
			"}";
	}
}
