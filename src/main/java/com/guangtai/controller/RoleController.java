package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.Role;
import com.guangtai.service.RoleService;
import io.ruibu.model.ResultModel;
import io.ruibu.util.SystemUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by Rojackios on 2017/02/14.
 * RoleController 角色Controller
 */
@Controller
@RequestMapping(value = "/Role")
public class RoleController {

    @Autowired
    RoleService roleService;


    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/Role");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<Role> roleList = roleService.getRole();
            return SystemUtil.getObjectMapper().writeValueAsString(roleList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    //添加角色
    @RequestMapping(value = "/Add")
    @ResponseBody
    public String Add(HttpServletRequest request,String name) {
        ResultModel<String> resultModel = new ResultModel<>();
        try {

            Role role = new Role();

            name = request.getParameter("name");
            String remark = request.getParameter("remark");

            role.setName(name);
            role.setRemark(remark);
            roleService.add(role);
            resultModel.setSuccess(true);
            resultModel.setData("添加成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            resultModel.setSuccess(false);
            resultModel.setData("添加失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }

        return "";
    }

    @RequestMapping(value = "/Edit")
    @ResponseBody
    public String Edit(@RequestParam String name,@RequestParam int id, HttpServletRequest request) {
        ResultModel<String> resultModel = new ResultModel<>();
        try {

            Role role = roleService.getById(Role.class, id);

            name = request.getParameter("name");
            String remark = request.getParameter("remark");

            role.setName(name);
            role.setRemark(remark);
            roleService.edit(role);
            resultModel.setSuccess(true);
            resultModel.setData("修改成功！");

            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            resultModel.setSuccess(false);
            resultModel.setData("修改失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }

        return "";
    }

    @RequestMapping(value = "/Delete")
    @ResponseBody
    public String delete(@RequestParam int id) {
        ResultModel<String> resultModel = new ResultModel<>();
        try {
            Role role = roleService.getById(Role.class, id);
            roleService.delete(role);
            resultModel.setSuccess(true);
            resultModel.setData("删除成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            resultModel.setSuccess(false);
            resultModel.setData("删除失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }

        return "";
    }
}
