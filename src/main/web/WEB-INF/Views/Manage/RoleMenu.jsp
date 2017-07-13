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
    <title>权限菜单管理</title>
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
    if(username==null){
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }


    function addRoleMenu() {


        $('#submit').attr("onclick","checkRoleMenu()");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增权限菜单');
        $('#roleid').combobox({

            url: '<%=contextPath%>/Role/GetRole',

            valueField: 'id',

            textField: 'name'
        });
        $('#menuid').combobox({

            url: '<%=contextPath%>/Menu/Get',

            valueField: 'id',

            textField: 'name'
        });
    }

    function checkRoleMenu() {
        var roleid;
        var menuid;
        var formData = new FormData();
        var serial = $.trim($("input[name='serial']")[0].value);
        var describes = $.trim($("input[name='describes']")[0].value);
        formData.append("roleid",$('#roleid').combobox('getValue'));
        formData.append("menuid",$('#menuid').combobox('getValue'));
        formData.append("serial",serial);
        formData.append("describes", describes);
        if (serial && describes) {
            $.ajax({
                url: "<%=contextPath%>/RoleMenu/Add",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert(data);
                },
                error: function (data) {
                    alert(data);
                }
            });


        }
        else {
            alert("必填项不能为空!");
        }
    }
    function editRoleMenu() {

        $('#submit').attr("onclick", "editcheckRoleMenu()");
        var row = $("#table").datagrid('getSelected');

        if (row != null) {
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改权限菜单');
            $('#roleid').combobox({

                url: '<%=contextPath%>/Role/GetRole',

                valueField: 'id',

                textField: 'name'
            });
            $('#menuid').combobox({

                url: '<%=contextPath%>/Menu/Get',

                valueField: 'id',

                textField: 'name'
            });
            $("#fm").form("load", row);
        }
        else {
            alert("请选择权限菜单!");
        }
    }
    function editcheckRoleMenu() {
        var roleid;
        var menuid;
        var formData = new FormData();
        var serial = $.trim($("input[name='serial']")[0].value);
        var describes = $.trim($("input[name='describes']")[0].value);
        formData.append("roleid",$('#roleid').combobox('getValue'));
        formData.append("menuid",$('#menuid').combobox('getValue'));
        formData.append("serial",serial);
        formData.append("describes", describes);
        if (serial && describes) {
            $.ajax({
                url: "<%=contextPath%>/RoleMenu/Edit",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    if(data=="Success") {
                        alert("修改权限菜单成功!");
                    }
                    else {
                        alert("修改权限菜单失败，请重新输入!");
                    }
                    return false;
                },
                error: function (data) {
                    alert("修改失败!");
                    return false;
                }
            });


        }
        else {
            alert("必填项不能为空!");
        }
        return;
    }
    function getRoles() {

        $.ajax({

            type: 'post',

            url: '<%=contextPath%>/Role/Get',

            dataType: 'JSON',

            success: function (data) {

                var json = eval(data);

                //alert(json.length);
                if (json.length != 0) {
                    for (var i = 0; i < json.length; i++) {
                       // alert(json[i].id);

                    }
                    $("#roleid").combobox('loadData', json);
                }


            },

            error: function () {

                alert("error")

            }
        });
    }
    function getMenus() {

        $.ajax({

            type: 'post',

            url: '<%=contextPath%>/Menu/Get',

            dataType: 'JSON',

            success: function (data) {

                var json = eval(data);

                //alert(json.length);
                if (json.length != 0) {
                    for (var i = 0; i < json.length; i++) {
                        //alert(json[i].id);

                    }
                    $("#menuid").combobox('loadData', json);
                }


            },

            error: function () {

                alert("error")

            }
        });
    }
    function deleteRoleMenu() {


        var formData = new FormData();
        var row = $("#table").datagrid('getSelected');
        if (row != null) {
            var roleid = row.rolemenuPK.roleid;
            var menuid = row.rolemenuPK.menuid;
            //alert(roleid+","+menuid);
            formData.append("roleid", roleid);
            formData.append("menuid", menuid);
            $.ajax({
                url: "<%=contextPath%>/RoleMenu/Delete",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    alert("删除权限菜单成功!");
                },
                error: function (data) {
                    alert("删除失败!");
                }
            });
        }
        else {
            alert("请选择权限菜单!");
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
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'<%=contextPath%>/RoleMenu/Get',method:'post'">
    <thead>
    <tr>
        <th data-options="field:'roleid',
                                  formatter:function(val,row)
                                  {
                                  return row.rolemenuPK.roleid;
                                   }
                                  ">权限id</th>
        <th field="role" width=auto>权限</th>
        <th data-options="field:'menuid',
                                  formatter:function(val,row)
                                  {
                                  return row.rolemenuPK.menuid;
                                   }
                                  ">菜单id</th>
        <th field="menu"width=auto>菜单</th>
        <th field="serial" width=auto>序号</th>
        <th field="describes" width=auto>备注</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addRoleMenu()">新增权限菜单
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteRoleMenu()">移除权限菜单</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">权限菜单</div>
    <form id="fm" method="post" novalidate="false">
        <div class="fitem">
            <label>权限</label>
            <input id="roleid"  name="roleid"  class="easyui-combobox"    required="true"  style="width:160px;"   >
        </div>
        <div class="fitem">
            <label>菜单</label>
            <input id="menuid"  name="menuid"  class="easyui-combobox"    required="true"  style="width:160px;"   >
        </div>
        <div class="fitem">
            <label>序号</label>
            <input name="serial"  class="easyui-numberbox" data-options="missingMessage:'请输入数字'" required="true">
        </div>
        <div class="fitem">
            <label>备注</label>
            <input name="describes" class="easyui-textbox" required="true">
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