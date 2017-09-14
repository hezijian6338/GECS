/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.thinkgem.jeesite.modules.sys.entity.Area;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 证照库管理Entity
 * @author xucaikai
 * @version 2017-09-14
 */
public class CertificateLibrary extends DataEntity<CertificateLibrary> {
	
	private static final long serialVersionUID = 1L;
	private String certificateName;		// 证照名称
	private String certificateTypeId;		// 证照类型id
	private String description;		// 证照描述
	private String unitId;		// 颁发机构id
	private String unitName;		// 颁发机构名称
	private Office office;      //部门名称
	private String ownerType;		// 持证者类型
	private Date effectiveDateStart;		// 证照有效期（起始
	private Date effectiveDateEnd;		// 证照有效期（截至）
	private String status;		// 状态
	private Area area;		// 所属区域
	private String path;		// 文件路径
	private String isIssue;		// 是否核发
	private Date issueDate;		// 核发日期
	
	public CertificateLibrary() {
		super();
	}

	public CertificateLibrary(String id){
		super(id);
	}

	@Length(min=1, max=100, message="证照名称长度必须介于 1 和 100 之间")
	public String getCertificateName() {
		return certificateName;
	}

	public void setCertificateName(String certificateName) {
		this.certificateName = certificateName;
	}
	
	@Length(min=0, max=64, message="证照类型id长度必须介于 0 和 64 之间")
	public String getCertificateTypeId() {
		return certificateTypeId;
	}

	public void setCertificateTypeId(String certificateTypeId) {
		this.certificateTypeId = certificateTypeId;
	}
	
	@Length(min=0, max=100, message="证照描述长度必须介于 0 和 100 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=18, message="颁发机构id长度必须介于 0 和 18 之间")
	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}
	
	@Length(min=1, max=64, message="颁发机构名称长度必须介于 1 和 64 之间")
	public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	@JsonIgnore
	@NotNull(message="归属部门不能为空")
	public Office getOffice() {
		return this.office;

	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=0, max=64, message="持证者类型长度必须介于 0 和 64 之间")
	public String getOwnerType() {
		return ownerType;
	}

	public void setOwnerType(String ownerType) {
		this.ownerType = ownerType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEffectiveDateStart() {
		return effectiveDateStart;
	}

	public void setEffectiveDateStart(Date effectiveDateStart) {
		this.effectiveDateStart = effectiveDateStart;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEffectiveDateEnd() {
		return effectiveDateEnd;
	}

	public void setEffectiveDateEnd(Date effectiveDateEnd) {
		this.effectiveDateEnd = effectiveDateEnd;
	}
	
	@Length(min=0, max=2, message="状态长度必须介于 0 和 2 之间")
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
	@Length(min=0, max=200, message="文件路径长度必须介于 0 和 200 之间")
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	@Length(min=0, max=2, message="是否核发长度必须介于 0 和 2 之间")
	public String getIsIssue() {
		return isIssue;
	}

	public void setIsIssue(String isIssue) {
		this.isIssue = isIssue;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(Date issueDate) {
		this.issueDate = issueDate;
	}
	
}