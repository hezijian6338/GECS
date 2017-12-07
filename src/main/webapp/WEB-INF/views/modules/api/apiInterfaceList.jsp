<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>API接口管理</title>
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
		<li class="active"><a href="${ctx}/api/apiInterface/">API接口列表</a></li>
		<shiro:hasPermission name="api:apiInterface:edit"><li><a href="${ctx}/api/apiInterface/form">API接口添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="apiInterface" action="${ctx}/api/apiInterface/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>公司名称：</label>
				<form:input path="company" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>公司名称</th>
				<th>公司类型</th>
				<th>用户编号</th>
				<th>TOKEN</th>
				<th>用户密钥</th>
				<th>过期时间</th>
				<th>联系人</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="api:apiInterface:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="apiInterface">
			<tr>
				<td><a href="${ctx}/api/apiInterface/form?id=${apiInterface.id}">
					${apiInterface.company}
				</a></td>
				<td>
					${apiInterface.companytype}
				</td>
				<td>
					${apiInterface.appid}
				</td>
				<td>
						${apiInterface.accesstoken}
				</td>
				<td>
						${apiInterface.appseceret}
				</td>
				<td>
					<fmt:formatDate value="${apiInterface.expiresIn}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${apiInterface.man}
				</td>
				<td>
					<fmt:formatDate value="${apiInterface.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${apiInterface.remarks}
				</td>
				<shiro:hasPermission name="api:apiInterface:edit"><td>
    				<a href="${ctx}/api/apiInterface/form?id=${apiInterface.id}">修改</a>
					<a href="${ctx}/api/apiInterface/delete?id=${apiInterface.id}" onclick="return confirmx('确认要删除该API接口吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>