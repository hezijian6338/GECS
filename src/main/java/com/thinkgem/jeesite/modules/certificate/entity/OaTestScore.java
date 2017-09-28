/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 学生分数修改申请审批Entity
 * @author xucaikai
 * @version 2017-09-26
 */
public class OaTestScore extends DataEntity<OaTestScore> {
	
	private static final long serialVersionUID = 1L;
	private String procInsId;		// 流程实例ID
	private String stuNo;		// 学号
	private String stuName;		// 姓名
	private String oldscore;		// 现在分数
	private String newscore;		// 调整分数
	private String content;		// 调整原因
	private String tText;		// 本门课程负责老师意见
	private String leadText;		// 辅导员意见
	
	public OaTestScore() {
		super();
	}

	public OaTestScore(String id){
		super(id);
	}

	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
	@Length(min=0, max=64, message="学号长度必须介于 0 和 64 之间")
	public String getStuNo() {
		return stuNo;
	}

	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}
	
	@Length(min=0, max=64, message="姓名长度必须介于 0 和 64 之间")
	public String getStuName() {
		return stuName;
	}

	public void setStuName(String stuName) {
		this.stuName = stuName;
	}
	
	@Length(min=0, max=64, message="现在分数长度必须介于 0 和 64 之间")
	public String getOldscore() {
		return oldscore;
	}

	public void setOldscore(String oldscore) {
		this.oldscore = oldscore;
	}
	
	@Length(min=0, max=64, message="调整分数长度必须介于 0 和 64 之间")
	public String getNewscore() {
		return newscore;
	}

	public void setNewscore(String newscore) {
		this.newscore = newscore;
	}
	
	@Length(min=0, max=255, message="调整原因长度必须介于 0 和 255 之间")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	@Length(min=0, max=255, message="本门课程负责老师意见长度必须介于 0 和 255 之间")
	public String getTText() {
		return tText;
	}

	public void setTText(String tText) {
		this.tText = tText;
	}
	
	@Length(min=0, max=255, message="辅导员意见长度必须介于 0 和 255 之间")
	public String getLeadText() {
		return leadText;
	}

	public void setLeadText(String leadText) {
		this.leadText = leadText;
	}
	
}