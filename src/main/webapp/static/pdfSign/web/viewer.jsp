<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<!--
Copyright 2012 Mozilla Foundation

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Adobe CMap resources are covered by their own copyright but the same license:

    Copyright 1990-2015 Adobe Systems Incorporated.

See https://github.com/adobe-type-tools/cmap-resources
-->
<html dir="ltr" mozdisallowselectionprint moznomarginboxes>
<head lang="zh">
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html;"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, user-scalable=yes" >
<%--<title>PDF.js viewer</title>--%>
    <title>签章</title>
    <link href="${ctxStatic}/css/style.css?id=2" rel="stylesheet" />
    <script src="${ctxStatic}/js/jquery.js?id=2" type="text/javascript"></script>
    <script src="${ctxStatic}/js/common.js?id=2" type="text/javascript"></script>
    <link rel="stylesheet" href="${ctxStatic}/pdfjs/web/viewer.css?id=2">
    <!-- This snippet is used in production (included from viewer.html) -->
    <link rel="resource" type="application/l10n" href="locale/locale.properties">
    <script>
        <%--var DEFAULT_URL = '${ctxStatic}/pdfjs/web/test.pdf';--%>
        var DEFAULT_URL = '/img${document2.fileUndonePath}';
        var pdfWorkerURL = '${ctxStatic}/pdfjs/build/pdf.worker.js'
    </script>
    <script src="${ctxStatic}/pdfjs/web/l10n.js?id=2"></script>
    <script src="${ctxStatic}/pdfjs/build/pdf.js?id=2"></script>
    <script src="${ctxStatic}/pdfjs/web/viewer.js?id=2"></script>
    <style>
        .toolbar {
            top: 40px;
        }
        #viewerContainer {
            margin-top: 72px;
        }
        .pdfViewer .page{
            margin: 1px auto 10px auto;
        }
    </style>
    <script type="text/javascript">
        function detectZoom (){
            var ratio = 0,
                screen = window.screen,
                ua = navigator.userAgent.toLowerCase();

            if (window.devicePixelRatio !== undefined) {
                ratio = window.devicePixelRatio;
            }
            else if (~ua.indexOf('msie')) {
                if (screen.deviceXDPI && screen.logicalXDPI) {
                    ratio = screen.deviceXDPI / screen.logicalXDPI;
                }
            }
            else if (window.outerWidth !== undefined && window.innerWidth !== undefined) {
                ratio = window.outerWidth / window.innerWidth;
            }

            if (ratio){
                ratio = Math.round(ratio * 100);
            }

            return ratio;
        };
        //window.onresize 事件可用于检测页面是否触发了放大或缩小。
        $(function(){
            //alert(detectZoom())
        });
        if(!/Android|webOS|iPhone|iPod|iPad|BlackBerry/i.test(navigator.userAgent)) {
            $(window).on('resize', function () {
                isScale();
            });
            //判断PC端浏览器缩放比例不是100%时的情况
            function isScale() {
                var rate = detectZoom();
                if (rate != 100) {
                    //如何让页面的缩放比例自动为100,'transform':'scale(1,1)'没有用，又无法自动条用键盘事件，目前只能提示让用户如果想使用100%的比例手动去触发按ctrl+0
                    alert('当前页面不是100%显示，请按键盘ctrl+0恢复100%显示标准，以防页面显示错乱！');
                }
            }
        }
        $(function () {
            $(".menu-btn").click(function () {
                $(".menu").slideToggle("slow");
            });
            /*上传文件*/
            $("#upload").click(function () {
                var formdata = new FormData($("#form")[0]);
                $.ajax({
                    url: "${ctx}/a/document/action/upload",
                    type: "POST",
                    data: formdata,
                    dataType: "json",
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function (result) {
                        if(result.code == 200){
                            alert("上传成功");
                            location.reload();
                        }else{
                            alert("上传失败");
                        }
                    },
                    error: function () {
                        alert("error")
                    }
                })
            });
            /*验章*/
            $("#btn-checkSeal").click(function () {
                checkSeal("${ctx}");
            });
        });
    </script>
</head>

<body tabindex="1" class="loadingInProgress">
<div class="modal" id="uploadFileModal">
    <div class="upload">
        <h2 class="clearfix">选择文件<img src="${ctxStatic}/img/close.png" class="close" onclick="closeModal()"></h2>
        <hr>
        <form id="form" enctype="multipart/form-data" method="post">
            <div class="clearfix" style="padding:10px 10px">
                <div class="label">文件名：</div>
                <input type="text" class="input" name="fileName" id="fileName">
            </div>
            <div class="clearfix" style="padding:5px 10px;display: none;display: none">
                <div class="label">备注：</div>
                <input type="text" class="input" name="remarks" id="remarks">
            </div>
            <div style="padding:8px 10px;text-align: left">
                <button id="btn-choose" class="btn-choose" type="button">选择文件</button>
                <span class="file-name"></span>
                <input type="file" id="uploadFile" name="file" style="display: none" onchange="filepath(this)">
            </div>
            <div style="padding-top: 20px;padding-bottom: 20px;">
                <button id="upload" class="btn-upload" type="button">确认上传</button>
            </div>
        </form>
    </div>
