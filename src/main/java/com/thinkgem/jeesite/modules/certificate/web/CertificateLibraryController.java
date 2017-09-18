/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.web;

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
import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;
import com.thinkgem.jeesite.modules.certificate.service.CertificateLibraryService;

/**
 * 证照库管理Controller
 * @author xucaikai
 * @version 2017-09-18
 */
@Controller
@RequestMapping(value = "${adminPath}/certificate/certificateLibrary")
public class CertificateLibraryController extends BaseController {

	@Autowired
	private CertificateLibraryService certificateLibraryService;
	
	@ModelAttribute
	public CertificateLibrary get(@RequestParam(required=false) String id) {
		CertificateLibrary entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = certificateLibraryService.get(id);
		}
		if (entity == null){
			entity = new CertificateLibrary();
		}
		return entity;
	}
	
	@RequiresPermissions("certificate:certificateLibrary:view")
	@RequestMapping(value = {"list", ""})
	public String list(CertificateLibrary certificateLibrary, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CertificateLibrary> page = certificateLibraryService.findPage(new Page<CertificateLibrary>(request, response), certificateLibrary); 
		model.addAttribute("page", page);
		return "modules/certificate/certificateLibraryList";
	}

	@RequiresPermissions("certificate:certificateLibrary:view")
	@RequestMapping(value = "form")
	public String form(CertificateLibrary certificateLibrary, Model model) {
		model.addAttribute("certificateLibrary", certificateLibrary);
		return "modules/certificate/certificateLibraryForm";
	}

	@RequiresPermissions("certificate:certificateLibrary:edit")
	@RequestMapping(value = "save")
	public String save(CertificateLibrary certificateLibrary, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, certificateLibrary)){
			return form(certificateLibrary, model);
		}
		certificateLibraryService.save(certificateLibrary);
		addMessage(redirectAttributes, "保存证照库成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateLibrary/?repage";
	}
	
	@RequiresPermissions("certificate:certificateLibrary:edit")
	@RequestMapping(value = "delete")
	public String delete(CertificateLibrary certificateLibrary, RedirectAttributes redirectAttributes) {
		certificateLibraryService.delete(certificateLibrary);
		addMessage(redirectAttributes, "删除证照库成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateLibrary/?repage";
	}

}