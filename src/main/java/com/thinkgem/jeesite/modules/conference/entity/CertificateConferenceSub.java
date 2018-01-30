/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.conference.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 股东会议Entity
 * @author xucaikai
 * @version 2018-01-30
 */
public class CertificateConferenceSub extends DataEntity<CertificateConferenceSub> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 股东姓名
	private String sex;		// 性别
	private String age;		// 年龄
	private String placeOrigin;		// 籍贯
	private String residence;		// 户口所在地
	private String currency;		// 以货币出资
	private String contributionType;		// 出资方式
	private String contributionPrice;		// 作价出资
	private String totalPrice;		// 总认缴出资
	private Date payTime;		// 资本缴足日期
	private CertificateConference certificateConference;		// 会议id 父类
	private String attendState;		// 参会状态
	private String fund;		// 出资金额
	private String sg;		// 资本占比
	private String position;		// 职位
	
	public CertificateConferenceSub() {
		super();
	}

	public CertificateConferenceSub(String id){
		super(id);
	}

	public CertificateConferenceSub(CertificateConference certificateConference){
		this.certificateConference = certificateConference;
	}

	@Length(min=0, max=25, message="股东姓名长度必须介于 0 和 25 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=10, message="性别长度必须介于 0 和 10 之间")
	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Length(min=0, max=10, message="年龄长度必须介于 0 和 10 之间")
	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
	
	@Length(min=0, max=64, message="籍贯长度必须介于 0 和 64 之间")
	public String getPlaceOrigin() {
		return placeOrigin;
	}

	public void setPlaceOrigin(String placeOrigin) {
		this.placeOrigin = placeOrigin;
	}
	
	@Length(min=0, max=255, message="住所长度必须介于 0 和 255 之间")
	public String getResidence() {
		return residence;
	}

	public void setResidence(String residence) {
		this.residence = residence;
	}
	
	@Length(min=0, max=64, message="以货币出资长度必须介于 0 和 64 之间")
	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	@Length(min=0, max=64, message="出资方式长度必须介于 0 和 64 之间")
	public String getContributionType() {
		return contributionType;
	}

	public void setContributionType(String contributionType) {
		this.contributionType = contributionType;
	}
	
	@Length(min=0, max=64, message="作价出资长度必须介于 0 和 64 之间")
	public String getContributionPrice() {
		return contributionPrice;
	}

	public void setContributionPrice(String contributionPrice) {
		this.contributionPrice = contributionPrice;
	}
	
	@Length(min=0, max=64, message="总认缴出资长度必须介于 0 和 64 之间")
	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
	
	@Length(min=1, max=64, message="会议id长度必须介于 1 和 64 之间")
	public CertificateConference getCertificateConference() {
		return certificateConference;
	}

	public void setCertificateConference(CertificateConference certificateConference) {
		this.certificateConference = certificateConference;
	}
	
	@Length(min=0, max=6, message="参会状态长度必须介于 0 和 6 之间")
	public String getAttendState() {
		return attendState;
	}

	public void setAttendState(String attendState) {
		this.attendState = attendState;
	}
	
	@Length(min=0, max=12, message="出资金额长度必须介于 0 和 12 之间")
	public String getFund() {
		return fund;
	}

	public void setFund(String fund) {
		this.fund = fund;
	}
	
	@Length(min=0, max=10, message="资本占比长度必须介于 0 和 10 之间")
	public String getSg() {
		return sg;
	}

	public void setSg(String sg) {
		this.sg = sg;
	}
	
	@Length(min=0, max=64, message="职位长度必须介于 0 和 64 之间")
	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}
	
}