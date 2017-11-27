package com.thinkgem.jeesite.test.web;


import java.io.FileInputStream;
import java.io.FileOutputStream;

import com.thinkgem.jeesite.common.utils.PdfSignItext;
import com.thinkgem.jeesite.common.utils.PdfSignItext_copy;


public class Test {
	public static void main(String[] args) throws  Exception {
		    // String KEYSTORE="d://signed/13722222222.pfx";
		    // char[] PASSWORD = "13722222222".toCharArray();//keystory密码
/*		   String KEYSTORE="d://signed/马英文.pfx";
	       char[] PASSWORD = "1234".toCharArray();//keystory密码
		       String SRC="d://signed/04400150511115192418.pdf" ;//原始pdf
		       String DEST=SRC.replace(".pdf", "_box.pdf"); //"d://demo_signed_box.pdf" ;//签名完成的pdf
		       String DEST2=SRC.replace(".pdf", "_itext.pdf");//签名完成的pdf
		      String chapterPath="d://chapter.png";//签章图片
		      String signername="润成科技";
		      String reason="润成电子印章签名";
		      String location="珠海";
		*/
		
		
		   String KEYSTORE="E://certificate/pdfsign/贺志军.pfx";
	       char[] PASSWORD = "1234".toCharArray();//keystory密码
		       String SRC="E://certificate/pdfsign/src/电风扇440825199509103912.pdf" ;//原始pdf
		    //   String DEST=SRC.replace(".pdf", "_box.pdf"); //"d://demo_signed_box.pdf" ;//签名完成的pdf
		       String DEST2=SRC.replace(".pdf", "_itext.pdf");//签名完成的pdf
		      String chapterPath="E://certificate/pdfsign/src/runcheng2.gif";//签章图片
		      String signername="润成科技";
		      String reason="润成电子印章签名";
		      String location="珠海";
		
/*
	PdfSignBox.sign(PASSWORD, new FileInputStream(KEYSTORE),
			new FileInputStream(chapterPath), 
			new File(SRC),new File(DEST),signername, reason, location);	*/
	
	PdfSignItext.sign(new FileInputStream(SRC), new FileOutputStream(DEST2),
			new FileInputStream(KEYSTORE), PASSWORD, 
		 reason, location, chapterPath);
	}
}
