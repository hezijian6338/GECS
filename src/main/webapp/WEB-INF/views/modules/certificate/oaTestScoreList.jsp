<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生分数修改申请审批流程管理</title>
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
		<li class="active"><a href="${ctx}/certificate/oaTestScore/">学生分数修改申请审批流程列表</a></li>
		<shiro:hasPermission name="certificate:oaTestScore:edit"><li><a href="${ctx}/certificate/oaTestScore/form">学生分数修改申请审批流程添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaTestScore" action="${ctx}/certificate/oaTestScore/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>学号：</label>
				<form:input path="stuNo" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>姓名：</label>
				<form:input path="stuName" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>学号</th>
				<th>姓名</th>
				<th>现在分数</th>
				<th>调整分数</th>
				<th>调整原因</th>
				<th>本门课程负责老师意见</th>
				<th>辅导员意见</th>
				<th>创建者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="certificate:oaTestScore:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaTestScore">
			<tr>
				<td><a href="${ctx}/certificate/oaTestScore/form?id=${oaTestScore.id}">
					${oaTestScore.stuNo}
				</a></td>
				<td>
					${oaTestScore.stuName}
				</td>
				<td>
					${oaTestScore.oldscore}
				</td>
				<td>
					${oaTestScore.newscore}
				</td>
				<td>
					${oaTestScore.content}
				</td>
				<td>
					${oaTestScore.tText}
				</td>
				<td>
					${oaTestScore.leadText}
				</td>
				<td>
					${oaTestScore.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${oaTestScore.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${oaTestScore.remarks}
				</td>
				<shiro:hasPermission name="certificate:oaTestScore:edit"><td>
    				<a href="${ctx}/certificate/oaTestScore/form?id=${oaTestScore.id}">修改</a>
					<a href="${ctx}/certificate/oaTestScore/delete?id=${oaTestScore.id}" onclick="return confirmx('确认要删除该学生分数修改申请审批流程吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>