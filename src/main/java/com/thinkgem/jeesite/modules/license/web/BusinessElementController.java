/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.license.entity.BusinessElement;
import com.thinkgem.jeesite.modules.license.service.BusinessElementService;
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
 * 营业执照元素生成表Controller
 * @author hzj
 * @version 2017-11-17
 */
@Controller
@RequestMapping(value = "${adminPath}/license/businessElement")
public class BusinessElementController extends BaseController {

	@Autowired
	private BusinessElementService businessElementService;
	
	@ModelAttribute
	public BusinessElement get(@RequestParam(required=false) String id) {
		BusinessElement entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = businessElementService.get(id);
		}
		if (entity == null){
			entity = new BusinessElement();
		}
		return entity;
	}
	
	@RequiresPermissions("license:businessElement:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusinessElement businessElement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusinessElement> page = businessElementService.findPage(new Page<BusinessElement>(request, response), businessElement);
		model.addAttribute("page", page);
		return "modules/license/businessElementList";
	}

	@RequiresPermissions("license:businessElement:view")
	@RequestMapping(value = "form")
	public String form(BusinessElement businessElement, Model model) {
		model.addAttribute("businessElement", businessElement);
		return "modules/license/businessElementForm";
	}

	@RequestMapping(value = "makeModel")
	public String makeModel(BusinessElement businessElement, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusinessElement> page = businessElementService.findPage(new Page<BusinessElement>(request, response), businessElement);
		model.addAttribute("page", page);
		model.addAttribute("businessElement", businessElement);
		return "modules/license/makeModel";
	}

	@RequestMapping(value = "managerModel")
	public String managerModel(BusinessElement businessElement, Model model) {
		model.addAttribute("businessElement", businessElement);
		return "modules/license/managerModel";
	}

	@RequiresPermissions("license:businessElement:edit")
	@RequestMapping(value = "save")
	public String save(BusinessElement businessElement, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, businessElement)){
			return form(businessElement, model);
		}
		businessElementService.save(businessElement);
		addMessage(redirectAttributes, "保存营业执照元素生成表成功");
		return "redirect:"+Global.getAdminPath()+"/license/businessElement/?repage";
	}
	
	@RequiresPermissions("license:businessElement:edit")
	@RequestMapping(value = "delete")
	public String delete(BusinessElement businessElement, RedirectAttributes redirectAttributes) {
		businessElementService.delete(businessElement);
		addMessage(redirectAttributes, "删除营业执照元素生成表成功");
		return "redirect:"+Global.getAdminPath()+"/license/businessElement/?repage";
	}

}