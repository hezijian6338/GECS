<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>忘记密码</title>
    <meta name="decorator" content="blank"/>
    <link href="/static/css/front/frontCss.css" rel="stylesheet" />
    <style>
        button.btn {
        }
        .btn, a.btn, button.btn {
            padding: 8px 15px;
            outline: none;
            border-image: none;
            background-image: none;
            text-shadow: none;
            background: #5191FF;
            box-shadow: none;
            border: none;
        }
        button.btn, input[type="submit"].btn {
        }
    </style>
    <script src="/static/js/idCardNo.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {

            //验证手身份证号码格式格式
            jQuery.validator.addMethod("isIdCardNo", function (value, element) {
                return this.optional(element) || isIdCardNo(value);
            }, "请正确输入您的身份证号码");

            $("#no").focus();
            $("#inputForm").validate({
                rules: {
                    loginName: {
                        required:true,
                        isIdCardNo: true,
                        remote: "${ctxFront}/checkLoginNameExist?oldLoginName="
                        + encodeURIComponent('${user.loginName}')
                    },
                    validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"},
                    validateCode22:{
                        required:true,
                    },
                },
                messages: {
                    loginName: {
                        required:"登录名不能为空",
                        isIdCardNo:"请正确输入您的身份证号码",
                        remote: "用户登录名不存在"},
                    validateCode: {remote: "验证码不正确.", required: "请填写验证码."},
                    validateCode22:{
                        required:"请输入手机验证码"
                    }
                },
                submitHandler: function(form){
                    // loading('正在提交，请稍等...');
                    var code=$("#validateCode22").val();
                    var loginName=$("#loginName").val();
                    // alert(code);
                    checkCode(code,loginName);

                    // form.submit();
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


            function buttonClike(){
                var code=$("#validateCode").val();
                alert(code);
                checkCode(code);
            }
            function sendCode(s) {
                $.ajax({
                    type:"post",
                    url:"${ctxFront}/sendCode?loginName="+s,
                    success:function () {

                    }
                })
            }

            function checkCode(s,l) {
                location="${ctxFront}/checkCode?code="+s+"&loginName="+l;
            }


     /*       //获取验证码
            $('#getCodeBtn').on('click', function() {

                    //身份证
                var loginName1 = $("#loginName").val();
                $.post("${ctxFront}/sendCode?loginName="+loginName1);

                    $('input[name="validateCode"]').focus();
                    console.log("zhenghao"+loginName1);

                    var getValidateCodeObj = $('#getCodeBtn');
                    getValidateCodeObj.attr('disabled', true);
                    var i = 60;
                    var myInterval = setInterval(myIntervalFun, 1000);
                    function myIntervalFun() {
                        i--;
                        getValidateCodeObj.html('<b style="padding:0 33px;color:#a9a9a9;">' + i + '</b>');
                        if (i == 0) {
                            clearInterval(myInterval);
                            getValidateCodeObj.
                            html('获取验证码');
                            getValidateCodeObj.attr('disabled', false);
                        }
                    }
                    $.axs(function(result) {
                        if (!result.isSuc) {
                            $("#loginName_error").html(result.msg);
                            clearInterval(myInterval);
                            getValidateCodeObj.html('获取验证码');
                            getValidateCodeObj.attr('disabled', false);
                        }
                    });
                    $("#validateCode_error").html('');


                });*/

        });
        //倒计时
        function resetCode(){
            var loginName1 = $("#loginName").val();
            var code = $("#validateCode").val();
            if(loginName1&&code){
            $.post("${ctxFront}/sendCode?loginName="+loginName1);
            $('#J_getCode').hide();
            $('#J_second').html('60');
            $('#J_resetCode').show();
            var second = 60;
            var timer = null;
            timer = setInterval(function(){
                second -= 1;
                if(second >0 ){
                    $('#J_second').html(second);
                }else{
                    clearInterval(timer);
                    $('#J_getCode').show();
                    $('#J_resetCode').hide();
                }
            },1000);
            }else {
                alert("请输入正确的登录名和验证码！");
            }
        }
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
        <div class="box-title">忘记密码</div>
        <form:form id="inputForm" modelAttribute="user" method="post"
                   class="form-horizontal register-form" >
            <form:hidden path="id"/>
            <sys:message content="${message}"/>
            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;登录名:</label>
                <div class="controls">
                    <form:input path="loginName" id="loginName"
                                placeholder="登录名为身份证号" htmlEscape="false" maxlength="50" />
                    <label id="loginName_error" class="error"></label>
                </div>
            </div>


            <%--<div class="control-group">--%>
            <%--<label class="control-label">手机:</label>--%>
            <%--<div class="controls">--%>
            <%--<label class="lbl" id="moblic"></label>--%>
            <%--</div>--%>
            <%--</div>--%>

            <div class="control-group">
                <label class="control-label"><font color="red">*</font>&nbsp;验证码:</label>
                <div class="validateCode">
                    &nbsp;&nbsp;&nbsp;&nbsp;<label class="input-label mid" for="validateCode"></label>
                    <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><font style="color: red;">*</font>&nbsp;手机验证码：</label>
                <div class="controls">

                    <input type="text" id="validateCode22" name="validateCode22" value=""
                           placeholder="请输入验证码" maxlength="11" style="width:100px;"/>

                    <button class="btn btn-small get-code" onclick="resetCode()" id="J_getCode">获取验证码</button>
                    <button class="btn btn-small reset-code" id="J_resetCode" style="display:none;"><span id="J_second">60</span>秒后重发</button>

                    <label id="validateCode_error" class="error"></label>
                </div>
            </div>



            <div class="form-actions">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>

        </form:form>
    </div>
</div>

<div class="fixed">
    <a href="javascript:;" class="tel">
        <div class="box">
            <p>客服电话：</p>
            <p>0756-3322881</p>
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
