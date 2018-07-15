package com.mumu.modular.flowable.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 
 * 〈一句话功能简述〉<br> 
 *  报销表
 *
 * @author 88396254
 * @date 2018年7月2日 下午5:18:15
 * @see [相关类/方法]（可选）
 * @since [产品/模块版本] （可选）
 */
@TableName("sys_expense")
public class Expense extends Model<Expense> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private String id;
	
    /**
     * 报销金额
     */
	private BigDecimal money;
	
    /**
     * 描述
     */
	private String expenseDesc;
	
	/**
	 * 创建时间
	 */
	private Date createtime;
	
    /**
     * 状态: 1.待提交  2:待审核   3.审核通过
     */
	private Integer state;
	
    /**
     * 用户id
     */
	private String userId;
	
    /**
     * 流程定义id
     */
	private String processId;


	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getExpenseDesc() {
        return expenseDesc;
    }

    public void setExpenseDesc(String expenseDesc) {
        this.expenseDesc = expenseDesc;
    }

    public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getProcessId() {
		return processId;
	}

	public void setProcessId(String processId) {
		this.processId = processId;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Expense{" +
			"id=" + id +
			", money=" + money +
			", desc=" + expenseDesc +
			", createtime=" + createtime +
			", state=" + state +
			", userId=" + userId +
			", processId=" + processId +
			"}";
	}
}
