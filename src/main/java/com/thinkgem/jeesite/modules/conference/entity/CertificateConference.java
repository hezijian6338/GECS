/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.conference.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.List;
import com.google.common.collect.Lists;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 股东会议Entity
 * @author xucaikai
 * @version 2018-01-30
 */
public class CertificateConference extends DataEntity<CertificateConference> {
	
	private static final long serialVersionUID = 1L;
	private String conferenceType;		// 会议类型
	private String companyName;		// 公司名称
	private String conferenceInformType;		// 通知方式
	private Date conferenceInformTime;		// 通知时间
	private String companyAddr;		// 公司地址
	private String manageAddr;		// 经营场所
	private String registerFund;		// 注册资本
	private Date conferenceTime;		// 会议时间
	private Date concludeDate;		// 章程订立日期
	private String conferenceAddr;		// 会议地址
	private String setDirectors;		// 是否设立董事会
	private String rulesPdfpath;		// 章程pdf路径
	private String meetingPafpath;		// 会议决议pdf路径
	private List<CertificateConferenceSub> certificateConferenceSubList = Lists.newArrayList();		// 子表列表
	
	public CertificateConference() {
		super();
	}

	public CertificateConference(String id){
		super(id);
	}

	@Length(min=0, max=24, message="会议类型长度必须介于 0 和 24 之间")
	public String getConferenceType() {
		return conferenceType;
	}

	public void setConferenceType(String conferenceType) {
		this.conferenceType = conferenceType;
	}
	
	@Length(min=0, max=40, message="公司名称长度必须介于 0 和 40 之间")
	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	
	@Length(min=0, max=64, message="通知方式长度必须介于 0 和 64 之间")
	public String getConferenceInformType() {
		return conferenceInformType;
	}

	public void setConferenceInformType(String conferenceInformType) {
		this.conferenceInformType = conferenceInformType;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getConferenceInformTime() {
		return conferenceInformTime;
	}

	public void setConferenceInformTime(Date conferenceInformTime) {
		this.conferenceInformTime = conferenceInformTime;
	}
	
	@Length(min=0, max=120, message="公司地址长度必须介于 0 和 120 之间")
	public String getCompanyAddr() {
		return companyAddr;
	}

	public void setCompanyAddr(String companyAddr) {
		this.companyAddr = companyAddr;
	}
	
	@Length(min=0, max=120, message="经营场所长度必须介于 0 和 120 之间")
	public String getManageAddr() {
		return manageAddr;
	}

	public void setManageAddr(String manageAddr) {
		this.manageAddr = manageAddr;
	}
	
	@Length(min=0, max=12, message="注册资本长度必须介于 0 和 12 之间")
	public String getRegisterFund() {
		return registerFund;
	}

	public void setRegisterFund(String registerFund) {
		this.registerFund = registerFund;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getConferenceTime() {
		return conferenceTime;
	}

	public void setConferenceTime(Date conferenceTime) {
		this.conferenceTime = conferenceTime;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getConcludeDate() {
		return concludeDate;
	}

	public void setConcludeDate(Date concludeDate) {
		this.concludeDate = concludeDate;
	}
	
	@Length(min=0, max=255, message="会议地址长度必须介于 0 和 255 之间")
	public String getConferenceAddr() {
		return conferenceAddr;
	}

	public void setConferenceAddr(String conferenceAddr) {
		this.conferenceAddr = conferenceAddr;
	}
	
	@Length(min=0, max=6, message="是否设立董事会长度必须介于 0 和 6 之间")
	public String getSetDirectors() {
		return setDirectors;
	}

	public void setSetDirectors(String setDirectors) {
		this.setDirectors = setDirectors;
	}
	
	@Length(min=0, max=255, message="章程pdf路径长度必须介于 0 和 255 之间")
	public String getRulesPdfpath() {
		return rulesPdfpath;
	}

	public void setRulesPdfpath(String rulesPdfpath) {
		this.rulesPdfpath = rulesPdfpath;
	}
	
	@Length(min=0, max=255, message="会议决议pdf路径长度必须介于 0 和 255 之间")
	public String getMeetingPafpath() {
		return meetingPafpath;
	}

	public void setMeetingPafpath(String meetingPafpath) {
		this.meetingPafpath = meetingPafpath;
	}
	
	public List<CertificateConferenceSub> getCertificateConferenceSubList() {
		return certificateConferenceSubList;
	}

	public void setCertificateConferenceSubList(List<CertificateConferenceSub> certificateConferenceSubList) {
		this.certificateConferenceSubList = certificateConferenceSubList;
	}
}