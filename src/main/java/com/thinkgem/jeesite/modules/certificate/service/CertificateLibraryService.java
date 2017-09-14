/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;
import com.thinkgem.jeesite.modules.certificate.dao.CertificateLibraryDao;

/**
 * 证照库管理Service
 * @author xucaikai
 * @version 2017-09-14
 */
@Service
@Transactional(readOnly = true)
public class CertificateLibraryService extends CrudService<CertificateLibraryDao, CertificateLibrary> {

	public CertificateLibrary get(String id) {
		return super.get(id);
	}
	
	public List<CertificateLibrary> findList(CertificateLibrary certificateLibrary) {
		return super.findList(certificateLibrary);
	}
	
	public Page<CertificateLibrary> findPage(Page<CertificateLibrary> page, CertificateLibrary certificateLibrary) {
		return super.findPage(page, certificateLibrary);
	}
	
	@Transactional(readOnly = false)
	public void save(CertificateLibrary certificateLibrary) {
		super.save(certificateLibrary);
	}
	
	@Transactional(readOnly = false)
	public void delete(CertificateLibrary certificateLibrary) {
		super.delete(certificateLibrary);
	}
	
}