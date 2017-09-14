<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>证照库管理</title>
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
		<li class="active"><a href="${ctx}/certificate/certificateLibrary/">证照库列表</a></li>
		<shiro:hasPermission name="certificate:certificateLibrary:edit"><li><a href="${ctx}/certificate/certificateLibrary/form">证照库添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="certificateLibrary" action="${ctx}/certificate/certificateLibrary/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>证照名称：</label>
				<form:input path="certificateName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>证照有效期（起始：</label>
				<input name="effectiveDateStart" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${certificateLibrary.effectiveDateStart}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>证照有效期（截至）：</label>
				<input name="effectiveDateEnd" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${certificateLibrary.effectiveDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>证照名称</th>
				<th>证照描述</th>
				<th>颁发机构名称</th>
				<th>持证者类型</th>
				<th>证照有效期（起始</th>
				<th>证照有效期（截至）</th>
				<th>状态</th>
				<th>所属区域</th>
				<th>是否核发</th>
				<th>核发日期</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="certificate:certificateLibrary:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="certificateLibrary">
			<tr>
				<td><a href="${ctx}/certificate/certificateLibrary/form?id=${certificateLibrary.id}">
					${certificateLibrary.certificateName}
				</a></td>
				<td>
					${certificateLibrary.description}
				</td>
				<td>
					${certificateLibrary.office.name}
				</td>
				<td>
					${certificateLibrary.ownerType}
				</td>
				<td>
					<fmt:formatDate value="${certificateLibrary.effectiveDateStart}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${certificateLibrary.effectiveDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateLibrary.status}
				</td>
				<td>
					${certificateLibrary.area.name}
				</td>
				<td>
					${certificateLibrary.isIssue}
				</td>
				<td>
					<fmt:formatDate value="${certificateLibrary.issueDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${certificateLibrary.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateLibrary.remarks}
				</td>
				<shiro:hasPermission name="certificate:certificateLibrary:edit"><td>
    				<a href="${ctx}/certificate/certificateLibrary/form?id=${certificateLibrary.id}">修改</a>
					<a href="${ctx}/certificate/certificateLibrary/delete?id=${certificateLibrary.id}" onclick="return confirmx('确认要删除该证照库吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>