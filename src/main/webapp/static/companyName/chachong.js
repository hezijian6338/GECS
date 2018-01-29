/**
 * Created by xucaikai on 2018\1\29 0029.
 * 用于公司名称查重
 */
//查重
function automatic(t) {
    $(".bg-model").fadeTo(300, 1);
    //隐藏窗体的滚动条
    $("body").css({"overflow": "hidden"});
    setTimeout(function () {

        $(".bg-model").hide();
        //显示窗体
        $("body").css({"overflow":"hidden"});

    },2000);
}

$(document).on("change",'select#combination',function () {
    var va = $("#combination option:selected").val();
    if(va==2) {
        var tableCom =document.getElementById("tableCombination");
        var th1 = tableCom.getElementsByTagName("td")[1].id;
        var th11 = tableCom.getElementsByTagName("td")[2].id;
        var th2 = tableCom.getElementsByTagName("td")[3].id;
        var th22 = tableCom.getElementsByTagName("td")[4].id;
        var th3 = tableCom.getElementsByTagName("td")[5].id;
        var th33 = tableCom.getElementsByTagName("td")[6].id;

        var th5 = tableCom.getElementsByTagName("tr")[1].cells[0].id;
        var th55 = tableCom.getElementsByTagName("tr")[1].cells[1].id;
        var th6 = tableCom.getElementsByTagName("tr")[1].cells[2].id;
        var th66 = tableCom.getElementsByTagName("tr")[1].cells[3].id;
        var th7 = tableCom.getElementsByTagName("tr")[1].cells[4].id;
        var th77 = tableCom.getElementsByTagName("tr")[1].cells[5].id;

        //标题
        $("#th1").hide();
        $("#th11").show();
        $("#th2").hide();
        $("#th22").show();
        $("#th3").show();
        $("#th33").hide();

        //列内容
        $("#th5").hide();
        $("#th55").show();
        $("#th6").hide();
        $("#th66").show();
        $("#th7").show();
        $("#th77").hide();

        $("#contentDiv").show();

        var tempName =tableCom.getElementsByTagName("tr")[1].cells[1].innerHTML
            +'('+tableCom.getElementsByTagName("tr")[1].cells[3].innerHTML+')'
            +tableCom.getElementsByTagName("tr")[1].cells[4].innerHTML+'有限责任公司';

        //修改合成的名称
        var obj = document.getElementById("combinationName");
        obj.innerText = tempName;

    } else if(va==1) {

        var tableCom =document.getElementById("tableCombination");
        var th1 = tableCom.getElementsByTagName("td")[1].id;
        var th11 = tableCom.getElementsByTagName("td")[2].id;
        var th2 = tableCom.getElementsByTagName("td")[3].id;
        var th22 = tableCom.getElementsByTagName("td")[4].id;
        var th3 = tableCom.getElementsByTagName("td")[5].id;
        var th33 = tableCom.getElementsByTagName("td")[6].id;

        var th5 = tableCom.getElementsByTagName("tr")[1].cells[0].id;
        var th55 = tableCom.getElementsByTagName("tr")[1].cells[1].id;
        var th6 = tableCom.getElementsByTagName("tr")[1].cells[2].id;
        var th66 = tableCom.getElementsByTagName("tr")[1].cells[3].id;
        var th7 = tableCom.getElementsByTagName("tr")[1].cells[4].id;
        var th77 = tableCom.getElementsByTagName("tr")[1].cells[5].id;

        //标题
        $("#th1").show();
        $("#th11").hide();
        $("#th2").show();
        $("#th22").hide();
        $("#th3").show();
        $("#th33").hide();

        //列内容
        $("#th5").show();
        $("#th55").hide();
        $("#th6").show();
        $("#th66").hide();
        $("#th7").show();
        $("#th77").hide();

        $("#contentDiv").hide();

        var tempName =tableCom.getElementsByTagName("tr")[1].cells[0].innerHTML
            +tableCom.getElementsByTagName("tr")[1].cells[2].innerHTML
            +tableCom.getElementsByTagName("tr")[1].cells[4].innerHTML+'有限责任公司';

        //修改合成的名称
        var obj = document.getElementById("combinationName");
        obj.innerText = tempName;
    }
    else{

        var tableCom =document.getElementById("tableCombination");
        var th1 = tableCom.getElementsByTagName("td")[1].id;
        var th11 = tableCom.getElementsByTagName("td")[2].id;
        var th2 = tableCom.getElementsByTagName("td")[3].id;
        var th22 = tableCom.getElementsByTagName("td")[4].id;
        var th3 = tableCom.getElementsByTagName("td")[5].id;
        var th33 = tableCom.getElementsByTagName("td")[6].id;

        var th5 = tableCom.getElementsByTagName("tr")[1].cells[0].id;
        var th55 = tableCom.getElementsByTagName("tr")[1].cells[1].id;
        var th6 = tableCom.getElementsByTagName("tr")[1].cells[2].id;
        var th66 = tableCom.getElementsByTagName("tr")[1].cells[3].id;
        var th7 = tableCom.getElementsByTagName("tr")[1].cells[4].id;
        var th77 = tableCom.getElementsByTagName("tr")[1].cells[5].id;

        //标题
        $("#th1").hide();
        $("#th11").hide();
        $("#th2").show();
        $("#th22").hide();
        $("#th3").show();
        $("#th33").show();

        //列内容
        $("#th5").hide();
        $("#th55").show();
        $("#th6").hide();
        $("#th66").hide();
        $("#th7").show();
        $("#th77").show();

        $("#contentDiv").show();

        var tempName =tableCom.getElementsByTagName("tr")[1].cells[1].innerHTML
            +tableCom.getElementsByTagName("tr")[1].cells[4].innerHTML
            +'('+tableCom.getElementsByTagName("tr")[1].cells[5].innerHTML+')'+'有限责任公司';

        //修改合成的名称
        var obj = document.getElementById("combinationName");
        obj.innerText = tempName;
    }
});

