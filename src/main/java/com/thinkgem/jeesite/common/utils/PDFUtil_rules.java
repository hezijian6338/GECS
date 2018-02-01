/**
 * Created by Macx on 2017/7/15.
 */
package com.thinkgem.jeesite.common.utils;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.pdf.AcroFields;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.thinkgem.jeesite.modules.conference.entity.CertificateConference;
import com.thinkgem.jeesite.modules.license.entity.BusinessLicense;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * 功能 PDF读写类
 *
 * @CreateTime 2011-4-14 下午02:44:11
 */
public class PDFUtil_rules {


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

    public static void fillTemplate(BusinessLicense businessLicense, CertificateConference certificateConference, String path, String outputFileName)
            throws IOException, DocumentException {
//        System.out.println("=========="+businessLicense.getEstablishDate());
        PdfReader reader = new PdfReader(path); // 模版文件目录

        //String outputFileName = "E:\\pdf\\" + BusinessLicense.getStuNo() + BusinessLicense.getStuName() + ".pdf" ;
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

//        // 图片路径获取
//        String imagePath = "E:/";
////        String imagePath = "E:/"+BusinessLicense.getStuImg();
//
//        // 通过域名获取所在页和坐标，左下角为起点
//        int pageNo = s.getFieldPositions("idPhoto").get(0).page;
//        Rectangle signRect = s.getFieldPositions("idPhoto").get(0).position;
//        s.setField("idPhoto", " ");
//        float x = signRect.getLeft();
//        float y = signRect.getBottom();
//        // 读图片
//        Image image = Image.getInstance(imagePath);
//        // 获取操作的页面
//        PdfContentByte under = ps.getOverContent(pageNo);
//        // 根据域的大小缩放图片
//        image.scaleToFit(signRect.getWidth(), signRect.getHeight());
//        // 添加图片
//        image.setAbsolutePosition(x, y);
//        under.addImage(image);

        DateFormat df = new SimpleDateFormat("yyyy年MM月dd日");

        s.addSubstitutionFont(bfChinese);


        //中文姓名 注入
        s.setFieldProperty("idName", "clrflags", 1, null);
        s.setFieldProperty("idName", "textfont", bfChinese, null);
        s.setFieldProperty("idName", "textsize", new Float(15), null);

        //姓(英) 注入
        s.setFieldProperty("idEngFamilyName", "clrflags", 1, null);
        s.setFieldProperty("idEngFamilyName", "textfont", bfChinese, null);
        s.setFieldProperty("idEngFamilyName", "textsize", new Float(15), null);

        //名(英) 注入
        s.setFieldProperty("idEngName", "clrflags", 1, null);
        s.setFieldProperty("idEngName", "textfont", bfChinese, null);
        s.setFieldProperty("idEngName", "textsize", new Float(15), null);

        //性别 注入
        s.setFieldProperty("idSex", "clrflags", 1, null);
        s.setFieldProperty("idSex", "textfont", bfChinese, null);
        s.setFieldProperty("idSex", "textsize", new Float(15), null);

        //性别(英) 注入
        s.setFieldProperty("idEngSex", "clrflags", 1, null);
        s.setFieldProperty("idEngSex", "textfont", bfChinese, null);
        s.setFieldProperty("idEngSex", "textsize", new Float(15), null);

        //证照类型 注入
        s.setFieldProperty("idcertificateType", "clrflags", 1, null);
        s.setFieldProperty("idcertificateType", "textfont", bfChinese, null);
        s.setFieldProperty("idcertificateType", "textsize", new Float(15), null);

 /*       //证照编号 注入
        s.setFieldProperty("idcertificateCode", "clrflags", 1, null);
        s.setFieldProperty("idcertificateCode", "textfont", bfChinese, null);
        s.setFieldProperty("idcertificateCode", "textsize", new Float(15), null);*/

        //证照名称 注入
        s.setFieldProperty("idcertificateName", "clrflags", 1, null);
        s.setFieldProperty("idcertificateName", "textfont", bfChinese, null);
        s.setFieldProperty("idcertificateName", "textsize", new Float(15), null);

        //颁发机构id 注入
        s.setFieldProperty("idoffice", "clrflags", 1, null);
        s.setFieldProperty("idoffice", "textfont", bfChinese, null);
        s.setFieldProperty("idoffice", "textsize", new Float(15), null);

        //统一社会信用代码 注入
        s.setFieldProperty("idcertificateCode", "clrflags", 1, null);
        s.setFieldProperty("idcertificateCode", "textfont", bfChinese, null);
        s.setFieldProperty("idcertificateCode", "textsize", new Float(15), null);

        //成立日期 注入
        s.setFieldProperty("idestablishDate", "clrflags", 1, null);
        s.setFieldProperty("idestablishDate", "textfont", bfChinese, null);
        s.setFieldProperty("idestablishDate", "textsize", new Float(15), null);

        //成立日期（年） 注入
        s.setFieldProperty("idestablishDateYear", "clrflags", 1, null);
        s.setFieldProperty("idestablishDateYear", "textfont", bfChinese, null);
        s.setFieldProperty("idestablishDateYear", "textsize", new Float(15), null);

        //成立日期（月） 注入
        s.setFieldProperty("idestablishDateMonth", "clrflags", 1, null);
        s.setFieldProperty("idestablishDateMonth", "textfont", bfChinese, null);
        s.setFieldProperty("idestablishDateMonth", "textsize", new Float(15), null);

        //成立日期（日） 注入
        s.setFieldProperty("idestablishDateDay", "clrflags", 1, null);
        s.setFieldProperty("idestablishDateDay", "textfont", bfChinese, null);
        s.setFieldProperty("idestablishDateDay", "textsize", new Float(15), null);

        //证照有效期（起始） 注入
        s.setFieldProperty("ideffectiveDateStar", "clrflags", 1, null);
        s.setFieldProperty("ideffectiveDateStar", "textfont", bfChinese, null);
        s.setFieldProperty("ideffectiveDateStar", "textsize", new Float(15), null);

        //证照有效期（截至） 注入
        s.setFieldProperty("ideffectiveDateEnd", "clrflags", 1, null);
        s.setFieldProperty("ideffectiveDateEnd", "textfont", bfChinese, null);
        s.setFieldProperty("ideffectiveDateEnd", "textsize", new Float(15), null);

        //注册公司类型  注入
        s.setFieldProperty("idregisteredType", "clrflags", 1, null);
        s.setFieldProperty("idregisteredType", "textfont", bfChinese, null);
        s.setFieldProperty("idregisteredType", "textsize", new Float(15), null);

        //注册资本  注入
        s.setFieldProperty("idregisteredCapital", "clrflags", 1, null);
        s.setFieldProperty("idregisteredCapital", "textfont", bfChinese, null);
        s.setFieldProperty("idregisteredCapital", "textsize", new Float(15), null);

        //地址  注入
        s.setFieldProperty("idaddress", "clrflags", 1, null);
        s.setFieldProperty("idaddress", "textfont", bfChinese, null);
        s.setFieldProperty("idaddress", "textsize", new Float(15), null);

        //法人姓名  注入
        s.setFieldProperty("idpersionName", "clrflags", 1, null);
        s.setFieldProperty("idpersionName", "textfont", bfChinese, null);
        s.setFieldProperty("idpersionName", "textsize", new Float(15), null);

        //法人身份证件类型  注入
        s.setFieldProperty("idpersionIdType", "clrflags", 1, null);
        s.setFieldProperty("idpersionIdType", "textfont", bfChinese, null);
        s.setFieldProperty("idpersionIdType", "textsize", new Float(15), null);

        //法人身份证件号码  注入
        s.setFieldProperty("idpersonId", "clrflags", 1, null);
        s.setFieldProperty("idpersonId", "textfont", bfChinese, null);
        s.setFieldProperty("idpersonId", "textsize", new Float(15), null);

        //法人联系方式  注入
        s.setFieldProperty("idpersionPhone", "clrflags", 1, null);
        s.setFieldProperty("idpersionPhone", "textfont", bfChinese, null);
        s.setFieldProperty("idpersionPhone", "textsize", new Float(15), null);

        //经办人姓名  注入
        s.setFieldProperty("idhandlerName", "clrflags", 1, null);
        s.setFieldProperty("idhandlerName", "textfont", bfChinese, null);
        s.setFieldProperty("idhandlerName", "textsize", new Float(15), null);

        //经办人身份证件类型  注入
        s.setFieldProperty("idhandlerIdType", "clrflags", 1, null);
        s.setFieldProperty("idhandlerIdType", "textfont", bfChinese, null);
        s.setFieldProperty("idhandlerIdType", "textsize", new Float(15), null);

        //经办人身份证件号码  注入
        s.setFieldProperty("idhandlerId", "clrflags", 1, null);
        s.setFieldProperty("idhandlerId", "textfont", bfChinese, null);
        s.setFieldProperty("idhandlerId", "textsize", new Float(15), null);

        //经办人联系方式  注入
        s.setFieldProperty("idhandlerPhone", "clrflags", 1, null);
        s.setFieldProperty("idhandlerPhone", "textfont", bfChinese, null);
        s.setFieldProperty("idhandlerPhone", "textsize", new Float(15), null);

        //经营/业务/许可范围   注入
        s.setFieldProperty("idscope", "clrflags", 1, null);
        s.setFieldProperty("idscope", "textfont", bfChinese, null);
        s.setFieldProperty("idscope", "textsize", new Float(15), null);

        //建筑名称  注入
        s.setFieldProperty("idbuildingName", "clrflags", 1, null);
        s.setFieldProperty("idbuildingName", "textfont", bfChinese, null);
        s.setFieldProperty("idbuildingName", "textsize", new Float(15), null);

        //层数  注入
        s.setFieldProperty("idfloorNumber", "clrflags", 1, null);
        s.setFieldProperty("idfloorNumber", "textfont", bfChinese, null);
        s.setFieldProperty("idfloorNumber", "textsize", new Float(15), null);

        //使用面积  注入
        s.setFieldProperty("iduseArea", "clrflags", 1, null);
        s.setFieldProperty("iduseArea", "textfont", bfChinese, null);
        s.setFieldProperty("iduseArea", "textsize", new Float(15), null);

        //使用情况  注入
        s.setFieldProperty("idusage1", "clrflags", 1, null);
        s.setFieldProperty("idusage1", "textfont", bfChinese, null);
        s.setFieldProperty("idusage1", "textsize", new Float(15), null);

        //现有消防设施  注入
        s.setFieldProperty("iddealfireFacilities", "clrflags", 1, null);
        s.setFieldProperty("iddealfireFacilities", "textfont", bfChinese, null);
        s.setFieldProperty("iddealfireFacilities", "textsize", new Float(15), null);

        //邮政编码  注入
        s.setFieldProperty("idpostcode", "clrflags", 1, null);
        s.setFieldProperty("idpostcode", "textfont", bfChinese, null);
        s.setFieldProperty("idpostcode", "textsize", new Float(15), null);

        //所属区域  注入
        s.setFieldProperty("idarea", "clrflags", 1, null);
        s.setFieldProperty("idarea", "textfont", bfChinese, null);
        s.setFieldProperty("id0area", "textsize", new Float(15), null);

        //以下是公司章程模板注入：
        //公司名称注入
        s.setField("idcompanyNameTitle", fillSpace(businessLicense.getCertificateName() ,10 , isNull(s,"idcompanyNameTitle")));

        //公司名称注入
        s.setField("idcompanyNameContext", fillSpace(businessLicense.getCertificateName() ,10 , isNull(s,"idcompanyNameContext")));

        //场所注入
        s.setField("idcompanyAddr", fillSpace(businessLicense.getAddress() ,10 , isNull(s,"idcompanyAddr")));

        //经营范围
        s.setField("idmanageRange", fillSpace(String.valueOf(businessLicense.getScope().getName()),10 , isNull(s,"idmanageRange")));

        //注册金额注入
        s.setField("idregisterFund", fillSpace(businessLicense.getRegisteredCapital() ,10 , isNull(s,"idregisterFund")));

        //股东人数注入
        s.setField("idshareholderNum", fillSpace(certificateConference.getShareholdersNum() ,10 , isNull(s,"idshareholderNum")));

        //股东姓名注入
        s.setField("idname1", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getName() ,10 , isNull(s,"idname1")));

