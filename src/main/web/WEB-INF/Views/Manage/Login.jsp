<%--
  Created by IntelliJ IDEA.
  User: Brooks
  Date: 2016/11/17
  Time: 20:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<html>
<head>
    <meta charset="UTF-8">
    <title>江苏金润润滑油后台登录</title>
    <!-- bootstrap-->
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- 字体图标-->
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- 网页css-->
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/pc-index.css">
    <script type="text/javascript" src="<%=contextPath%>/resources/librarys/jquery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#btnLogin").on("click", function () {
                if ($("#txtUserName").val() == "") {
                    alert("用户名不能为空！");
                    return;
                }

                if ($("#txtPassword").val() == "") {
                    alert("密码不能为空！");
                    return;
                }

                $.ajax({
                    type: "POST",
                    url: '<%=contextPath%>' + "/Manage/ManageLogin",
                    cache: false,
                    dataType: "json",
                    data: {
                        username: $("#txtUserName").val(),
                        password: $("#txtPassword").val()
                    },
                    success: function (data) {
                        if (data.success) {
                            var json = JSON.parse(data.data);
                            sessionStorage.setItem("id",json);
                            window.location.href = "<%=contextPath%>/Manage/Index?username="+$("#txtUserName").val();
                        } else {
                            alert(data.data);
                        }
                    },
                    error: function (data) {
                        alert(data.data);
                    }
                });
            });
        });
    </script>
</head>
<body>
<div class="login">
    <p class="login-title"><img src="<%=contextPath%>/resources/images/index-pc-header-logo.png"></p>
    <div class="login-main">
        <div class="login-main-content">
            <div class="login-content fr mr30 fa">
                <div class="login-content-box">
                    <p class="login-content-title text-center">金士百润滑油<small>Jin Run lubricating Oil</small></p>
                        <div class="login-content-input form-group mt20">
                            <i class="fa fa-user login-content-icon fa-lg"></i>
                            <input id="txtUserName" class="form-control" type="text" placeholder="用户名或手机号">
                        </div>
                        <div class="login-content-input form-group mt20">
                            <i class="fa fa-lock login-content-icon fa-lg"></i>
                            <input id="txtPassword" class="form-control" type="password" placeholder="密码">
                        </div>
                        <div class="login-content-input form-group">
                            <div class="fl">
                                <div class="checkbox login-main-checkbox">
                                    <label>
                                        <input id="chkIsRemember" type="checkbox" menuname="Form[auto]" class="login-main-checkbox-size">自动登录</label>
                                </div>
                            </div>
                            <div class="fr login-main-forget"><a href="forget-password.html">忘记密码？</a> </div>
                        </div>
                        <div class="login-content-input form-group">
                            <button id="btnLogin" class="btn login-content-button mt15">登录</button>
                        </div>
                </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>