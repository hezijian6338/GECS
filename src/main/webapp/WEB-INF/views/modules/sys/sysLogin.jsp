<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head lang="zh">
	<meta charset="UTF-8">
	<%--<meta name="decorator" content="blank"/>--%>
	<!-- ie渲染-->
	<meta http-equiv="X-UA-Compatible" content="IE=Edge，chrome=1">
	<!-- 包含头部信息用于适应不同设备 -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 包含 bootstrap 样式表 -->
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/login_new.css?id=3">
	<script src="${ctxStatic}/js/jquery.js?id=4"></script>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />
	<link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet" />

	<script src="${ctxStatic}/js/page_new.js?id=4"></script>
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

	</style>
</head>

<body>
<div id="Layer1" style="position:absolute; left:0px; top:0px; width:100%; height:100%;position:fixed">
	<img src="${ctxStatic}/images/loginbg_new.png" width="100%" height="100%"/>
</div>
<div class="background">
	<div id="mainContent" class="mainContent">
		<div class="sealSystem">
			<div id="sealProblem" class="sealProblem">
				<div class="sealTitleTable">
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
		<div class="login">
			<div class="loginTitleTable">
				<div class="loginTitle">
					<p id="loginTitleText" class="loginTitleText"></p>
				</div>
			</div>
			<div id="errorLoginDiv" class="errorLoginDiv" style="display:${empty message ? 'none' : 'block'}">
				<div id="errorLogin" class="errorLogin">${message}</div>
			</div>
			<h1 class="form-signin-heading">${fns:getConfig('productName')}</h1>
			<form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
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
</div>
</body>

