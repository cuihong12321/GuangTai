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

}