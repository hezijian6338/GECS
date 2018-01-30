/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.license.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.aliyuncs.exceptions.ClientException;
import com.google.common.collect.Maps;
import com.itextpdf.text.DocumentException;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.modules.act.service.ActTaskService;
import com.thinkgem.jeesite.modules.act.utils.ActUtils;

import com.thinkgem.jeesite.modules.certificate.entity.CertificateLibrary;
import com.thinkgem.jeesite.modules.certificate.service.CertificateLibraryService;
import com.thinkgem.jeesite.modules.certificate.service.CertificateTypeService;
import com.thinkgem.jeesite.modules.oa.entity.OaNotify;
import com.thinkgem.jeesite.modules.oa.service.OaNotifyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.license.dao.BusinessLicenseDao;

/**
 * 营业执照Service
 * @author xucaikai
 * @version 2017-10-11
 */
@Service
@Transactional(readOnly = true)
public class BusinessLicenseService extends CrudService<BusinessLicenseDao, BusinessLicense> {

	@Autowired
	private OaNotifyService oaNotifyService;

	@Autowired
	private CertificateLibraryService certificateLibraryService;

	@Autowired
	private ActTaskService actTaskService;

	@Autowired
	private BusinessLicenseDao businessLicenseDao;

	@Override
	public BusinessLicense get(String id) {
		return super.get(id);
	}

	@Override
	public List<BusinessLicense> findList(BusinessLicense businessLicense) {
		return super.findList(businessLicense);
	}

	@Override
	public Page<BusinessLicense> findPage(Page<BusinessLicense> page, BusinessLicense businessLicense) {
		return super.findPage(page, businessLicense);
	}
	/**
	 * @author 许彩开
	 * @TODO (注：审核新增或编辑)
	 * @param businessLicense
	 * @DATE: 2017\10\11 0011 9:36
	 */

	@Override
	@Transactional(readOnly = false)
	public void save(BusinessLicense businessLicense) {
		DateFormat df = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");

		final String path = "E:\\certificate\\BusinessModel\\名称预先核准申请书减缩版22222.pdf";

		final String savaPath = "E:\\certificate\\Application\\"+businessLicense.getCertificateName()+"\\"+businessLicense.getCertificateName()
				+"+名称预先核准申请书"+".pdf";

		FileUtils.createDirectory("E:\\certificate\\Application\\"+businessLicense.getCertificateName());

		//申请发起
		if(StringUtils.isBlank(businessLicense.getId())){
			businessLicense.preInsert();
			dao.insert(businessLicense);
			//加入缓存
			CacheUtils.put("businessLicense","businessLicense",businessLicense);

			try {

				PDFUtil_mingzi.fillTemplate(businessLicense, path, savaPath);

			}catch (Exception E){
				E.printStackTrace();
			}

			System.out.println("收到货给客户定时关机====="+businessLicense.getId());
			//启动流程
			actTaskService.startProcess(ActUtils.PD_BUSINESS_LICENSE[0],ActUtils.PD_BUSINESS_LICENSE[1],businessLicense.getId(),businessLicense.getCertificateName()+"-"+df.format(businessLicense.getCreateDate()));
		}

		//重新编辑申请
		else{
			businessLicense.preUpdate();
			dao.update(businessLicense);

			businessLicense.getAct().setComment(("yes".equals(businessLicense.getAct().getFlag())?"[重申] ":"[销毁] ")+businessLicense.getAct().getComment());
			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			vars.put("pass", "yes".equals(businessLicense.getAct().getFlag())? "1" : "0");

			actTaskService.complete(businessLicense.getAct().getTaskId(), businessLicense.getAct().getProcInsId(), businessLicense.getAct().getComment(), businessLicense.getCertificateName()+"-"+df.format(businessLicense.getCreateDate()), vars);
		}
	}


