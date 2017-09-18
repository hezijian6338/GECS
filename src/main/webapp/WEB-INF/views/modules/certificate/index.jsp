<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE9"/>
<head><title>Moudle Demo</title></head>
<script type="text/javascript" src="${ctxStatic}/js/html2canvas.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-ui.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-v1.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jquery-v1-ui.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jscolor.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/jscolor.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/FileSaver.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/FileSaver.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/js/canvas-toBlob.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/pdfMaker.css"/>

<%--ckfinder相关的css&js--%>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/ckfinder/_samples/sample.css"/>
<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
<%--pdf的IE预览插件--%>
<script type="text/javascript" src="${ctxStatic}/js/jquery.media.js"></script>
<%--<!--图片相关的js代码-->--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/images.js"></script>--%>
<!--生成PDF的相关js代码-->
<script type="text/javascript" src="${ctxStatic}/js/jspdf.debug.js"></script>
<%--工具栏自适应位置--%>
<script type="text/javascript" src="${ctxStatic}/js/jquery.vgrid.min.js"></script>
<script>
    $(function () {
        $("#util").vgrid({
            easing: "easeOutQuint",
            time: 500,
            delay: 20,
            fadeIn: {
                time: 300,
                delay: 50
            }
        });
    });
    $(function () {
        //alert("pageRight:"+"width:"+document.getElementById("pageRight").offsetWidth+"height:"+document.getElementById("pageRight").offsetHeight);
        document.getElementById("printf").style.width = document.getElementById("pageRight").offsetWidth - 20;
        document.getElementById("printf").style.height = document.getElementById("pageRight").offsetHeight - document.getElementById("util").offsetHeight + 100;
        $("#products").resizable({
            minHeight: 140,
            minWidth: 200,
            resize: function () {
                $("#catalog").accordion("refresh");
            }
        });
        $("#catalog").accordion({
            autoHeight: false
        });
        $(".components").draggable({
            appendTo: "body",
            helper: "clone"
        });

        $("#textarea").blur(function () {
            alert("cao ni ma ");
        });

        $("#printf").droppable({
            activeClass: "ui-state-default",
            hoverClass: "ui-state-hover",
            accept: ".components",
            drop: function (event, ui) {

                <!--第一个拖拉组件文本框的生成-->

                if (ui.helper.attr("id") == "Text") {
                    var el = $("<div class='printComponents textComponents ' onclick='checkClick(this)'  tabindex='0' onmousedown='setIndex(event,this)' ></div>");
                    //el.append("<ul><li style='list-style: none;'><textarea class='textarea' id='textarea' style='' onchange='wirteText(this)'></textarea></li></ul>");
                    el.append("<textarea class='textarea' id='textarea' style='' onchange='wirteText(this)'></textarea>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);
                    el.draggable({
                        containment: "#printf",
                        handle: "ul"
                    }).resizable({
                        stop: function (e, ui) {
                            var hereDrag = this;
                            var width = parseInt($(hereDrag).css("width"));
                            var height = parseInt($(hereDrag).css("height"));
                            $(hereDrag).find('textarea').css('width', width - (width * 0.06));
                            $(hereDrag).find('textarea').css('height', height - (height * 0.06));
                        },
                        containment: "#printf",
                        handles: 'se'
                    }).appendTo("#printf");
                    //$("ul").disableSelection();

                } else if (ui.helper.attr("id") == "radiobutton") {

                    <!--第二个拖拉组件单选按钮的生成-->

                    var RadiostyleChoice = document.getElementById("RadiostyleChoice").value;
                    var radioAcount = document.getElementById("radioAcount").value;
                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);
                    var radio = Math.random();

                    //当用户没有输入按钮数量的时候 默认生成一个按钮
                    if (radioAcount == null || radioAcount == 0) {
                        function prom() {
                            var content = prompt("请输入你按钮的内容", "");
                            return content;
                        }

                        var content = prom();
                        el.append("<input type='radio' class='input' id='" + content + "' name='" + radio + "'><label for='" + content + "'>" + content + "</label>");
                        el.resizable({
                            stop: function (e, ui) {
                                var hereDrag = this;
                                var width = parseInt($(hereDrag).css("width"));
                                var height = parseInt($(hereDrag).css("height"));
                                $(hereDrag).find('input').css('width', width / 2);
                                $(hereDrag).find('input').css('height', height / 2);
                            },
                            containment: "#printf"
                        }).draggable({
                            containment: "#printf",
                            cancel: "#input"
                        }).appendTo("#printf");

                    } else {

                        //当用户输入了所需要的单选按钮数量的时候 生成相对应的单选按钮数量
                        for (var i = 0; i < radioAcount; i++) {
                            function prom() {
                                var content = prompt("请输入你按钮的内容", "");
                                return content;
                            }

                            var content = prom();
                            el.append("<input type='radio' class='input' id='" + content + "' name='" + radio + "'><label for='" + content + "'>" + content + "</label>");
                            el.resizable({
                                stop: function (e, ui) {
                                    var hereDrag = this;
                                    var width = parseInt($(hereDrag).css("width"));
                                    var height = parseInt($(hereDrag).css("height"));
                                    if (RadiostyleChoice == 1) {
                                        $(hereDrag).find('input').css('width', width / 2);
                                        $(hereDrag).find('input').css('height', height / (radioAcount * 2));
                                    } else {
                                        $(hereDrag).find('input').css('width', width / radioAcount * 2);
                                        $(hereDrag).find('input').css('height', height / 2);
                                    }
                                },
                                containment: "#printf"
                            }).draggable({
                                containment: "#printf",
                                cancel: "#input"
                            }).appendTo("#printf");
                            if (RadiostyleChoice == 1) {
                                el.append("<br />");
                            }
                        }
                    }

                } else if (ui.helper.attr("id") == "check box") {

                    <!--第三个拖拉组件 多选按钮的生成-->

                    var CheckBoxstyleChoice = document.getElementById("CheckBoxstyleChoice").value;
                    var checkAcount = document.getElementById("checkAcount").value;
                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);

                    //当用户没有输入如何数组的时候 默认生成一个多选按钮
                    if (checkAcount == null || checkAcount == 0) {
                        function prom() {
                            var content = prompt("请输入你按钮的内容", "");
                            return content;
                        }

                        var content = prom();
                        el.append("<input type='checkbox' class='input' id='" + content + "'><label for='" + content + "'>" + content + "</label>");
                        el.resizable({
                            stop: function () {
                                var hereDrag = this;
                                var width = parseInt($(hereDrag).css("width"));
                                var height = parseInt($(hereDrag).css("height"));
                                $(hereDrag).find('input').css('width', width / 2);
                                $(hereDrag).find('input').css('height', height / 2);
                            },
                            containment: "#printf"
                        }).draggable({
                            containment: "#printf",
                            cancel: "#input"
                        }).appendTo("#printf");

                    } else {

                        //生成用户输入所需要的多选按钮数量
                        for (var i = 0; i < checkAcount; i++) {
                            function prom() {
                                var content = prompt("请输入你按钮的内容", "");
                                return content;
                            }

                            var content = prom();
                            el.append("<input type='checkbox' class='input' id='" + content + "'><label for='" + content + "'>" + content + "</label>");
                            el.resizable({
                                stop: function () {
                                    var hereDrag = this;
                                    var width = parseInt($(hereDrag).css("width"));
                                    var height = parseInt($(hereDrag).css("height"));
                                    if (CheckBoxstyleChoice == 1) {
                                        $(hereDrag).find('input').css('width', width / 2);
                                        $(hereDrag).find('input').css('height', height / (2 * checkAcount));
                                    } else {
                                        $(hereDrag).find('input').css('width', width / (checkAcount * 2));
                                        $(hereDrag).find('input').css('height', height / 2);
                                    }
                                },
                                containment: "#printf"
                            }).draggable({
                                containment: "#printf",
                                cancel: "#input"
                            }).appendTo("#printf");
                            if (CheckBoxstyleChoice == 1) {
                                el.append("<br />");
                            }
                        }
                    }

                } else if (ui.helper.attr("id") == "line") {

                    <!--第四个拖拉组件的生成 直线 有横竖供用户选择-->

                    var lineStylechoice = document.getElementById("lineStylechoice").value;
                    if (lineStylechoice == 1) {
                        var el = $("<div class='verticallineStyle' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                        var id = (new Date()).getMilliseconds();
                        el.attr("id", "new" + id);
                        el.resizable({
                            containment: "#printf",
                            maxWidth: 5
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    } else {
                        var el = $("<div class='horizontallineStyle' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                        var id = (new Date()).getMilliseconds();
                        el.attr("id", "new" + id);
                        el.resizable({
                            containment: "#printf",
                            maxHeight: 5
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    }

                } else if (ui.helper.hasClass("Elements")) {

                    <!--第五个组件 生成只能拖拉一次的关键拖拉组件 供以后可以用java代码寻找到相应的位置 输入相关内容-->

                    //alert("id" + ui.helper.attr("id"));(width*0.1)
                    if (document.getElementById("id" + ui.helper.attr("id"))) {
                        alert("此组件只能拖拉一次！");
                    } else if (ui.helper.attr("id") == "Photo") {
                        alert("画布宽度：" + document.getElementById("printf").offsetWidth + "   " + "画布长度：" + document.getElementById("printf").offsetHeight);

                        var el = $("<div class='printComponents specialElements Photo' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)' style='border:1px solid #000000;'></div>");
                        var id = "id" + ui.helper.attr("id");
                        el.attr("id", id);
                        el.attr("name", id);
                        el.text("ID:" + id);
                        el.resizable({
                            containment: "#printf",
                            handle: 'se',
                            stop: function (e, ui) {
                                var photoWidth = parseInt((99.21 * document.getElementById("printf").offsetWidth) / 841.89) + 'px';
                                var photoHeight = parseInt((150.2338 * document.getElementById("printf").offsetHeight) / 595.28) + 'px';
                                //alert("画布宽度：" + photoWidth + "   " + "画布长度：" + photoHeight);
                                var hereDrag = this;
                                $(hereDrag).css('width', photoWidth);
                                $(hereDrag).css('height', photoHeight);
                            }
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    } else {
                        var el = $("<div class='printComponents specialElements' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)' style='border:1px solid #000000;'></div>");
                        var id = "id" + ui.helper.attr("id");
                        el.attr("id", id);
                        el.attr("name", id);
                        el.text("ID:" + id);
                        el.resizable({
                            containment: "#printf"
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    }


                } else if (ui.helper.attr("id") == "Form") {

                    <!--第六个组件 表格的生成-->

                    var lineAcount = document.getElementById("FormLineAcount").value;
                    var columnAcount = document.getElementById("FormColumnAcount").value;
                    if (lineAcount == 0 || lineAcount == null) {
                        lineAcount = 1;
                    }
                    if (columnAcount == 0 || columnAcount == null) {
                        columnAcount = 1;
                    }
                    //alert(lineAcount +" "+ columnAcount);			//确认是否能取得值
                    var textareaWidth = 500 / columnAcount;
                    var el = $("<div class='printComponents textComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                    var id = "id" + ui.helper.attr("id");
                    el.attr("id", id);
                    for (var x = 0; x < lineAcount; x++) {
                        for (var y = 0; y < columnAcount; y++) {
                            el.append("<textarea class='textarea' style='resize: none;width:" + textareaWidth + "px' ></textarea>");
                        }
                        el.append("<br />");
                    }
                    el.resizable({
                        stop: function (e, ui) {
                            var hereDrag = this;
                            var width = parseInt($(hereDrag).css('width'));
                            var height = parseInt($(hereDrag).css('height'));
                            $(hereDrag).find('textarea').css('width', width / columnAcount - 5);
                            $(hereDrag).find('textarea').css('height', height / lineAcount - 5);
                        },
                        containment: "#printf"
                    }).draggable({
                        containment: "#printf"
                    }).appendTo("#printf");

                } else if (ui.helper.hasClass("othersElement")) {

                    <!--第七个组件的生成 图片的拖拉-->

                    var fileName = "/picFile/upload/1/modelPhoto/" + ui.helper.attr("id") ;
                    //alert(fileName);
                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                    el.append("<img src=" + fileName + " class='img' style='width:98%;height: auto'>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);
                    el.resizable({
                        stop: function () {
                            var hereDrag = this;
                            var width = parseInt($(hereDrag).css('width'));
                            var height = parseInt($(hereDrag).css('height'));
                            $(hereDrag).find('img').css('width', width);
                            $(hereDrag).find('img').css('height', height);
                        },
                        containment: "#printf"
                    }).draggable({
                        containment: "#printf"
                    }).appendTo("#printf");

                } else {
                    <!--第八个组件的生成 一些其他组件的生成-->

                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' onmousedown='setIndex(event,this)'></div>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);
                    el.text("ID=new" + id);
                    el.draggable({
                        containment: "#printf"
                    }).resizable({
                        containment: "#printf"
                    }).appendTo("#printf");

                }
            }
        });
    });
</script>
<script>

</script>
<body>
<div id="products">
    <h1 class="ui-widget-header">组件</h1>
    <div id="catalog">
        <h2><a href="#">基本元素</a></h2>
        <div>
            <ul>
                <div class="components" id="Text">文本框</div>
                <div class="components" id="Form">表格</div>
                <div draggable="false">
                    <small>行:</small>
                    <input class="FormAcount" id="FormLineAcount"
                           onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                           onafterpaste=
                    "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                    <br/>
                    <small>列:</small>
                    <input class="FormAcount" id="FormColumnAcount"
                           onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                           onafterpaste=
                    "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">
                </div>
                <div class="components" id="line">直线</div>
                <select id="lineStylechoice">
                    <option>横</option>
                    <option value="1">竖</option>
                </select>
            </ul>
        </div>
        <h2><a href="#">元素</a></h2>
        <div>
            <ul>
                <div class="components Elements" id="Photo">照片</div>
                <div class="components Elements" id="Name">名字</div>
                <div class="components Elements" id="EngFamilyName">姓(英)</div>
                <div class="components Elements" id="EngName">名(英)</div>
                <div class="components Elements" id="Sex">性别</div>
                <div class="components Elements" id="EngSex">性别(英)</div>
                <div class="components Elements" id="GraYear">毕业年份</div>
                <div class="components Elements" id="GraMonth">毕业月份</div>
                <div class="components Elements" id="StuYear">入学年份</div>
                <div class="components Elements" id="StuMonth">入学月份</div>
                <div class="components Elements" id="BirthYear">出生年份</div>
                <div class="components Elements" id="BirthMonth">出生月份</div>
                <div class="components Elements" id="BirthDay">出生日</div>
                <div class="components Elements" id="MakeYear">制作年份</div>
                <div class="components Elements" id="MakeMonth">制作月份</div>
                <div class="components Elements" id="MakeDay">制作日</div>
                <div class="components Elements" id="EngBirthYear">出生年份(英)</div>
                <div class="components Elements" id="EngBirthDay">出生月日(英)</div>
                <div class="components Elements" id="Major">专业名称</div>
                <div class="components Elements" id="Major1">专业名称(1)</div>
                <div class="components Elements" id="EngMajor">专业名称(英)</div>
                <div class="components Elements" id="EngMajor1">专业名称(英 1)</div>
                <div class="components Elements" id="GraNo">毕业证号</div>
                <div class="components Elements" id="DgeNo">学位证号</div>

            </ul>
        </div>
        <h2><a href="#">按钮选择</a></h2>
        <div>
            <ul>
                <div class="components" id="radiobutton"> 单选按钮</div>
                <select id="RadiostyleChoice">
                    <option>横</option>
                    <option value="1">竖</option>
                </select>
                <input id="radioAcount" style="width: 80%"
                       onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                       onafterpaste=
                "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">

                <div class="components" id="check box"> 多选按钮</div>
                <select id="CheckBoxstyleChoice">
                    <option>横</option>
                    <option value="1">竖</option>
                </select>
                <input id="checkAcount" style="width: 80%"
                       onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                       onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}">

                <div class="components" id="singleButton">单个按钮</div>
            </ul>
        </div>
        <h2><a href="#">其他组件</a></h2>                                <!-- 其他组件的插入位置 -->
        <div>
            <ul id="othersElements">
                <%
                    String realpath = "E:\\photo\\upload\\1\\modelPhoto\\";
                    System.out.println(realpath);
                    File d = new File(realpath);
                    if (d.exists()) {
                        File list[] = d.listFiles();
                        for (int i = 0; i < list.length; i++) {
                            String filename = list[i].getName();
                            int end = filename.lastIndexOf(".");
                            String realName = filename.substring(0, end);
                            //System.out.println(realName);		//成功显示当前文件夹的文件名字
                            out.println("<div class='components othersElement' id=" + filename + ">" + realName + "</div>");
                        }
                    }
                %>
            </ul>
        </div>
    </div>
</div>


<div class="pageRight" id="pageRight">
    <div id="pdf"></div>
    <div class="util" id="util">
        <!-- 设置画布大小 -->
        <div id="setDraw_size" class="_util" style="float:left;clear: both">
            <form>
                设置画布大小:
                宽:<input id="printfWidth" size="10" placeholder="width"
                         onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                         onafterpaste=
                                 "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                高:<input id="printfHeight" size="10" placeholder="height"
                         onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                         onafterpaste=
                                 "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
                <input id="submitPrintf" type="button" value="确认画布大小" onclick="setPrintfSize()"/>
            </form>
        </div>

        <%--ckfinder相关代码--%>
        <script type="text/javascript">

            function BrowseServer(startupPath, selectAD) {
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                finder.basePath = '../';	// The path for the installation of CKFinder (default = "/ckfinder/").
                finder.startupPath = startupPath;
                finder.resourceType = "modelPhoto";
                finder.selectActionFunction = SetFileField;
                finder.selectActionData = selectAD;
                finder.popup();
            }


            function viewBS(startupPath) {
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                finder.basePath = '../';	// The path for the installation of CKFinder (default = "/ckfinder/").
                //Startup path in a form: "Type:/path/to/directory/"
                finder.readOnly = true ;
                finder.resourceType = "pdf";
                finder.startupPath = startupPath;
                finder.selectActionFunction = viewSFF;
                finder.popup();
            }

            // This is a sample function which is called when a file is selected in CKFinder.
            function SetFileField(fileUrl, data) {
                document.getElementById(data["selectActionData"]).value = fileUrl;
            }

            function closeWindow() {
                document.getElementById('pdf').innerHTML = "";
            }

            // This is a sample function which is called when a file is selected in CKFinder.
            function viewSFF(fileUrl, data) {
                // document.getElementById('xFilePath').value = fileUrl;
                var url = "/picFile" + fileUrl;
                var sFileName = this.getSelectedFile().name;
                document.getElementById('pdf').innerHTML =
                    '<span class="close cursor" onclick="closeWindow()"> ' + '&times;' +
                    '</span>' +
                    '<a class="media" href="' + url + '">' +
                    '</a>' + '<div class="caption">' +
                    '<a href="' + data["fileUrl"] + '" target="_blank">' + sFileName + '</a> (' + data["fileSize"] + 'KB)' +
                    '</div>';

                $('a.media').media({width: 800, height: 600});

                //document.getElementById('preview').style.display = "";
                // It is not required to return any value.
                // When false is returned, CKFinder will not close automatically.
                return true;
            }
        </script>


        <!--背景颜色设置透明-->
        <div id="setBG_color" class="_util" style="float:left;clear: both">
            <form>
                设置背景颜色 : 设置透明
                <select id="backgroundTransparent">
                    <option value="1" selected="selected">是</option>
                    <option value="0">否</option>
                </select>
                <div style="float:right;" style="width:100px;">
                    <button id="backgroundColorSelect"
                            class="jscolor {valueElement:'chosen-value', onFineChange:''}"
                            disabled>背景颜色
                    </button>
                    <input id="chosen-value" value="000000" disabled/>
                    <!-- <input id="backgroundColorSelect" type="color" style="height:24px;line-height:20px" disabled /> -->
                </div>
                <input id="submitColorSelect" onclick="changeBackgroundColor()" type="button" value="确认背景">
            </form>
        </div>


        <!--提供上传文件-->
        <div id="setFile_upload" class="_util" style="float:left;">
            <%--<form action="smartUploaddemo.jsp" enctype="multipart/form-data" method="post" target="_blank">--%>
            <%--输入图片ID<input name="id" size="10" id="imgid" onkeyup="checkUnique()" placeholder="输入唯一的ID" required>--%>
            <%--<input name="image" type="file" id="imagefile" required>--%>
            <%--<input id="inputSubmit" type="submit" value="上传文件" onclick="createNewElements()">--%>
            <%--</form>--%>
            <div>
                <p>
                    <input id="xFilePath" name="FilePath" type="text" size="60"/>
                    <input type="button" value="Browse Server" onclick="BrowseServer('modelPhoto:/','xFilePath');"/>
                    <input type="button" value="confirm" onclick="createNewElements();"/>
                    <input type="button" value="查看历史模板" onclick="viewBS('pdf:/');"/>
                    <input type="button" id="downloadPDF" onclick="print()" value="下载PDF"/>
                </p>
            </div>

        </div>


        <div>
            <%--<!-- 上传模板到服务器 -->暂时不需要--%>
            <%--<div style="float: left;padding-left:2em">--%>
            <%--<form action="uploadTheServer.jsp" enctype="multipart/form-data" method="post" target="_blank">--%>
            <%--<input type="hidden" id="theTxt" name="thePrintfTxt">--%>
            <%--<input type="hidden" id="thePng" name="thePrintfPng">--%>
            <%--<input id="downId" name="thePrintfID" size="10" placeholder="输入唯一的ID" onmouseover="writeTxtAndPng()"--%>
            <%--required>--%>
            <%--<input id="uploadTxtAndPng" type="submit" onmouseover="writeTxtAndPng()" value="下载到服务器">--%>
            <%--</form>--%>
            <%--</div>--%>
            <%--下载模板--%>
            <%--<div style="float: left;padding-left: 0.2em">--%>
            <%--<input type="button" id="downloadPDF" onclick="print()" value="下载PDF"/>--%>
            <%--<input type="button" id="savePrintf" onclick="saveTxt()" value="保存"/>--%>
            <%--<input type="button" id="historicalModle" onclick="jump()" value="查看历史模板"/>--%>
            <%--<input type="button" value="查看历史模板" onclick="viewBS();"/>--%>
            <%--</div>--%>
        </div>


        <div id="setFont_option" class="_util" style="float:left;">
            <!--字体设置工具栏-->
            <input id="bold" type="button" value="加粗" style="height:24px;line-height:20px"/>
            <input id="italic" type="button" value="加斜" style="height:24px;line-height:20px"/>
            <input id="underline" type="button" value="下划线" style="height:24px;line-height:20px"/>
            <input id="textareaBorder" type="button" value="边框" style="height:24px;line-height:20px"/>
            <select id="fontfamily">
                <option value="" selected="selected">字体属性</option>
                <option value="宋体,simsun">宋体</option>
                <option value="楷体,楷体_gb2312,simkai">楷体</option>
                <option value="隶书,simli">隶书</option>
                <option value="黑体,simhei">黑体</option>
                <option value="andale mono,times">andale mono</option>
                <option value="arial,helvetica,sans-serif">arial</option>
                <option value="arial black,avant garde">arial black</option>
                <option value="comic sans ms,sans-serif">comic sans ms</option>
            </select>
            <select id="fontsize">
                <option value="" selected="selected">字体大小</option>
                <option value="1px">1px</option>
                <option value="2px">2px</option>
                <option value="3px">3px</option>
                <option value="4px">4px</option>
                <option value="5px">5px</option>
                <option value="6px">6px</option>
                <option value="7px">7px</option>
                <option value="8px">8px</option>
                <option value="9px">9px</option>
                <option value="10px">10px</option>
                <option value="11px">11px</option>
                <option value="12px">12px</option>
                <option value="13px">13px</option>
                <option value="14px">14px</option>
                <option value="15px">15px</option>
                <option value="16px">16px</option>
                <option value="17px">17px</option>
                <option value="18px">18px</option>
                <option value="19px">19px</option>
                <option value="20px">20px</option>
                <option value="21px">21px</option>
                <option value="22px">22px</option>
                <option value="23px">23px</option>
                <option value="24px">24px</option>
                <option value="25px">25px</option>
                <option value="26px">26px</option>
                <option value="27px">27px</option>
                <option value="28px">28px</option>
                <option value="29px">29px</option>
                <option value="30px">30px</option>
                <option value="31px">31px</option>
                <option value="32px">32px</option>
                <option value="33px">33px</option>
                <option value="34px">34px</option>
                <option value="35px">35px</option>
                <option value="36px">36px</option>
                <option value="37px">37px</option>
                <option value="38px">38px</option>
                <option value="39px">39px</option>
                <option value="40px">40px</option>
                <option value="41px">41px</option>
                <option value="42px">42px</option>
                <option value="43px">43px</option>
                <option value="44px">44px</option>
                <option value="45px">45px</option>
                <option value="46px">46px</option>
                <option value="47px">47px</option>
                <option value="48px">48px</option>
            </select>
            <div id="setFont_color" style="float:left;width:auto;">
                <button class="jscolor {valueElement:'chosen1-value'}">字体颜色</button>
                <input id="chosen1-value" value="000000"/>
                <!-- <input id="colorselect" type="color" style="height:24px;line-height:30px" /> -->
            </div>
            <%--<input type="button" id="downloadPDF" onclick="print()" value="下载PDF"/>--%>
            <%--<button onclick="checkTest()">test</button>--%>
        </div>


    </div>
    <div id="printf"></div>
</div>


<script>
    var realPrintfContent;
    var i;	//加粗的变量
    var j;	//加斜的变量
    var k; //下划线的变量
    var l; //边框属性的变量
    var backGroundUnique = 0; //控制背景唯一性
    var index = 2;	//控制每个元素的Z-Index
    var inputSubmit = document.getElementById("inputSubmit");


    window.onload = function () {					//禁止鼠标右键事件
        document.oncontextmenu = function (e) {
            e.preventDefault();
        }
        <% String realPrintfContent=request.getParameter("printfContent") ; %>
        realPrintfContent = <%=realPrintfContent%>;
        if (!(realPrintfContent == 0 || realPrintfContent == "" || realPrintfContent == null || realPrintfContent == undefined)) {
            alert(realPrintfContent);
        }
    };

    function jump() {				//跳转到第二个页面查看历史模板
        window.open("CheckModel.jsp");
    }


    function wirteText(e) {			//为每一个文本框输入后自动生成相对应的Html
        alert(e.value);
        e.innerHTML = e.value;

    }

    function writeTxtAndPng() {
        var writeText = document.getElementById("printf").innerHTML;
        document.getElementById("theTxt").value = writeText;
        html2canvas($("#printf"), {
            onrendered: function (canvas) {
                var src = canvas.toDataURL("image/png");
                document.getElementById("thePng").value = src;
            }
        });
    }

    //把画布内容保存到txt和图片
    function saveTxt() {
        var blob = new Blob([document.getElementById("printf").innerHTML], {type: "text/plain;charset=utf-8"});
        saveAs(blob, "printf.txt");
        html2canvas($("#printf"), {
            onrendered: function (canvas) {
                canvas.toBlob(function (blob) {
                    saveAs(blob, "printf.png");
                });
            }
        });
    }

    function setPrintfSize() {
        var printf = document.getElementById("printf");
        if (!($(printf).children().length == 0)) {
            alert("有东西啊！！！！！！" + $(printf).children().length);
        } else {
            var printfWidth = document.getElementById("printfWidth").value;
            var printfHeight = document.getElementById("printfHeight").value;
            //alert(printfWidth.value);
            if (printfWidth == 0 || printfWidth == "" || printfWidth == null || printfWidth == undefined || printfHeight == 0 || printfHeight == "" || printfHeight == null || printfHeight == undefined) {
                alert("老铁 这两个值不能为空啊！我很难做啊！");
            } else {
                printf.style.width = printfWidth;
                printf.style.height = printfHeight;
            }
        }
    }

    function checkUnique() {
        var inputContent = document.getElementById("imgid").value;
        if (document.getElementById(inputContent)) {
            inputSubmit.setAttribute("disabled", true);
        } else {
            $(inputSubmit).removeAttr("disabled");
        }
    }

    var backgroundColorSelect = document.getElementById("backgroundColorSelect");
    var backgroundTransparent = document.getElementById("backgroundTransparent");
    backgroundTransparent.onclick = function () {
        var setColorSelect = backgroundTransparent.value;
        if (setColorSelect == "0") {
            $(backgroundColorSelect).removeAttr("disabled");
        } else {
            backgroundColorSelect.setAttribute("disabled", true);
        }
    }

    function changeBackgroundColor() {
        var printf = document.getElementById("printf");
        var backgroundColorSelect = document.getElementById("chosen-value");
        var setColorSelect = backgroundTransparent.value;
        alert(backgroundColorSelect.value);
        if (setColorSelect == "0") {
            //提取颜色的选择 设置背景为该颜色
            var getbackgroundColor = backgroundColorSelect.value;
            printf.style.backgroundColor = getbackgroundColor;
        } else {
            //背景被设置为透明
            printf.style.backgroundColor = "transparent";
        }
    }

    function checkTest() {		//检测画布里的代码
        alert(document.getElementById("printf").innerHTML);
    }


    function setIndex(event, e) {					//使选中的元素永远在图层的最上面
        var btnNum = event.button;
        //alert(e.button);
        if (e.style.zIndex != 1) {				//不是背景的元素
            index = index + 1;
            e.style.zIndex = index;
        }
        if (btnNum == 1) {
            //alert("点击鼠标中键");
            if (e.style.zIndex == 1) {
                if (confirm("是否解除当前组件背景？")) {
                    index = index + 1;
                    e.style.zIndex = index;
                }
            } else {								//设置选中元素的zIndex

            }
        } else if (btnNum == 0) {
            //alert("点击鼠标左键");
        } else if (btnNum == 2) {
            //alert("点击鼠标右键");
            if (backGroundUnique == 0) {			//还没有设置背景
                if (confirm("确认此图作为背景？")) {
                    e.style.zIndex = 1;
                    backGroundUnique = 1; //背景已经设置了
                }
            } else {
                alert("你已设置过背景！背景只能有一个！");
            }
        }

        //让保存的元素重新到画布上后能重新拖拽伸缩编辑功能
        if ($(e).hasClass("printComponents")) {
            $(e).resizable({
                containment: "#printf"
            }).draggable({
                containment: "#printf"
            });
        }
    }

    function checkClick(e) {
        //alert(e.getAttribute("id"));
        var thisID = document.getElementById(e.getAttribute("id"));
        document.onkeydown = function () {
            var oEvent = window.event;
            if (oEvent.keyCode == 46) {
                $(e).remove();
            }
        }

        var bold = document.getElementById("bold");
        bold.onclick = function () {
            if (i == 0 || i == "" || i == null || i == undefined) {
                //alert(e.getAttribute("id")+"    yeah get it!");			//是否成功获取属性值
                $(thisID).find('textarea').css('font-weight', "bold");
                $(thisID).find('label').css('font-weight', "bold");
                i = 1;
            } else {
                $(thisID).find('textarea').css('font-weight', "normal");
                $(thisID).find('label').css('font-weight', "normal");
                i = 0;
            }
        }

        var italic = document.getElementById("italic");
        italic.onclick = function () {
            if (j == 0 || j == "" || j == undefined) {
                $(thisID).find('textarea').css('font-style', "italic");
                $(thisID).find('label').css('font-style', "italic");
                j = 1;
            } else {
                $(thisID).find('textarea').css('font-style', "normal");
                $(thisID).find('label').css('font-style', "normal");
                j = 0;
            }
        }

        var underline = document.getElementById("underline");
        underline.onclick = function () {
            if (k == 0 || k == "" || k == undefined) {
                $(thisID).find('textarea').css('text-decoration', "underline");
                $(thisID).find('label').css('text-decoration', "underline");
                k = 1;
            } else {
                $(thisID).find('textarea').css('text-decoration', "none");
                $(thisID).find('label').css('text-decoration', "none");
                k = 0;
            }
        }

        var textareaBorder = document.getElementById("textareaBorder");
        textareaBorder.onclick = function () {
            if ($(thisID).hasClass("textComponents")) {
                if (l == 0 || l == "" || l == undefined) {
                    $(thisID).find('textarea').css('border', "1px solid #000");
                    l = 1;
                } else {
                    $(thisID).find('textarea').css('border', "none");
                    l = 0;
                }
            }
        }

        var colorselect = document.getElementById('chosen1-value');
        var size = document.getElementById("fontsize");
        var family = document.getElementById("fontfamily");
        var setFontsize = document.getElementById("fontsize");
        var setFontfamily = document.getElementById("fontfamily");

        //获取当前元素的颜色 字体 大小属性并显示在分别显示在三个选择框 如果为空显示默认的
        if ($(thisID).hasClass("textComponents")) {

            //字体属性获取
            if ($(thisID).find('textarea').css('font-family') == 'Courier New') {			//当前字体为默认字体
                //alert("font-family");
                setFontfamily.options[0].selected = true;
            } else {																		//用户已经设置新的字体
                setFontfamily.value = $(thisID).find('textarea').css('font-family');
            }

            //大小属性获取
            if (parseFloat($(thisID).find('textarea').css('font-size')) == '13.33') {			//当前大小为默认大小
                //alert("font-size");
                setFontsize.options[0].selected = true;
            } else {																			//用户已经设置新的大小
                setFontsize.value = $(thisID).find('textarea').css('font-size');
            }

            //颜色属性获取
            var hexColor = RGBToHex($(thisID).find('textarea').css('color'));
            if (hexColor == '000000') {														//当前字体颜色为默认颜色
                //alert("color");
                colorselect.value = '000000';
            } else {																			//用户已经设置字体的默认颜色
                hexColor = parseZero(hexColor);
                colorselect.value = hexColor;
            }

        }
        colorselect.onchange = function () {
            var fontcolor = colorselect.value;
            $(thisID).find('textarea').css('color', fontcolor);
            $(thisID).find('label').css('color', fontcolor);
        }
        size.onchange = function () {
            var fontsize = size.value;
            $(thisID).find('textarea').css('font-size', fontsize);
            $(thisID).find('label').css('font-size', fontsize);
        }

        family.onchange = function () {
            var fontfamily = family.value;
            $(thisID).find('textarea').css('font-family', fontfamily);
            $(thisID).find('label').css('font-family', fontfamily);
        }

        //alert(e.getAttribute("id")+""+fontsize+""+fontfamily);		//是否成功获取属性值

        if ($(thisID).hasClass("horizontallineStyle") || $(thisID).hasClass("verticallineStyle")) {//border-bottom: 2px solid #000000;
            var fontcolor = colorselect.value;
            var display = '2px solid ' + fontcolor;
            if (fontsize != "" && fontsize != undefined && fontsize != 0) {
                var display = fontsize + ' solid ' + fontcolor;
                //alert(display);
                //$(e).css('border-bottom',display);
                //alert($(e).css('border-bottom'));
            }
            if ($(thisID).hasClass("horizontallineStyle")) {
                $(thisID).css('border-bottom', display);
            } else if ($(thisID).hasClass("verticallineStyle")) {
                $(thisID).css('border-right', display);
            }
        }

    }

    //rgb转换16进制
    function RGBToHex(rgb) {
        var regexp = /[0-9]{0,3}/g;
        var re = rgb.match(regexp);//利用正则表达式去掉多余的部分，将rgb中的数字提取
        var hexColor = "";
        var hex = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'];
        for (var i = 0; i < re.length; i++) {
            var r = null;
            var c = re[i];
            var hexAr = [];
            while (c > 16) {
                r = c % 16;
                c = (c / 16) >> 0;
                hexAr.push(hex[r]);
            }
            hexAr.push(hex[c]);
            if (c < 16 && c != "") {
                hexAr.push(0)
            }
            hexColor += hexAr.reverse().join('');
        }
        //alert(hexColor)
        return hexColor;
    }

    //把16进制的数字去掉1 4 7位的0
    function parseZero(hexColor) {
        var first = hexColor.substring(1, 3);
        var second = hexColor.substring(4, 6);
        var third = hexColor.substring(7, 9);
        return first + second + third;
    }

    function createTextField(pdf, TF_Id, TF_Name, posX, posY, posW, posH, TF_T) {

        //alert(TF_Id + "       " + TF_Name + "       " + posX + "       " + posY + "       " + posW + "       " + posH);
        var textField = new TextField();
        textField.Rect = [posX, posY, posW, posH];
        textField.multiline = false;
        //textField.F = '30px serif' ;
        textField.V = TF_T;
        textField.T = TF_Name;
        pdf.addField(textField);
    }

    //使当前页面变成图片 然后转换为pdf
    function print() {
        var printfWidth = document.getElementById("printfWidth").value;
        var printfHeight = document.getElementById("printfHeight").value;
        if (printfWidth == 0 || printfWidth == "" || printfWidth == undefined) {
            printfWidth = 1500;
        }
        if (printfHeight == 0 || printfHeight == "" || printfHeight == undefined) {
            printfHeight = 920;
        }
        var pdf = new jsPDF('l', 'pt', 'a4');
        $.each($('.specialElements'), function () {
            var TF_T = $(this).text();
            var TF_Id = $(this).attr("id");
            var TF_Name = $(this).attr("name");
            var posX = parseInt($(this).css("left"));
            var posY = parseInt($(this).css("top"));
            var posW;
            var posH;
            var width = parseInt($(this).css("width"));
            var height = parseInt($(this).css("height"));
            if (width == 0 || width == "" || width == undefined) {
                width = 80;
            }
            posW = width;
            if (height == 0 || height == "" || height == undefined) {
                height = 30;
            }
            posH = height;
            var pw = document.getElementById("printf");
            var printfWidth = parseInt($(pw).css("width"));
            var printfHeight = parseInt($(pw).css("height"));
            //alert(printfWidth);
            posX = ( 841.89 * posX ) / printfWidth;
            posY = ( 595.28 * posY ) / printfHeight;
            posW = ( 841.89 * posW ) / printfWidth;
            posH = ( 595.28 * posH ) / printfHeight;
            createTextField(pdf, TF_Id, TF_Name, posX, posY, posW, posH, TF_T);
            $(this).remove();
        });

        //alert("宽"+document.getElementById("printf").offsetWidth);

        html2canvas($("#printf"), {
            onrendered: function (canvas) {
                pdf.addImage(canvas.toDataURL("image/png", 1.0), 'PNG', 0, 0, 841.89, 595.28);
                pdf.save('content.pdf');

            }
        });
    }


    function createNewElements() {
        var inputContent = document.getElementById("xFilePath").value;
        document.getElementById("xFilePath").value = "" ;
        var splitPoint = inputContent.lastIndexOf(".");
        var split = inputContent.lastIndexOf("/");
        var id_el = inputContent.substring(split + 1, splitPoint);
        var new_id = inputContent.substring(split + 1, inputContent.length);
        if (document.getElementById(id_el)) {
            $("#imgid").val("");
            $("#imagefile").val("");
        } else {
            var openUl = document.getElementById("othersElements");
            var openDiv = document.createElement("div");
            openDiv.setAttribute('class', 'components othersElement');
            openDiv.id = new_id;
            openDiv.innerHTML = id_el;
            $(openDiv).draggable({
                appendTo: "body",
                helper: "clone"
            });
            openUl.appendChild(openDiv);
        }
    }

</script>

</body>
</html>