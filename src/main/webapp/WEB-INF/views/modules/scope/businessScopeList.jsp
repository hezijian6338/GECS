<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>经营范围管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/scope/businessScope/">经营范围列表</a></li>
		<shiro:hasPermission name="scope:businessScope:edit"><li><a href="${ctx}/scope/businessScope/form">经营范围添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="businessScope" action="${ctx}/scope/businessScope/" method="post" class="breadcrumb form-search">
		<table>
			<tr><td class="tit">归属类型:</td>
				<td>
				<div>
					<sys:treeselect id="parent" name="parent.id" value="${businessScope.parent.id}" labelName="parent.name" labelValue="${businessScope.parent.name}"
									title="归属类型(上级)" url="/scope/businessScope/treeData" extId="${businessScope.id}" cssClass="" allowClear="true"/>
				</div>
				</td>
				<td>&nbsp</td>
				<td class="tit">类别名称:</td>
				<td>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
				</td>
			<td class="tit"><ul class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></ul>
			</td>
			<td><ul class="clearfix"></ul></td>
			</tr>
		</table>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>类别名称</th>
				<th>排序</th>
				<th>类别编码</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="scope:businessScope:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/scope/businessScope/form?id={{row.id}}">
				{{row.name}}
			</a></td>
			<td>
				{{row.sort}}
			</td>
			<td>
				{{row.code}}
			</td>
			<td>
				{{row.updateDate}}
			</td>
			<td>
				{{row.remarks}}
			</td>
			<shiro:hasPermission name="scope:businessScope:edit"><td>
   				<a href="${ctx}/scope/businessScope/form?id={{row.id}}">修改</a>
				<a href="${ctx}/scope/businessScope/delete?id={{row.id}}" onclick="return confirmx('确认要删除该经营范围及所有子经营范围吗？', this.href)">删除</a>
				<a href="${ctx}/scope/businessScope/form?parent.id={{row.id}}">添加下级经营范围</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>