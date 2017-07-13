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
    var id;
    var username = sessionStorage.getItem("username");
    if (username == null) {
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
            rowStyler: function (index, row) {
                if (row.state == 2) {
                    return 'background-color:#D3D3D3;';
                }
                if (row.state == 3) {
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
                        var rows = $("#table").datagrid("getRows");

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

        if (row.state >= 2) {
            return;
        }
        return '<a href="#" onclick="editcarrier(' + index + ')">修改承运人</a>';
    }
    function formatwaybillcomplete(val, row, index) {

        if (row.state == 3) {
            return;
        }
        if (row.state == 2) {
            return;
        }
        else {
            return '<a href="#" id="Completewaybill" onclick="Completewaybill(' + index + ')">完成运单</a>';
        }

    }

    function editcarrier(index) {
        var url = "";
        $("#fm").form("clear");
        $('#submit').attr("onclick", "editcheckCarrier()");
        var row = $('#table').datagrid('getRows')[index];
        id = row.id;
        if (row.carriertype == 0) {
            $('#carrierid').combobox('setValue', '0');
        } else if (row.carriertype == 1) {
            url = '<%=contextPath%>/Driver/GetDriver';
        } else if (row.carriertype == 2) {
            url = '<%=contextPath%>/Supplier/GetSupplier';
        }
        $('#carrierid').attr("url", url);
        $('#carrierid').combobox("reload", url);
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改承运人');

        $("#fm").form("load", row);
        return false;
    }

    function editcheckCarrier() {
        var formData = new FormData();
        var carriertypeid = $.trim($("#carriertypeid").combobox('getValue'));
        var carrierid = $.trim($("#carrierid").combobox('getValue'));
        var state;
        if (carriertypeid == 0) {
            state = 0;
        } else {
            state = 1;
        }
        formData.append("carriertypeid", carriertypeid);
        formData.append("carrierid", carrierid);
        formData.append("state", state);
        formData.append("id", id);
        if (carrierid && carriertypeid) {
            $.ajax({
                url: "<%=contextPath%>/Order/Dispatch",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert(data);
                }, error: function (data) {

                }
            });
        } else {
            alert("必填项不能为空!");
        }

    }


    function Completewaybill(index) {

        $('#table').datagrid('selectRow', index);
        var row = $("#table").datagrid('getSelected');
        var carrier = row.carrier;
        var formData = new FormData();
        var carriertype = row.carriertype;

        var state = 2;
        formData.append("id", row.id);
        formData.append("state", state);
        if (carriertype != 0 && carrier != null) {

            $.ajax({
                url: "<%=contextPath%>/Order/Complete",
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
                error: function (data) {

                }
            });

        }
        else {
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
            begintime: $("#makingtime").datebox("getValue"),
            endtime: $("#makingendtime").datebox("getValue")
        });
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

</script>
<body class="easyui-layout">
<div id="aa" class="easyui-accordion">
    <div title="运单查询" iconcls="icon-search" style="overflow: auto; padding: 10px;">
        <div>
            <label for="customerid">客&nbsp;&nbsp;&nbsp;户：</label>
            <input class="easyui-combobox" id="customerid" name="customerid"
                   data-options="valueField:'customerid',textField:'customername'"
                    url="<%=contextPath%>/Customer/GetCustomerComboBox"/>
            <label for="factoryid">工&nbsp;厂：</label>
            <input class="easyui-combobox" id="factoryid" name="factoryid"
                   data-options="valueField:'factoryid',textField:'factoryname'"
                    url="<%=contextPath%>/Factory/GetFactoryComboBox"/>
            <label for="containerid">箱&nbsp;形：</label>
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
                                        ]"/>
            <label for="billnumber">提单号：</label>
            <input class="easyui-textbox" type="text" id="billnumber" name="billnumber"><br/><br/>
            <label for="customerworknumber">客户工作号：</label>
            <input class="easyui-textbox" type="text" id="customerworknumber" name="customerworknumber">
            <label for="cabinetnumber">柜&nbsp;号：</label>
            <input class="easyui-textbox" type="text" id="cabinetnumber" name="cabinetnumber">
            <label for="sealnumber">封条号：</label>
            <input class="easyui-textbox" type="text" id="sealnumber" name="sealnumber">
            <label for="makingtime">做箱日期：&nbsp;</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="makingtime"
                   id="makingtime"/>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="makingendtime"
                   id="makingendtime"/>
            <label for="begindate">录入日期：</label>
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="begindate"
                   id="begindate"/> -------
            <input class="easyui-datebox" data-options="formatter:myformatter,parser:myparser" name="enddate"
                   id="enddate"/>&nbsp;
            <a href="javascript:query();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
               style="width:100px">查询</a><br/><br/>
        </div>
    </div>

