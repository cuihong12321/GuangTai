<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: haoyue001
  Date: 2016/11/26
  Time: 15:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>用户管理</title>
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="<%=contextPath%>/resources/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet"
          href="<%=contextPath%>/resources/bower_components/datatables.net-bs/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/kindeditor/themes/default/default.css">
    <link rel="stylesheet"
          href="<%=contextPath%>/resources/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/css/css.css">
    <link rel="stylesheet"
          href="<%=contextPath%>/resources/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet"
          href="<%=contextPath%>/resources/bower_components/datatables.net-bs/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/uploader.css">
    <script src="<%=contextPath%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="<%=contextPath%>/resources/librarys/kindeditor/kindeditor-all-min.js"></script>
    <script src="<%=contextPath%>/resources/librarys/kindeditor/lang/zh-CN.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/bootstrap-select/dist/js/i18n/defaults-zh_CN.min.js"></script>
    <style>
        tbody img {
            height: 100px;
        }
    </style>
    <script type="text/javascript">
        //模式： 0：添加 1：修改、 2：删除
        var mode = 0, editor;

        $(function () {
            var table = $("#table").DataTable({
                language: {
                    url: '<%=contextPath%>/resources/bower_components/datatables.net/Chinese.json'
                },
                "bFilter": false,
                "processing": true,
                "serverSide": true,
                "ajax": {
                    "url": "<%=contextPath%>/User/GetAll",
                    "type": 'POST',
                    "data": function (d) {
                        //添加额外的参数传给服务器
                        d.idcardnumber = $("#txtIdCardNumber1").val();
                        d.username = $("#txtUserName1").val();
                        d.telephone = $("#txtTelephone1").val();
                        d.roleid = $("#txtRolid1").selectpicker("val");
                        d.regionid = $("#txtRegionid").selectpicker("val");
                    }
                },
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": false,
                        "searchable": true
                    },
                    {
                        "targets": [4],
                        "visible": false,
                        "searchable": true
                    },
                    {
                        "targets": [7],
                        "visible": false,
                        "searchable": true
                    },
                    {
                        "targets": [19],
                        "visible": false,
                        "searchable": true
                    },
                    {
                        "targets": [20],
                        "visible": false,
                        "searchable": true
                    },
                    {
                        "targets": [21],
                        "visible": false,
                        "searchable": true
                    }
                ],
                "columns": [
                    {"data": "id"},
                    {"data": "role"},
                    {
                        "data": "headicon",
                        "render": function (data, type, row) {
                            return '<img src="<%=contextPath%>' + data + '" />';
                        }
                    },
                    {"data": "username"},
                    {"data": "password"},
                    {"data": "realname"},
                    {"data": "telephone"},
                    {"data": "sex"},
                    {"data": "sexname"},
                    {"data": "birthday"},
                    {"data": "idcardnumber"},
                    {"data": "drivinglicensetype"},
                    {"data": "drivinglicensenumber"},
                    {"data": "email"},
                    {"data": "region"},
                    {"data": "address"},
                    {"data": "referrer"},
                    {"data": "point"},
                    {"data": "balance"},
                    {"data": "wechatid"},
                    {"data": "qqid"},
                    {"data": "isdisabled"},
                    {"data": "isdisabledname"},
                    {"data": "registertime"},
                    {"data": "remark"}
                ]
            });

            $('#table tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            $("#btnSearch").on("click", function () {
                table.ajax.reload();
            });

            $("#btnAdd").on("click", function () {
                mode = 0;                               //执行添加方法

                $("#role").selectpicker('val', '');
                $("#txtImageName").val("");
                $("#txtUserName").val("");
                $("#txtPassword").val("");
                $("#txtPassword1").val("");
                $("#txtRealName").val("");
                $("#txtTelephone").val("");
                $("#sex").selectpicker('val', '');
                $("#txtBirthday").val("");
                $("#txtIdCardNumber").val("");
                $("#DrivingLicenseType").val("");
                $("#DrivingLicenseNumber").val("");
                $("#txtEmail").val("");
                $("#region").selectpicker('val', '');
                $("#txtAddress").val("");
                $("#referrer").val();
                $("#point").val("");
                $("#balance").val("");
                $("#wechatid").val("");
                $("#qqid").val("");
                $("#disabled").val();
                $("#txtRemark").val("");

                $('#modal').modal('show');
            });

            $("#btnEdit").on("click", function () {
                var data = table.row('.selected').data();

                if (data == undefined) {
                    alert("请选中一行数据!");
                    return;
                }

                mode = 1;
                $("#role").selectpicker('val', data.roleid);
                $("#region").selectpicker('val', data.regionid);
                $(".selectpicker").selectpicker("refresh");
                $("#txtImageName").val(data.headicon);
                $("#txtUserName").val(data.username);
                $("#txtPassword").val("");
                $("#txtPassword1").val("");
                $("#txtRealName").val(data.realname);
                $("#txtTelephone").val(data.telephone);
                $("#sex").selectpicker('val', data.sex);
                $("#txtBirthday").val(data.birthday);
                $("#txtIdCardNumber").val(data.idcardnumber);
                $("#DrivingLicenseType").val(data.drivinglicensetype);
                $("#DrivingLicenseNumber").val(data.drivinglicensenumber);
                $("#txtEmail").val(data.email);
                $("#txtAddress").val(data.address);
                $("#referrer").selectpicker('val', data.referrerid);
                $("#point").val(data.point);
                $("#balance").val(data.balance);
                $("#wechatid").val(data.wechatid);
                $("#qqid").val(data.qqid);
                $("#disabled").selectpicker('val', data.isdisabled);
                $("#txtRemark").val(data.remark);
                $('#modal').modal("show");
            });

            $("#btnDelete").on("click", function () {
                var data = table.row('.selected').data();

                if (data == undefined) {
                    alert("请选中一行数据!");
                    return;
                }

                mode = 2;
                if (confirm("确定要删除该条记录吗？")) {
                    $.ajax({
                        type: "POST",
                        url: '<%=contextPath%>' + "/User/Delete",
                        cache: false,
                        dataType: "json",
                        data: {
                            id: data.id
                        },
                        success: function (data) {
                            alert(data.data);

                            $('#modal').modal("hide");
                            table.ajax.reload();
                        },
                        error: function (data) {
                            alert(data.data);
                        }
                    });
                }
            });

            $("#btnSave").on("click", function () {

//                if ($("#role").val() == "") {
//                    alert("角色不能为空！");
//                    return;
//                }
//
//                var str = $("#txtImageName").val();
//                if(str.length==0)
//                {
//                    alert("请选择上传");
//                    return;
//                }
//
//                if ($("#txtUserName").val() == "") {
//                    alert("用户名不能为空！");
//                    return;
//                }
//


                var  a=$("#txtPassWord").val();
                var  b=$("#txtPassWord1").val();

                    if (a != b) {
                        alert("两次密码输入不一致请重新输入");
                        return;
                    }




//                if ($("#txtRealName").val() == "") {
//                    alert("姓名不能为空！");
//                    return;
//                }
//
//                if ($("#txtTelephone").val() == "") {
//                    alert("电话不能为空！");
//                    return;
//                }
//
//                if ($("#sex").val() == "") {
//                    alert("性别不能为空！");
//                    return;
//                }
//
//                if ($("#txtBirthday").val() == "") {
//                    alert("生日不能为空！");
//                    return;
//                }
//
//                if ($("#txtIdcardnumber").val() == "") {
//                    alert("身份证号不能为空！");
//                    return;
//                }
//
//                if ($("#DrivingLicenseType").val() == "") {
//                    alert("驾驶证类型不能为空！");
//                    return;
//                }
//
//                if ($("#DrivingLicenseNumber").val() == "") {
//                    alert("驾驶证号码不能为空！");
//                    return;
//                }
//
//                if ($("#txtEmail").val() == "") {
//                    alert("邮箱不能为空！");
//                    return;
//                }
//
//                if ($("#region").val() == "") {
//                    alert("区域不能为空！");
//                    return;
//                }
//
//                if ($("#txtAddress").val() == "") {
//                    alert("地址不能为空！");
//                    return;
//                }


                var formData = new FormData();

                formData.append("role", $("#role").selectpicker('val'));
                formData.append("headicon", $("#txtImage")[0].files[0]);
                formData.append("username", $("#txtUserName").val());
                formData.append("password", $("#txtPassword").val());
                formData.append("password1", $("#txtPassword1").val());
                formData.append("realname", $("#txtRealName").val());
                formData.append("telephone", $("#txtTelephone").val());
                formData.append("sex", $("#sex").selectpicker('val'));
                formData.append("birthday", $("#txtBirthday").val());
                formData.append("idcardnumber", $("#txtIdCardNumber").val());
                formData.append("drivinglicensetype", $("#DrivingLicenseType").val());
                formData.append("drivinglicensenumber", $("#DrivingLicenseNumber").val());
                formData.append("email", $("#txtEmail").val());
                formData.append("region", $("#region").selectpicker('val'));
                formData.append("address", $("#txtAddress").val());
                formData.append("referrer", $("#referrer").val());
                formData.append("point", $("#point").val());
                formData.append("balance", $("#balance").val());
                formData.append("wechatid", $("#wechatid").val());
                formData.append("qqid", $("#qqid").val());
                formData.append("isdisabled", $("#disabled").val());
                formData.append("remark", $("#txtRemark").val());

                if (mode == 0) {

                    $.ajax({
                        type: "POST",
                        url: '<%=contextPath%>' + "/User/Add",
                        cache: false,
                        //dataType: "json",
                        contentType: false,
                        processData: false,
                        data: formData,
                        success: function (data) {              //数组
                            var json = JSON.parse(data);
                            alert(json.data);
                            if (json.success) {
                                $("#role").selectpicker('val', '');
                                $("#region").selectpicker('val', '');
                                $("#sex").selectpicker('val', '');
                                $("#txtImageName").val("");
                                $("#txtUserName").val("");
                                $("#txtPassword").val("");
                                $("#txtPassword1").val("");
                                $("#txtRealName").val("");
                                $("#txtTelephone").val("");
                                $("#txtBirthday").val("");
                                $("#txtIdCardNumber").val("");
                                $("#DrivingLicenseType").val("");
                                $("#DrivingLicenseNumber").val("");
                                $("#txtEmail").val("");
                                $("#txtAddress").val("");
                                $("#point").val("");
                                $("#balance").val("");
                                $("#wechatid").val("");
                                $("#qqid").val("");
                                $("#txtRemark").val("");

                                $('#modal').modal("hide");
                                table.ajax.reload();
                            } else {
                                alert(data.data);
                            }
                        },
                    });

                } else if (mode == 1) {
                    var data = table.row('.selected').data();

                    formData.append("id", data.id);

                    $.ajax({
                        type: "POST",
                        url: '<%=contextPath%>' + "/User/Edit",
                        cache: false,
                        //dataType: "json",
                        contentType: false,
                        processData: false,
                        data: formData,
                        success: function (data) {
                            var json = JSON.parse(data);

                            if (json.success) {
                                $("#role").selectpicker('val', '');
                                $("#region").selectpicker('val', '');
                                $("#sex").selectpicker('val', '');

                                $("#txtImageName").val("");
                                $("#txtUserName").val("");
                                $("#txtPassword").val("");
                                $("#txtPassword1").val("");
                                $("#txtRealName").val("");
                                $("#txtTelephone").val("");
                                $("#txtBirthday").val("");
                                $("#txtIdCardNumber").val("");
                                $("#DrivingLicenseType").val("");
                                $("#DrivingLicenseNumber").val("");
                                $("#txtEmail").val("");
                                $("#txtAddress").val("");
                                $("#point").val("");
                                $("#balance").val("");
                                $("#wechatid").val("");
                                $("#qqid").val("");
                                $("#txtRemark").val("");

                                $('#modal').modal('hide');
                                table.ajax.reload();
                            } else {
                                alert(json.data);
                            }
                        },
                        error: function (data) {
                            alert(data.data);
                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
<%--增加、删除、修改按钮--%>
<div class="col-lg-12 modal-search pt20">
    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <a id="btnAdd" class="btn search-button1" href="#"><i class="glyphicon glyphicon-plus"></i>添加</a>
        </div>
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <a id="btnEdit" class="btn search-button1" href="#"><i class="glyphicon glyphicon-pencil"></i>修改</a>
        </div>
    </div>
    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <a id="btnDelete" class="btn search-button1" href="#"><i class="glyphicon glyphicon-trash"></i>删除</a>
        </div>
    </div>

    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <input id="txtUserName1" style="width: 120px;height: 35px" type="text" placeholder="请输入用户名">
        </div>
    </div>

    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <input id="txtTelephone1" style="width: 120px;height: 35px" type="text" placeholder="请输入手机号">
        </div>
    </div>

    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <input id="txtIdCardNumber1" style="width: 160px;height: 35px" type="text" placeholder="请输入身份证号">
        </div>
    </div>


        <div class="input-group col-lg-2 col-md-2 col-sm-2 col-xs-8">
            <div class="" style="">用户角色</div>
            <select id="txtRolid1" class="selectpicker">
                <c:forEach var="role" items="${list}" varStatus="status">
                    <option value="${role.id}">${role.name}</option>
                </c:forEach>
            </select>
        </div>


        <div class="input-group col-lg-2 col-md-2 col-sm-2 col-xs-8">
            <div class="">地区</div>
            <select id="txtRegionid" class="selectpicker">
                <c:forEach var="region" items="${list1}" varStatus="status">
                    <option value="${region.id}">${region.name}</option>
                </c:forEach>
            </select>
        </div>


    <div class="col-lg-1 col-md-1 col-sm-1 form-group">
        <div class="input-group search">
            <a id="btnSearch" class="btn search-button1" href="#"><i class="glyphicon glyphicon-pencil"></i>查询</a>
        </div>
    </div>

</div>
<table id="table" class="display" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>id</th>
        <th>角色</th>
        <th>用户头像</th>
        <th>用户名</th>
        <th>密码</th>
        <th>真实姓名</th>
        <th>手机号</th>
        <th>性别ID</th>
        <th>性别</th>
        <th>生日</th>
        <th>身份证号</th>
        <th>驾照类型</th>
        <th>驾照号码</th>
        <th>邮箱</th>
        <th>区域</th>
        <th>地址</th>
        <th>推荐人</th>
        <th>积分</th>
        <th>账户金额</th>
        <th>微信openid</th>
        <th>QQopenid</th>
        <th>是否禁用ID</th>
        <th>是否禁用</th>
        <th>注册时间</th>
        <th>备注</th>
    </tr>
    </thead>
</table>
<div id="modal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">

            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="关闭"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">用户</h4>
            </div>

            <div class="modal-body">
                <div class="modal-search">
                    <div class="col-lg-8 col-md-8 col-sm-8 col-xs-8 pl20">

                        <div class="form-group">
                            <div class="input-group col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <div class="input-group-addon">用户角色</div>
                                <select id="role" class="selectpicker">
                                    <c:forEach var="role" items="${list}" varStatus="status">
                                        <option value="${role.id}">${role.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">上传头像</div>
                                <%--<input id="txtImage" name="image" class="form-control" type="file" placeholder="请选择图片">--%>
                                <div class="uploader white form-control">
                                    <input id="txtImageName" type="text" class="filename" readonly/>
                                    <input type="button" name="file" class="button" value="查找..."/>
                                    <input id="txtImage" type="file" size="30"/>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">用户名</div>
                                <input id="txtUserName" class="form-control" type="text" placeholder="请输入用户名">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">新密码</div>
                                <input id="txtPassword" class="form-control" type="password" placeholder="请输入新密码">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">确认密码</div>
                                <input id="txtPassword1" class="form-control" type="password" placeholder="请确认新密码">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">真实姓名</div>
                                <input id="txtRealName" class="form-control" type="text" placeholder="请输姓名">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">电话</div>
                                <input id="txtTelephone" class="form-control" type="text" placeholder="请输入电话">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <div class="input-group-addon">性别</div>
                                <select id="sex" class="selectpicker">
                                    <option value="0">男</option>
                                    <option value="1">女</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">生日</div>
                                <input id="txtBirthday" class="form-control" type="text"
                                       placeholder="请输生日,例如1990-01-01">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">身份证号</div>
                                <input id="txtIdCardNumber" class="form-control" type="text" placeholder="请输入身份证号">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">驾驶证类型</div>
                                <input id="DrivingLicenseType" class="form-control" type="text" placeholder="请输入驾驶证类型">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">驾驶证号码</div>
                                <input id="DrivingLicenseNumber" class="form-control" type="text"
                                       placeholder="请输入驾驶证号码">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">邮箱</div>
                                <input id="txtEmail" class="form-control" type="text" placeholder="请输入邮箱">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <div class="input-group-addon">区域</div>
                                <select id="region" class="selectpicker">
                                    <c:forEach var="region" items="${list1}" varStatus="status">
                                        <option value="${region.id}">${region.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">地址</div>
                                <input id="txtAddress" class="form-control" type="text" placeholder="请输入地址">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <div class="input-group-addon">推荐人</div>
                                <select id="referrer" class="selectpicker">
                                    <c:forEach var="referrer" items="${list2}" varStatus="status">
                                        <option value="${referrer.id}">${referrer.username}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">积分</div>
                                <input id="point" class="form-control" type="text" placeholder="请输入积分">
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">账户余额</div>
                                <input id="balance" class="form-control" type="text" placeholder="请输入账户余额">
                            </div>
                        </div>

                        <%--<div class="form-group">--%>
                        <%--<div class="input-group">--%>
                        <%--<div class="input-group-addon">微信OpenID</div>--%>
                        <%--<input id="wechatid" class="form-control" type="text" placeholder="请输入微信OpenID">--%>
                        <%--</div>--%>
                        <%--</div>--%>

                        <%--<div class="form-group">--%>
                        <%--<div class="input-group">--%>
                        <%--<div class="input-group-addon">QQOpenID</div>--%>
                        <%--<input id="qqid" class="form-control" type="text" placeholder="请输入QQOpenID">--%>
                        <%--</div>--%>
                        <%--</div>--%>

                        <div class="form-group">
                            <div class="input-group col-lg-8 col-md-8 col-sm-8 col-xs-8">
                                <div class="input-group-addon">是否禁用</div>
                                <select id="disabled" class="selectpicker">
                                    <option value="false">否</option>
                                    <option value="true">是</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">备注</div>
                                <input id="txtRemark" class="form-control" type="text" placeholder="请输入备注">
                            </div>
                        </div>
                    </div>

                    <%-- &lt;%&ndash;视频内容&ndash;%&gt;
                     <textarea id="content" name="content" style="width:800px;height:200px;"></textarea>--%>

                </div>
                <div class="clear"></div>
            </div>
            <div class="modal-footer">
                <button id="btnSave" type="button" class="btn btn-primary save-color"><i
                        class="glyphicon glyphicon-ok"></i>保存
                </button>
                <button type="button" class="btn btn-default" data-dismiss="modal"><i
                        class="glyphicon glyphicon-remove"></i>关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
<script>
    $(function () {
        $("input[type=file]").change(function () {
            $(this).parents(".uploader").find(".filename").val($(this).val());
        });
        $("input[type=file]").each(function () {
            if ($(this).val() == "") {
                $(this).parents(".uploader").find(".filename").val("No file selected...");
            }
        });
    });
</script>
</html>