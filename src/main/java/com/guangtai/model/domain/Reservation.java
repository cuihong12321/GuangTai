package com.guangtai.model.domain;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "reservation", schema = "guangtai", catalog = "")
public class Reservation {
    private int id;
    private Integer visitorid;
    private Integer intervieweeid;
    private String reason;
    private String retinue;
    private String belongings;
    private String transport;
    private String replacement;
    private String visitornumber;
    private String ordertime;
    private String interviewtime;
    private String cometime;
    private String leavetime;
    private Integer operatorid;
    private String operatetime;
    private Integer state;
    private String remark;

    @Id
    @Column(name = "id", nullable = false)
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "visitorid", nullable = true)
    public Integer getVisitorid() {
        return visitorid;
    }

    public void setVisitorid(Integer visitorid) {
        this.visitorid = visitorid;
    }

    @Basic
    @Column(name = "intervieweeid", nullable = true)
    public Integer getIntervieweeid() {
        return intervieweeid;
    }

    public void setIntervieweeid(Integer intervieweeid) {
        this.intervieweeid = intervieweeid;
    }

    @Basic
    @Column(name = "reason", nullable = true, length = 2000)
    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    @Basic
    @Column(name = "retinue", nullable = true, length = 200)
    public String getRetinue() {
        return retinue;
    }

    public void setRetinue(String retinue) {
        this.retinue = retinue;
    }

    @Basic
    @Column(name = "belongings", nullable = true, length = 200)
    public String getBelongings() {
        return belongings;
    }

    public void setBelongings(String belongings) {
        this.belongings = belongings;
    }

    @Basic
    @Column(name = "transport", nullable = true, length = 50)
    public String getTransport() {
        return transport;
    }

    public void setTransport(String transport) {
        this.transport = transport;
    }

    @Basic
    @Column(name = "replacement", nullable = true, length = 50)
    public String getReplacement() {
        return replacement;
    }

    public void setReplacement(String replacement) {
        this.replacement = replacement;
    }

    @Basic
    @Column(name = "visitornumber", nullable = true, length = 50)
    public String getVisitornumber() {
        return visitornumber;
    }

    public void setVisitornumber(String visitornumber) {
        this.visitornumber = visitornumber;
    }

    @Basic
    @Column(name = "ordertime", nullable = true)
    public String getOrdertime() {
        return ordertime;
    }

    public void setOrdertime(String ordertime) {
        this.ordertime = ordertime;
    }

    @Basic
    @Column(name = "interviewtime", nullable = true)
    public String getInterviewtime() {
        return interviewtime;
    }

    public void setInterviewtime(String interviewtime) {
        this.interviewtime = interviewtime;
    }

    @Basic
    @Column(name = "cometime", nullable = true)
    public String getCometime() {
        return cometime;
    }

    public void setCometime(String cometime) {
        this.cometime = cometime;
    }

    @Basic
    @Column(name = "leavetime", nullable = true)
    public String getLeavetime() {
        return leavetime;
    }

    public void setLeavetime(String leavetime) {
        this.leavetime = leavetime;
    }

    @Basic
    @Column(name = "operatorid", nullable = true)
    public Integer getOperatorid() {
        return operatorid;
    }

    public void setOperatorid(Integer operatorid) {
        this.operatorid = operatorid;
    }

    @Basic
    @Column(name = "operatetime", nullable = true)
    public String getOperatetime() {
        return operatetime;
    }

    public void setOperatetime(String operatetime) {
        this.operatetime = operatetime;
    }

    @Basic
    @Column(name = "state", nullable = true)
    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    @Basic
    @Column(name = "remark", nullable = true, length = 2000)
    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Reservation that = (Reservation) o;

        if (id != that.id) return false;
        if (visitorid != null ? !visitorid.equals(that.visitorid) : that.visitorid != null) return false;
        if (intervieweeid != null ? !intervieweeid.equals(that.intervieweeid) : that.intervieweeid != null)
            return false;
        if (reason != null ? !reason.equals(that.reason) : that.reason != null) return false;
        if (retinue != null ? !retinue.equals(that.retinue) : that.retinue != null) return false;
        if (belongings != null ? !belongings.equals(that.belongings) : that.belongings != null) return false;
        if (transport != null ? !transport.equals(that.transport) : that.transport != null) return false;
        if (replacement != null ? !replacement.equals(that.replacement) : that.replacement != null) return false;
        if (visitornumber != null ? !visitornumber.equals(that.visitornumber) : that.visitornumber != null)
            return false;
        if (ordertime != null ? !ordertime.equals(that.ordertime) : that.ordertime != null) return false;
        if (interviewtime != null ? !interviewtime.equals(that.interviewtime) : that.interviewtime != null)
            return false;
        if (cometime != null ? !cometime.equals(that.cometime) : that.cometime != null) return false;
        if (leavetime != null ? !leavetime.equals(that.leavetime) : that.leavetime != null) return false;
        if (operatorid != null ? !operatorid.equals(that.operatorid) : that.operatorid != null) return false;
        if (operatetime != null ? !operatetime.equals(that.operatetime) : that.operatetime != null) return false;
        if (state != null ? !state.equals(that.state) : that.state != null) return false;
        if (remark != null ? !remark.equals(that.remark) : that.remark != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (visitorid != null ? visitorid.hashCode() : 0);
        result = 31 * result + (intervieweeid != null ? intervieweeid.hashCode() : 0);
        result = 31 * result + (reason != null ? reason.hashCode() : 0);
        result = 31 * result + (retinue != null ? retinue.hashCode() : 0);
        result = 31 * result + (belongings != null ? belongings.hashCode() : 0);
        result = 31 * result + (transport != null ? transport.hashCode() : 0);
        result = 31 * result + (replacement != null ? replacement.hashCode() : 0);
        result = 31 * result + (visitornumber != null ? visitornumber.hashCode() : 0);
        result = 31 * result + (ordertime != null ? ordertime.hashCode() : 0);
        result = 31 * result + (interviewtime != null ? interviewtime.hashCode() : 0);
        result = 31 * result + (cometime != null ? cometime.hashCode() : 0);
        result = 31 * result + (leavetime != null ? leavetime.hashCode() : 0);
        result = 31 * result + (operatorid != null ? operatorid.hashCode() : 0);
        result = 31 * result + (operatetime != null ? operatetime.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        return result;
    }
}
