package com.guangtai.model.domain;

import javax.persistence.*;

@Entity
@Table(name = "relomenu", schema = "guangtai", catalog = "")
@IdClass(RoleMenuPK.class)
public class RoleMenu {
    private int roleid;
    private int menuid;
    private String updatetime;
    private String remark;

    @Id
    @Column(name = "roleid", nullable = false)
    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    @Id
    @Column(name = "menuid", nullable = false)
    public int getMenuid() {
        return menuid;
    }

    public void setMenuid(int menuid) {
        this.menuid = menuid;
    }

    @Basic
    @Column(name = "updatetime", nullable = true)
    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
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

        RoleMenu roleMenu = (RoleMenu) o;

        if (roleid != roleMenu.roleid) return false;
        if (menuid != roleMenu.menuid) return false;
        if (updatetime != null ? !updatetime.equals(roleMenu.updatetime) : roleMenu.updatetime != null) return false;
        if (remark != null ? !remark.equals(roleMenu.remark) : roleMenu.remark != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = roleid;
        result = 31 * result + menuid;
        result = 31 * result + (updatetime != null ? updatetime.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        return result;
    }
}
