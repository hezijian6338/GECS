package com.thinkgem.jeesite.test.web;

/**
 * 全国组织机构代码校验码生成程序
 * 00251805 7 中共温州市委办公室
 * 00251807 3 中共温州市委组织部
 * 00251808 1 中共温州市委老干部局 沈伟 2002-04-09 2008-05-05 0.0000 详细
 * 00251809 X
 **/
public class test111 {
    public static char[] a = new char[8];

    public String jy(char[] a) {
        int[] ww = { 3, 7, 9, 10, 5, 8, 4, 2 };

        int[] cc = new int[8];
        int DD = 0;
        int C9 = 0;

        for (int i = 0; i < 8; i++) {
            cc[i] = a[i];
            if (47 < cc[i] && cc[i] < 58)
                cc[i] = cc[i] - 48;
            else
                cc[i] = cc[i] - 65;
        }
        for (int i = 0; i < 8; i++) {
            DD += cc[i] * ww[i];
        }
        C9 = 11 - DD % 11;
        if (C9 == 10) {
            for (int i = 0; i < 8; i++)
                System.out.print(test111.a[i]);
            System.out.println("-X");
            return new String(a) + "-X";
        } else if (C9 == 11) {
            for (int i = 0; i < 8; i++)
                System.out.print(test111.a[i]);
            System.out.println("-" + (char) (48));
            return new String(a) + "-" + (char) (48);
        } else {
            for (int i = 0; i < 8; i++)
                System.out.print(test111.a[i]);
            System.out.println("-" + (char) (C9 + 48));
            return new String(a) + "-" + (char) (C9 + 48);
        }

    }
	 public static void main(String[] args){

	  System.out.println("请输入长8位的本体代码！");

         a[0]='0';
         a[1]='0';
         a[2]='2';
         a[3]='5';
         a[4]='1';
         a[5]='8';
         a[6]='0';
         a[7]='9';
         for(int i=0;i<8;i++){

             System.out.println("分别为："+a[i]);
         }

         test111 G=new test111();
	     G.jy(a);

	  }
}
