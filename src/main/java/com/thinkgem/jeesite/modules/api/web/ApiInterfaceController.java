/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.api.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.license.service.BusinessLicenseService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
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
import com.thinkgem.jeesite.modules.api.entity.ApiInterface;
import com.thinkgem.jeesite.modules.api.service.ApiInterfaceService;

/**
 * API接口接入Controller
 * @author xucaikai
 * @version 2017-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/api/apiInterface")
public class ApiInterfaceController extends BaseController {

	@Autowired
	private ApiInterfaceService apiInterfaceService;
	@Autowired
	private BusinessLicenseService businessLicenseService;
	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public ApiInterface get(@RequestParam(required=false) String id) {
		ApiInterface entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = apiInterfaceService.get(id);
		}
		if (entity == null){
			entity = new ApiInterface();
		}
		return entity;
	}
	
	@RequiresPermissions("api:apiInterface:view")
	@RequestMapping(value = {"list", ""})
	public String list(ApiInterface apiInterface, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ApiInterface> page = apiInterfaceService.findPage(new Page<ApiInterface>(request, response), apiInterface); 
		model.addAttribute("page", page);
		return "modules/api/apiInterfaceList";
	}

	@RequiresPermissions("api:apiInterface:view")
	@RequestMapping(value = "form")
	public String form(ApiInterface apiInterface, Model model) {
		model.addAttribute("apiInterface", apiInterface);
		return "modules/api/apiInterfaceForm";
	}

	@RequiresPermissions("api:apiInterface:edit")
	@RequestMapping(value = "save")
	public String save(ApiInterface apiInterface, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, apiInterface)){
			return form(apiInterface, model);
		}
		//随机生成用户编号
		apiInterface.setAppid((int)((Math.random()*9+1)*10000000)+"1");

		//保存token
		apiInterface.setAccesstoken((int)((Math.random()*9+1)*10000000)+businessLicenseService.getCharAndNumr(9));
		//加密
		String temp = systemService.entryptPassword(apiInterface.getAccesstoken());
		//随机生成用户密钥
		apiInterface.setAppseceret(temp);
		apiInterfaceService.save(apiInterface);
		addMessage(redirectAttributes, "保存API接口成功");
		return "redirect:"+Global.getAdminPath()+"/api/apiInterface/?repage";
	}
	
	@RequiresPermissions("api:apiInterface:edit")
	@RequestMapping(value = "delete")
	public String delete(ApiInterface apiInterface, RedirectAttributes redirectAttributes) {
		apiInterfaceService.delete(apiInterface);
		addMessage(redirectAttributes, "删除API接口成功");
		return "redirect:"+Global.getAdminPath()+"/api/apiInterface/?repage";
	}

}