        //股东性别注入
        s.setField("idsex", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getSex() ,10 , isNull(s,"idsex")));

        //股东年龄注入
        s.setField("idage", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getAge() ,10 , isNull(s,"idage")));

        //股东籍贯注入
        s.setField("idplaceOrigin", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getPlaceOrigin() ,10 , isNull(s,"idplaceOrigin")));

        //股东户口所在地注入
        s.setField("residence", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getResidence() ,10 , isNull(s,"residence")));

        //股东姓名注入
        s.setField("idname2", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getName() ,10 , isNull(s,"idname2")));

        //货币出资注入
        s.setField("idcurrency", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getCurrency() ,10 , isNull(s,"idcurrency")));

        //出资类型注入
        s.setField("idcontributionType", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getContributionType() ,10 , isNull(s,"idcontributionType")));

        //作价出资注入
        s.setField("idcontributionPrice", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getContributionPrice() ,10 , isNull(s,"idcontributionPrice")));

        //总认缴出资注入
        s.setField("idtotalPrice", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getTotalPrice() ,10 , isNull(s,"idtotalPrice")));

        //占公司注册资本注入
        s.setField("idsg1", fillSpace(certificateConference.getCertificateConferenceSubList().get(0).getSg() ,10 , isNull(s,"idsg1")));

        String dateTime = (new SimpleDateFormat("yyyy年MM月dd日")).format(new Date());

        //s.setField("dateTime", fillSpace(dateTime ,10 , isNull(s,"dateTime")));

        ps.setFormFlattening(true); // 这句不能少
        ps.close();
        reader.close();
    }

}