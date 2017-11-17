<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营业执照元素生成表管理</title>
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
		<li class="active"><a href="${ctx}/license/businessElement/">营业执照元素生成表列表</a></li>
		<shiro:hasPermission name="license:businessElement:edit"><li><a href="${ctx}/license/businessElement/form">营业执照元素生成表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="businessElement" action="${ctx}/license/businessElement/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>元素英文名</th>
				<th>元素中文名</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="license:businessElement:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="businessElement">
			<tr>
				<td><a href="${ctx}/license/businessElement/form?id=${businessElement.id}">
					${businessElement.elementeng}
				</a></td>
				<td>
					${businessElement.elementchinese}
				</td>
				<td>
					<fmt:formatDate value="${businessElement.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${businessElement.remarks}
				</td>
				<shiro:hasPermission name="license:businessElement:edit"><td>
    				<a href="${ctx}/license/businessElement/form?id=${businessElement.id}">修改</a>
					<a href="${ctx}/license/businessElement/delete?id=${businessElement.id}" onclick="return confirmx('确认要删除该营业执照元素生成表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>