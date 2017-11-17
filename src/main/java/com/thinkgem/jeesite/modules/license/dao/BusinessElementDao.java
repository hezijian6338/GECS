/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.license.entity.BusinessElement;

/**
 * 营业执照元素生成表DAO接口
 * @author hzj
 * @version 2017-11-17
 */
@MyBatisDao
public interface BusinessElementDao extends CrudDao<BusinessElement> {
	
}