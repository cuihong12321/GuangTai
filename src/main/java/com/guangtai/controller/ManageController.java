package com.guangtai.controller;


import com.guangtai.model.ResultModels;
import com.guangtai.model.domain.User;
import com.guangtai.service.RoleMenuService;
import com.guangtai.service.RoleService;
import com.guangtai.service.UserService;
import io.ruibu.model.ResultModel;
import io.ruibu.util.SecurityUtil;
import io.ruibu.util.SystemUtil;
import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * Created by Rojackios on 2017/02/13.
 * PCController
 */
@Controller
@RequestMapping(value = "/Manage")
public class ManageController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/")
    public String Login() {
        return "Manage/Login";
    }

    @RequestMapping(value = "/Index")
    public ModelAndView Index(@RequestParam String username) {

        User user= userService.getByName(username);//根据用户名获取该用户对象

        Map<String, Object> mapModel = new HashedMap();
        mapModel.put("UserName",username);

        return new ModelAndView("Manage/Index",mapModel);
    }


    @RequestMapping(value = "/ManageLogin")
    @ResponseBody
    public String ManageLogin(HttpServletRequest request) {
        ResultModels<String> resultModels = new ResultModels<>();
        try {
            User user = userService.getByUserNameAndPassword(request.getParameter("username"), SecurityUtil.encrypt(request.getParameter("password"), SecurityUtil.AlgorithmType.SHA512));

            if (user == null) {
                resultModels.setSuccess(false);
                resultModels.setData("用户名或密码错误!");
            } else {
                resultModels.setSuccess(true);
                resultModels.setData("登陆成功！");
                resultModels.setUser(user);
            }

            return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}