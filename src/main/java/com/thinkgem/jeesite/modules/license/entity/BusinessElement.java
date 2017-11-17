/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 营业执照元素生成表Entity
 * @author hzj
 * @version 2017-11-17
 */
public class BusinessElement extends DataEntity<BusinessElement> {
	
	private static final long serialVersionUID = 1L;
	private String elementeng;		// 元素英文名
	private String elementchinese;		// 元素中文名
	
	public BusinessElement() {
		super();
	}

	public BusinessElement(String id){
		super(id);
	}

	@Length(min=0, max=255, message="元素英文名长度必须介于 0 和 255 之间")
	public String getElementeng() {
		return elementeng;
	}

	public void setElementeng(String elementeng) {
		this.elementeng = elementeng;
	}
	
	@Length(min=0, max=255, message="元素中文名长度必须介于 0 和 255 之间")
	public String getElementchinese() {
		return elementchinese;
	}

	public void setElementchinese(String elementchinese) {
		this.elementchinese = elementchinese;
	}
	
}