<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2016/6/6
  Time: 15:56
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

    <title>Title</title>
</head>
<script type="text/javascript">
    var username = sessionStorage.getItem("username");
    if (username == null) {
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }


    function addOrder() {

        var url = "<%=contextPath%>/Customer/GetCustomer";
        $('#customercombo').attr("url", url);
        $('#customercombo').combobox("reload", url);

        url = "<%=contextPath%>/Factory/GetFactory";
        $('#factorycombo').attr("url", url);
        $('#factorycombo').combobox("reload", url);

        url = "<%=contextPath%>/ContainerType/GetContainerType";
        $('#container').attr("url", url);
        $('#container').combobox("reload", url);

        $('#submit').attr("onclick", "checkaddOrder()");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增运单');

    }
    function Commit() {
        var container;
        var flag = true;
        var formData = new FormData();
        var rows = $('#table').datagrid('getSelections');
        var entities = "";
        if (rows != null && rows.length > 0) {
            for (i = 0; i < rows.length; i++) {
                entities = entities + JSON.stringify(rows[i]);
                container = rows[i].container;
            }
            formData.append("entities", entities);
            if (flag) {
                $.ajax({
                    url: "<%=contextPath%>/Order/Commit",
                    type: 'POST',
                    dataType: 'json',
                    cache: false,
                    contentType: false,
                    processData: false,
                    data: formData,
                    success: function (data) {
                        if (data == "success") {
                            alert("签入成功!");
                            deleteOrder();
                            return false;
                        } else {
                            alert("签入失败!");
                            return false;
                        }
                    }
                });
            }
            return false;
        }
        else {
            alert("请选择需签入行!");
            return false;
        }

    }

    function checkaddOrder() {
        var customerid = $.trim($("#customercombo").combobox('getValue'));
        var factoryid = $.trim($("#factorycombo").combobox('getValue'));
        var containerid = $.trim($("#container").combobox('getValue'));
        var makingtime = $.trim($("input[name='makingtime']")[0].value);
        var customer = $.trim($("#customercombo").combobox('getText'));
        var factory = $.trim($("#factorycombo").combobox('getText'));
        var container = $.trim($("#container").combobox('getText'));
        var billnumber = $.trim($("input[name='billnumber']")[0].value);
        var customerworknumber = $.trim($("input[name='customerworknumber']")[0].value);
        var cabinetnumber = '柜号未定';
        var sealnumber = '封条号未定';
        var number = $.trim($("input[name='number']")[0].value);
        var orderworknumber = guid();
        var explain = $.trim($("input[name='explain']")[0].value);
        var operatorid = sessionStorage.getItem("id");
        var operator = sessionStorage.getItem("username");
        if (customer && factory && container && billnumber && customerworknumber && cabinetnumber && sealnumber && explain && makingtime) {
            if (number > 0) {
                for (var i = 0; i < number; i++) {
                    $("#table").datagrid('appendRow', {
                        customer: customer,
                        factory: factory,
                        container: container,
                        makingtime: makingtime,
                        customerid: customerid,
                        factoryid: factoryid,
                        containerid: containerid,
                        billnumber: billnumber,
                        customerworknumber: customerworknumber,
                        cabinetnumber: cabinetnumber,
                        sealnumber: sealnumber,
                        orderworknumber: orderworknumber,
                        operator: operator,
                        operatorid: operatorid,
                        explain: explain
                    });
                }

            }
            else {
                alert("数量不正确!")
            }
            $('#dlg').dialog('close');

        }
        else {

            alert("请完整填写运单!")
        }
    }

    function editOrder() {
        var rows = $('#table').datagrid('getSelections');
        if (rows != null && rows.length == 1) {
            $('#submit').attr("onclick", "editcheckOrder()");
            var row = $("#table").datagrid('getSelected');

            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改运单');
            $("#fm").form("load", row);

        }
        else {
            alert("一次只可修改一条运单,请正确选择运单!");
        }
    }
    function editcheckOrder() {
        var row = $("#table").datagrid('getSelected');
        var customerid = $.trim($("#customercombo").combobox('getValue'));
        var factoryid = $.trim($("#factorycombo").combobox('getValue'));
        var containerid = $.trim($("#container").combobox('getValue'));
        var makingtime = $.trim($("input[name='makingtime']")[0].value);
        var customer = $.trim($("#customercombo").combobox('getText'));
        var factory = $.trim($("#factorycombo").combobox('getText'));
        var container = $.trim($("#container").combobox('getText'));
        var billnumber = $.trim($("input[name='billnumber']")[0].value);
        var customerworknumber = $.trim($("input[name='customerworknumber']")[0].value);
        var cabinetnumber = row.cabinetnumber;
        var sealnumber = row.sealnumber;
        var explain = $.trim($("input[name='explain']")[0].value);
        var operatorid = sessionStorage.getItem("id");
        var operator = sessionStorage.getItem("username");
        if (customer && factory && container && billnumber && customerworknumber && cabinetnumber && sealnumber && explain && makingtime) {
            var index = $("#table").datagrid('getRowIndex', row);
            $("#table").datagrid('updateRow', {
                index: index,
                row: {
                    customer: customer,
                    factory: factory,
                    container: container,
                    makingtime: makingtime,
                    customerid: customerid,
                    factoryid: factoryid,
                    containerid: containerid,
                    billnumber: billnumber,
                    customerworknumber: customerworknumber,
                    cabinetnumber: cabinetnumber,
                    sealnumber: sealnumber,
                    operator: operator,
                    operatorid: operatorid,
                    explain: explain
                },
            });


        }
        else {
            alert("必填项不能为空!");
        }
        $('#dlg').dialog('close');
        alert("修改成功!");
    }
    function deleteOrder() {


        var formData = new FormData();
        var rows = $('#table').datagrid('getSelections');
        if (rows != null && rows.length > 0) {
            for (i = 0; i < rows.length; i++) {
                var index = $("#table").datagrid('getRowIndex', rows[i]);
                $('#table').datagrid('deleteRow', index);
            }
        }


        else {
            alert("请选择运单!");
        }


    }

    function guid() {

        function S4() {

            return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);

        }

        return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());

    }

    function updatewaybill() {


        var rows = $('#table').datagrid('getSelections');
        if (rows != null && rows.length == 1) {
            $('#updatesubmit').attr("onclick", "updateOrder()");


            var row = $("#table").datagrid('getSelected');
            $('#dlgupdate').dialog('open').dialog('center').dialog('setTitle', '完善运单');
            $("#forms").form("load", row);
        }
        else {
            alert("一次只可完善一条运单,请正确选择运单!");
        }
    }
    function updateOrder() {
        var row = $("#table").datagrid('getSelected');
        var cabinetnumber = $.trim($("input[name='cabinetnumber']")[0].value);
        var sealnumber = $.trim($("input[name='sealnumber']")[0].value);
        if (cabinetnumber && sealnumber) {

            var row = $("#table").datagrid('getSelected');
            var index = $("#table").datagrid('getRowIndex', row);
            $("#table").datagrid('updateRow', {
                index: index,
                row: {
                    cabinetnumber: cabinetnumber,
                    sealnumber: sealnumber
                },
            });


        }
        else {
            alert("必填项不能为空!");
        }
        $('#dlgupdate').dialog('close');
        alert("完善成功!");
    }

    function myformatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
    }

    function myparser(s) {
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(y, m - 1, d);
        } else {
            return new Date();
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
       singleSelect="false"
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'',method:'post'">
    <thead>
    <tr>
        <th field="ck" checkbox="true" width=10%>选中</th>
        <th field="customer" width=15%>客户</th>
        <th field="factory" width=15%>工厂</th>
        <th field="container" width=10%>箱形</th>
        <th field="makingtime" width=10%>做箱时间</th>
        <th field="billnumber" width=15%>提单号</th>
        <th field="customerworknumber" width=10%>客户工作号</th>
        <th field="orderworknumber" width=15%>运单工作号</th>
        <th field="operator" width=auto>操作员</th>
        <th field="explain" width=10%>备注</th>
        <th field="cabinetnumber" width=10%>柜号</th>
        <th field="sealnumber" width=10%>封条号</th>
        <th field="customerid" width=auto hidden="true">客户ID</th>
        <th field="factoryid" width=auto hidden="true">工厂ID</th>
        <th field="containerid" width=auto hidden="true">箱形ID</th>
        <th field="operatorid" width=auto hidden="true">操作员ID</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addOrder()">新增运单
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editOrder()">修改运单
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true"
       onclick="deleteOrder()">移除运单</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updatewaybill()">完善运单
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="Commit()"
    >签入运单</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">运单</div>
    <form id="fm" method="post" novalidate="false">

        <div class="fitem">
            <label>客户</label>
            <input name="customerid" id="customercombo" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Customer/GetCustomer" required="true">
        </div>
        <div class="fitem">
            <label>工厂</label>
            <input name="factoryid" id="factorycombo" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Factory/GetFactory" required="true">
        </div>

        <div class="fitem">
            <label>箱形</label>
            <input name="containerid" id="container" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/ContainerType/GetContainerType" required="true">
        </div>

        <div class="fitem">
            <label>做箱时间</label>
            <input name="makingtime" id="makingtime" class="easyui-datebox" editable="false"
                   data-options="formatter:myformatter,parser:myparser" required="true">
        </div>

        <div class="fitem">
            <label>提单号</label>
            <input name="billnumber" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>客户工作号</label>
            <input name="customerworknumber" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>数量</label>
            <input name="number" class="easyui-numberbox" value="1" data-options="missingMessage:'请输入数字'"
                   required="true">
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


<div id="dlgupdate" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlgupdate-buttons">
    <div class="ftitle">运单</div>
    <form id="forms" method="post" novalidate="false">
        <div class="fitem">
            <label>柜号</label>
            <input name="cabinetnumber" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>封条号</label>
            <input name="sealnumber" class="easyui-textbox" required="true">
        </div>

    </form>
</div>
<div id="dlgupdate-buttons">
    <a id="updatesubmit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok"

       style="width:90px">Save</a>
    <a id="updatecancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlgupdate').dialog('close')" style="width:90px">Cancel</a>
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

