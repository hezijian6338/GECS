/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.Area;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 证照模板管理Entity
 * @author xucaikai
 * @version 2017-09-18
 */
public class CertificateTemplate extends DataEntity<CertificateTemplate> {
	
	private static final long serialVersionUID = 1L;
	private String templateName;		// 模板名称
	private String templateType;		// 模板类型
	private Office office;		// 所属单位id
	private Area area;		// 所属区域
	private String isShare;		// 是否共享
	private String path;		// 文件路径
	
	public CertificateTemplate() {
		super();
	}

	public CertificateTemplate(String id){
		super(id);
	}

	@Length(min=1, max=100, message="模板名称长度必须介于 1 和 100 之间")
	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	
	@Length(min=1, max=20, message="模板类型长度必须介于 1 和 20 之间")
	public String getTemplateType() {
		return templateType;
	}

	public void setTemplateType(String templateType) {
		this.templateType = templateType;
	}
	
	@NotNull(message="所属单位id不能为空")
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=0, max=20, message="是否共享长度必须介于 0 和 20 之间")
	public String getIsShare() {
		return isShare;
	}

	public void setIsShare(String isShare) {
		this.isShare = isShare;
	}
	
	@Length(min=0, max=200, message="文件路径长度必须介于 0 和 200 之间")
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
}