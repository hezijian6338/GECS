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
import com.thinkgem.jeesite.modules.certificate.entity.OaTestScore;
import com.thinkgem.jeesite.modules.certificate.service.OaTestScoreService;

/**
 * 学生分数修改申请审批Controller
 * @author xucaikai
 * @version 2017-09-26
 */
@Controller
@RequestMapping(value = "${adminPath}/certificate/oaTestScore")
public class OaTestScoreController extends BaseController {

	@Autowired
	private OaTestScoreService oaTestScoreService;
	
	@ModelAttribute
	public OaTestScore get(@RequestParam(required=false) String id) {
		OaTestScore entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = oaTestScoreService.get(id);
		}
		if (entity == null){
			entity = new OaTestScore();
		}
		return entity;
	}
	
	@RequiresPermissions("certificate:oaTestScore:view")
	@RequestMapping(value = {"list", ""})
	public String list(OaTestScore oaTestScore, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<OaTestScore> page = oaTestScoreService.findPage(new Page<OaTestScore>(request, response), oaTestScore); 
		model.addAttribute("page", page);
		return "modules/certificate/oaTestScoreList";
	}

	@RequiresPermissions("certificate:oaTestScore:view")
	@RequestMapping(value = "form")
	public String form(OaTestScore oaTestScore, Model model) {
		model.addAttribute("oaTestScore", oaTestScore);
		return "modules/certificate/oaTestScoreForm";
	}

	@RequiresPermissions("certificate:oaTestScore:edit")
	@RequestMapping(value = "save")
	public String save(OaTestScore oaTestScore, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, oaTestScore)){
			return form(oaTestScore, model);
		}
		oaTestScoreService.save(oaTestScore);
		addMessage(redirectAttributes, "保存学生分数修改申请审批流程成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/oaTestScore/?repage";
	}
	
	@RequiresPermissions("certificate:oaTestScore:edit")
	@RequestMapping(value = "delete")
	public String delete(OaTestScore oaTestScore, RedirectAttributes redirectAttributes) {
		oaTestScoreService.delete(oaTestScore);
		addMessage(redirectAttributes, "删除学生分数修改申请审批流程成功");
		return "redirect:"+Global.getAdminPath()+"/certificate/oaTestScore/?repage";
	}

}