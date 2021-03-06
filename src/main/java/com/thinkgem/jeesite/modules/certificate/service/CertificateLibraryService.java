/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;
import com.thinkgem.jeesite.modules.certificate.dao.CertificateLibraryDao;

/**
 * 证照库管理Service
 * @author xucaikai
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class CertificateLibraryService extends CrudService<CertificateLibraryDao, CertificateLibrary> {
	@Autowired
	CertificateLibraryDao certificateLibraryDao;

	@Override
	public CertificateLibrary get(String id) {
		return super.get(id);
	}

	public CertificateLibrary getByCertificateCode(String certificateCode){
		return certificateLibraryDao.getByCertificateCode(certificateCode);
	}

	@Override
	public List<CertificateLibrary> findList(CertificateLibrary certificateLibrary) {
		return super.findList(certificateLibrary);
	}
	
	@Override
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

	public CertificateLibrary getByCertificateName(String certificateName){
		return certificateLibraryDao.getByCertificateName(certificateName);
	}
}