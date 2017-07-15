package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.Visitor;
import com.guangtai.service.VisitorService;
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

import java.time.LocalDate;
import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * VisitorController
 */
@org.springframework.stereotype.Controller
@RequestMapping(value = "/Visitor")
public class VisitorController {

    @Autowired
    private VisitorService visitorService;

    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/Visitor");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<Visitor> visitorList = visitorService.getVisitor();
            return SystemUtil.getObjectMapper().writeValueAsString(visitorList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }


    //添加
    @RequestMapping(value = "/Add")
    @ResponseBody
    public String Add(HttpServletRequest request,
                      @RequestParam(required = false) String certificateid,
                      @RequestParam(required = false) String companyid,
                      @RequestParam(required = false) String name,
                      @RequestParam(required = false) String certificatenumber,
                      @RequestParam(required = false) String transport,
                      @RequestParam(required = false) String carnumber,
                      @RequestParam(required = false) String visitornumber,
                      @RequestParam(required = false) String telephone,
                      @RequestParam(required = false) String cometime,
                      @RequestParam(required = false) String leavetime,
                      @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Visitor visitor = new Visitor();

            if (certificateid != null) {
                visitor.setCertificateid(Integer.valueOf(certificateid));
            }

            if (companyid != null) {
                visitor.setCompanyid(Integer.valueOf(companyid));
            }

            if (name != null) {
                visitor.setName(name);
            }


            if (certificatenumber != null) {
                visitor.setCertificatenumber(certificatenumber);
            }

            if (transport != null) {
                visitor.setTransport(transport);
            }

            if (carnumber != null) {
                visitor.setCarnumber(carnumber);
            }

            if (visitornumber != null) {
                visitor.setVisitornumber(visitornumber);
            }

            if (telephone != null) {
               visitor.setTelephone(telephone);
            }

            visitor.setCometime(LocalDate.now().toString());

            visitor.setLeavetime(LocalDate.now().toString());

            if (telephone != null) {
                visitor.setTelephone(telephone);
            }

            if (remark != null) {
                visitor.setRemark(remark);
            }

            //执行修改添加方法
            visitorService.add(visitor);

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
                       @RequestParam(required = false) String certificateid,
                       @RequestParam(required = false) String companyid,
                       @RequestParam(required = false) String name,
                       @RequestParam(required = false) String certificatenumber,
                       @RequestParam(required = false) String transport,
                       @RequestParam(required = false) String carnumber,
                       @RequestParam(required = false) String visitornumber,
                       @RequestParam(required = false) String telephone,
                       @RequestParam(required = false) String cometime,
                       @RequestParam(required = false) String leavetime,
                       @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Visitor visitor = visitorService.getById(Visitor.class, Integer.valueOf(id));

            if (certificateid != null) {
                visitor.setCertificateid(Integer.valueOf(certificateid));
            }

            if (companyid != null) {
                visitor.setCompanyid(Integer.valueOf(companyid));
            }

            if (name != null) {
                visitor.setName(name);
            }

            if (certificatenumber != null) {
                visitor.setCertificatenumber(certificatenumber);
            }

            if (transport != null) {
                visitor.setTransport(transport);
            }

            if (carnumber != null) {
                visitor.setCarnumber(carnumber);
            }


            if (visitornumber != null) {
                visitor.setVisitornumber(visitornumber);
            }

            if (telephone != null) {
                visitor.setTelephone(telephone);
            }

            visitor.setCometime(LocalDate.now().toString());

            visitor.setLeavetime(LocalDate.now().toString());

            if (telephone != null) {
                visitor.setTelephone(telephone);
            }

            if (remark != null) {
                visitor.setRemark(remark);
            }

            //执行修改方法
            visitorService.edit(visitor);

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
            Visitor visitor = visitorService.getById(Visitor.class, Integer.valueOf(id));

            //执行删除方法
            visitorService.delete(visitor);

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