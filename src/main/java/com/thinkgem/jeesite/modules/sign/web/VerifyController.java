package com.thinkgem.jeesite.modules.sign.web;

import com.thinkgem.jeesite.common.condition.Condition;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sign.entity.Client;
import com.thinkgem.jeesite.modules.sign.entity.JsonReturn;
import com.thinkgem.jeesite.modules.sign.service.ClientTestService;
import com.thinkgem.jeesite.modules.sign.service.VerifyFileService;
import com.thinkgem.jeesite.modules.sign.utils.HttpURLConnectionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import net.sf.json.JSONObject;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileNotFoundException;
import java.net.URLEncoder;

/**
 * 签名和验签Controller
 * @author
 * bb3011
 */
@Controller
@RequestMapping(value = "${frontPath}/verify/certificate")
public class VerifyController extends BaseController{

    @Autowired
    private VerifyFileService verifyFileService;
    @Autowired
    private ClientTestService clientTestService;

    private static final String uploadURL = "http://localhost:8081/a/signature/qm/pass/upload?";

    //跳转页面
    @RequestMapping(value = "jump")
    public String verify(Model model){
        return "modules/sign/sign";
    }


    /**
     * 验证通过之后，签名商(润成)调用本接口来通知到应用商
     * @param barcode 二维码字符串（包含了 Appid 和 pdfId）
     * @param signseceret 签名密钥
     */
    @RequestMapping(value = "/SingNotifyURLTest", method = RequestMethod.POST)
    @ResponseBody
    public String SingNotifyURLTest(@RequestParam(value = "barcode", required = true) String barcode,
                                    @RequestParam(value = "signseceret", required = true) String signseceret) {

        String appId = barcode.substring(0,8);
        String pdfId = barcode.substring(8,barcode.length());
        System.out.println("appId="+appId+";pdfId="+pdfId);

        Client client = new Client();
        client.setPdfid(pdfId);
        client.setSignseceret(signseceret);
        client.setIscheck("1");

        if (clientTestService.insert(client) == 1){
            return "success";
        }

        return "fail";
    }

    /**
     * 页面轮询接口，判断是否已验证成功
     * @param pdfId 文件编码
     */
    @RequestMapping(value = "isPass", method = RequestMethod.GET)
    @ResponseBody
    public JsonReturn isPass(@RequestParam(value = "pdfId", required = true) String pdfId) {


        Client client = new Client();
        client.setPdfid(pdfId);
        client = clientTestService.isPass(client);
        System.out.println("getSignseceret="+client.getSignseceret());
        if (client != null){
            JsonReturn jsonReturn = new JsonReturn();
            jsonReturn.setCode(JsonReturn.SUCCESS_CODE);
            jsonReturn.setMessage("身份验证成功！");
            jsonReturn.setSignseceret(client.getSignseceret());
            System.out.println("轮询成功！");
            return jsonReturn;
        }

        JsonReturn jsonReturn = new JsonReturn();
        jsonReturn.setCode(JsonReturn.ERROR_CODE);
        jsonReturn.setMessage("身份验证失败！");
        return jsonReturn;
    }

    /**
     * 文件上传接口，后台自动将文件上传给签名商(润成)
     * @param token
     * @param membercode
     * @param checkPath
     */
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    @ResponseBody
    public JsonReturn upload(@RequestParam(value = "token", required = true) String token,
                             @RequestParam(value = "membercode", required = true) String membercode,
                             @RequestParam(value = "checkPath", required = true) String checkPath) {

        File path1 = null;
        try {
            path1 = new File(ResourceUtils.getURL("classpath:").getPath());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        if(!path1.exists()) path1 = new File("");

        checkPath = checkPath.replace("/pic","E:");
        File file = new File(checkPath);//部署本地地址

        String path = file.getAbsolutePath();
        System.out.println("path:"+path);

        // 上传文件
        String result = HttpURLConnectionUtil.uploadFile(uploadURL +
                        "token="+ token +
                        "&membercode=" + membercode,
                new String[]{path} );

        JSONObject jsonObject = JSONObject.fromObject(result);
        int code = Integer.valueOf(jsonObject.get("code").toString());
        String message = jsonObject.get("message").toString();

        if (code == 200){
            JsonReturn jsonReturn = new JsonReturn();
            jsonReturn.setCode(JsonReturn.SUCCESS_CODE);
            jsonReturn.setMessage(message);
            return jsonReturn;
        }

        JsonReturn jsonReturn = new JsonReturn();
        jsonReturn.setCode(JsonReturn.ERROR_CODE);
        jsonReturn.setMessage("上传失败！");
        return jsonReturn;
    }

    /**
     * 验签接口
     * @param checkPath
     * @return
     */
    //@RequiresPermissions("sign:certificate:view")
    @RequestMapping(value="info")
    @ResponseBody
    public String verifyByFile(@RequestParam(value="checkPath")String checkPath,
                               HttpServletResponse response){
        System.out.println("checkPath="+checkPath);
        response.setHeader("Access-Control-Allow-Origin", "*");//解决跨域问题

        Condition condition = verifyFileService.verifyByFile(checkPath);

        return JsonMapper.toJsonString(condition);
    }

}
