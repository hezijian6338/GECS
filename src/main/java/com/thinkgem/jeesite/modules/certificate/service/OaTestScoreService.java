/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.certificate.entity.OaTestScore;
import com.thinkgem.jeesite.modules.certificate.dao.OaTestScoreDao;

/**
 * 学生分数修改申请审批Service
 * @author xucaikai
 * @version 2017-09-26
 */
@Service
@Transactional(readOnly = true)
public class OaTestScoreService extends CrudService<OaTestScoreDao, OaTestScore> {

	public OaTestScore get(String id) {
		return super.get(id);
	}
	
	public List<OaTestScore> findList(OaTestScore oaTestScore) {
		return super.findList(oaTestScore);
	}
	
	public Page<OaTestScore> findPage(Page<OaTestScore> page, OaTestScore oaTestScore) {
		return super.findPage(page, oaTestScore);
	}
	
	@Transactional(readOnly = false)
	public void save(OaTestScore oaTestScore) {
		super.save(oaTestScore);
	}
	
	@Transactional(readOnly = false)
	public void delete(OaTestScore oaTestScore) {
		super.delete(oaTestScore);
	}
	
}