</div>

<table id="table" class="easyui-datagrid" fitColumns="false" style="width:100%;height:auto"
       singleSelect="false" detailFormatter="$('#costtable')"
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'<%=contextPath%>/Order/Get',method:'post'">
    <thead>
    <tr>
        <th field="id" hidden="true">ID</th>

        <th field="factoryname" width=15%>工厂</th>
        <th field="container" width=5%>箱形</th>
        <th field="makingtime" width=10%>做箱时间</th>
        <th field="billnumber" width=9%>提单号</th>
        <th field="cabinetnumber" width=9%>柜号</th>
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
        <th field="operator" width=auto>操作员</th>
        <th field="explain" width=5%>备注</th>
        <th field="customerid" width=auto hidden="true">客户ID</th>
        <th field="factoryid" width=auto hidden="true">工厂ID</th>
        <th field="operatorid" width=auto hidden="true">操作员ID</th>
        <th field="carrierid" width=auto hidden="true">承运人ID</th>
        <th data-options="field:'editcarrier',width:70,align:'center',formatter:formatcarrier">修改承运人</th>
        <th data-options="field:'completewaybill',width:60,align:'center',formatter:formatwaybillcomplete">完成运单</th>


    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">

    <div class="ftitle">修改承运人</div>
    <form id="fm" method="post" novalidate="false">

        <div class="fitem">
            <label>承运人类型</label>
            <input class="easyui-combobox" id="carriertypeid" name="carriertype" data-options="valueField:'id',textField:'text',data:[
            {id:'0',text:'未派单'},
            {id:'1',text:'内派'},
            {id:'2',text:'外派'},],
            onSelect:function(rec){
            if(rec.id == 0){
            $('#carrierid').combobox('clear');
            $('#carrierid').combobox('setValue','0');
            $('#carrierid').combobox('setText', '未派单');
            }else if(rec.id == 1){
            $('#carrierid').combobox('clear');
            url = '<%=contextPath%>/Driver/GetDriver';
            $('#carrierid').combobox('reload',url);
            }else if(rec.id == 2){
            $('#carrierid').combobox('clear');
            url = '<%=contextPath%>/Supplier/GetSupplier';
            $('#carrierid').combobox('reload',url);
            }
            }"  required="true"/>
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

<div id="dlgcost" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlgcost-buttons">
    <div class="ftitle">运单</div>
    <form id="fmcost" method="post" novalidate="false">

        <div class="fitem">
            <label>应收应付</label>
            <select name="ordercosttype" id="ordercosttype" class="easyui-combobox" style="width:160px"
                    data-options="valueField:'id',textField:'name'"
                    editable="false" required="true">
                <option value="0">应收</option>
                <option value="1">应付</option>
            </select>
        </div>
        <div class="fitem">
            <label>费用类型</label>
            <input name="costtype" id="costtype" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   editable="false" url="<%=contextPath%>/CostType/GetCostType" required="true">
        </div>
        <div class="fitem">
            <label>结算单位</label>
            <input name="balanceunit" id="balanceunit" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   editable="false" url="<%=contextPath%>/Balanceunit/GetBalanceunit" required="true">
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
                   editable="false" url="<%=contextPath%>/Currency/GetCurrency" required="true">
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
