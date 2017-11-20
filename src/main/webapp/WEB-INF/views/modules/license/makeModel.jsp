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
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-3.2.1.js"></script>--%>
<script type="text/javascript" src="${ctxStatic}/js/jquery-1.7.2.js"></script>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-1.8.3.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-1.8.3.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery.min.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-1.12.4.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-ui.js"></script>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-v1.min.js"></script>--%>
<script type="text/javascript" src="${ctxStatic}/js/jquery-v1-ui.js"></script>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery-ui.min.js"></script>--%>
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
<%--&lt;%&ndash;右键菜单插件&ndash;%&gt;--%>
<%--<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/jquery.contextmenu.css"/>--%>
<%--<script type="text/javascript" src="${ctxStatic}/js/jquery.contextmenu.js"></script>--%>
<%--右键菜单插件--%>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/context.standalone.css"/>
<script type="text/javascript" src="${ctxStatic}/js/context.js"></script>
<%--按钮UI插件--%>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/bttn.min.css"/>
<%--开关按钮插件--%>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/css/honeySwitch.css">
<script type="text/javascript" src="${ctxStatic}/js/honeySwitch.js"></script>
<script>
    //自动填充工具栏（util）的div的排版位置
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
        context.init({
            fadeSpeed: 100,
            filter: function ($obj){},
            above: 'auto',
            preventDoubleContext: true,
            compress: false
        });

        /*检查浏览器的型号，确定按钮样式（暂时）*/
        myBrowser();

        //context.settings({compress: true});

        /*加载画布的右键插件(hezijian6338)*/
