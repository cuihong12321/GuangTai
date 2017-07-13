package com.guangtai.model.domain;

import javax.persistence.*;

@Entity
@Table(name = "visitor", schema = "guangtai", catalog = "")
public class Visitor {
    private int id;
    private Integer certificateid;
    private Integer companyid;
    private String name;
    private String retinue;
    private String belongings;
    private String certificatenumber;
    private String transport;
    private String carnumber;
    private String replacement;
    private String visitornumber;
    private String telephone;
    private String cometime;
    private String leavetime;
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
    @Column(name = "certificateid", nullable = true)
    public Integer getCertificateid() {
        return certificateid;
    }

    public void setCertificateid(Integer certificateid) {
        this.certificateid = certificateid;
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
    @Column(name = "name", nullable = true, length = 50)
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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
    @Column(name = "certificatenumber", nullable = true, length = 50)
    public String getCertificatenumber() {
        return certificatenumber;
    }

    public void setCertificatenumber(String certificatenumber) {
        this.certificatenumber = certificatenumber;
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
    @Column(name = "carnumber", nullable = true, length = 50)
    public String getCarnumber() {
        return carnumber;
    }

    public void setCarnumber(String carnumber) {
        this.carnumber = carnumber;
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
    @Column(name = "telephone", nullable = true, length = 50)
    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
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

        Visitor visitor = (Visitor) o;

        if (id != visitor.id) return false;
        if (certificateid != null ? !certificateid.equals(visitor.certificateid) : visitor.certificateid != null)
            return false;
        if (companyid != null ? !companyid.equals(visitor.companyid) : visitor.companyid != null) return false;
        if (name != null ? !name.equals(visitor.name) : visitor.name != null) return false;
        if (retinue != null ? !retinue.equals(visitor.retinue) : visitor.retinue != null) return false;
        if (belongings != null ? !belongings.equals(visitor.belongings) : visitor.belongings != null) return false;
        if (certificatenumber != null ? !certificatenumber.equals(visitor.certificatenumber) : visitor.certificatenumber != null)
            return false;
        if (transport != null ? !transport.equals(visitor.transport) : visitor.transport != null) return false;
        if (carnumber != null ? !carnumber.equals(visitor.carnumber) : visitor.carnumber != null) return false;
        if (replacement != null ? !replacement.equals(visitor.replacement) : visitor.replacement != null) return false;
        if (visitornumber != null ? !visitornumber.equals(visitor.visitornumber) : visitor.visitornumber != null)
            return false;
        if (telephone != null ? !telephone.equals(visitor.telephone) : visitor.telephone != null) return false;
        if (cometime != null ? !cometime.equals(visitor.cometime) : visitor.cometime != null) return false;
        if (leavetime != null ? !leavetime.equals(visitor.leavetime) : visitor.leavetime != null) return false;
        if (remark != null ? !remark.equals(visitor.remark) : visitor.remark != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (certificateid != null ? certificateid.hashCode() : 0);
        result = 31 * result + (companyid != null ? companyid.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (retinue != null ? retinue.hashCode() : 0);
        result = 31 * result + (belongings != null ? belongings.hashCode() : 0);
        result = 31 * result + (certificatenumber != null ? certificatenumber.hashCode() : 0);
        result = 31 * result + (transport != null ? transport.hashCode() : 0);
        result = 31 * result + (carnumber != null ? carnumber.hashCode() : 0);
        result = 31 * result + (replacement != null ? replacement.hashCode() : 0);
        result = 31 * result + (visitornumber != null ? visitornumber.hashCode() : 0);
        result = 31 * result + (telephone != null ? telephone.hashCode() : 0);
        result = 31 * result + (cometime != null ? cometime.hashCode() : 0);
        result = 31 * result + (leavetime != null ? leavetime.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        return result;
    }
}
