package com.guangtai.model.domain;

import javax.persistence.*;

/**
 * Created by Ruibu003 on 2017/6/5.
 */
@Entity
@Table(name = "menu", schema = "guangtai", catalog = "")
public class Menu {
    private int id;
    private String icon;
    private String name;
    private String url;
    private Integer parentid;
    private String updatetime;
    private String remark;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "icon")
    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    @Basic
    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "url")
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    @Basic
    @Column(name = "parentid")
    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    @Basic
    @Column(name = "updatetime")
    public String getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
    }

    @Basic
    @Column(name = "remark")
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

        Menu menu = (Menu) o;

        if (id != menu.id) return false;
        if (icon != null ? !icon.equals(menu.icon) : menu.icon != null) return false;
        if (name != null ? !name.equals(menu.name) : menu.name != null) return false;
        if (url != null ? !url.equals(menu.url) : menu.url != null) return false;
        if (parentid != null ? !parentid.equals(menu.parentid) : menu.parentid != null) return false;
        if (updatetime != null ? !updatetime.equals(menu.updatetime) : menu.updatetime != null) return false;
        if (remark != null ? !remark.equals(menu.remark) : menu.remark != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (icon != null ? icon.hashCode() : 0);
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (url != null ? url.hashCode() : 0);
        result = 31 * result + (parentid != null ? parentid.hashCode() : 0);
        result = 31 * result + (updatetime != null ? updatetime.hashCode() : 0);
        result = 31 * result + (remark != null ? remark.hashCode() : 0);
        return result;
    }
}
