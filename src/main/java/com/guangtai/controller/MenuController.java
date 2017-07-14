package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.RoleMenu;
import com.guangtai.model.domain.Menu;
import com.guangtai.service.MenuService;
import com.guangtai.service.RoleMenuService;
import io.ruibu.model.ResultModel;
import io.ruibu.util.SystemUtil;
import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * UserController
 */
@Controller
@RequestMapping(value = "/Menu")
public class MenuController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private RoleMenuService roleMenuService;

    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/Menu");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<Menu> MenuList = menuService.getMenu();
            return SystemUtil.getObjectMapper().writeValueAsString(MenuList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    @RequestMapping("/Gettest")
    @ResponseBody
    public void getMenutest(HttpServletRequest request, HttpServletResponse response) {
        Integer roleid = Integer.parseInt(request.getParameter("roleid"));

        try {
            List<Menu> menulist = new ArrayList<>();
            List<RoleMenu> roleMenulist = roleMenuService.getRoleMenu(roleid);
            Menu menu;
            for (RoleMenu roleMenu : roleMenulist) {
                menu = menuService.getById(Menu.class,roleMenu.getMenuid());
                menulist.add(menu);
                System.out.print(roleMenu);
            }
            System.out.print(menulist);
            response.getWriter().write(SystemUtil.getObjectMapper().writeValueAsString(menulist));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //添加工厂
    @RequestMapping(value = "/Add")
    @ResponseBody
    public String Add(HttpServletRequest request,
                      @RequestParam(required = false) String icon,
                      @RequestParam(required = false) String name,
                      @RequestParam(required = false) String url,
                      @RequestParam(required = false) String parentid,
                      @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Menu menu = new Menu();

            if (icon != null) {
                menu.setIcon(icon);
            }

            if (name != null) {
                menu.setName(name);
            }

            if (url != null) {
                menu.setUrl(url);
            }

            if (parentid != null) {
                menu.setParentid(Integer.valueOf(parentid));
            }

            if (remark != null) {
                menu.setRemark(remark);
            }

            menu.setUpdatetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            //执行修改添加方法
            menuService.add(menu);

            resultModel.setSuccess(true);
            resultModel.setData("添加成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            LogManager.getLogger().error(e.toString());

            resultModel.setSuccess(false);
            resultModel.setData("添加失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                LogManager.getLogger().error(ex.toString());

            }
        }

        return "";
    }

    //修改工厂
    @RequestMapping(value = "/Edit/{id}")
    @ResponseBody
    public String Edit(HttpServletRequest request, @PathVariable String id,
                       @RequestParam(required = false) String icon,
                       @RequestParam(required = false) String name,
                       @RequestParam(required = false) String url,
                       @RequestParam(required = false) String parentid,
                       @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Menu menu = menuService.getById(Menu.class, Integer.valueOf(id));

            if (icon != null) {
                menu.setIcon(icon);
            }

            if (name != null) {
                menu.setName(name);
            }

            if (url != null) {
                menu.setUrl(url);
            }

            if (parentid != null) {
                menu.setParentid(Integer.valueOf(parentid));
            }

            if (remark != null) {
                menu.setRemark(remark);
            }

            menu.setUpdatetime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
            //执行修改方法
            menuService.edit(menu);

            resultModel.setSuccess(true);
            resultModel.setData("修改成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            LogManager.getLogger().error(e.toString());

            resultModel.setSuccess(false);
            resultModel.setData("修改失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                LogManager.getLogger().error(ex.toString());

            }
        }

        return "";
    }

    //删除工厂
    @RequestMapping(value = "/Delete/{id}")
    @ResponseBody
    public String Delete(HttpServletRequest request, @PathVariable String id) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Menu menu = menuService.getById(Menu.class, Integer.valueOf(id));

            //执行删除方法
            menuService.delete(menu);

            resultModel.setSuccess(true);
            resultModel.setData("删除成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            LogManager.getLogger().error(e.toString());

            resultModel.setSuccess(false);
            resultModel.setData("删除失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                LogManager.getLogger().error(ex.toString());

            }
        }

        return "";
    }
}