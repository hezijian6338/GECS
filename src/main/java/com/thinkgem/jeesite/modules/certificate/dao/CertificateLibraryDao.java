/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;

/**
 * 证照库管理DAO接口
 * @author xucaikai
 * @version 2017-09-14
 */
@MyBatisDao
public interface CertificateLibraryDao extends CrudDao<CertificateLibrary> {
	
}