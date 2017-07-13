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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>权限管理</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <script src="<%=contextPath%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/17.1.3/css/dx.spa.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdn3.devexpress.com/jslib/17.1.3/css/dx.common.css"/>
    <link rel="dx-theme" data-theme="generic.light" href="https://cdn3.devexpress.com/jslib/17.1.3/css/dx.light.css"/>
    <script src="https://cdn3.devexpress.com/jslib/17.1.3/js/dx.all.js"></script>
    <style>
        #gridContainer {
            height: auto;
            width: 100%;
        }

        #data-grid-demo {
            min-height: 530px;
        }
    </style>
    <script>
        var gridDataSource = new DevExpress.data.DataSource({
            key: "id",
            loadMode: "raw",
            load: function() {
                return $.getJSON("<%=contextPath%>/RoleMenu/GetAll");
            },
            // 插入数据
            insert: function (values) {
                return $.ajax({
                    url: "<%=contextPath%>/RoleMenu/Add/",
                    method: "POST",
                    data: values
                })
            },
            //删除数据
            remove: function (key) {
                return $.ajax({
                    url: "<%=contextPath%>/RoleMenu/Delete/" + key,
                    method: "POST"
                })
            },
            update: function (key, values) {
                $.ajax({
                    url: "<%=contextPath%>/RoleMenu/Edit/" + key,
                    method: "POST",
                    data: values
                })
            }
        });

        $(function () {
            $("#gridContainer").dxTreeList({
                dataSource: gridDataSource,
                keyExpr: "id",
                parentIdExpr: "menuid",
                editing: {
                    mode: "popup",
                    allowUpdating: true,
                    allowDeleting: true,
                    allowAdding: true,
                    popup: {
                        title: "Employee Info",
                        showTitle: true,
                        width: 700,
                        height: 345,
                        position: {
                            my: "top",
                            at: "top",
                            of: window
                        }
                    }
                },
                showColumnLines: true,
                showRowLines: true,
                rowAlternationEnabled: true,
                showBorders: true,
                columnAutoWidth: true,
                selection: {
                    mode: "multiple"
                },
                columns: [
                    {
                        dataField: "roleid",
                        width: 170
                    },
                    {
                        dataField: "menuid",
                        width: 170
                    },
                    {
                        dataField: "updatetime",
                        dataType: "date",
                        width: 170
                    },
                    {
                        dataField: "remark",
                        width: 170
                    }
                ],
                onCellPrepared: function(e) {
                    if(e.column.command === "edit") {
                        e.cellElement.children(".dx-link-add").remove();
                    }
                },
                expandedRowKeys: [2]
            });
        });
    </script>
</head>
<body class="dx-viewport">
<div class="demo-container">
    <div class="demo-container">
        <div id="data-grid-demo">
            <div id="gridContainer"></div>
        </div>
    </div>
</div>
</body>
</html>
