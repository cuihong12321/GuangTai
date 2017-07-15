package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.Interviewee;
import com.guangtai.service.IntervieweeService;
import io.ruibu.model.ResultModel;
import io.ruibu.util.SystemUtil;
import org.apache.logging.log4j.LogManager;
import org.springframework.beans.factory.annotation.Autowired;
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
 * IntervieweeController
 */
@org.springframework.stereotype.Controller
@RequestMapping(value = "/Interviewee")
public class IntervieweeController {

    @Autowired
    private IntervieweeService intervieweeService;

    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/Interviewee");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<Interviewee> intervieweeList = intervieweeService.getInterviewee();
            return SystemUtil.getObjectMapper().writeValueAsString(intervieweeList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }


    //添加
    @RequestMapping(value = "/Add")
    @ResponseBody
    public String Add(HttpServletRequest request,
                      @RequestParam(required = false) String departmentid,
                      @RequestParam(required = false) String name,
                      @RequestParam(required = false) String telephone,
                      @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Interviewee interviewee = new Interviewee();

            if (departmentid != null) {
                interviewee.setDepartmentid(Integer.valueOf(departmentid));
            }

            if (name != null) {
                interviewee.setName(name);
            }

            if (telephone != null) {
                interviewee.setTelephone(telephone);
            }

            if (remark != null) {
                interviewee.setRemark(remark);
            }

            interviewee.setUpdatetime(LocalDateTime.now().toString());
            //执行修改添加方法
            intervieweeService.add(interviewee);

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
                       @RequestParam(required = false) String departmentid,
                       @RequestParam(required = false) String name,
                       @RequestParam(required = false) String telephone,
                       @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Interviewee interviewee = intervieweeService.getById(Interviewee.class, Integer.valueOf(id));

            if (departmentid != null) {
                interviewee.setDepartmentid(Integer.valueOf(departmentid));
            }

            if (name != null) {
                interviewee.setName(name);
            }

            if (telephone != null) {
                interviewee.setTelephone(telephone);
            }

            if (remark != null) {
                interviewee.setRemark(remark);
            }

            interviewee.setUpdatetime(LocalDateTime.now().toString());
            //执行修改方法
            intervieweeService.edit(interviewee);

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
            Interviewee Interviewee = intervieweeService.getById(Interviewee.class, Integer.valueOf(id));

            //执行删除方法
            intervieweeService.delete(Interviewee);

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