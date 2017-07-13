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
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui-datagridview/datagrid-detailview.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui-datagridview/jquery.edatagrid.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>

    <title>Title</title>
</head>
<script type="text/javascript">
    var userid = sessionStorage.getItem("id");

    var id;
    var customerid;
    var factoryid;
    var containerid;
    var customername;
    var factoryname;
    var container;
    var username = sessionStorage.getItem("username");
    if (username == null) {
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }

    $(function () {
        var curl='<%=contextPath%>/CostType/GetCostType';//ajax给弹出框值。
        $.ajax({
            url:curl,
            type:'get',
            async:false,//此处必须是同步
            dataTye:'json',
            success:function(data){
                costtypedata=eval(data);
            }
        });
        var burl='<%=contextPath%>/Balanceunit/GetBalanceunit';
        $.ajax({
            url:burl,
            type:'get',
            async:false,//此处必须是同步
            dataTye:'json',
            success:function(data){
                balanceunitdata=eval(data);
            }
        });
        var courl='<%=contextPath%>/Currency/GetCurrency';
        $.ajax({
            url:courl,
            type:'get',
            async:false,//此处必须是同步
            dataTye:'json',
            success:function(data){
                currencydata=eval(data);
            }
        });
        var ourl='<%=contextPath%>/User/GetUser';
        $.ajax({
            url:ourl,
            type:'get',
            async:false,//此处必须是同步
            dataTye:'json',
            success:function(data){
                operatordata=eval(data);
            }
        });
        $('#table').datagrid({
            fit: true,
            fitColumns:false,
            pagination: true,
            idField: 'id',
            pagePosition: 'both',
            singleSelect: false,
            view: detailview,
            rowStyler: function (index, row) {
                if (row.state == 2) {
                    return 'background-color:#D3D3D3;';
                }
                if (row.state == 3) {
                    return 'background-color:#FFB6C1;';
                }
            },
            detailFormatter: function (index, row) {
                return '<div style="padding:2px"><table id="ddv' + index + '"></table><table id="sddv' + index + '"></table></div>';
            },
            onExpandRow: function (index, row) {
                $('#table').datagrid('selectRow', index);
                $('#sddv' + index).edatagrid({
                    url: '<%=contextPath%>/Cost/Get?ordercosttype=1&&orderid=' + row.id,
                    saveUrl:'<%=contextPath%>/Cost/Adds?ordercosttype=1&&orderid=' + row.id+'&&operatorid='+userid,
                    updateUrl: '<%=contextPath%>/Cost/Edits?ordercosttypeid=1&&orderid=' + row.id+'&&operatorid='+userid,
                    destroyUrl:'<%=contextPath%>/Cost/Delete',
                    title: "应付",
                    fitColumns: false,
                    singleSelect: true,
                    rownumbers: true,
                    loadMsg: '',
                    height: 'auto',
                    toolbar: [{ text: '添加', iconCls: 'icon-add', handler: function () {
                        $('#sddv'+index).edatagrid('addRow');
                    }
                    }, '-',
                        { text: '保存', iconCls: 'icon-save', handler: function () {
                            if(row.state!=3){
                                $('#sddv'+index).edatagrid('saveRow');
                                alert("保存成功!");
                            }
                            else
                            {
                                alert("保存失败!该运单已审核!")}
                            $('#sddv'+index).edatagrid('reload');
                        }
                        }, '-',
                        { text: '撤销', iconCls: 'icon-undo', handler: function () {
                            $('#sddv'+index).edatagrid('cancelRow');
                        }
                        }, '-',
                        { text: '删除', iconCls: 'icon-remove', handler: function () {
                            if(row.state!=3){
                                $('#sddv'+index).edatagrid('destroyRow');
                                alert("删除成功!");
                            }
                            else
                            {
                                alert("删除失败!该运单已审核!")}
                            $('#sddv'+index).edatagrid('reload');
                        }
                        }, '-'
                    ],
                    columns: [[
                        {field:'costtypeid',title:'费用类型',width:100,
                            formatter:function(value){                      //格式化该字段内的显示
                                for(var i=0; i<costtypedata.length; i++){
                                    if(costtypedata[i].id==value){
                                        costtypeid=costtypedata[i].id;
                                        return costtypedata[i].name;
                                    }
                                }
                                return "nulls";
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    data:costtypedata,
                                    required:true
                                }
                            }
                        },
                        {field:'balanceunitid',title:'结算单位',width:250,
                            formatter:function(value){                      //格式化该字段内的显示
//                                if(value==undefined){value=1}
                                for(var i=0; i<balanceunitdata.length; i++){
                                    if(balanceunitdata[i].id==value){
                                        balanceunitid=balanceunitdata[i].id;
                                        return balanceunitdata[i].name;
                                    }
                                }
                                return "nulls";
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    data:balanceunitdata,
//                                    required:true
                                }
                            }
                        },
                        {field: 'price', title: '单价', width: '100', align: 'right',editor:'numberbox'},
                        {field: 'measure', title: '计量', width: '100', align: 'right',editor:'numberbox'},
                        {field:'currencyid',title:'币种',width:100,
                            formatter:function(value){                      //格式化该字段内的显示
                                for(var i=0; i<currencydata.length; i++){
                                    if(currencydata[i].id==value){
                                        currencyid=currencydata[i].id;
                                        return currencydata[i].name;
                                    }
                                }
                                return "nulls";
                            },
                            editor:{
                                type:'combobox',
                                options:{
                                    valueField:'id',
                                    textField:'name',
                                    data:currencydata
//                                    required:true
                                }
                            }
                        },
                        {field: 'operator', title: '操作员', width: '100', align: 'right'},
                        {field: 'operatettime', title: '操作时间', width: '200', align: 'right'},
                        {field: 'explain', title: '备注', width: '100', align: 'right',editor:'textbox'},
                        {field: 'id', title: 'ID', width: '100', align: 'right', hidden: 'true'},
                    ]],
                    onResize: function () {
                        $('#table').datagrid('fixDetailRowHeight', index);
                    },
                    onLoadSuccess: function () {
                        if (row.state == 3) {
                            $('#sddv-' + index).datagrid('hideColumn', 'edit');
                            $('#sddv-' + index).datagrid('hideColumn', 'delete');
                        }
                        setTimeout(function () {
                            $('#table').datagrid('fixDetailRowHeight', index);
                        }, 0);
                    }
                });

                $('#table').datagrid('fixDetailRowHeight', index);
            }
        });
    });

    function guid() {
        function S4() {
            return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
        }
        return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
    }
