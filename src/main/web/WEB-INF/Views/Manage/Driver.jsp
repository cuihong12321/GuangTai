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
    <title>司机管理</title>
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

    function addDriver() {


        $('#submit').attr("onclick","checkDriver()");
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '新增司机');
    }

    function checkDriver() {
        if(!$("#fm").form('validate')){

            alert("填写的信息有误，请重新填写!");
            return false;
        }
        var formData = new FormData();
        var name = $.trim($("input[name='name']")[0].value);
        var trucknumber = $.trim($("input[name='trucknumber']")[0].value);
        var telephone = $.trim($("input[name='telephone']")[0].value);
        var idcardnumber = $.trim($("input[name='idcardnumber']")[0].value);
        var address = $.trim($("input[name='address']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        formData.append("name", name);
        formData.append("trucknumber",trucknumber);
        formData.append("telephone",telephone);
        formData.append("idcardnumber",idcardnumber);
        formData.append("address",address);
        formData.append("explain", explain);
        if (name && trucknumber && telephone && idcardnumber && address && explain) {
            $.ajax({
                url: "<%=contextPath%>/Driver/Add",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert("添加司机成功!");
                },
                error: function (data) {

                }
            });
        }
        else {
            alert("必填项不能为空!");
        }

    }
    function editDriver() {

        $('#submit').attr("onclick","editcheckDriver()");
        var row = $("#table").datagrid('getSelected');
        id = row.id;
        if(row!=null){
        $('#dlg').dialog('open').dialog('center').dialog('setTitle', '修改司机');
        $("#fm").form("load",row);
    }
    else{
            alert("请选择司机!");
        }
    }
    function editcheckDriver() {
        if(!$("#fm").form('validate')){

            alert("填写的信息有误，请重新填写!");
            return false;
        }
        var formData = new FormData();
        var name = $.trim($("input[name='name']")[0].value);
        var trucknumber = $.trim($("input[name='trucknumber']")[0].value);
        var telephone = $.trim($("input[name='telephone']")[0].value);
        var idcardnumber = $.trim($("input[name='idcardnumber']")[0].value);
        var address = $.trim($("input[name='address']")[0].value);
        var explain = $.trim($("input[name='explain']")[0].value);
        formData.append("id",id);
        formData.append("name", name);
        formData.append("trucknumber",trucknumber);
        formData.append("telephone",telephone);
        formData.append("idcardnumber",idcardnumber);
        formData.append("address",address);
        formData.append("explain", explain);
        if(name && trucknumber && telephone && idcardnumber && address && explain)
        {
            $.ajax({
                url:"<%=contextPath%>/Driver/Edit",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    $('#dlg').dialog('close');
                    alert("修改司机成功!");
                },
                error: function (data) {

                }
            });

        }
        else
        {
            alert("必填项不能为空");
        }
    }
    function deleteDriver() {

        var formData = new FormData();
        var row = $("#table").datagrid('getSelected');
        if(row!=null){
        var id = row.id;
        formData.append("id",id);

            $.ajax({
                url:"<%=contextPath%>/Driver/Delete",
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    $('#table').datagrid('reload');
                    alert("删除司机成功!");
                },
                error: function (data) {
                    alert("删除失败!");
                }
            });
        }
        else
        {
            alert("请选择司机!");
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



    var aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"};

    function isCardID(sId){
        var iSum=0 ;
        var info="" ;
        if(!/^\d{17}(\d|x)$/i.test(sId)) return "你输入的身份证长度或格式错误!";
        sId=sId.replace(/x$/i,"a");
        if(aCity[parseInt(sId.substr(0,2))]==null) return "你的身份证地区非法!";
        sBirthday=sId.substr(6,4)+"-"+Number(sId.substr(10,2))+"-"+Number(sId.substr(12,2));
        var d=new Date(sBirthday.replace(/-/g,"/")) ;
        if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate()))return "身份证上的出生日期非法!";
        for(var i = 17;i>=0;i --) iSum += (Math.pow(2,i) % 11) * parseInt(sId.charAt(17 - i),11) ;
        if(iSum%11!=1) return "你输入的身份证号非法!";
        return true;//aCity[parseInt(sId.substr(0,2))]+","+sBirthday+","+(sId.substr(16,1)%2?"男":"女")
    }


    $.extend($.fn.validatebox.defaults.rules, {
        idcared: {
            validator: function(value,param){
                var flag= isCardID(value);
                return flag==true?true:false;
            },
            message: '不是有效的身份证号码!'
        }
    });
</script>
<body>
<script type="text/javascript">
</script>
<label for="zhan">数据维护</label>
<input class="easyui-combobox" id="zhan" name="zhan"/>&nbsp;
<h2 id="title">数据管理模块</h2><br/>

<table id="table" class="easyui-datagrid" style="width:100%;height:auto"
       data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:20,url:'<%=contextPath%>/Driver/Get',method:'post'">
    <thead>
    <tr>
        <th field="id" width=auto>ID</th>
        <th field="name" width=auto>司机姓名</th>
        <th field="trucknumber" width=auto>车牌号</th>
        <th field="telephone" width=auto>电话</th>
        <th field="idcardnumber" width=auto>身份证</th>
        <th field="address" width=auto>地址</th>
        <th field="explain" width=auto>备注</th>
    </tr>

    </thead>
    <tbody>

    </tbody>
</table>

<div id="toolbar">
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addDriver()">新增司机
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editDriver()">修改司机
    </a>
    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteDriver()">移除司机</a>
</div>
<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
     closed="true" buttons="#dlg-buttons">
    <div class="ftitle">司机</div>
    <form id="fm" method="post" novalidate="false">

        <div class="fitem">
            <label>司机姓名</label>
            <input name="name" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>车牌号</label>
            <input name="trucknumber" class="easyui-textbox" required="true">
        </div>
        <div class="fitem">
            <label>电话</label>
            <input name="telephone" class="easyui-textbox" data-options="required:true,missingMessage:'请输入正确电话或手机号',validType:'phoneRex'" required="true">
        </div>
        <div class="fitem">
            <label>身份证</label>
            <input name="idcardnumber" class="easyui-textbox" data-options="required:true,missingMessage:'请输入身份证号',validType:'idcared'" required="true">
        </div>
        <div class="fitem">
            <label>地址</label>
            <input name="address" class="easyui-textbox" required="true">
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
