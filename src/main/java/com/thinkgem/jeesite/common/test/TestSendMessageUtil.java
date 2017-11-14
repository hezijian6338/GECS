package com.thinkgem.jeesite.common.test;

import com.taobao.api.ApiException;
import com.thinkgem.jeesite.common.utils.SendMessageUtil;
import org.junit.Test;

import java.util.Scanner;


public class TestSendMessageUtil {
    public static void main(String []args) throws ApiException {
        String phoneNum = "13750051367";
//        String random = "dog";
        boolean b2 = SendMessageUtil.SendAuthCode(phoneNum);
        Scanner scan = new Scanner(System.in);
        String valiNum = scan.nextLine();
        boolean b1 = SendMessageUtil.isValidate(valiNum);
        System.out.println(b1);

    }
}