/*    function formatOperedit(val, row, index) {
        return '<a href="#" onclick="editCost(' + index + ')">修改费用</a>';
    }
    function formatOperdelete(val, row, index) {
        return '<a href="#" onclick="deleteCost(' + index + ')">删除费用</a>';
    }*/
    function editWaybill() {
        var rows = $('#table').datagrid('getSelections');
        if (rows != null && rows.length == 1) {
            $('#submit').attr("onclick", "editcheckOrder()");
            var row = $("#table").datagrid('getSelected');
            id = row.id;
            customerid = row.customerid;
            factoryid = row.factoryid;
            containerid = row.containerid;
            customername = row.customername;
            factoryname = row.factoryname;
            container = row.container;
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改运单');
            $("#fm").form("load", row);

        }
        else {
            alert("一次只可修改一条运单,请正确选择运单!");
        }
    }
    function editcheckOrder() {

        var formData = new FormData();
        if (customername != $.trim($("#customercombo").combobox('getText'))) {
            customerid = $.trim($("#customercombo").combobox('getValue'));
        }
        if (factoryname != $.trim($("#factorycombo").combobox('getText'))) {
            factoryid = $.trim($("#factorycombo").combobox('getValue'));
        }
        if (container != $.trim($("#containercombo").combobox('getText'))) {
            containerid = $.trim($("#containercombo").combobox('getValue'));
        }
        var makingtime = $.trim($("input[name='makingtime']")[0].value);
        var billnumber = $.trim($("input[name='billnumber']")[1].value);
        var customerworknumber = $.trim($("input[name='customerworknumber']")[1].value);
        var cabinetnumber = $.trim($("input[name='cabinetnumber']")[1].value);
        var sealnumber = $.trim($("input[name='sealnumber']")[1].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        if (containerid && factoryid && customerid && makingtime && billnumber && customerworknumber && cabinetnumber && sealnumber && explain) {

            formData.append("id", id);
            formData.append("customerid", customerid);
            formData.append("factoryid", factoryid);
            formData.append("containerid", containerid);
            formData.append("makingtime", makingtime);
            formData.append("billnumber", billnumber);
            formData.append("customerworknumber", customerworknumber);
            formData.append("cabinetnumber", cabinetnumber);
            formData.append("sealnumber", sealnumber);
            formData.append("explain", explain);
            $.ajax({
                url: "<%=contextPath%>/Order/Edit",
                type: 'POST',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert(data);
                    return false;
                },
                error: function (data) {
                }
            });
        }
        else {
            alert("必填项不能为空!");
        }
    }
    function deleteWaybill() {
        var rows = $("#table").datagrid('getSelections');
        var formData = new FormData;
        var ens = "";
        for (var i = 0; i < rows.length; i++) {
            ens = ens + rows[i].id + ",";
        }
        formData.append("ens", ens);
        if (ens) {
            $.ajax({
                url: "<%=contextPath%>/Order/Delete",
                type: 'POST',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#table').datagrid('clearChecked');
                    alert(data);
                    return false;
                },
                error: function (data) {

                }
            });
        }
        else {
            alert("请选择运单!");
        }
    }
    function addCost() {
        //   $('#table').datagrid('selectRow', index);// 关键在这里
        var rows = $('#table').datagrid('getSelections');

        if (rows != null && rows.length > 0) {
            //alert(rows.length);
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].state == 3) {
                    alert("存在已审核记录!");
                    return;
                }
            }
            $('#costsubmit').attr("onclick", "checkaddCost()");
            $('#dlgcost').dialog('open').dialog('setTitle', '添加费用');
            $('#fmcost').form("clear");
        }
        else {
            alert("请选择运单!");
        }
    }
    function checkaddCost() {
        var rows = $("#table").datagrid('getSelections');
        var formData = new FormData;
        var ens = "";
        for (var i = 0; i < rows.length; i++) {
            ens = ens + rows[i].id + ",";
        }

        // urlin='<%=contextPath%>/Cost/Get?ordercosttype=0&&orderid=' + row.id;
        // urlout='<%=contextPath%>/Cost/Get?ordercosttype=1&&orderid=' + row.id;
        //var index =$('#table').datagrid("getRowIndex",row);


        var ordercosttype = $.trim($("#ordercosttype").combobox('getValue'));

        var costtypeid = $.trim($("#costtype").combobox('getValue'));

        var balanceunitid = $.trim($("#balanceunit").combobox('getValue'));

        var price = $.trim($("input[name='price']")[0].value);

        var measure = $.trim($("input[name='measure']")[0].value);

        var currencyid = $.trim($("#currency").combobox('getValue'));

        var explain = $.trim($("input[name='explain']")[1].value);

        formData.append("ens", ens);
        formData.append("ordercosttype", ordercosttype);
        formData.append("costtypeid", costtypeid);
        formData.append("balanceunitid", balanceunitid);
        formData.append("price", price);
        formData.append("measure", measure);
        formData.append("currencyid", currencyid);
        formData.append("explain", explain);
        formData.append("operatorid", sessionStorage.getItem("id"));

        if (ens && ordercosttype && costtypeid && balanceunitid && price && measure && currencyid && explain) {
            $.ajax({
                url: "<%=contextPath%>/Cost/Add",
                type: 'POST',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    alert(data);
                    $('#dlgcost').dialog("close");
                    $('#table').datagrid('reload');
                    //$('#ddv-' + index).datagrid("reload",urlin);
                    //   $('#sddv-' + index).datagrid("reload",urlout);

                    return false;
                },
                error: function (data) {

                }
            });

        } else {
            alert("必填项不能为空!");
        }
    }

