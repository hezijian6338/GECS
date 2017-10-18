<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>用户注册</title>
    <meta name="decorator" content="default"/>
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
                        remote: "/f/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')
                    },
                    email:{
                        required: true,
                        email: true
                    },
                    mobile : {
                        required : true,
                        minlength : 11,
                        // remote: "/f/checkmobile?mobile=" + encodeURIComponent('${user.mobile}')
                        isMobile : true
                    },
                },
                messages: {
                    loginName: {
                        isIdCardNo:"请正确输入您的身份证号码",
                        remote: "用户登录名已存在"},
                    email:{
                        required:"请输入邮箱",
                        email:"请输入正确的邮箱格式"},
                    mobile : {
                        required : "请输入手机号",
                        minlength : "确认手机不能小于11个字符",
                        isMobile : "请正确填写您的手机号码"
                    },
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
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

        //增加身份证验证
        function isIdCardNo(num) {
            var factorArr = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1);
            var parityBit = new Array("1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2");
            var varArray = new Array();
            var intValue;
            var lngProduct = 0;
            var intCheckDigit;
            var intStrLen = num.length;
            var idNumber = num;
            // initialize
            if ((intStrLen != 15) && (intStrLen != 18)) {
                return false;
            }
            // check and set value
            for (i = 0; i < intStrLen; i++) {
                varArray[i] = idNumber.charAt(i);
                if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
                    return false;
                } else if (i < 17) {
                    varArray[i] = varArray[i] * factorArr[i];
                }
            }
            if (intStrLen == 18) {
                //check date
                var date8 = idNumber.substring(6, 14);
                if (isDate8(date8) == false) {
                    return false;
                }
                // calculate the sum of the products
                for (i = 0; i < 17; i++) {
                    lngProduct = lngProduct + varArray[i];
                }
                // calculate the check digit
                intCheckDigit = parityBit[lngProduct % 11];
                // check last digit
                if (varArray[17] != intCheckDigit) {
                    return false;
                }
            }
            else {        //length is 15
                //check date
                var date6 = idNumber.substring(6, 12);
                if (isDate6(date6) == false) {
                    return false;
                }
            }
            return true;
        }
        function isDate6(sDate) {
            if (!/^[0-9]{6}$/.test(sDate)) {
                return false;
            }
            var year, month, day;
            year = sDate.substring(0, 4);
            month = sDate.substring(4, 6);
            if (year < 1700 || year > 2500) return false
            if (month < 1 || month > 12) return false
            return true
        }

        function isDate8(sDate) {
            if (!/^[0-9]{8}$/.test(sDate)) {
                return false;
            }
            var year, month, day;
            year = sDate.substring(0, 4);
            month = sDate.substring(4, 6);
            day = sDate.substring(6, 8);
            var iaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            if (year < 1700 || year > 2500) return false
            if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1] = 29;
            if (month < 1 || month > 12) return false
            if (day < 1 || day > iaMonthDays[month - 1]) return false
            return true
        }

    </script>

    <meta name="decorator" content="default"/>
    <style>
        .header{ height:60px; color:#fff; background:#5191FF;}
        .logo{ line-height:60px; float:left; color:#fff;}
        .back{ line-height:60px; float:right; color:#fff;}
        .back:hover{ color:#fff;}
        .register{ margin-top:25px;}
        .register-box{ padding:30px 70px;}
        .register-form{ width:700px; margin:auto; padding:30px 0;}
        .examine{ width:100%; height:100%; background:rgba(0,0,0,0.4); position:fixed; left:0; top:0; display:none;}
        .examine-box{ width:240px; height:320px; background:#fff; border-radius:2px; padding:40px 80px; box-shadow:0 0 20px #666; text-align:center; position:absolute; left:50%; top:50%; margin:-200px 0 0 -200px;}
        .examine-box h3{ margin-bottom:15px;}
        .examine-box p{ line-height:26px; font-size:16px; margin-bottom:30px;}
        .examine-box .btn{ width:150px; padding:12px; font-size:16px;}

        /* fixed */
        .fixed {
            position: fixed;
            right: 10px;
            bottom: 200px;
        }
        .fixed a {
            color: #fff;
            width: 50px;
            height: 50px;
            display: block;
            background-size: cover;
            position: relative;
        }
        .fixed a .box {
            font-size: 14px;
            padding: 10px;
            background-color: rgba(0, 0, 0, .6);
            border-radius: 4px;
            display: none;
            position: absolute;
            left: -180px;
            top: -50px;
        }
        .fixed a:hover .box {
            display: block;
        }
        .fixed a .box p {
            margin: 5px 0 0 0;
        }
    </style>
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
        <form:form id="inputForm" modelAttribute="user" action="/f/save" method="post" class="form-horizontal register-form">
            <form:hidden path="id"/>
            <sys:message content="${message}"/>
            <div class="control-group">
                <label class="control-label">姓名:</label>
                <div class="controls">
                    <form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">登录名:</label>
                <div class="controls">
                    <form:input path="loginName" placeholder="请输入身份证号进行注册" htmlEscape="false" maxlength="50" class="required userName"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">密码:</label>
                <div class="controls">
                    <input id="password" name="password" type="password" value="" maxlength="50" minlength="3" class="${empty user.id?'required':''}"/>
                    <c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">确认密码:</label>
                <div class="controls">
                    <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" equalTo="#password"/>
                    <c:if test="${empty user.id}"><span class="help-inline"><font color="red">*</font> </span></c:if>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">邮箱:</label>
                <div class="controls">
                    <form:input path="email" htmlEscape="false" maxlength="100" class="email"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">电话:</label>
                <div class="controls">
                    <form:input path="phone" htmlEscape="false" maxlength="100"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">手机:</label>
                <div class="controls">
                    <form:input path="mobile" htmlEscape="false" maxlength="100"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">验证码:</label>
                <div class="validateCode">
                    &nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label mid" for="validateCode"></label>
                    <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                </div>
            </div>

            <div class="form-actions">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="注册"/>&nbsp;
                <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
            </div>

        </form:form>
    </div>
</div>
</body>
</html>