</div>
<div class="modal" id="checkSealModal">
    <div class="upload">
        <h2 class="clearfix">验章<img src="${ctxStatic}/img/close.png" class="close" onclick="closeCheckSealModal()"></h2>
        <hr>
        <form id="checkSealForm" enctype="multipart/form-data" method="post">
            <div id="up">
                <div style="padding:8px 10px;text-align: left">
                    <button id="btn-check" class="btn-choose" type="button">选择文件</button>
                    <span class="file-name"></span>
                    <input type="file" id="checkSealFile" name="file" style="display: none" onchange="filepath(this)">
                </div>
                <div style="padding-top: 20px;padding-bottom: 20px;">
                    <button id="btn-checkSeal" class="btn-upload" type="button">确认上传</button>
                </div>
            </div>
            <div id="checkseal">

            </div>
        </form>
    </div>
</div>

<header style="position: fixed">
    <h2 style="color: white">文档签章</h2>
    <span class="menu-button"></span>
    <div class="menu">
        <ul>
            <li><a href="###"></a>占位置</li>
            <li style="margin-top: 5px"><a href="${ctx}/a/document/info/list">文件列表</a></li>
            <li><a href="##" onclick="restar()">重置印模位置</a></li>
            <li><a href="##" id="signature">签章</a></li>
            <%--<li><a href="###" onclick="uploadModal()">上传文件</a></li>--%>
            <%--<li><a href="###" onclick="checkSealModal()">验章</a></li>--%>
            <li><a href="${ctx}/a/logout">退出</a></li>
        </ul>
    </div>
</header>
<%--<div style="display:block;text-align: center;position: fixed;bottom: 0;left: calc((100% - 100px)/2);width: 100px;z-index: 1001">--%>
    <%--<button id="signature" class="btn-upload" style="width: 100px;z-index: 1001">签章</button>--%>
<%--</div>--%>
<%--<div style="width:140px;height:140px;z-index:999;border:2px solid #ccc; position:fixed; left: 500px;top:100px;background: url('/img${seal.eleModel}');background-size: cover;cursor: pointer"--%>
     <%--id="div">--%>
