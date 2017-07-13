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
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>角色管理</title>
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/datatables.net-bs/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/librarys/kindeditor/themes/default/default.css">
    <link rel="stylesheet"
          href="<%=contextPath%>/resources/bower_components/bootstrap-select/dist/css/bootstrap-select.min.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/css/css.css">
    <script src="<%=contextPath%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="<%=contextPath%>/resources/librarys/kindeditor/kindeditor-all-min.js"></script>
    <script src="<%=contextPath%>/resources/librarys/kindeditor/lang/zh-CN.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script src="<%=contextPath%>/resources/bower_components/bootstrap-select/dist/js/i18n/defaults-zh_CN.min.js"></script>
    <script type="text/javascript">
        //模式： 0：添加 1：修改、 2：删除
        var mode = 0;
        $(function () {
            var table = $("#table").DataTable({
                language: {
                    url: '<%=contextPath%>/resources/bower_components/datatables.net/Chinese.json'
                },
                "bFilter": false,
                "processing": true,
                "serverSide": true,
                "ajax": "<%=contextPath%>/Role/GetAll",
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": false,
                        "searchable": true
                    }
                ],
                "columns": [
                    {"data": "id"},
                    {"data": "parent"},
                    {"data": "name"},
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

            $("#btnAdd").on("click", function () {
                mode = 0;  //添加

                $("#parent").val();
                $("#txtName").val("");
                $("#txtRemark").val("");

                $('#modal').modal('show');
            });

            $("#btnEdit").on("click", function () {
                var data = table.row('.selected').data();

                if (data == undefined) {
                    alert("请选中一行数据!");
                    return;
                }

                mode = 1;  //修改

                $("#parent").val();
                $("#txtName").val(data.name);
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
                        url: '<%=contextPath%>' + "/Role/Delete",
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

//                if ($("#parent").val() == "") {
//                    alert("上级不能为空！");
//                    return;
//                }

                if ($("#txtName").val() == "") {
                    alert("角色名称不能为空！");
                    return;
                }

                if ($("#txtRemark").val() == "") {
                    alert("备注不能为空！");
                    return;
                }

                if (mode == 0) {
                    var formData = new FormData();
                    var parent = $("#parent").val();
                    var name = $("#txtName").val();
                    var remark = $("#txtRemark").val();
                    formData.append("parent",parent);
                    formData.append("name",name);
                    formData.append("remark",remark);
                    $.ajax({
                        type: "POST",
                        url: '<%=contextPath%>' + "/Role/Add",
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            var json = JSON.parse(data);
                            alert(json.data);
                            if (json.success){
                                $("#txtName").val("");
                                $("#txtRemark").val("");

                                $('#modal').modal("hide");
                                table.ajax.reload();
                            }

                        },
                        error: function (data) {
                            alert(data.data);
                        }
                    });
                } else if (mode === 1) {
                    var data = table.row('.selected').data();
                    var formData = new FormData();
                    var parent = $("#parent").val();
                    var name = $("#txtName").val();
                    var remark = $("#txtRemark").val();
                    formData.append("id", data.id);
                    formData.append("parent",parent);
                    formData.append("name",name);
                    formData.append("remark",remark);
                    $.ajax({
                        type: "POST",
                        url: '<%=contextPath%>' + "/Role/Edit",
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (data) {
                            var json = JSON.parse(data);
                            alert(json.data);
                            if (json.success){
                                $("#txtName").val("");
                                $("#txtRemark").val("");

                                $('#modal').modal('hide');
                                table.ajax.reload();
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
</div>
<table id="table" class="display" cellspacing="0" width="100%">
    <thead>
    <tr>
        <th>id</th>
        <th>上级名称</th>
        <th>角色名称</th>
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
                <h4 class="modal-title">角色</h4>
            </div>
            <div class="modal-body">
                <div class="col-lg-12 modal-search">
                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">上级名称</div>
                            <select id="parent" class="selectpicker">
                                <c:forEach  var="parent" items="${list}" varStatus="status">
                                    <option value="${parent.id}">${parent.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-lg-5 mt30">
                        <div class="input-group">
                            <div class="input-group-addon">角色名称</div>
                            <input id="txtName" class="form-control" type="text" placeholder="请输入角色名称">
                        </div>
                    </div>
                    <div class="form-group col-lg-5 mt30">
                        <div class="input-group">
                            <div class="input-group-addon">备注</div>
                            <input id="txtRemark" class="form-control" type="text" placeholder="请输入备注">
                        </div>
                    </div>
                </div>
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
</html>