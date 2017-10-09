/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.certificate.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateInfo;
import com.thinkgem.jeesite.modules.certificate.service.CertificateInfoService;
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
 * 证照元数据Controller
 * @author xucaikai
 * @version 2017-09-28
 */
@Controller
@RequestMapping(value = "${adminPath}/certificate/certificateInfo")
public class CertificateInfoController extends BaseController {

	@Autowired
	private CertificateInfoService certificateInfoService;
	
	@ModelAttribute
	public CertificateInfo get(@RequestParam(required=false) String id) {
		CertificateInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = certificateInfoService.get(id);
		}
		if (entity == null){
			entity = new CertificateInfo();
		}
		return entity;
	}


	@RequiresPermissions("certificate:certificateInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(CertificateInfo certificateInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CertificateInfo> page = certificateInfoService.findPage(new Page<CertificateInfo>(request, response), certificateInfo); 
		model.addAttribute("page", page);
		return "modules/certificate/certificateInfoList";
	}

	@RequiresPermissions("certificate:certificateInfo:view")
	@RequestMapping(value = "form")
	public String form(CertificateInfo certificateInfo, Model model) {
		model.addAttribute("certificateInfo", certificateInfo);
		return "modules/certificate/certificateInfoForm";
	}

	@RequiresPermissions("certificate:certificateInfo:edit")
	@RequestMapping(value = "save")
	public String save(CertificateInfo certificateInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, certificateInfo)){
			return form(certificateInfo, model);
		}
		certificateInfoService.save(certificateInfo);
		addMessage(redirectAttributes, "保存证照元数据成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateInfo/?repage";
	}
	
	@RequiresPermissions("certificate:certificateInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(CertificateInfo certificateInfo, RedirectAttributes redirectAttributes) {
		certificateInfoService.delete(certificateInfo);
		addMessage(redirectAttributes, "删除证照元数据成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/certificateInfo/?repage";
	}

}