package com.thinkgem.jeesite.modules.sign.entity;

/**
 * Created by bb on 2017-11-11.
 */
public class JsonReturn {

    // 成功状态码
    public static final int SUCCESS_CODE = 200;

    // 失败状态码
    public static final int ERROR_CODE = 500;

    private int code;

    private String message;

    private String signseceret;

    public JsonReturn(){

    }

    public JsonReturn(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSignseceret() {
        return signseceret;
    }

    public void setSignseceret(String signseceret) {
        this.signseceret = signseceret;
    }
}
