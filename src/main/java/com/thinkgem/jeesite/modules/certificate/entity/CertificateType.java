/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.thinkgem.jeesite.common.supcan.annotation.treelist.cols.SupCol;
import com.thinkgem.jeesite.common.utils.excel.annotation.ExcelField;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

import javax.validation.constraints.NotNull;

/**
 * 证照类型管理Entity
 * @author xucaikai
 * @version 2017-09-13
 */
public class CertificateType extends DataEntity<CertificateType> {
	
	private static final long serialVersionUID = 1L;
	private String certificateTypeCode;		// 证照类型编号
	private String certificateTypeName;		// 证照类型名称
	private String unitId;		// 颁发机构id
//	private String unitName;		// 颁发机构名称
	private Office office;       // 归属部门
	private String effectiveDate;		// 有效期限（年）
	private String description;		// 证照描述
	private String ownerType;		// 持证者类型
	
	public CertificateType() {
		super();
	}

	public CertificateType(String id){
		super(id);
	}

	@Length(min=1, max=64, message="证照类型编号长度必须介于 1 和 64 之间")
	public String getCertificateTypeCode() {
		return certificateTypeCode;
	}

	public void setCertificateTypeCode(String certificateTypeCode) {
		this.certificateTypeCode = certificateTypeCode;
	}
	
	@Length(min=1, max=18, message="证照类型名称长度必须介于 1 和 18 之间")
	public String getCertificateTypeName() {
		return certificateTypeName;
	}

	public void setCertificateTypeName(String certificateTypeName) {
		this.certificateTypeName = certificateTypeName;
	}
	
	@Length(min=0, max=64, message="颁发机构id长度必须介于 0 和 64 之间")
	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	/*public String getUnitName() {
		return unitName;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}*/
	@SupCol(isUnique="true", isHide="true")
	public String getId() {
		return id;
	}

	@JsonIgnore
	@NotNull(message="归属部门不能为空")
	public Office getOffice() {
		return this.office;

	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@Length(min=1, max=100, message="有效期限（年）长度必须介于 1 和 100 之间")
	public String getEffectiveDate() {
		return effectiveDate;
	}

	public void setEffectiveDate(String effectiveDate) {
		this.effectiveDate = effectiveDate;
	}
	
	@Length(min=0, max=100, message="证照描述长度必须介于 0 和 100 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=1, max=64, message="持证者类型长度必须介于 1 和 64 之间")
	public String getOwnerType() {
		return ownerType;
	}

	public void setOwnerType(String ownerType) {
		this.ownerType = ownerType;
	}
	
}