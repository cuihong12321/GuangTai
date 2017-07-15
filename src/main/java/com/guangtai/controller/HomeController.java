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

    @RequestMapping(value = "/")
    public ModelAndView Manage() {
        return new ModelAndView("Manage/Login");
    }



    @RequestMapping(value = "/ForGround/ForGround")
    public ModelAndView ForGround() {
        return new ModelAndView("ForGround");
    }

    @RequestMapping(value = "/ForGround/InsertOrder")
    public ModelAndView InsertOrder() {
        return new ModelAndView("Manage/InsertOrder");
    }

    @RequestMapping(value = "/ForGround/OperateOrder")
    public ModelAndView OperateOrder() {
        return new ModelAndView("Manage/OperateOrder");
    }

    @RequestMapping(value = "/ForGround/CheckOrder")
    public ModelAndView CheckOrder() {
        return new ModelAndView("Manage/CheckOrder");
    }




    @RequestMapping(value = "/BackGround/BackGround")
    public ModelAndView BackGround() {
        return new ModelAndView("BackGround");
    }

    @RequestMapping(value = "/BackGround/Visitor")
    public ModelAndView Visitor() {
        return new ModelAndView("Manage/Visitor");
    }

    @RequestMapping(value = "/BackGround/Company")
    public ModelAndView Company() {
        return new ModelAndView("Manage/Company");
    }

    @RequestMapping(value = "/BackGround/Certificate")
    public ModelAndView Certificate() {
        return new ModelAndView("Manage/Certificate");
    }



    @RequestMapping(value = "/BackGround/BasicManage")
    public ModelAndView BasicManage() {
        return new ModelAndView("BasicManage");
    }

    @RequestMapping(value = "/BasicManage/Interviewee")
    public ModelAndView Interviewee() {
        return new ModelAndView("Manage/Interviewee");
    }

    @RequestMapping(value = "/BasicManage/DepartMent")
    public ModelAndView Department() {
        return new ModelAndView("Manage/DepartMent");
    }




    @RequestMapping(value = "/BackGround/AccountManage")
    public ModelAndView AccountManagePage() {
        return new ModelAndView("AccountManage");
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