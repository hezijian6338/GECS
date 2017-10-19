/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;
import com.thinkgem.jeesite.modules.oa.entity.TestAudit;
import javafx.scene.input.DataFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.license.dao.BusinessLicenseDao;

/**
 * 营业执照Service
 * @author xucaikai
 * @version 2017-10-11
 */
@Service
@Transactional(readOnly = true)
public class BusinessLicenseService extends CrudService<BusinessLicenseDao, BusinessLicense> {

	@Autowired
	private ActTaskService actTaskService;

	public BusinessLicense get(String id) {
		return super.get(id);
	}
	
	public List<BusinessLicense> findList(BusinessLicense businessLicense) {
		return super.findList(businessLicense);
	}
	
	public Page<BusinessLicense> findPage(Page<BusinessLicense> page, BusinessLicense businessLicense) {
		return super.findPage(page, businessLicense);
	}
/**
 * @author 许彩开
 * @TODO (注：审核新增或编辑)
  * @param businessLicense
 * @DATE: 2017\10\11 0011 9:36
 */

	@Transactional(readOnly = false)
	public void save(BusinessLicense businessLicense) {
		DateFormat df = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		//申请发起
		if(StringUtils.isBlank(businessLicense.getId())){
			businessLicense.preInsert();
			dao.insert(businessLicense);

			//启动流程
			actTaskService.startProcess(ActUtils.PD_BUSINESS_LICENSE[0],ActUtils.PD_BUSINESS_LICENSE[1],businessLicense.getId(),businessLicense.getCertificateName()+"-"+df.format(businessLicense.getCreateDate()));
		}

		//重新编辑申请
		else{
			businessLicense.preUpdate();
			dao.update(businessLicense);

			businessLicense.getAct().setComment(("yes".equals(businessLicense.getAct().getFlag())?"[重申] ":"[销毁] ")+businessLicense.getAct().getComment());
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			vars.put("pass", "yes".equals(businessLicense.getAct().getFlag())? "1" : "0");

			actTaskService.complete(businessLicense.getAct().getTaskId(), businessLicense.getAct().getProcInsId(), businessLicense.getAct().getComment(), businessLicense.getCertificateName()+"-"+df.format(businessLicense.getCreateDate()), vars);
		}
	}


	/**
	 * 审核审批保存
	 * @param businessLicense
	 */
	@Transactional(readOnly = false)
	public void auditSave(BusinessLicense businessLicense) {

		// 设置意见
		businessLicense.getAct().setComment(("yes".equals(businessLicense.getAct().getFlag())?"[同意] ":"[驳回] ")+businessLicense.getAct().getComment());

		businessLicense.preUpdate();

		// 对不同环节的业务逻辑进行操作
		String taskDefKey = businessLicense.getAct().getTaskDefKey();

		// 审核环节
		if ("audit1".equals(taskDefKey)){
			businessLicense.setOpinion1(businessLicense.getAct().getComment());
			dao.updateOpinion1(businessLicense);
		}
		else if ("audit2".equals(taskDefKey)){
			businessLicense.setOpinion2(businessLicense.getAct().getComment());
			dao.updateOpinion2(businessLicense);
		}
		else if ("audit3".equals(taskDefKey)){
			businessLicense.setOpinion3(businessLicense.getAct().getComment());
			dao.updateOpinion3(businessLicense);
		}
		else if ("apply_end".equals(taskDefKey)){
			businessLicense.setOpinion4(businessLicense.getAct().getComment());
			dao.updateOpinion4(businessLicense);
		}

		// 未知环节，直接返回
		else{
			return;
		}

		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(businessLicense.getAct().getFlag())? "1" : "0");
		actTaskService.complete(businessLicense.getAct().getTaskId(), businessLicense.getAct().getProcInsId(), businessLicense.getAct().getComment(), vars);

	}
	
	@Transactional(readOnly = false)
	public void delete(BusinessLicense businessLicense) {
		super.delete(businessLicense);
	}
	
}