	/**
	 * 审核审批保存
	 * @param businessLicense
	 */
	@Transactional(readOnly = false)
	public void auditSave( BusinessLicense businessLicense) throws IOException, DocumentException, ClientException {
		final String path = "E:\\certificate\\BusinessModel\\BusinessModel.pdf";
		final String path_copy = "E:\\certificate\\BusinessModel\\BusinessModel_copy.pdf";
		FileUtils.createDirectory("E:\\certificate\\Business\\"+businessLicense.getCertificateName());
		final String savaPath = "E:\\certificate\\Business\\"+businessLicense.getCertificateName()+"\\"+businessLicense.getCertificateName()
				+businessLicense.getPersonId()+".pdf";
		final String realativePath = "/pic/certificate/Business/"+businessLicense.getCertificateName()+"/"+businessLicense.getCertificateName()
				+businessLicense.getPersonId()+"_itext.pdf";
		final String savaPath_copy = "E:\\certificate\\Business\\"+businessLicense.getCertificateName()+"\\"+businessLicense.getCertificateName()
				+businessLicense.getPersonId()+"_copy"+".pdf";
//		String view = "businessLicenseForm";
		final CertificateLibrary certificateLibrary = new CertificateLibrary();
		// 设置意见
		businessLicense.getAct().setComment(("yes".equals(businessLicense.getAct().getFlag())?"[同意] ":"[驳回] ")+businessLicense.getAct().getComment());

		businessLicense.preUpdate();

		// 对不同环节的业务逻辑进行操作
		String taskDefKey = businessLicense.getAct().getTaskDefKey();

		// 审核环节
		if ("audit1".equals(taskDefKey)){
			businessLicense.setOpinion1(businessLicense.getAct().getComment());
			dao.updateOpinion1(businessLicense);
		}
		else if ("audit2".equals(taskDefKey)){
			businessLicense.setOpinion2(businessLicense.getAct().getComment());
			dao.updateOpinion2(businessLicense);
		}
		else if ("audit3".equals(taskDefKey)){
			businessLicense.setOpinion3(businessLicense.getAct().getComment());
			dao.updateOpinion3(businessLicense);
		}
		else if ("apply_end".equals(taskDefKey)){

					businessLicense.setOpinion4(businessLicense.getAct().getComment());
//					dao.updateOpinion4(businessLicense);
					businessLicense.setPath(realativePath);
					businessLicense.setStatus("审核通过");
					dao.update(businessLicense);
					try {
						PDFUtil.fillTemplate(businessLicense,path,savaPath);
						PDFUtil.fillTemplate(businessLicense,path_copy,savaPath_copy);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (DocumentException e) {
						e.printStackTrace();
					}

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

					OaNotify oaNotify=new OaNotify();
					oaNotify.setContent(businessLicense.getId());
					oaNotify.setStatus("审核通过");
					oaNotify.setFiles(realativePath);
					oaNotifyService.updateStatus(oaNotify);

					try {
						//开始盖章
						startStamp(savaPath);
						startStamp2(savaPath_copy);

						File file = new File(savaPath);
						if (file.isFile()&&file.exists()){
							file.delete();
						}

						File file2 = new File(savaPath_copy);
						if (file2.isFile()&&file2.exists()){
							file2.delete();
						}
					   SendMessageUtil.sendMessage(businessLicense.getPersionName(),businessLicense.getCertificateTypeName(),
								businessLicense.getPersionPhone());
					} catch (Exception e) {
						e.printStackTrace();
					}

		}		// 未知环节，直接返回
		else{

			return;
		}

		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(businessLicense.getAct().getFlag())? "1" : "0");
		actTaskService.complete(businessLicense.getAct().getTaskId(), businessLicense.getAct().getProcInsId(), businessLicense.getAct().getComment(), vars);

	}

	@Transactional(readOnly = false)
	public void delete(BusinessLicense businessLicense) {
		super.delete(businessLicense);
	}


	/**
	 * @author 许彩开
	 * @TODO (注：随机产生字母+数字组合)
	 * @param length
	 * @DATE: 2017\10\23 0023 14:40
	 */

