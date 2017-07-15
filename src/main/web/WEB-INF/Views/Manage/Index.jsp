<%@ page import="java.time.LocalDate" %>
<%--
  Created by IntelliJ IDEA.
  User: Brooks
  Date: 2015-11-28
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <title>数据管理</title>
    <script type="text/javascript" src="<%=contextPath%>/resources/librarys/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>
    <script type="text/javascript">
        var username = sessionStorage.getItem("username");
        if (username == null) {
            alert("未检测到您登录，请先登录");
            location.href = "<%=contextPath%>/";
        }
        var task;
        <%   Object  menulist;%>


        $(function () {
            var username = sessionStorage.getItem("username");
            var roleid = sessionStorage.getItem("roleid");
            $.ajax({
                url: "<%=contextPath%>/Menu/Gettest",
                type: 'POST',
                data: {
                    roleid: roleid
                },
                dataType: 'json',
                cache: false,
                success: function (data) {
                    menulist = eval(data);
                    for (var i = 0; i < menulist.length; i++) {


                        if (menulist[i].url.indexOf("ForGround") == 1) {
                            $('<img/>', {
                                src: "<%=contextPath%>/resources/images/" + menulist[i].icon,
                                title: menulist[i].name,
                                onclick: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"
                            }).appendTo($("#a"));
                            $('<br/><br/>').appendTo($("#a"));
                            $('<a />', {
                                id: "a" + i,
                                text: menulist[i].name,
                                href: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}",
                            }).appendTo($("#a"));
                            $('<br/><br/>').appendTo($("#a"));
                        }


                        if (menulist[i].url.indexOf("BackGround") == 1) {
                            $('<img/>', {
                                src: "<%=contextPath%>/resources/images/" + menulist[i].icon,
                                title: menulist[i].name,
                                onclick: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"
                            }).appendTo($("#b"));
                            $('<br/><br/>').appendTo($("#b"));
                            $('<a />', {
                                id: "a" + i,
                                text: menulist[i].name,
                                href: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"

                            }).appendTo($("#b"));

                            $('<br/><br/>').appendTo($("#b"));
                        }



                        if (menulist[i].url.indexOf("BasicManage") == 1) {
                            $('<img/>', {
                                src: "<%=contextPath%>/resources/images/" + menulist[i].icon,
                                title: menulist[i].name,
                                onclick: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"
                            }).appendTo($("#c"));
                            $('<br/><br/>').appendTo($("#c"));
                            $('<a />', {
                                id: "a" + i,
                                text: menulist[i].name,
                                href: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"
                            }).appendTo($("#c"));
                            $('<br/><br/>').appendTo($("#c"));
                        }



                        if (menulist[i].url.indexOf("AccountManage") == 1) {
                            $('<img/>', {
                                src: "<%=contextPath%>/resources/images/" + menulist[i].icon,
                                title: menulist[i].name,
                                onclick: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"
                            }).appendTo($("#d"));
                            $('<br/><br/>').appendTo($("#d"));
                            $('<a />', {
                                id: "a" + i,
                                text: menulist[i].name,
                                href: "javascript:{addTab(" +
                                "'" + menulist[i].name + "'" + "," + "'" + "<%=contextPath%>" + menulist[i].url + "'" + ")}"

                            }).appendTo($("#d"));

                            $('<br/><br/>').appendTo($("#d"));
                        }


                    }
                }
            });
        });

        function addTab(title, url) {
            if ($('#content').tabs('exists', title)) {
                $('#content').tabs('select', title);

                if (title == "") {
                    $('#layout').layout('expand', 'east');
                } else {
                    $('#layout').layout('collapse', 'east');
                }
            } else {
                if (title == "") {
                    $('#content').tabs('add', {
                        title: title,
                        href: url,
                        closable: true
                    });

                    $('#layout').layout('expand', 'east');
                } else {
                    var content = '<iframe scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:100%;"></iframe>';
                    $('#content').tabs('add', {
                        title: title,
                        content: content,
                        closable: true
                    });

                    $('#layout').layout('collapse', 'east');
                }
            }
        }

        function updateTab(title, url) {
            if ($('#content').tabs('exists', title)) {
                var tab = $('#content').tabs('getTab', title);
                $("#content").tabs('update', {
                    tab: tab,
                    options: {
                        href: url
                    }
                });
                tab.panel('refresh');
            }
        }

        function startCount(title, url) {
            updateTab(title, url);

            task = setTimeout("startCount('" + title + "', '" + url + "')", 90000);
        }
    </script>
    <style type="text/css">

        #north {
            height: 130px;
            text-align: center;
            font-size: 50px;
            vertical-align: middle;
            color: white;
            background: url("<%=contextPath%>/resources/images/login-bg-img.jpg") no-repeat;
        }

        #home {
            background: url("<%=contextPath%>/resources/images/banner.png") no-repeat;
            background-size: cover;
            padding-top: 50px;
            padding-left: 50px;
            font-size: 30px;
            color: blue;
        }

        .welcome {
            font-size: 49px;
            font-weight: bold;
            font-family: "Microsoft YaHei";
            -webkit-text-stroke: 2px #6694b9;
            letter-spacing: 3px;
            -webkit-text-fill-color: transparent;
            text-align: center;
            margin-top: 25px;
        }

        .title {
            text-align: center;
        }

        .title a {
            font-family: '微软雅黑';
            font-size: 16px;
            color: #6694b9;
            text-decoration: none;
        }

        #south {
            margin: 0 auto auto auto;
        }

        #copyright {
            text-align: center;
            vertical-align: middle;
            color: #fff;
            background: url("<%=contextPath%>/resources/images/login-bg-img.jpg") no-repeat;
            height: 100%;
            line-height: 1.6;
            font-size: 14px;
            font-family: '微软雅黑';
        }

        #north p {
            margin: 0 !important;
            line-height: 2.2;
            font-family: '微软雅黑';
            font-size: 40px;
        }

        #ordermanage img {
            width: 76px;
        }

        #visitormanage img {
            width: 76px;
        }

        #backgroundmanage img {
            width: 76px;
        }

        #accountmanage img {
            width: 76px;
        }

        .accordion .accordion-header-selected {
            background: #6694b9;
        }
    </style>
</head>
<body>
<div id="layout" class="easyui-layout" style="width:100%;height:100%;">
    <div id="north" data-options="region:'north',split:true" title="公司信息">
        <div>
            <p class="north">广泰精密冲压(苏州)有限公司</p>
        </div>
    </div>
    <div data-options="region:'west',split:true" title="功能菜单" style="width:200px;">
        <div class="easyui-accordion" data-options="fit:true,border:false">
            <div id="a" class="title" title="预约管理" data-options="selected:true" style="padding:10px;">

            </div>
            <div id="b" class="title" title="访客管理" style="padding:10px;">

            </div>
            <div id="c" class="title" title="受访管理" style="padding:10px;">

            </div>
            <div id="d" class="title" title="账户管理" style="padding:10px;">

            </div>
        </div>
    </div>
    <div data-options="region:'center'">
        <div id="content" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
            <div id="home" title="主页" style="padding:10px">
                <p class="welcome">欢迎使用本系统!</p>
            </div>
        </div>
    </div>
    <div id="south" data-options="region:'south',split:true" title="版权信息" style="height:100px;">
        <div id="copyright">
            广泰精密冲压(苏州)有限公司 版本号：V1.01<br>
            Copyright © <%=LocalDate.now().getYear()%> GuangTai.<br>
            广泰·苏州 版权所有.
        </div>
    </div>
</div>
</body>
</html>