<%--</div>--%>
<%--原生代码--%>
<div id="outerContainer">

    <div id="sidebarContainer">
        <div id="toolbarSidebar">
            <div class="splitToolbarButton toggled">
                <button id="viewThumbnail" class="toolbarButton toggled" title="Show Thumbnails" tabindex="2"
                        data-l10n-id="thumbs">
                    <span data-l10n-id="thumbs_label">Thumbnails</span>
                </button>
                <button id="viewOutline" class="toolbarButton"
                        title="Show Document Outline (double-click to expand/collapse all items)" tabindex="3"
                        data-l10n-id="document_outline">
                    <span data-l10n-id="document_outline_label">Document Outline</span>
                </button>
                <button id="viewAttachments" class="toolbarButton" title="Show Attachments" tabindex="4"
                        data-l10n-id="attachments">
                    <span data-l10n-id="attachments_label">Attachments</span>
                </button>
            </div>
        </div>
        <div id="sidebarContent">
            <div id="thumbnailView">
            </div>
            <div id="outlineView" class="hidden">
            </div>
            <div id="attachmentsView" class="hidden">
            </div>
        </div>
    </div>  <!-- sidebarContainer -->

    <div id="mainContainer" style="width: 1000px;">
        <div class="findbar hidden doorHanger" id="findbar">
            <div id="findbarInputContainer">
                <input id="findInput" class="toolbarField" title="Find" placeholder="Find in document…" tabindex="91"
                       data-l10n-id="find_input">
                <div class="splitToolbarButton">
                    <button id="findPrevious" class="toolbarButton findPrevious"
                            title="Find the previous occurrence of the phrase" tabindex="92"
                            data-l10n-id="find_previous">
                        <span data-l10n-id="find_previous_label">Previous</span>
                    </button>
                    <div class="splitToolbarButtonSeparator"></div>
                    <button id="findNext" class="toolbarButton findNext" title="Find the next occurrence of the phrase"
                            tabindex="93" data-l10n-id="find_next">
                        <span data-l10n-id="find_next_label">Next</span>
                    </button>
                </div>
            </div>

            <div id="findbarOptionsContainer">
                <input type="checkbox" id="findHighlightAll" class="toolbarField" tabindex="94">
                <label for="findHighlightAll" class="toolbarLabel" data-l10n-id="find_highlight">Highlight all</label>
                <input type="checkbox" id="findMatchCase" class="toolbarField" tabindex="95">
                <label for="findMatchCase" class="toolbarLabel" data-l10n-id="find_match_case_label">Match case</label>
                <span id="findResultsCount" class="toolbarLabel hidden"></span>
            </div>

            <div id="findbarMessageContainer">
                <span id="findMsg" class="toolbarLabel"></span>
            </div>
        </div>  <!-- findbar -->

        <div id="secondaryToolbar" class="secondaryToolbar hidden doorHangerRight">
            <div id="secondaryToolbarButtonContainer">
                <button id="secondaryPresentationMode" class="secondaryToolbarButton presentationMode visibleLargeView"
                        title="Switch to Presentation Mode" tabindex="51" data-l10n-id="presentation_mode">
                    <span data-l10n-id="presentation_mode_label">Presentation Mode</span>
                </button>

                <button id="secondaryOpenFile" class="secondaryToolbarButton openFile visibleLargeView"
                        title="Open File" tabindex="52" data-l10n-id="open_file">
                    <span data-l10n-id="open_file_label">Open</span>
                </button>

                <button id="secondaryPrint" class="secondaryToolbarButton print visibleMediumView" title="Print"
                        tabindex="53" data-l10n-id="print">
                    <span data-l10n-id="print_label">Print</span>
                </button>

                <button id="secondaryDownload" class="secondaryToolbarButton download visibleMediumView"
                        title="Download" tabindex="54" data-l10n-id="download">
                    <span data-l10n-id="download_label">Download</span>
                </button>

                <a href="#" id="secondaryViewBookmark" class="secondaryToolbarButton bookmark visibleSmallView"
                   title="Current view (copy or open in new window)" tabindex="55" data-l10n-id="bookmark">
                    <span data-l10n-id="bookmark_label">Current View</span>
                </a>

                <div class="horizontalToolbarSeparator visibleLargeView"></div>

                <button id="firstPage" class="secondaryToolbarButton firstPage" title="Go to First Page" tabindex="56"
                        data-l10n-id="first_page">
                    <span data-l10n-id="first_page_label">Go to First Page</span>
                </button>
                <button id="lastPage" class="secondaryToolbarButton lastPage" title="Go to Last Page" tabindex="57"
                        data-l10n-id="last_page">
                    <span data-l10n-id="last_page_label">Go to Last Page</span>
                </button>

                <div class="horizontalToolbarSeparator"></div>

                <button id="pageRotateCw" class="secondaryToolbarButton rotateCw" title="Rotate Clockwise" tabindex="58"
                        data-l10n-id="page_rotate_cw">
                    <span data-l10n-id="page_rotate_cw_label">Rotate Clockwise</span>
                </button>
                <button id="pageRotateCcw" class="secondaryToolbarButton rotateCcw" title="Rotate Counterclockwise"
                        tabindex="59" data-l10n-id="page_rotate_ccw">
                    <span data-l10n-id="page_rotate_ccw_label">Rotate Counterclockwise</span>
                </button>

                <div class="horizontalToolbarSeparator"></div>

                <button id="toggleHandTool" class="secondaryToolbarButton handTool" title="Enable hand tool"
                        tabindex="60" data-l10n-id="hand_tool_enable">
                    <span data-l10n-id="hand_tool_enable_label">Enable hand tool</span>
                </button>

                <div class="horizontalToolbarSeparator"></div>

                <button id="documentProperties" class="secondaryToolbarButton documentProperties"
                        title="Document Properties…" tabindex="61" data-l10n-id="document_properties">
                    <span data-l10n-id="document_properties_label">Document Properties…</span>
                </button>
            </div>
        </div>  <!-- secondaryToolbar -->

        <div class="toolbar">
            <div id="toolbarContainer">
                <div id="toolbarViewer">
                    <div id="toolbarViewerLeft">
                        <button id="sidebarToggle" class="toolbarButton" title="Toggle Sidebar" tabindex="11"
                                data-l10n-id="toggle_sidebar">
                            <span data-l10n-id="toggle_sidebar_label">Toggle Sidebar</span>
                        </button>
                        <div class="toolbarButtonSpacer"></div>
                        <button id="viewFind" style="display: none" class="toolbarButton" title="Find in Document"
                                tabindex="12" data-l10n-id="findbar">
                            <span data-l10n-id="findbar_label">Find</span>
                        </button>
                        <div class="splitToolbarButton hiddenSmallView">
                            <button class="toolbarButton pageUp" title="Previous Page" id="previous" tabindex="13"
                                    data-l10n-id="previous">
                                <span data-l10n-id="previous_label">Previous</span>
                            </button>
                            <div class="splitToolbarButtonSeparator"></div>
                            <button class="toolbarButton pageDown" title="Next Page" id="next" tabindex="14"
                                    data-l10n-id="next">
                                <span data-l10n-id="next_label">Next</span>
                            </button>
                        </div>
                        <input type="number" id="pageNumber" class="toolbarField pageNumber" title="Page" value="1"
                               size="4" min="1" tabindex="15" data-l10n-id="page">
                        <span id="numPages" class="toolbarLabel"></span>
                    </div>
                    <div id="toolbarViewerRight">
                        <button id="presentationMode" class="toolbarButton presentationMode hiddenLargeView"
                                title="Switch to Presentation Mode" tabindex="31" data-l10n-id="presentation_mode">
                            <span data-l10n-id="presentation_mode_label">Presentation Mode</span>
                        </button>

                        <button id="openFile" style="display: none" class="toolbarButton openFile hiddenLargeView"
                                title="Open File" tabindex="32" data-l10n-id="open_file">
                            <span data-l10n-id="open_file_label">Open</span>
                        </button>

                        <button id="print" class="toolbarButton print hiddenMediumView" title="Print" tabindex="33"
                                data-l10n-id="print">
                            <span data-l10n-id="print_label">Print</span>
                        </button>

                        <button id="download" class="toolbarButton download hiddenMediumView" title="Download"
                                tabindex="34" data-l10n-id="download">
                            <span data-l10n-id="download_label">Download</span>
                        </button>
                        <a href="#" id="viewBookmark" style="display: none"
                           class="toolbarButton bookmark hiddenSmallView"
                           title="Current view (copy or open in new window)" tabindex="35" data-l10n-id="bookmark">
                            <span data-l10n-id="bookmark_label">Current View</span>
                        </a>

                        <div class="verticalToolbarSeparator hiddenSmallView"></div>

                        <button id="secondaryToolbarToggle" class="toolbarButton" title="Tools" tabindex="36"
                                data-l10n-id="tools">
                            <span data-l10n-id="tools_label">Tools</span>
                        </button>
                    </div>
                    <div id="toolbarViewerMiddle" style="display: none">
                        <div class="splitToolbarButton">
                            <button id="zoomOut" class="toolbarButton zoomOut" title="Zoom Out" tabindex="21"
                                    data-l10n-id="zoom_out">
                                <span data-l10n-id="zoom_out_label">Zoom Out</span>
                            </button>
                            <div class="splitToolbarButtonSeparator"></div>
                            <button id="zoomIn" class="toolbarButton zoomIn" title="Zoom In" tabindex="22"
                                    data-l10n-id="zoom_in">
                                <span data-l10n-id="zoom_in_label">Zoom In</span>
                            </button>
                        </div>
                        <span id="scaleSelectContainer" class="dropdownToolbarButton">
                  <select id="scaleSelect" title="Zoom" tabindex="23" data-l10n-id="zoom">
                    <option id="pageAutoOption" title="" value="auto" selected="selected"
                            data-l10n-id="page_scale_auto">Automatic Zoom</option>
                    <option id="pageActualOption" title="" value="page-actual" data-l10n-id="page_scale_actual">Actual Size</option>
                    <option id="pageFitOption" title="" value="page-fit" data-l10n-id="page_scale_fit">Fit Page</option>
                    <option id="pageWidthOption" title="" value="page-width"
                            data-l10n-id="page_scale_width">Full Width</option>
                    <option id="customScaleOption" title="" value="custom" disabled="disabled" hidden="true"></option>
                    <option title="" value="0.5" data-l10n-id="page_scale_percent"
                            data-l10n-args='{ "scale": 50 }'>50%</option>
                    <option title="" value="0.75" data-l10n-id="page_scale_percent"
                            data-l10n-args='{ "scale": 75 }'>75%</option>
                    <option title="" value="1" data-l10n-id="page_scale_percent"
                            data-l10n-args='{ "scale": 100 }'>100%</option>
                    <option title="" value="1.25" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 125 }'>125%</option>
                    <option title="" value="1.5" data-l10n-id="page_scale_percent" data-l10n-args='{ "scale": 150 }'>150%</option>
                    <option title="" value="2" data-l10n-id="page_scale_percent"
                            data-l10n-args='{ "scale": 200 }'>200%</option>
                    <option title="" value="3" data-l10n-id="page_scale_percent"
                            data-l10n-args='{ "scale": 300 }'>300%</option>
                    <option title="" value="4" data-l10n-id="page_scale_percent"
                            data-l10n-args='{ "scale": 400 }'>400%</option>
                  </select>
                </span>
                    </div>
                </div>
                <div id="loadingBar">
                    <div class="progress">
                        <div class="glimmer">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <menu type="context" id="viewerContextMenu">
            <menuitem id="contextFirstPage" label="First Page"
                      data-l10n-id="first_page"></menuitem>
            <menuitem id="contextLastPage" label="Last Page"
                      data-l10n-id="last_page"></menuitem>
            <menuitem id="contextPageRotateCw" label="Rotate Clockwise"
                      data-l10n-id="page_rotate_cw"></menuitem>
            <menuitem id="contextPageRotateCcw" label="Rotate Counter-Clockwise"
                      data-l10n-id="page_rotate_ccw"></menuitem>
        </menu>
        <%--修改架构，增加代码--%>
        <div id="viewerContainer" tabindex="0" style="position: relative">
            <%--增加印模图片，用于拖动和获得坐标--%>
            <div style="width:140px;height:140px;z-index:999;border:2px solid #ccc;
                    position:absolute; left: 500px;top:50px;background: url('/img${seal.eleModel}');
                    background-size: cover;cursor: pointer;"
                 id="div">
            </div>

            <div id="viewer" class="pdfViewer"></div>
        </div>

        <div id="errorWrapper" hidden='true'>
            <div id="errorMessageLeft">
                <span id="errorMessage"></span>
                <button id="errorShowMore" data-l10n-id="error_more_info">
                    More Information
                </button>
                <button id="errorShowLess" data-l10n-id="error_less_info" hidden='true'>
                    Less Information
                </button>
            </div>
            <div id="errorMessageRight">
                <button id="errorClose" data-l10n-id="error_close">
                    Close
                </button>
            </div>
            <div class="clearBoth"></div>
            <textarea id="errorMoreInfo" hidden='true' readonly="readonly"></textarea>
        </div>
    </div> <!-- mainContainer -->

    <div id="overlayContainer" class="hidden">
        <div id="passwordOverlay" class="container hidden">
            <div class="dialog">
                <div class="row">
                    <p id="passwordText" data-l10n-id="password_label">Enter the password to open this PDF file:</p>
                </div>
                <div class="row">
                    <!-- The type="password" attribute is set via script, to prevent warnings in Firefox for all http:// documents. -->
                    <input id="password" class="toolbarField">
                </div>
                <div class="buttonRow">
                    <button id="passwordCancel" class="overlayButton"><span data-l10n-id="password_cancel">Cancel</span>
                    </button>
                    <button id="passwordSubmit" class="overlayButton"><span data-l10n-id="password_ok">OK</span>
                    </button>
                </div>
            </div>
        </div>
        <div id="documentPropertiesOverlay" class="container hidden">
            <div class="dialog">
                <div class="row">
                    <span data-l10n-id="document_properties_file_name">File name:</span>
                    <p id="fileNameField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_file_size">File size:</span>
                    <p id="fileSizeField">-</p>
                </div>
                <div class="separator"></div>
                <div class="row">
                    <span data-l10n-id="document_properties_title">Title:</span>
                    <p id="titleField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_author">Author:</span>
                    <p id="authorField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_subject">Subject:</span>
                    <p id="subjectField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_keywords">Keywords:</span>
                    <p id="keywordsField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_creation_date">Creation Date:</span>
                    <p id="creationDateField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_modification_date">Modification Date:</span>
                    <p id="modificationDateField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_creator">Creator:</span>
                    <p id="creatorField">-</p>
                </div>
                <div class="separator"></div>
                <div class="row">
                    <span data-l10n-id="document_properties_producer">PDF Producer:</span>
                    <p id="producerField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_version">PDF Version:</span>
                    <p id="versionField">-</p>
                </div>
                <div class="row">
                    <span data-l10n-id="document_properties_page_count">Page Count:</span>
                    <p id="pageCountField">-</p>
                </div>
                <div class="buttonRow">
                    <button id="documentPropertiesClose" class="overlayButton"><span
                            data-l10n-id="document_properties_close">Close</span></button>
                </div>
            </div>
        </div>
        <div id="printServiceOverlay" class="container hidden">
            <div class="dialog">
                <div class="row">
                    <span data-l10n-id="print_progress_message">Preparing document for printing…</span>
                </div>
                <div class="row">
                    <progress value="0" max="100"></progress>
                    <span data-l10n-id="print_progress_percent" data-l10n-args='{ "progress": 0 }'
                          class="relative-progress">0%</span>
                </div>
                <div class="buttonRow">
                    <button id="printCancel" class="overlayButton"><span
                            data-l10n-id="print_progress_close">Cancel</span></button>
                </div>
            </div>
        </div>
    </div>  <!-- overlayContainer -->

