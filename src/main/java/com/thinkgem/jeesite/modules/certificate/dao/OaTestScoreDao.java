/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.certificate.entity.OaTestScore;

/**
 * 学生分数修改申请审批DAO接口
 * @author xucaikai
 * @version 2017-09-26
 */
@MyBatisDao
public interface OaTestScoreDao extends CrudDao<OaTestScore> {
	
}