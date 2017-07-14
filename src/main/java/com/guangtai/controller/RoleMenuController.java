package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.ResultModels;
import com.guangtai.model.RoleMenuTreeModel;
import com.guangtai.model.domain.Role;
import com.guangtai.model.domain.RoleMenu;
import com.guangtai.service.MenuService;
import com.guangtai.service.RoleMenuService;
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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * UserController
 */
@Controller
@RequestMapping(value = "/RoleMenu")
public class RoleMenuController {

    @Autowired
    private RoleMenuService roleMenuService;

    @Autowired
    private RoleService roleService;

    @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/RoleMenu");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<RoleMenu> roleMenuList = roleMenuService.getRoleMenu();
            return SystemUtil.getObjectMapper().writeValueAsString(roleMenuList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/GetRole")
    @ResponseBody
    public String GetRole() {
        try {
            List<Role> roleList = roleService.getRole();
            return SystemUtil.getObjectMapper().writeValueAsString(roleList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/TreeViewDemo")
    public ModelAndView TreeViewDemo() {
        return new ModelAndView("Manage/TreeViewDemo");
    }

    @RequestMapping(value = "/GetByRole")
    @ResponseBody
    public String GetByRole(HttpServletRequest request) {
        ResultModels<String> resultModels = new ResultModels<>();
        try {
            Integer roleid = Integer.parseInt(request.getParameter("roleid"));
            List<Integer> ids = roleMenuService.getMenuList(roleid);
            resultModels.setSuccess(true);
            resultModels.setData("查询成功！");
            resultModels.setIds(ids);
            return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/GetNodes")
    @ResponseBody
    public String GetNodes(HttpServletRequest request) {
        try {
            Integer roleid = Integer.parseInt(request.getParameter("roleid"));
            List<RoleMenuTreeModel> listRoleMenu = roleMenuService.getRoleMenuList(roleid);
            return SystemUtil.getObjectMapper().writeValueAsString(listRoleMenu);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @RequestMapping(value = "/Update")
    @ResponseBody
    public String Update(HttpServletRequest request, @RequestParam("menuids[]") List<String> menuids) {
        ResultModel<String> resultModel = new ResultModel<>();
        try {
            Integer roleid = Integer.parseInt(request.getParameter("roleid"));
            RoleMenu roleMenu;
            List<RoleMenu> roleMenuList = roleMenuService.getRoleMenu(roleid);
            if (roleMenuList != null) {
                for (RoleMenu rm : roleMenuList) {
                    roleMenuService.delRoleMenu(rm);
                }
            }
            for (String m : menuids) {
                roleMenu = new RoleMenu();
                roleMenu.setRoleid(roleid);
                roleMenu.setMenuid(Integer.valueOf(m));
                roleMenu.setUpdatetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
                roleMenu.setRemark("管理员授权");
                roleMenuService.addRoleMenu(roleMenu);
            }

            resultModel.setSuccess(true);
            resultModel.setData("更新权限成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            resultModel.setSuccess(false);
            resultModel.setData("更新权限失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }

        return "";
    }

}