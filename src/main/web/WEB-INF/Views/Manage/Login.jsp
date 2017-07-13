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
    <title>龙宇运输后台登录</title>
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
<script type="text/javascript">

    $(document).ready(function () {
        $("#loginbtn").click(function () {

            var formData = new FormData();
            var username = $.trim($("input[name='username']")[0].value);
            var password = $.trim($("input[name='password']")[0].value);
            formData.append("username", username);
            formData.append("password", password);
            if ($("input[name='name']").val() == "") {
                alert("用户名不能为空!");
                return false;
            }
            else if ($("input[name='password']").val() == "") {
                alert("密码不能为空!");
                return false;
            } else {
                $.ajax({
                    url: "<%=contextPath%>/Manage/ManageLogin",
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {

                        if (data=="2") {

                            alert("用户名或密码错误!");
                            location.href = "/";
                            return false;

                        } else {

                            var json = eval("("+data+")");
                            sessionStorage.setItem("username",json.username);
                            sessionStorage.setItem("roleid",json.roleid);
                            sessionStorage.setItem("id",json.id);
                            alert("登录成功!");
                            sessionStorage.setItem("username",username);
                            location.href = "<%=contextPath%>/Manage/Index";


                            return false;
                        }

                    },
                    error: function (data) {

                    }
                });

            }
            return false;
        });
        $("#resetbtn").click(function () {
            $('#ff').form('clear');
        });
    });


</script>
<body style="min-width: 1200px;">
<!--头部-->

<header class="login-head">
    <img src="<%=contextPath%>/resources/images/logo.png">
    <span class="vm">太仓龙宇运输有限公司</span>
</header>
<!--内容-->
<div class="login-background-box">
    <div class="login-background-box-img">
        <img src="<%=contextPath%>/resources/images/login-bg-img.jpg">
    </div>
    <div class="login-content">
        <div class="login-content-description fr">
            <form id="ff" method="post">
                <p>用户登录</p>
                <div class="login-content-input form-group">
                    <i class="fa fa-user login-content-icon fa-lg"></i>
                    <input type="text" id="username" name="username" class="form-control"  placeholder="请输入用户名">
                    <span id="userspan"></span>
                </div>
                <div class="login-content-input form-group">
                    <i class="fa fa-lock login-content-icon fa-lg"></i>
                    <input type="password" id="password" name="password" class="form-control"  placeholder="请输入密码">
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
                    <div class="fr login-main-forget"><a href="#">忘记密码？</a> </div>
                </div>
                <div class="login-content-input form-group">
                    <button id="loginbtn"  class="btn login-content-button mt15">登录</button>
                    <button id="resetbtn"  class="btn login-content-button mt15">重置</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>