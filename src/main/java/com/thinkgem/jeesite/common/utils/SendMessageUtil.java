package com.thinkgem.jeesite.common.utils;

import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;



public class SendMessageUtil {
    private static String randNum;

    /**
     * @author 练浩文
     * @TODO (注：发送验证码)
     * @param phoneNum
     * @DATE: 2017/10/26 9:32
     */
    public static boolean SendAuthCode(String phoneNum) throws ApiException {
        String rand = Double.toString((Math.random()*9+1)*100000);
        randNum = rand.substring(0,6);
        System.out.println("====="+randNum);
        String url = "http://gw.api.taobao.com/router/rest";
        String appkey = "23293904";
        String secret = "e6fdba63321ad26515bfbe3c88f19ba9";
        TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
        AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
        req.setExtend("");
        req.setSmsType( "normal" );
        req.setSmsFreeSignName( "注册验证" );
        req.setSmsParamString( "{\"code\":\"" + randNum + "\",\"minute\":\"2\"}" );
        req.setRecNum( phoneNum );
        req.setSmsTemplateCode( "SMS_3985867" );
        AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
        System.out.println(rsp.getBody());
        return true;

    }

    /**
     * @author 练浩文
     * @TODO (注：验证验证码)
     * @param valiNum
     * @DATE: 2017/10/26 9:33
     */
    public static boolean isValidate(String valiNum){
//        System.out.println("+++"+randNum);

        if (valiNum.equals(randNum)){
            return true;
        }else{
            return false;
        }
    }

}