//交换列值
function swapNode(node1,node2){
    var _parent = node1.parentNode;
    var _t1 = node1.nextSibling;
    var _t2 = node2.nextSibling;

    if(_t1){
        _parent.insertBefore(node2,_t1);
    }else {
        _parent.appendChild(node2);
    }

    if(_t2){
        _parent.insertBefore(node1,_t2);
    }else{
        _parent.appendChild(node1);
    }
}

//输入框触发事件
function comName() {
    var province = $("#province option:selected").text();
    var city = $("#city option:selected").text();
    var county = $("#county option:selected").text();
    var zihao = $("#zihao").val();
    var hangye = $("#hangye").val();
    var companyType = $("#companyType option:selected").text();

    var tempName = province+city+county+zihao+hangye+companyType;

    //修改合成的名称
    var obj = document.getElementById("finalCompanyName");
    obj.innerText = tempName;

}

$(document).on("change",'select#companyType',function () {
    comName();
});

$(document).on("change",'select#city',function () {
    comName();
});
$(document).on("change",'select#county',function () {
    comName();
});
$(document).on("change",'select#province',function () {
    comName();
});

$(document).on("change",'select#provinceCity',function () {
    var va = $("#provinceCity option:selected").val();

    if(va==1){
        $("#sheng").show();
        $("#shi").hide();
        $("#xian").hide();
        var province = $("#province option:selected").text();
        var zihao = $("#zihao").val();
        var hangye = $("#hangye").val();
        var companyType = $("#companyType option:selected").text();

        var tempName = province+zihao+hangye+companyType;

        //修改合成的名称
        var obj = document.getElementById("finalCompanyName");
        obj.innerText = tempName;
    }else if(va==2){
        $("#sheng").hide();
        $("#shi").show();
        $("#xian").hide();
        var city = $("#city option:selected").text();
        var zihao = $("#zihao").val();
        var hangye = $("#hangye").val();
        var companyType = $("#companyType option:selected").text();

        var tempName = city+zihao+hangye+companyType;

        //修改合成的名称
        var obj = document.getElementById("finalCompanyName");
        obj.innerText = tempName;
    }else if(va==3){
        $("#sheng").hide();
        $("#shi").hide();
        $("#xian").show();
    }else if(va==123){
        $("#sheng").show();
        $("#shi").show();
        $("#xian").show();
    }else if(va==12){
        $("#sheng").show();
        $("#shi").show();
        $("#xian").hide();
    }else if(va==23){
        $("#sheng").hide();
        $("#shi").show();
        $("#xian").show();
    }
});
