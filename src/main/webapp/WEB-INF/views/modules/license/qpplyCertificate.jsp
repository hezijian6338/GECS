<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
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
        .modal {
            width: 900px;
            margin-left: -450px;
        }
        .btn-sign{
            display: block;
            margin: 0 auto;
            width: 40%;
        }
    </style>
    <script type="text/javascript">

        function swapImage(x,src1) {
            document.getElementById(x).src=src1
        }

        var fileType = 0;
        function signDoc(type) {
            var path
            switch (type) {
                case 1:
                    path = $("input[id='applynamePdfpath']").val();
                    $('#myModalLabel').text("申请书");
                    fileType = 1;
                    break;
                case 2:
                    path = $("input[id='meetingPdfpath']").val();
                    $('#myModalLabel').text("股东会决议");
                    fileType = 2;
                    break;
                case 3:
                    path = $("input[id='rulesPdfpath']").val();
                    $('#myModalLabel').text("公司章程");
                    fileType = 3;
                    break;
            }
            var rand = Math.random();
            if(path!=""&&path!=null){
                $('#btn_browse').modal({});
                fileURL = path + "?" + rand;
                console.log("fileURL:" + fileURL)
                $('#displayPdfIframe').attr("src", '${ctxStatic}/pdfSign/web/pdf.html?file=' + fileURL);
                setTimeout(function () {
                    console.log('刷新')
                    $('#displayPdfIframe').attr('src','${ctxStatic}/pdfSign/web/pdf.html?file=' + fileURL);
                },1000)
            } else {
                alert("找不到文件，请联系管理员！");
            }
        }

        var finishFlag = 0;
        //签署成功后给input框赋值(更新路径)并关闭iframe窗口
        function updatePath(path,type) {
            switch (type) {
                case 1:
                    $('#applynamePdfpath').val(path);
                    $('#closebtn').click();
                    $('#applyName').hide();
                    $('#applyNameDo').show();
                    finishFlag = finishFlag + 1;
                    break;
                case 2:
                    $('#meetingPdfpath').val(path);
                    $('#closebtn').click();
                    $('#conference').hide();
                    $('#conferenceDo').show();
                    finishFlag = finishFlag + 1;
                    break;
                case 3:
                    $('#rulesPdfpath').val(path);
                    $('#closebtn').click();
                    $('#zhangcheng').hide();
                    $('#zhangchengDo').show();
                    finishFlag = finishFlag + 1;
                    break;
            }
        }
        function finishAll() {
            if (finishFlag != 3){
                alert("请签署完全部文件！");
            }else {
                $('#inputForm').submit();
            }
        }

    </script>
</head>
    <body>
        <form:form id="inputForm" modelAttribute="certificateConference1" action="${ctx}/conference/certificateConference/updatePdfPath" method="post" class="form-horizontal">
        <div class="center_div1" >
            <div>
                <br>
                <h1 align="center"><font color="#317eac">请签署以下文件</font></h1>
                <h4 style="color: red" align="center">*请确认已在I签APP注册过电子签名</h4>
                <form:input path="id"  htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true" cssStyle="display: none"/>
                <%--<h5>章程pdf路径</h5>--%>
                <form:input id="rulesPdfpath" path="rulesPdfpath" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true" cssStyle="display: none"/>
                <%--<h5>名称申请pdf路径</h5>--%>
                <form:input id="applynamePdfpath" path="applynamePdfpath" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true" cssStyle="display: none"/>
                <%--<h5>会议决议pdf路径</h5>--%>
                <form:input id="meetingPdfpath" path="meetingPdfpath" htmlEscape="false" maxlength="64" class="input-xlarge required" readonly="true" cssStyle="display: none"/>

                <br>
                <br>
                <div>
                    <table  class="table table-bordered table-hover" align="center" width="90%"   border="10"  bordercolor="#a0c6e5" cellspacing="20">
                        <tr>
<%--
                            <td><a href="${ctx}/license/businessLicense/applyBusinessLicense?typeName=营业执照" onMouseOut="swapImage('Image12','/static/licenseImages/applayName.png')" onMouseOver="swapImage('Image12','/static/licenseImages/business1.jpg')"><img src="/static/licenseImages/business.jpg" name="Image12" width="280" height="470" border="0" id="Image12" /></a></td>
--%>
                            <td><img src="/static/licenseImages/applyName.png" name="Image1" id="Image1"  style="height: 495px;width:380px;"/></td>
                            <td><img src="/static/licenseImages/conference.png" name="Image3" id="Image3"  style="height: 495px;width:380px;"/></td>
                            <td><img src="/static/licenseImages/zhangcheng.png" name="Image2" id="Image2"  style="height: 495px;width:380px;" /></td>
                        </tr>
                        <tr>
                            <td align="center">
                                <a class="btn btn-success btn-sign" data-toggle="modal" id="applyName"
                                   onclick="signDoc(1)" >点击签名</a>
                                <a class="btn btn-danger btn-sign" id="applyNameDo" disabled style="display: none">已签署</a>
                            </td>
                            <td align="center">
                                <a class="btn btn-success btn-sign" data-toggle="modal" id="conference"
                                   onclick="signDoc(2)" >点击签名</a>
                                <a class="btn btn-danger btn-sign" id="conferenceDo" disabled style="display: none">已签署</a>
                            </td>
                            <td align="center">
                                <a class="btn btn-success btn-sign" data-toggle="modal" id="zhangcheng"
                                   onclick="signDoc(3)" >点击签名</a>
                                <a class="btn btn-danger btn-sign" id="zhangchengDo" disabled style="display: none">已签署</a>
                            </td>
                        </tr>
                    </table>
                    <br>
                    <div class="form-actions" style="text-align: center;padding-left:0;">
                        <input type="button" id="finish" value="完成" class="btn btn-primary" onclick="finishAll()"/>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
                    </div>
                    <br>
                    <br>
                </div>
            </div>
        </div>

            <!--预览模态框-->
            <div id="btn_browse" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true"
                 style="width: 100%;height: 100%;left: 450px; top:0px;">
                <div class="modal-header" style="background-color: rgb(0,0,0); filter: alpha(opacity=10);">
                    <button id="closebtn" type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color:white;">X</button>
                    <h3 id="myModalLabel" style="color: white;"></h3>
                </div>
                <div class="modal-body" style="width: 100%;max-height: 800px; padding: 0px;overflow:hidden;">

                    <iframe id="displayPdfIframe" width="100%" height="780px"></iframe>

                </div>
            </div>
        </form:form>
</body>
</html>