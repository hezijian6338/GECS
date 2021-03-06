<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>营业执照管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">

        //窗口类型(电子营业执照)
        var iframeType = 1;

        $(document).ready(function() {

        });
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
        function getdetail1(s,id1) {
            console.log(id1);
            $.ajax({
                url:"${ctx}/license/businessLicense/detail/"+id1,
                type:"GET",
                success:function(result){
                    console.log(result);
                }});
        };
        function licenseInfo(s) {
            var rand = Math.random();
            path = s;
            if(path!=""&&path!=null){
                $('#btn_browse').modal({});
                url1=path+"?"+rand;
                $('#displayPdfIframe').attr("src",'${ctxStatic}/pdfjs/web/viewer.html?file='+url1);
            }else {
                alert("执照还未生成！");
            }
        }
	</script>
	<style type="text/css">
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
	<li class="active"><a href="${ctx}/license/businessLicense/">营业执照列表</a></li>
	<%--	<shiro:hasPermission name="license:businessLicense:edit"><li><a href="${ctx}/license/businessLicense/form">营业执照申请流程</a></li></shiro:hasPermission>--%>
</ul>
<form:form id="searchForm" modelAttribute="businessLicense" action="${ctx}/license/businessLicense/" method="post" class="breadcrumb form-search">

	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	<ul class="ul-form">
		<li><label>证照类型：</label>
			<form:input path="certificateTypeName" htmlEscape="false" maxlength="64" class="input-medium"/>
		</li>
		<li><label>公司名称：</label>
			<form:input path="certificateName" htmlEscape="false" maxlength="100" class="input-medium"/>
		</li>
		<li><label>颁发机构：</label>
			<sys:treeselect id="office" name="office.id" value="${businessLicense.office.id}" labelName="office.name" labelValue="${businessLicense.office.name}"
							title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
		</li>
		<li><label class="">公司类型：</label>
			<form:input path="registeredType" htmlEscape="false" maxlength="64" class="input-medium"/>
		</li>
		<li class="btns"><input id="btnSubmit" class="btn btn-primary input-medium" type="submit" value="查询"/></li>
		<li class="clearfix"></li>
	</ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
	<thead>
	<tr>
		<th>证照类型 </th>
		<th>统一社会信用代码</th>
		<th>公司名称</th>
		<th>颁发机构</th>
		<th>证照有效期（起始)</th>
		<th>证照有效期（截至）</th>
		<th>注册公司类型</th>
		<th>法人姓名</th>
		<th>经办人姓名</th>
		<th>经营/业务/许可范围</th>
		<%--<th>所属区域</th>--%>
		<th>状态</th>
		<th>创建者</th>
		<th>更新时间</th>
		<shiro:hasPermission name="license:businessLicense:edit"><th>操作</th></shiro:hasPermission>
	</tr>
	</thead>
	<tbody>
	<c:forEach items="${page.list}" var="businessLicense">
		<tr>
			<td><a href="${ctx}/license/businessLicense/form?id=${businessLicense.id}">
					${businessLicense.certificateTypeName}
			</a></td>
			<td>
					${businessLicense.certificateCode}
			</td>
			<td>
					${businessLicense.certificateName}
			</td>
			<td>
					${businessLicense.office.name}
			</td>
			<td>
				<fmt:formatDate value="${businessLicense.effectiveDateStar}" pattern="yyyy-MM-dd "/>
			</td>
			<td>
				<fmt:formatDate value="${businessLicense.effectiveDateEnd}" pattern="yyyy-MM-dd "/>
			</td>
			<td>
					${businessLicense.registeredType}
			</td>
			<td>
					${businessLicense.persionName}
			</td>
			<td>
					${businessLicense.handlerName}
			</td>

			<td>
					${businessLicense.scope.name}
			</td>

			<%--<td>
					${businessLicense.area.name}
			</td>--%>
			<td>
				<c:if test="${businessLicense.status eq '审核通过'}">
				<font size="3" color="green">
					${businessLicense.status}
				</font>
				</c:if>
				<c:if test="${businessLicense.status ne '审核通过'}">
					<font size="3" color="red">
							${businessLicense.status}
					</font>
				</c:if>
			</td>
			<td>
					${businessLicense.createBy.name}
			</td>
			<td>
				<fmt:formatDate value="${businessLicense.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</td>
			<shiro:hasPermission name="license:businessLicense:edit"><td>
				<a href="${ctx}/license/businessLicense/form?id=${businessLicense.id}">详情</a>
				<a data-toggle="modal" onclick="licenseInfo('${businessLicense.path}')">预览</a>
				<a href="javascript:location.href=encodeURI('${ctx}/license/businessLicense/downLoad?certificateName=${businessLicense.certificateName}')">下载</a>
				<a href="${ctx}/license/businessLicense/delete?id=${businessLicense.id}" onclick="return confirmx('确认要删除该营业执照吗？', this.href)">删除</a>
			</td></shiro:hasPermission>
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