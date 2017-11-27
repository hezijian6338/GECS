<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
        <div class="center_div1" >
            <div>
                <br>
                <h1 align="center"><font color="#317eac">选择需要申请证照</font></h1>
                <br>
                <br>
                <div>
                    <table  align="center" width="50%"   border="10"  bordercolor="#a0c6e5" cellspacing="20">
                        <tr>
                            <td><a href="${ctx}/license/businessLicense/applyBusinessLicense?typeName=营业执照" onMouseOut="swapImage('Image12','/static/licenseImages/business.jpg')" onMouseOver="swapImage('Image12','/static/licenseImages/business1.jpg')"><img src="/static/licenseImages/business.jpg" name="Image12" width="180" height="270" border="0" id="Image12" /></a></td>
                        <%--    <td><a href="xcb.html" onMouseOut="swapImage('Image13','/static/licenseImages/xc.jpg')" onMouseOver="swapImage('Image13','/static/licenseImages/xc2.jpg')"><img src="/static/licenseImages/xc.jpg" name="Image13" width="180" height="270" border="0" id="Image13" /></a></td>
                            <td><a href="zy.html" onMouseOut="swapImage('Image14','/static/licenseImages/zy.jpg')" onMouseOver="swapImage('Image14','/static/licenseImages/zy2.jpg')"><img src="/static/licenseImages/zy.jpg" name="Image14" width="180" height="270" border="0" id="Image14" /></a></td>
                        </tr>

                        <tr>
                            <td> <a href="jz.html" onMouseOut="swapImage('Image15','/static/licenseImages/jz.jpg')" onMouseOver="swapImage('Image15','/static/licenseImages/jz2.jpg')"><img src="/static/licenseImages/jz.jpg" name="Image15" width="180" height="270" border="0" id="Image15" /></a></td>
                            <td> <a href="index.html" onMouseOut="swapImage('Image16','/static/licenseImages/sy.jpg')" onMouseOver="swapImage('Image16','/static/licenseImages/sy2.jpg')"><img src="/static/licenseImages/sy.jpg" name="Image16" width="180" height="270" border="0" id="Image16" /></a></td>
                            <td> <a href="sc.html" onMouseOut="swapImage('Image17','/static/licenseImages/sc.jpg')" onMouseOver="swapImage('Image17','/static/licenseImages/sc2.jpg')"><img src="/static/licenseImages/sc.jpg" name="Image17" width="180" height="270" border="0" id="Image17" /></a></td>

                        </tr>

                        <tr>
                            <td> <a href="cm.html" onMouseOut="swapImage('Image18','/static/licenseImages/cm.jpg')" onMouseOver="swapImage('Image18','/static/licenseImages/cm2.jpg')"><img src="/static/licenseImages/cm.jpg" name="Image18" width="180" height="270" border="0" id="Image18" /></a></td>
                            <td> <a href="zc.html" onMouseOut="swapImage('Image19','/static/licenseImages/zc.jpg')" onMouseOver="swapImage('Image19','/static/licenseImages/zc2.jpg')"><img src="/static/licenseImages/zc.jpg" name="Image19" width="180" height="270" border="0" id="Image19" /></a></td>
                            <td> <a href="px.html" onMouseOut="swapImage('Image20','/static/licenseImages/px.jpg')" onMouseOver="swapImage('Image20','/static/licenseImages/px2.jpg')"><img src="/static/licenseImages/px.jpg" name="Image20" width="180" height="270" border="0" id="Image20" /></a></td>--%>
                        </tr>
                    </table>
                    <br>
                    <br>
                </div>
            </div>
        </div>
</body>
</html>
