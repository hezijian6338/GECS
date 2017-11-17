/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.license.entity.BusinessElement;
import com.thinkgem.jeesite.modules.license.dao.BusinessElementDao;

/**
 * 营业执照元素生成表Service
 * @author hzj
 * @version 2017-11-17
 */
@Service
@Transactional(readOnly = true)
public class BusinessElementService extends CrudService<BusinessElementDao, BusinessElement> {

	public BusinessElement get(String id) {
		return super.get(id);
	}
	
	public List<BusinessElement> findList(BusinessElement businessElement) {
		return super.findList(businessElement);
	}
	
	public Page<BusinessElement> findPage(Page<BusinessElement> page, BusinessElement businessElement) {
		return super.findPage(page, businessElement);
	}
	
	@Transactional(readOnly = false)
	public void save(BusinessElement businessElement) {
		super.save(businessElement);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusinessElement businessElement) {
		super.delete(businessElement);
	}
	
}