/*    function editCostCostpay(index, indexson) {
        indexsonoveral = indexson;
        indexoveral = index;
        $('#table').datagrid('selectRow', index);
        var row = $('#sddv-' + index).datagrid('getRows')[indexson];


        if (row) {

            $('#costsubmit').attr("onclick", "checkedityCostpay()");
            $('#dlgcost').dialog('open').dialog('setTitle', '修改费用');
            $('#fmcost').form("load", row)
        }
        $('#ddv-' + indexoveral).datagrid("reload");
    }*/

    function checkedityCostpay() {
        var row = $("#table").datagrid('getSelected');
        var urlload = '<%=contextPath%>/Cost/Get?ordercosttype=1&&orderid=' + row.id;

        var rowson = $('#sddv-' + indexoveral).datagrid('getRows')[indexsonoveral];
        var formData = new FormData;

        if (row && rowson) {
            var id = rowson.id;
            var orderid = row.id;

            var ordercosttype = $.trim($("#ordercosttype").combobox('getValue'));

            var costtypeid = $.trim($("#costtype").combobox('getValue'));

            if (costtypeid == rowson.costtype) {
                costtypeid = rowson.costtypeid;
            }

            var balanceunitid = $.trim($("#balanceunit").combobox('getValue'));
            if (balanceunitid == rowson.balanceunit) {
                balanceunitid = rowson.balanceunitid;
            }
            var price = $.trim($("input[name='price']")[0].value);
            var measure = $.trim($("input[name='measure']")[0].value);

            var currencyid = $.trim($("#currency").combobox('getValue'));
            if (currencyid == rowson.currency) {
                currencyid = rowson.currencyid;
            }
            var explain = $.trim($("input[name='explain']")[1].value);
            formData.append("id", id);
            formData.append("orderid", orderid);
            formData.append("ordercosttype", ordercosttype);
            formData.append("costtypeid", costtypeid);
            formData.append("balanceunitid", balanceunitid);

            formData.append("price", price);
            formData.append("measure", measure);
            formData.append("currencyid", currencyid);
            formData.append("explain", explain);
            formData.append("operatorid", row.operatorid);


            $.ajax({
                url: "<%=contextPath%>/Cost/Edit",
                type: 'POST',
                dataType: 'json',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    alert(data);
                    $('#ddv-' + indexoveral).datagrid("reload", urlload);
                },error:function (data) {
                    alert(data);
                    $('#ddv-' + indexoveral).datagrid("reload", urlload);
                }
            });


        }
        $('#dlgcost').dialog("close");
    }

