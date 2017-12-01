/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.web.front;

import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;

import com.aliyuncs.exceptions.ClientException;
import com.itextpdf.text.DocumentException;
import com.thinkgem.jeesite.common.persistence.Msg;
import com.thinkgem.jeesite.common.utils.*;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;

import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.activiti.engine.impl.util.json.JSONArray;
import org.activiti.engine.impl.util.json.JSONObject;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.servlet.ValidateCodeServlet;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.cms.entity.Comment;
import com.thinkgem.jeesite.modules.cms.entity.Link;
import com.thinkgem.jeesite.modules.cms.entity.Site;
import com.thinkgem.jeesite.modules.cms.service.ArticleDataService;
import com.thinkgem.jeesite.modules.cms.service.ArticleService;
import com.thinkgem.jeesite.modules.cms.service.CategoryService;
import com.thinkgem.jeesite.modules.cms.service.CommentService;
import com.thinkgem.jeesite.modules.cms.service.LinkService;
import com.thinkgem.jeesite.modules.cms.service.SiteService;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * 网站Controller
 * @author ThinkGem
 * @version 2013-5-29
 */
@Controller
@RequestMapping(value = "${frontPath}")
public class FrontController extends BaseController {

	@Autowired
	private ArticleService articleService;
	@Autowired
	private ArticleDataService articleDataService;
	@Autowired
	private LinkService linkService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private SiteService siteService;

	@Autowired
	private SystemService systemService;


	/**
	 * @author YuXiaoXi
	 * @TODO (注：用户注册页面)
	 * @DATE: 2017/10/11 14:16
	 */
	@RequestMapping(value = "userRegiste")
	public String Registe(User user, Model model) {
		model.addAttribute("user", user);
		return "modules/sys/userRegiste";
	}

	/**
	 * @author YuXiaoXi
	 * @TODO (注：用户忘记密码页面)
	 * @DATE: 2017/10/11 14:16
	 */
	@RequestMapping(value = "forgetPassword")
	public String forgetPwd(User user, Model model) {
		model.addAttribute("user", user);
		return "modules/sys/forgetPassword";
	}

	/**
	 * 验证登录名是否有效可用
	 *
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkLoginName")
	public String checkLoginName(String oldLoginName, String loginName) {
		if (loginName != null && loginName.equals(oldLoginName)) {
			return "true";

		} else if (loginName != null && systemService.getUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}

	/**
	 * 验证登录名是否存在
	 *
	 * @param loginName
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "checkLoginNameExist")
	public String checkLoginNameExist(String oldLoginName, String loginName, HttpServletRequest request,Model model) {
		if (loginName != null && systemService.getUserByLoginName(loginName) == null) {
			return "false";
		}
		User user = systemService.getUserByLoginName(loginName);
		if(user!=null) {
			String mobile = user.getMobile();
			mobile = mobile.substring(0, mobile.length() - (mobile.substring(3)).length()) + "****" + mobile.substring(7);
			User user1 =new User();
			user1.setMobile(mobile);
			model.addAttribute("user",user1);
			//request.setAttribute("mobile", mobile);
		}
		return "true";
	}


/**
 * @author 许彩开
 * @TODO (注：验证提交过来的验证码是否正确)
  * @param
 * @DATE: 2017\11\10 0010 16:39
 */

	@RequestMapping(value = "checkCode")
	public String checkCode(String code,String loginName,Model model){
		System.out.println("验证码========="+code);
		System.out.println("验证码是否正确========"+SendMessageUtil.isValidate(code));
		User user=systemService.getUserByLoginName(loginName);
		//临时保存user
		UserUtils.tempUser=user;
		System.out.println("用户======="+user);
		model.addAttribute("user", user);
		if(SendMessageUtil.isValidate(code)){
			System.out.println("验证码正确");
			return "modules/sys/userModifyPwd2";
		}
		JOptionPane.showMessageDialog(null,"手机验证码输入错误！！！","确认信息",JOptionPane.INFORMATION_MESSAGE);
		return "modules/sys/forgetPassword";
	}

