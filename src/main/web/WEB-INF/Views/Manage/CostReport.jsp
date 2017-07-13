<%--
  Created by IntelliJ IDEA.
  User: cpmoffice
  Date: 2017/4/28
  Time: 10:07
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
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui-datagridview/datagrid-detailview.js"></script>
    <script src="<%=contextPath%>/resources/librarys/jquery-easyui-datagridview/jquery.edatagrid.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>

    <title>Title</title>

</head>
<script type="text/javascript">

    var costtypedata;
    var balanceunitdata;
    var currencydata;
    var operatordata;

    var starttme ="";
    var endtime ="";
    var balanceunitid ="";



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
    function query() {
        starttime = $("#begindate").datebox('getValue');
        endtime  =  $("#enddate").datebox("getValue");
        balanceunitid = $("#balanceunitid").combobox('getValue')

        $('#table').datagrid('load', {
            balanceunitid:balanceunitid,
            starttime: starttime,
            endtime: endtime
        });
    }
    $(function () {
        var curl = '<%=contextPath%>/CostType/GetCostType';//ajax给弹出框值。
        $.ajax({
            url: curl,
            type: 'get',
            async: false,//此处必须是同步
            dataTye: 'json',
            success: function (data) {
                costtypedata = eval(data);
            }
        });
        var burl = '<%=contextPath%>/Balanceunit/GetBalanceunit';
        $.ajax({
            url: burl,
            type: 'get',
            async: false,//此处必须是同步
            dataTye: 'json',
            success: function (data) {
                balanceunitdata = eval(data);
            }
        });
        var courl = '<%=contextPath%>/Currency/GetCurrency';
        $.ajax({
            url: courl,
            type: 'get',
            async: false,//此处必须是同步
            dataTye: 'json',
            success: function (data) {
                currencydata = eval(data);
            }
        });
        var ourl = '<%=contextPath%>/User/GetUser';
        $.ajax({
            url: ourl,
            type: 'get',
            async: false,//此处必须是同步
            dataTye: 'json',
            success: function (data) {
                operatordata = eval(data);
            }
        });

        $('#table').edatagrid({
            url: '<%=contextPath%>/Cost/GetCostReport',
            fit: true,
            fitColumns: false,
            border: false,
            pagination: true,
            idField: 'id',
            pagePosition: 'both',
            singleSelect: true,
            columns: [[
                {
                    field: 'balanceunit', title: '结算单位', width: '280', align: 'right',

                },
                {field: 'price', title: '单价', width: '100', align: 'right'},
                {field: 'measure', title: '计量', width: '100', align: 'right'},
                {
                    field: 'currency', title: '币种', width: '100',
                },
                {field: 'operator', title: '操作员', width: '100', align: 'right'},
                {field: 'makingtime', title: '做箱时间', width: '200', align: 'right'},
                {field: 'explain', title: '备注', width: '100', align: 'center'},
                {
                    field: 'costtype', title: '费用类型', width: '100',


                }
            ]],
            toolbar:[{

                 text: '导出', iconCls: 'icon-add', handler: function () {
                    Export();
                }

            }],
                onResize: function () {
                $('#table').datagrid('fixDetailRowHeight', index);
            },
            onLoadSuccess: function () {
                var rows = $("#table").datagrid("getRows");

                setTimeout(function () {
                    $('#table').datagrid('fixDetailRowHeight', index);
                }, 0);
            }

        });
    });

    function  Export() {
        starttime = $("#begindate").datebox('getValue');
        endtime  =  $("#enddate").datebox("getValue");
        balanceunitid = $("#balanceunitid").combobox('getValue')


        window.location.href ="<%=contextPath%>/Cost/ExportCostReport?starttime="+starttime+"&&endtime="+endtime+"&&balanceunitid="+balanceunitid;


    }

</Script>
<body>
<div id="aa" class="easyui-accordion" >
    <div title="费用查询" iconcls="icon-search" style="overflow: auto; padding: 10px;">
        <div>

            <label for="balanceunitid">结算&nbsp;&nbsp;&nbsp;单位：</label>
            <input class="easyui-combobox"  id="balanceunitid" name="balanceunitid"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Balanceunit/GetBalanceunit"/>

            <label for="begindate">操作日期：</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="begindate" id="begindate"/> --------
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="enddate" id="enddate"/>&nbsp;&nbsp;
            <a href="javascript:query();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               style="width:100px">查询</a><br/><br/>
        </div>
    </div>
</div>
<div class="easyui-layout"data-options="fit:true " region="center">
<table id="table"  class="easyui-datagrid" fitColumns="true" style="width:100%;height:85%"
       singleSelect="true"
       data-options="rownumbers:true,singleSelect:true,pagination:true">
    <thead>
    <tr>
        <th field="id" hidden="true">ID</th>
        <th field="costtype" width=15%>费用类型</th>
        <th field="balanceunit" width=15%>结算单位</th>
        <th field="price" width=5%>单价</th>
        <th field="measure" width=5%>计量</th>
        <th field="currency" width=5%>币种</th>
        <th field="operator" width=10%>操作员</th>
        <th field="explain" width=9%>备注</th>
        <th field="operatettime" width=9%>操作时间</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>
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