/*    function deleteCostpay(index, indexson) {

        var row = $("#table").datagrid('getSelected');
        var rowson = $('#sddv-' + index).datagrid('getRows')[indexson];
        var urlout = '<%=contextPath%>/Cost/Get?ordercosttype=1&&orderid=' + row.id;
        if (row && rowson) {
            var formData = new FormData;
            formData.append("id", rowson.id);
            $.ajax({
                url: "<%=contextPath%>/Cost/Delete",
                type: 'POST',
                dataType: 'json',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    if (data.message == "Success") {


                        $('#sddv-' + index).datagrid("reload", urlout);
                    } else {


                        $('#sddv-' + index).datagrid("reload", urlout);
                    }

                }
            });
        }
    }*/

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
        $('#table').datagrid('load', {

            customerid: $('#customerid').combobox('getValue'),
            factoryid: $('#factoryid').combobox('getValue'),
            containerid: $('#containerid').combobox('getValue'),
            billnumber: $("#billnumber").val(),
            customerworknumber: $("#customerworknumber").val(),
            cabinetnumber: $("#cabinetnumber").val(),
            sealnumber: $("#sealnumber").val(),
            operatorid: $('#operatorid').combobox('getValue'),
            state: $('#stateid').combobox('getValue'),
            begindate: $("#begindate").datebox('getValue'),
            enddate: $("#enddate").datebox("getValue"),
            begintime: $("#begintime").datebox("getValue"),
            endtime: $("#endtime").datebox("getValue")
        });
        $('#table').datagrid('clearChecked');
    }
    $(function () {
        $('#customerid').combobox({
            width: fixWidth()
        });
        $('#factoryid').combobox({
            width: fixWidth()
        });
        $('#containerid').combobox({
            width: fixWidth()
        });
        $('#operatorid').combobox({
            width: fixWidth()
        });
        $('#stateid').combobox({
            width: fixWidth()
        });
    });
    $(function () {
        $('#billnumber').textbox({
            width: fixWidth()
        });
        $('#customerworknumber').textbox({
            width: fixWidth()
        });
        $('#cabinetnumber').textbox({
            width: fixWidth()
        });
        $('#sealnumber').textbox({
            width: fixWidth()
        });

    });
    function fixWidth() {
        return document.body.clientWidth * 0.1;
    }
    window.onload = function () {
        $('#customerid').combobox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#factoryid').combobox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#containerid').combobox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#operatorid').combobox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#stateid').combobox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#billnumber').textbox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#customerworknumber').textbox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#cabinetnumber').textbox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
        $('#sealnumber').textbox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
    }
    $(function () {
        var pager = $('#table').datagrid('getPager');	// get the pager of datagrid
        pager.pagination({
            buttons: [{
                iconCls: 'icon-add',
                text: '添加费用',
                handler: function () {
                    addCost();
                }
            }, {
                iconCls: 'icon-edit',
                text: '修改运单',
                handler: function () {
                    editWaybill();
                }
            }, {
                iconCls: 'icon-remove',
                text: '删除运单',
                handler: function () {
                    deleteWaybill();
                }
            }]
        });
    });

