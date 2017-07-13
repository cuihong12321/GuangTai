package com.guangtai.model.domain;

import javax.persistence.*;

@Entity
@Table(name = "reservation", schema = "guangtai", catalog = "")
public class Reservation {
    private int id;
    private Integer companyid;
    private Integer visitorid;
    private Integer certificateid;
    private String reason;
    private Integer departmentid;
    private Integer intervieweeid;
    private String ordertime;
    private String interviewtime;
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
    @Column(name = "companyid", nullable = true)
    public Integer getCompanyid() {
        return companyid;
    }

    public void setCompanyid(Integer companyid) {
        this.companyid = companyid;
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
    @Column(name = "certificateid", nullable = true)
    public Integer getCertificateid() {
        return certificateid;
    }

    public void setCertificateid(Integer certificateid) {
        this.certificateid = certificateid;
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
    @Column(name = "departmentid", nullable = true)
    public Integer getDepartmentid() {
        return departmentid;
    }

    public void setDepartmentid(Integer departmentid) {
        this.departmentid = departmentid;
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
        if (companyid != null ? !companyid.equals(that.companyid) : that.companyid != null) return false;
        if (visitorid != null ? !visitorid.equals(that.visitorid) : that.visitorid != null) return false;
        if (certificateid != null ? !certificateid.equals(that.certificateid) : that.certificateid != null)
            return false;
        if (reason != null ? !reason.equals(that.reason) : that.reason != null) return false;
        if (departmentid != null ? !departmentid.equals(that.departmentid) : that.departmentid != null) return false;
        if (intervieweeid != null ? !intervieweeid.equals(that.intervieweeid) : that.intervieweeid != null)
            return false;
        if (ordertime != null ? !ordertime.equals(that.ordertime) : that.ordertime != null) return false;
        if (interviewtime != null ? !interviewtime.equals(that.interviewtime) : that.interviewtime != null)
            return false;
        if (operatorid != null ? !operatorid.equals(that.operatorid) : that.operatorid != null) return false;
        if (operatetime != null ? !operatetime.equals(that.operatetime) : that.operatetime != null) return false;
        if (state != null ? !state.equals(that.state) : that.state != null) return false;
        if (remark != null ? !remark.equals(that.remark) : that.remark != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (companyid != null ? companyid.hashCode() : 0);
        result = 31 * result + (visitorid != null ? visitorid.hashCode() : 0);
        result = 31 * result + (certificateid != null ? certificateid.hashCode() : 0);
        result = 31 * result + (reason != null ? reason.hashCode() : 0);
        result = 31 * result + (departmentid != null ? departmentid.hashCode() : 0);
        result = 31 * result + (intervieweeid != null ? intervieweeid.hashCode() : 0);
        result = 31 * result + (ordertime != null ? ordertime.hashCode() : 0);
        result = 31 * result + (interviewtime != null ? interviewtime.hashCode() : 0);
        result = 31 * result + (operatorid != null ? operatorid.hashCode() : 0);
        result = 31 * result + (operatetime != null ? operatetime.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        return result;
    }
}
