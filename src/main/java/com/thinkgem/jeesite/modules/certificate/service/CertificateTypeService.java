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
import com.thinkgem.jeesite.modules.certificate.entity.CertificateType;
import com.thinkgem.jeesite.modules.certificate.dao.CertificateTypeDao;

/**
 * 证照类型Service
 * @author xucaikai
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class CertificateTypeService extends CrudService<CertificateTypeDao, CertificateType> {

	@Autowired
	CertificateTypeDao certificateTypeDao;

	public CertificateType get(String id) {
		return super.get(id);
	}
	
	public List<CertificateType> findList(CertificateType certificateType) {
		return super.findList(certificateType);
	}
	
	public Page<CertificateType> findPage(Page<CertificateType> page, CertificateType certificateType) {
		return super.findPage(page, certificateType);
	}
	
	@Transactional(readOnly = false)
	public void save(CertificateType certificateType) {
		super.save(certificateType);
	}
	
	@Transactional(readOnly = false)
	public void delete(CertificateType certificateType) {
		super.delete(certificateType);
	}


}