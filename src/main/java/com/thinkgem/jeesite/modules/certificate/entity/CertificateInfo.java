/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.entity;

import org.hibernate.validator.constraints.Length;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;
import com.thinkgem.jeesite.modules.sys.entity.Area;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 证照元数据Entity
 * @author xucaikai
 * @version 2017-09-18
 */
public class CertificateInfo extends DataEntity<CertificateInfo> {
	
	private static final long serialVersionUID = 1L;
	private String certificateTypeId;		// 证照类型
	private String certificateCode;		// 证照编号
	private String certificateName;		// 证照名称
	private Office office;		// 颁发机构id
	private Date establishDate;		// 成立日期
	private Date effectiveDateStar;		// 证照有效期（起始
	private Date effectiveDateEnd;		// 证照有效期（截至）
	private String registeredType;		// 注册公司类型
	private String registeredCapital;		// 注册资本
	private String address;		// 地址
	private String persionName;		// 法人姓名
	private String persionIdType;		// 法人身份证件类型
	private String personId;		// 法人身份证件号码
	private String persionPhone;		// 法人联系方式
	private String handlerName;		// 经办人姓名
	private String handlerIdType;		// 经办人身份证件类型
	private String handlerId;		// 经办人身份证件号码
	private String handlerPhone;		// 经办人联系方式
	private String scope;		// 经营/业务/许可范围
	private String buildingName;		// 建筑名称
	private String floorNumber;		// 层数
	private String useArea;		// 使用面积
	private String usage1;		// 使用情况
	private String dealfireFacilities;		// 现有消防设施
	private String postcode;		// 邮政编码
	private Area area;		// 所属区域
	
	public CertificateInfo() {
		super();
	}

	public CertificateInfo(String id){
		super(id);
	}

	@Length(min=0, max=64, message="证照类型长度必须介于 0 和 64 之间")
	public String getCertificateTypeId() {
		return certificateTypeId;
	}

	public void setCertificateTypeId(String certificateTypeId) {
		this.certificateTypeId = certificateTypeId;
	}
	
	@Length(min=1, max=100, message="证照编号长度必须介于 1 和 100 之间")
	public String getCertificateCode() {
		return certificateCode;
	}

	public void setCertificateCode(String certificateCode) {
		this.certificateCode = certificateCode;
	}
	
	@Length(min=1, max=100, message="证照名称长度必须介于 1 和 100 之间")
	public String getCertificateName() {
		return certificateName;
	}

	public void setCertificateName(String certificateName) {
		this.certificateName = certificateName;
	}
	
	public Office getOffice() {
		return office;
	}

	public void setOffice(Office office) {
		this.office = office;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="成立日期不能为空")
	public Date getEstablishDate() {
		return establishDate;
	}

	public void setEstablishDate(Date establishDate) {
		this.establishDate = establishDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="证照有效期（起始不能为空")
	public Date getEffectiveDateStar() {
		return effectiveDateStar;
	}

	public void setEffectiveDateStar(Date effectiveDateStar) {
		this.effectiveDateStar = effectiveDateStar;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="证照有效期（截至）不能为空")
	public Date getEffectiveDateEnd() {
		return effectiveDateEnd;
	}

	public void setEffectiveDateEnd(Date effectiveDateEnd) {
		this.effectiveDateEnd = effectiveDateEnd;
	}
	
	@Length(min=1, max=64, message="注册公司类型长度必须介于 1 和 64 之间")
	public String getRegisteredType() {
		return registeredType;
	}

	public void setRegisteredType(String registeredType) {
		this.registeredType = registeredType;
	}
	
	@Length(min=1, max=20, message="注册资本长度必须介于 1 和 20 之间")
	public String getRegisteredCapital() {
		return registeredCapital;
	}

	public void setRegisteredCapital(String registeredCapital) {
		this.registeredCapital = registeredCapital;
	}
	
	@Length(min=0, max=100, message="地址长度必须介于 0 和 100 之间")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	@Length(min=1, max=20, message="法人姓名长度必须介于 1 和 20 之间")
	public String getPersionName() {
		return persionName;
	}

	public void setPersionName(String persionName) {
		this.persionName = persionName;
	}
	
	@Length(min=1, max=20, message="法人身份证件类型长度必须介于 1 和 20 之间")
	public String getPersionIdType() {
		return persionIdType;
	}

	public void setPersionIdType(String persionIdType) {
		this.persionIdType = persionIdType;
	}
	
	@Length(min=1, max=64, message="法人身份证件号码长度必须介于 1 和 64 之间")
	public String getPersonId() {
		return personId;
	}

	public void setPersonId(String personId) {
		this.personId = personId;
	}
	
	@Length(min=0, max=20, message="法人联系方式长度必须介于 0 和 20 之间")
	public String getPersionPhone() {
		return persionPhone;
	}

	public void setPersionPhone(String persionPhone) {
		this.persionPhone = persionPhone;
	}
	
	@Length(min=0, max=20, message="经办人姓名长度必须介于 0 和 20 之间")
	public String getHandlerName() {
		return handlerName;
	}

	public void setHandlerName(String handlerName) {
		this.handlerName = handlerName;
	}
	
	@Length(min=0, max=20, message="经办人身份证件类型长度必须介于 0 和 20 之间")
	public String getHandlerIdType() {
		return handlerIdType;
	}

	public void setHandlerIdType(String handlerIdType) {
		this.handlerIdType = handlerIdType;
	}
	
	@Length(min=0, max=64, message="经办人身份证件号码长度必须介于 0 和 64 之间")
	public String getHandlerId() {
		return handlerId;
	}

	public void setHandlerId(String handlerId) {
		this.handlerId = handlerId;
	}
	
	@Length(min=0, max=20, message="经办人联系方式长度必须介于 0 和 20 之间")
	public String getHandlerPhone() {
		return handlerPhone;
	}

	public void setHandlerPhone(String handlerPhone) {
		this.handlerPhone = handlerPhone;
	}
	
	@Length(min=0, max=200, message="经营/业务/许可范围长度必须介于 0 和 200 之间")
	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}
	
	@Length(min=0, max=64, message="建筑名称长度必须介于 0 和 64 之间")
	public String getBuildingName() {
		return buildingName;
	}

	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	
	@Length(min=0, max=10, message="层数长度必须介于 0 和 10 之间")
	public String getFloorNumber() {
		return floorNumber;
	}

	public void setFloorNumber(String floorNumber) {
		this.floorNumber = floorNumber;
	}
	
	@Length(min=0, max=20, message="使用面积长度必须介于 0 和 20 之间")
	public String getUseArea() {
		return useArea;
	}

	public void setUseArea(String useArea) {
		this.useArea = useArea;
	}
	
	@Length(min=0, max=100, message="使用情况长度必须介于 0 和 100 之间")
	public String getUsage1() {
		return usage1;
	}

	public void setUsage1(String usage1) {
		this.usage1 = usage1;
	}
	
	@Length(min=0, max=100, message="现有消防设施长度必须介于 0 和 100 之间")
	public String getDealfireFacilities() {
		return dealfireFacilities;
	}

	public void setDealfireFacilities(String dealfireFacilities) {
		this.dealfireFacilities = dealfireFacilities;
	}
	
	@Length(min=0, max=10, message="邮政编码长度必须介于 0 和 10 之间")
	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}
	
}