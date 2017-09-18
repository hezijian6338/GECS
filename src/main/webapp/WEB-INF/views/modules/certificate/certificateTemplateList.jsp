<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>证照模板管理</title>
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
		<li class="active"><a href="${ctx}/certificate/certificateTemplate/">证照模板列表</a></li>
		<shiro:hasPermission name="certificate:certificateTemplate:edit"><li><a href="${ctx}/certificate/certificateTemplate/form">证照模板添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="certificateTemplate" action="${ctx}/certificate/certificateTemplate/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>模板名称：</label>
				<form:input path="templateName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>模板类型：</label>
				<form:input path="templateType" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>所属单位id：</label>
				<sys:treeselect id="office" name="office.id" value="${certificateTemplate.office.id}" labelName="office.name" labelValue="${certificateTemplate.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>所属区域：</label>
				<sys:treeselect id="area" name="area.id" value="${certificateTemplate.area.id}" labelName="area.name" labelValue="${certificateTemplate.area.name}"
					title="区域" url="/sys/area/treeData" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>模板名称</th>
				<th>模板类型</th>
				<th>所属单位id</th>
				<th>所属区域</th>
				<th>是否共享</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="certificate:certificateTemplate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="certificateTemplate">
			<tr>
				<td><a href="${ctx}/certificate/certificateTemplate/form?id=${certificateTemplate.id}">
					${certificateTemplate.templateName}
				</a></td>
				<td>
					${certificateTemplate.templateType}
				</td>
				<td>
					${certificateTemplate.office.name}
				</td>
				<td>
					${certificateTemplate.area.name}
				</td>
				<td>
					${certificateTemplate.isShare}
				</td>
				<td>
					${certificateTemplate.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${certificateTemplate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateTemplate.remarks}
				</td>
				<shiro:hasPermission name="certificate:certificateTemplate:edit"><td>
    				<a href="${ctx}/certificate/certificateTemplate/form?id=${certificateTemplate.id}">修改</a>
					<a href="${ctx}/certificate/certificateTemplate/delete?id=${certificateTemplate.id}" onclick="return confirmx('确认要删除该证照模板吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>