/**
 * Created by Macx on 2017/7/15.
 */
package com.thinkgem.jeesite.common.utils;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import com.thinkgem.jeesite.modules.certificate.entity.CertificateInfo ;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * 功能 PDF读写类
 *
 * @CreateTime 2011-4-14 下午02:44:11
 */
public class PDFUtil {


    //  public static final String CHARACTOR_FONT_CH_FILE = "SIMFANG.TTF";  //仿宋常规
//    public static final String CHARACTOR_FONT_CH_FILE = "C:\\Users\\Administrator\\Desktop\\graduate\\Graduation\\src\\main\\resources\\SIMHEI.TTF";  //黑体常规
    public static final String CHARACTOR_FONT_CH_FILE = "E:\\util\\simhei.ttf";


    /**
     * 功能：创造字体格式
     *
     * @param fontname
     * @param size     字体大小
     * @param style    字体风格
     * @param color    字体颜色
     * @return Font
     */
    public static Font createFont(String fontname, float size, int style, BaseColor color) {
        Font font = FontFactory.getFont(fontname, size, style, color);
        return font;
    }

    /**
     * 功能： 返回支持中文的字体---仿宋
     *
     * @param size  字体大小
     * @param style 字体风格
     * @param color 字体 颜色
     * @return 字体格式
     */
    public static Font createCHineseFont(float size, int style, BaseColor color) {
        BaseFont bfChinese = null;
        try {
            bfChinese = BaseFont.createFont(CHARACTOR_FONT_CH_FILE, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);
        } catch (DocumentException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new Font(bfChinese, size, style, color);
    }

    /**
     * 功能： 中文分离日期
     *
     * @param date  日期
     * @param choice 返回参数
     * @return year 年份
     * @return month 月份
     * @return day 日
     */
    public static String extractYear( Date date,int choice){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String tempDate = format.format(date);
        String year = tempDate.substring(0, 4);
        String month = tempDate.substring(5, 7);
        String day = tempDate.substring(8, 10);
        //System.out.println(year +"**"+ month +"&&"+ day );
        if (choice == 1) {
            return year;
        } else if (choice == 2) {
            return month;
        } else {
            return day;
        }

    }

    /**
     * 功能： 英文分离日期
     *
     * @param date  日期
     * @param choice 返回参数
     * @return year 年份
     * @return month 月份
     */

    public static String extractEnYear(String date, int choice){
        String year = date.substring(date.length()-4,date.length());
        String monthDay = date.substring(0,date.length()-4);
        if(choice == 1){
            return year ;
        }else{
            return monthDay ;
        }
    }

    /**
     * 得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为1,英文字符长度为0.5
     * @param String s 需要得到长度的字符串
     * @return int 得到的字符串长度
     */
    public static double getLength(String s,int fontSize) {
        double valueLength = 0;
        String chinese = "[\u4e00-\u9fa5]";
        String number = "^[0-9]*$" ;
        // 获取字段值的长度，如果含中文字符，则每个中文字符长度为2，否则为1
        for (int i = 0; i < s.length(); i++) {
            // 获取一个字符
            String temp = s.substring(i, i + 1);
            // 判断是否为中文字符
            if (temp.matches(chinese)) {
                // 中文字符长度为1
                valueLength += 1.56;
                //System.out.println("中文:" + valueLength);
            } else  if(temp.matches(number)){
                // 数字字符长度为0.5
                valueLength += 0.45;
                //System.out.println("英文::" + valueLength);
            }else{
                //英文字符长度
                valueLength += 0.45;
            }
            if(temp.matches(" ")){
                valueLength += 1.56;
                //System.out.println("空格:" + valueLength);
            }
        }

        return  valueLength * fontSize ;
    }

    public static String fillSpace(String value ,int fontSize ,double tfWidth){
       // System.out.println("宽:" + tfWidth);
        if(getLength(value,fontSize) <= tfWidth){
            double fill = tfWidth - getLength(value,fontSize) ;
            double fillSpace = fill / 2 * 1.56 / fontSize;
            //System.out.println(fill+"  "+fillSpace);
            for(int i =1 ;i <=  Math.ceil(fillSpace) ;i ++){
                value = " "+value ;
            }
        }
        return value ;
    }

    public static double isNull(AcroFields s,String name){
        try{
            double width = s.getFieldPositions(name).get(0).position.getWidth();
            return width ;
        }catch(NullPointerException e){
            double width = 1 ;
            return width ;
        }
    }

    public static void fillTemplate (CertificateInfo certificateInfo,String path,String outputFileName)
            throws IOException, DocumentException {

        PdfReader reader = new PdfReader(path); // 模版文件目录

       // String outputFileName = "E:\\pdf\\" + certificateInfo.getStuNo() + certificateInfo.getStuName() + ".pdf" ;
        PdfStamper ps = new PdfStamper(reader, new FileOutputStream(
                outputFileName)); // 生成的输出流

        AcroFields s = ps.getAcroFields();

        int index = 0 ;
        Map<String, AcroFields.Item> fieldMap = s.getFields();              // pdf表单相关信息展示

        for (Map.Entry<String, AcroFields.Item> entry : fieldMap.entrySet()) {

            System.out.print(index);
            String name = entry.getKey();                                   // name就是pdf模版中各个文本域的名字
            AcroFields.Item item = (AcroFields.Item) entry.getValue();
            System.out.println("[name]:" + name + ", [value]: " + item);
            index++;
        };

        BaseFont bfChinese = BaseFont.createFont(CHARACTOR_FONT_CH_FILE, BaseFont.IDENTITY_H, BaseFont.EMBEDDED);

        // 图片路径获取
       String imagePath = "E:/";
//        String imagePath = "E:/"+certificateInfo.getStuImg();

        // 通过域名获取所在页和坐标，左下角为起点
        int pageNo = s.getFieldPositions("idPhoto").get(0).page;
        Rectangle signRect = s.getFieldPositions("idPhoto").get(0).position;
        s.setField("idPhoto", " ");
        float x = signRect.getLeft();
        float y = signRect.getBottom();
        // 读图片
        Image image = Image.getInstance(imagePath);
        // 获取操作的页面
        PdfContentByte under = ps.getOverContent(pageNo);
        // 根据域的大小缩放图片
        image.scaleToFit(signRect.getWidth(), signRect.getHeight());
        // 添加图片
        image.setAbsolutePosition(x, y);
        under.addImage(image);


        s.addSubstitutionFont(bfChinese);


        //中文姓名注入
        s.setFieldProperty("idName","clrflags",1,null) ;
        s.setFieldProperty("idName","textfont",bfChinese,null) ;
        s.setFieldProperty("idName","textsize",new Float(15),null) ;

        //中文性别注入
        s.setFieldProperty("idSex","clrflags",1,null) ;
        s.setFieldProperty("idSex","textfont",bfChinese,null) ;
        s.setFieldProperty("idSex","textsize",new Float(15),null) ;

        //中文出生年份注入
        s.setFieldProperty("idBirthYear","clrflags",1,null) ;
        s.setFieldProperty("idBirthYear","textfont",bfChinese,null) ;
        s.setFieldProperty("idBirthYear","textsize",new Float(15),null) ;

        //中文出生月份注入
        s.setFieldProperty("idBirthMonth","clrflags",1,null) ;
        s.setFieldProperty("idBirthMonth","textfont",bfChinese,null) ;
        s.setFieldProperty("idBirthMonth","textsize",new Float(15),null) ;

        //中文出生日份注入
        s.setFieldProperty("idBirthDay","clrflags",1,null) ;
        s.setFieldProperty("idBirthDay","textfont",bfChinese,null) ;
        s.setFieldProperty("idBirthDay","textsize",new Float(15),null) ;

        //入学年份注入
        s.setFieldProperty("idStuYear","clrflags",1,null) ;
        s.setFieldProperty("idStuYear","textfont",bfChinese,null) ;
        s.setFieldProperty("idStuYear","textsize",new Float(15),null) ;

        //入学月份注入
        s.setFieldProperty("idStuMonth","clrflags",1,null) ;
        s.setFieldProperty("idStuMonth","textfont",bfChinese,null) ;
        s.setFieldProperty("idStuMonth","textsize",new Float(15),null) ;

        //毕业年份注入
        s.setFieldProperty("idGraYear","clrflags",1,null) ;
        s.setFieldProperty("idGraYear","textfont",bfChinese,null) ;
        s.setFieldProperty("idGraYear","textsize",new Float(15),null) ;

        //毕业月份注入
        s.setFieldProperty("idGraMonth","clrflags",1,null) ;
        s.setFieldProperty("idGraMonth","textfont",bfChinese,null) ;
        s.setFieldProperty("idGraMonth","textsize",new Float(15),null) ;

        //中文专业注入
        s.setFieldProperty("idMajor","clrflags",1,null) ;
        s.setFieldProperty("idMajor","textfont",bfChinese,null) ;
        s.setFieldProperty("idMajor","textsize",new Float(15),null) ;

        //英文姓注入
        s.setFieldProperty("idEngFamilyName","clrflags",1,null) ;
        s.setFieldProperty("idEngFamilyName","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngFamilyName","textsize",new Float(15),null) ;

        //英文名注入
        s.setFieldProperty("idEngName","clrflags",1,null) ;
        s.setFieldProperty("idEngName","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngName","textsize",new Float(13),null) ;

        //英文性别注入
        s.setFieldProperty("idEngSex","clrflags",1,null) ;
        s.setFieldProperty("idEngSex","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngSex","textsize",new Float(13),null) ;


        //英文出生年份注入
        s.setFieldProperty("idEngBirthYear","clrflags",1,null) ;
        s.setFieldProperty("idEngBirthYear","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngBirthYear","textsize",new Float(15),null) ;

        //英文出生日期注入
        s.setFieldProperty("idEngBirthDay","clrflags",1,null) ;
        s.setFieldProperty("idEngBirthDay","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngBirthDay","textsize",new Float(15),null) ;

        //英文专业注入
        s.setFieldProperty("idEngMajor","clrflags",1,null) ;
        s.setFieldProperty("idEngMajor","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngMajor","textsize",new Float(15),null) ;

        //颁发日期年份注入
        s.setFieldProperty("idMakeYear","clrflags",1,null) ;
        s.setFieldProperty("idMakeYear","textfont",bfChinese,null) ;
        s.setFieldProperty("idMakeYear","textsize",new Float(15),null) ;

        //颁发日期月份注入
        s.setFieldProperty("idMakeMonth","clrflags",1,null) ;
        s.setFieldProperty("idMakeMonth","textfont",bfChinese,null) ;
        s.setFieldProperty("idMakeMonth","textsize",new Float(15),null) ;


        //颁发日期日注入
        s.setFieldProperty("idMakeDay","clrflags",1,null) ;
        s.setFieldProperty("idMakeDay","textfont",bfChinese,null) ;
        s.setFieldProperty("idMakeDay","textsize",new Float(15),null) ;

        //第二个位置的专业注入
        s.setFieldProperty("idMajor1","clrflags",1,null) ;
        s.setFieldProperty("idMajor1","textfont",bfChinese,null) ;
        s.setFieldProperty("idMajor1","textsize",new Float(15),null) ;

        //第二个位置的英语专业注入
        s.setFieldProperty("idEngMajor1","clrflags",1,null) ;
        s.setFieldProperty("idEngMajor1","textfont",bfChinese,null) ;
        s.setFieldProperty("idEngMajor1","textsize",new Float(15),null) ;

        //毕业证书编号注入
        s.setFieldProperty("idGraNo","clrflags",1,null) ;
        s.setFieldProperty("idGraNo","textfont",bfChinese,null) ;
        s.setFieldProperty("idGraNo","textsize",new Float(15),null) ;

        //学位证书编号注入
        s.setFieldProperty("idDgeNo","clrflags",1,null) ;
        s.setFieldProperty("idDgeNo","textfont",bfChinese,null) ;
        s.setFieldProperty("idDgeNo","textsize",new Float(15),null) ;

        //向相关的文本域注入根据名字
//        s.setField("idName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"idName")));
//        s.setField("idSex", fillSpace(certificateInfo.getSex() ,15 , isNull(s,"idSex")));
//        s.setField("idBirthYear", fillSpace(extractYear(certificateInfo.getBirthday(),1),15 , isNull(s,"idBirthYear")));
//        s.setField("idBirthMonth", fillSpace(extractYear(certificateInfo.getBirthday(),2),15 , isNull(s,"idBirthMonth")));
//        s.setField("idBirthDay", fillSpace(extractYear(certificateInfo.getBirthday(),3),15 ,isNull(s,"idBirthDay")));
//        s.setField("idStuYear", fillSpace(extractYear(certificateInfo.getAcceptanceDate(),1),15 , isNull(s,"idStuYear")));
//        s.setField("idStuMonth",fillSpace(extractYear(certificateInfo.getAcceptanceDate(),2),15 , isNull(s,"idStuMonth")));
//        s.setField("idGraYear",fillSpace(extractYear(certificateInfo.getGraduationDate(),1),15 , isNull(s,"idGraYear")));
//        s.setField("idGraMonth",fillSpace(extractYear(certificateInfo.getGraduationDate(),2),15 , isNull(s,"idGraMonth")));
//        s.setField("idMajor",fillSpace(certificateInfo.getMajorName(),15 , isNull(s,"idMajor")));
//        s.setField("idEngFamilyName",fillSpace(certificateInfo.getLastNameEn(),15 , isNull(s,"idEngFamilyName")));
//        s.setField("idEngName",fillSpace(certificateInfo.getFirstNameEn(),15 , isNull(s,"idEngName")));
//        s.setField("idMajor1",fillSpace(certificateInfo.getMajorName(),13 ,isNull(s,"idMajor1")));
//        s.setField("idEngMajor1",fillSpace(certificateInfo.getMajorNameEn(),15 , isNull(s,"idEngMajor1")));
//        s.setField("idEngSex",fillSpace(certificateInfo.getSexEn(),13 , isNull(s,"idEngSex")));
//        s.setField("idEngBirthYear",fillSpace(extractEnYear(certificateInfo.getBirthdayEn(),1),15 , isNull(s,"idEngBirthYear")));
//        s.setField("idEngBirthDay",fillSpace(extractEnYear(certificateInfo.getBirthdayEn(),2),15 , isNull(s,"idEngBirthDay")));
//        s.setField("idEngMajor",fillSpace(certificateInfo.getMajorNameEn(),15 , isNull(s,"idEngMajor")));
//        s.setField("idMakeYear",fillSpace(extractYear(new Date(),1),15 , isNull(s,"idMakeYear")));
//        s.setField("idMakeMonth",fillSpace(extractYear(new Date(),2),15 , isNull(s,"idMakeMonth")));
//        s.setField("idMakeDay",fillSpace(extractYear(new Date(),3),15 , isNull(s,"idMakeDay")));
//        s.setField("idGraNo", fillSpace(certificateInfo.getGraCertificateNo(),15 , isNull(s,"idGraNo")));
//        s.setField("idDgeNo", fillSpace(certificateInfo.getGraCertificateNo(),15 , isNull(s,"idDgeNo")));

        ps.setFormFlattening(true); // 这句不能少
        ps.close();
        reader.close();
    }

}
