<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>证照元数据管理</title>
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
		<li class="active"><a href="${ctx}/certificate/certificateInfo/">证照元数据列表</a></li>
		<shiro:hasPermission name="certificate:certificateInfo:edit"><li><a href="${ctx}/certificate/certificateInfo/form">证照元数据添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="certificateInfo" action="${ctx}/certificate/certificateInfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>证照编号：</label>
				<form:input path="certificateCode" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>颁发机构id：</label>
				<sys:treeselect id="office" name="office.id" value="${certificateInfo.office.id}" labelName="office.name" labelValue="${certificateInfo.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>所属区域：</label>
				<sys:treeselect id="area" name="area.id" value="${certificateInfo.area.id}" labelName="area.name" labelValue="${certificateInfo.area.name}"
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
				<th>法人身份证件类型</th>
				<th>法人身份证件号码</th>
				<th>法人联系方式</th>
				<th>经办人姓名</th>
				<th>经办人身份证件类型</th>
				<th>经办人身份证件号码</th>
				<th>经办人联系方式</th>
				<th>经营/业务/许可范围</th>
				<th>建筑名称</th>
				<th>层数</th>
				<th>使用面积</th>
				<th>使用情况</th>
				<th>现有消防设施</th>
				<th>邮政编码</th>
				<th>所属区域</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="certificate:certificateInfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="certificateInfo">
			<tr>
				<td><a href="${ctx}/certificate/certificateInfo/form?id=${certificateInfo.id}">
					${certificateInfo.certificateCode}
				</a></td>
				<td>
					${certificateInfo.certificateName}
				</td>
				<td>
					${certificateInfo.office.name}
				</td>
				<td>
					<fmt:formatDate value="${certificateInfo.establishDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${certificateInfo.effectiveDateStar}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${certificateInfo.effectiveDateEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateInfo.registeredType}
				</td>
				<td>
					${certificateInfo.registeredCapital}
				</td>
				<td>
					${certificateInfo.address}
				</td>
				<td>
					${certificateInfo.persionName}
				</td>
				<td>
					${certificateInfo.persionIdType}
				</td>
				<td>
					${certificateInfo.personId}
				</td>
				<td>
					${certificateInfo.persionPhone}
				</td>
				<td>
					${certificateInfo.handlerName}
				</td>
				<td>
					${certificateInfo.handlerIdType}
				</td>
				<td>
					${certificateInfo.handlerId}
				</td>
				<td>
					${certificateInfo.handlerPhone}
				</td>
				<td>
					${certificateInfo.scope}
				</td>
				<td>
					${certificateInfo.buildingName}
				</td>
				<td>
					${certificateInfo.floorNumber}
				</td>
				<td>
					${certificateInfo.useArea}
				</td>
				<td>
					${certificateInfo.usage1}
				</td>
				<td>
					${certificateInfo.dealfireFacilities}
				</td>
				<td>
					${certificateInfo.postcode}
				</td>
				<td>
					${certificateInfo.area.name}
				</td>
				<td>
					${certificateInfo.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${certificateInfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${certificateInfo.remarks}
				</td>
				<shiro:hasPermission name="certificate:certificateInfo:edit"><td>
					<a onclick="getDetail('${certificateInfo}')">详情</a>
    				<a href="${ctx}/certificate/certificateInfo/form?id=${certificateInfo.id}">修改</a>
					<a href="${ctx}/certificate/certificateInfo/delete?id=${certificateInfo.id}" onclick="return confirmx('确认要删除该证照元数据吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<div id="dateModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="width: 900px;left: 40%;">
		<div class="modal-header" style="background-color: #0D8BBD;">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="font-size: 20px;color: #000000;">×</button>
			<h3 id="myModalLabel" style="color: #000000;">详情</h3>
		</div>
		<div class="modal-body" style="background-color: #0bbbee;">

		</div>
	</div>

</body>
</html>