/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.scope.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.scope.entity.BusinessScope;
import com.thinkgem.jeesite.modules.scope.dao.BusinessScopeDao;

/**
 * 经营范围Service
 * @author xucaikai
 * @version 2017-10-16
 */
@Service
@Transactional(readOnly = true)
public class BusinessScopeService extends TreeService<BusinessScopeDao, BusinessScope> {

	public BusinessScope get(String id) {
		return super.get(id);
	}
	
	public List<BusinessScope> findList(BusinessScope businessScope) {
		if (StringUtils.isNotBlank(businessScope.getParentIds())){
			businessScope.setParentIds(","+businessScope.getParentIds()+",");
		}
		return super.findList(businessScope);
	}
	
	@Transactional(readOnly = false)
	public void save(BusinessScope businessScope) {
		super.save(businessScope);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusinessScope businessScope) {
		super.delete(businessScope);
	}
	
}