//        context.attach('#printf', [
//            {header: 'printf Menu'},
//            {text: '清空画布', action: function(e){
//                if (confirm("是否清空画布？")) {
//                    document.getElementById("printf").innerHTML = "";
//                }
//            }},
//            {text: 'Reload', href: '#'},
//            {divider: true},
//            {text: 'Disable This Menu', action: function(e){
//                e.preventDefault();
//                context.destroy('html');
//                alert('html contextual menu destroyed!');
//            }},
//        ]);

    });

    /*加载可拖拽的组件(Mickey)*/
    $(function () {
        /*打开页面的时候使画布自动填充满屏幕可用区域（hezijian6338）*/

        //调试代码
        //alert("pageRight:"+"width:"+document.getElementById("pageRight").offsetWidth+"height:"+document.getElementById("pageRight").offsetHeight);

        //留出右边的边沿区域
        document.getElementById("printf").style.width = document.getElementById("pageRight").offsetWidth - 20;

        //减去工具区域的位置
        document.getElementById("printf").style.height = document.getElementById("pageRight").offsetHeight - document.getElementById("util").offsetHeight + 100;

        /*左边组件栏设置为可缩放（Mickey）*/
//        $("#products").resizable({
//            minHeight: 140,
//            minWidth: 200,
//            resize: function () {
//                $("#catalog").accordion("refresh");
//            }
//        });
        $("#catalog").accordion({
            autoHeight: false
        });
        $(".components").draggable({
            appendTo: "body",
            helper: "clone"
        });

        $("#textarea").blur(function () {
            //alert("cao ni ma ");
        });

        /*画布使用jauery拖拽插件（Miceky）*/
        $("#printf").droppable({
            activeClass: "ui-state-default",
            hoverClass: "ui-state-hover",
            accept: ".components",
            drop: function (event, ui) {

                <!--第一个拖拉组件文本框的生成(Mickey)-->

                if (ui.helper.attr("id") == "Text") {
                    //alert("top(offset):" + ui.offset.top + "left(offset):" + ui.offset.left + "；top(position):" + ui.position.top + "left(position):" + ui.position.left);
                    var el = $("<div class='printComponents textComponents' onclick='setIndex(event,this)'  tabindex='0' ></div>");
                    //el.append("<ul><li style='list-style: none;'><textarea class='textarea' id='textarea' style='' onchange='wirteText(this)'></textarea></li></ul>");
                    el.append("<textarea class='textarea' id='textarea' style='' onchange='wirteText(this)'></textarea>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);
                    //el.css("position","absolute");
                    //el.css("left",ui.offset.top -  document.getElementById("util").offsetHeight);
                    //el.css("top",ui.offset.left + "px");
                    el.draggable({
                        containment: "#printf"
//                        , handle: "se,nw"
                    })
                        .resizable({
                        stop: function (e, ui) {
                            var hereDrag = this;
                            var width = parseInt($(hereDrag).css("width"));
                            var height = parseInt($(hereDrag).css("height"));
                            /*宽度会自动填充*/
                            //$(hereDrag).find('textarea').css('width', width - (width * 0.06));

                            /*动态可拖拽的高度*/
                            //$(hereDrag).find('textarea').css('height', height - 10 );
                            $(hereDrag).find('textarea').css('height', height - (height * 0.06));
                        },
                        containment: "#printf"
                            , handles: 'se,nw,ne,sw'
//                            ,ghost:true
                    })
                        .appendTo("#printf");


                } else if (ui.helper.attr("id") == "radiobutton") {

                    <!--第二个拖拉组件单选按钮的生成(Mickey)-->

                    var RadiostyleChoice = document.getElementById("RadiostyleChoice").value;
                    var radioAcount = document.getElementById("radioAcount").value;
                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0'></div>");
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
                            , handles: 'se,nw,ne,sw'
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
                                , handles: 'se,nw,ne,sw'
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

                    <!--第三个拖拉组件 多选按钮的生成(Mickey)-->

                    var CheckBoxstyleChoice = document.getElementById("CheckBoxstyleChoice").value;
                    var checkAcount = document.getElementById("checkAcount").value;
                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0'></div>");
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
                            , handles: 'se,nw,ne,sw'
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
                                , handles: 'se,nw,ne,sw'
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

                    <!--第四个拖拉组件的生成 直线 有横竖供用户选择(Mickey)-->

                    var lineStylechoice = document.getElementById("lineStylechoice").value;
                    if (lineStylechoice == 1) {
                        var el = $("<div class='verticallineStyle' onclick='checkClick(this)' tabindex='0'></div>");
                        var id = (new Date()).getMilliseconds();
                        el.attr("id", "new" + id);
                        el.resizable({
                            containment: "#printf",
                            maxWidth: 5
                            , handles: 'se,nw,ne,sw'
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    } else {
                        var el = $("<div class='horizontallineStyle' onclick='checkClick(this)' tabindex='0'></div>");
                        var id = (new Date()).getMilliseconds();
                        el.attr("id", "new" + id);
                        el.resizable({
                            containment: "#printf",
                            maxHeight: 5
                            , handles: 'se,nw,ne,sw'
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    }

                } else if (ui.helper.hasClass("Elements")) {

                    <!--第五个组件 生成只能拖拉一次的关键拖拉组件 供以后可以用java代码寻找到相应的位置 输入相关内容(hezijain6338)-->

                    /*增加了控制头像框尺寸的代码*/

                    //alert("id" + ui.helper.attr("id"));(width*0.1)
                    if (document.getElementById("id" + ui.helper.attr("id"))) {
                        alert("此组件只能拖拉一次！");
                    } else if (ui.helper.attr("id") == "Photo") {
                        //alert("画布宽度：" + document.getElementById("printf").offsetWidth + "   " + "画布长度：" + document.getElementById("printf").offsetHeight);
                        document.getElementById(ui.helper.attr("id")).style.backgroundColor = "#B8E834";
                        var el = $("<div class='printComponents specialElements Photo' onclick='checkClick(this)' tabindex='0' style='border:1px solid #000000;'></div>");
                        var id = "id" + ui.helper.attr("id");
                        el.attr("id", id);
                        el.attr("name", id);
                        el.text("ID:" + id);
                        el.resizable({
                            containment: "#printf"
                            , handles: 'se,nw,ne,sw'
                            ,stop: function (e, ui) {
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
                        document.getElementById(ui.helper.attr("id")).style.backgroundColor = "#B8E834";
                        var el = $("<div class='printComponents specialElements' onclick='checkClick(this)' tabindex='0' style='border:1px solid #000000;'></div>");
                        var id = "id" + ui.helper.attr("id");
                        el.attr("id", id);
                        el.attr("name", id);
                        el.text("ID:" + id);
                        el.resizable({
                            containment: "#printf"
                            , handles: 'se,nw,ne,sw'
                        }).draggable({
                            containment: "#printf"
                        }).appendTo("#printf");
                    }


                } else if (ui.helper.attr("id") == "Form") {

                    <!--第六个组件 表格的生成（Mickey）-->

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
                    var el = $("<div class='printComponents textComponents' onclick='checkClick(this)' tabindex='0'></div>");
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
                        , handles: 'se,nw,ne,sw'
                    }).draggable({
                        containment: "#printf"
                    }).appendTo("#printf");

                } else if (ui.helper.hasClass("othersElement")) {

                    <!--第七个组件的生成 图片的拖拉(Mickey)-->

                    var fileName = "/picFile/upload/1/modelPhoto/" + ui.helper.attr("id");
                    //alert(fileName);
                    var el = $("<div class='printComponents picComponents'  onmousedown='setIndex(event,this)' tabindex='0'></div>");

                    el.append("<img src=" + fileName + " class='img' style='width:98%;height: auto'  />");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id + "-" + ui.helper.attr("id"));
                    el.resizable({
                        stop: function () {
                            var hereDrag = this;
                            var width = parseInt($(hereDrag).css('width'));
                            var height = parseInt($(hereDrag).css('height'));
                            $(hereDrag).find('img').css('width', width);
                            $(hereDrag).find('img').css('height', height);
                        },
                        containment: "#printf"
                        , handles: 'se,nw,ne,sw'
                    }).draggable({
                        containment: "#printf"
                    }).appendTo("#printf");

                } else {
                    <!--第八个组件的生成 一些其他组件的生成(Mickey)-->

                    var el = $("<div class='printComponents' onclick='checkClick(this)' tabindex='0' ></div>");
                    var id = (new Date()).getMilliseconds();
                    el.attr("id", "new" + id);
                    el.text("ID=new" + id);
                    el.draggable({
                        containment: "#printf"
                    }).resizable({
                        containment: "#printf"
                        , handles: 'se,nw,ne,sw'
                    }).appendTo("#printf");

                }
            }
        });
    });
</script>
<body>
<%--左侧栏目组件的div(Mickey)--%>
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
        <%--变换PDF文本域的主要可拖拽元素（Mickey）--%>
        <h2><a href="#">元素</a></h2>
        <div>
            <ul id="componentsElements">
                <div class="components Elements" id="Photo">照片</div>
                <div class="components Elements" id="Name">名字</div>
                <div class="components Elements" id="EngFamilyName">姓(英)</div>
                <div class="components Elements" id="EngName">名(英)</div>
                <div class="components Elements" id="Sex">性别</div>
                <div class="components Elements" id="EngSex">性别(英)</div>

                <%--<div class="components Elements" id="certificateTypeId">证照类型</div>--%>
                <%--<div class="components Elements" id="certificateCode">证照编号</div>--%>
                <%--<div class="components Elements" id="certificateName">公司名称</div>--%>
                <%--<div class="components Elements" id="office">颁发机构id</div>--%>
                <%--<div class="components Elements" id="tyshxydm">统一社会信用代码</div>--%>
                <%--<div class="components Elements" id="establishDate">成立日期</div>--%>
                <%--<div class="components Elements" id="establishDateYear">成立日期(年)</div>--%>
                <%--<div class="components Elements" id="establishDateMonth">成立日期(月)</div>--%>
                <%--<div class="components Elements" id="establishDateDay">成立日期(日)</div>--%>
                <%--<div class="components Elements" id="effectiveDateStar">证照有效期（起始）</div>--%>
                <%--<div class="components Elements" id="effectiveDateEnd">证照有效期（截至）</div>--%>
                <%--<div class="components Elements" id="registeredType">注册公司类型</div>--%>
                <%--<div class="components Elements" id="registeredCapital">注册资本</div>--%>
                <%--<div class="components Elements" id="address">地址</div>--%>
                <%--<div class="components Elements" id="persionName">法人姓名</div>--%>
                <%--<div class="components Elements" id="persionIdType">法人身份证件类型</div>--%>
                <%--<div class="components Elements" id="personId">法人身份证件号码</div>--%>
                <%--<div class="components Elements" id="persionPhone">法人联系方式</div>--%>
                <%--<div class="components Elements" id="handlerName">经办人姓名</div>--%>
                <%--<div class="components Elements" id="handlerIdType">经办人身份证件类型</div>--%>
                <%--<div class="components Elements" id="handlerId">经办人身份证件号码</div>--%>
                <%--<div class="components Elements" id="handlerPhone">经办人联系方式</div>--%>

                <%--<div class="components Elements" id="scope">经营/业务/许可范围</div>--%>
                <%--<div class="components Elements" id="buildingName">建筑名称</div>--%>
                <%--<div class="components Elements" id="floorNumber">层数</div>--%>
                <%--<div class="components Elements" id="useArea">使用面积</div>--%>
                <%--<div class="components Elements" id="usage1">使用情况</div>--%>
                <%--<div class="components Elements" id="dealfireFacilities">现有消防设施</div>--%>
                <%--<div class="components Elements" id="postcode">邮政编码</div>--%>
                <%--<div class="components Elements" id="area">所属区域</div>--%>
                <c:forEach items="${page.list}" var="businessElement">
                    <div class="components Elements" id="${businessElement.elementeng}">${businessElement.elementchinese}</div>
                </c:forEach>

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
                    /*读取模板文件目录要具体设置（hezijian6338&Mickey）*/

                    //Windows的文件目录
                    //String realpath = "E:\\photo\\upload\\1\\modelPhoto\\";

                    //Mac的文件目录
                    String realpath = "/Users/Macx/github/RC_Work/GECS/manager/upload/1/modelPhoto/";

                    //System.out.println(realpath);
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

<%--页面右侧div(Mickey)--%>
<div class="pageRight" id="pageRight">
    <%--页面中ckfinder预览div(hezijian6338)--%>
    <div id="pdf" class="pdf"></div>
    <%--页面工具栏（hezijian6338）--%>
    <div class="util" id="util">

        <!-- 设置画布大小(Mickey)-->
        <div id="setDraw_size" class="_util" style="float:left;clear: both">
            <%--<form>--%>
            画布大小:
            宽:<input id="printfWidth" size="10" placeholder="width"
                     onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                     onafterpaste=
                             "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
            高:<input id="printfHeight" size="10" placeholder="height"
                     onkeyup="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"
                     onafterpaste=
                             "if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
            <%--<input id="submitPrintf"   type="button" value="确认画布大小" onclick="setPrintfSize()"/>--%>
            <%--</form>--%>

            <%--加载的样式按钮--%>
            <button id="submitPrintf" class="bttn-unite bttn-xs bttn-primary" onclick="setPrintfSize()">确认</button>
        </div>

        <%--ckfinder相关代码--%>
        <script type="text/javascript">

            function BrowseServer(startupPath, selectAD) {
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                finder.basePath = '../';	// The path for the installation of CKFinder (default = "/ckfinder/").
                finder.startupPath = startupPath;

                finder.resourceType = "元素图片文件夹";
                finder.selectActionFunction = SetFileField;
                finder.selectActionData = selectAD;
                finder.popup();
            }

            function BrowseServer_txt(startupPath, selectAD) {
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                finder.basePath = '../';	// The path for the installation of CKFinder (default = "/ckfinder/").
                finder.startupPath = startupPath;
                finder.resourceType = "modelTxt";
                finder.selectActionFunction = SetFileField;
                finder.selectActionData = selectAD;
                finder.popup();
            }


            function viewBS(startupPath) {
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                finder.basePath = '../';	// The path for the installation of CKFinder (default = "/ckfinder/").

                //Startup path in a form: "Type:/path/to/directory/"
                finder.readOnly = true;
                finder.resourceType = "证照模板文件夹";
                finder.startupPath = startupPath;
                finder.selectActionFunction = viewSFF;
                finder.popup();
            }

            function viewTxt(startupPath) {
                // You can use the "CKFinder" class to render CKFinder in a page:
                var finder = new CKFinder();
                finder.basePath = '../';	// The path for the installation of CKFinder (default = "/ckfinder/").

                //Startup path in a form: "Type:/path/to/directory/"
                finder.resourceType = "二次编辑文件夹";
                finder.startupPath = startupPath;
                finder.selectActionFunction = SetTxtField;
                finder.popup();
            }

            // This is a sample function which is called when a file is selected in CKFinder.
            function SetFileField(fileUrl, data) {
                document.getElementById(data["selectActionData"]).value = fileUrl;
                createNewElements();
            }

            // This is a sample function which is called when a file is selected in CKFinder.
            function SetTxtField(fileUrl, data) {
                var furl = "/picFile" + fileUrl;
                $.ajax({
                    url: furl,
                    dataType: 'text',
                    success: function(data) {
                        document.getElementById("printf").innerHTML = data ;
                    }
                });
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


        <!--背景颜色设置透明（Mickey&hezijian6338）-->
        <div id="setBG_color" class="_util" style="float:left;clear: both;width: 45%;">
            <%--<form>--%>
            背景颜色：是否透明
            <%--<select id="backgroundTransparent" style="margin-right: 0.2em">--%>
            <%--<option value="1" selected="selected">是</option>--%>
            <%--<option value="0">否</option>--%>
            <%--</select>--%>
            <span class="switch-off" id="backgroundTransparent" themeColor="#1d89ff" offText="" onText=""
                  style="zoom: 0.8"> 否</span>
            <div id="bgcolorPicker" style="float:right;display: none;width: auto">
                <button id="backgroundColorSelect"
                        class="jscolor {valueElement:'chosen-value', onFineChange:''}"
                        disabled>背景颜色
                </button>
                <input id="chosen-value" value="000000" disabled hidden=""/>
                <button id="submitColorSelect" class="bttn-unite bttn-xs bttn-primary"
                        onclick="changeBackgroundColor()">
                    确认背景
                </button>
                <!-- <input id="backgroundColorSelect" type="color" style="height:24px;line-height:20px" disabled /> -->
            </div>

            <%--<input id="submitColorSelect"  class="bttn-unite bttn-xs bttn-primary" onclick="changeBackgroundColor()" type="button" value="确认背景">--%>
            <%--</form>--%>
        </div>


        <%--<div id="editPdf_txt" class="_util">--%>
        <%--<div>--%>
        <%--<p>--%>
        <%--<form action="${ctx}/certificate/certificateTemplate/makeModel" method="post" id="txtAction">--%>
        <%--<input id="txtPath" name="FilePath" type="text" size="60"/>--%>
        <%--<input type="button" value="Browse Server" onclick="BrowseServer_txt('modelTxt:/','txtPath');"/>--%>
        <%--<input type="button" value="confirm" onclick="editPdf_txt();"/>--%>
        <%--<input type="submit" value="submit"/>--%>
        <%--</form>--%>
        <%--</p>--%>
        <%--</div>--%>
        <%--</div>--%>

        <%--PDF生成格式设置(hezijian6338)--%>
        <div id="setPdf_makeup" class="_util">
            PDF布局形式:
            <select id="LorP">
                <option value=" " selected="selected">选择形式</option>
                <option value="l">横版</option>
                <option value="p">竖版</option>
            </select>
            PDF大小:
            <select id="pdfSize">
                <option value=" " selected="selected">选择大小</option>
                <option value="a10">A10</option>
                <option value="a9">A9</option>
                <option value="a8">A8</option>
                <option value="a7">A7</option>
                <option value="a6">A6</option>
                <option value="a5">A5</option>
                <option value="a4">A4</option>
                <option value="a3">A3</option>
                <option value="a2">A2</option>
                <option value="a1">A1</option>
                <option value="a0">A0</option>
                <option value="b10">B10</option>
                <option value="b9">B9</option>
                <option value="b8">B8</option>
                <option value="b7">B7</option>
                <option value="b6">B6</option>
                <option value="b5">B5</option>
                <option value="b4">B4</option>
                <option value="b3">B3</option>
                <option value="b2">B2</option>
                <option value="b1">B1</option>
                <option value="b0">B0</option>
            </select>
            <button id="downloadPDF" class="bttn-unite bttn-xs bttn-primary" onclick="print()">下载PDF</button>
            <button id="saveTxt" class="bttn-unite bttn-xs bttn-primary" onclick="saveTxt()">下载图片</button>
            <input id="xFilePath" name="FilePath" type="text" size="60" style="display: none"/>
            <%--ui风格按钮--%>
            <button class="bttn-unite bttn-xs bttn-primary" onclick="BrowseServer('元素图片文件夹:/','xFilePath');">浏览文件夹
            </button>
            <button class="bttn-unite bttn-xs bttn-primary" onclick="viewBS('证照模板文件夹:/');">查看历史模板</button>
            <button class="bttn-unite bttn-xs bttn-primary" onclick="viewTxt('二次编辑文件夹:/');">二次编辑文件夹</button>
            <%--<input type="button" id="downloadPDF" onclick="print()" value="下载PDF"/>--%>
            <%--<input type="button" id="saveTxt" onclick="saveTxt()" value="下载图片"/>--%>
        </div>

        <!--提供上传文件(hezijian6338)暂时取消使用-->
        <div id="setFile_upload" class="_util">
            <%--<form action="smartUploaddemo.jsp" enctype="multipart/form-data" method="post" target="_blank">--%>
            <%--输入图片ID<input name="id" size="10" id="imgid" onkeyup="checkUnique()" placeholder="输入唯一的ID" required>--%>
            <%--<input name="image" type="file" id="imagefile" required>--%>
            <%--<input id="inputSubmit" type="submit" value="上传文件" onclick="createNewElements()">--%>
            <%--</form>--%>
            <%--<div>--%>
            <%--<p>--%>
            <%--<input id="xFilePath" name="FilePath" type="text" size="60" hidden=""/>--%>
            <%--ui风格按钮--%>
            <%--<button  class="bttn-unite bttn-xs bttn-primary" onclick="BrowseServer('元素图片文件夹:/','xFilePath');">浏览文件夹</button>--%>
            <%--<button  class="bttn-unite bttn-xs bttn-primary" onclick="viewBS('证照模板文件夹:/');">查看历史模板</button>--%>
            <%--非ui风格按钮--%>
            <%--<input type="button" value="浏览文件夹" onclick="BrowseServer('元素图片文件夹:/','xFilePath');"/>--%>
            <%--<input type="button" value="confirm" onclick="createNewElements();"/>--%>
            <%--<input type="button" value="查看历史模板" onclick="viewBS('证照模板文件夹:/');"/>--%>
            <%--</p>--%>
            <%--</div>--%>
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

        <!--字体设置工具栏(Mickey)-->
        <div id="setFont_option" class="_util" style="float:left;">
            <button id="bold" class="bttn-unite bttn-xs bttn-primary">加粗</button>
            <button id="italic" class="bttn-unite bttn-xs bttn-primary">加斜</button>
            <button id="underline" class="bttn-unite bttn-xs bttn-primary">下划线</button>
            <button id="textareaBorder" class="bttn-unite bttn-xs bttn-primary">边框</button>
            <%--<button id="setBackGround" class="bttn-unite bttn-xs bttn-primary">设置背景图片</button>--%>
            <%--<input id="bold" type="button" value="加粗" style="height:24px;line-height:20px"/>--%>
            <%--<input id="italic" type="button" value="加斜" style="height:24px;line-height:20px"/>--%>
            <%--<input id="underline" type="button" value="下划线" style="height:24px;line-height:20px"/>--%>
            <%--<input id="textareaBorder" type="button" value="边框" style="height:24px;line-height:20px"/>--%>
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
            <div id="setFont_color" style="float:left;width:auto;padding-right: 0.4em">
                <button class="jscolor {valueElement:'chosen1-value'}">字体颜色</button>
                <input id="chosen1-value" value="000000"/>
                <!-- <input id="colorselect" type="color" style="height:24px;line-height:30px" /> -->
            </div>
            <%--<input type="button" id="downloadPDF" onclick="print()" value="下载PDF"/>--%>
            <%--<button onclick="checkTest()">test</button>--%>
        </div>
    </div>

    <%--画布--%>
    <div id="printf"></div>
</div>


<script>

    /*加载开关按钮的控制选项*/
    $(function () {
            var backgroundColorSelect = document.getElementById("backgroundColorSelect");
            var printf = document.getElementById("printf");
            switchEvent("#backgroundTransparent", function () {
                document.getElementById("bgcolorPicker").style.display = ""
                $(backgroundColorSelect).removeAttr("disabled");
            }, function () {
                backgroundColorSelect.setAttribute("disabled", true);
                document.getElementById("bgcolorPicker").style.display = "none"
                printf.style.backgroundColor = "transparent";
            });
        });


    /*设定PDF生成格式的大小*/
    var pageFormats = { // Size in pt of various paper formats
        'a0': [2383.94, 3370.39],
        'a1': [1683.78, 2383.94],
        'a2': [1190.55, 1683.78],
        'a3': [841.89, 1190.55],
        'a4': [595.28, 841.89],
        'a5': [419.53, 595.28],
        'a6': [297.64, 419.53],
        'a7': [209.76, 297.64],
        'a8': [147.40, 209.76],
        'a9': [104.88, 147.40],
        'a10': [73.70, 104.88],
        'b0': [2834.65, 4008.19],
        'b1': [2004.09, 2834.65],
        'b2': [1417.32, 2004.09],
        'b3': [1000.63, 1417.32],
        'b4': [708.66, 1000.63],
        'b5': [498.90, 708.66],
        'b6': [354.33, 498.90],
        'b7': [249.45, 354.33],
        'b8': [175.75, 249.45],
        'b9': [124.72, 175.75],
        'b10': [87.87, 124.72],
        'c0': [2599.37, 3676.54],
        'c1': [1836.85, 2599.37],
        'c2': [1298.27, 1836.85],
        'c3': [918.43, 1298.27],
        'c4': [649.13, 918.43],
        'c5': [459.21, 649.13],
        'c6': [323.15, 459.21],
        'c7': [229.61, 323.15],
        'c8': [161.57, 229.61],
        'c9': [113.39, 161.57],
        'c10': [79.37, 113.39],
        'dl': [311.81, 623.62],
        'letter': [612, 792],
        'government-letter': [576, 756],
        'legal': [612, 1008],
        'junior-legal': [576, 360],
        'ledger': [1224, 792],
        'tabloid': [792, 1224],
        'credit-card': [153, 243]
    };


    var realPrintfContent;
    var i;	//加粗的变量
    var j;	//加斜的变量
    var k; //下划线的变量
    var l; //边框属性的变量
    var backGroundUnique = 0; //控制背景唯一性
    var index = 2;	//控制每个元素的Z-Index
    var inputSubmit = document.getElementById("inputSubmit");


    /*加载控制PDF格式变化的监测（hezijian6338）*/
    var pdfsize = document.getElementById("pdfSize");
    var lorp = document.getElementById("LorP");
    var printf = document.getElementById("printf");

    //PDF大小控制
    pdfsize.onchange = function () {
        if(printf.innerHTML != ""){
            alert("自动修改画布为你当前所选的格式,并且清楚画布内容,请重新排版！");
        }
        $.each($('.Elements'),function () {
            $(this).css("backgroundColor","");
        });
        printf.innerHTML = "";
        var size = pdfsize.value;
        var format = size.toLowerCase();
        if (pageFormats.hasOwnProperty(format)) {
            printf.style.width = pageFormats[format][0];
            printf.style.height = pageFormats[format][1];
            //alert("宽" +pdfWidth + "高" + pdfHeight + "1");
        }
    };

    //PDF排版控制
    lorp.onchange = function () {
        if(printf.innerHTML != ""){
            alert("自动修改画布为你当前所选的格式,并且清楚画布内容,请重新排版！");
        }
        $.each($('.Elements'),function () {
            $(this).css("backgroundColor","");
        });
        printf.innerHTML = "";
        var or = lorp.value;
        var orientation = or;
        if (orientation) {
            switch (orientation.substr(0, 1)) {
                case 'l':
                    if (printf.style.height > printf.style.width) orientation = 's';
                    break;
                case 'p':
                    if (printf.style.width > printf.style.height) orientation = 's';
                    break;
            }
            if (orientation === 's') {
                var tmp = printf.style.width;
                printf.style.width = printf.style.height;
                printf.style.height = tmp;
                //alert("宽" + pdfWidth + "宽" + pdfHeight + "2");
            }
        }
    };



    /*页面控制（Mickey）*/
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


    function wirteText(e) {			//为每一个文本框输入后自动生成相对应的Html
        //alert(e.value);
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

    /* 把画布内容保存到txt和图片(Mickey)*/
    function saveTxt() {
        var blob = new Blob([document.getElementById("printf").innerHTML], {type: "text/plain;charset=utf-8"});
        saveAs(blob, "secondText.txt");
        html2canvas($("#printf"), {
            onrendered: function (canvas) {
                canvas.toBlob(function (blob) {
                    saveAs(blob, "secondPic.png");
                });
            }
        });
    }

    /*手动修改画布大小(Mickey)*/
    function setPrintfSize() {
        var printf = document.getElementById("printf");
        if (!($(printf).children().length == 0)) {
            //alert("有东西啊！！！！！！" + $(printf).children().length);
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


    /*修改背景颜色（Mickey）*/
    function changeBackgroundColor() {
        var printf = document.getElementById("printf");
        var backgroundColorSelect = document.getElementById("chosen-value");
        alert(backgroundColorSelect.value);
        //提取颜色的选择 设置背景为该颜色
        var getbackgroundColor = backgroundColorSelect.value;
        printf.style.backgroundColor = getbackgroundColor;
    }

    function checkTest() {		//检测画布里的代码
        alert(document.getElementById("printf").innerHTML);
    }


    /*图片元素右键监测函数（Mickey&hezijian6338）*/
    function setIndex(event, e) {
        var thisID = document.getElementById(e.getAttribute("id"));
        checkFont(thisID);
        document.onkeydown = function () {
            var oEvent = window.event;
            if (oEvent.keyCode == 46) {
                $(e).remove();
            }
        }
        var _this = "#" + e.getAttribute("id") ;
        context.attach(e, [
            {header: '元素属性操作' + _this},
            {text: '设置背景',  action:function (et) {
                            if (backGroundUnique == 0) {			//还没有设置背景
                if (confirm("确认此图作为背景？")) {
                    e.style.zIndex = 1;
                    backGroundUnique = 1; //背景已经设置了
                }
            } else {
                alert("你已设置过背景！背景只能有一个！");
            }
            }},
            {text: '取消背景', action: function(et){
                if (e.style.zIndex == 1) {
                if (confirm("是否解除当前组件背景？")) {
                    index = index + 1;
                    e.style.zIndex = index;
                    backGroundUnique = 0;
                }
            }
            }},
            {text: '删除元素', action:function (et) {
                if (confirm("是否删除该元素？")) {
                    backGroundUnique = 0;
                    $(e).unbind();
                    $(e).attr("onclick","");
                    $(e).remove();
                    context.destroy(et);
                }
            }},
        ]);

        //让保存的元素重新到画布上后能重新拖拽伸缩编辑功能
        if ($(e).hasClass("printComponents")) {
            $(e).resizable({
                containment: "#printf"
            }).draggable({
                containment: "#printf"
            });
        }
    }

    /*普通元素右键监测(Mickey&hezijian6338)*/
    function checkClick(e) {
        var thisID = document.getElementById(e.getAttribute("id"));
        checkFont(thisID);
        var tempId = e.getAttribute("id");
        var originId = tempId.substring(2, tempId.length);
        document.onkeydown = function () {
            var oEvent = window.event;
            if (oEvent.keyCode == 46) {
                $(e).remove();
                /*删除唯一元素后工具栏颜色取消*/
                document.getElementById(originId).style.backgroundColor = "";
            }
        }
        var _this = "#" + e.getAttribute("id") ;
        //alert(_this);

        context.attach(_this, [
            {header: '元素属性操作' + originId},
            {text: '删除元素', action:function (event) {
                if (confirm("是否删除该元素？")) {
//                        alert(originId);
                    if(document.getElementById(originId).style.backgroundColor != ""){
                        document.getElementById(originId).style.backgroundColor = "";
                    }
                    $(e).remove();
                }
            }},
            {divider: true},
            {text: 'Disable This Menu', action: function(e){
                e.preventDefault();
                context.destroy('html');
                alert('html contextual menu destroyed!');
            }},
        ]);

    }

    function checkFont(thisID){

        /*字体样式监测（Mickey）*/
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

        /*字体样式监测（Mickey）*/
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

        /*字体样式监测（Mickey）*/
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

        /*字体样式监测（Mickey）*/
        var textareaBorder = document.getElementById("textareaBorder");
        textareaBorder.onclick = function () {
            if ($(thisID).hasClass("textComponents")) {
                //alert("font-family");
                if (l == 0 || l == "" || l == undefined) {
                    $(thisID).find('textarea').css('border', "1px solid #000");
                    l = 1;
                } else {
                    $(thisID).find('textarea').css('border', "none");
                    l = 0;
                }
            }
        }

//        alert("...");
//
//        /*字体样式监测（Mickey）*/
//        var setBackGround = document.getElementById("setBackGround");
//        setBackGround.onclick = function () {
//            if ($(thisID).hasClass("textComponents")) {
//                if (l == 0 || l == "" || l == undefined) {
//                    $(thisID).find('textarea').css('border', "1px solid #000");
//                    l = 1;
//                } else {
//                    $(thisID).find('textarea').css('border', "none");
//                    l = 0;
//                }
//            }
//        }

        /*字体具体属性控制（Mickey）*/
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
            } else {
                //用户已经设置新的字体
                setFontfamily.value = $(thisID).find('textarea').css('font-family');
            }

            //大小属性获取
            if (parseFloat($(thisID).find('textarea').css('font-size')) == '13.33') {			//当前大小为默认大小
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
            //alert(colorselect.value);
            var fontcolor = colorselect.value;
            $(thisID).find('textarea').css('color', fontcolor);
            $(thisID).find('label').css('color', fontcolor);
        }
        size.onchange = function () {
            var fontsize = size.value;
            //alert(size.value);
            $(thisID).find('textarea').css('font-size', fontsize);
            $(thisID).find('label').css('font-size', fontsize);
        }

        family.onchange = function () {
            var fontfamily = family.value;
            //alert(family.value);
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

    /*创建PDF的文本域（Mickey&hezijian6338）*/
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

    /*使当前页面变成图片 然后转换为pdf(Mickey&hezijian6338)*/
    function print() {
        var printfWidth = document.getElementById("printfWidth").value;
        var printfHeight = document.getElementById("printfHeight").value;

        var LorP = document.getElementById("LorP");
        var pdfSize = document.getElementById("pdfSize");

        if (LorP.value == " " || LorP.value == 0 || LorP.value == undefined) {
            alert("必须选择PDF布局形式！" + LorP.value);
        } else if (pdfSize.value == " " || pdfSize.value == 0 || pdfSize.value == undefined) {
            alert("必须选择PDF大小！" + pdfSize.value);
        } else {
            var format = pdfSize.value.toLowerCase();
            if (pageFormats.hasOwnProperty(format)) {
                pdfWidth = pageFormats[format][0];
                pdfHeight = pageFormats[format][1];
                //alert("宽" +pdfWidth + "高" + pdfHeight + "1");
            }
        }
        var orientation = LorP.value;
        if (orientation) {
            switch (orientation.substr(0, 1)) {
                case 'l':
                    if (pdfHeight > pdfWidth) orientation = 's';
                    break;
                case 'p':
                    if (pdfWidth > pdfHeight) orientation = 's';
                    break;
            }
            if (orientation === 's') {
                var tmp = pdfWidth;
                pdfWidth = pdfHeight;
                pdfHeight = tmp;
                //alert("宽" + pdfWidth + "宽" + pdfHeight + "2");
            }
        }

        if (printfWidth == 0 || printfWidth == "" || printfWidth == undefined) {
            printfWidth = 1500;
        }
        if (printfHeight == 0 || printfHeight == "" || printfHeight == undefined) {
            printfHeight = 920;
        }

        //更改了排版方式为竖版（p--竖版；l--横版）
        var pdf = new jsPDF(LorP.value, 'pt', pdfSize.value);
        $.each($('.Elements'),function () {
            $(this).css("backgroundColor","");
        });
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

            //参数修改 长宽交换
            posX = ( pdfWidth * posX ) / printfWidth;
            posY = ( pdfHeight * posY ) / printfHeight;
            posW = ( pdfWidth * posW ) / printfWidth;
            posH = ( pdfHeight * posH ) / printfHeight;
            createTextField(pdf, TF_Id, TF_Name, posX, posY, posW, posH, TF_T);
            $(this).remove();
        });

        //alert("宽"+document.getElementById("printf").offsetWidth);

        html2canvas($("#printf"), {
            onrendered: function (canvas) {
                pdf.addImage(canvas.toDataURL("image/png", 1.0), 'PNG', 0, 0, pdfWidth, pdfHeight);
                pdf.save('content.pdf');

            }
        });
    }


    /*新建用户自插入图片（Mickey&hezijian6338）*/
    function createNewElements() {
        var inputContent = document.getElementById("xFilePath").value;
        document.getElementById("xFilePath").value = "";
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


    function editPdf_txt() {
        <%
                //String realpath = "E:\\photo\\upload\\1\\modelPhoto\\";
                System.out.println("test");
                String txtPath = "picFile/" + request.getParameter("txtPath") ;
                System.out.println(txtPath);
        %>
    }

    function myBrowser(){
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        var isOpera = userAgent.indexOf("Opera") > -1;
        if (isOpera) {
            return "Opera"
        }; //判断是否Opera浏览器
        if (userAgent.indexOf("Firefox") > -1) {
            return "FF";
        } //判断是否Firefox浏览器
        if (userAgent.indexOf("Chrome") > -1){
            //$("button").addClass("bttn-unite bttn-xs bttn-primary");
            return "Chrome";
        }
        if (userAgent.indexOf("Safari") > -1) {
            return "Safari";
        } //判断是否Safari浏览器
        if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) {
            $("button").removeClass("bttn-unite bttn-xs bttn-primary");
            return "IE";
        }; //判断是否IE浏览器
    }

</script>

</body>
</html>