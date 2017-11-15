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

        function a(){
            var newPassword=$("#newPassword").val();
            $.post("${ctxFront}/modifyPwd2?newPassword="+newPassword);
            <%--location = "${ctxFront}/modifyPwd2?newPassword="+newPassword;--%>
            alert(newPassword);
		}

//		function b(s){
//            $.ajax()
//		}


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
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存" onclick="a()"/>
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
			<img src="/static/images/2.png">
			<p>关注微信</p>
		</div>
	</a>
</div>
</body>
</html>
