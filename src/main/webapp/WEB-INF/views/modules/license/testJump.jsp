<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
    <title>跳转页面</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        function a(){//json数据
            /*
            1.idcertificateCode：统一社会信用代码，例如：61553949P310WL0976
            2.idcertificateName：公司名称，例如：李四技术有限公司
            3.idregisteredType：公司类型，例如：技术有限公司
            4.idaddress：公司地址，例如：广东省珠海市香洲区南油大酒店
            5.idpersionName：法人姓名，例如;张三
            6.idregisteredCapital：注册资本，例如：100万
            7.idestablishDate：成立日期，例如：格式（2017-02-30，注：2017年2月3日一定要写成-》2017-02-03）
            8.ideffectiveDateStar：有效起始日期，例如：格式（2017-02-30，注：2017年2月3日一定要写成-》2017-02-03）
            9.ideffectiveDateEnd：有效终止日期,例如;格式（2017-02-30，注：2017年2月3日一定要写成-》2017-02-03）
            10.idscope：经营范围，例如：家政服务咨询，电脑网络软件开发等。
            11.idoffice:登记机关，例如；珠海工商局
            */
            var jsonStr=[{"idcertificateCode":"123","idcertificateName":"李四技术有限公司","idregisteredType":"技术有限公司",
                "idaddress":"广东省珠海市香洲区南油大酒店","idpersionName":"张三","idregisteredCapital":"100万","idestablishDate":"2017-02-30",
                "ideffectiveDateStar":"2017-02-30","ideffectiveDateEnd":"2017-03-30","idscope":"五金店","idoffice":"珠海工商局"}];

            $.ajax({
                type:"post",//post请求
                url:"http://192.168.8.117:8081/f/getTemplate",//请求地址
                dataType:"json",//数据类型json
                data:{'mydata':JSON.stringify(jsonStr)},//id,必须为"mydata"
                success:function (result) {
                    console.log(result);
                    alert(result.downLoadPath);
                },
                error:function () {
                    alert("生成失败，请检查您的json数据格式！");
                }
            });
        }

    </script>
</head>
<body>
<input id="btnSend" class="btn btn-primary input-medium" type="button" value="发送"  onclick="a()"/>
</body>
</html>