	/**
	 * @author 许彩开
	 * @TODO (注：忘记密码的修改)
	 * @param newPassword
	 * @DATE: 2017\11\14 0014 16:38
	 */

//	@RequiresPermissions("user")
	@RequestMapping(value = "modifyPwd2")
	public String  modifyPwd2( String newPassword) {
		User user = UserUtils.getTempUser();
		System.out.println("这里是UserController====user==="+user);
		if (StringUtils.isNotBlank(newPassword)){
			systemService.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
			//model.addAttribute("message", "修改密码成功");
			JOptionPane.showMessageDialog(null,"密码修改成功！！！","确认信息",JOptionPane.INFORMATION_MESSAGE);
			return "modules/sys/sysLogin";
		}
		//model.addAttribute("user", user);
			return "modules/sys/sysLogin";
	}

	@RequestMapping(value = "jumpLogin" ,method = RequestMethod.GET)
	public String jumpLogin() {
		return "modules/sys/sysLogin";
	}

	/**
	 * @author YuXiaoXi
	 * @TODO (注：保存注册用户信息)
	 * @DATE: 2017/10/17 19:26
	 */
	@RequestMapping(value = "save")
	public String save(User user, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		//获取登录ip地址
		String localip = null;
		InetAddress local = null;
		try {
			local = local.getLocalHost();
			localip = local.getHostAddress();
			System.out.println("本机的ip是 ：" + localip);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		user.setCompany(new Office("1"));
		user.setOffice(new Office("1"));
		if (!beanValidator(model, user)) {
			return Registe(user, model);
		}
		if (!"true".equals(checkLoginName(user.getOldLoginName(), user.getLoginName()))) {
			addMessage(model, "保存用户'" + user.getLoginName() + "'失败，登录名已存在");
			return Registe(user, model);
		}
		user.setCompany(new Office("0"));
		user.setOffice(new Office("0"));
		user.setNo("00000");
		user.setUserType("3");
		user.setPassword(systemService.entryptPassword(user.getPassword()));
		user.setLoginIp(localip);
		user.setLoginDate(new Date());
		System.out.println(user.getLoginIp());
		// 设置注册用户的角色数据
		Role role = systemService.getRoleByEnname("populace");
		List<Role> roleList = Lists.newArrayList();
		roleList.add(role);
		user.setRoleList(roleList);
		// 保存用户信息
		systemService.saveRegister(user);
		addMessage(redirectAttributes, "注册用户'" + user.getLoginName() + "'成功");
		return "modules/sys/sysLogin";
	}
/**
 * @author 许彩开
 * @TODO (注：发送验证码)
  * @param loginName
 * @DATE: 2017\11\14 0014 9:15
 */

	@ResponseBody
	@RequestMapping(value = "sendCode",method = RequestMethod.POST)
	public boolean sendCode(String loginName) throws ClientException {
		System.out.println("登录名========="+loginName);

		User user=systemService.getUserByLoginName(loginName);
		if(user!=null) {
			String mobile = user.getMobile();
			SendMessageUtil.sendAuthCode(mobile);
		}
		return true;
	}

	/**
	 * 网站首页
	 */
	@RequestMapping
	public String index(Model model) {
		Site site = CmsUtils.getSite(Site.defaultSiteId());
		model.addAttribute("site", site);
		model.addAttribute("isIndex", true);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex";
	}
	
	/**
	 * 网站首页
	 */
	@RequestMapping(value = "index-{siteId}${urlSuffix}")
	public String index(@PathVariable String siteId, Model model) {
		if (siteId.equals("1")){
			return "redirect:"+Global.getFrontPath();
		}
		Site site = CmsUtils.getSite(siteId);
		// 子站有独立页面，则显示独立页面
		if (StringUtils.isNotBlank(site.getCustomIndexView())){
			model.addAttribute("site", site);
			model.addAttribute("isIndex", true);
			return "modules/cms/front/themes/"+site.getTheme()+"/frontIndex"+site.getCustomIndexView();
		}
		// 否则显示子站第一个栏目
		List<Category> mainNavList = CmsUtils.getMainNavList(siteId);
		if (mainNavList.size() > 0){
			String firstCategoryId = CmsUtils.getMainNavList(siteId).get(0).getId();
			return "redirect:"+Global.getFrontPath()+"/list-"+firstCategoryId+Global.getUrlSuffix();
		}else{
			model.addAttribute("site", site);
			return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory";
		}
	}
	
	/**
	 * 内容列表
	 */
	@RequestMapping(value = "list-{categoryId}${urlSuffix}")
	public String list(@PathVariable String categoryId, @RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		Site site = siteService.get(category.getSite().getId());
		model.addAttribute("site", site);
		// 2：简介类栏目，栏目第一条内容
		if("2".equals(category.getShowModes()) && "article".equals(category.getModule())){
			// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
			List<Category> categoryList = Lists.newArrayList();
			if (category.getParent().getId().equals("1")){
				categoryList.add(category);
			}else{
				categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
			}
			model.addAttribute("category", category);
			model.addAttribute("categoryList", categoryList);
			// 获取文章内容
			Page<Article> page = new Page<Article>(1, 1, -1);
			Article article = new Article(category);
			page = articleService.findPage(page, article, false);
			if (page.getList().size()>0){
				article = page.getList().get(0);
				article.setArticleData(articleDataService.get(article.getId()));
				articleService.updateHitsAddOne(article.getId());
			}
			model.addAttribute("article", article);
            CmsUtils.addViewConfigAttribute(model, category);
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
			return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
		}else{
			List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
			// 展现方式为1 、无子栏目或公共模型，显示栏目内容列表
			if("1".equals(category.getShowModes())||categoryList.size()==0){
				// 有子栏目并展现方式为1，则获取第一个子栏目；无子栏目，则获取同级分类列表。
				if(categoryList.size()>0){
					category = categoryList.get(0);
				}else{
					// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
					if (category.getParent().getId().equals("1")){
						categoryList.add(category);
					}else{
						categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
					}
				}
				model.addAttribute("category", category);
				model.addAttribute("categoryList", categoryList);
				// 获取内容列表
				if ("article".equals(category.getModule())){
					Page<Article> page = new Page<Article>(pageNo, pageSize);
					//System.out.println(page.getPageNo());
					page = articleService.findPage(page, new Article(category), false);
					model.addAttribute("page", page);
					// 如果第一个子栏目为简介类栏目，则获取该栏目第一篇文章
					if ("2".equals(category.getShowModes())){
						Article article = new Article(category);
						if (page.getList().size()>0){
							article = page.getList().get(0);
							article.setArticleData(articleDataService.get(article.getId()));
							articleService.updateHitsAddOne(article.getId());
						}
						model.addAttribute("article", article);
			            CmsUtils.addViewConfigAttribute(model, category);
			            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
						return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
					}
				}else if ("link".equals(category.getModule())){
					Page<Link> page = new Page<Link>(1, -1);
					page = linkService.findPage(page, new Link(category), false);
					model.addAttribute("page", page);
				}
				String view = "/frontList";
				if (StringUtils.isNotBlank(category.getCustomListView())){
					view = "/"+category.getCustomListView();
				}
	            CmsUtils.addViewConfigAttribute(model, category);
                site =siteService.get(category.getSite().getId());
                //System.out.println("else 栏目第一条内容 _2 :"+category.getSite().getTheme()+","+site.getTheme());
				return "modules/cms/front/themes/"+siteService.get(category.getSite().getId()).getTheme()+view;
				//return "modules/cms/front/themes/"+category.getSite().getTheme()+view;
			}
			// 有子栏目：显示子栏目列表
			else{
				model.addAttribute("category", category);
				model.addAttribute("categoryList", categoryList);
				String view = "/frontListCategory";
				if (StringUtils.isNotBlank(category.getCustomListView())){
					view = "/"+category.getCustomListView();
				}
	            CmsUtils.addViewConfigAttribute(model, category);
				return "modules/cms/front/themes/"+site.getTheme()+view;
			}
		}
	}

	/**
	 * 内容列表（通过url自定义视图）
	 */
	@RequestMapping(value = "listc-{categoryId}-{customView}${urlSuffix}")
	public String listCustom(@PathVariable String categoryId, @PathVariable String customView, @RequestParam(required=false, defaultValue="1") Integer pageNo,
			@RequestParam(required=false, defaultValue="15") Integer pageSize, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		Site site = siteService.get(category.getSite().getId());
		model.addAttribute("site", site);
		List<Category> categoryList = categoryService.findByParentId(category.getId(), category.getSite().getId());
		model.addAttribute("category", category);
		model.addAttribute("categoryList", categoryList);
        CmsUtils.addViewConfigAttribute(model, category);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontListCategory"+customView;
	}

	/**
	 * 显示内容
	 */
	@RequestMapping(value = "view-{categoryId}-{contentId}${urlSuffix}")
	public String view(@PathVariable String categoryId, @PathVariable String contentId, Model model) {
		Category category = categoryService.get(categoryId);
		if (category==null){
			Site site = CmsUtils.getSite(Site.defaultSiteId());
			model.addAttribute("site", site);
			return "error/404";
		}
		model.addAttribute("site", category.getSite());
		if ("article".equals(category.getModule())){
			// 如果没有子栏目，并父节点为跟节点的，栏目列表为当前栏目。
			List<Category> categoryList = Lists.newArrayList();
			if (category.getParent().getId().equals("1")){
				categoryList.add(category);
			}else{
				categoryList = categoryService.findByParentId(category.getParent().getId(), category.getSite().getId());
			}
			// 获取文章内容
			Article article = articleService.get(contentId);
			if (article==null || !Article.DEL_FLAG_NORMAL.equals(article.getDelFlag())){
				return "error/404";
			}
			// 文章阅读次数+1
			articleService.updateHitsAddOne(contentId);
			// 获取推荐文章列表
			List<Object[]> relationList = articleService.findByIds(articleDataService.get(article.getId()).getRelation());
			// 将数据传递到视图
			model.addAttribute("category", categoryService.get(article.getCategory().getId()));
			model.addAttribute("categoryList", categoryList);
			article.setArticleData(articleDataService.get(article.getId()));
			model.addAttribute("article", article);
			model.addAttribute("relationList", relationList); 
            CmsUtils.addViewConfigAttribute(model, article.getCategory());
            CmsUtils.addViewConfigAttribute(model, article.getViewConfig());
            Site site = siteService.get(category.getSite().getId());
            model.addAttribute("site", site);
//			return "modules/cms/front/themes/"+category.getSite().getTheme()+"/"+getTpl(article);
            return "modules/cms/front/themes/"+site.getTheme()+"/"+getTpl(article);
		}
		return "error/404";
	}
	
	/**
	 * 内容评论
	 */
	@RequestMapping(value = "comment", method=RequestMethod.GET)
	public String comment(String theme, Comment comment, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Comment> page = new Page<Comment>(request, response);
		Comment c = new Comment();
		c.setCategory(comment.getCategory());
		c.setContentId(comment.getContentId());
		c.setDelFlag(Comment.DEL_FLAG_NORMAL);
		page = commentService.findPage(page, c);
		model.addAttribute("page", page);
		model.addAttribute("comment", comment);
		return "modules/cms/front/themes/"+theme+"/frontComment";
	}
	
	/**
	 * 内容评论保存
	 */
	@ResponseBody
	@RequestMapping(value = "comment", method=RequestMethod.POST)
	public String commentSave(Comment comment, String validateCode,@RequestParam(required=false) String replyId, HttpServletRequest request) {
		if (StringUtils.isNotBlank(validateCode)){
			if (ValidateCodeServlet.validate(request, validateCode)){
				if (StringUtils.isNotBlank(replyId)){
					Comment replyComment = commentService.get(replyId);
					if (replyComment != null){
						comment.setContent("<div class=\"reply\">"+replyComment.getName()+":<br/>"
								+replyComment.getContent()+"</div>"+comment.getContent());
					}
				}
				comment.setIp(request.getRemoteAddr());
				comment.setCreateDate(new Date());
				comment.setDelFlag(Comment.DEL_FLAG_AUDIT);
				commentService.save(comment);
				return "{result:1, message:'提交成功。'}";
			}else{
				return "{result:2, message:'验证码不正确。'}";
			}
		}else{
			return "{result:2, message:'验证码不能为空。'}";
		}
	}
	
	/**
	 * 站点地图
	 */
	@RequestMapping(value = "map-{siteId}${urlSuffix}")
	public String map(@PathVariable String siteId, Model model) {
		Site site = CmsUtils.getSite(siteId!=null?siteId:Site.defaultSiteId());
		model.addAttribute("site", site);
		return "modules/cms/front/themes/"+site.getTheme()+"/frontMap";
	}

    private String getTpl(Article article){
        if(StringUtils.isBlank(article.getCustomContentView())){
            String view = null;
            Category c = article.getCategory();
            boolean goon = true;
            do{
                if(StringUtils.isNotBlank(c.getCustomContentView())){
                    view = c.getCustomContentView();
                    goon = false;
                }else if(c.getParent() == null || c.getParent().isRoot()){
                    goon = false;
                }else{
                    c = c.getParent();
                }
            }while(goon);
            return StringUtils.isBlank(view) ? Article.DEFAULT_TEMPLATE : view;
        }else{
            return article.getCustomContentView();
        }
    }


	/**
	 * @author 许彩开
	 * @TODO (注：生成证照)
	 * @param request
	 * @DATE: 2017\11\29 0029 17:18
	 */


	@ResponseBody
	@RequestMapping(value = "getTemplate")
	public Map<String,Object> getTemplate(HttpServletRequest request, HttpServletResponse response){
		Map<String,Object> result=new HashMap<String, Object>();
		BusinessLicense businessLicense = new BusinessLicense();
		//解析json数据
		//response.setContentType("application/json");
		String jsonStr = request.getParameter("mydata");
		JSONArray jsonArray = new JSONArray(jsonStr);
		for(int i=0;i<jsonArray.length();i++){
			JSONObject jsonObject = jsonArray.getJSONObject(i);
			//统一社会信用代码=idcertificateCode
			businessLicense.setCertificateCode(jsonObject.getString("idcertificateCode"));
			System.out.println("================统一社会信用代码===="+businessLicense.getCertificateCode());
			businessLicense.setCertificateName(jsonObject.getString("idcertificateName"));
			businessLicense.setRegisteredType(jsonObject.getString("idregisteredType"));
			businessLicense.setAddress(jsonObject.getString("idaddress"));
			businessLicense.setPersionName(jsonObject.getString("idpersionName"));
			businessLicense.setRegisteredCapital(jsonObject.getString("idregisteredCapital"));
			businessLicense.setEstablishDate(StrToDate(jsonObject.getString("idestablishDate")));
			businessLicense.setEffectiveDateStar(StrToDate(jsonObject.getString("ideffectiveDateStar")));
			businessLicense.setEffectiveDateEnd(StrToDate(jsonObject.getString("ideffectiveDateEnd")));
			//这里是临时使用“备注-》remarks”字段保存“经营范围”
			businessLicense.setRemarks(jsonObject.getString("idscope"));
			//这里是临时使用“意见1-》opinion1”字段保存“登记机关”
			businessLicense.setOpinion1(jsonObject.getString("idoffice"));
			System.out.println("===============成功===");
		}

		final String path = "E:\\certificate\\BusinessModel\\BusinessModel.pdf";
		final String savaPath = "E:\\certificate\\Business\\"+businessLicense.getCertificateName()+"\\"+businessLicense.getCertificateName()+".pdf";
		FileUtils.createDirectory("E:\\certificate\\Business\\"+businessLicense.getCertificateName());
		try {
			//接口pdf
			PDFUtil_interface.fillTemplate(businessLicense,path,savaPath);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

		String savaPath2 = "E:\\certificate\\Business";
		String isExsitFile = "E:\\certificate\\Business\\"+businessLicense.getCertificateName();
		String downLoadPath = "E:\\certificate\\Business\\"+businessLicense.getCertificateName()+".zip";
		File file = new File(isExsitFile);
		if (file.exists()){
			FileUtils.zipFiles(savaPath2,businessLicense.getCertificateName(),downLoadPath);
			File file1 = new File(downLoadPath);
			//FileUtils.downFile(file1,request,response,businessLicense.getCertificateName() +".zip");
			result.put("downLoadPath","下载地址：192.168.8.117\\"+downLoadPath);
		} else{
			try {
				PrintWriter out = response.getWriter();
				out.println("<script Language='JavaScript'>");
				out.println("alert(\"证照还未生成！无法下载()！！！\");");
				out.println("history.back();");
				out.println("</script>");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return result;

	}

/**
 * @author 许彩开
 * @TODO (注：字符串转日期)
  * @param str
 * @DATE: 2017\11\30 0030 9:58
 */

	public static Date StrToDate(String str) {

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = format.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

}
