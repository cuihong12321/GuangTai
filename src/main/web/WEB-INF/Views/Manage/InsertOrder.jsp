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
    </style>
    <script>
        $(function () {

            var Company = new DevExpress.data.ODataStore({
                url: "<%=contextPath%>/Company/GetAll"
            });

            var Visitor = new DevExpress.data.ODataStore({
                url: "<%=contextPath%>//GetAll"
            });

            var Certificate = new DevExpress.data.ODataStore({
                url: "<%=contextPath%>/Certificate/GetAll"
            });

            var DepartMent = new DevExpress.data.ODataStore({
                url: "<%=contextPath%>/DepartMent/GetAll"
            });

            var Interviewee = new DevExpress.data.ODataStore({
                url: "<%=contextPath%>/Interviewee/GetAll"
            });

            var gridDataSource = new DevExpress.data.DataSource({
                key: "id",
                loadMode: "raw",
                load: function () {
                    return $.getJSON("<%=contextPath%>/InsertOrder/GetAll");
                },
                // 插入数据
                insert: function (values) {
                    return $.ajax({
                        url: "<%=contextPath%>/InsertOrder/Add/",
                        method: "POST",
                        data: values
                    })
                },
                //删除数据
                remove: function (key) {
                    return $.ajax({
                        url: "<%=contextPath%>/InsertOrder/Delete/" + key,
                        method: "POST"
                    })
                },
                update: function (key, values) {
                    return $.ajax({
                        url: "<%=contextPath%>/InsertOrder/Edit/" + key,
                        method: "POST",
                        data: values
                    })
                }
            });


            $(function () {
                $("#gridContainer").dxDataGrid({
                    dataSource: gridDataSource,
                    keyExpr: "id",
                    editing: {
                        mode: "popup",
                        allowUpdating: true,
                        allowDeleting: true,
                        allowAdding: true,
                        popup: {
                            title: "访客单",
                            showTitle: true,
                            width: 700,
                            height: 700,
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
                            dataField: "companyid",
                            caption: "来宾公司",
                            lookup: {
                                valueExpr: "id",
                                displayExpr: "name",
                                dataSource: {
                                    store: Company
                                }
                            },
                            width: 300
                        },
                        {
                            dataField: "visitorid",
                            caption: "来宾姓名",
                            lookup: {
                                valueExpr: "id",
                                displayExpr: "name",
                                dataSource: {
                                    store: Visitor
                                }
                            },
                            width: 300
                        },
                        {
                            dataField: "certificateid",
                            caption: "证件名称",
                            lookup: {
                                valueExpr: "id",
                                displayExpr: "name",
                                dataSource: {
                                    store: Certificate
                                }
                            },
                            width: 300
                        },
                        {
                            dataField: "departmentid",
                            caption: "被访部门",
                            lookup: {
                                valueExpr: "id",
                                displayExpr: "name",
                                dataSource: {
                                    store: DepartMent
                                }
                            },
                            width: 300
                        },
                        {
                            dataField: "intervieweweeid",
                            caption: "被访人",
                            lookup: {
                                valueExpr: "id",
                                displayExpr: "name",
                                dataSource: {
                                    store: Interviewee
                                }
                            },
                            width: 300
                        },
                        {
                            dataField: "reason",
                            caption: "来访事由",
                            width: 300
                        },
                        {
                            dataField: "retinue",
                            caption: "随行人员",
                            width: 300
                        },
                        {
                            dataField: "belongings",
                            caption: "携带物品",
                            width: 300
                        },
                        {
                            dataField: "certificatenumber",
                            caption: "证件号码",
                            width: 300
                        },
                        {
                            dataField: "transport",
                            caption: "交通工具",
                            width: 300
                        },
                        {
                            dataField: "carnumber",
                            caption: "车牌号码",
                            width: 300
                        },
                        {
                            dataField: "replacement",
                            caption: "换证物品",
                            width: 300
                        },
                        {
                            dataField: "visitornumber",
                            caption: "访客证号",
                            width: 300
                        },
                        {
                            dataField: "ordertime",
                            caption: "预约时间",
                            dataType: "date",
                            width: 300
                        },
                        {
                            dataField: "interviewtime",
                            caption: "来访时间",
                            dataType: "date",
                            width: 300
                        },
                        {
                            dataField: "cometime",
                            caption: "进厂时间",
                            dataType: "date",
                            width: 300
                        },
                        {
                            dataField: "leavetime",
                            caption: "出厂时间",
                            dataType: "date",
                            width: 300
                        },
                        {
                            dataField: "state",
                            caption: "状态",
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
                    expandedRowKeys: [2],
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
                    }

                });
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