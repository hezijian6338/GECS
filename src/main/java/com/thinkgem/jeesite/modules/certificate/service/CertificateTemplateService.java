/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateTemplate;
import com.thinkgem.jeesite.modules.certificate.dao.CertificateTemplateDao;

/**
 * 证照模板管理Service
 * @author xucaikai
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class CertificateTemplateService extends CrudService<CertificateTemplateDao, CertificateTemplate> {

	public CertificateTemplate get(String id) {
		return super.get(id);
	}
	
	public List<CertificateTemplate> findList(CertificateTemplate certificateTemplate) {
		return super.findList(certificateTemplate);
	}
	
	public Page<CertificateTemplate> findPage(Page<CertificateTemplate> page, CertificateTemplate certificateTemplate) {
		return super.findPage(page, certificateTemplate);
	}
	
	@Transactional(readOnly = false)
	public void save(CertificateTemplate certificateTemplate) {
		super.save(certificateTemplate);
	}
	
	@Transactional(readOnly = false)
	public void delete(CertificateTemplate certificateTemplate) {
		super.delete(certificateTemplate);
	}
	
}