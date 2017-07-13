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
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>

    <title>Title</title>
</head>
<script type="text/javascript">
    var username = sessionStorage.getItem("username");
    if(username==null){
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }
    <%   int indexsonoveral=0;%>
    <%   int indexoveral=0;%>

    $(function () {

        $('#table').datagrid({
            fit: true,
            fitColumns: false,
            border: false,
            pagination: true,
            idField: 'id',
            pagePosition: 'both',
            singleSelect: false,
            view: detailview,
            rowStyler:function(index,row){
                if (row.state==2){
                    return 'background-color:#D3D3D3;';
                }
                if (row.state==3){
                    return 'background-color:#FFB6C1;';
                }
            },

            detailFormatter: function (index, row) {
                return '<div style="padding:2px"><table id="ddv-' + index + '"></table><table id="sddv-' + index + '"></table></div>';
            },
            onExpandRow: function (index, row) {
                $('#table').datagrid('selectRow', index);
                $('#sddv-' + index).datagrid({
                    url: '<%=contextPath%>/Cost/get?ordercosttype=1&&bulkorderid=' + row.id,
                    title: "应付",
                    fitColumns: false,
                    singleSelect: true,
                    rownumbers: true,
                    loadMsg: '',
                    height: 'auto',
                    columns: [[
                        {field: 'costtype', title: '费用类型', width: '100'},
                        {field: 'balanceunit', title: '结算单位', width: '100', align: 'right'},
                        {field: 'price', title: '单价', width: '100', align: 'right'},
                        {field: 'measure', title: '计量', width: '100', align: 'right'},
                        {field: 'currency', title: '币种', width: '100', align: 'right'},
                        {field: 'operator', title: '操作员', width: '100', align: 'right'},
                        {field: 'operatettime', title: '操作时间', width: '200', align: 'right'},
                        {field: 'explain', title: '备注', width: '100', align: 'right'},
                        {field: 'costtypeid', title: '费用类型', width: '100', hidden: 'true', align: 'right'},
                        {field: 'balanceunitid', title: '结算单位', width: '100', align: 'right', hidden: 'true'},
                        {field: 'currencyid', title: '币种', width: '100', align: 'right', hidden: 'true'},
                        {field: 'operatorid', title: '操作员', width: '100', align: 'right', hidden: 'true'},
                        {field: 'id', title: 'ID', width: '100', align: 'right', hidden: 'true'},
                        {field:'edit',width:50, title:"修改费用" ,width: '100', align:'center',formatter:function (value, row, indexson) {

                            return '<a href="#" onclick="editCostCostpay(' + index + ','+ indexson+')">修改费用</a>';
                        }},
                        {field:'delete', title:"删除费用" ,width: '100', align:'center',formatter:  function (value, row, indexson) {
                            return '<a href="#" onclick="deleteCostpay(' + index + ','+ indexson+')">删除费用</a>';
                        }}
                    ]],
                    onResize: function () {
                        $('#table').datagrid('fixDetailRowHeight', index);
                    },
                    onLoadSuccess: function () {
                        if(row.state==3)
                        {
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

    function editWaybill() {
        var rows = $('#table').datagrid('getSelections');
        if (rows != null && rows.length==1) {
            $('#submit').attr("onclick", "editcheckOrder()");
            var row = $("#table").datagrid('getSelected');
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改运单');
            $("#fm").form("load", row);

        } else {
            alert("一次只可修改一条运单,请正确选择运单!");
        }
    }
    function editcheckOrder() {

        var formData = new FormData();
        var row = $("#table").datagrid('getSelected');

        var number = $.trim($("input[name='number']")[0].value);
        var weight = $.trim($("input[name='weight']")[0].value);
        var volume = $.trim($("input[name='volume']")[0].value);
        var commdityid = $.trim($("#commditycombo").combobox('getValue'));//("#commditycombo")和名字有关..
        var customerid = $.trim($("#customercombo").combobox('getValue'));
        var startingid = $.trim($("#startingcombo").combobox('getValue'));
        var destinationid = $.trim($("#destinationcombo").combobox('getValue'));
        var customerworknumber =$.trim($("input[name='customerworknumber']")[1].value);//[1]代表什么。
        var explain = $.trim($("input[name='explain']")[0].value);
        var deliverytime = $.trim($("input[name='deliverytime']")[1].value);
        var dispatchtime = $.trim($("input[name='dispatchtime']")[1].value);
        formData.append("pattern" , "operateorder");
        if(number < 1 || weight < 1 || volume < 1){
            alert("存在不合理值!");
            return ;
        }
        if ( commdityid && customerid && startingid && destinationid && customerworknumber
                && explain  && dispatchtime && deliverytime) {
            formData.append("id",row.id);
            formData.append("number",number);
            formData.append("weight",weight);
            formData.append("volume",volume);
            formData.append("commdityid",commdityid);
            formData.append("customerid",customerid);
            formData.append("startingid",startingid);
            formData.append("destinationid",destinationid);
            formData.append("customerworknumber",customerworknumber);
            formData.append("explain",explain);
            formData.append("dispatchtime",dispatchtime);
            formData.append("deliverytime",deliverytime);
            $.ajax({
                url: "<%=contextPath%>/BulkOrder/Edit",
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
        } else {
            alert("必填项不能为空!");
        }
    }

    function deleteWaybill(index) {

        var rows = $("#table").datagrid('getSelections');
        var formData = new FormData;
        var ens = "";
        for(var i = 0; i<rows.length; i++){
            ens = ens +rows[i].id + ",";
        }
        formData.append("ens" , ens);
        formData.append("pattern" , "operateorder");
        if(ens){
            $.ajax({
                url:"<%=contextPath%>/BulkOrder/Delete",
                type:'POST',
                cache:false,
                contentType:false,
                processData:false,
                data:formData,
                success:function (data) {
                    $('#table').datagrid('reload');
                    $('#table').datagrid('clearChecked');
                    alert(data);
                },error:function (data) {
                    alert(data);
                }

            });
        }else{
            alert("请选择订单！");
        }
    }


    function addCost() {
        //   $('#table').datagrid('selectRow', index);// 关键在这里
        var rows = $('#table').datagrid('getSelections');

        if (rows!=null && rows.length>0 ) {
            //alert(rows.length);
            for(var i = 0; i < rows.length; i++) {
                if(rows[i].state == 3) {
                    alert("存在已审核记录!");
                    return;
                }
            }
            $('#costsubmit').attr("onclick", "checkaddCost()");
            $('#dlgcost').dialog('open').dialog('setTitle', '添加费用');
            $('#fmcost').form("clear");
        }
        else
        {
            alert("请选择运单!");
        }
    }
    function checkaddCost() {
        var rows = $("#table").datagrid('getSelections');
        var formData = new FormData;
        var ens = "";
        for(var i=0;i<rows.length;i++){
            ens=ens+rows[i].id+",";
        }
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
        formData.append("ordertype", "bulkorder");
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
                }
            });
        }else{
            alert("必填项不能为空!");
        }
    }

    function editCostCostpay(index, indexson ) {
        indexsonoveral = indexson;
        indexoveral = index;
        $('#table').datagrid('selectRow', index);
        var row =   $('#sddv-' + index).datagrid('getRows')[indexson];
        if (row) {
            $('#costsubmit').attr("onclick", "checkedityCostpay()");
            $('#dlgcost').dialog('open').dialog('setTitle', '修改费用');
            $('#fmcost').form("load", row)
        }
    }

    function  checkedityCostpay() {
        var row = $("#table").datagrid('getSelected');
        var rowson =   $('#sddv-' + indexoveral).datagrid('getRows')[indexsonoveral];
        var formData = new FormData;
        if (row && rowson) {
            var id = rowson.id;
            var bulkorderid = row.id;

            var ordercosttype = $.trim($("#ordercosttype").combobox('getValue'));

            var costtypeid = $.trim($("#costtype").combobox('getValue'));

            if(costtypeid==rowson.costtype)
            {
                costtypeid = rowson.costtypeid;
            }

            var balanceunitid = $.trim($("#balanceunit").combobox('getValue'));
            if(balanceunitid==rowson.balanceunit)
            {
                balanceunitid = rowson.balanceunitid;
            }
            var price = $.trim($("input[name='price']")[0].value);
            var measure = $.trim($("input[name='measure']")[0].value);

            var currencyid = $.trim($("#currency").combobox('getValue'));
            if(currencyid==rowson.currency)
            {
                currencyid = rowson.currencyid;
            }
            var explain = $.trim($("input[name='explain']")[1].value);
            formData.append("id", id);
            formData.append("bulkorderid", bulkorderid);
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
                    $('#sddv-' + indexoveral).datagrid("reload");
                }
            });
        }
        $('#dlgcost').dialog("close");
    }

    function deleteCostpay(index,indexson) {
        indexsonoveral = indexson;
        indexoveral = index;
        var rowson =$('#sddv-' + index).datagrid('getRows')[indexson];
        if (rowson.id) {
            var formData= new FormData;
            formData.append("id",rowson.id);
            $.ajax({
                url: "<%=contextPath%>/Cost/Delete",
                type: 'POST',
                dataType: 'json',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    $('#sddv-' + indexoveral).datagrid("reload");
                }
            });
        }
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

    function query() {
        $('#table').datagrid('load', {
            commdityid:$('#commdityid').combobox('getValue'),
            customerid: $('#customerid').combobox('getValue'),
            startingid: $('#startingid').combobox('getValue'),
            destinationid: $('#destinationid').combobox('getValue'),
            operatorid: $('#operatorid').combobox('getValue'),
            deliverytime: $("#delivery").datebox('getValue'),
            dispatchtime: $("#dispatch").datebox('getValue'),
            state: $('#stateid').combobox('getValue'),
            customerworknumber: $("#customerworknumber").val(),
            begindate: $("#begindate").datebox('getValue'),
            enddate: $("#enddate").datebox("getValue")
        });
        $('#table').datagrid('clearChecked');
    }
    $(function(){
        $('#commdityid').combobox({
            width:fixWidth()
        });
        $('#customerid').combobox({
            width:fixWidth()
        });
        $('#startingid').combobox({
            width:fixWidth()
        });
        $('#destinationid').combobox({
            width:fixWidth()
        });
        $('#operatorid').combobox({
            width:fixWidth()
        });
        $('#stateid').combobox({
            width:fixWidth()
        });
    });
    $(function(){
        $('#customerworknumber').textbox({
            width:fixWidth()
        });
    });
    $(function(){
        $('#deliverytime').datebox({
            width:fixWidth()
        });
        $('#dispatchtime').datebox({
            width:fixWidth()
        });
        $('#begindate').datebox({
            width:fixWidth()
        });
        $('#enddate').datebox({
            width:fixWidth()
        });

    });
    function fixWidth() {
        return document.body.clientWidth*0.1;
    }
    window.onload = function(){
        $('#commdityid').combobox({
            //相当于html >> select >> onChange事件
            onChange:query
        });
        $('#customerid').combobox({
            //相当于html >> select >> onChange事件
            onChange:query
        });
        $('#startingid').combobox({
            //相当于html >> select >> onChange事件
            onChange:query
        });
        $('#destinationid').combobox({
            //相当于html >> select >> onChange事件
            onChange:query
        });
        $('#operatorid').combobox({
            //相当于html >> select >> onChange事件
            onChange:query
        });
        $('#stateid').combobox({
            //相当于html >> select >> onChange事件
            onChange:query
        });
        $('#customerworknumber').textbox({
            //相当于html >> select >> onChange事件
            onChange: query
        });
    }
    $(function(){
        var pager = $('#table').datagrid('getPager');	// get the pager of datagrid
        pager.pagination({
            buttons:[{
                iconCls:'icon-add',
                text:'添加费用',
                handler:function(){
                    addCost();
                }
            },{
                iconCls:'icon-edit',
                text:'修改运单',
                handler:function(){
                    editWaybill();
                }
            },{
                iconCls:'icon-remove',
                text:'删除运单',
                handler:function(){
                    deleteWaybill();
                }
            }]
        });
    });
    function formattotalcostpay() {

    }
</script>
<body class="easyui-layout">
<div id="aa" class="easyui-accordion" style="width: auto">
    <div title="运单查询" iconcls="icon-search" style="overflow: auto; padding: 10px;">
        <div>

            <label for="customerid">客&nbsp;&nbsp;&nbsp;户：</label>
            <input class="easyui-combobox"  id="customerid" name="customerid"
                   data-options="valueField:'customerid',textField:'customername'"
                   url="<%=contextPath%>/Customer/GetCustomerComboBox"/>

            <label for="commdityid">货物类型：</label>
            <input class="easyui-combobox"  id="commdityid" name="commdityid"
                   data-options="valueField:'commdityid',textField:'commdity'"
                   url="<%=contextPath%>/Commdity/GetCommdityComboBox" />
            <label for="startingid">&nbsp;起运地：</label>
            <input class="easyui-combobox"  id="startingid" name="startingid"
                   data-options="valueField:'factoryid',textField:'factoryname'"
                   url="<%=contextPath%>/Factory/GetFactoryComboBox"/>&nbsp;
            <label for="destinationid">目的地：&nbsp;</label>
            <input class="easyui-combobox"  id="destinationid" name="destinationid"
                   data-options="valueField:'factoryid',textField:'factoryname'"
                   url="<%=contextPath%>/Factory/GetFactoryComboBox"/>
            <label for="stateid">运单状态：</label>
            <input class="easyui-combobox" id="stateid" name="state"  data-options="valueField:'id',textField:'text',data:[{
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
                                        ]"/>
            <label for="operatorid">操作员：</label>
            <input class="easyui-combobox"  id="operatorid" name="operatorid"
                   data-options="valueField:'operatorid',textField:'operator'"
                   url="<%=contextPath%>/User/GetOperatorComboBox"/><br/><br/>
            <label for="customerworknumber">客户工作号：</label>
            <input  class="easyui-textbox" type="text" id="customerworknumber" name="customerworknumber">
            <label for="begindate">提货日期：</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="deliverytime" id="delivery"/>
            <label for="begindate">送货日期：</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="dispatchtime" id="dispatch"/>
            <label for="begindate">操作日期：</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="begindate" id="begindate"/> ----------
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="enddate" id="enddate"/>&nbsp;&nbsp;
            <a href="javascript:query();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               style="width:100px">查询</a><br/><br/>
        </div>
    </div>

</div>

<table id="table" class="easyui-datagrid"  fitColumns="false" style="width:auto;height:auto"
       singleSelect="false" detailFormatter="$('#costtable')"
       data-options="rownumbers:true,singleSelect:false,pagination:true,pageSize:20,url:'<%=contextPath%>/BulkOrder/Get',method:'post'">
    <thead>
    <tr>
        <th field="ck" checkbox="true" width=10% >选中</th>
        <th field="customername" width=15%>客户</th>
        <th field="commdityname" width=10%>货物类型</th>
        <th field="number" width=5% >件数</th>
        <th field="weight" width=5%>毛重</th>
        <th field="volume" width=5%>体积</th>
        <th field="startingname" width=15%>起运地</th>
        <th field="destinationname" width=15%>目的地</th>
        <th field="sumout" width=10%>应付总额</th>
        <th field="deliverytime" width=10%>提货日期</th>
        <th field="dispatchtime" width=10%>送货日期</th>
        <th field="customerworknumber" width=10%>客户工作号</th>
        <th field="orderworknumber" width=10%>运单工作号</th>
        <th field="carrier" width=5% >承运人</th>
        <th  data-options="field:'state',
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


                                  }"    width=5%>运单状态</th>
        <th field="operatetime" width=10%>操作时间</th>
        <th field="operatorname" width=5%>操作员</th>
        <th field="explain" width=10%>备注</th>
        <th field="customerid" width=auto hidden="true">客户ID</th>
        <th field="startingid" width=auto hidden="true">起运地ID</th>
        <th field="destinationid" width=auto hidden="true">目的地ID</th>
        <th field="commdityid" width=auto hidden="true">货物ID</th>
        <th field="operatorid" width=auto hidden="true">操作员ID</th>


    </tr>
    </thead>
</table>


<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">散货运单</div>
    <form id="fm" method="post" novalidate="false">
        <div class="fitem">
            <label>件数</label>
            <input name="number" id="number" class="easyui-numberbox" data-options="missingMessage:'请输入数字'" required="true">
        </div>

        <div class="fitem">
            <label>毛重</label>
            <input name="weight" id="weight" class="easyui-numberbox" data-options="missingMessage:'请输入数字'" required="true">
        </div>

        <div class="fitem">
            <label>体积</label>
            <input name="volume" id="volume" class="easyui-numberbox" data-options="missingMessage:'请输入数字'" required="true">
        </div>

        <div class="fitem">
            <label>货物类型</label>
            <input name="commdityid" id="commditycombo" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Commdity/GetCommdity" required="true">
        </div>

        <div class="fitem">
            <label>客户</label>
            <input name="customerid" id="customercombo" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Customer/GetCustomer" required="true">
        </div>
        <div class="fitem">
            <label>起运地</label>
            <input name="startingid" id="startingcombo" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Factory/GetFactory" required="true">
        </div>

        <div class="fitem">
            <label>目的地</label>
            <input name="destinationid" id="destinationcombo" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Factory/GetFactory" required="true">
        </div>

        <div class="fitem">
            <label>客户工作号</label>
            <input name="customerworknumber" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>提货日期</label>
            <input name="deliverytime" id="deliverytime" class="easyui-datebox" editable="false"
                   data-options="formatter:myformatter,parser:myparser" required="true">
        </div>
        <div class="fitem">
            <label>送货日期</label>
            <input name="dispatchtime" id="dispatchtime" class="easyui-datebox" editable="false"
                   data-options="formatter:myformatter,parser:myparser" required="true">
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
            <select  name="ordercosttype" id="ordercosttype" class="easyui-combobox" style="width:160px" editable="false"
                     data-options="valueField:'id',textField:'name'"
                     required="true">
                <option value="1">应付</option>
            </select >
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
            <input name="price" id="price" class="easyui-numberbox" data-options="missingMessage:'请输入数字'" required="true">
        </div>
        <div class="fitem">
            <label>计量</label>
            <input name="measure" id="measure" class="easyui-numberbox" data-options="missingMessage:'请输入数字'" required="true">
        </div>
        <div class="fitem">
            <label>币种</label>
            <input name="currency" id="currency" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
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
