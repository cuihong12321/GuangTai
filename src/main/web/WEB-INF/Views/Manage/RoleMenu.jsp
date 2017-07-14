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
    <title>DevExtreme Demo</title>
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

        .save .dx-button-content {
            padding: 4px 12px;
        }

        .save .dx-button-content .dx-icon {
            width: 30px;
            height: 30px;
        }

        #popup {
            padding: 10px;
        }

        .button-info {
            margin: 10px;
        }

        .popup p {
            margin-bottom: 60px;
            margin-top: 60px;
            margin-left: 60px;
        }
    </style>
    <script>
        $(function () {
            var ids;
            var result;
            var gridDataSource = new DevExpress.data.DataSource({
                key: "id",
                loadMode: "raw",
                load: function () {
                    return $.getJSON("<%=contextPath%>/RoleMenu/GetRole");
                }
            });

            var store = new DevExpress.data.ODataStore({
                url: "<%=contextPath%>/Menu/GetAll"
            });

            var treeDataSource = new DevExpress.data.DataSource({
                key: "id",
                loadMode: "raw",
                load: function () {
                    return $.getJSON("<%=contextPath%>/Menu/GetAll");
                }
            });

//            function foreachNodes(nodes, func) {
//                for (var i = 0; i < nodes.length; i++) {
//                    func(nodes[i]);
//                    foreachNodes(nodes[i].children, func);
//                }
//            }


            $(function () {
                var treeListInstance = $("#dxTreeList").dxTreeList({
                    dataSource: treeDataSource,
                    keyExpr: "id",
                    parentIdExpr: "parentid",
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
                            dataField: "image",
                            caption: "菜单图片",
                            width: 300
                        },
                        {
                            dataField: "name",
                            caption: "菜单名称",
                            width: 300
                        },
                        {
                            dataField: "url",
                            caption: "菜单链接",
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
                            caption: "更新时间",
                            dataType: "date",
                            width: 300
                        },
                        {
                            dataField: "remark",
                            caption: "备注",
                            width: 300
                        }
                    ],
                    onCellPrepared: function (e) {
                        if (e.column.command === "edit") {
                            e.cellElement.children(".dx-link-add").remove();
                        }
                    },
//                    expandedRowKeys: [1],
                    autoExpandAll: true,
                    onToolbarPreparing: function (e) {
                        var dataGrid = e.component;
                        e.toolbarOptions.items.unshift({
                            location: "after",
                            widget: "dxButton",
                            options: {
                                hint: "刷新",
                                icon: "refresh",
                                onClick: function () {
                                    dataGrid.refresh();
                                }
                            }
                        });
                    },
//                    onSelectionChanged: function (e) {
//                        if (e.component._skipChildrenProcessing) return;
//                        var currentSelectedRowKeys = e.currentSelectedRowKeys;
//                        var currentDeselectedRowKeys = e.currentDeselectedRowKeys;
//
//                        if (currentSelectedRowKeys.length === 1 || currentDeselectedRowKeys.length === 1) {
//                            var key = currentSelectedRowKeys.length ? currentSelectedRowKeys[0] : currentDeselectedRowKeys[0];
//                            var rowIndex = e.component.getRowIndexByKey(key);
//                            var row = e.component.getVisibleRows()[rowIndex];
//                            var childrenKeys = [];
//
//                            if (!row) return;
//
//                            foreachNodes(row.node.children, function (node) {
//                                childrenKeys.push(node.key);
//                            });
//
//                            (currentSelectedRowKeys.length ? e.component.selectRows(childrenKeys, true) : e.component.deselectRows(childrenKeys)).done(function () {
//                                var node = row.node;
//                                var parentRowIndexes = [];
//
//                                while (node.parent) {
//                                    node = node.parent;
//                                    rowIndex = e.component.getRowIndexByKey(node.key);
//                                    row = e.component.getVisibleRows()[rowIndex];
//                                    if (row) {
//                                        parentRowIndexes.push(rowIndex);
//                                    }
//                                }
//
//                                if (parentRowIndexes.length) {
//                                    e.component.repaintRows(parentRowIndexes);
//                                }
//                            });
//                        }
//                    },
//                    onCellPrepared: function (e) {
//                        if (e.columnIndex === 0 && e.row && e.row.rowType === "data") {
//                            var isSelected = e.row.isSelected,
//                                allChildrenCount = 0,
//                                allSelectedCount = 0;
//
//                            foreachNodes(e.row.node.children, function (node) {
//                                if (!node.children.length) {
//                                    allChildrenCount++;
//                                    if (e.component.isRowSelected(node.key)) {
//                                        allSelectedCount++;
//                                    }
//                                }
//                            });
//
//                            var newIsSelected;
//
//                            if (allChildrenCount === 0) {
//                                newIsSelected = isSelected;
//                            } else if (allSelectedCount === 0) {
//                                newIsSelected = false;
//                            } else if (allSelectedCount === allChildrenCount) {
//                                newIsSelected = true;
//                            }
//                            if (isSelected !== newIsSelected) {
//                                e.component._skipChildrenProcessing = e.component._skipChildrenProcessing || 0;
//                                e.component._skipChildrenProcessing++;
//                                var d = $.Deferred();
//                                if (!isSelected !== !newIsSelected) {
//                                    if (newIsSelected) {
//                                        d = e.component.selectRows(e.row.key, true);
//                                    }
//                                    else {
//                                        d = e.component.deselectRows(e.row.key);
//                                    }
//                                }
//                                else {
//                                    d.resolve();
//                                }
//                                d.always(function () {
//                                    if (newIsSelected === undefined) {
//                                        setTimeout(function () {
//                                            e.cellElement.find(".dx-select-checkbox").dxCheckBox("option", "value", undefined);
//                                            e.row.isSelected = undefined;
//                                        });
//                                    }
//                                    e.component._skipChildrenProcessing--;
//                                });
//                            }
//                        }
//                    }
                }).dxTreeList("instance");

                var dataGridInstance = $("#dxDataGrid").dxDataGrid({
                    dataSource: gridDataSource,
                    keyExpr: "id",
                    showColumnLines: true,
                    showRowLines: true,
                    rowAlternationEnabled: true,
                    showBorders: true,
                    columnAutoWidth: true,
                    selection: {
                        mode: "single"
                    },
                    columns: [
                        {
                            dataField: "id",
                            caption: "角色ID",
                            width: 300
                        },
                        {
                            dataField: "name",
                            caption: "角色名称",
                            width: 300
                        },
                        {
                            dataField: "parentid",
                            caption: "父级角色",
                            width: 300
                        },
                        {
                            dataField: "isrebate",
                            caption: "是否参与返利",
                            width: 300
                        },
                        {
                            dataField: "updatetime",
                            caption: "更新时间",
                            dataType: "date",
                            width: 300
                        },
                        {
                            dataField: "remark",
                            caption: "备注",
                            width: 300
                        }
                    ],
                    onCellPrepared: function (e) {
                        if (e.column.command === "edit") {
                            e.cellElement.children(".dx-link-add").remove();
                        }
                    },
                    onToolbarPreparing: function (e) {
                        var dataGrid = e.component;
                        e.toolbarOptions.items.unshift({
                            location: "after",
                            widget: "dxButton",
                            options: {
                                hint: "刷新",
                                icon: "refresh",
                                onClick: function () {
                                    dataGrid.refresh();
                                }
                            }
                        });
                    },
                    onSelectionChanged: function (selectedItems) {
                        var data = selectedItems.selectedRowsData[0];
                        if (data) {
                            $.ajax({
                                type: "POST",
                                url: '<%=contextPath%>' + "/RoleMenu/GetByRole",
                                cache: false,
                                dataType: "json",
                                data: {
                                    roleid: data.id
                                },
                                success: function (result) {
                                    if (result.success) {
                                        ids = result.ids;
                                        treeListInstance.selectRows(ids);
                                    } else {
                                        alert(result.data);
                                    }
                                },
                                error: function (result) {
                                    alert(result.data);
                                }
                            });
                        }
                    }
                }).dxDataGrid("instance");

                $("#icon-save").dxButton({
                    icon: "save",
                    text: "保存",
                    onClick: function () {
                        var keys = dataGridInstance.getSelectedRowKeys();
                        var keyList = treeListInstance.getSelectedRowKeys();
                        if (keys == undefined || keys.length == 0) {
                            DevExpress.ui.notify("请选择角色！");
                            return;
                        }
                        if (keyList == undefined || keyList.length == 0) {
                            DevExpress.ui.notify("请选择菜单！");
                            return;
                        }
                        $.ajax({
                            type: "POST",
                            url: '<%=contextPath%>' + "/RoleMenu/Update",
                            cache: false,
                            dataType: "json",
                            data: {
                                roleid: keys[0],
                                menuids: keyList
                            },
                            success: function (result) {
                                if (result.success) {
//                                    DevExpress.ui.notify(result.data);
                                    showInfo(result);
                                } else {
//                                    DevExpress.ui.notify(result.data);
                                    showInfo(result);
                                }
                            },
                            error: function (result) {
                                alert(result.data);
                            }
                        });
//                        DevExpress.ui.notify("The button was clicked " + JSON.stringify(keys) + " ---------- " + JSON.stringify(keyList));
                    }
                });

                var popup = null,
                    popupOptions = {
                        width: 300,
                        height: 250,
                        contentTemplate: function () {
                            return $("<div />").append($("<p><span>" + result.data + "</span></p>"));
                        },
                        showTitle: true,
                        title: "提示信息",
                        visible: false,
                        dragEnabled: false,
                        closeOnOutsideClick: true
                    };

                var showInfo = function (data) {
                    result = data;
                    if (popup) {
                        $(".popup").remove();
                    }
                    var $popupContainer = $("<div />")
                        .addClass("popup")
                        .appendTo($("#popup"));
                    popup = $popupContainer.dxPopup(popupOptions).dxPopup("instance");
                    popup.show();
                };
            });
        });
    </script>
</head>
<body class="dx-viewport">
<div class="demo-container">
    <div class="demo-container">
        <div>
            <div id="icon-save" class="save"></div>
        </div>
        <div id="popup">
            <div class="popup"></div>
        </div>
        <div id="data-grid">
            <div id="dxDataGrid"></div>
        </div>
        <div id="tree-grid">
            <div id="dxTreeList"></div>
        </div>
    </div>
</div>
</body>
</html>