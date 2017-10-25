package com.thinkgem.jeesite.modules.certificate.web;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.certificate.entity.CertificateInfo;
import com.thinkgem.jeesite.modules.certificate.service.CertificateInfoService;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;
import com.thinkgem.jeesite.modules.sys.entity.User;
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
 * @author YuXiaoXi
 * @TODO (注：申请证照)

 * @DATE: 2017/10/18 16:19
 */
@Controller
@RequestMapping(value = "${adminPath}/certificate/applyCertificate")
public class ApplyCertificateController extends BaseController{

    /**
     * @author YuXiaoXi
     * @TODO (注：跳转用户申请证照界面)

     * @DATE: 2017/10/18 16:21
     */
    @RequestMapping(value = "apply")
    public String apply(User user, BusinessLicense businessLicense, Model model) {
        return "modules/license/qpplyCertificate";
    }

    @RequestMapping(value = "applyBusinessLicense")
    public String apply1(User user, BusinessLicense businessLicense, Model model) {
        
        model.addAttribute("businessLicense", businessLicense);
        model.addAttribute("user", user);
        return "modules/license/businessLicenseForm";
    }

}
