/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.scope.dao;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.scope.entity.BusinessScope;

/**
 * 经营范围DAO接口
 * @author xucaikai
 * @version 2017-10-16
 */
@MyBatisDao
public interface BusinessScopeDao extends TreeDao<BusinessScope> {
	
}