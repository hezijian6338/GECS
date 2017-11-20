/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateTemplate;
import com.thinkgem.jeesite.modules.certificate.service.CertificateTemplateService;
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
import java.util.ArrayList;
import java.util.List;

/**
 * 证照模板管理Controller
 * @author xucaikai
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/certificate/certificateTemplate")
public class CertificateTemplateController extends BaseController {

	@Autowired
	private CertificateTemplateService certificateTemplateService;
	
	@ModelAttribute
	public CertificateTemplate get(@RequestParam(required=false) String id) {
		CertificateTemplate entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = certificateTemplateService.get(id);
		}
		if (entity == null){
			entity = new CertificateTemplate();
		}
		return entity;
	}
	
	@RequiresPermissions("certificate:certificateTemplate:view")
	@RequestMapping(value = {"list", ""})
	public String list(CertificateTemplate certificateTemplate, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CertificateTemplate> page = certificateTemplateService.findPage(new Page<CertificateTemplate>(request, response), certificateTemplate); 
		model.addAttribute("page", page);
		return "modules/certificate/certificateTemplateList";
	}

	@RequiresPermissions("certificate:certificateTemplate:view")
	@RequestMapping(value = "form")
	public String form(CertificateTemplate certificateTemplate, Model model) {
		model.addAttribute("certificateTemplate", certificateTemplate);
		return "modules/certificate/certificateTemplateForm";
	}

	@RequiresPermissions("certificate:certificateTemplate:view")
	@RequestMapping(value = "makeModel")
	public String makeModel(CertificateTemplate certificateTemplate, Model model) {
		List<String> list = new ArrayList<String>();
		list.add("test1");
		list.add("test2");
		model.addAttribute("certificateTemplate", certificateTemplate);
		model.addAttribute("list", list);
		return "modules/certificate/index";
	}

	@RequiresPermissions("certificate:certificateTemplate:view")
	@RequestMapping(value = "managerModel")
	public String managerModel(CertificateTemplate certificateTemplate, Model model) {
		model.addAttribute("certificateTemplate", certificateTemplate);
		return "modules/certificate/managerModel";
	}

	@RequiresPermissions("certificate:certificateTemplate:edit")
	@RequestMapping(value = "save")
	public String save(CertificateTemplate certificateTemplate, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, certificateTemplate)){
			return form(certificateTemplate, model);
		}
		certificateTemplateService.save(certificateTemplate);
		addMessage(redirectAttributes, "保存证照模板成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateTemplate/?repage";
	}
	
	@RequiresPermissions("certificate:certificateTemplate:edit")
	@RequestMapping(value = "delete")
	public String delete(CertificateTemplate certificateTemplate, RedirectAttributes redirectAttributes) {
		certificateTemplateService.delete(certificateTemplate);
		addMessage(redirectAttributes, "删除证照模板成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateTemplate/?repage";
	}

}