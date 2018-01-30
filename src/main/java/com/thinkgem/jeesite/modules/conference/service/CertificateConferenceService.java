/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.conference.service;

import java.util.List;

import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.conference.entity.CertificateConference;
import com.thinkgem.jeesite.modules.conference.dao.CertificateConferenceDao;
import com.thinkgem.jeesite.modules.conference.entity.CertificateConferenceSub;
import com.thinkgem.jeesite.modules.conference.dao.CertificateConferenceSubDao;

/**
 * 股东会议Service
 * @author xucaikai
 * @version 2018-01-30
 */
@Service
@Transactional(readOnly = true)
public class CertificateConferenceService extends CrudService<CertificateConferenceDao, CertificateConference> {

	@Autowired
	private CertificateConferenceSubDao certificateConferenceSubDao;
	
	@Override
	public CertificateConference get(String id) {
		CertificateConference certificateConference = super.get(id);
		certificateConference.setCertificateConferenceSubList(certificateConferenceSubDao.findList(new CertificateConferenceSub(certificateConference)));
		return certificateConference;
	}
	
	@Override
	public List<CertificateConference> findList(CertificateConference certificateConference) {
		return super.findList(certificateConference);
	}
	
	@Override
	public Page<CertificateConference> findPage(Page<CertificateConference> page, CertificateConference certificateConference) {
		return super.findPage(page, certificateConference);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void save(CertificateConference certificateConference) {
		super.save(certificateConference);
		BusinessLicense businessLicense = (BusinessLicense) CacheUtils.get("businessLicense","businessLicense");
		final String path = "E:\\certificate\\BusinessModel\\有限公司章程.pdf";

		final String savaPath = "E:\\certificate\\Rules\\"+businessLicense.getCertificateName()+"\\"+businessLicense.getCertificateName()
				+"+有限公司章程"+".pdf";

		final String path2 = "E:\\certificate\\BusinessModel\\有限公司股东会决议.pdf";

		final String savaPath2 = "E:\\certificate\\conference\\"+businessLicense.getCertificateName()+"\\"+businessLicense.getCertificateName()
				+"+有限公司章程"+".pdf";

		FileUtils.createDirectory("E:\\certificate\\conference\\"+businessLicense.getCertificateName());

		FileUtils.createDirectory("E:\\certificate\\Rules\\"+businessLicense.getCertificateName());
		try {

			PDFUtil_rules.fillTemplate(businessLicense,certificateConference, path, savaPath);

			PDFUtil_conference.fillTemplate(certificateConference, path2, savaPath2);

		}catch (Exception E){
			E.printStackTrace();
		}

		for (CertificateConferenceSub certificateConferenceSub : certificateConference.getCertificateConferenceSubList()){
			if (certificateConferenceSub.getId() == null){
				continue;
			}
			if (CertificateConferenceSub.DEL_FLAG_NORMAL.equals(certificateConferenceSub.getDelFlag())){
				if (StringUtils.isBlank(certificateConferenceSub.getId())){
					certificateConferenceSub.setCertificateConference(certificateConference);
					certificateConferenceSub.preInsert();
					certificateConferenceSubDao.insert(certificateConferenceSub);
				}else{
					certificateConferenceSub.preUpdate();
					certificateConferenceSubDao.update(certificateConferenceSub);
				}
			}else{
				certificateConferenceSubDao.delete(certificateConferenceSub);
			}
		}
	}
	
	@Override
	@Transactional(readOnly = false)
	public void delete(CertificateConference certificateConference) {
		super.delete(certificateConference);
		certificateConferenceSubDao.delete(new CertificateConferenceSub(certificateConference));
	}
	
}