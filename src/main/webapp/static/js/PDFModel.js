/**
 * Created by Macx on 2017/10/30.
 */

/* 把画布内容保存到txt和图片(Mickey)*/
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

/*修改背景颜色（Mickey）*/
function changeBackgroundColor() {
    var printf = document.getElementById("printf");
    var backgroundColorSelect = document.getElementById("chosen-value");
    alert(backgroundColorSelect.value);
    //提取颜色的选择 设置背景为该颜色
    var getbackgroundColor = backgroundColorSelect.value;
    printf.style.backgroundColor = getbackgroundColor;
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

//把16进制的数字去掉1 4 7位的0
function parseZero(hexColor) {
    var first = hexColor.substring(1, 3);
    var second = hexColor.substring(4, 6);
    var third = hexColor.substring(7, 9);
    return first + second + third;
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

