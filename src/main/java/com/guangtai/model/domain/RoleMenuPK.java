package com.guangtai.model.domain;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

public class RoleMenuPK implements Serializable {
    private int roleid;
    private int menuid;

    @Column(name = "roleid", nullable = false)
    @Id
    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    @Column(name = "menuid", nullable = false)
    @Id
    public int getMenuid() {
        return menuid;
    }

    public void setMenuid(int menuid) {
        this.menuid = menuid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RoleMenuPK that = (RoleMenuPK) o;

        if (roleid != that.roleid) return false;
        if (menuid != that.menuid) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = roleid;
        result = 31 * result + menuid;
        return result;
    }
}
