/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;

/**
 * 营业执照DAO接口
 * @author xucaikai
 * @version 2017-10-09
 */
@MyBatisDao
public interface BusinessLicenseDao extends CrudDao<BusinessLicense> {
	
}