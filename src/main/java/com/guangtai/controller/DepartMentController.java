package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.DepartMent;
import com.guangtai.service.DepartMentService;
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
import java.time.LocalDateTime;
import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * UserController
 */
@Controller
@RequestMapping(value = "/DepartMent")
public class DepartMentController {

    @Autowired
    private DepartMentService departMentService;

    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/DepartMent");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<DepartMent> departMentList = departMentService.getDepartMent();
            return SystemUtil.getObjectMapper().writeValueAsString(departMentList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }


    //添加
    @RequestMapping(value = "/Add")
    @ResponseBody
    public String Add(HttpServletRequest request,
                      @RequestParam(required = false) String name,
                      @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            DepartMent departMent = new DepartMent();

            if (name != null) {
                departMent.setName(name);
            }

            if (remark != null) {
                departMent.setRemark(remark);
            }

            departMent.setUpdatetime(LocalDateTime.now().toString());
            //执行修改添加方法
            departMentService.add(departMent);

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

    //修改
    @RequestMapping(value = "/Edit/{id}")
    @ResponseBody
    public String Edit(HttpServletRequest request, @PathVariable String id,
                       @RequestParam(required = false) String name,
                       @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            DepartMent departMent = departMentService.getById(DepartMent.class, Integer.valueOf(id));

            if (name != null) {
                departMent.setName(name);
            }

            if (remark != null) {
                departMent.setRemark(remark);
            }

            departMent.setUpdatetime(LocalDateTime.now().toString());
            //执行修改方法
            departMentService.edit(departMent);

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

    //删除
    @RequestMapping(value = "/Delete/{id}")
    @ResponseBody
    public String Delete(HttpServletRequest request, @PathVariable String id) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            DepartMent departMent = departMentService.getById(DepartMent.class, Integer.valueOf(id));

            //执行删除方法
            departMentService.delete(departMent);

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