package com.thinkgem.jeesite.common.test;

//import com.taobao.api.ApiException;
import com.aliyuncs.exceptions.ClientException;
import com.thinkgem.jeesite.common.utils.SendMessageUtil;
import org.junit.Test;

import java.util.Scanner;


public class TestSendMessageUtil {
    public static void main(String []args) throws ClientException {
        String phoneNum = "13160676759";
//        String random = "dog";
        String name  = "许彩开";
        String type = "营业执照";

        SendMessageUtil.sendAuthCode(phoneNum);
//        Scanner scan = new Scanner(System.in);
//        String valiNum = scan.nextLine();
//        boolean b1 = SendMessageUtil.isValidate(valiNum);
//        System.out.println(b1);

    }
}
