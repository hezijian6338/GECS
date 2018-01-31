<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<html>
<head>
    <title>营业执照管理</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        $(document).ready(function() {
            $("#name").focus();
            $("#inputForm").validate({
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

        function a(){
            var ex=prompt("请输入密码：");
            if (ex=='1234'){
                alert("输入正确！！！！！！！");
                $('#flag').val('yes');
            }
        }


    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/license/businessLicense/">营业执照列表</a></li>
    <li class="active"><a href="#"><shiro:hasPermission name="license:businessLicense:edit">${businessLicense.act.taskName}</shiro:hasPermission><shiro:lacksPermission name="license:businessLicense:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="businessLicense" action="${ctx}/license/businessLicense/saveAudit" method="post" class="form-horizontal">
    <sys:message content="${message}"/>
    <form:hidden path="id"/>
    <form:hidden path="act.taskId"/>
    <form:hidden path="act.taskName"/>
    <form:hidden path="act.taskDefKey"/>
    <form:hidden path="act.procInsId"/>
    <form:hidden path="act.procDefId"/>
    <form:hidden id="flag" path="act.flag"/>
    <sys:message content="${message}"/>
    <fieldset>
        <legend>审核人员：${businessLicense.act.taskName}</legend>
        <h1 align="center">营业执照审批申请</h1>
        <table class="table-form">
            <tr>
                <td class="tit">证照类型</td>
                <td>
                    <form:input path="certificateTypeName" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </td>
                <td class="tit">统一社会信用代码</td>
                <td> 
                    <form:input path="certificateCode" htmlEscape="false" maxlength="100" class="input-xlarge " readonly="true"/>
                </td>
                <td class="tit">颁发机构</td>
                <td>
                 <%--    <sys:treeselect id="office" name="office.id" value="${businessLicense.office.id}" labelName="office.name" labelValue="${businessLicense.office.name}"
                                    title="部门" url="/sys/office/treeData?type=2" cssClass="required" allowClear="true" notAllowSelectParent="true"/>
                    <span class="help-inline"><font color="red">*</font> </span> --%>
                    ${businessLicense.office.name}
                </td>
            </tr>
            <tr>
                <td class="tit">地址</td>
                <td colspan="5">
                    <form:input path="address" htmlEscape="false" maxlength="100" class="input-xlarge " readonly="true"/>
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
                    <form:input path="registeredType" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
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
                    <form:input path="certificateName" htmlEscape="false" maxlength="100" class="input-xlarge required" readonly="true"/>
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
                    <form:input path="registeredCapital" htmlEscape="false" maxlength="20" class="input-xlarge required" readonly="true"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </td>
            </tr>
            <tr><td class="tit">经营/业务/许可范围</td>
                <td colspan="5">
<%--                                    title="经营范围" url="/scope/businessScope/treeData" cssClass="required" allowClear="true" notAllowSelectParent="true" expandOnLoad="false" checked="true"/>
                        <span class="help-inline"><font color="red">*</font> </span> --%>
                    ${businessLicense.scope.name}
                </td>
            </tr>
            <tr>
                <td class="tit" rowspan="4">法人信息</td>
                <td class="tit">法人姓名</td>
                <td>
                    <form:input path="persionName" htmlEscape="false" maxlength="20" class="input-xlarge required" readonly="true"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </td>
                <td class="tit" rowspan="4">经办人信息</td>
                <td class="tit">经办人姓名</td>
                <td>
                    <form:input path="handlerName" htmlEscape="false" maxlength="20" class="input-xlarge " readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="tit">法人证件类型</td>
                <td>
                    <form:input path="persionIdType" htmlEscape="false" maxlength="20" class="input-xlarge required" readonly="true"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </td>
                <td class="tit">经办人证件类型</td>
                <td>
                    <form:input path="handlerIdType" htmlEscape="false" maxlength="20" class="input-xlarge " readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="tit">法人证件号码</td>
                <td>
                    <form:input path="personId" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </td>
                <td class="tit">经办人证件号码</td>
                <td>
                    <form:input path="handlerId" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true" />
                </td>
            </tr>
            <tr>
                <td class="tit">法人联系方式</td>
                <td>
                    <form:input path="persionPhone" htmlEscape="false" maxlength="20" class="input-xlarge required" readonly="true"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </td>
                <td class="tit">经办人联系方式</td>
                <td>
                    <form:input path="handlerPhone" htmlEscape="false" maxlength="20" class="input-xlarge " readonly="true"/>
                </td>
            </tr>
           <%-- <tr>
                <td colspan="6" class="tit">所入驻建筑信息</td>
            </tr>
            <tr>
                <td class="tit">建筑名称</td>
                <td>
                    <form:input path="buildingName" htmlEscape="false" maxlength="64" class="input-xlarge " readonly="true"/>
                </td>
                <td class="tit">层数</td>
                <td>
                    <form:input path="floorNumber" htmlEscape="false" maxlength="10" class="input-xlarge " readonly="true"/>
                </td>
                <td class="tit">使用面积</td>
                <td>
                    <form:input path="useArea" htmlEscape="false" maxlength="20" class="input-xlarge " readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="tit">使用情况</td>
                <td colspan="">
                    <form:input path="usage1" htmlEscape="false" maxlength="100" class="input-xlarge " readonly="true"/>
                </td>
                <td class="tit">现有消防措施</td>
                <td colspan="3">
                    <form:input path="dealfireFacilities" htmlEscape="false" maxlength="100" class="input-xlarge " readonly="true"/>
                </td>
            </tr>
            <tr>
                <td class="tit">邮政编码</td>
                <td>
                    <form:input path="postcode" htmlEscape="false" maxlength="10" class="input-xlarge " readonly="true"/>
                </td>
                <td class="tit">所属区域</td>
                <td colspan="3">
&lt;%&ndash;                     <sys:treeselect id="area" name="area.id" value="${businessLicense.area.id}" labelName="area.name" labelValue="${businessLicense.area.name}" title="区域" url="/sys/area/treeData" cssClass="" allowClear="true" notAllowSelectParent="true"/>
 &ndash;%&gt;
				 	${businessLicense.area.name}
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
                <td class="tit">您的意见</td>
                <td colspan="5">
                    <form:textarea path="act.comment" class="required" rows="5" maxlength="20" cssStyle="width:500px"/>
                </td>
            </tr>
        </table>
    </fieldset>

    <div class="form-actions">
        <shiro:hasPermission name="license:businessLicense:edit">
            <c:if test="${businessLicense.act.taskDefKey eq 'apply_end'}">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="生成执照" onclick="$('#flag').val('yes')"/>&nbsp;
            </c:if>
            <c:if test="${businessLicense.act.taskDefKey ne 'apply_end'}">
                <input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
                <input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
            </c:if>
        </shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
    <act:histoicFlow procInsId="${businessLicense.act.procInsId}"/>
</form:form>
</body>
</html>