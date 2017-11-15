package com.thinkgem.jeesite.common.utils;

//import com.taobao.api.ApiException;
//import com.taobao.api.DefaultTaobaoClient;
//import com.taobao.api.TaobaoClient;
//import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
//import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;


import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;

public class SendMessageUtil {
    private static String authCode;

//    /**
//     * @author 练浩文
//     * @TODO (注：发送验证码)
//     * @param phoneNum
//     * @DATE: 2017/10/26 9:32
//     */
//    public static boolean SendAuthCode(String phoneNum){
//
//        System.out.println("====="+randNum);
//        String url = "http://gw.api.taobao.com/router/rest";
//        String appkey = "23293904";
//        String secret = "e6fdba63321ad26515bfbe3c88f19ba9";
//        TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
//        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
//        req.setExtend("");
//        req.setSmsType( "normal" );
//        req.setSmsFreeSignName( "注册验证" );
//        req.setSmsParamString( "{\"code\":\"" + randNum + "\",\"minute\":\"2\"}" );
//        req.setRecNum( phoneNum );
//        req.setSmsTemplateCode( "SMS_3985867" );
//        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
//        System.out.println(rsp.getBody());
//        return true;
//
//    }

    /**0
     * @author 练浩文
     * @TODO (注：)
     * @param personName
     * @param certificateType
     * @param phoneNum
     * @DATE: 2017/11/7 17:13
     */
//    public static boolean sendMessage(String personName,String certificateType,String phoneNum) throws ApiException {
//
//        String url = "http://gw.api.taobao.com/router/rest";
//        String appkey = "LTAIu0omVFXsvKkk";
//        String secret = "jiblKJLlVIqOB15P6jlCWRakeSUNf5";
//        TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
//        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
//        req.setExtend("");
//        req.setSmsType( "normal" );
//        req.setSmsFreeSignName( "润成科技" );
//        req.setSmsParamString( "{\"name\":\"" + personName + "\",\"certificateType\":\""+certificateType+"}" );
//        req.setRecNum( phoneNum );
//        req.setSmsTemplateCode( "SMS_107795097" );
//        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
//        System.out.println(rsp.getBody());
//        return true;
//    }

    public static void sendMessage(String personName,String certificateType,String phoneNum) throws ClientException {
        //设置超时时间-可自行调整
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
        //初始化ascClient需要的几个参数
        final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
        final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
        //替换成你的AK
        final String accessKeyId = "LTAIu0omVFXsvKkk";//你的accessKeyId,参考本文档步骤2
        final String accessKeySecret = "jiblKJLlVIqOB15P6jlCWRakeSUNf5";//你的accessKeySecret，参考本文档步骤2
        //初始化ascClient,暂时不支持多region（请勿修改）
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
                accessKeySecret);

        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
        IAcsClient acsClient = new DefaultAcsClient(profile);
        //组装请求对象
        SendSmsRequest request = new SendSmsRequest();
        //使用post提交
        request.setMethod(MethodType.POST);
        //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
        request.setPhoneNumbers(phoneNum);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName("润成科技");
        //必填:短信模板-可在短信控制台中找到
        request.setTemplateCode("SMS_107795097");
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
        request.setTemplateParam("{\"name\":\""+personName+"\", \"certificateType\":\""+certificateType+"\"}");
        //可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
//        request.setOutId("yourOutId");
        //请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        System.out.println("----"+sendSmsResponse.getCode());
        if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
        //请求成功
            System.out.println("请求成功");
        }
    }

    public static void sendAuthCode(String phoneNum) throws ClientException {
        String rand = Double.toString((Math.random()*9+1)*100000);
        authCode = rand.substring(0,6);
        //设置超时时间-可自行调整
        System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
        System.setProperty("sun.net.client.defaultReadTimeout", "10000");
        //初始化ascClient需要的几个参数
        final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
        final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
        //替换成你的AK
        final String accessKeyId = "LTAIu0omVFXsvKkk";//你的accessKeyId,参考本文档步骤2
        final String accessKeySecret = "jiblKJLlVIqOB15P6jlCWRakeSUNf5";//你的accessKeySecret，参考本文档步骤2
        //初始化ascClient,暂时不支持多region（请勿修改）
        IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
                accessKeySecret);

        DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);
        IAcsClient acsClient = new DefaultAcsClient(profile);
        //组装请求对象
        SendSmsRequest request = new SendSmsRequest();
        //使用post提交
        request.setMethod(MethodType.POST);
        //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式
        request.setPhoneNumbers(phoneNum);
        //必填:短信签名-可在短信控制台中找到
        request.setSignName("润成科技");
        //必填:短信模板-可在短信控制台中找到
        request.setTemplateCode("SMS_103530002");
        //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
        //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
        request.setTemplateParam("{\"code\":\""+authCode+"\"}");
        //可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
        //request.setSmsUpExtendCode("90997");
        //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
//        request.setOutId("yourOutId");
        //请求失败这里会抛ClientException异常
        SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
        System.out.println("+++++++++++++++++++"+authCode);
//        System.out.println("----"+sendSmsResponse.getCode());
        if(sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
            //请求成功
            System.out.println("请求成功");
        }
    }
    /**
     * @author 练浩文
     * @TODO (注：验证验证码)
     * @param valiNum
     * @DATE: 2017/10/26 9:33
     */
    public static boolean isValidate(String valiNum){
//        System.out.println("+++"+randNum);

        if (valiNum.equals(authCode)){
            return true;
        }else{
            return false;
        }
    }

}
