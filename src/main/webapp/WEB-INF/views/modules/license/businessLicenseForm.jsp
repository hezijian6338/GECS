<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营业执照管理</title>
	<meta name="decorator" content="default"/>

	<script type="text/javascript">

        $(document).ready(function() {

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
                },
                messages: {
                    personId: {
                        isIdCardNo:"请正确输入您的身份证号码",
                       // remote: "用户登录名已存在"
						},
                    handlerId:{
                        isIdCardNo:"请正确输入您的身份证号码",
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
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/license/businessLicense/">营业执照列表</a></li>
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
				<tr>
					<td class="tit">证照类型</td>
					<td>
						<form:input path="certificateTypeId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">证照编号</td>
					<td>
						<form:input path="certificateCode" htmlEscape="false" maxlength="100" class="input-xlarge "/>
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
						<form:input path="address" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit" rowspan="3">日期填写</td>
					<td class="tit">成立日期</td>
					<td>
					<input name="establishDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${businessLicense.establishDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
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
							value="<fmt:formatDate value="${businessLicense.effectiveDateStar}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">公司名称</td>
					<td>
						<form:input path="certificateName" htmlEscape="false" maxlength="100" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr>
					<td class="tit">证照有效期（截至）</td>
					<td>
						<input name="effectiveDateEnd" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
							   value="<fmt:formatDate value="${businessLicense.effectiveDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>"
							   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">注册资本</td>
					<td>
						<form:input path="registeredCapital" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
				</tr>
				<tr><td class="tit">经营/业务/许可范围</td>
					<td colspan="5">
						
						<sys:treeselect id="scope" name="scope.id" value="${businessLicense.scope.id}" labelName="scope.name" labelValue="${businessLicense.scope.name}"
										title="经营范围" url="/scope/businessScope/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true" expandOnLoad="false"/>
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
						<form:input path="handlerName" htmlEscape="false" maxlength="20" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">法人证件类型</td>
					<td>
						<form:select path="persionIdType" class="input-medium">
							<form:option readonly="true" value="" label="请选择证件类型"/>
							<form:options items="${fns:getDictList('certificate_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">经办人证件类型</td>
					<td>
						<form:select path="handlerIdType" class="input-medium">
							<form:option readonly="true" value="" label="请选择证件类型"/>
							<form:options items="${fns:getDictList('certificate_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
						</form:select>
					</td>
				</tr>
				<tr>
					<td class="tit">法人证件号码</td>
					<td>
						<form:input path="personId" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">经办人证件号码</td>
					<td>
						<form:input path="handlerId" htmlEscape="false" maxlength="64" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">法人联系方式</td>
					<td>
						<form:input path="persionPhone" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
						<span class="help-inline"><font color="red">*</font> </span>
					</td>
					<td class="tit">经办人联系方式</td>
					<td>
						<form:input path="handlerPhone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td colspan="6" class="tit">所入驻建筑信息</td>
				</tr>
				<tr>
					<td class="tit">建筑名称</td>
					<td>
						<form:input path="buildingName" htmlEscape="false" maxlength="64" class="input-xlarge "/>
					</td>
					<td class="tit">层数</td>
					<td>
						<form:input path="floorNumber" htmlEscape="false" maxlength="10" class="input-xlarge "/>
					</td>
					<td class="tit">使用面积</td>
					<td>
						<form:input path="useArea" htmlEscape="false" maxlength="20" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">使用情况</td>
					<td colspan="">
						<form:input path="usage1" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</td>
					<td class="tit">现有消防措施</td>
					<td colspan="3">
						<form:input path="dealfireFacilities" htmlEscape="false" maxlength="100" class="input-xlarge "/>
					</td>
				</tr>
				<tr>
					<td class="tit">邮政编码</td>
					<td>
						<form:input path="postcode" htmlEscape="false" maxlength="10" class="input-xlarge "/>
					</td>
					<td class="tit">所属区域</td>
					<td colspan="3">
						<sys:treeselect id="area" name="area.id" value="${businessLicense.area.id}" labelName="area.name" labelValue="${businessLicense.area.name}" title="区域" url="/sys/area/treeData" cssClass="" allowClear="true" notAllowSelectParent="true"/>
					</td>
				</tr>
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
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
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
</body>
</html>