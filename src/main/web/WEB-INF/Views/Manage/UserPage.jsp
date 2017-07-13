<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2016/6/11
  Time: 9:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <title>用户管理</title>
    <script type="text/javascript" src="<%=contextPath%>/resources/librarys/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>

</head>
<script type="text/javascript">
    var username = sessionStorage.getItem("username");
    if(username == null){
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }

    function addUser() {

        $('#submit').attr("onclick","checkUser()");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增用户');
        $('#roleid').combobox({

            url: '<%=contextPath%>/Role/GetRole',

            valueField: 'id',

            textField: 'name'
        });
    }

    function checkUser() {
        if(!$("#fm").form('validate')){

            alert("填写的信息有误，请重新填写!");
            return false;
        }
        var roleid;
        var formData = new FormData();
        var name = $.trim($("input[name='name']")[0].value);
        var password = $.trim($("input[name='password']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        formData.append("roleid", $('#roleid').combobox('getValue'));
        formData.append("name", name);
        formData.append("password", password);
        formData.append("explain", explain);
        if (name && password && explain) {
            if (name != null && name != "") {
                validateUser(name);
            }
            $.ajax({
                url: "<%=contextPath%>/User/Add",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert(data);
                    //alert("添加成功");
                },
                error: function (data) {

                }
            });
        }
        else {
            alert("必填项不能为空!");
        }
    }

    function editcheckUser() {
        if(!$("#fm").form('validate')){

            alert("填写的信息有误，请重新填写!");
            return false;
        }
        var formData = new FormData();
        var roleid;
        var row = $("#table").datagrid('getSelected');
        var id = row.id;
        var name = $.trim($("input[name='name']")[0].value);
        var password = $.trim($("input[name='password']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        formData.append("id", id);
        formData.append("roleid", $('#roleid').combobox('getValue'));
        formData.append("name", name);
        formData.append("password", password);
        formData.append("explain", explain);
        if (name && password && explain) {
            if (name != null && name != "") {
                validateUser(name);
            }
            $.ajax({
                url: "<%=contextPath%>/User/Edit",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert(data);
                    //alert("修改用户成功");
                },
                error: function (data) {

                }
            });

        }
        else {
            alert("必填项不能为空!");
        }
    }

    function editUser() {
        var row = $("#table").datagrid('getSelected');
        if (row != null) {
            var id = row.id;
            $('#submit').attr("onclick", "editcheckUser()");
            var row = $("#table").datagrid('getSelected');

            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改用户');
            $('#roleid').combobox({

                url: '<%=contextPath%>/Role/GetRole',

                valueField: 'id',

                textField: 'name'
            });
            $("#fm").form("load", row);
        } else {
            alert("请选择用户!");
        }
    }

    function getRoles() {

        $.ajax({

            type: 'post',

            url: '<%=contextPath%>/Role/GetRole',

            dataType: 'JSON',

            success: function (data) {

                var json = eval(data);

                alert(json.length);
                if (json.length != 0) {
                    for (var i = 0; i < json.length; i++) {
                        alert(json[i].id);

                    }
                    $("#roleid").combobox('loadData', json);
                }


            },

            error: function () {

                alert("error")

            }
        });
    }

    function deleteUser() {

        var formData = new FormData();
        var row = $("#table").datagrid('getSelected');
        if (row != null) {
            var id = row.id;
            formData.append("id", id);

            $.ajax({
                url: "<%=contextPath%>/User/Delete",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    alert(data);
                    return false;
                },
                error: function (data) {

                }
            });
        }
        else {
            alert("请选择用户!");
        }
    }
    $.extend($.fn.validatebox.defaults.rules, {
        password: {
            validator: function(value,param){
                if (value){
                    return /^([a-zA-Z/u00A1-uFFFF0-9])*$/.test(value);
                } else {
                    return true;
                }

            },
            message: '只能输入字母和数字!'
        }
    });

    function validateUser(name) {

        $.ajax({
            url: '<%=contextPath%>/User/validateUser?name=' + name,
            type: "post",
            dataType: 'JSON',
            data: {name: name},
            success: function (data) {
                //已经存在该名字提示用户
                if (data == "success") {
                    // alert('可以使用');
                    $("#userspan").html(data);
                    $("#submit").attr("disabled",false);
                } else {
                    // alert('不可以使用');
                    $("#userspan").html(data);
                    $("#submit").attr("disabled",true);
                }
            }, error: function (data) {

            }
        });
    }
</script>
<body>
<script type="text/javascript">
</script>
<label for="zhan">数据维护</label>
<input class="easyui-combobox" id="zhan" name="zhan"/>&nbsp;
<h2 id="title">数据管理模块</h2><br/>

<table id="table" class="easyui-datagrid" style="width:100%;height:auto"
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'<%=contextPath%>/User/Get',method:'post'">
    <thead>
    <tr>
        <th field="id" width=auto>ID</th>
        <th field="role" width=auto>权限</th>
        <th field="name" width=auto>用户名</th>
        <th field="password" width=auto>密码</th>
        <th field="explain" width=auto>备注</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addUser()">新增用户
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改用户
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">移除用户</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">用户</div>
    <form id="fm" method="post" novalidate="false">

        <div class="fitem">
            <label>权限</label>
            <input id="roleid"  name="roleid"  class="easyui-combobox"   data-options="valueField:'id',textField:'text'" required="true"  style="width:160px;"   >
        </div>
        <div class="fitem">
            <label>用户名</label>
            <input type="text" id="name" name="name" class="easyui-textbox"  data-options="missingMessage:'请输入用户名',validType:'check'" required="true" autofocus>
            <span id="userspan"></span>
        </div>
        <div class="fitem">
            <label>密码</label>
            <input name="password" class="easyui-textbox" data-options="missingMessage:'请输入密码',validType:'password'" required="true">
        </div>
        <div class="fitem">
            <label>备注</label>
            <input name="explain" class="easyui-textbox" required="true">
        </div>
    </form>
</div>
<div id="dlg-buttons">
    <a id="submit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok"

       style="width:90px">Save</a>
    <a id="cancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlg').dialog('close')" style="width:90px">Cancel</a>
</div>

<style type="text/css">
    #fm {
        margin: 0;
        padding: 10px 30px;
    }

    .ftitle {
        font-size: 14px;
        font-weight: bold;
        margin-bottom: 10px;
        border-bottom: 1px solid #ccc;
    }

    .fitem {
        margin-bottom: 5px;
    }

    .fitem label {
        display: inline-block;
        width: 80px;
    }

    .fitem input {
        width: 160px;
    }
</style>


</body>
</html>