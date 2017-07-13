<%--
  Created by IntelliJ IDEA.
  User: haoyuedev001
  Date: 2016-05-29
  Time: 16:04
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
    <script type="text/javascript" src="<%=contextPath%>/resources/librarys/jquery-easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="<%=contextPath%>/resources/librarys/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/bootstrap/easyui.css"/>
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/jquery-easyui/themes/icon.css"/>
    <script type="text/javascript">

        var username = sessionStorage.getItem("username");
        if(username==null){
            alert("未检测到您登录，请先登录");
            location.href = "<%=contextPath%>/";
        }
        function addFactory() {


            $('#submit').attr("onclick","checkFactory()");
            $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增工厂');

        }

        function checkFactory() {
            if(!$("#fm").form('validate')){

                alert("填写的信息有误，请重新填写!");
                return false;
            }
            var formData = new FormData();
            var areaid = $('#area').combobox('getValue');
            var name = $.trim($("input[name='name']")[0].value);
            var address = $.trim($("input[name='address']")[0].value);
            var contact = $.trim($("input[name='contact']")[0].value);
            var telephone = $.trim ($("input[name='telephone']")[0].value);
            var explain = $.trim($("input[name='explain']")[0].value);
            formData.append("name",name);
            formData.append("address",address);
            formData.append("areaid",areaid);
            formData.append("contact",contact);
            formData.append("telephone",telephone);
            formData.append("explain",explain);
            if(name && address && areaid && contact && telephone && explain)
            {
                $.ajax({
                    url:"<%=contextPath%>/Factory/Add",
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        $('#table').datagrid('reload');
                        $('#dlg').dialog('close');
                        alert("添加工厂成功!");
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
        function editcheckFactory() {
            if(!$("#fm").form('validate')){

                alert("填写的信息有误，请重新填写!");
                return false;
            }
            var formData = new FormData();
            var area;
            var row = $("#table").datagrid('getSelected');
            var id = row.id;

            var name=  $.trim($("input[name='name']")[0].value);
            var  address =   $.trim($("input[name='address']")[0].value);
            var area;

            if( $('#area').combobox('getValue') != row.area) {
                 area = $('#area').combobox('getValue');
            }else {
                area = row.areaid;
            }
            var  contact =     $.trim($("input[name='contact']")[0].value);
            var  telephone =      $.trim ($("input[name='telephone']")[0].value);
            var  explain =      $.trim($("input[name='explain']")[0].value);
            formData.append("id",id);
            formData.append("name",name);
            formData.append("address",address);
            formData.append("areaid",area);
            formData.append("contact",contact);
            formData.append("telephone",telephone);
            formData.append("explain",explain);
            if(name&&address&&area&&contact&&telephone&&explain)
            {
                $.ajax({
                    url:"<%=contextPath%>/Factory/Edit",
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        $('#table').datagrid('reload');
                        $('#dlg').dialog('close');
                        alert("修改工厂成功!");
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
        function editFactory() {
            var row = $("#table").datagrid('getSelected');
            if (row!=null) {
                var id = row.id;
                $('#submit').attr("onclick", "editcheckFactory()");
                var row = $("#table").datagrid('getSelected');

                $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改工厂');
                $("#fm").form("load", row);
            }
            else
            {
                alert("请选择工厂!");
            }

        }



/*  $( function () {
       $( '#area'  ).combotree ({
           url: "<%=contextPath%>/Factory/GetAreanode",
           onBeforeExpand : function (node) {

               $('#area').combotree("tree").tree("options").url = "<%=contextPath%>/Factory/GetAreanode?id="+node.id;

           }
       });

   });*/
    function deleteFactory() {


        var formData = new FormData();
        var row = $("#table").datagrid('getSelected');
        if (row!=null) {
        var id = row.id;
        formData.append("id",id);

            $.ajax({
                url:"<%=contextPath%>/Factory/Delete",
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
            alert("请选择工厂!");
        }


    }
        $.extend($.fn.validatebox.defaults.rules, {
            phoneRex: {
                validator: function(value){
                    var rex=/^1[3-8]+\d{9}$/;
                    //var rex=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                    //区号：前面一个0，后面跟2-3位数字 ： 0\d{2,3}
                    //电话号码：7-8位数字： \d{7,8
                    //分机号：一般都是3位数字： \d{3,}
                    //这样连接起来就是验证电话的正则表达式了：/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/
                    var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                    if(rex.test(value)||rex2.test(value))
                    {
                        // alert('t'+value);
                        return true;
                    }else
                    {
                        //alert('false '+value);
                        return false;
                    }

                },
                message: '不是正确的电话或手机号!'
            }
        });

        $(function(){
            $('input.easyui-validatebox').validatebox({
                tipOptions: {	// the options to create tooltip
                    showEvent: 'mouseenter',
                    hideEvent: 'mouseleave',
                    showDelay: 0,
                    hideDelay: 0,
                    zIndex: '',
                    onShow: function(){
                        if (!$(this).hasClass('validatebox-invalid')){
                            if ($(this).tooltip('options').prompt){
                                $(this).tooltip('update', $(this).tooltip('options').prompt);
                            } else {
                                $(this).tooltip('tip').hide();
                            }
                        } else {
                            $(this).tooltip('tip').css({
                                color: '#000',
                                borderColor: '#CC9933',
                                backgroundColor: '#FFFFCC'
                            });
                        }
                    },
                    onHide: function(){
                        if (!$(this).tooltip('options').prompt){
                            $(this).tooltip('destroy');
                        }
                    }
                }
            }).tooltip({
                position: 'right',
                content: function(){
                    var opts = $(this).validatebox('options');
                    return opts.prompt;
                },
                onShow: function(){
                    $(this).tooltip('tip').css({
                        color: '#000',
                        borderColor: '#CC9933',
                        backgroundColor: '#FFFFCC'
                    });
                }
            });
        });

        function query(){
            $('#table').datagrid('load',{
                name:$('#factoryname').val(),
            });
        }

    </script>
</head>
<body>
<script type="text/javascript">
</script>
<label for="zhan">数据维护</label>
<input class="easyui-combobox" id="zhan" name="zhan"/>&nbsp;
<h2 id="title">数据管理模块</h2><br/>

<div>
    <label for="factoryname">工厂名:</label>
    <input class="easyui-textbox" type="text" id="factoryname" name="factoryname">
    <a href="javascript:query();" class="easyui-linkbutton" data-options="iconCls:'icon-search'"
       style="width:100px">查询</a>
</div>


<table id="table"  class="easyui-datagrid"  style="width:100%;height:auto"
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'<%=contextPath%>/Factory/Get',method:'post'">
    <thead>
    <tr>
        <th field="id" width=auto>ID</th>
        <th field="name" width=auto>工厂名称</th>
        <th field="address" width=auto>工厂地址</th>
        <th field="areaid" width="auto">区域ID</th>
        <th field="area" width=auto>所在区域</th>
        <th field="contact" width=auto>联系人</th>
        <th field="telephone" width=auto>电话</th>
        <th field="explain" width=auto>备注</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addFactory()">新增工厂
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editFactory()">修改工厂
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteFactory()">移除工厂</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons" >
    <div class="ftitle">工厂信息</div>
    <form id="fm" method="post" novalidate="false">

        <div class="fitem">
            <label>工厂名称</label>
            <input name="name" class="easyui-textbox"  required="true">
        </div>
        <div class="fitem">
            <label>工厂地址</label>
            <input name="address" class="easyui-textbox" required="true">
        </div>
        <div>

        </div>
        <div class="fitem">
            <label>所在区域</label>
            <input name="area" id="area" class="easyui-combobox"
                   data-options="valueField:'id',textField:'name'"
                   url="<%=contextPath%>/Area/GetArea" required="true">
        </div>
        <div class="fitem">
            <label>联系人</label>
            <input name="contact" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>电话</label>
            <input name="telephone" class="easyui-textbox" data-options="required:true,missingMessage:'请输入正确电话或手机号',validType:'phoneRex'" required="true">
        </div>
        <div class="fitem">
            <label>备注</label>
            <input name="explain" class="easyui-textbox" required="true" >
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