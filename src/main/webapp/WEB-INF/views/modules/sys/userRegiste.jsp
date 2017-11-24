<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户注册</title>
    <meta name="decorator" content="blank"/>
    <link href="/static/css/front/frontCss.css" rel="stylesheet" />
    <script src="/static/js/idCardNo.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            //验证手机号码格式
            jQuery.validator.addMethod("isMobile", function(value, element) {
                var length = value.length;
                var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
                return this.optional(element) || (length == 11 && mobile.test(value));
            }, "请正确填写您的手机号码");

            //验证手身份证号码格式格式
            jQuery.validator.addMethod("isIdCardNo", function (value, element) {
                return this.optional(element) || isIdCardNo(value);
            }, "请正确输入您的身份证号码");

            $("#no").focus();
            $("#inputForm").validate({
                rules: {
                    loginName: {
                        isIdCardNo: true,
                        remote: "${ctxFront}/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')
                    },
                    email:{
                        email: true
                    },
                    mobile : {
                        required : true,
                        minlength : 11,
                        // remote: "/f/checkmobile?mobile=" + encodeURIComponent('${user.mobile}')
                        isMobile : true
                    },
                    validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"},
                },
                messages: {
                    loginName: {
                        isIdCardNo:"请正确输入您的身份证号码",
                        remote: "用户登录名已存在"},
                    email:{
                        email:"请输入正确的邮箱格式"},
                    mobile : {
                        required : "请输入手机号",
                        minlength : "确认手机不能小于11个字符",
                        isMobile : "请正确填写您的手机号码"
                    },
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"},
                    validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
                },
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
    </script>
</head>
<body>
<div class="header">
    <div class="container">
        <h3 class="logo">电子证照系统</h3>
        <a class="back" href="/a">返回首页登录</a>
    </div>
</div>
<div class="container register">
    <div class="box register-box">
        <div class="box-title">用户注册</div>
        <form:form id="inputForm" modelAttribute="user" action="${ctxFront}/save" method="post"
                   class="form-horizontal register-form">
            <form:hidden path="id"/>
            <sys:message content="${message}"/>
            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;姓名:</label>
                <div class="controls">
                    <form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;登录名:</label>
                <div class="controls">
                    <form:input path="loginName" placeholder="请输入身份证号进行注册" htmlEscape="false"
                                maxlength="50" class="required userName"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;密码:</label>
                <div class="controls">
                    <input id="password" name="password" type="password" value="" maxlength="50" minlength="3"
                           class="${empty user.id?'required':''}"/>
                    <c:if test="${empty user.id}"><span class="help-inline"></span></c:if>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;确认密码:</label>
                <div class="controls">
                    <input id="confirmNewPassword" name="confirmNewPassword" type="password" value=""
                           maxlength="50" minlength="3" equalTo="#password"/>
                    <c:if test="${empty user.id}"><span class="help-inline"></span></c:if>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;手机:</label>
                <div class="controls">
                    <form:input path="mobile" htmlEscape="false" maxlength="100"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">邮箱:</label>
                <div class="controls">
                    <form:input path="email" htmlEscape="false" maxlength="100" class="email"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">电话:</label>
                <div class="controls">
                    <form:input path="phone" htmlEscape="false" maxlength="100"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;验证码:</label>
                   <div class="validateCode">
                        &nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label mid" for="validateCode"></label>
                        <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                    </div>
            </div>

            <div class="form-actions">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="注册"/>&nbsp;
                <input id="btnCancel" class="btn btn-primary" type="button" value="返回" onclick="history.go(-1)"/>
            </div>

        </form:form>
    </div>
</div>

<div class="fixed">
    <a href="javascript:;" class="tel">
        <div class="box">
            <p>客服电话：</p>
            <p>140202011026</p>
        </div>
    </a>
    <a href="javascript:;" class="wechat">
        <div class="box">
            <img src="/static/images/runcheng.jpg">
            <p>关注微信</p>
        </div>
    </a>
</div>
</body>
</html>
