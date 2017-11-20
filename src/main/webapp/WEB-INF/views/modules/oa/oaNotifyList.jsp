<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>通知管理</title>
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

        function licenseInfo(s) {
            var rand = Math.random();
            var path = s;
            if(path!=""&&path!=null){
                $('#btn_browse').modal({});
                url1=path+"?"+rand;
                $('#displayPdfIframe').attr("src",'${ctxStatic}/pdfjs/web/viewer.html?file='+encodeURIComponent(url1));
            }else {
                alert("执照还未生成！");
            }
        }
	</script>
	<style type="text/css">
		.bg-primary {
			color: #fff;
			background-color: #337ab7;
		}
		a.bg-primary:hover,
		a.bg-primary:focus {
			background-color: #286090;
		}

		.bg-info {
			background-color: #d9edf7;
		}
		.modal {
			width:900px;
			margin-left:-450px;
		}
		@media (min-width: 992px) {
			.modal-lg {
				width: 900px;
			}
		}
	</style>
</head>

<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}">通知列表</a></li>
		<%--<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit"><li><a href="${ctx}/oa/oaNotify/form">通知添加</a></li></shiro:hasPermission></c:if>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="oaNotify" action="${ctx}/oa/oaNotify/${oaNotify.self?'self':''}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<c:if test="${!fns:isPopulace()}">
		<ul class="ul-form">
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="200" class="input-medium"/>
			</li>
			<li><label>类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('oa_notify_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>状态：</label>
				<form:radiobuttons path="status" items="${fns:getDictList('oa_notify_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</c:if>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>类型</th>
				<th>状态</th>
				<th>查阅状态</th>
				<th>更新时间</th>
				<%--<c:if test="${!oaNotify.self}"><shiro:hasPermission name="oa:oaNotify:edit">--%><th>操作</th><%--</shiro:hasPermission></c:if>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaNotify">
			<tr>
				<td><%--<a href="${ctx}/oa/oaNotify/${requestScope.oaNotify.self?'view':'form'}?id=${oaNotify.id}">--%>
					<%--${fns:abbr(oaNotify.title,100)}--%>
					<a href="${ctx}/license/businessLicense/form?id=${oaNotify.content}">
					${oaNotify.title}
				</a></td>
				<td>
					<%--${fns:getDictLabel(oaNotify.type, 'oa_notify_type', '')}--%>
					${oaNotify.type}
				</td>
				<td>
					<%--${fns:getDictLabel(oaNotify.status, 'oa_notify_status', '')}--%>
					<c:if test="${oaNotify.status eq '审核通过'}">
						<font size="3" color="green">
						  ${oaNotify.status}
						</font>
					</c:if>
					<c:if test="${oaNotify.status ne '审核通过'}">
						<font size="3" color="red">
								${oaNotify.status}
						</font>
					</c:if>

				</td>
				<td>
					<%--<c:if test="${requestScope.oaNotify.self}">
						${fns:getDictLabel(oaNotify.readFlag, 'oa_notify_read', '')}
					</c:if>
					<c:if test="${!requestScope.oaNotify.self}">--%>
						${oaNotify.readNum} / ${oaNotify.readNum + oaNotify.unReadNum}
					<%--</c:if>--%>
				</td>
				<td>
					<fmt:formatDate value="${oaNotify.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<c:if test="${!fns:isPopulace()}">
    				<%--<a href="${ctx}/oa/oaNotify/form?id=${oaNotify.id}">修改</a>--%>
				<%--	<a href="${ctx}/oa/oaNotify/delete?id=${oaNotify.id}" onclick="return confirmx('确认要删除该通知吗？', this.href)">删除</a>--%>
					</c:if>
					<a data-toggle="modal" onclick="licenseInfo('${oaNotify.files}')">预览</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<!--预览模态框-->
	<div id="btn_browse" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
		 style="width: 100%;height: 100%;left: 450px; top:0px;">
		<div class="modal-header" style="background-color: rgb(0,0,0); filter: alpha(opacity=10);">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white;">×</button>
			<h3 id="myModalLabel">预览</h3>
		</div>
		<div class="modal-body" style="width: 100%;max-height: 800px; padding: 0px;">

			<iframe id="displayPdfIframe" width="100%" height="780px"></iframe>

		</div>
	</div>
</body>
</html>