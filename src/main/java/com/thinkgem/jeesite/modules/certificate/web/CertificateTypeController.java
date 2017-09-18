/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateType;
import com.thinkgem.jeesite.modules.certificate.service.CertificateTypeService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 证照类型Controller
 * @author xucaikai
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/certificate/certificateType")
public class CertificateTypeController extends BaseController {

	@Autowired
	private CertificateTypeService certificateTypeService;
	
	@ModelAttribute
	public CertificateType get(@RequestParam(required=false) String id) {
		CertificateType entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = certificateTypeService.get(id);
		}
		if (entity == null){
			entity = new CertificateType();
		}
		return entity;
	}
	
	@RequiresPermissions("certificate:certificateType:view")
	@RequestMapping(value = {"list", ""})
	public String list(CertificateType certificateType, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CertificateType> page = certificateTypeService.findPage(new Page<CertificateType>(request, response), certificateType); 
		model.addAttribute("page", page);
		return "modules/certificate/certificateTypeList";
	}


	@RequiresPermissions("certificate:certificateType:view")
	@RequestMapping(value = "form")
	public String form(CertificateType certificateType, Model model) {
		model.addAttribute("certificateType", certificateType);
		return "modules/certificate/certificateTypeForm";
	}

	@RequiresPermissions("certificate:certificateType:edit")
	@RequestMapping(value = "save")
	public String save(CertificateType certificateType, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, certificateType)){
			return form(certificateType, model);
		}
		certificateTypeService.save(certificateType);
		addMessage(redirectAttributes, "保存证照类型成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateType/?repage";
	}
	
	@RequiresPermissions("certificate:certificateType:edit")
	@RequestMapping(value = "delete")
	public String delete(CertificateType certificateType, RedirectAttributes redirectAttributes) {
		certificateTypeService.delete(certificateType);
		addMessage(redirectAttributes, "删除证照类型成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateType/?repage";
	}

}