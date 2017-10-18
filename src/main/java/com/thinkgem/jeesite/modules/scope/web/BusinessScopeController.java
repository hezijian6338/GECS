/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.scope.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.scope.entity.BusinessScope;
import com.thinkgem.jeesite.modules.scope.service.BusinessScopeService;

/**
 * 经营范围Controller
 * @author xucaikai
 * @version 2017-10-16
 */
@Controller
@RequestMapping(value = "${adminPath}/scope/businessScope")
public class BusinessScopeController extends BaseController {

	@Autowired
	private BusinessScopeService businessScopeService;
	
	@ModelAttribute
	public BusinessScope get(@RequestParam(required=false) String id) {
		BusinessScope entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = businessScopeService.get(id);
		}
		if (entity == null){
			entity = new BusinessScope();
		}
		return entity;
	}
	
	@RequiresPermissions("scope:businessScope:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusinessScope businessScope, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<BusinessScope> list = businessScopeService.findList(businessScope); 
		model.addAttribute("list", list);
		return "modules/scope/businessScopeList";
	}

	@RequiresPermissions("scope:businessScope:view")
	@RequestMapping(value = "form")
	public String form(BusinessScope businessScope, Model model) {
		if (businessScope.getParent()!=null && StringUtils.isNotBlank(businessScope.getParent().getId())){
			businessScope.setParent(businessScopeService.get(businessScope.getParent().getId()));
			// 获取排序号，最末节点排序号+30
			if (StringUtils.isBlank(businessScope.getId())){
				BusinessScope businessScopeChild = new BusinessScope();
				businessScopeChild.setParent(new BusinessScope(businessScope.getParent().getId()));
				List<BusinessScope> list = businessScopeService.findList(businessScope); 
				if (list.size() > 0){
					businessScope.setSort(list.get(list.size()-1).getSort());
					if (businessScope.getSort() != null){
						businessScope.setSort(businessScope.getSort() + 30);
					}
				}
			}
		}
		if (businessScope.getSort() == null){
			businessScope.setSort(30);
		}
		model.addAttribute("businessScope", businessScope);
		return "modules/scope/businessScopeForm";
	}

	@RequiresPermissions("scope:businessScope:edit")
	@RequestMapping(value = "save")
	public String save(BusinessScope businessScope, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, businessScope)){
			return form(businessScope, model);
		}
		businessScopeService.save(businessScope);
		addMessage(redirectAttributes, "保存经营范围成功");
		return "redirect:"+Global.getAdminPath()+"/scope/businessScope/?repage";
	}
	
	@RequiresPermissions("scope:businessScope:edit")
	@RequestMapping(value = "delete")
	public String delete(BusinessScope businessScope, RedirectAttributes redirectAttributes) {
		businessScopeService.delete(businessScope);
		addMessage(redirectAttributes, "删除经营范围成功");
		return "redirect:"+Global.getAdminPath()+"/scope/businessScope/?repage";
	}

	@RequiresPermissions("user")
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<BusinessScope> list = businessScopeService.findList(new BusinessScope());
		for (int i=0; i<list.size(); i++){
			BusinessScope e = list.get(i);
			if (StringUtils.isBlank(extId) || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParentId());
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
}