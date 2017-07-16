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
    <title>DevExtreme Demo</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
    <script src="<%=contextPath%>/resources/bower_components/jquery/dist/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/bower_components/devextreme/css/dx.spa.css"/>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/resources/bower_components/devextreme/css/dx.common.css"/>
    <link rel="dx-theme" data-theme="generic.light" href="<%=contextPath%>/resources/bower_components/devextreme/css/dx.light.css"/>
    <script src="<%=contextPath%>/resources/bower_components/devextreme/js/dx.all.js"></script>
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
        var store = new DevExpress.data.ODataStore({
            url: "<%=contextPath%>/Menu/GetAll"
        });

        var gridDataSource = new DevExpress.data.DataSource({
            key: "id",
            loadMode: "raw",
            load: function() {
                return $.getJSON("<%=contextPath%>/Menu/GetAll");
            },
            // 插入数据
            insert: function (values) {
                return $.ajax({
                    url: "<%=contextPath%>/Menu/Add/",
                    method: "POST",
                    data: values
                })
            },
            //删除数据
            remove: function (key) {
                return $.ajax({
                    url: "<%=contextPath%>/Menu/Delete/" + key,
                    method: "POST"
                })
            },
            update: function (key, values) {
                $.ajax({
                    url: "<%=contextPath%>/Menu/Edit/" + key,
                    method: "POST",
                    data: values
                })
            }
        });

        $(function () {
            $("#gridContainer").dxTreeList({
                dataSource: gridDataSource,
                keyExpr: "id",
                parentIdExpr: "parentid",
                editing: {
                    mode: "popup",
                    allowUpdating: true,
                    allowDeleting: true,
                    allowAdding: true,
                    texts: {
                        confirmDeleteMessage: "确认删除吗？"
                    },
                    popup: {
                        title: "菜单",
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
                allowColumnReordering: true,
                allowColumnResizing: true,
                columnFixing: {
                    enabled: true
                },
                selection: {
                    mode: "multiple"
                },
                loadPanel: {
                    enabled: true
                },
                columns: [
                    {
                        dataField: "image",
                        width: 300,
                        fixed: true
                    },
                    {
                        dataField: "name",
                        width: 300
                    },
                    {
                        dataField: "url",
                        width: 300
                    },
                    {
                        dataField: "parentid",
                        caption: "父级菜单",
                        lookup: {
                            valueExpr: "id",
                            displayExpr: "name",
                            dataSource: {
                                store: store
                            }
                        },
                        width: 300
                    },
                    {
                        dataField: "updatetime",
                        dataType: "date",
                        width: 300
                    },
                    {
                        dataField: "remark",
                        width: 300
                    }
                ],
                onCellPrepared: function(e) {
                    if(e.column.command === "edit") {
                        e.cellElement.children(".dx-link-add").remove();
                    }
                },
                expandedRowKeys: [2],
                onToolbarPreparing: function(e) {
                    var dataGrid = e.component;

                    e.toolbarOptions.items.unshift({
                        location: "after",
                        widget: "dxButton",
                        options: {
                            hint: "展开",
                            icon: "chevrondown",
                            onClick: function(e) {
                                var expanding = e.component.option("icon") === "chevronnext";
                                dataGrid.option("grouping.autoExpandAll", expanding);
                                e.component.option({
                                    icon: expanding ? "chevrondown": "chevronnext",
                                    hint: expanding ? "Collapse All" : "Expand All"
                                });
                            }
                        }
                    }, {
                        location: "after",
                        widget: "dxButton",
                        options: {
                            hint: "刷新",
                            icon: "refresh",
                            onClick: function() {
                                dataGrid.refresh();
                            }
                        }
                    });
                }
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
