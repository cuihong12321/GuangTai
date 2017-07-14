<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2016/6/29
  Time: 16:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>广泰精密后台登录</title>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/font-awesome-4.5.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/css/css.css">
    <script type="text/javascript" src="<%=contextPath%>/resources/librarys/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>
</head>
<style>
    .login-content-description{
        padding:0;
        text-align: center;
        margin: 0;
        margin-top: 300px;
    }
</style>
<script type="text/javascript">

    $(document).ready(function () {
        $("#loginbtn").click(function () {

            var username = $("#username").val();
            var password = $("#password").val();
            if (username == "") {
                alert("用户名不能为空!");
                return;
            }
            if (password == "") {
                alert("密码不能为空!");
                return;
            }
            $.ajax({
                url: "<%=contextPath%>/Manage/ManageLogin",
                type: 'POST',
                dataType: "json",
                cache: false,
                data: {
                    username: username,
                    password: password
                },
                success: function (data) {
                    if (data.success) {
                        sessionStorage.setItem("roleid", data.user.roleid);
                        sessionStorage.setItem("id", data.user.id);
                        sessionStorage.setItem("username", data.user.username);
                        window.location.href = "<%=contextPath%>/Manage/Index?username=" + username;
                    } else {
                        alert(data.data);
                    }
                },
                error: function (data) {
                    alert(data.data);
                }
            });
        });
        $("#resetbtn").click(function () {
            $('#ff').div('clear');
        });
    });


</script>
<body style="min-width: 1200px;">
<div>

</div>
<!--内容-->
<div class="login-background-box">
    <div class="login-content">
        <div class="login-content-description">
            <div id="ff">
                <div class="login-content-input form-group">
                    <h1 style="text-align: center">用户登录</h1>
                </div>
                <div class="login-content-input form-group">
                    <i class="fa fa-user login-content-icon fa-lg"></i>
                    <input type="text" id="username" name="username" class="form-control" placeholder="请输入用户名">
                    <span id="userspan"></span>
                </div>
                <div class="login-content-input form-group">
                    <i class="fa fa-lock login-content-icon fa-lg"></i>
                    <input type="password" id="password" name="password" class="form-control" placeholder="请输入密码">
                    <span id="pswspan"></span>
                </div>
                <div class="login-content-input form-group">
                    <div class="fl">
                        <div class="checkbox login-main-checkbox">
                            <label>
                                <input type="checkbox" name="Form[auto]" class="login-main-checkbox-size">自动登录
                            </label>
                        </div>
                    </div>
                    <div class="fl fr">
                        <div class="checkbox login-main-checkbox fr">
                            <div class="login-main-forget fr"><a href="#">忘记密码？</a></div>
                        </div>
                    </div>

                </div>
                <div class="login-content-input form-group">
                    <button id="loginbtn" class="btn login-content-button mt15">登录</button>
                    <button id="resetbtn" class="btn login-content-button mt15">重置</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>