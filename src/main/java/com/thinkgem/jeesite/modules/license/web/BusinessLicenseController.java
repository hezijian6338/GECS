/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.license.service.BusinessLicenseService;

/**
 * 营业执照Controller
 * @author xucaikai
 * @version 2017-10-09
 */
@Controller
@RequestMapping(value = "${adminPath}/license/businessLicense")
public class BusinessLicenseController extends BaseController {

	@Autowired
	private BusinessLicenseService businessLicenseService;
	
	@ModelAttribute
	public BusinessLicense get(@RequestParam(required=false) String id) {
		BusinessLicense entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = businessLicenseService.get(id);
		}
		if (entity == null){
			entity = new BusinessLicense();
		}
		return entity;
	}
	
	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusinessLicense businessLicense, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusinessLicense> page = businessLicenseService.findPage(new Page<BusinessLicense>(request, response), businessLicense); 
		model.addAttribute("page", page);
		return "modules/license/businessLicenseList";
	}

	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = "form")
	public String form(BusinessLicense businessLicense, Model model) {
		model.addAttribute("businessLicense", businessLicense);
		return "modules/license/businessLicenseForm";
	}

	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "save")
	public String save(BusinessLicense businessLicense, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, businessLicense)){
			return form(businessLicense, model);
		}
		businessLicenseService.save(businessLicense);
		addMessage(redirectAttributes, "保存营业执照成功");
		return "redirect:"+Global.getAdminPath()+"/license/businessLicense/?repage";
	}
	
	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "delete")
	public String delete(BusinessLicense businessLicense, RedirectAttributes redirectAttributes) {
		businessLicenseService.delete(businessLicense);
		addMessage(redirectAttributes, "删除营业执照成功");
		return "redirect:"+Global.getAdminPath()+"/license/businessLicense/?repage";
	}

}