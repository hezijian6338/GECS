/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.license.dao.BusinessLicenseDao;

/**
 * 营业执照Service
 * @author xucaikai
 * @version 2017-10-09
 */
@Service
@Transactional(readOnly = true)
public class BusinessLicenseService extends CrudService<BusinessLicenseDao, BusinessLicense> {

	public BusinessLicense get(String id) {
		return super.get(id);
	}
	
	public List<BusinessLicense> findList(BusinessLicense businessLicense) {
		return super.findList(businessLicense);
	}
	
	public Page<BusinessLicense> findPage(Page<BusinessLicense> page, BusinessLicense businessLicense) {
		return super.findPage(page, businessLicense);
	}
	
	@Transactional(readOnly = false)
	public void save(BusinessLicense businessLicense) {
		super.save(businessLicense);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusinessLicense businessLicense) {
		super.delete(businessLicense);
	}
	
}