package com.guangtai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by haoyuedev001 on 2016-05-29.
 * HomeController
 */
@Controller
public class HomeController {

    @RequestMapping(value = "/BackGround/Forground")
    public ModelAndView ForgroundPage() {
        return new ModelAndView("Forground");
    }

    @RequestMapping(value = "/ForGround/OrderPage")
    public ModelAndView OrderPage() {
        return new ModelAndView("OrderPage");
    }

    @RequestMapping(value = "/ForGround/OperateOrderPage")
    public ModelAndView OperateOrderPage() {
        return new ModelAndView("OperateOrderPage");
    }

    @RequestMapping(value = "/ForGround/DispatchPage")
    public ModelAndView DispatchPage() {
        return new ModelAndView("DispatchPage");
    }

    @RequestMapping(value = "/ForGround/AuditingPage")
    public ModelAndView AuditingPage() {
        return new ModelAndView("AuditingPage");
    }

    @RequestMapping(value = "/BackGround/BulkCargo")
    public ModelAndView BulkCargoPage() {
        return new ModelAndView("BulkCargo");
    }

    @RequestMapping(value = "/BulkCargo/Order")
    public ModelAndView Order() {
        return new ModelAndView("Order");
    }

    @RequestMapping(value = "/BulkCargo/OperateOrder")
    public ModelAndView OperateOrder() {
        return new ModelAndView("OperateOrder");
    }

    @RequestMapping(value = "/BulkCargo/Dispatch")
    public ModelAndView Dispatch() {
        return new ModelAndView("Dispatch");
    }

    @RequestMapping(value = "/BulkCargo/Auditing")
    public ModelAndView Auditing() {
        return new ModelAndView("Auditing");
    }

    @RequestMapping(value = "/BackGround/Factory")
    public ModelAndView FactoryPage() {
        return new ModelAndView("FactoryPage");
    }

    @RequestMapping(value = "/BackGround/Supplier")
    public ModelAndView SupplierPage() {
        return new ModelAndView("SupplierPage");
    }

    @RequestMapping(value = "/BackGround/Area")
    public ModelAndView AreaPage() {
        return new ModelAndView("AreaPage");
    }

    @RequestMapping(value = "/BackGround/Cost")
    public ModelAndView CostPage() {
        return new ModelAndView("CostPage");
    }

    @RequestMapping(value = "/BackGround/Balanceunit")
    public ModelAndView BalanceunitPage() {
        return new ModelAndView("BalanceunitPage");
    }

    @RequestMapping(value = "/BackGround/CostType")
    public ModelAndView CostTypePage() {
        return new ModelAndView("CostTypePage");
    }

    @RequestMapping(value = "/BackGround/Currency")
    public ModelAndView CurrencyPage() {
        return new ModelAndView("CurrencyPage");
    }

    @RequestMapping(value = "/BackGround/Customer")
    public ModelAndView CustomerPage() {
        return new ModelAndView("CustomerPage");
    }

    @RequestMapping(value = "/BackGround/ContainerType")
    public ModelAndView ContainerTypePage() {
        return new ModelAndView("ContainerTypePage");
    }

    @RequestMapping(value = "/BackGround/Driver")
    public ModelAndView DriverPage() {
        return new ModelAndView("Driver");
    }

    @RequestMapping(value = "/BackGround/AccountManage")
    public ModelAndView AccountManagePage() {
        return new ModelAndView("AccountManage");
    }

    @RequestMapping(value = "/BackGround/Commdity")
    public ModelAndView CommdityPage() {
        return new ModelAndView("CommdityPage");
    }

    @RequestMapping(value = "/ForGround/Report")
    public ModelAndView Payreportpage() {
        return new ModelAndView("CostReport");
    }


    @RequestMapping(value = "/")
    public ModelAndView Manage() {
        return new ModelAndView("Manage/Login");
    }

    @RequestMapping(value = "AccountManage/User")
    public ModelAndView User() {
        return new ModelAndView("Manage/User");
    }

    @RequestMapping(value = "AccountManage/Role")
    public ModelAndView Role() {
        return new ModelAndView("Manage/Role");
    }

    @RequestMapping(value = "AccountManage/Menu")
    public ModelAndView Menu() {
        return new ModelAndView("Manage/Menu");
    }

    @RequestMapping(value = "AccountManage/RoleMenu")
    public ModelAndView RoleMenu() {
        return new ModelAndView("Manage/RoleMenu");
    }

}