<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="decorator" content="default"/>
    <title>选择申请证照</title>
    <style>
        body
        {
            margin-left:10%;
            background:#45aeea;
        }
        .center_div1
        {
            margin-left:10%;
            text-align:center;
            border:1px solid gray;
            width:70%;
            background-color:#FFF;
            text-align:left;
        }
        td.top1
        {
            height:auto;
            width:300%;
            text-align:center;
            border:1px solid gray;
            background-color:#00FFFF;
            text-align:center;
            display:inline;
            border:none;
        }
    </style>
    <script type="text/javascript">
        function swapImage(x,src1) {
            document.getElementById(x).src=src1
        }
    </script>
</head>
    <body>
        <form:form id="inputForm" modelAttribute="certificateConference1" action="${ctx}/conference/certificateConference/updatePdfPath" method="post" class="form-horizontal">
        <div class="center_div1" >
            <div>
                <br>
                <h1 align="center"><font color="#317eac">请签署以下文件</font></h1>
                <form:input path="id"  htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
                <h5>章程pdf路径</h5>
                <form:input path="rulesPdfpath" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
                <h5>名称申请pdf路径</h5>
                <form:input path="applynamePdfpath" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
                <h5>会议决议pdf路径</h5>
                <form:input path="meetingPdfpath" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true"/>
                <br>
                <br>
                <div>
                    <table  class="table table-bordered table-hover" align="center" width="90%"   border="10"  bordercolor="#a0c6e5" cellspacing="20">
                        <tr>
<%--
                            <td><a href="${ctx}/license/businessLicense/applyBusinessLicense?typeName=营业执照" onMouseOut="swapImage('Image12','/static/licenseImages/applayName.png')" onMouseOver="swapImage('Image12','/static/licenseImages/business1.jpg')"><img src="/static/licenseImages/business.jpg" name="Image12" width="280" height="470" border="0" id="Image12" /></a></td>
--%>
                            <td><img src="/static/licenseImages/applyName.png" name="Image1" id="Image1"  style="height: 550px;width:380px;"/></td>
                            <td><img src="/static/licenseImages/zhangcheng.png" name="Image2" id="Image2"  style="height: 550px;width:380px;" /></td>
                            <td><img src="/static/licenseImages/conference.png" name="Image3" id="Image3"  style="height: 550px;width:380px;"/></td>
                        </tr>
                        <tr>
                            <td align="center"><input type="button" id="applyName" value="点击签名" class="btn btn-primary"/> </td>
                            <td align="center"><input type="button" id="zhangcheng" value="点击签名" class="btn btn-primary"/> </td>
                            <td align="center"><input type="button" id="conference" value="点击签名" class="btn btn-primary"/> </td>
                        </tr>
                    </table>
                    <br>
                    <div class="form-actions" style="text-align: center">
                        <input type="button" id="finish" value="完成" class="btn btn-primary" />&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
                    </div>
                    <br>
                    <br>
                </div>
            </div>
        </div>
</form:form>
</body>
</html>
