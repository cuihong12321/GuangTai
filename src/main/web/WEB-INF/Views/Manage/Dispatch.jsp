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
    if(username == null){
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
            singleSelect: true,
            rowStyler:function(index,row){
                if (row.state==2){
                    return 'background-color:#D3D3D3;';
                }
                if (row.state==3){
                    return 'background-color:#FFB6C1;';
                }
            },
            view: detailview,
            detailFormatter: function (index, row) {
                return '<div style="padding:2px"><table id="ddv-' + index + '"></table><table id="sddv-' + index + '"></table></div>';
            },
            onExpandRow: function (index, row) {
                $('#table').datagrid('selectRow', index);
                $('#ddv-' + index).datagrid({
                    url: '<%=contextPath%>/Cost/Get?&&orderid=' + row.id + '&&costtypename=5',
                    title: "司机提成",
                    fitColumns: true,
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
                        {field: 'explain', title: '备注', width: '100', align: 'center'},
                        {field: 'costtypeid', title: '费用类型', width: '100', hidden: 'true', align: 'right'},
                        {field: 'balanceunitid', title: '结算单位', width: '100', align: 'right', hidden: 'true'},
                        {field: 'currencyid', title: '币种', width: '100', align: 'right', hidden: 'true'},
                        {field: 'id', title: 'ID', width: '100', align: 'right', hidden: 'true'},
                        {field: 'operatorid', title: '操作员', width: '100', align: 'right', hidden: 'true'}
                    ]],
                    onResize: function () {
                        $('#table').datagrid('fixDetailRowHeight', index);
                    },
                    onLoadSuccess: function () {
                        var rows =   $("#table").datagrid("getRows");

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

    function formatcarrier(val, row, index) {

        if(row.state>=2)
        {
            return;
        }
        return '<a href="#" onclick="editcarrier(' + index + ')">修改承运人</a>';
    }
    function formatwaybillcomplete(val, row, index) {

        if(row.state==3 || row.state==2)
        {
            return;
        }else{
            return '<a href="#" id="Completewaybill" onclick="Completewaybill(' + index + ')">完成运单</a>';
        }

    }

    function editcarrier(index) {
        var url="";
        $("#fm").form("clear");
        $('#submit').attr("onclick", "editcheckCarrier()");
        var row =  $('#table').datagrid('getRows')[index];
        if(row.carriertype == 0){
            $('#carrierid').combobox('setValue','0');
        }else if(row.carriertype == 1){
            url = '<%=contextPath%>/Driver/GetDriver';
        }else if(row.carriertype == 2){
            url = '<%=contextPath%>/Supplier/GetSupplier';
        }
        $('#carrierid').attr("url",url);
        $('#carrierid').combobox("reload",url);
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改承运人');

        $("#fm").form("load", row);
        return false;
    }

    function editcheckCarrier(){
        var formData = new FormData();
        var row = $('#table').datagrid('getSelected');
        var carriertypeid =$.trim($("#carriertypeid").combobox('getValue'));
        var carrierid  = $.trim($("#carrierid").combobox('getValue'));
        var carriername  = $.trim($("#carrierid").combobox('getText'));
        var id = row.id;
        var state;
        if(carriertypeid != 0 && carriername != null){
            state = 1;
        }else{
            state = 0;
        }
        formData.append("carriertypeid",carriertypeid);
        formData.append("carrierid",carrierid);
        formData.append("state",state);
        formData.append("id",id);
        if(carrierid && carriertypeid){
            $.ajax({
                url:"<%=contextPath%>/BulkOrder/Dispatch",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success:function(data){
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert(data);
                },error:function(data){
                }
            });
        }else{
            alert("必填项不能为空!");
        }
    }


    function Completewaybill(index) {

        $('#table').datagrid('selectRow', index);
        var row = $("#table").datagrid('getSelected');
        var carrier = row.carrier;
        var formData = new FormData();
        var carriertype = row.carriertype;
        formData.append("id",row.id);
        formData.append("state","1");
        if(carriertype != 0 && carrier != null){

            $.ajax({
                url: "<%=contextPath%>/BulkOrder/Complete",
                type: 'POST',
                cache: false,
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    $("#table").datagrid("reload");
                    alert(data);
                    return false;
                },
                error:function (data) {

                }
            });

        }
        else
        {
            alert("请修改承运人信息!");
        }
    }


    $(function () {

    });

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
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="begindate" id="begindate"/> --------
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
        <th field="customername" width=15%>客户</th>
        <th field="commdityname" width=10%>货物类型</th>
        <th field="number" width=5% >件数</th>
        <th field="weight" width=5%>毛重</th>
        <th field="volume" width=5%>体积</th>
        <th field="startingname" width=15%>起运地</th>
        <th field="destinationname" width=15%>目的地</th>
        <th field="deliverytime" width=10%>提货日期</th>
        <th field="dispatchtime" width=10%>送货日期</th>
        <th field="customerworknumber" width=10%>客户工作号</th>
        <th field="orderworknumber" width=10%>运单工作号</th>
        <th data-options="field:'carriertype',
                                  formatter:function(val,row){

                                         if(row.carriertype==0)
                                         {
                                         return '未派单';
                                         }
                                          if(row.carriertype==1)
                                         {
                                         return '内派';
                                         }
                                          if(row.carriertype==2)
                                         {
                                         return '外派';
                                         }

                                  }" width=5%>承运人类型
        </th>
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
        <th field="operatetime" width=5%>操作时间</th>
        <th field="operatorname" width=5%>操作员</th>
        <th field="explain" width=8%>备注</th>
        <th field="customerid" width=auto hidden="true">客户ID</th>
        <th field="startingid" width=auto hidden="true">起运地ID</th>
        <th field="destinationid" width=auto hidden="true">目的地ID</th>
        <th field="commdityid" width=auto hidden="true">货物ID</th>
        <th field="operatorid" width=auto hidden="true">操作员ID</th>
        <th data-options="field:'editcarrier',width:70,align:'center',formatter:formatcarrier">修改承运人</th>
        <th data-options="field:'completewaybill',width:60,align:'center',formatter:formatwaybillcomplete">完成运单</th>
        </tr>
        </thead>
    </table>

    <div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
         closed="true" buttons="#dlg-buttons">

        <div class="ftitle">修改承运人</div>
        <form id="fm" method="post" novalidate="false">

            <div class="fitem">
                <label>承运人类型</label>
                <input class="easyui-combobox" id="carriertypeid" name="carriertype"  data-options="valueField:'id',textField:'text',
       data:[{id:'0',text:'未派单'},
            {id:'1',text:'内派'},
            {id:'2',text:'外派'},],
            onSelect:function(rec){
            if(rec.id == 0){
            $('#carrierid').combobox('clear');
            $('#carrierid').combobox('setValue', '0');
            $('#carrierid').combobox('setText', '未派单');
            }else if(rec.id == 1){
            url = '<%=contextPath%>/Driver/GetDriver';
            $('#carrierid').combobox('clear');
            $('#carrierid').combobox('reload',url);
            }else if(rec.id == 2){
            url = '<%=contextPath%>/Supplier/GetSupplier';
            $('#carrierid').combobox('clear');
            $('#carrierid').combobox('reload',url);
            }
            }"   required="true"/>
            </div>

            <div class="fitem">
                <label>承运人</label>
                <input class="easyui-combobox" id="carrierid" name="carrierid"
                       data-options="valueField:'id',textField:'name'"
                        required="true">
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
