<%--
  Created by IntelliJ IDEA.
  User: haoyue001
  Date: 2016/11/26
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String contextPath = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta menuname="viewport" content="width=device-width, initial-scale=1.0" />
    <meta menuname="description" content="Xenon Boostrap Admin Panel" />
    <meta menuname="author" content="" />
    <title>江苏金润润滑油后台主页</title>
    <link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/font-awesome/css/font-awesome.min.css">
    <%--<link rel="stylesheet" href="<%=contextPath%>/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/xenon-core.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/xenon-forms.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/xenon-components.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/xenon-skins.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/custom.css">
    <link rel="stylesheet" href="<%=contextPath%>/resources/styles/pc-index.css">
    <script src="<%=contextPath%>/resources/librarys/nav/jquery-1.8.3.min.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="<%=contextPath%>/resources/librarys/bootstrap/js/html5shiv.js"></script>
    <script src="<%=contextPath%>/resources/librarys/bootstrap/js/respond.js"></script>
    <![endif]-->
    <script>
        function myFunction(){
            if (confirm("确认要退出登录吗？")){
                window.location.href="<%=contextPath%>/";
            }
        }
    </script>
    <style>
        .sidebar-menu .main-menu {
            padding: 0;
            margin-top: 20px;
            margin-bottom: 20px;
            list-style: none;
        }
        .sidebar-menu .main-menu ul li a {
            padding-left: 70px;
        }
        .sidebar-menu .main-menu a {
            padding: 13px 30px;
        }
    </style>
