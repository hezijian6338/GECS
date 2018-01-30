<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>股东会议表管理</title>
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
		<li class="active"><a href="${ctx}/conference/certificateConference/">股东会议表列表</a></li>
		<shiro:hasPermission name="conference:certificateConference:edit"><li><a href="${ctx}/conference/certificateConference/form">股东会议表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="certificateConference" action="${ctx}/conference/certificateConference/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>公司名称：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="40" class="input-medium"/>
			</li>
			<li><label>会议时间：</label>
				<input name="conferenceTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${certificateConference.conferenceTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>会议类型</th>
				<th>公司名称</th>
				<th>通知方式</th>
				<th>通知时间</th>
				<th>公司地址</th>
				<th>经营场所</th>
				<th>注册资本</th>
				<th>会议时间</th>
				<th>章程订立日期</th>
				<th>会议地址</th>
				<th>是否设立董事会</th>
				<th>更新时间</th>
				<shiro:hasPermission name="conference:certificateConference:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="certificateConference">
			<tr>
				<td><a href="${ctx}/conference/certificateConference/form?id=${certificateConference.id}">
					${certificateConference.conferenceType}
				</a></td>
				<td>
					${certificateConference.companyName}
				</td>
				<td>
					${certificateConference.conferenceInformType}
				</td>
				<td>
					<fmt:formatDate value="${certificateConference.conferenceInformTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateConference.companyAddr}
				</td>
				<td>
					${certificateConference.manageAddr}
				</td>
				<td>
					${certificateConference.registerFund}
				</td>
				<td>
					<fmt:formatDate value="${certificateConference.conferenceTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${certificateConference.concludeDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateConference.conferenceAddr}
				</td>
				<td>
					${certificateConference.setDirectors}
				</td>
				<td>
					<fmt:formatDate value="${certificateConference.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="conference:certificateConference:edit"><td>
    				<a href="${ctx}/conference/certificateConference/form?id=${certificateConference.id}">修改</a>
					<a href="${ctx}/conference/certificateConference/delete?id=${certificateConference.id}" onclick="return confirmx('确认要删除该股东会议表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>