<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营业执照管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/license/businessLicense/">营业执照列表</a></li>
		<shiro:hasPermission name="license:businessLicense:edit"><li><a href="${ctx}/license/businessLicense/form">营业执照申请流程</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="businessLicense" action="${ctx}/license/businessLicense/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>证照类型：</label>
				<form:input path="certificateTypeId" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>证照名称：</label>
				<form:input path="certificateName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>颁发机构id：</label>
				<sys:treeselect id="office" name="office.id" value="${businessLicense.office.id}" labelName="office.name" labelValue="${businessLicense.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>注册公司类型：</label>
				<form:input path="registeredType" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>证照类型</th>
				<th>证照编号</th>
				<th>证照名称</th>
				<th>颁发机构id</th>
				<th>成立日期</th>
				<th>证照有效期（起始</th>
				<th>证照有效期（截至）</th>
				<th>注册公司类型</th>
				<th>注册资本</th>
				<th>地址</th>
				<th>法人姓名</th>
				<th>法人证件类型</th>
				<th>法人证件号码</th>
				<th>法人联系方式</th>
				<th>经办人姓名</th>
				<th>经办人证件类型</th>
				<th>经办人证件号码</th>
				<th>经办人联系方式</th>
				<th>经营/业务/许可范围</th>
				<th>建筑名称</th>
				<th>层数</th>
				<th>使用面积</th>
				<th>使用情况</th>
				<th>现有消防设施</th>
				<th>邮政编码</th>
				<th>所属区域</th>
				<th>创建者</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="license:businessLicense:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="businessLicense">
			<tr>
				<td><a href="${ctx}/license/businessLicense/form?id=${businessLicense.id}">
					${businessLicense.certificateTypeId}
				</a></td>
				<td>
					${businessLicense.certificateCode}
				</td>
				<td>
					${businessLicense.certificateName}
				</td>
				<td>
					${businessLicense.office.name}
				</td>
				<td>
					<fmt:formatDate value="${businessLicense.establishDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${businessLicense.effectiveDateStar}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${businessLicense.effectiveDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${businessLicense.registeredType}
				</td>
				<td>
					${businessLicense.registeredCapital}
				</td>
				<td>
					${businessLicense.address}
				</td>
				<td>
					${businessLicense.persionName}
				</td>
				<td>
					${businessLicense.persionIdType}
				</td>
				<td>
					${businessLicense.personId}
				</td>
				<td>
					${businessLicense.persionPhone}
				</td>
				<td>
					${businessLicense.handlerName}
				</td>
				<td>
					${businessLicense.handlerIdType}
				</td>
				<td>
					${businessLicense.handlerId}
				</td>
				<td>
					${businessLicense.handlerPhone}
				</td>
				<td>
					${businessLicense.scope}
				</td>
				<td>
					${businessLicense.buildingName}
				</td>
				<td>
					${businessLicense.floorNumber}
				</td>
				<td>
					${businessLicense.useArea}
				</td>
				<td>
					${businessLicense.usage1}
				</td>
				<td>
					${businessLicense.dealfireFacilities}
				</td>
				<td>
					${businessLicense.postcode}
				</td>
				<td>
					${businessLicense.area.name}
				</td>
				<td>
					${businessLicense.createBy.id}
				</td>
				<td>
					${businessLicense.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${businessLicense.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${businessLicense.remarks}
				</td>
				<shiro:hasPermission name="license:businessLicense:edit"><td>
    				<a href="${ctx}/license/businessLicense/form?id=${businessLicense.id}">修改</a>
					<a href="${ctx}/license/businessLicense/delete?id=${businessLicense.id}" onclick="return confirmx('确认要删除该营业执照吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>