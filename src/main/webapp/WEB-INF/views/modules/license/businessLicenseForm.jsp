<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营业执照管理</title>
	<meta name="decorator" content="default"/>
    <script type="text/javascript" src="${ctxStatic}/companyName/chachong.js"></script>
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
                    personId: {
                        isIdCardNo: true,
                       // remote: "/f/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')
                    },
                    handlerId:{
                        isIdCardNo:true,
					},

                    persionPhone : {
                        required : true,
                        minlength : 11,
                        // remote: "/f/checkmobile?mobile=" + encodeURIComponent('${user.mobile}')
                        isMobile : true
                    },

                    handlerPhone : {
                        required : true,
                        minlength : 11,
                        <%--// remote: "/f/checkmobile?mobile=" + encodeURIComponent('${user.mobile}')--%>
                        isMobile : true
                    },

                    certificateName:{
						remote: "${ctx}/license/businessLicense/checkCertificateName?certificateName=" + encodeURIComponent('${businessLicense.certificateName}')
					},

                },
                messages: {
                    personId: {
                        isIdCardNo:"请正确输入您的身份证号码",
                       // remote: "用户登录名已存在"
						},
                    handlerId:{
                        isIdCardNo:"请正确输入您的身份证号码",
					},
                    persionPhone : {
                        required : "请输入手机号",
                        minlength : "确认手机不能小于11个字符",
                        isMobile : "请正确填写您的手机号码"
                    },
                    handlerPhone : {
                        required : "请输入手机号",
                        minlength : "确认手机不能小于11个字符",
                        isMobile : "请正确填写您的手机号码"
                    },
                    certificateName:{
                        remote:"该公司名已被注册",
					},
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

        //查重
        function automatic(t) {
            $(".bg-model").fadeTo(300, 1);
            //隐藏窗体的滚动条
            $("body").css({"overflow": "hidden"});
            setTimeout(function () {

                var tableCom =document.getElementById("finalTable");

                var finalName = tableCom.getElementsByTagName("tr")[2].cells[1].innerHTML;

                $.ajax({
                    type: "post",
                    url: "${ctx}/license/businessLicense/checkCertificateName?certificateName=" +finalName,
                    dataType: "json",
                    success: function (result) {

                        if (result == true) {

                                //alert(finalName);
                                $("#certificateName").attr("value",finalName);

                                $(".bg-model").hide();
                                $("#myModal2").modal("hide");
                                //显示窗体
                                $("body").css({"overflow":"hidden"});

                            }else{
                                alert("亲，这个名称已存在，请重试！");
                                $(".bg-model").hide();
                                //显示窗体的滚动条
                                $("body").css({"overflow": "visible"});

                         }
                        }
                    });


            },2000);
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
<div class="center clearfix" style="padding-top: 2%;width: 82%;min-width: 1060px;margin-left: auto;margin-right: auto">
	<ul class="nav nav-tabs">
		<%--<li><a href="${ctx}/license/businessLicense/">营业执照列表</a></li>--%>
		<li class="active"><a href="${ctx}/license/businessLicense/form?id=${businessLicense.id}">营业执照<shiro:hasPermission name="license:businessLicense:edit">${not empty businessLicense.id?'修改':'申请'}流程</shiro:hasPermission><shiro:lacksPermission name="license:businessLicense:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="businessLicense" action="${ctx}/license/businessLicense/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>

		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<fieldset>
			<h1 align="center">营业执照审批申请</h1>
			<table class="table-form">
				<form:hidden path="certificateTypeId"/>
				<tr>
					<td class="tit">证照类型</td>
					<td>
						<form:input path="certificateTypeName" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">统一社会信用代码</td>
					<td>
						<form:input path="certificateCode" htmlEscape="false" maxlength="100" class="input-xlarge required" readonly="true"/>
					</td>
					<td class="tit">颁发机构</td>
					<td>
						<sys:treeselect id="office" name="office.id" value="${businessLicense.office.id}" labelName="office.name" labelValue="${businessLicense.office.name}"
										title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
						<span class="help-inline"><font color="red">*</font> </span>

					</td>
				</tr>
				<tr>
					<td class="tit">地址</td>
					<td colspan="5">
						<form:input path="address" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					</td>
				</tr>

				<tr>
					<td class="tit" rowspan="3">日期填写</td>
					<td class="tit">成立日期</td>
					<td>
					<input name="establishDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${businessLicense.establishDate}" pattern="yyyy-MM-dd"/>"
						/>
					<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit" rowspan="3">公司信息</td>
					<td class="tit">注册公司类型</td>
					<td>
						<form:select path="registeredType" class="input-medium required">
							<form:option readonly="true" value="" label="请选择公司类型"/>
							<form:options items="${fns:getDictList('company_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">证照有效期（起始）</td>
					<td>
						<input name="effectiveDateStar" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							value="<fmt:formatDate value="${businessLicense.effectiveDateStar}" pattern="yyyy-MM-dd"/>"
							/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">公司名称</td>
					<td>
						<form:input id="certificateName" path="certificateName" placeholder="请点击名称申请" htmlEscape="false" maxlength="100" class="input-xlarge required" readonly="true"/>
						<a id="change" class="btn btn-default showcod" data-toggle="modal" data-target=".modal" >名称申请</a>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">证照有效期（截至）</td>
					<td>
						<input name="effectiveDateEnd" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${businessLicense.effectiveDateEnd}" pattern="yyyy-MM-dd"/>"
							 />
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">注册资本</td>
					<td>
						<form:input path="registeredCapital" placeholder="只能输入数字" htmlEscape="false" maxlength="20" class="input-xlarge required"
									onKeyUp="value=value.replace(/[^\d]/g,'')"/>
						<input type="radio" name="bt1" value="万" checked="true">万
						<input type="radio" name="bt1" value="亿">亿
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr><td class="tit">经营/业务/许可范围</td>
					<td colspan="5">
						
						<sys:treeselect id="scope" name="scope.id" value="${businessLicense.scope.id}" labelName="scope.name" labelValue="${businessLicense.scope.name}"
										title="经营范围" url="/scope/businessScope/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true" expandOnLoad="false" />
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit" rowspan="4">法人信息</td>
					<td class="tit">法人姓名</td>
					<td>
						<form:input path="persionName" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit" rowspan="4">经办人信息</td>
					<td class="tit">经办人姓名</td>
					<td>
						<form:input path="handlerName" htmlEscape="false" maxlength="20" class="input-xlarge  required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">法人证件类型</td>
					<td>
						<form:select path="persionIdType" class="input-medium required">
							<form:option readonly="true" value="" label="请选择证件类型"/>
							<form:options items="${fns:getDictList('certificate_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">经办人证件类型</td>
					<td>
						<form:select path="handlerIdType" class="input-medium required">
							<form:option readonly="true" value="" label="请选择证件类型"/>
							<form:options items="${fns:getDictList('certificate_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="tit">法人证件号码</td>
					<td>
						<form:input path="personId" placeholder="请输入证件号码" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">经办人证件号码</td>
					<td>
						<form:input path="handlerId" placeholder="请输入证件号码" htmlEscape="false" maxlength="64" class="input-xlarge  required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">法人联系方式</td>
					<td>
						<form:input path="persionPhone" placeholder="请输入手机号码" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">经办人联系方式</td>
					<td>
						<form:input path="handlerPhone" placeholder="请输入手机号码" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
					</td>
				</tr>
				<%--<tr>
					<td colspan="6" class="tit">所入驻建筑信息</td>
				</tr>
				<tr>
					<td class="tit">建筑名称</td>
					<td>
						<form:input path="buildingName" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
					</td>
					<td class="tit">层数</td>
					<td>
						<form:input path="floorNumber" htmlEscape="false" maxlength="10" class="input-xlarge required"/>
					</td>
					<td class="tit">使用面积</td>
					<td>
						<form:input path="useArea" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">使用情况</td>
					<td colspan="">
						<form:input path="usage1" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					</td>
					<td class="tit">现有消防措施</td>
					<td colspan="3">
						<form:input path="dealfireFacilities" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
					</td>
				</tr>
				<tr>
					<td class="tit">邮政编码</td>
					<td>
						<form:input path="postcode" placeholder="请输入邮政编码（只能输入数字）" htmlEscape="false" maxlength="10" class="input-xlarge required"
									onKeyUp="value=value.replace(/[^\d]/g,'')"/>
					</td>
					<td class="tit">所属区域</td>
					<td colspan="3">
						<sys:treeselect id="area" name="area.id" value="${businessLicense.area.id}" labelName="area.name" labelValue="${businessLicense.area.name}" title="区域" url="/sys/area/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>--%>
				<tr>
					<td class="tit">审批人1的意见</td>
					<td colspan="5">
						${businessLicense.opinion1}
					</td>
				</tr>
				<tr>
					<td class="tit">审批人2的意见</td>
					<td colspan="5">
							${businessLicense.opinion2}
					</td>
				</tr>
				<tr>
					<td class="tit">审批人3的意见</td>
					<td colspan="5">
							${businessLicense.opinion3}
					</td>
				</tr>
				<tr>
					<td class="tit">审批人4的意见</td>
					<td colspan="5">
							${businessLicense.opinion4}
					</td>
				</tr>
				<tr>
					<td class="tit">备注信息</td>
					<td colspan="5">
						<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
					</td>
				</tr>
		<%--<div class="form-actions">
			<shiro:hasPermission name="license:businessLicense:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>--%>
			</table>
		</fieldset>
		<div class="form-actions">
			<shiro:hasPermission name="license:businessLicense:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="下一步" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty businessLicense.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<c:if test="${not empty businessLicense.id}">
			<act:histoicFlow procInsId="${businessLicense.act.procInsId}" />
		</c:if>
	</form:form>
	<%--模态框--%>
	<div id="myModal2" class="modal fade " tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"style="width:700px">
		<div class="modal-dialog " role="document" style="width:700px">
			<div class="modal-content">
				<div class="modal-header" style="border: 0;padding-right: 0">
					<%--<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true"><img src="${ctxStatic}/images/close.png"></span></button>--%>
					<h4 class="modal-title" id="modalLabel">公司名称登记</h4>
				</div>
                <div class="modal-body">
                    <div>
                        <form id="permissionForm" action="${ctx}/policeStampPage/permission" method="post">
                            <table class="table table-bordered table-hover"  id="tableCombination">
                                <tbody>
                                <tr>
                                    <input id="hidden" name="id" type="hidden" value="">
                                    <input id="type_id" name="type_id" type="hidden" value="">
                                    <td rowspan="2"><font color="red" size="3">示例：</font></td>
                                    <td id="th1">行政区划</td>
                                    <td id="th11" style="display:none">字号</td>
                                    <td id="th2">字号</td>
                                    <td id="th22" style="display:none">行政区划</td>
                                    <td id="th3">行业特点</td>
                                    <td id="th33" style="display:none">行政区划</td>
                                    <td id="th4">组织形式</td>
                                </tr>
                                <tr>
                                    <td id="th5">佛山</td>
                                    <td id="th55" style="display:none">芝雅</td>
                                    <td id="th6">芝雅</td>
                                    <td id="th66" style="display:none">佛山</td>
                                    <td id="th7">服饰</td>
                                    <td id="th77" style="display:none">佛山</td>
                                    <td id="th8">有限责任公司</td>
                                </tr>
                                <tr>
                                    <td ><font color="red" size="3">合成的名称：</font></td>
                                    <td colspan="4" id="combinationName">佛山芝雅服饰有限责任公司 </td>
                                </tr>
                                </tbody>
                            </table>
                            <div>
                                <span class="help-inline"><font color="red">*</font> </span>
                                <label>名称组合模式：</label>
                                <select id="combination">
                                    <option value ="1">行政区划+字号+行业+组织形式</option>
                                    <option value ="2">字号+行政区划+行业+组织形式</option>
                                    <option value ="3">字号+行业+行政区划+组织形式</option>
                                </select>
                            </div>
                            <div id="contentDiv" style="display: none">
                            <font color="red" size="2">根据《企业名称登记管理实施办法》的有关规定，企业名称依次由“行政区划+字号+行业+组织形式”组成，只有具备下列条件的企业法人，可以将名称中的行政区划放在字号之后，组织形式之前：
                                1、使用控股企业名称中的字号；2、该控股企业的名称不含行政区划。</font>
                            </div>
                        </form>
                    </div>
                    <div>
                        <hr style="width:100%;height:1px;background-color:#000;"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                        <label>所在地：</label>
                        <sys:treeselect id="area" name="parent.id" value="${area.parent.id}" labelName="parent.name" labelValue="${area.parent.name}"
                                        title="区域" url="/sys/area/treeData" extId="${area.id}" cssClass="" allowClear="true"/>
                    </div>
                    <div>
                        <hr style="width:100%;height:1px;background-color:#000;"/>
                        <span class="help-inline"><font color="red">*</font> </span>
                        <label>名称基本信息：</label>
                        <form:form id="permissionForm2" modelAttribute="businessLicense" action="${ctx}/license/businessLicense/save" method="post">
                            <table id="finalTable" class="table table-bordered table-hover" >
                                <tbody>
                                <tr>
                                    <td><span class="help-inline"><font color="red">*</font> </span>行政区划：
                                        <select id="provinceCity" style="width: 150px">
                                            <option value ="1">冠省名</option>
                                            <option value ="2">冠市名</option>
                                            <option value="3">冠区(县)名</option>
                                            <option value="123">冠省市区(县)名</option>
                                            <option value="12">冠省市名</option>
                                            <option value="23">冠市区(县)名</option>
                                        </select>
                                    </td>
                                    <td id="sheng">省：
                                        <select id="province">
                                            <option value ="saab1">广东</option>
                                            <option value ="saab2">广东省</option>
                                        </select>
                                    </td>
                                    <td id="shi">市：
                                        <select id="city">
                                            <option value ="saab2">珠海</option>
                                            <option value ="saab">珠海市</option>
                                        </select>
                                    </td>
                                    <td id="xian">县（区）：
                                        <select id="county">
                                            <option value ="saab2">香洲</option>
                                            <option value ="saab">斗门</option>
                                            <option value="opel">金湾</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><span class="help-inline"><font color="red">*</font> </span>字号：
                                        <input id="zihao" type="text" style="width: 80px" onblur="comName();"/>
                                    </td>
                                    <td><span class="help-inline"><font color="red">*</font> </span>行业特点：
                                        <input id="hangye" type="text" style="width: 80px" onblur="comName();"/>
                                    </td>
                                    <td><span class="help-inline"><font color="red">*</font> </span>组织形式：
                                        <form:select path="registeredType" class="input-medium required" id="companyType">
                                            <form:option readonly="true" value="" label="请选择公司类型"/>
                                            <form:options items="${fns:getDictList('company_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
                                        </form:select>
                                    </td>
                                    <td>
                                        <%--<button type="button" class="btn btn-primary">查重</button>--%>&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td><font color="red" size="3">合成的名称：</font></td>
                                    <td colspan="3" id="finalCompanyName"> </td>
                                </tr>
                                </tbody>
                            </table>
                        </form:form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" onclick="automatic(this)">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
		</div>
	</div>

    <div class="bg-model"
         style="position:absolute;top:0;left:0;display:none;background:rgba(0,0,0,0.3);width:100%;height:100%;position:fixed;z-index:9999">
        <div class='content'
             style="position: absolute;left: 35%;top: 25%;border-radius: 8px;width: 30%;height: 40%;text-align: center">
            <h3 style="color: white;font-weight: bold">亲，正在查重中，请稍等哦.........</h3>
        </div>
    </div>
</div>
</body>
</html>