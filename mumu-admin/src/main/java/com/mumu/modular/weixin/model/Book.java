package com.mumu.modular.weixin.model;

import java.util.Date;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

@TableName("weixin_book")
public class Book {
	
    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private String id;

	/**
	 * 书名
	 */
	private String bookName; 
	
	/**
	 * 所有者
	 */
	private String owner; 
	
	/**
	 * 类别
	 */
	private String type;
	
	/**
	 * 是否删除 1：删除 0：未删除
	 */
	private String deleteFlag; 
	
	/**
	 * 是否上架 1：上架 0：未上架
	 */
	private String isUpper;
	
	/**
	 * 创建时间
	 */
	private Date createTime;
	
	/*
	 * 修改时间
	 */
	private Date updateTime;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getDeleteFlag() {
		return deleteFlag;
	}
	public void setDeleteFlag(String deleteFlag) {
		this.deleteFlag = deleteFlag;
	}
	public String getIsUpper() {
		return isUpper;
	}
	public void setIsUpper(String isUpper) {
		this.isUpper = isUpper;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
}
