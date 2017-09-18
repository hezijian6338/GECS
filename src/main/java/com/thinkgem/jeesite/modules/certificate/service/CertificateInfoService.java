/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateInfo;
import com.thinkgem.jeesite.modules.certificate.dao.CertificateInfoDao;

/**
 * 证照元数据Service
 * @author xucaikai
 * @version 2017-09-18
 */
@Service
@Transactional(readOnly = true)
public class CertificateInfoService extends CrudService<CertificateInfoDao, CertificateInfo> {

	public CertificateInfo get(String id) {
		return super.get(id);
	}
	
	public List<CertificateInfo> findList(CertificateInfo certificateInfo) {
		return super.findList(certificateInfo);
	}
	
	public Page<CertificateInfo> findPage(Page<CertificateInfo> page, CertificateInfo certificateInfo) {
		return super.findPage(page, certificateInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(CertificateInfo certificateInfo) {
		super.save(certificateInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(CertificateInfo certificateInfo) {
		super.delete(certificateInfo);
	}
	
}