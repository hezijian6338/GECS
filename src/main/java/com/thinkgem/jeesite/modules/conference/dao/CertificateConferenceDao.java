/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.conference.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.conference.entity.CertificateConference;

/**
 * 股东会议DAO接口
 * @author xucaikai
 * @version 2018-01-30
 */
@MyBatisDao
public interface CertificateConferenceDao extends CrudDao<CertificateConference> {

    public int updatePdfPath(CertificateConference certificateConference);
	
}