</script>
<body class="easyui-layout">
<div id="aa" class="easyui-accordion">
    <div title="运单查询" iconcls="icon-search" style="overflow: auto; padding: 10px;">
        <div>
            <label for="customerid">客&nbsp;&nbsp;&nbsp;户：</label>
            <input class="easyui-combobox" id="customerid" name="customerid"
                   data-options="valueField:'customerid',textField:'customername'"
                   url="<%=contextPath%>/Customer/GetCustomerComboBox"/>
            <label for="factoryid">工&nbsp;&nbsp;&nbsp;厂：</label>
            <input class="easyui-combobox" id="factoryid" name="factoryid"
                   data-options="valueField:'factoryid',textField:'factoryname'"
                   url="<%=contextPath%>/Factory/GetFactoryComboBox"/>
            <label for="containerid">箱&nbsp;&nbsp;形：</label>
            <input class="easyui-combobox" id="containerid" name="containerid"
                   data-options="valueField:'containerid',textField:'container'"
                   url="<%=contextPath%>/ContainerType/GetContainerTypeComboBox"/>
            <label for="operatorid">操&nbsp;作&nbsp;员：</label>
            <input class="easyui-combobox" id="operatorid" name="operatorid"
                   data-options="valueField:'operatorid',textField:'operator'"
                   url="<%=contextPath%>/User/GetOperatorComboBox"/>
            <label for="stateid">运单状态：</label>
            <input class="easyui-combobox" id="stateid" name="state" data-options="valueField:'id',textField:'text',data:[{
                                        id:'0',
                                        text:'正常单'
                                        },
                                        {
                                        id:'1',
                                        text:'已派单'
                                        },
                                        {
                                        id:'2',
                                        text:'已完成'
                                        },
                                        {
                                        id:'3',
                                        text:'已审核'
                                        }
                                        ]"/><br/><br/>
            <label for="billnumber">提&nbsp;单&nbsp;号：</label>
            <input class="easyui-textbox" type="text" id="billnumber" name="billnumber">
            <label for="customerworknumber">客户工作号：</label>
            <input class="easyui-textbox" type="text" id="customerworknumber" name="customerworknumber">
            <label for="cabinetnumber">柜&nbsp;&nbsp;号：</label>
            <input class="easyui-textbox" type="text" id="cabinetnumber" name="cabinetnumber">
            <label for="sealnumber">封&nbsp;条&nbsp;号：</label>
            <input class="easyui-textbox" type="text" id="sealnumber" name="sealnumber"><br/><br/>
            <label for="makingtime">做箱日期：&nbsp;</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="begintime"
                   id="begintime"/> -----------
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="endtime"
                   id="endtime"/>
            <label for="begindate">录入日期：</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="begindate"
                   id="begindate"/> -----------
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="enddate"
                   id="enddate"/>&nbsp;
            <a href="javascript:query();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               style="width:100px">查询</a>
        </div>
    </div>

