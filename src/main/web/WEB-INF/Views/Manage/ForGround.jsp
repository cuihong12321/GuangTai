<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDate" %>
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
</head>
<body>

<script type="text/javascript">

    var username = sessionStorage.getItem("username");
    if(username==null){
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }
    var task;
    <%   Object  menulist;%>

    $(function () {
        $.ajax({
            url: "<%=contextPath%>/Menu/Gettest",
            type: 'GET',
            dataType: 'json',
            cache: false,
            contentType: false,
            processData: false,
            success: function (data) {
                menulist =eval(data);
                $('#a').accordion('add',{
                    class:'div',
                    id:'div1'

                });
                for(var i =0;i<menulist.length;i++)
                {
                    $('<a />',{
                        id:"a"+i,
                        text:menulist[i].name,
                        href:"javascript:{addTab(" +
                        "'"+ menulist[i].name+"'"+","+"'"+menulist[i].url+"'"+")}"

                    }).appendTo($("#div1"));

                }

            }

        });

    });
    function addTab(title, url) {
        alert("title:"+title+" url:"+url);
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
    #l-map {
        height: 100%;
        width: 100%;
        margin: 0;
        font-family: "微软雅黑";
    }

    .station-panel {
        width: 400px;
    }

    #north {
        height: 130px;
        text-align: center;
        font-size: 20px;
        vertical-align: middle;
        color: white;
        background: url("<%=contextPath%>/resources/images/5.jpg") no-repeat;
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
        -webkit-text-stroke: 2px #008ed4;
        letter-spacing: 3px;
        -webkit-text-fill-color: transparent;
        text-align: center;
        margin-top: 25px;
    }

    .panel-title {
        font-size: 15pt;
    }

    .title {
        text-align: center;
    }

    .title a {
        text-decoration: none;
    }

    #south {
        margin: 0 auto auto auto;
    }

    #copyright {
        text-align: center;
        vertical-align: middle;
        color: white;
        background: url("<%=contextPath%>/resources/images/6.jpg") no-repeat;
    }
</style>
<div id="layout" class="easyui-layout" style="width:100%;height:100%;">
    <div data-options="region:'west',split:true" title="功能菜单" style="width:200px;">
        <div id="a" class="easyui-accordion" data-options="fit:true,border:false">

            <c:forEach var="menu" items="${menulist}">

                <a href="javascript:addTab(menu.name , menu.url);">
                    menu.name
                </a><br/><br/>
            </c:forEach>

        </div>
    </div>
    <div data-options="region:'center'">
        <div id="content" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
            <div id="home" title="主页" style="padding:10px">
                <p class="welcome">欢迎使用本系统!</p>
            </div>
        </div>
    </div>
    <div id="south" data-options="region:'south',split:true" title="版权信息" style="height:80px;">
        <div id="copyright">
            太仓龙宇运输有限公司 版本号：V1.01<br>
            Copyright © <%=LocalDate.now().getYear()%> Sinocharge.<br>
            太仓龙宇 版权所有.
        </div>
    </div>
</div>
</body>
</html>