</head>
<body class="page-body">
<div class="page-container">
    <div class="sidebar-menu toggle-others fixed">
        <div class="sidebar-menu-inner">
            <header class="logo-env">
                <!-- logo -->
                <div class="logo">
                    <a href="#" class="logo-expanded">
                        <img src="<%=contextPath%>/resources/images/index-pc-header-logo.png">
                    </a>
                    <a href="#" class="logo-collapsed">
                        <img src="<%=contextPath%>/resources/images/1.png" width="40" alt="" />
                    </a>
                </div>
                <!-- This will toggle the mobile menu and will be visible only on mobile devices -->
                <%--<div class="mobile-menu-toggle visible-xs">--%>
                    <%--<a href="#" data-toggle="user-info-menu">--%>
                        <%--<i class="fa-bell-o"></i>--%>
                        <%--<span class="badge badge-success">7</span>--%>
                    <%--</a>--%>

                    <%--<a href="#" data-toggle="mobile-menu">--%>
                        <%--<i class="fa-bars"></i>--%>
                    <%--</a>--%>
                <%--</div>--%>
            </header>
            <ul id="main-menu" class="main-menu">
                <!-- add class "multiple-expanded" to allow multiple submenus to open -->
                <!-- class "auto-inherit-active-class" will automatically add "active" class for parent elements who are marked already with class "active" -->
                <li>
                    <a href="#">
                        <%--onclick="addActive(this);"--%>
                        <i class="linecons-cog"></i>
                        <span class="title">首页</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">首页轮播管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/HomeCarouse/" target="aaa">
                                <span class="title">首页轮播</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <%--onclick="addActive(this);"--%>
                        <i class="linecons-desktop"></i>
                        <span class="title">账号管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/User/" target="aaa">
                                <span class="title">用户管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/Role/" target="aaa">
                                <span class="title">角色管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/Menu/" target="aaa">
                                <span class="title">菜单管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/RoleMenu/" target="aaa">
                                <span class="title">权限管理</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">银行卡管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/Bank/" target="aaa">
                                <span class="title">银行管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/BankCard/" target="aaa">
                                <span class="title">用户银行卡管理</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-note"></i>
                        <span class="title">汽车管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/Car/" target="aaa">
                                <span class="title">汽车管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/Carbrand/" target="aaa">
                                <span class="title">汽车品牌管理</span>
                            </a>
                        </li>

                        <li>
                            <a href="<%=contextPath%>/CarCompany/" target="aaa">
                                <span class="title">汽车厂商管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/CarSeries/" target="aaa">
                                <span class="title">车系管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/Cartype/" target="aaa">
                                <span class="title">汽车车型管理</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">服务管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/Region/" target="aaa">
                                <span class="title">区域管理</span>
                            </a>
                        </li>
                        <%--<li>--%>
                        <%--<a href="<%=contextPath%>/Services/" target="aaa">--%>
                        <%--<span class="title">服务管理</span>--%>
                        <%--</a>--%>
                        <%--</li>--%>
                        <%--<li>--%>
                        <%--<a href="<%=contextPath%>/ServiceType/" target="aaa">--%>
                        <%--<span class="title">服务类型管理</span>--%>
                        <%--</a>--%>
                        <%--</li>--%>
                        <li>
                            <a href="<%=contextPath%>/ServiceProvider/" target="aaa">
                                <span class="title">服务商管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/RegionPrice/" target="aaa">
                                <span class="title">地区价格管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/RegionSubsidy/" target="aaa">
                                <span class="title">地区补助管理</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">库存管理</span>
                    </a>
                    <ul>
                        <%--<li>--%>
                            <%--<a href="<%=contextPath%>/Inventory/" target="aaa">--%>
                                <%--<span class="title">库存记录</span>--%>
                            <%--</a>--%>
                        <%--</li>--%>
                            <li>
                                <a href="<%=contextPath%>/UserProductBg/" target="aaa">
                                    <span class="title">总库存</span>
                                </a>
                            </li>
                        <li>
                            <a href="<%=contextPath%>/InventoryRecord/" target="aaa">
                                <span class="title">库存记录</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">券管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/TicketSeries/" target="aaa">
                                <span class="title">劵系列</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/MaintainTicket/" target="aaa">
                                <span class="title">用户所持保养券</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/TicketMaster/" target="aaa">
                                <span class="title">劵订单</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/MaintainTicketMasterBg/" target="aaa">
                                <span class="title">保养券管理</span>
                            </a>
                        </li>

                        <li>
                            <a href="<%=contextPath%>/MaintainTicketMasterDetailBg/" target="aaa">
                                <span class="title">保养券细则管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/MaintainTicketOrderMaster/" target="aaa">
                                <span class="title">保养券订单管理</span>
                            </a>
                        </li>

                        <li>
                            <a href="<%=contextPath%>/CouponTicket/" target="aaa">
                                <span class="title">优惠券</span>
                            </a>
                        </li>

                        <li>
                            <a href="<%=contextPath%>/CouponTicketOrder/" target="aaa">
                                <span class="title">优惠券订单</span>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <span class="title">劵订单详情</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">保养套餐管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/Product/" target="aaa">
                                <span class="title">产品管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/PackageMaster/" target="aaa">
                                <span class="title">套餐管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/PackageDetail/" target="aaa">
                                <span class="title">套餐明细管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/PackageType/" target="aaa">
                                <span class="title">套餐类型管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/ProductType/" target="aaa">
                                <span class="title">产品类型管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/ProductSeries/" target="aaa">
                                <span class="title">产品系列管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/PackageOrderMaster/" target="aaa">
                                <span class="title">订单记录管理</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/MaintainOrder/" target="aaa">
                                <span class="title">保养记录管理</span>
                            </a>
                        </li>

                        <li>
                            <a href="<%=contextPath%>/PackageStatistics/" target="aaa">
                                <span class="title">套餐换油统计</span>
                            </a>
                        </li>

                        <li>
                            <a href="<%=contextPath%>/SaleStatistice/" target="aaa">
                                <span class="title">爱车无限销售汇总</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/Sale/" target="aaa">
                                <span class="title">总代总金额</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/SaleDetailList/" target="aaa">
                                <span class="title">总代销售明细</span>
                            </a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#">
                        <i class="linecons-database"></i>
                        <span class="title">流水记录管理</span>
                    </a>
                    <ul>
                        <li>
                            <a href="<%=contextPath%>/DealRecord/" target="aaa">
                                <span class="title">交易记录</span>
                            </a>
                        </li>
                        <li>
                            <a href="<%=contextPath%>/DealType/" target="aaa">
                                <span class="title">交易类型</span>
                            </a>
                        </li>
                    </ul>
                </li>



            </ul>
        </div>
    </div>
    <div class="main-content">
        <!-- User Info, Notifications and Menu Bar -->
        <nav class="navbar user-info-navbar" role="navigation">

            <!-- Left links for user info navbar -->
            <ul class="user-info-menu left-links list-inline list-unstyled">

                <li class="hidden-sm hidden-xs">
                    <a href="#" data-toggle="sidebar">
                        <i class="fa-bars"></i>
                    </a>
                </li>
            </ul>
            <!-- Right links for user info navbar -->
            <ul class="user-info-menu right-links list-inline list-unstyled">
                <li class="dropdown user-profile">
                    <a href="#">
                        <img src="<%=contextPath%>/resources/images/user-4.png" alt="user-image" class="img-circle img-inline userpic-32" width="28" />
                        <span>
                            ${UserName}
                        </span>
                    </a>
                </li>

                <li>
                    <a id="exit" onclick="myFunction()">
                        <i class="fa-power-off"></i>
                    </a>
                </li>

            </ul>

        </nav>

        <%--内嵌--%>
        <iframe name="aaa" style="width: 100%;height: 90%;margin-top: 76px;border: none;"></iframe>
    </div>
</div>

<!-- Bottom Scripts -->
<%--<script src="<%=contextPath%>/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>--%>
<script src="<%=contextPath%>/resources/js/TweenMax.min.js"></script>
<script src="<%=contextPath%>/resources/js/resizeable.js"></script>
<script src="<%=contextPath%>/resources/js/joinable.js"></script>
<script src="<%=contextPath%>/resources/js/xenon-api.js"></script>
<script src="<%=contextPath%>/resources/js/xenon-toggles.js"></script>

<!-- Imported scripts on this page -->
<!--<script src="<%=contextPath%>/resources/js/rwd-table.min.js"></script>-->
<!-- JavaScripts initializations and stuff -->
<script src="<%=contextPath%>/resources/js/xenon-custom.js"></script>
<script>
    $(function(){
        var nav_width = $('.sidebar-menu').width();
        var doc_width = $(document).width();
        $('.user-info-navbar').width(doc_width-nav_width);
        $('footer.main-footer').width(doc_width-nav_width);

    });
</script>
</body>
</html>