</div>

<table id="table" class="easyui-datagrid" fitColumns="false" style="width:auto;height:auto"
       singleSelect="false" detailFormatter="$('#costtable')"
       data-options="rownumbers:true,singleSelect:false,pagination:true,pageSize:20,url:'<%=contextPath%>/Order/Get',method:'post'">
    <thead>
    <tr>
        <th field="ck" checkbox="true" width=10%>选中</th>
        <th field="id" hidden="true">ID</th>
        <th field="customername" width=15%>客户</th>
        <th field="factoryname" width=15%>工厂</th>
        <th field="container" width=5%>箱形</th>
        <th field="sumout" width=5%>应付总额</th>
        <th field="makingtime" width=10%>做箱时间</th>
        <th field="billnumber" width=9%>提单号</th>
        <th field="cabinetnumber" width=9%>柜号</th>
        <th field="sealnumber" width=9%>封条号</th>
        <th field="customerworknumber" width=9%>客户工作号</th>
        <th field="orderworknumber" width=15%>运单工作号</th>
        <th field="carrier" width=5%>承运人</th>
        <th data-options="field:'state',
                                  formatter:function(val,row){

                                         if(row.state==0)
                                         {
                                         return '正常单';
                                         }
                                          if(row.state==1)
                                         {
                                         return '已派单';
                                         }
                                          if(row.state==2)
                                         {
                                         return '已完成';
                                         }
                                           if(row.state==3)
                                         {
                                         return '已审核';
                                         }

                                  }" width=5%>运单状态
        </th>
        <th field="operatetime" width=auto>录入时间</th>
        <th field="operator" width=5%>操作员</th>
        <th field="explain" width=5%>备注</th>
        <th field="customerid" width=auto hidden="true">客户ID</th>
        <th field="factoryid" width=auto hidden="true">工厂ID</th>
        <th field="operatorid" width=auto hidden="true">操作员ID</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>


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
            <input name="container" id="containercombo" class="easyui-combobox"
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
            <label>柜号</label>
            <input name="cabinetnumber" class="easyui-textbox" required="true">
        </div>

        <div class="fitem">
            <label>封条号</label>
            <input name="sealnumber" class="easyui-textbox" required="true">
        </div>

        <div class="fitem">
            <label>客户工作号</label>
            <input name="customerworknumber" class="easyui-textbox" required="true">
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


<div id="dlgcost" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlgcost-buttons">
    <div class="ftitle">运单</div>
    <form id="fmcost" method="post" novalidate="false">

        <div class="fitem">
            <label>应收应付</label>
            <select name="ordercosttype" id="ordercosttype" class="easyui-combobox" style="width:160px"
                    data-options="valueField:'id',textField:'name'"
                    required="true">
                <option value="1">应付</option>
            </select>
        </div>
        <div class="fitem">
            <label>费用类型</label>
            <input name="costtype" id="costtype" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/CostType/GetCostType" required="true">
        </div>
        <div class="fitem">
            <label>结算单位</label>
            <input name="balanceunit" id="balanceunit" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Balanceunit/GetBalanceunit" required="true">
        </div>
        <div class="fitem">
            <label>单价</label>
            <input name="price" id="price" class="easyui-numberbox" data-options="missingMessage:'请输入数字'"
                   required="true">
        </div>
        <div class="fitem">
            <label>计量</label>
            <input name="measure" id="measure" class="easyui-numberbox" data-options="missingMessage:'请输入数字'"
                   required="true">
        </div>
        <div class="fitem">
            <label>币种</label>
            <input name="currency" id="currency" class="easyui-combobox" data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Currency/GetCurrency" required="true">
        </div>
        <div class="fitem">
            <label>备注</label>
            <input name="explain" class="easyui-textbox" required="true">
        </div>


    </form>
</div>
<div id="dlgcost-buttons">
    <a id="costsubmit" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok"

       style="width:90px">Save</a>
    <a id="costcancel" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
       onclick="javascript:$('#dlgcost').dialog('close')" style="width:90px">Cancel</a>
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