</div> <!-- outerContainer -->
<div id="printContainer"></div>
<script>
    //alert(document.getElementById("viewer"));
    function getScrollTop() {
        var scrollPos = document.documentElement.scrollTop || document.body.scrollTop;
        return scrollPos;
    }
    window.onscroll = parent.div.onmouseup;
</script>
<%--数据提交表单--%>
<form id="form-sign" style="display: none">
    <input name="point.x" id="x">
    <input name="point.y" id="y">
    <input name="point.width" id="width">
    <input name="point.high" id="high">
    <input name="point.pageSize" id="pageSize">
    <input name="point.pxWidth" id="pageWidth">
    <input name="point.pxHigh" id="pageHeight">
    <input name="document" id="document">
    <input name="seal" id="seal">
</form>
<%--自己写的js脚本--%>
<script>
    window.setTimeout(function(){document.title = "签章"},1000);
//    印模位置重置
    function restar(){
        div.style.top = yScroll + 100 + 'px';
        <%--获取y坐标和页码--%>
        if(pageCount == 0){
            pageCount = parseInt((parseInt(div.style.top) - 10) / pageHeight);
            py = (parseInt(div.style.top) - 10) % pageHeight;
        }else{
            pageCount = parseInt((parseInt(div.style.top) - 10 - (pageCount-1)*10) / pageHeight);
            py = (parseInt(div.style.top) - 10 - (pageCount*10)) % pageHeight;
        }
    }
    /*确认签章*/
    $("#signature").click(function () {
        var msg = "确定签章到此文件吗？";
        if(confirm(msg)==true){
            <%--不能在两页之间签章控制--%>
            if(py >= pageHeight-10 || py >= pageHeight-ph){
               alert("不能在两页之间签章！");
               return false;
            }
            <%--将参数设置进入form表单用于提交给后台--%>
            $("#x").val(px);
            $("#y").val(pageHeight-py);
            $("#width").val(pw);
            $("#high").val(ph);
            $("#pageSize").val(pageCount+1);
            $("#pageWidth").val(pageWidth);
            $("#pageHeight").val(pageHeight);
            $("#document").val("${document}");
            $("#seal").val("${seal.id}");
            var formdata = new FormData($("#form-sign")[0]);
//            console.log(formdata);
            $.ajax({
                type: "POST",
                url: "${ctx}/a/singal/signature",
                data: formdata,
                dataType: "JSON",
                cache: false,
                processData: false,
                contentType: false,
                success: function (result) {
                    if(result.code == 200){
                        alert("签章成功");
                        location.href = "${ctx}/a/document/info/list";
                    }else{
                        alert(result.message);
                    }
                },
                error:function(){
                    alert("error")
                }
            });
        }else{
            return false;
        }
    });
    //拖拽功能
    var div = document.getElementById("div"); //签章div
    var px,py;
    var pw = parseInt(div.style.width); //签章宽度
    var ph = parseInt(div.style.height); //签章高度
    var add = 0;lastScroll = 0;//滚动相较上次增加的值，上次滚动的值
    var wh = document.body.clientHeight;//获取页面高度
    var yScroll = 0; //当前相对pdf首页顶部高度
    var iframe = document.getElementById('myFrame'); //pdfFrame
    var page, pageWidth, pageHeight, pageLeft, pageCount;//pdf的每一页，每一页的宽度，每一页的高度，每一页相对左边的宽度，相对右边的宽度（空白）
    var viewWidth = document.getElementById('viewer').offsetWidth;//页面宽度
    var viewHeight = document.getElementById('viewer').offsetHeight;//页面可视高度
