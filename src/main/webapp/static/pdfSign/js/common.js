$(function () {
    /*右上菜单*/
    $(".menu-button").click(function () {
        $(".menu").slideToggle("slow");
    });

    /*上传文件-选择文件按钮*/
    $("#btn-choose").click(function () {
        $("#uploadFile").click();
    });
    /*验章-选择文件按钮*/
    $("#btn-check").click(function () {
        $("#checkSealFile").click();
    });
});
/*上传文件*/
function uploadModal() {
    $("#uploadFileModal").fadeIn();
}
function filepath(fp) {
    var filename = $(fp).val().split("\\");
    filename = filename[filename.length - 1];
    $(fp).prev().text(filename);
}
function closeModal() {
    $("#uploadFileModal").fadeOut();
}

/*验章*/
function checkSealModal() {
    $(".upload").css("max-width","300px");
    $("#up").show();
    $("#checkseal").empty();
    $("#checkSealModal").fadeIn();
}
function closeCheckSealModal() {
    $("#checkSealModal").fadeOut();
}
//验章方法
function checkSeal(ctx) {
    $("#btn-checkSeal").attr("disabled","disabled"); //设置变灰按钮
    var formdata = new FormData($("#checkSealForm")[0]);
    $.ajax({
        url: ctx+"/a/check/document",
        type: "POST",
        data: formdata,
        dataType: "json",
        cache: false,
        processData: false,
        contentType: false,
        success: function (result) {
            if(result.code == 200){
                alert(result.message);
                $("#up").hide();
                $(".upload").css("max-width","700px");
                var date;
                var undoneUrl;
                var doneUrl;
                //验证成功后显示签章信息列表
                var s = "<table border='1' cellpadding='0' cellspacing='0'>"+
                        "<tr>"+
                        "<th>文件名称</th><th>备注</th><th>签章日期</th><th>用章单位</th><th>印章名称</th><th>印章图案</th><th>原文件</th><th>已签章文件</th></tr>";
                for(var i = 0;i < result.entity.length;i++){
                    date = changeDate(result.entity[i].singalDate);
                    undoneUrl = ctx + "/a/document/info/undone?document=" + result.entity[i].id;
                    doneUrl = ctx + "/a/document/info/done?document=" + result.entity[i].id;
                    s +='<tr><td>' + result.entity[i].fileName + '</td>'+
                            '<td>' + result.entity[i].remarks + '</td>'+
                            '<td>' + date + '</td>'+
                            '<td>' + result.entity[i].stamp.useComp.companyName + '</td>'+
                            '<td>' + result.entity[i].stamp.stampName + '</td>'+
                            "<td><img src='/img" +result.entity[i].stamp.eleModel + "' style='height: 140px'></td>" +
                            "<td><button class='btn-choose' type='button' onclick='window.open(\""+ undoneUrl +"\")'>查看</button></td>" +
                            "<td><button class='btn-choose' type='button' onclick='window.open(\""+ doneUrl +"\")'>查看</button></td>"+
                        "</tr>";
                }
                s += "</table>";
                $("#checkseal").html(s);
                $('#btn-checkSeal').removeAttr('disabled');
            }else{
                $('#btn-checkSeal').removeAttr('disabled');
                alert(result.message);
            }
        },
        error: function () {
            $('#btn-checkSeal').removeAttr('disabled');
            alert("出错了！请重试。");
        }
    })
}
function changeDate(date) {
    var jsondate="/Date(" + date + ")/";
    var formatdate=eval(jsondate.replace(/\/Date\((\d+)\)\//gi, "new Date($1)"));
    return formatdate.toLocaleDateString();
}

/*点击底部文档签章*/
function toFileList(url) {
    alert("请先选择文件再进行签章！");
    location.href = url;
}