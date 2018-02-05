<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>${fns:getConfig('productName')} 登录</title>
	<meta name="decorator" content="blank"/>
	<style type="text/css">
      html,body,table{background-color:#f5f5f5;width:100%;text-align:center;}.form-signin-heading{font-family:Helvetica, Georgia, Arial, sans-serif, 黑体;font-size:36px;margin-bottom:20px;color:#0663a2;}
      .form-signin{position:relative;text-align:left;width:360px;padding:25px 29px 29px;margin:0 auto 20px;background-color:#fff;border:1px solid #e5e5e5;
        	-webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
      .form-signin .checkbox{margin-bottom:10px;color:#0663a2;} .form-signin .input-label{font-size:16px;line-height:23px;color:#999;}
      .form-signin .input-block-level{font-size:16px;height:auto;margin-bottom:15px;padding:7px;*width:283px;*padding-bottom:0;_padding:7px 7px 9px 7px;}
      .form-signin .btn.btn-large{font-size:16px;} .form-signin #themeSwitch{position:absolute;right:15px;bottom:10px;}
      .form-signin div.validateCode {padding-bottom:15px;} .mid{vertical-align:middle;}
      .header{height:80px;padding-top:20px;} .alert{position:relative

											 ;width:300px;margin:0 auto;*padding-bottom:0px;}
      label.error{background:none;width:270px;font-weight:normal;color:inherit;margin:0;}

	  .form-signin2{position:relative;text-align:left;width:360px;padding:25px 29px 29px;margin:0 auto 20px;background-color:#fff;border:1px solid #e5e5e5;
		  -webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px;-webkit-box-shadow:0 1px 2px rgba(0,0,0,.05);-moz-box-shadow:0 1px 2px rgba(0,0,0,.05);box-shadow:0 1px 2px rgba(0,0,0,.05);}
    </style>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/login_new.css?id=8">
	<style type="text/css">
		.QRCode{
			background: white;
		}

		.QQ{
			background: #36A7E9;
		}
		.contactUs{
			position: absolute;
			bottom: 10%;
			right: 20px;
			width: 50px;
			height: 100px;
			box-shadow: #999999 0 0 10px;
		}
		.changeHand{
			cursor:pointer;
		}
		.contactUsSingle{
			width: 50px;
			height: 50px;
			padding: 5px;
		}
		.hideQRCode{
			display: none;
		}

		.showQRCode{
			position: absolute;
			right: 80px;
			bottom: 5%;
			background: white;
			box-shadow: #36A7E9 0 0 10px;
			width: 210px;
			height:250px;
			color: #8C8F94;
			font-size: 16px;
			text-align: center;
		}
		.WX{
			padding: 10px;
		}

		.WXQRCode{
			width: 190px;
			height: 190px;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}

        /**
         * 联系的显示
         */
		function wxBig() {
            $("#QRCodeInfo").removeClass().addClass("showQRCode")
        }
        function wxSmall() {
            $("#QRCodeInfo").removeClass().addClass("hideQRCode")
        }
	</script>
</head>
<body>
	<!--[if lte IE 6]><br/><div class='alert alert-block' style="text-align:left;padding-bottom:10px;"><a class="close" data-dismiss="alert">x</a><h4>温馨提示：</h4><p>你使用的浏览器版本过低。为了获得更好的浏览体验，我们强烈建议您 <a href="http://browsehappy.com" target="_blank">升级</a> 到最新版本的IE浏览器，或者使用较新版本的 Chrome、Firefox、Safari 等。</p></div><![endif]-->
	<div class="header">
		<div id="messageBox" class="alert alert-error ${empty message ? 'hide' : ''}"><button data-dismiss="alert" class="close">×</button>
			<label id="loginError" class="error">${message}</label>
		</div>
	</div>
	<div style="width: 50%;height: 50%;text-align: center;position:relative">
	<h1 class="form-signin-heading">${fns:getConfig('productName')}</h1>
	<form id="loginForm" class="form-signin" action="${ctx}/login" method="post" style="float: left;margin-right:-30px;">
		<label class="input-label" for="username">登录名</label>
		<input type="text" id="username" name="username" class="input-block-level required" value="${username}">
		<label class="input-label" for="password">密码</label>
		<input type="password" id="password" name="password" class="input-block-level required">
		<c:if test="${isValidateCodeLogin}"><div class="validateCode">
			<label class="input-label mid" for="validateCode">验证码</label>
			<sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
		</div></c:if><%--
		<label for="mobile" title="手机登录"><input type="checkbox" id="mobileLogin" name="mobileLogin" ${mobileLogin ? 'checked' : ''}/></label> --%>
		<input class="btn btn-large btn-primary" type="submit" value="登 录"/>&nbsp;&nbsp;
		<a class="btn-line" href="${ctxFront}/userRegiste">注册帐号</a>
		<a class="btn-line" href="${ctxFront}/forgetPassword">忘记密码</a>
		<div id="themeSwitch" class="dropdown">
			<a class="dropdown-toggle" data-toggle="dropdown" href="#">${fns:getDictLabel(cookie.theme.value,'theme','默认主题')}<b class="caret"></b></a>
			<ul class="dropdown-menu">
			  <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
			</ul>
			<!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
		</div>
	</form>

	<div class="sealSystem" style="float: left;margin-left: 100px;">
		<div id="sealProblem" class="sealProblem">
			<div class="sealTitleTable">
				<div class="sealTitleAndLogo">
					<img class="logo" src="${ctxHtml}/images/logoAndTitle_new.png"/>
				</div>
			</div>
			<div id="sealProblemContent" class="sealProblemContent">
				<div id="sealProblemContentDiv" class="sealProblemContentDiv">
					<div class="sealProblemList" id="sealProblemList">
						<ul id="listContent" class="listContent">
						</ul>
					</div>
					<div class="sealProblemLineOut">
						<div class="line"></div>
					</div>
					<div class="sealProblemExplain">
						<div id="sealExplainContent" class="sealExplainContent">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	</div>

	<div class="contactUs">
		<div class="QRCode changeHand" id="QRCode" title="APP下载" onmouseover="wxBig(this)" onmouseout="wxSmall(this)">
			<img src="${ctxStatic}/images/rclogo.jpg" class="contactUsSingle"/>
		</div>
		<div class="QQ changeHand" id="QQ" title="联系QQ">
			<img src="${ctxStatic}/images/QQ_new.png" class="contactUsSingle"/>
		</div>
	</div>
	<div class="hideQRCode" id="QRCodeInfo">
		<div class="WX">
			<span>I签下载</span>
		</div>
		<img class="WXQRCode" src="${ctxStatic}/images/appQRCode.JPG"/>
	</div>
	<div class="footer">
		Copyright &copy; 2012-${fns:getConfig('copyrightYear')} <a href="${pageContext.request.contextPath}${fns:getFrontPath()}">${fns:getConfig('productName')}</a> - Powered By <a href="http://www.ieseals.cn/" target="_blank">润成科技</a> ${fns:getConfig('version')}
	</div>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
</body>
</html>