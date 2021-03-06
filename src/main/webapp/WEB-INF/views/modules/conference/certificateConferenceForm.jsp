<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>股东会议表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">


    $(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					//loading('正在提交，请稍等...');
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
		function addRow(list, idx, tpl, row){
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
			}));
			$(list+idx).find("select").each(function(){
				$(this).val($(this).attr("data-value"));
			});
			$(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
				var ss = $(this).attr("data-value").split(',');
				for (var i=0; i<ss.length; i++){
					if($(this).val() == ss[i]){
						$(this).attr("checked","checked");
					}
				}
			});
		}
		function delRow(obj, prefix){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().parent().remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().parent().removeClass("error");
			}
		}


	</script>
</head>
<body>
<div class="center clearfix" style="padding-top: 2%;width: 82%;min-width: 1060px;margin-left: auto;margin-right: auto">
	<ul class="nav nav-tabs">
		<%--<li><a href="${ctx}/conference/certificateConference/">股东会议表列表</a></li>--%>
		<li class="active"><a href="${ctx}/conference/certificateConference/form?id=${certificateConference.id}">公司信息<shiro:hasPermission name="conference:certificateConference:edit">${not empty certificateConference.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="conference:certificateConference:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<%--@elvariable id="certificateConference" type=""--%>
	<form:form id="inputForm" modelAttribute="certificateConference" action="${ctx}/conference/certificateConference/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
	<table class="table-form">
		<tr>
			<td class="tit">会议类型：</td>
			<td>
				<form:input path="conferenceType" htmlEscape="false" maxlength="24" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">公司名称：</td>
			<td>
				<form:input path="companyName" htmlEscape="false" maxlength="40" class="input-xlarge " readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">通知方式：</td>
			<td>
				<form:select path="conferenceInformType" class="input-medium required">
					<form:option readonly="true" value="" label="请选择通知方式"/>
					<form:options items="${fns:getDictList('notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
		</tr>
		<tr>
			<td class="tit">通知时间：</td>
			<td>
				<input name="conferenceInformTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required "
					value="<fmt:formatDate value="${certificateConference.conferenceInformTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">公司地址：</td>
			<td>
				<form:input path="companyAddr" htmlEscape="false" maxlength="120" class="input-xlarge required "/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">经营场所：</td>
			<td>
				<form:input path="manageAddr" htmlEscape="false" maxlength="120" class="input-xlarge  required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
		</tr>
		<tr>
			<td class="tit">股东人数：</td>
			<td>
				<form:input path="shareholdersNum" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">注册资本：</td>
			<td>
				<form:input path="registerFund" htmlEscape="false" maxlength="12" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">会议时间：</td>
			<td>
				<input name="conferenceTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${certificateConference.conferenceTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
		</tr>
		<tr>
			<td class="tit">章程订立日期：</td>
			<td>
				<input name="concludeDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
					value="<fmt:formatDate value="${certificateConference.concludeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">会议地址：</td>
			<td>
				<form:input path="conferenceAddr" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
			<td class="tit">是否设立董事会：</td>
			<td>
				<form:input path="setDirectors" htmlEscape="false" maxlength="6" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</td>
		</tr>
			<div class="control-group">
<%--
				<label class="control-label">股东表：</label>
--%>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>股东信息</th>
							</tr>
						</thead>
						<tbody id="certificateConferenceSubList">
						</tbody>
						<shiro:hasPermission name="conference:certificateConference:edit"><tfoot>
							<tr>
								<td colspan="16">
									<a href="javascript:" onclick="addRow('#certificateConferenceSubList', certificateConferenceSubRowIdx, certificateConferenceSubTpl);certificateConferenceSubRowIdx = certificateConferenceSubRowIdx + 1;" class="btn">新增</a>
								</td>
							</tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="certificateConferenceSubTpl">//<!--
							<table id="certificateConferenceSubList{{idx}}"  width="100%">
								<tr>
								<td class="hide" style="text-align: center"></td>
								<td class="hide">
									<input id="certificateConferenceSubList{{idx}}_id" name="certificateConferenceSubList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
									<input id="certificateConferenceSubList{{idx}}_delFlag" name="certificateConferenceSubList[{{idx}}].delFlag" type="hidden" value="0"/>
								</td>
								<td class="tit" style="text-align: center">股东姓名：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_name" name="certificateConferenceSubList[{{idx}}].name" type="text" value="{{row.name}}" maxlength="25" class="input-small required"/>
								</td>
								<td  class="tit" style="text-align: center">性别：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_sex" name="certificateConferenceSubList[{{idx}}].sex" type="text" value="{{row.sex}}" maxlength="10" class="input-small required"/>
								</td>
								<td  class="tit" style="text-align: center">年龄：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_age" name="certificateConferenceSubList[{{idx}}].age" type="text" value="{{row.age}}" maxlength="10" class="input-small required"/>
								</td>
								<td  class="tit" style="text-align: center">籍贯：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_placeOrigin" name="certificateConferenceSubList[{{idx}}].placeOrigin" type="text" value="{{row.placeOrigin}}" maxlength="64" class="input-small required"/>
								</td>
								</tr>
								<tr>
								<td  class="tit" style="text-align: center">住所：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_residence" name="certificateConferenceSubList[{{idx}}].residence" type="text" value="{{row.residence}}" maxlength="255" class="input-small required"/>
								</td>

								<td  class="tit" style="text-align: center">以货币出资：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_currency" name="certificateConferenceSubList[{{idx}}].currency" type="text" value="{{row.currency}}" maxlength="64" class="input-small required"/>
								</td>

								<td class="tit" style="text-align: center">出资方式：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_contributionType" name="certificateConferenceSubList[{{idx}}].contributionType" type="text" value="{{row.contributionType}}" maxlength="64" class="input-small required"/>
								</td>

								<td class="tit" style="text-align: center">作价出资：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_contributionPrice" name="certificateConferenceSubList[{{idx}}].contributionPrice" type="text" value="{{row.contributionPrice}}" maxlength="64" class="input-small required"/>
								</td>
								</tr>
								<tr>
								<td class="tit" style="text-align: center">总认缴出资：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_totalPrice" name="certificateConferenceSubList[{{idx}}].totalPrice" type="text" value="{{row.totalPrice}}" maxlength="64" class="input-small required"/>
								</td>
								<td class="tit" style="text-align: center">资本缴足日期：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_payTime" name="certificateConferenceSubList[{{idx}}].payTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate required"
										value="{{row.payTime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
								</td>

								<td class="tit" style="text-align: center">参会状态：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_attendState" name="certificateConferenceSubList[{{idx}}].attendState" type="text" value="{{row.attendState}}" maxlength="6" class="input-small required"/>
								</td>

								<td class="tit" style="text-align: center">出资金额：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_fund" name="certificateConferenceSubList[{{idx}}].fund" type="text" value="{{row.fund}}" maxlength="12" class="input-small required"/>
								</td>
								</tr>
								<tr>
								<td class="tit" style="text-align: center">资本占比：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_sg" name="certificateConferenceSubList[{{idx}}].sg" type="text" value="{{row.sg}}" maxlength="10" class="input-small required"/>
								</td>

								<td class="tit" style="text-align: center">职位：</td>
								<td>
									<input id="certificateConferenceSubList{{idx}}_position" name="certificateConferenceSubList[{{idx}}].position" type="text" value="{{row.position}}" maxlength="64" class="input-small "/>
								</td>
								<td></td>
								<td></td>
								</tr>
								<tr style="text-align: center">

									<shiro:hasPermission name="conference:certificateConference:edit"><td class="text-center">
									{{#delBtn}}<span class="close" onclick="delRow(this, '#certificateConferenceSubList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
									</td>
									</shiro:hasPermission>

								</tr>
						</table>//-->
					</script>
					<script type="text/javascript">
						var certificateConferenceSubRowIdx = 0, certificateConferenceSubTpl = $("#certificateConferenceSubTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(certificateConference.certificateConferenceSubList)};
							for (var i=0; i<data.length; i++){
								addRow('#certificateConferenceSubList', certificateConferenceSubRowIdx, certificateConferenceSubTpl, data[i]);
								certificateConferenceSubRowIdx = certificateConferenceSubRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
		<div class="form-actions" style="text-align: center;">
			<shiro:hasPermission name="conference:certificateConference:edit"><input id="btnSubmit" class="btn btn-primary" style="text-align: center" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</table>
	</form:form>
</div>

</body>
</html>