//    页面滚动时的事件
    $(window).scroll(function(){
        //为了保证兼容性，这里取两个值，哪个有值取哪一个
        yScroll = document.documentElement.scrollTop || document.body.scrollTop;
        //scrollTop就是触发滚轮事件时滚轮的高度
        div.style.top = parseInt(div.style.top) + add + "px";
        if (parseInt(div.style.top) < 10) {
            div.style.top = 10 + 'px';
        }
        <%--初始化值--%>
        page = document.getElementsByClassName('page')[0];
        pageWidth = parseInt(page.style.width);
        pageHeight = parseInt(page.style.height);
        pageLeft = (parseInt(viewWidth) - pageWidth)/2;
        px = parseInt(div.style.left) - pageLeft - 7.5;
        pageCount = parseInt((parseInt(div.style.top) - 10) / pageHeight);
        <%--如果页码为0，计算y坐标值--%>
        if(pageCount == 0){
            pageCount = parseInt((parseInt(div.style.top) - 10) / pageHeight);
            py = (parseInt(div.style.top) - 10) % pageHeight;
        }else{
            <%--如果页码不为0，计算y值要加上两页之间宽度--%>
            pageCount = parseInt((parseInt(div.style.top) - 10 - (pageCount-1)*10) / pageHeight);
            py = (parseInt(div.style.top) - 10 - (pageCount*10)) % pageHeight;
        }
        console.log("签章的坐标x=" + px + ", y=" + py + ", 签章宽度w=" + pw + ", 高度h=" + ph + ", 页码数count=" + pageCount);
        <%--计算页面滚动量--%>
        add = yScroll - lastScroll;
        lastScroll = yScroll;
    });
    //手机端拖动
    <%--识别手机端操作系统--%>
    if(/Android|webOS|iPhone|iPod|iPad|BlackBerry/i.test(navigator.userAgent)){
        <%--重设印模位置和大小--%>
        document.getElementById("div").style.top = "84px";
        document.getElementById("div").style.left = "50px";
        document.getElementById("div").style.width = "50px";
        document.getElementById("div").style.height = "50px";
        pw = 50;
        ph = 50;
        var flag = false;
        var cur = {
            x:0,
            y:0
        };
        var nx,ny,dx,dy,x,y ;
        <%--手指按下时调用--%>
        function down(){
            flag = true;
            var touch ;
            if(event.touches){
                touch = event.touches[0];
            }else {
                touch = event;
            }
            cur.x = touch.clientX;
            cur.y = touch.clientY;
            dx = parseInt(div2.style.left);
            dy = parseInt(div2.style.top);
        }
        <%--手指移动时调用--%>
        function move(){
            if(flag){
                var touch ;
                if(event.touches){
                    touch = event.touches[0];
                }else {
                    touch = event;
                }
                <%--初始化数据--%>
                page = document.getElementsByClassName('page')[0]; //每页
                viewWidth = document.getElementById('viewer').offsetWidth;
                viewHeight = document.getElementById('viewer').offsetHeight;
                pageWidth = parseInt(page.style.width);
                pageHeight = parseInt(page.style.height);
                pageLeft = (parseInt(viewWidth) - pageWidth)/2;
                nx = touch.clientX - cur.x;
                ny = touch.clientY - cur.y;
                x = dx+nx;
                y = dy+ny;
                <%--限制印模不能拖出页面左右代码--%>
                <%--如果小于最左边，则x值不再减小--%>
                if(x < (pageLeft + 8)){
                    div2.style.left = (pageLeft + 8)+"px";
                }else if(x > (pageLeft + pageWidth - parseInt(document.getElementById("div").style.width) + 8)){
                    <%--如果大于最左边，则x值不再增加--%>
                    div2.style.left = (pageLeft + pageWidth - parseInt(document.getElementById("div").style.width) + 8) + "px";
                }else{
                    <%--否则x值随手指移动改变--%>
                    div2.style.left = x+"px";
                }
                <%--控制印模不能拖出pdf页面上下代码--%>
                <%--如果小于页面，则不再减小--%>
                if(y < 10){
                    div2.style.top = 10 +"px";
                }else if(y > (viewHeight - parseInt(document.getElementById("div").style.height) + 10)){
                    <%--如果大于页面，则不再增加--%>
                    div2.style.top = (viewHeight - parseInt(document.getElementById("div").style.height) + 10) +"px";
                }else{
                    div2.style.top = y +"px";
                }
                //阻止页面的滑动默认事件
                $("body").on("touchmove",function(event){
                    event.preventDefault;
                }, false);
            }
        }
        //手指释放时候的函数
        function end(){
            flag = false;
            <%--初始化值--%>
            viewWidth = document.getElementById('viewer').offsetWidth;
            page = document.getElementsByClassName('page')[0]; //iframe内pdf对象
            pageLeft = (parseInt(viewWidth) - pageWidth)/2;
            px = parseInt(div2.style.left) - pageLeft - 8;
            pageHeight = parseInt(page.style.height);
            pageLeft = parseInt(page.offsetLeft);
            pageCount = parseInt((parseInt(div2.style.top) - 10) / pageHeight);
            <%--如果页码为0，计算y坐标值--%>
            if(pageCount == 0){
                pageCount = parseInt((parseInt(div.style.top) - 10) / pageHeight);
                py = (parseInt(div.style.top) - 10) % pageHeight;
            }else{
                <%--如果页码不为0，计算y值要加上两页之间宽度--%>
                pageCount = parseInt((parseInt(div.style.top) - 10 - (pageCount-1)*10) / pageHeight);
                py = (parseInt(div.style.top) - 10 - (pageCount*10)) % pageHeight;
            }
            //        不允许在两页中间的控制
            <%--y坐标高过页面且在两页中间，则弹回此页顶点--%>
            if(py >= pageHeight-10){
                div.style.top = (parseInt(div.style.top) + pageHeight - py) + 'px';
                py = 0;
            }else if(py >= pageHeight-ph){
                <%--y坐标超过此页，则弹回此页--%>
                div.style.top = (parseInt(div.style.top) - (ph - (pageHeight - py))) + 'px';
                py = (parseInt(div.style.top) - 10 - (pageCount*10)) % pageHeight;
            }
            console.log("签章的坐标x=" + px + ", y=" + py + ", 签章宽度w=" + pw + ", 高度h=" + ph + ", 页码数count=" + pageCount);
            //关闭阻止页面的滑动事件
            $("body").off("touchmove");
        }
        var div2 = document.getElementById("div");
        div2.addEventListener("mousedown",function(){
            down();
        },false);
        div2.addEventListener("touchstart",function(){
            down();
        },false);
        div2.addEventListener("mousemove",function(){
            move();
        },false);
        div2.addEventListener("touchmove",function(){
            move();
        },false);
        document.body.addEventListener("mouseup",function(){
            end();
        },false);
        div2.addEventListener("touchend",function(){
            end();
        },false);
    }
    //    手机端结束
    //    PC端
    div.onmousedown = function (e) {
        <%--鼠标按下时，设置默认值--%>
        px = e.clientX - parseInt(div.style.left);
        py = e.clientY - parseInt(div.style.top);
        div.onmousemove = mousemove;
        div.onmouseleave = div.onmouseup;
    };
    <%--鼠标释放时--%>
    div.onmouseup = function () {
        div.onmousemove = null;
        <%--初始化值--%>
        viewWidth = document.getElementById('viewer').offsetWidth;
        page = document.getElementsByClassName('page')[0]; //每页
        pageLeft = (parseInt(viewWidth) - pageWidth)/2;
        px = parseInt(div.style.left) - pageLeft - 7.5;
        pageHeight = parseInt(page.style.height);
        pageCount = parseInt((parseInt(div.style.top) - 10) / pageHeight);
        <%--如果页码为0，计算y坐标值--%>
        if(pageCount == 0){
            pageCount = parseInt((parseInt(div.style.top) - 10) / pageHeight);
            py = (parseInt(div.style.top) - 10) % pageHeight;
        }else{
            <%--如果页码不为0，计算y值要加上两页之间宽度--%>
            pageCount = parseInt((parseInt(div.style.top) - 10 - (pageCount-1)*10) / pageHeight);
            py = (parseInt(div.style.top) - 10 - (pageCount*10)) % pageHeight;
        }
//        不允许在两页中间的控制
        <%--y坐标高过页面且在两页中间，则弹回此页顶点--%>
        if(py >= pageHeight-10){
            div.style.top = (parseInt(div.style.top) + pageHeight - py) + 'px';
            py = 0;
        }else if(py >= pageHeight-ph){
            <%--y坐标超过此页，则弹回此页--%>
            div.style.top = (parseInt(div.style.top) - (ph - (pageHeight - py))) + 'px';
            py = (parseInt(div.style.top) - 10 - (pageCount*10)) % pageHeight;
        }
        console.log("签章的坐标x=" + px + ", y=" + py + ", 签章宽度w=" + pw + ", 高度h=" + ph + ", 页码数count=" + pageCount);
    };
    <%--鼠标移动时--%>
    function mousemove(em) {
        if (!em) em = window.event;//if不是firefox等浏览器，那么e为IE浏览器
        <%--初始化值--%>
        page = document.getElementsByClassName('page')[0]; //每页
        viewWidth = document.getElementById('viewer').offsetWidth;
        viewHeight = document.getElementById('viewer').offsetHeight;
        pageWidth = parseInt(page.style.width);
        pageHeight = parseInt(page.style.height);
        pageLeft = (parseInt(viewWidth) - pageWidth)/2;
        <%--限制印模不能拖出页面左右代码--%>
        <%--如果小于最左边，则x值不再减小--%>
        if ((em.clientX - px) < (pageLeft + 8)) {
            div.style.left = (pageLeft + 8) + 'px';
        } else if ((em.clientX - px) > (pageLeft + pageWidth - pw + 10)) {
            <%--如果大于最左边，则x值不再增加--%>
            div.style.left = (pageLeft + pageWidth - pw + 10) + 'px';
        } else {
            <%--否则x值随手指移动改变--%>
            div.style.left = (em.clientX - px) + 'px';
        }
        <%--控制印模不能拖出pdf页面上下代码--%>
        <%--如果小于页面，则不再减小--%>
        if ((em.clientY - py) < 10) {
            div.style.top = 10 + 'px';
        } else if ((em.clientY - py) > (viewHeight - ph + 10)) {
            <%--如果大于页面，则不再增加--%>
            div.style.top = (viewHeight - ph + 10) + 'px';
        }else{
            div.style.top = (em.clientY - py) + 'px';
        }
        <%--限制印模不能拖出浏览器可视区域顶部--%>
        if(parseInt(div.style.top) < parseInt(yScroll)){
            div.style.top = yScroll + 'px';
        }else if(parseInt(div.style.top) > (parseInt(yScroll) + wh -ph)){
            div.style.top = (parseInt(yScroll) + wh -ph) + 'px';
        }
    }
</script>
</body>
</html>

