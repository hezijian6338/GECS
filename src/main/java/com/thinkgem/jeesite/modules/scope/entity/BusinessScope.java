/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.scope.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 经营范围Entity
 * @author xucaikai
 * @version 2017-10-16
 */
public class BusinessScope extends TreeEntity<BusinessScope> {
	
	private static final long serialVersionUID = 1L;
/*	private BusinessScope parent;		// 归属类型(上级)
	private String parentIds;		// 所有父级编号
	private String name;		// 类别名称
	private String sort;		// 排序*/
	private String code;		// 类别编码
	
	public BusinessScope() {
		super();
	}

	public BusinessScope(String id){
		super(id);
	}

	@JsonBackReference
	@NotNull(message="归属类型(上级)不能为空")
	public BusinessScope getParent() {
		return parent;
	}

	public void setParent(BusinessScope parent) {
		this.parent = parent;
	}
	
	@Length(min=1, max=2000, message="所有父级编号长度必须介于 1 和 2000 之间")
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=100, message="类别名称长度必须介于 1 和 100 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
/*	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}*/
	
	@Length(min=0, max=100, message="类别编码长度必须介于 0 和 100 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
}