<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html style="overflow-x:auto;overflow-y:auto;">
<head>
    <title>忘记密码 </title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <meta name="author" content="http://jeesite.com/"/>
    <meta name="renderer" content="webkit"><meta http-equiv="X-UA-Compatible" content="IE=8,IE=9,IE=10" />
    <meta http-equiv="Expires" content="0"><meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-store">

    <link href="/static/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <link href="/static/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet" />
    <link href="/static/jquery-select2/3.4/select2.min.css" rel="stylesheet" />
    <link href="/static/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet" />

    <!--[if lte IE 7]><link href="/static/bootstrap/2.3.1/awesome/font-awesome-ie7.min.css" type="text/css" rel="stylesheet" /><![endif]-->
    <!--[if lte IE 6]><link href="/static/bootstrap/bsie/css/bootstrap-ie6.min.css" type="text/css" rel="stylesheet" />
<script src="/static/bootstrap/bsie/js/bootstrap-ie.min.js" type="text/javascript"></script><![endif]-->

    <script src="/static/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="/static/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="/static/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
    <script src="/static/jquery-validation/1.16.0/dist/jquery.validate.min.js" type="text/javascript"></script>
    <script src="/static/jquery-validation/1.16.0/dist/localization/messages_zh.js" type="text/javascript"></script>
    <script src="/static/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <script src="/static/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/static/common/mustache.min.js" type="text/javascript"></script>
    <link href="/static/common/jeesite.css" type="text/css" rel="stylesheet" />
    <script src="/static/common/jeesite.js" type="text/javascript"></script>
    <script src="/static/common/common.js" type="text/javascript"></script>
    <script src="/static/common/jquery.custom.table.js" type="text/javascript"></script>
    <script src="/static/layer/layer.min.js" type="text/javascript"></script>

    <script type="text/javascript">var ctx = '/clinic', ctxStatic='/static';</script>
    <!-- Baidu tongji analytics --><script>var _hmt=_hmt||[];(function(){var hm=document.createElement("script");hm.src="//hm.baidu.com/hm.js?82116c626a8d504a5c0675073362ef6f";var s=document.getElementsByTagName("script")[0];s.parentNode.insertBefore(hm,s);})();</script>


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

        /* fixed */
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
        <div class="box-title">忘记密码</div>
        <form id="modelForm" class="form-horizontal register-form">
            <div class="control-group">
                <label class="control-label"><font style="color: red;">*</font>&nbsp;登录帐号：</label>
                <div class="controls">
                    <input type="text" id="loginName" name="loginName" value="" placeholder="帐号（长度为6-20个字符）" style="width:200px;">
                    <button type="button" id="checkLoginNameBtn" class="btn btn-info">检测帐号</button>
                    <label id="checkLoginName_error" class="error"></label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label">手机号码：</label>
                <div class="controls">
                    <input type="tel" id="phoneNum" name="phoneNum" value="" readonly="readonly" style="width:200px;"/>
                    <input type="hidden" id="vCode" value=""/>
                    <label id="phoneNum_error" class="error"></label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label"><font style="color: red;">*</font>&nbsp;验证码：</label>
                <div class="controls">
                    <input type="text" id="validateCode" name="validateCode" value="" placeholder="请输入验证码" maxlength="11" style="width:100px;"/>
                    <button type="button" id="getCodeBtn" class="btn btn-info">获取验证码</button>
                    <label id="validateCode_error" class="error"></label>
                </div>
            </div>
            <div class="control-group">
                <div class="controls">
                    <button id="submitBtn" type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </form>
    </div>
</div>

<div class="fixed">
    <a href="javascript:;" class="tel">
        <div class="box">
            <p>客服电话：</p>
            <p>13902294031</p>
        </div>
    </a>
    <a href="javascript:;" class="wechat">
        <div class="box">
            <img src="/filePath/common/images/qrcode_for_gh_b793c3f77e6c_258.jpg">
            <p>关注微信</p>
        </div>
    </a>
