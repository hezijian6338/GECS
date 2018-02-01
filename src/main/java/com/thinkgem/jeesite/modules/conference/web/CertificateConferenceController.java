/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.conference.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.persistence.Msg;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.conference.entity.CertificateConference;
import com.thinkgem.jeesite.modules.conference.service.CertificateConferenceService;

import java.util.List;

/**
 * 股东会议Controller
 * @author xucaikai
 * @version 2018-01-30
 */
@Controller
@RequestMapping(value = "${adminPath}/conference/certificateConference")
public class CertificateConferenceController extends BaseController {

	@Autowired
	private CertificateConferenceService certificateConferenceService;
	
	@ModelAttribute
	public CertificateConference get(@RequestParam(required=false) String id) {
		CertificateConference entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = certificateConferenceService.get(id);
		}
		if (entity == null){
			entity = new CertificateConference();
		}
		return entity;
	}
	
	@RequiresPermissions("conference:certificateConference:view")
	@RequestMapping(value = {"list", ""})
	public String list(CertificateConference certificateConference, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<CertificateConference> page = certificateConferenceService.findPage(new Page<CertificateConference>(request, response), certificateConference); 
		model.addAttribute("page", page);
		return "modules/conference/certificateConferenceList";
	}

	@RequiresPermissions("conference:certificateConference:view")
	@RequestMapping(value = "form")
	public String form(CertificateConference certificateConference, Model model) {
		model.addAttribute("certificateConference", certificateConference);
		return "modules/conference/certificateConferenceForm";
	}

	@RequiresPermissions("conference:certificateConference:edit")
	@RequestMapping(value = "save")
	public String save(CertificateConference certificateConference, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, certificateConference)){
			return form(certificateConference, model);
		}

		certificateConferenceService.save(certificateConference);

		CertificateConference certificateConference1 = certificateConferenceService.get(certificateConference);

		model.addAttribute("certificateConference1",certificateConference1);

		addMessage(redirectAttributes, "保存股东会议表成功");
		//return "redirect:"+Global.getAdminPath()+"/conference/certificateConference/?repage";
		return "modules/license/qpplyCertificate";
	}
	
	@RequiresPermissions("conference:certificateConference:edit")
	@RequestMapping(value = "delete")
	public String delete(CertificateConference certificateConference, RedirectAttributes redirectAttributes) {
		certificateConferenceService.delete(certificateConference);
		addMessage(redirectAttributes, "删除股东会议表成功");
		return "redirect:"+Global.getAdminPath()+"/conference/certificateConference/?repage";
	}

	/**
	 * @author 练浩文
	 * @TODO (注：certificateCode)
	 * @param title
	 * @DATE: 2017/11/2 8:56
	 */
	@ResponseBody
	@RequestMapping(value="/getPathByTitle/{title}",method= RequestMethod.POST)
	public Msg getBookPathByTitle(@PathVariable String title){
		CertificateConference certificateConference = new CertificateConference();
		certificateConference.setCompanyName(title);
		List <CertificateConference> listCertificateConference = certificateConferenceService.getPathByCompanyName(certificateConference);
		certificateConference = listCertificateConference.get(0);
		System.out.println("--------"+listCertificateConference.get(0).toString());
		return Msg.success().add("certificateConference",certificateConference);
	}

}