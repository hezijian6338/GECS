<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%--<meta name="decorator" content="default"/>--%>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9"/>
<script type="text/javascript" src="${ctxStatic}/js/jquery-1.8.3.min.js"></script>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-1.12.4.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-ui.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-v1.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-v1-ui.js"></script>--%>

<%--ckfinder相关的css&js--%>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/ckfinder/_samples/sample.css"/>
<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
<%--pdf的IE预览插件--%>
<script type="text/javascript" src="${ctxStatic}/js/jquery.media.js"></script>
<body>
<div id="pdf" style="position: absolute;top: 2%;left: 25%"></div>
<h1 class="samples">
    模板（文件）管理
</h1>

<!-- Button trigger modal -->
<%--<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">--%>
    <%--Launch demo modal--%>
<%--</button>--%>



<script type="text/javascript">

    // You can use the "CKFinder" class to render CKFinder in a page:
    var finder = new CKFinder();
    // The path for the installation of CKFinder (default = "/ckfinder/").
    finder.basePath = '../';
    // The default height is 400.
    finder.height = 600;
    // This is a sample function which is called when a file is selected in CKFinder.
    finder.selectActionFunction = viewSFF;

    finder.create();

    function preview(fileUrl, data, allFiles) {
        window.open("previewWindows.html" + "?url=" + fileUrl, "previewWindows", "height=100, width=400, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no"); //写成一行
    }

    function closeWindow() {
        document.getElementById('pdf').innerHTML = "";
    }

    function viewSFF(fileUrl, data) {
        // document.getElementById('xFilePath').value = fileUrl;
        var url = "/picFile" + fileUrl;
        var sFileName = this.getSelectedFile().name;
        document.getElementById('pdf').innerHTML =
            '<button type="button" class="close" onclick="closeWindow()" >'
            + '&times;' +
            ' </button>' +
        '<a class="media" href="' + url + '">' +
        '</a>' + '<div class="caption" style="padding-top: 0.8em">' +
        '<a href="' + data["fileUrl"] + '" target="_blank">' + sFileName + '</a> (' + data["fileSize"] + 'KB)' +
        '</div>';

        $('a.media').media({width: 800, height: 600});

//        $('#myModal').modal({});


        //document.getElementById('preview').style.display = "";
        // It is not required to return any value.
        // When false is returned, CKFinder will not close automatically.
        return true;
    }

    // This is a sample function which is called when a file is selected in CKFinder.
    function showFileInfo(fileUrl, data, allFiles) {
        var msg = 'The last selected file is: <a href="' + fileUrl + '">' + fileUrl + '</a><br /><br />';
        // Display additional information available in the "data" object.
        // For example, the size of a file (in KB) is available in the data["fileSize"] variable.
        if (fileUrl != data['fileUrl'])
            msg += '<b>File url:</b> ' + data['fileUrl'] + '<br />';
        msg += '<b>File size:</b> ' + data['fileSize'] + 'KB<br />';
        msg += '<b>Last modified:</b> ' + data['fileDate'];

        if (allFiles.length > 1) {
            msg += '<br /><br /><b>Selected files:</b><br /><br />';
            msg += '<ul style="padding-left:20px">';
            for (var i = 0; i < allFiles.length; i++) {
                // See also allFiles[i].url
                msg += '<li>' + allFiles[i].data['fileUrl'] + ' (' + allFiles[i].data['fileSize'] + 'KB)</li>';
            }
            msg += '</ul>';
        }
        // this = CKFinderAPI object
        this.openMsgDialog("Selected file", msg);
    }

    // It can also be done in a single line, calling the "static"
    // create( basePath, width, height, selectActionFunction ) function:
    // CKFinder.create( '../', null, null, showFileInfo );

    // The "create" function can also accept an object as the only argument.
    // CKFinder.create( { basePath : '../', selectActionFunction : showFileInfo } );
</script>

<!-- Modal -->
<%--<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">--%>
    <%--<div class="modal-dialog" role="document">--%>
        <%--<div class="modal-content">--%>
            <%--<div class="modal-header">--%>
                <%--<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>--%>
                <%--<h4 class="modal-title" id="myModalLabel">Modal title</h4>--%>
            <%--</div>--%>
            <%--<div class="modal-body">--%>
                <%--...--%>
            <%--</div>--%>
            <%--<div class="modal-footer">--%>
                <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                <%--<button type="button" class="btn btn-primary">Save changes</button>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>
</body>
</html>
