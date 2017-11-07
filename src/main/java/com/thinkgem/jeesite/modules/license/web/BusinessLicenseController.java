/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.DocumentException;
import com.thinkgem.jeesite.common.persistence.Msg;
import com.thinkgem.jeesite.common.utils.PDFUtil;
import com.thinkgem.jeesite.common.utils.SendMailUtil;
import com.thinkgem.jeesite.modules.act.entity.Act;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateType;
import com.thinkgem.jeesite.modules.certificate.service.CertificateLibraryService;
import com.thinkgem.jeesite.modules.certificate.service.CertificateTypeService;
import com.thinkgem.jeesite.modules.oa.dao.OaNotifyRecordDao;
import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.commons.lang3.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.license.service.BusinessLicenseService;

import java.io.IOException;
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

		String path = "E:\\certificate\\BusinessModel\\BusinessModel.pdf";
		String savaPath = "E:\\certificate\\Business\\"+businessLicense.getCertificateName()+businessLicense.getPersonId()+".pdf";
		String realativePath = "/pic/certificate/Business/"+businessLicense.getCertificateName()+businessLicense.getPersonId()+".pdf";
		String view = "businessLicenseForm";
		CertificateLibrary certificateLibrary = new CertificateLibrary();

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
//				System.out.println("+++++++"+certificateLibrary);
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

//				User user = systemService.getUser(businessLicense.getPersonId());
//				addMessage(redirectAttributes,"成功生成营业执照");
//				String sendMessage="亲爱的"+businessLicense.getPersionName()+"!您申请的营业执照已通过审核并生成，请到www.runcheng.com查阅";
//				String emailAddr = businessLicense.getPersionPhone();
//				SendMailUtil.sendCommonMail(emailAddr,"执照生成通知",sendMessage);

			PDFUtil.fillTemplate(businessLicense,path,savaPath);


			certificateLibrary.setCertificateCode(businessLicense.getCertificateCode());
			certificateLibrary.setCertificateTypeId(businessLicense.getCertificateTypeId());
			certificateLibrary.setCertificateName(businessLicense.getCertificateName());
			certificateLibrary.setArea(businessLicense.getArea());
			certificateLibrary.setDownloadsNum("0");
			certificateLibrary.setEffectiveDateEnd(businessLicense.getEffectiveDateEnd());
			certificateLibrary.setEffectiveDateStart(businessLicense.getEffectiveDateStar());
			certificateLibrary.setOffice(businessLicense.getOffice());
			certificateLibrary.setPath(realativePath);
			certificateLibraryService.save(certificateLibrary);
				//保存在通告表中
			businessLicense.setPath(realativePath);
			businessLicense.setStatus("审核通过");
			businessLicenseService.update(businessLicense);

			OaNotify oaNotify=new OaNotify();
			oaNotify.setContent(businessLicense.getId());
			oaNotify.setStatus("审核通过");
			oaNotify.setFiles(realativePath);
			oaNotifyService.updateStatus(oaNotify);
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


		addMessage(redirectAttributes, "保存营业执照成功");

		return "redirect:" + adminPath + "/oa/oaNotify/?repage";

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
		businessLicenseService.auditSave(businessLicense);
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
		System.out.println("---------"+certificateName);
		CertificateLibrary certificateLibrary = certificateLibraryService.getByCertificateName(certificateName);
		System.out.println("------------========="+certificateLibrary);
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



}