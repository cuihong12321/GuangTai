<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2016/6/6
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<% String dates=new SimpleDateFormat("yyyy/MM/dd").format(Calendar.getInstance().getTime());%>
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
    if(username==null){
        alert("未检测到您登录，请先登录");
        location.href = "<%=contextPath%>/";
    }


    function addOrder() {
        var url="<%=contextPath%>/Factory/Factory";
        $('#startingname').attr("url",url);
        $('#startingname').combobox("reload",url);

        $('#destinationname').attr("url",url);
        $('#destinationname').combobox("reload",url);

        url="<%=contextPath%>/Customer/GetCustomer";
        $('#customer').attr("url",url);
        $('#customer').combobox("reload",url);

        url="<%=contextPath%>/Commdity/Commdity";
        $('#commdity').attr("url",url);
        $('#commdity').combobox("reload",url);


        $('#submit').attr("onclick", "checkaddOrder()");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增运单');

    }
    function Commit() {
        var container;
        var flag=true;
        var formData = new FormData();
        var rows = $('#table').datagrid('getSelections');
        var entities="" ;
        if(rows!=null && rows.length>0) {
            for (i = 0; i < rows.length; i++) {
                entities = entities + JSON.stringify(rows[i]);
                container = rows[i].container;
            }
            formData.append("entities", entities);
            if(flag){
            $.ajax({
                url: "<%=contextPath%>/BulkOrder/Commit",
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
        else
        {
            alert("请选择需签入行!");
            return false;
        }

    }

    function checkaddOrder() {

        var number =$.trim($("input[name='number']")[0].value);
        var weight =$.trim($("input[name='weight']")[0].value);
        var volume =$.trim($("input[name='volume']")[0].value);

        var customerid = $.trim($("#customercombo").combobox('getValue'));
        var startingid =  $.trim($("#startingcombo").combobox('getValue'));
        var destinationid =$.trim($("#destinationcombo").combobox('getValue'));
        var commdityid =$.trim($("#commdity").combobox('getValue'));

        var customername = $.trim($("#customercombo").combobox('getText'));
        var startingname =  $.trim($("#startingcombo").combobox('getText'));
        var destinationname = $.trim($("#destinationcombo").combobox('getText'));
        var commdityname = $.trim($("#commdity").combobox('getText'));

        var orderworknumber = guid();
        var customerworknumber = $.trim($("input[name='customerworknumber']")[0].value);
        var numbers = $.trim($("input[name='numbers']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        var deliverytime = $.trim($("input[name='deliverytime']")[0].value);
        var dispatchtime = $.trim($("input[name='dispatchtime']")[0].value);
        var operatorid = sessionStorage.getItem("id");
        var operator =sessionStorage.getItem("username");
        if(numbers < 1 || number < 1 || weight < 1 || volume < 1){
            alert("存在不合理的值");
            return ;
        }
            if( customername && startingname && destinationname && orderworknumber &&
               explain && customerworknumber && dispatchtime && deliverytime)
       {
           for (var i=0; i<numbers; i++) {
               $("#table").datagrid('appendRow', {
                   number: number,
                   weight: weight,
                   volume: volume,
                   customername:customername,
                   startingname:startingname,
                   commdityname:commdityname,
                   destinationname:destinationname,
                   orderworknumber:orderworknumber,
                   customerworknumber:customerworknumber,
                   customerid: customerid,
                   startingid: startingid,
                   destinationid: destinationid,
                   commdityid: commdityid,
                   operator:operator,
                   operatorid:operatorid,
                   explain: explain,
                   deliverytime:deliverytime,
                   dispatchtime:dispatchtime
               });
           }


           $('#dlg').dialog('close');

       }
       else {

           alert("请完整填写运单!")
       }
    }
    function editOrder() {
        var rows = $('#table').datagrid('getSelections');
        if (rows != null && rows.length==1) {
            $('#submit').attr("onclick", "editcheckOrder()");
            var row = $("#table").datagrid('getSelected');
                $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改散货运单');
                $("#fm").form("load", row);
        }else{
            alert("一次只可修改一条运单,请正确选择运单!");
        }
    }
    function editcheckOrder() {
        var row = $("#table").datagrid('getSelected');
        var number =$.trim($("input[name='number']")[0].value);
        var weight =$.trim($("input[name='weight']")[0].value);
        var volume =$.trim($("input[name='volume']")[0].value);
        var customerid = $.trim($("#customercombo").combobox('getValue'));
        var startingid =  $.trim($("#startingcombo").combobox('getValue'));
        var destinationid = $.trim($("#destinationcombo").combobox('getValue'));
        var commdityid =$.trim($("#commdity").combobox('getValue'));
        var customername = $.trim($("#customercombo").combobox('getText'));
        var startingname =  $.trim($("#startingcombo").combobox('getText'));
        var destinationname = $.trim($("#destinationcombo").combobox('getText'));
        var commdityname = $.trim($("#commdity").combobox('getText'));
        var orderworknumber = row.orderworknumber;
        var customerworknumber = $.trim($("input[name='customerworknumber']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        var deliverytime = $.trim($("input[name='deliverytime']")[0].value);
        var dispatchtime = $.trim($("input[name='dispatchtime']")[0].value);
        var operatorid = sessionStorage.getItem("id");
        var operator =sessionStorage.getItem("username");
        if(number < 1 || weight < 1 || volume < 1){
            alert("存在不合理的值");
            return ;
        }
        if(number && weight && volume && customername && startingname &&
        destinationname && commdityname && orderworknumber && explain &&
        customerworknumber && deliverytime && dispatchtime)
        {
            var index=  $("#table").datagrid('getRowIndex',row);
            $("#table").datagrid('updateRow', {
                index: index,
                row: {
                    number: number,
                    weight: weight,
                    volume: volume,
                    customername:customername,
                    startingname:startingname,
                    destinationname:destinationname,
                    commdityname:commdityname,
                    orderworknumber:orderworknumber,
                    explain: explain,
                    deliverytime:deliverytime,
                    dispatchtime:dispatchtime,
                    customerworknumber:customerworknumber,
                    customerid: customerid,
                    startingid: startingid,
                    destinationid: destinationid,
                    commdityid: commdityid,
                    operator:operator,
                    operatorid:operatorid
                },
            });
        } else {
            alert("必填项不能为空!");
        }
        $('#dlg').dialog('close');
        alert("修改成功!");
    }
    function deleteOrder() {
        var formData = new FormData();
        var rows = $('#table').datagrid('getSelections');
        if (rows != null &&rows.length>0) {
            for(i = 0; i < rows.length; i++) {
                var index = $("#table").datagrid('getRowIndex', rows[i]);
                $('#table').datagrid('deleteRow', index);
            }
        }else{
            alert("请选择运单!");
        }
    }

    function guid() {
        function S4() {
            return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
        }
        return ("LY-"+"<%=dates%>-"+S4()+S4());
    }


    function updateOrder() {
        var row = $("#table").datagrid('getSelected');
        var cabinetnumber = $.trim($("input[name='cabinetnumber']")[0].value);
        var sealnumber = $.trim($("input[name='sealnumber']")[0].value);
        if ( cabinetnumber && sealnumber ) {

            var row = $("#table").datagrid('getSelected');
            var index=  $("#table").datagrid('getRowIndex',row);
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
       singleSelect="false"   data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'',method:'post'">
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
        <th field="deliverytime" width=10%>提货日期</th>
        <th field="dispatchtime" width=10%>送货日期</th>
        <th field="customerworknumber" width=15%>客户工作号</th>
        <th field="orderworknumber" width=15%>运单工作号</th>
        <th field="explain" width=10%>备注</th>
        <th field="customerid" width=auto hidden="true">客户ID</th>
        <th field="startingid" width=auto hidden="true">起运地ID</th>
        <th field="destinationid" width=auto hidden="true">目的地ID</th>
        <th field="commdityid" width=auto hidden="true">货物ID</th>
        <th field="operatorid" width=auto hidden="true">操作员ID</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addOrder()">新增散货运单
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editOrder()">修改散货运单
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true"
       onclick="deleteOrder()">移除散货运单</a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="Commit()"
    >签入散货运单</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">散货运单</div>
    <form id="fm" method="post" novalidate="false">
        <div class="fitem">
            <label>客户</label>
            <input name="customerid" id="customercombo" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Customer/GetCustomer" required="true">
        </div>

        <div class="fitem">
            <label>货物类型</label>
            <input name="commdity" id="commdity" class="easyui-combobox"  data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Commdity/GetCommdity" required="true">
        </div>

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
            <label>数量</label>
            <input name="numbers" class="easyui-numberbox" value="1" data-options="missingMessage:'请输入数字'"
                   required="true">
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

