<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2016/6/7
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<html>
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <title>客户管理</title>
    <script type="text/javascript" src="<%=contextPath%>/resources/librarys/jquery/jquery-2.2.4.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>

</head>
<script type="text/javascript">
    var id;
    var username = sessionStorage.getItem("username");
    if(username == null){
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }

    function addCustomer() {


        $('#submit').attr("onclick","checkCustomer()");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增客户');

    }

    function checkCustomer() {
        var formData = new FormData();
        var name = $.trim($("input[name='name']")[0].value);
        var address = $.trim($("input[name='address']")[0].value);
        var contact = $.trim($("input[name='contact']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        formData.append("name", name);
        formData.append("address",address);
        formData.append("contact",contact);
        formData.append("explain", explain);
        if (name && address && contact && explain) {
            $.ajax({
                url: "<%=contextPath%>/Customer/Add",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert("添加客户成功!");
                },
                error: function (data) {

                }
            });


        }
        else {
            alert("必填项不能为空!");
        }
    }
    function editCustomer() {

        $('#submit').attr("onclick","editcheckCustomer()");
        var row = $("#table").datagrid('getSelected');
        id = row.id;
        if(row!=null){
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改客户');
        $("#fm").form("load",row);
    }
        else
        {
            alert("请选择客户!");
        }

    }
    function editcheckCustomer() {
        var formData = new FormData();
        var name=  $.trim($("input[name='name']")[0].value);
        var address = $.trim($("input[name='address']")[0].value);
        var contact = $.trim($("input[name='contact']")[0].value);
        var explain =      $.trim($("input[name='explain']")[0].value);
        formData.append("id",id);
        formData.append("name",name);
        formData.append("address",address);
        formData.append("contact",contact);
        formData.append("explain",explain);
        if(name && address && contact && explain)
        {
            $.ajax({
                url:"<%=contextPath%>/Customer/Edit",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert("修改客户成功!");
                },
                error: function (data) {

                }
            });


        }
        else
        {
            alert("必填项不能为空!");
        }
    }
    function deleteCustomer() {


        var formData = new FormData();
        var row = $("#table").datagrid('getSelected');
        if(row!=null){
        var id = row.id;
        formData.append("id",id);

            $.ajax({
                url:"<%=contextPath%>/Customer/Delete",
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
        else
        {
            alert("请选择客户!");
        }

    }
</script>
<body>
<script type="text/javascript">
</script>
<label for="zhan">数据维护</label>
<input class="easyui-combobox" id="zhan" name="zhan"/>&nbsp;
<h2 id="title">数据管理模块</h2><br/>

<table id="table" class="easyui-datagrid" style="width:100%;height:auto"
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'<%=contextPath%>/Customer/Get',method:'post'">
    <thead>
    <tr>
        <th field="id" width=auto>ID</th>
        <th field="name" width=auto>客户名称</th>
        <th field="address" width=auto>地址</th>
        <th field="contact" width=auto>联系人</th>
        <th field="explain" width=auto>备注</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addCustomer()">新增客户
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editCustomer()">修改客户
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteCustomer()">移除客户</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">客户</div>
    <form id="fm" method="post" novalidate="false">

        <div class="fitem">
            <label>客户名称</label>
            <input name="name" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>地址</label>
            <input name="address" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>联系人</label>
            <input name="contact" class="easyui-textbox" required="true">
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
