package com.thinkgem.jeesite.modules.sign.dto;


/**
 * Created by bb on 2018/1/2.
 */
public class VerifyResultDTO {

	private String signer;//签章用户
	private String fileName;//文档标题
	private String signImage;//签章图片
	private String totalRevisions;//本文档共包含电子签章个数
	private String revisions;//签章序号
	private String isSignValid;//签章有效性
	private String signDate;//签章日期
	private String cerHolder;//证书持有人
	private String cerAuthority;//证书颁发机构
	private String cerDate;//证书有效期
	private String cerState;//签章所用证书当前状态
	private String cerReason;//签章原因
	private String cerLocation;//签章地点
	private String isDocumentUseful;//文档完整性
	
	public String getSigner() {
		return signer;
	}
	public void setSigner(String signer) {
		this.signer = signer;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getSignImage() {
		return signImage;
	}
	public void setSignImage(String signImage) {
		this.signImage = signImage;
	}
	public String getTotalRevisions() {
		return totalRevisions;
	}
	public void setTotalRevisions(String totalRevisions) {
		this.totalRevisions = totalRevisions;
	}
	public String getRevisions() {
		return revisions;
	}
	public void setRevisions(String revisions) {
		this.revisions = revisions;
	}
	public String getIsSignValid() {
		return isSignValid;
	}
	public void setIsSignValid(String isSignValid) {
		this.isSignValid = isSignValid;
	}
	public String getSignDate() {
		return signDate;
	}
	public void setSignDate(String signDate) {
		this.signDate = signDate;
	}
	public String getCerHolder() {
		return cerHolder;
	}
	public void setCerHolder(String cerHolder) {
		this.cerHolder = cerHolder;
	}
	public String getCerAuthority() {
		return cerAuthority;
	}
	public void setCerAuthority(String cerAuthority) {
		this.cerAuthority = cerAuthority;
	}
	public String getCerDate() {
		return cerDate;
	}
	public void setCerDate(String cerDate) {
		this.cerDate = cerDate;
	}
	public String getCerState() {
		return cerState;
	}
	public void setCerState(String cerState) {
		this.cerState = cerState;
	}
	public String getCerReason() {
		return cerReason;
	}
	public void setCerReason(String cerReason) {
		this.cerReason = cerReason;
	}
	public String getCerLocation() {
		return cerLocation;
	}
	public void setCerLocation(String cerLocation) {
		this.cerLocation = cerLocation;
	}
	public String getIsDocumentUseful() {
		return isDocumentUseful;
	}
	public void setIsDocumentUseful(String isDocumentUseful) {
		this.isDocumentUseful = isDocumentUseful;
	}

	@Override
	public String toString() {
		return "VerifyResultDTO{" +
				"signer='" + signer + '\'' +
				", fileName='" + fileName + '\'' +
				", signImage='" + signImage + '\'' +
				", totalRevisions='" + totalRevisions + '\'' +
				", revisions='" + revisions + '\'' +
				", isSignValid='" + isSignValid + '\'' +
				", signDate='" + signDate + '\'' +
				", cerHolder='" + cerHolder + '\'' +
				", cerAuthority='" + cerAuthority + '\'' +
				", cerDate='" + cerDate + '\'' +
				", cerState='" + cerState + '\'' +
				", cerReason='" + cerReason + '\'' +
				", cerLocation='" + cerLocation + '\'' +
				", isDocumentUseful=" + isDocumentUseful +
				'}';
	}
}
