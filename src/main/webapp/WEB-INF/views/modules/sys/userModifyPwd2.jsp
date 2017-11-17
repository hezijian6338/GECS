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
            $("#oldPassword").focus();
            $("#inputForm").validate({
                rules: {
                },
                messages: {
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
                submitHandler: function(form){
                   // loading('正在提交，请稍等...');
                    a();
                    //form.submit();
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

        function a(){
            var newPassword=$("#newPassword").val();

			location="${ctxFront}/modifyPwd2?newPassword="+newPassword;
           // alert("密码修改成功！！");

		}

//		function b(s){
//            $.ajax()
//		}


	</script>
</head>
<body>
<sys:message content="${message}"/>
<div class="header">
	<div class="container">
		<h3 class="logo">电子证照系统</h3>
		<a class="back" href="/a">返回首页登录</a>
	</div>
</div>
<div class="container register">
	<div class="box register-box">
		<div class="box-title">修改密码</div>
		<form:form id="inputForm" modelAttribute="user"  method="post" class="form-horizontal">
			<form:hidden path="id"/>
			<sys:message content="${message}"/>

			<div class="control-group">
				<label class="control-label">新密码:</label>
				<div class="controls">
					<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">确认新密码:</label>
				<div class="controls">
					<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required" equalTo="#newPassword"/>
					<span class="help-inline"><font color="red">*</font> </span>
				</div>
			</div>
			<div class="form-actions">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" />
			</div>
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
</body>
</html>
