/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.web;

import com.aliyuncs.exceptions.ClientException;
import com.itextpdf.text.DocumentException;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Msg;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.FileUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateType;
import com.thinkgem.jeesite.modules.certificate.service.CertificateLibraryService;
import com.thinkgem.jeesite.modules.certificate.service.CertificateTypeService;
import com.thinkgem.jeesite.modules.conference.entity.CertificateConference;
import com.thinkgem.jeesite.modules.conference.service.CertificateConferenceService;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.license.service.BusinessLicenseService;
import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.groovy.runtime.powerassert.SourceText;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;


/**
 * 营业执照Controller
 * @author xucaikai
 * @version 2017-10-11
 */
@Controller
@RequestMapping(value = "${adminPath}/license/businessLicense")
public class BusinessLicenseController extends BaseController {

	@Autowired
	private OaNotifyService oaNotifyService;

	@Autowired
	private BusinessLicenseService businessLicenseService;

	@Autowired
	private CertificateTypeService certificateTypeService;

	@Autowired
	private CertificateLibraryService certificateLibraryService;

	@Autowired
	private CertificateConferenceService certificateConferenceService;

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

	/**
	 * @author YuXiaoXi
	 * @TODO (注：跳转用户申请证照界面)

	 * @DATE: 2017/10/18 16:21
	 */
	@RequestMapping(value = "apply")
	public String apply(User user, BusinessLicense businessLicense, Model model) {
		return "modules/license/qpplyCertificate";
	}
	
	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusinessLicense businessLicense, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			businessLicense.setCreateBy(user);
		}
        Page<BusinessLicense> page = businessLicenseService.findPage(new Page<BusinessLicense>(request, response), businessLicense);
        model.addAttribute("page", page);
		return "modules/license/businessLicenseList";
	}

	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = "form")
	public String form(BusinessLicense businessLicense, Model model) throws IOException, DocumentException {
		String view = "businessLicenseForm";
		//查看审批申请单
		if(StringUtils.isNotBlank(businessLicense.getId())){
			//环节编号
			String taskDefKey = businessLicense.getAct().getTaskDefKey();

			//查看工单
			if(businessLicense.getAct().isFinishTask()){
				view = "businessLicenseView";
			}
			//修改环节
			else if("modify".equals(taskDefKey)){
				view = "businessLicenseForm";
			}
			/*// 审核环节
			else if ("audit".equals(taskDefKey)){
				view = "businessLicenseAudit";
			}*/
			// 审核环节2
			else if ("audit1".equals(taskDefKey)){
				view = "businessLicenseAudit";
			}
			// 审核环节3
			else if ("audit2".equals(taskDefKey)){
				view = "businessLicenseAudit";
			}
			//审核环节4
			else if ("audit3".equals(taskDefKey)){
				view = "businessLicenseAudit";
			}
			// 兑现环节
			else if ("apply_end".equals(taskDefKey)){
			view = "businessLicenseAudit";
			}
		}
		model.addAttribute("businessLicense", businessLicense);
		return "modules/license/"+view;
	}

	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "save")
	public String save(BusinessLicense businessLicense, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request) throws IOException, DocumentException {
		if (!beanValidator(model, businessLicense)){
			return form(businessLicense, model);
		}
		String radio=request.getParameter("bt1");
		businessLicense.setRegisteredCapital(businessLicense.getRegisteredCapital()+radio);
		businessLicense.setStatus("审核中");

		//保存在通告表中
		OaNotify oaNotify=new OaNotify();
		DateFormat df = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");

		businessLicenseService.save(businessLicense);
		oaNotify.setType(businessLicense.getCertificateTypeName());
		oaNotify.setTitle(businessLicense.getCertificateName()+"-"+df.format(businessLicense.getCreateDate()));

		//将business_license的id存在content里
		oaNotify.setContent(businessLicense.getId());

		oaNotify.setStatus("审核中");
		oaNotify.setReadNum("1");
		oaNotify.setOaNotifyRecordIds(UserUtils.getUser().getId());
		oaNotify.setSelf(true);
		System.out.println("------"+oaNotify);
		oaNotifyService.save(oaNotify);

		//传CertificateConference
		CertificateConference certificateConference = new CertificateConference();

		certificateConference.setCompanyName(businessLicense.getCertificateName());

		model.addAttribute("certificateConference", certificateConference);

		addMessage(redirectAttributes, "保存营业执照成功");

		//return "redirect:" + adminPath + "/oa/oaNotify/self?repage";
		//return "redirect:" + adminPath +"/conference/certificateConference/form?repage";
		return "modules/conference/certificateConferenceForm";

	}


	/**
	 * 工单执行（完成任务）
	 * @param businessLicense
	 * @param model
	 * @return
	 */
	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "saveAudit")
	public String saveAudit(BusinessLicense businessLicense, Model model) throws IOException, DocumentException {
		if (StringUtils.isBlank(businessLicense.getAct().getFlag())
				|| StringUtils.isBlank(businessLicense.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(businessLicense, model);
		}
		try {
			businessLicenseService.auditSave(businessLicense);
		} catch (ClientException e) {
			e.printStackTrace();
		}
		return "redirect:" + adminPath + "/act/task/todo/";
	}


	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "delete")
	public String delete(BusinessLicense businessLicense, RedirectAttributes redirectAttributes) {
		businessLicenseService.delete(businessLicense);
		addMessage(redirectAttributes, "删除营业执照成功");
		return "redirect:"+Global.getAdminPath()+"/license/businessLicense/?repage";
	}



	/**
	 * @author 练浩文
	 * @TODO (注：certificateCode)
	  * @param certificateCode
	 * @DATE: 2017/11/2 8:56
	 */
	@ResponseBody
	@RequestMapping(value="/getPath/{certificateCode}",method= RequestMethod.GET)
	public Msg getPath(@PathVariable String certificateCode){
		CertificateLibrary certificateLibrary = certificateLibraryService.getByCertificateCode(certificateCode);
		return Msg.success().add("certificateLibrary",certificateLibrary);
	}

	/**
	 * @author 练浩文
	 * @TODO (注：certificateCode)
	 * @param title
	 * @DATE: 2017/11/2 8:56
	 */
	@ResponseBody
	@RequestMapping(value="/getPathByTitle/{title}",method= RequestMethod.GET)
	public Msg getPathByTitle(@PathVariable String title){
		String certificateName = title.substring(0,title.indexOf("-"));
		CertificateLibrary certificateLibrary = certificateLibraryService.getByCertificateName(certificateName);
		return Msg.success().add("certificateLibrary",certificateLibrary);
	}

	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "testJump")
	public String testJump(BusinessLicense businessLicense, RedirectAttributes redirectAttributes ) {
		return "modules/license/testJump";
	}

	/**
	 * @author 练浩文
	 * @TODO (注：)

	 * @DATE: 2017/10/23 11:03
	 */
	@RequiresPermissions("license:businessLicense:edit")
	@RequestMapping(value = "applyBusinessLicense")
	public String testJump(String typeName,Model model) {
		typeName = "营业执照";
		BusinessLicense businessLicense = new BusinessLicense();
		CertificateType certificateType = certificateTypeService.getTypeByName(typeName);
		businessLicense.setCertificateCode((int)((Math.random()*9+1)*10000000)+businessLicenseService.getCharAndNumr(9)+(int)((Math.random()*9+1)*1));
		businessLicense.setCertificateTypeName(certificateType.getCertificateTypeName());
        //设置证照成立日期、有效起始日期，有效截止日期
        Date startDate = new Date();
        Date endDate = new Date();
        Calendar calendar=new GregorianCalendar();
        calendar.setTime(startDate);
        int yearAdd=Integer.parseInt(certificateType.getEffectiveDate());
        calendar.add(calendar.YEAR,yearAdd);
        endDate=calendar.getTime();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        businessLicense.setEstablishDate(startDate);
        businessLicense.setEffectiveDateStar(startDate);
        businessLicense.setEffectiveDateEnd(endDate);
        System.out.println(dateFormat.format(startDate));
        System.out.println(dateFormat.format(endDate));
        businessLicense.setCertificateTypeName(certificateType.getCertificateTypeName());
		businessLicense.setCertificateTypeId(certificateType.getId());
		businessLicense.setOffice(certificateType.getOffice());
		model.addAttribute("businessLicense", businessLicense);
		return "modules/license/businessLicenseForm";
	}

    /**
     * @author 练浩文
     * @TODO (注:公司名字校验，如果已经有了则显示已被注册)
     * @param certificateName
     * @DATE: 2017/11/15 15:34
     */
	@ResponseBody
	@RequestMapping(value = "checkCertificateName")
	public String checkCertificateName(String certificateName){

		String realCertifcateName = certificateName.substring(0);
		System.out.println("真实公司名称=="+realCertifcateName);
		List<BusinessLicense> list = businessLicenseService.getByCertificateName(realCertifcateName);

		if (list.size()>0){
			return "false";
		}else {
			return "true";
		}
	}

	/**
	 * @author 练浩文
	 * @TODO (注：下载)
	 * @param certificateName
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @DATE: 2017/11/20 17:57
	 */
	@RequestMapping(value = "downLoad")
	public void downLoad(String certificateName,HttpServletRequest request,HttpServletResponse response,RedirectAttributes redirectAttributes){
		String savaPath = "C:\\certificate\\Business";
		String isExsitFile = "C:\\certificate\\Business\\"+certificateName;
		String downLoadPath = "C:\\certificate\\Business\\"+certificateName+".zip";
		File file = new File(isExsitFile);
		System.out.println("文件是否存在==="+file.exists());
		if (file.exists()){
			FileUtils.zipFiles(savaPath,certificateName,downLoadPath);
			File file1 = new File(downLoadPath);
			FileUtils.downFile(file1,request,response,certificateName +".zip");
		} else{
			try {
				PrintWriter out = response.getWriter();
				out.println("<script Language='JavaScript'>");
				out.println("alert(\"证照还未生成！无法下载！！！\");");
				out.println("history.back();");
				out.println("</script>");

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
//		return "redirect:"+Global.getAdminPath()+"/license/businessLicense/?repage";
	}

/**
 * @author 许彩开
 * @TODO (注：变更列表)
  * @param businessLicense
 * @DATE: 2018\2\5 0005 9:21
 */

	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = {"changeList"})
	public String changeList(BusinessLicense businessLicense, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			businessLicense.setCreateBy(user);
		}
		Page<BusinessLicense> page = businessLicenseService.findPage(new Page<BusinessLicense>(request, response), businessLicense);
		model.addAttribute("page", page);
		return "modules/conference/businessLicense_change_List";
	}


	/**
	 * @author 许彩开
	 * @TODO (注：注销列表)
	 * @param businessLicense
	 * @DATE: 2018\2\5 0005 9:21
	 */

	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = {"cancelList"})
	public String cancelList(BusinessLicense businessLicense, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			businessLicense.setCreateBy(user);
		}
		Page<BusinessLicense> page = businessLicenseService.findPage(new Page<BusinessLicense>(request, response), businessLicense);
		model.addAttribute("page", page);
		return "modules/conference/businessLicense_cancel_List";
	}

	/**
	 * @author 许彩开
	 * @TODO (注：备案列表)
	 * @param businessLicense
	 * @DATE: 2018\2\5 0005 9:21
	 */

	@RequiresPermissions("license:businessLicense:view")
	@RequestMapping(value = {"recordList"})
	public String recordList(BusinessLicense businessLicense, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		if (!user.isAdmin()){
			businessLicense.setCreateBy(user);
		}
		Page<BusinessLicense> page = businessLicenseService.findPage(new Page<BusinessLicense>(request, response), businessLicense);
		model.addAttribute("page", page);
		return "modules/conference/businessLicense_record_List";
	}

}