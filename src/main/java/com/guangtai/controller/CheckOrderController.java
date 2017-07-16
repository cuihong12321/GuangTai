package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.Reservation;
import com.guangtai.service.ReservationService;
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
 * CheckOrderController
 */
@Controller
@RequestMapping(value = "/CheckOrder")
public class CheckOrderController {

    @Autowired
    private ReservationService reservationService;

    @RequestMapping(value = "/")
    public ModelAndView Index() {

        return new ModelAndView("Manage/CheckOrder");
    }

    @RequestMapping(value = "/GetAll")
    @ResponseBody
    public String GetAll() {
        try {
            List<Reservation> ReservationList = reservationService.getReservation();
            return SystemUtil.getObjectMapper().writeValueAsString(ReservationList);
        } catch (Exception e) {
            return e.getMessage();
        }
    }


    //添加
    @RequestMapping(value = "/Add")
    @ResponseBody
    public String Add(HttpServletRequest request,
                      @RequestParam(required = false) String visitorid,
                      @RequestParam(required = false) String intervieweeid,
                      @RequestParam(required = false) String reason,
                      @RequestParam(required = false) String retinue,
                      @RequestParam(required = false) String belongings,
                      @RequestParam(required = false) String transport,
                      @RequestParam(required = false) String replacement,
                      @RequestParam(required = false) String visitornumber,
                      @RequestParam(required = false) String ordertime,
                      @RequestParam(required = false) String interviewtime,
                      @RequestParam(required = false) String cometime,
                      @RequestParam(required = false) String leavetime,
                      @RequestParam(required = false) String operatorid,
                      @RequestParam(required = false) String state,
                      @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Reservation reservation = new Reservation();

            if (visitorid != null) {
                reservation.setVisitorid(Integer.valueOf(visitorid));
            }

            if (intervieweeid != null) {
                reservation.setIntervieweeid(Integer.valueOf(intervieweeid));
            }

            if (reason != null) {
                reservation.setReason(reason);
            }

            if (retinue != null) {
                reservation.setRetinue(retinue);
            }

            if (belongings != null) {
                reservation.setBelongings(belongings);
            }

            if (transport != null) {
                reservation.setTransport(transport);
            }

            if (replacement != null) {
                reservation.setReplacement(replacement);
            }

            if (visitornumber != null) {
                reservation.setVisitornumber(visitornumber);
            }

            if (ordertime != null) {
                reservation.setOrdertime(ordertime);
            }

            if (interviewtime != null) {
                reservation.setInterviewtime(interviewtime);
            }

            if (cometime != null) {
                reservation.setCometime(cometime);
            }

            if (leavetime != null) {
                reservation.setLeavetime(leavetime);
            }

            if (operatorid != null) {
                reservation.setOperatorid(Integer.valueOf(operatorid));
            }
                reservation.setOperatetime(LocalDateTime.now().toString());

            if (state != null) {
                reservation.setState(Integer.valueOf(state));
            }

            if (remark != null) {
                reservation.setRemark(remark);
            }
            //执行修改添加方法
            reservationService.add(reservation);

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
                       @RequestParam(required = false) String visitorid,
                       @RequestParam(required = false) String intervieweeid,
                       @RequestParam(required = false) String reason,
                       @RequestParam(required = false) String retinue,
                       @RequestParam(required = false) String belongings,
                       @RequestParam(required = false) String transport,
                       @RequestParam(required = false) String replacement,
                       @RequestParam(required = false) String visitornumber,
                       @RequestParam(required = false) String ordertime,
                       @RequestParam(required = false) String interviewtime,
                       @RequestParam(required = false) String cometime,
                       @RequestParam(required = false) String leavetime,
                       @RequestParam(required = false) String operatorid,
                       @RequestParam(required = false) String state,
                       @RequestParam(required = false) String remark) {
        ResultModel<String> resultModel = new ResultModel<>();

        try {
            Reservation reservation = reservationService.getById(Reservation.class, Integer.valueOf(id));

            if (visitorid != null) {
                reservation.setVisitorid(Integer.valueOf(visitorid));
            }

            if (intervieweeid != null) {
                reservation.setIntervieweeid(Integer.valueOf(intervieweeid));
            }

            if (reason != null) {
                reservation.setReason(reason);
            }

            if (retinue != null) {
                reservation.setRetinue(retinue);
            }

            if (belongings != null) {
                reservation.setBelongings(belongings);
            }

            if (transport != null) {
                reservation.setTransport(transport);
            }

            if (replacement != null) {
                reservation.setReplacement(replacement);
            }

            if (visitornumber != null) {
                reservation.setVisitornumber(visitornumber);
            }

            if (ordertime != null) {
                reservation.setOrdertime(ordertime);
            }

            if (interviewtime != null) {
                reservation.setInterviewtime(interviewtime);
            }

            if (cometime != null) {
                reservation.setCometime(cometime);
            }

            if (leavetime != null) {
                reservation.setLeavetime(leavetime);
            }

            if (operatorid != null) {
                reservation.setOperatorid(Integer.valueOf(operatorid));
            }
                reservation.setOperatetime(LocalDateTime.now().toString());

            if (state != null) {
                reservation.setState(Integer.valueOf(state));
            }

            if (remark != null) {
                reservation.setRemark(remark);
            }
            //执行修改方法
            reservationService.edit(reservation);

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
            Reservation reservation = reservationService.getById(Reservation.class, Integer.valueOf(id));

            //执行删除方法
            reservationService.delete(reservation);

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