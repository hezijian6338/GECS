/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;

import java.util.List;

/**
 * 营业执照DAO接口
 * @author xucaikai
 * @version 2017-10-11
 */
@MyBatisDao
public interface BusinessLicenseDao extends CrudDao<BusinessLicense> {

    public int updateOpinion1(BusinessLicense businessLicense);

    public int updateOpinion2(BusinessLicense businessLicense);

    public int updateOpinion3(BusinessLicense businessLicense);

    public int updateOpinion4(BusinessLicense businessLicense);

    List<BusinessLicense> getByCertificateName(String certificateName);
}