	public String getCharAndNumr(int length)
	{
		String val = "";

		Random random = new Random();
		for(int i = 0; i < length; i++)
		{
			String charOrNum = random.nextInt(2) % 2 == 0 ? "char" : "num"; // 输出字母还是数字

			if("char".equalsIgnoreCase(charOrNum)) // 字符串
			{
				int choice =65 /*random.nextInt(2) % 2 == 0 ? 65 : 97*/; //取得大写字母还是小写字母
				val += (char) (choice + random.nextInt(26));
			}
			else if("num".equalsIgnoreCase(charOrNum)) // 数字
			{
				val += String.valueOf(random.nextInt(10));
			}
		}

		return val;
	}

	@Transactional(readOnly = false)
	public void update(BusinessLicense businessLicense) {
		dao.update(businessLicense);
	}

	public List<BusinessLicense> getByCertificateName(String certificateName) {
		return businessLicenseDao.getByCertificateName(certificateName);
	}

	/**
	 * @author 许彩开
	 * @TODO (注：调用盖章接口，进行盖章)
	 * @param SRC
	 * @DATE: 2017\11\24 0024 16:34
	 */

	@Transactional(readOnly = false)
	public void startStamp(String SRC) throws Exception {

		String KEYSTORE="E://certificate/pdfsign/贺志军.pfx";
		char[] PASSWORD = "1234".toCharArray();//keystory密码
		//String SRC="E://certificate/pdfsign/src/练浩文打飞机有限公司440825199509103912.pdf" ;//原始pdf
		//   String DEST=SRC.replace(".pdf", "_box.pdf"); //"d://demo_signed_box.pdf" ;//签名完成的pdf
		String DEST2=SRC.replace(".pdf", "_itext.pdf");//签名完成的pdf
		String chapterPath="E://certificate/pdfsign/src/runcheng2.gif";//签章图片
		String signername="润成科技";
		String reason="润成电子印章签名";
		String location="珠海";


		System.out.println("==================这里是startStamp方法======================");
/*
	PdfSignBox.sign(PASSWORD, new FileInputStream(KEYSTORE),
			new FileInputStream(chapterPath),
			new File(SRC),new File(DEST),signername, reason, location);	*/


		PdfSignItext.sign(new FileInputStream(SRC), new FileOutputStream(DEST2),
				new FileInputStream(KEYSTORE), PASSWORD,
				reason, location, chapterPath);

	}



	/**
	 * @author 许彩开
	 * @TODO (注：调用盖章接口，进行盖章)
	 * @param SRC
	 * @DATE: 2017\11\24 0024 16:34
	 */

	@Transactional(readOnly = false)
	public void startStamp2(String SRC) throws Exception {

		String KEYSTORE="E://certificate/pdfsign/贺志军.pfx";
		char[] PASSWORD = "1234".toCharArray();//keystory密码
		//String SRC="E://certificate/pdfsign/src/练浩文打飞机有限公司440825199509103912.pdf" ;//原始pdf
		//   String DEST=SRC.replace(".pdf", "_box.pdf"); //"d://demo_signed_box.pdf" ;//签名完成的pdf
		String DEST2=SRC.replace(".pdf", "_itext.pdf");//签名完成的pdf
		String chapterPath="E://certificate/pdfsign/src/runcheng2.gif";//签章图片
		String signername="润成科技";
		String reason="润成电子印章签名";
		String location="珠海";


		System.out.println("==================这里是startStamp2方法======================");
/*
	PdfSignBox.sign(PASSWORD, new FileInputStream(KEYSTORE),
			new FileInputStream(chapterPath),
			new File(SRC),new File(DEST),signername, reason, location);	*/


		PdfSignItext_copy.sign(new FileInputStream(SRC), new FileOutputStream(DEST2),
				new FileInputStream(KEYSTORE), PASSWORD,
				reason, location, chapterPath);

	}


}