</div>
<script type="text/javascript">
    $(function(){
        //检测账号
        $('#checkLoginNameBtn').on('click', function() {
            var loginName = $("#loginName").val();
            if(loginName){
                $.axs('/f/loadPhoneByLoginName', {"loginName":loginName}, function(result) {
                    if(result.isSuc){
                        $('#loginName').attr("readonly","readonly");//设置登陆账号为只读
                        $("#checkLoginName_error").html('');
                        $("#phoneNum_error").html('');
                        $("#phoneNum").val(result.data.encryptionPhone);
                        $("#vCode").val(result.data.vCode);
                    }else{
                        $("#checkLoginName_error").html(result.msg);
                    }
                });
            }else{
                $("#checkLoginName_error").html('请输入登陆账号！');
            }

        });
        //获取验证码
        $('#getCodeBtn').on('click', function() {
            var vCode = $("#vCode").val();
            if(vCode){
                $('input[name="validateCode"]').focus();
                var getValidateCodeObj = $('#getCodeBtn');
                getValidateCodeObj.attr('disabled', true);
                var i = 60;
                var myInterval = setInterval(myIntervalFun, 1000);
                function myIntervalFun() {
                    i--;
                    getValidateCodeObj.html('<b style="padding:0 33px;color:#a9a9a9;">' + i + '</b>');
                    if (i == 0) {
                        clearInterval(myInterval);
                        getValidateCodeObj.html('获取验证码');
                        getValidateCodeObj.attr('disabled', false);
                    }
                }
                $.axs('/f/sendFindPwdCode', {"vCode":vCode}, function(result) {
                    if (!result.isSuc) {
                        $("#phoneNum_error").html(result.msg);
                        clearInterval(myInterval);
                        getValidateCodeObj.html('获取验证码');
                        getValidateCodeObj.attr('disabled', false);
                    }
                });
                $("#validateCode_error").html('');
            }else{
                $("#phoneNum_error").html('手机号不能为空！');
            }

        });
        $('#submitBtn').on('click', function() {
            var loginName = $("#loginName").val();
            console.log(loginName);
            var validateCode = $("#validateCode").val();
            var vCode = $("#vCode").val();
            if(vCode){
                $.axs('/f/doValidateCode', {"loginName":loginName, "validateCode":validateCode, "vCode":vCode}, function(result) {
                    if(result.isSuc){
                        window.location.href = '/f/forgetPwdModPassword?vbCode='+result.data.vbCode;
                    }else{
                        $("#validateCode_error").html('验证码错误！');
                    }
                });
            }else{
                $("#validateCode_error").html('请输入验证码！');
            }
        });
    });

    //根据登陆名加载手机号
    function checkLoginName() {
        $.post('/f/weiXinModel/areaList', {"parentId":pid,"type":type}, function(resultList, s) {
            $(resultList).each(function(i,l){
                $("#"+targetId).append("<option value='"+l.id+"'>"+l.name+"</option>");
            });
        });
    }

</script>

<script type="text/javascript">//<!-- 无框架时，左上角显示菜单图标按钮。
if(!(self.frameElement && self.frameElement.tagName=="IFRAME")){
// 			$("body").prepend("<i id=\"btnMenu\" class=\"icon-th-list\" style=\"cursor:pointer;float:right;margin:10px;\"></i><div id=\"menuContent\"></div>");
// 			$("#btnMenu").click(function(){
// 				top.$.jBox('get:/clinic/sys/menu/treeselect;JSESSIONID=', {title:'选择菜单', buttons:{'关闭':true}, width:300, height: 350, top:10});
// 				//if ($("#menuContent").html()==""){$.get("/clinic/sys/menu/treeselect", function(data){$("#menuContent").html(data);});}else{$("#menuContent").toggle(100);}
// 			});
}//-->
</script>
</body>
</html>