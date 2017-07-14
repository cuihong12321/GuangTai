package com.guangtai.model;

import java.io.Serializable;

public class RoleMenuTreeModel implements Serializable {
    private int id;
    private String name;
    private Integer parentid;
    private String url;

    public RoleMenuTreeModel() {
    }

    public RoleMenuTreeModel(int id, String name, Integer parentid, String url) {
        this.id = id;
        this.name = name;
        this.parentid = parentid;
        this.url = url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getParentid() {
        return parentid;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}