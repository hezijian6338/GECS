/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.api.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import javax.validation.constraints.NotNull;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * API接口接入Entity
 * @author xucaikai
 * @version 2017-12-06
 */
public class ApiInterface extends DataEntity<ApiInterface> {
	
	private static final long serialVersionUID = 1L;
	private String company;		// 公司名称
	private String companytype;		// 公司类型
	private String appid;		// 用户编号
	private String appseceret;		// 用户密钥
	private String accesstoken;		// TOKEN
	private Date timeStamp;		// 时间戳
	private Date expiresIn;		// 过期时间
	private String man;		// 联系人
	private String phone;		// 联系电话
	
	public ApiInterface() {
		super();
	}

	public ApiInterface(String id){
		super(id);
	}

	@Length(min=1, max=255, message="公司名称长度必须介于 1 和 255 之间")
	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
	
	@Length(min=0, max=100, message="公司类型长度必须介于 0 和 100 之间")
	public String getCompanytype() {
		return companytype;
	}

	public void setCompanytype(String companytype) {
		this.companytype = companytype;
	}
	
	@Length(min=1, max=50, message="用户编号长度必须介于 1 和 50 之间")
	public String getAppid() {
		return appid;
	}

	public void setAppid(String appid) {
		this.appid = appid;
	}
	
	@Length(min=1, max=100, message="用户密钥长度必须介于 1 和 100 之间")
	public String getAppseceret() {
		return appseceret;
	}

	public void setAppseceret(String appseceret) {
		this.appseceret = appseceret;
	}
	
	@Length(min=1, max=100, message="TOKEN长度必须介于 1 和 100 之间")
	public String getAccesstoken() {
		return accesstoken;
	}

	public void setAccesstoken(String accesstoken) {
		this.accesstoken = accesstoken;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(Date timeStamp) {
		this.timeStamp = timeStamp;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@NotNull(message="过期时间不能为空")
	public Date getExpiresIn() {
		return expiresIn;
	}

	public void setExpiresIn(Date expiresIn) {
		this.expiresIn = expiresIn;
	}
	
	@Length(min=1, max=20, message="联系人长度必须介于 1 和 20 之间")
	public String getMan() {
		return man;
	}

	public void setMan(String man) {
		this.man = man;
	}
	
	@Length(min=1, max=20, message="联系电话长度必须介于 1 和 20 之间")
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}