package com.thinkgem.jeesite.modules.sign.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * Created by bb on 2017-11-11.
 */
public class Client{

    private Integer id;
    private String pdfid;//PDF文件id
    private String signseceret;//签名密钥
    private String ischeck;//是否通过验证(缺省值为1)



    public String getPdfid() {
        return pdfid;
    }

    public void setPdfid(String pdfid) {
        this.pdfid = pdfid;
    }


    public String getSignseceret() {
        return signseceret;
    }

    public void setSignseceret(String signseceret) {
        this.signseceret = signseceret;
    }


    public String getIscheck() {
        return ischeck;
    }

    public void setIscheck(String ischeck) {
        this.ischeck = ischeck;
    }

    public Integer getId() {
        return id;
    }
    public void setId(Integer id) {
        this.id = id;
    }
}
