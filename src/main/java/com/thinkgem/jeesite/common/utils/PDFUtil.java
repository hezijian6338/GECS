/**
 * Created by Macx on 2017/7/15.
 */
package com.thinkgem.jeesite.common.utils;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import com.thinkgem.jeesite.modules.certificate.entity.CertificateInfo;

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
     * @param date   日期
     * @param choice 返回参数
     * @return day 日
     */
    public static String extractYear(Date date, int choice) {
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
     * @param date   日期
     * @param choice 返回参数
     * @return month 月份
     */

    public static String extractEnYear(String date, int choice) {
        String year = date.substring(date.length() - 4, date.length());
        String monthDay = date.substring(0, date.length() - 4);
        if (choice == 1) {
            return year;
        } else {
            return monthDay;
        }
    }

    /**
     * 得到一个字符串的长度,显示的长度,一个汉字或日韩文长度为1,英文字符长度为0.5
     *
     * @return int 得到的字符串长度
     */
    public static double getLength(String s, int fontSize) {
        double valueLength = 0;
        String chinese = "[\u4e00-\u9fa5]";
        String number = "^[0-9]*$";
        // 获取字段值的长度，如果含中文字符，则每个中文字符长度为2，否则为1
        for (int i = 0; i < s.length(); i++) {
            // 获取一个字符
            String temp = s.substring(i, i + 1);
            // 判断是否为中文字符
            if (temp.matches(chinese)) {
                // 中文字符长度为1
                valueLength += 1.56;
                //System.out.println("中文:" + valueLength);
            } else if (temp.matches(number)) {
                // 数字字符长度为0.5
                valueLength += 0.45;
                //System.out.println("英文::" + valueLength);
            } else {
                //英文字符长度
                valueLength += 0.45;
            }
            if (temp.matches(" ")) {
                valueLength += 1.56;
                //System.out.println("空格:" + valueLength);
            }
        }

        return valueLength * fontSize;
    }

    public static String fillSpace(String value, int fontSize, double tfWidth) {
        // System.out.println("宽:" + tfWidth);
        if (getLength(value, fontSize) <= tfWidth) {
            double fill = tfWidth - getLength(value, fontSize);
            double fillSpace = fill / 2 * 1.56 / fontSize;
            //System.out.println(fill+"  "+fillSpace);
            for (int i = 1; i <= Math.ceil(fillSpace); i++) {
                value = " " + value;
            }
        }
        return value;
    }

    public static double isNull(AcroFields s, String name) {
        try {
            double width = s.getFieldPositions(name).get(0).position.getWidth();
            return width;
        } catch (NullPointerException e) {
            double width = 1;
            return width;
        }
    }

    public static void fillTemplate(CertificateInfo certificateInfo, String path, String outputFileName)
            throws IOException, DocumentException {

        PdfReader reader = new PdfReader(path); // 模版文件目录

        // String outputFileName = "E:\\pdf\\" + certificateInfo.getStuNo() + certificateInfo.getStuName() + ".pdf" ;
        PdfStamper ps = new PdfStamper(reader, new FileOutputStream(
                outputFileName)); // 生成的输出流

        AcroFields s = ps.getAcroFields();

        int index = 0;
        Map<String, AcroFields.Item> fieldMap = s.getFields();              // pdf表单相关信息展示

        for (Map.Entry<String, AcroFields.Item> entry : fieldMap.entrySet()) {

            System.out.print(index);
            String name = entry.getKey();                                   // name就是pdf模版中各个文本域的名字
            AcroFields.Item item = (AcroFields.Item) entry.getValue();
            System.out.println("[name]:" + name + ", [value]: " + item);
            index++;
        }
        ;

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


        //中文姓名 注入
        s.setFieldProperty("Name", "clrflags", 1, null);
        s.setFieldProperty("Name", "textfont", bfChinese, null);
        s.setFieldProperty("Name", "textsize", new Float(15), null);

        //姓(英) 注入
        s.setFieldProperty("EngFamilyName", "clrflags", 1, null);
        s.setFieldProperty("EngFamilyName", "textfont", bfChinese, null);
        s.setFieldProperty("EngFamilyName", "textsize", new Float(15), null);

        //名(英) 注入
        s.setFieldProperty("EngName", "clrflags", 1, null);
        s.setFieldProperty("EngName", "textfont", bfChinese, null);
        s.setFieldProperty("EngName", "textsize", new Float(15), null);

        //性别 注入
        s.setFieldProperty("Sex", "clrflags", 1, null);
        s.setFieldProperty("Sex", "textfont", bfChinese, null);
        s.setFieldProperty("Sex", "textsize", new Float(15), null);

        //性别(英) 注入
        s.setFieldProperty("EngSex", "clrflags", 1, null);
        s.setFieldProperty("EngSex", "textfont", bfChinese, null);
        s.setFieldProperty("EngSex", "textsize", new Float(15), null);

        //证照类型 注入
        s.setFieldProperty("certificateTypeId", "clrflags", 1, null);
        s.setFieldProperty("certificateTypeId", "textfont", bfChinese, null);
        s.setFieldProperty("certificateTypeId", "textsize", new Float(15), null);

        //证照编号 注入
        s.setFieldProperty("certificateCode", "clrflags", 1, null);
        s.setFieldProperty("certificateCode", "textfont", bfChinese, null);
        s.setFieldProperty("certificateCode", "textsize", new Float(15), null);

        //证照名称 注入
        s.setFieldProperty("certificateName", "clrflags", 1, null);
        s.setFieldProperty("certificateName", "textfont", bfChinese, null);
        s.setFieldProperty("certificateName", "textsize", new Float(15), null);

        //颁发机构id 注入
        s.setFieldProperty("office", "clrflags", 1, null);
        s.setFieldProperty("office", "textfont", bfChinese, null);
        s.setFieldProperty("office", "textsize", new Float(15), null);

        //成立日期 注入
        s.setFieldProperty("establishDate", "clrflags", 1, null);
        s.setFieldProperty("establishDate", "textfont", bfChinese, null);
        s.setFieldProperty("establishDate", "textsize", new Float(15), null);

        //证照有效期（起始） 注入
        s.setFieldProperty("effectiveDateStar", "clrflags", 1, null);
        s.setFieldProperty("effectiveDateStar", "textfont", bfChinese, null);
        s.setFieldProperty("effectiveDateStar", "textsize", new Float(15), null);

        //证照有效期（截至） 注入
        s.setFieldProperty("effectiveDateEnd", "clrflags", 1, null);
        s.setFieldProperty("effectiveDateEnd", "textfont", bfChinese, null);
        s.setFieldProperty("effectiveDateEnd", "textsize", new Float(15), null);

        //注册公司类型  注入
        s.setFieldProperty("registeredType", "clrflags", 1, null);
        s.setFieldProperty("registeredType", "textfont", bfChinese, null);
        s.setFieldProperty("registeredType", "textsize", new Float(15), null);

        //注册资本  注入
        s.setFieldProperty("registeredCapital", "clrflags", 1, null);
        s.setFieldProperty("registeredCapital", "textfont", bfChinese, null);
        s.setFieldProperty("registeredCapital", "textsize", new Float(15), null);

        //地址  注入
        s.setFieldProperty("address", "clrflags", 1, null);
        s.setFieldProperty("address", "textfont", bfChinese, null);
        s.setFieldProperty("address", "textsize", new Float(15), null);

        //法人姓名  注入
        s.setFieldProperty("persionName", "clrflags", 1, null);
        s.setFieldProperty("persionName", "textfont", bfChinese, null);
        s.setFieldProperty("persionName", "textsize", new Float(15), null);

        //法人身份证件类型  注入
        s.setFieldProperty("persionIdType", "clrflags", 1, null);
        s.setFieldProperty("persionIdType", "textfont", bfChinese, null);
        s.setFieldProperty("persionIdType", "textsize", new Float(15), null);

        //法人身份证件号码  注入
        s.setFieldProperty("personId", "clrflags", 1, null);
        s.setFieldProperty("personId", "textfont", bfChinese, null);
        s.setFieldProperty("personId", "textsize", new Float(15), null);

        //法人联系方式  注入
        s.setFieldProperty("persionPhone", "clrflags", 1, null);
        s.setFieldProperty("persionPhone", "textfont", bfChinese, null);
        s.setFieldProperty("persionPhone", "textsize", new Float(15), null);

        //经办人姓名  注入
        s.setFieldProperty("handlerName", "clrflags", 1, null);
        s.setFieldProperty("handlerName", "textfont", bfChinese, null);
        s.setFieldProperty("handlerName", "textsize", new Float(15), null);

        //经办人身份证件类型  注入
        s.setFieldProperty("handlerIdType", "clrflags", 1, null);
        s.setFieldProperty("handlerIdType", "textfont", bfChinese, null);
        s.setFieldProperty("handlerIdType", "textsize", new Float(15), null);

        //经办人身份证件号码  注入
        s.setFieldProperty("handlerId", "clrflags", 1, null);
        s.setFieldProperty("handlerId", "textfont", bfChinese, null);
        s.setFieldProperty("handlerId", "textsize", new Float(15), null);

        //经办人联系方式  注入
        s.setFieldProperty("handlerPhone", "clrflags", 1, null);
        s.setFieldProperty("handlerPhone", "textfont", bfChinese, null);
        s.setFieldProperty("handlerPhone", "textsize", new Float(15), null);

        //经营/业务/许可范围   注入
        s.setFieldProperty("scope", "clrflags", 1, null);
        s.setFieldProperty("scope", "textfont", bfChinese, null);
        s.setFieldProperty("scope", "textsize", new Float(15), null);

        //建筑名称  注入
        s.setFieldProperty("buildingName", "clrflags", 1, null);
        s.setFieldProperty("buildingName", "textfont", bfChinese, null);
        s.setFieldProperty("buildingName", "textsize", new Float(15), null);

        //层数  注入
        s.setFieldProperty("floorNumber", "clrflags", 1, null);
        s.setFieldProperty("floorNumber", "textfont", bfChinese, null);
        s.setFieldProperty("floorNumber", "textsize", new Float(15), null);

        //使用面积  注入
        s.setFieldProperty("useArea", "clrflags", 1, null);
        s.setFieldProperty("useArea", "textfont", bfChinese, null);
        s.setFieldProperty("useArea", "textsize", new Float(15), null);

        //使用情况  注入
        s.setFieldProperty("usage1", "clrflags", 1, null);
        s.setFieldProperty("usage1", "textfont", bfChinese, null);
        s.setFieldProperty("usage1", "textsize", new Float(15), null);

        //现有消防设施  注入
        s.setFieldProperty("dealfireFacilities", "clrflags", 1, null);
        s.setFieldProperty("dealfireFacilities", "textfont", bfChinese, null);
        s.setFieldProperty("dealfireFacilities", "textsize", new Float(15), null);

        //邮政编码  注入
        s.setFieldProperty("postcode", "clrflags", 1, null);
        s.setFieldProperty("postcode", "textfont", bfChinese, null);
        s.setFieldProperty("postcode", "textsize", new Float(15), null);

        //所属区域  注入
        s.setFieldProperty("area", "clrflags", 1, null);
        s.setFieldProperty("area", "textfont", bfChinese, null);
        s.setFieldProperty("area", "textsize", new Float(15), null);

        //向相关的文本域注入根据名字
        //        s.setField("Name", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"Name")));

        //        s.setField("EngFamilyName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"EngFamilyName")));

        //        s.setField("EngName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"EngName")));

        //        s.setField("Sex", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"Sex")));

        //        s.setField("EngSex", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"EngSex")));

        //        s.setField("certificateTypeId", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"certificateTypeId")));

        //        s.setField("certificateCode", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"certificateCode")));

        //        s.setField("certificateName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"certificateName")));

        //        s.setField("office", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"office")));

        //        s.setField("establishDate", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"establishDate")));

        //        s.setField("effectiveDateStar", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"effectiveDateStar")));

        //        s.setField("effectiveDateEnd", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"effectiveDateEnd")));

        //        s.setField("registeredType", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"registeredType")));

        //        s.setField("registeredCapital", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"registeredCapital")));

        //        s.setField("address", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"address")));

        //        s.setField("persionName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"persionName")));

        //        s.setField("persionIdType", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"persionIdType")));

        //        s.setField("personId", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"personId")));

        //        s.setField("persionPhone", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"persionPhone")));

        //        s.setField("handlerName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"handlerName")));

        //        s.setField("handlerIdType", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"handlerIdType")));

        //        s.setField("handlerId", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"handlerId")));

        //        s.setField("handlerPhone", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"handlerPhone")));

        //        s.setField("scope", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"scope")));

        //        s.setField("buildingName", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"buildingName")));

        //        s.setField("floorNumber", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"floorNumber")));

        //        s.setField("useArea", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"useArea")));

        //        s.setField("usage1", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"usage1")));

        //        s.setField("dealfireFacilities", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"dealfireFacilities")));

        //        s.setField("postcode", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"postcode")));

        //        s.setField("area", fillSpace(certificateInfo.getStuName() ,15 , isNull(s,"area")));

        ps.setFormFlattening(true); // 这句不能少
        ps.close();
        reader.close();
    }

}
