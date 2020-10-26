<%--
  Created by IntelliJ IDEA.
  User: 道科
  Date: 2020/10/13
  Time: 8:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + 	request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <title>Title</title>
    <base href="<%=basePath%>">
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script>
        var string = ${requestScope.mag}
            $("#msg").html(string);
        /*页面加载完毕之后清空账号密码的内容*/
        $("#loginAct").val();
        $("#loginPwd").val();

        /*
            采用ajax发送请求是为了局部刷新msg中的信息内容
        */
        $(function () {
            $("#submitBtn").click(
                function () {
                    /*alert("hello")*/
                      login();
                }
            )
        })
        /*为当前窗口绑定一个敲击键盘的事件
        * event可以获取到我们敲击键盘时的键位*/
        $(window).keydown(function (event) {
            /*alert(event.keyCode);*/
            if (event.keyCode==13){
                login()
            }
        })
        function login() {
            var loginAct = $.trim($("#loginAct").val());
            var loginPwd = $.trim($("#loginPwd").val());
            if (loginAct==""||loginPwd==""){
                $("#msg").html("用户名或密码不能为空");
                /*如果账号密码为空则需要终止程序的运行，不需要走ajax的程序了*/
                return false;

            }
            $.ajax({
                url:"settings/user/login.do",
                data:{
                    "loginAct":loginAct,
                    "loginPwd":loginPwd
                },
                type:"post",
                dataType:"json",
                success:function (resp) {
                    if (resp.flag){
                        /*跳转到当前页面 workbench/index.jsp */
                        location.href= resp.page;
                    }else{
                        $("#msg").html(resp.msg);
                    }
                }
            })
        }
    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;height: 100%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2017&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form  class="form-horizontal" role="form" method="post">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" type="text" id="loginAct" name="loginAct" placeholder="用户名">
                </div>
                <div style=" width: 350px; position: relative;top: 20px;">
                    <input class="form-control" type="password" id="loginPwd" name="loginPwd" placeholder="密码">
                </div>
                <div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
                    <span id="msg" style="color: darkred"></span>
                </div>
                <button type="button" id="submitBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
