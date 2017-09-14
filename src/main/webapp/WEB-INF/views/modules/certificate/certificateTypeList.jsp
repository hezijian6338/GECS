<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>证照类型管理</title>
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
		<li class="active"><a href="${ctx}/certificate/certificateType/">证照类型列表</a></li>
		<shiro:hasPermission name="certificate:certificateType:edit"><li><a href="${ctx}/certificate/certificateType/form">证照类型添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="certificateType" action="${ctx}/certificate/certificateType/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>证照类型编号：</label>
				<form:input path="certificateTypeCode" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>证照类型名称：</label>
				<form:input path="certificateTypeName" htmlEscape="false" maxlength="18" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>证照类型编号</th>
				<th>证照类型名称</th>
				<th>颁发机构名称</th>
				<th>有效期限（年）</th>
				<th>证照描述</th>
				<th>持证者类型</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="certificate:certificateType:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="certificateType">
			<tr>
				<td><a href="${ctx}/certificate/certificateType/form?id=${certificateType.id}">
					${certificateType.certificateTypeCode}
				</a></td>
				<td>
					${certificateType.certificateTypeName}
				</td>
				<td>
					${certificateType.office.name}
				</td>
				<td>
					${certificateType.effectiveDate}
				</td>
				<td>
					${certificateType.description}
				</td>
				<td>
					${certificateType.ownerType}
				</td>
				<td>
					<fmt:formatDate value="${certificateType.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateType.remarks}
				</td>
				<shiro:hasPermission name="certificate:certificateType:edit"><td>
    				<a href="${ctx}/certificate/certificateType/form?id=${certificateType.id}">修改</a>
					<a href="${ctx}/certificate/certificateType/delete?id=${certificateType.id}" onclick="return confirmx('确认要删除该证照类型吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>