<script>


    var browser = navigator.appName
    var b_version = navigator.appVersion
    var version = b_version.split(";");
	/*解决火狐undefined问题*/
    var trim_Version = ""
    if(version[1]){
        trim_Version = version[1].replace(/[ ]/g, "");
    }
    if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE6.0" || trim_Version == "MSIE7.0" || trim_Version == "MSIE8.0")) {

        $('#mainContent').removeClass().addClass('mainContentIe8')

        $('#sealProblem').removeClass().addClass('sealProblemIe8')

        $('#sealProblemContent').removeClass().addClass('sealProblemContentIe8')

        $('#sealProblemContentDiv').removeClass().addClass('sealProblemContentDivIe8')

        $('#certificateLogin').removeClass().addClass('certificateLoginIe8')


        $('#usernameInputLabel').css('display', 'block')
        $('#passwordInputLabel').css('display', 'block')
        $('#verificationInputLabel').css('display', 'block')

        $('#username').bind("input propertychange", function () {
            if ($(this).val() != '') {
                $('#usernameInputLabel').css('display', 'none')
            } else {
                $('#usernameInputLabel').css('display', 'block')
            }
        });

        $('#password').bind("input propertychange", function () {
            if ($(this).val() != '') {
                $('#passwordInputLabel').css('display', 'none')
            } else {
                $('#passwordInputLabel').css('display', 'block')
            }
        });

        $('#verification').bind("input propertychange", function () {
            if ($(this).val() != '') {
                $('#verificationInputLabel').css('display', 'none')
            } else {
                $('#verificationInputLabel').css('display', 'block')
            }
        });


        $('#Search').removeClass().addClass('SearchIe8')
        $('#SearchCancel').removeClass().addClass('SearchCancelIe8')
        $('#SearchSelect').removeClass().addClass('SearchSelectIe8')

    }else if(browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE9.0")){

        $('#usernameInputLabel').css('display', 'block')
        $('#passwordInputLabel').css('display', 'block')
        $('#verificationInputLabel').css('display', 'block')

        $('#username').bind("input onchange", function () {
            if ($(this).val() != '') {
                $('#usernameInputLabel').css('display', 'none')
            } else {
                $('#usernameInputLabel').css('display', 'block')
            }
        });

        $('#password').bind("input propertychange", function () {
            if ($(this).val() != '') {
                $('#passwordInputLabel').css('display', 'none')
            } else {
                $('#passwordInputLabel').css('display', 'block')
            }
        });

        $('#verification').bind("input propertychange", function () {
            if ($(this).val() != '') {
                $('#verificationInputLabel').css('display', 'none')
            } else {
                $('#verificationInputLabel').css('display', 'block')
            }
        });

    }


    var li = ['网上办事指南', '用户注册流程', '企业年审流程', '企业管理办法']

    var liText = "<h3>一、\t广东省商事登记条例</h3>" +
        "        <p style='font-size: 16px;'>第一条  为了规范商事登记活动，推进商事登记便利化，保护商事主体的合法权益，根据有关法律、行政法规，结合本省实际，制定本条例。</p>" +
        "        <p style='font-size: 16px;'>第二条　本条例适用于本省行政区域内商事登记及其管理。本条例所称商事登记，是指商事登记机关（以下简称登记机关）根据申请人的申请，经依法审查，将商事主体设立、变更、注销的事项予以登记并公示的行为。</p>" +
        "        <p style='font-size: 16px;'>第三条　实施商事登记，应当遵循公开、公平、公正、便民、高效的原则。</p>" +
        "        <p style='font-size: 16px;'>第四条　市县级以上人民政府负责工商行政管理的部门是登记机关。</p>" +
        "        <p style='font-size: 16px;'>第五条　经登记机关依法登记，领取营业执照，申请人方取得商事主体资格。</p>"

    var li2 = [
        {liName:'备案登记指南',value:liText},
        {liName:'用户注册流程',value:'待补充'},
        {liName:'企业年审流程',value:'待补充'},
        {liName:'企业管理办法',value:'待补充'}
    ]

    addLiHtml("#listContent", li2)

    /**
     *  默认加载第一个li
     */
    $("#li0").children().removeClass().addClass("listContentSingleChoose")
    replaceSonHtml("#sealExplainContent", li2[0].value)

    /**
     * li 的居中
     */
    centerHtml("#sealProblemList", "#listContent")
    /**
     * 放大缩小重新设置li
     */
    window.onresize = function () {
        centerHtml("#sealProblemList", "#listContent")
    }
    /**
     *  li点击事件
     */
    $(".listContentSingleText").click(function () {
        //回归默认值
        $(".listContentSingleText").children().removeClass().addClass("listContentSingleUnChoose")
        //改变选中值
        $(this).children().removeClass().addClass("listContentSingleChoose")
        //获取id
//        alert($(this).attr("id"))
        var liId = $(this).attr("id")
        //改变右侧
        liId = liId.substring(2,liId.length)

        replaceSonHtml("#sealExplainContent", li2[liId].value)
    })

    /**
     * 修改记住密码文字
     */
    $("#rememberMeCheckbox").change(function () {
        if ($(this).is(":checked")) {
            $("#rememberMeLabel").removeClass("rememberMeLabelFalse").addClass("rememberMeLabelTure");
        } else {
            $("#rememberMeLabel").removeClass("rememberMeLabelTure").addClass("rememberMeLabelFalse");
        }
    })


    /**
     *  修改验证码图片
     */
    $("#verificationCodeImg").click(function () {
        $(this).attr('src', '${pageContext.request.contextPath}/servlet/validateCodeServlet?' + new Date().getTime());
    })


    /**
     * 联系的显示
     */
    $("#QRCode").mouseover(function () {
        $("#QRCodeInfo").removeClass().addClass("showQRCode")
    }).mouseout(function () {
        $("#QRCodeInfo").removeClass().addClass("hideQRCode")
    })


    /**
     * 搜索
     **/
    $("#ShowSearch").click(function () {
        $('#Search').css({
            'display': 'table'
        })
    })

    $("#SearchCancel").mouseover(function () {
        $(this).animate({
            height: '+=5px',
            width: '+=5px'
        })
    }).mouseout(function () {
        $(this).animate({
            height: '-=5px',
            width: '-=5px'
        })
    }).click(function () {
        $('#Search').css({
            'display': 'none'
        })
    })

    /**
     *  搜索
     * @returns {boolean} 返回false为表单不处理
     * @constructor
     */
    function FormSearch() {
        var dataArray = $('#searchForm').serializeArray()
        var data = {}
        for(var i = 0; i < dataArray.length; i++){
            data[dataArray[i].name] = dataArray[i].value
        }
        if(dataArray[0].value == '' && dataArray[1].value == '' && dataArray[2].value == ''){
            alert('请输入搜索条件')
            return false
        }
        $.post(
            "${ctxOther}/check/page/search",
            data,
            function (result) {
                if(result.list){
                    addSearchResultListHtml("#SearchResult", result.list)
                }
            }
        )
        //addSearchResultListHtml("#SearchResult", [1, 2, 3, 4])
        return false
    }

    ////TODO 表单验证

    $("#loginForm").validate({
        rules: {
            validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
        },
        messages: {
            validateCode: {remote: "验证码不正确", required: "请填写验证码"}
        },
        errorElement: 'div',
        errorLabelContainer: "#errorLoginDiv",
        errorContainer: "#errorLoginDiv",
        showErrors:function (errorMap,errorList) {
            if(errorMap.validateCode){
                $('#errorLoginDiv').css({
                    'display':'inline-block'
                })
                errorLoginHtml($('#errorLoginDiv'),errorMap.validateCode)
            }else{
                if($('#verification').val()){
                    $('#errorLoginDiv').css({
                        'display':'none'
                    })
                }
            }
        }
    });


</script>
</html>
