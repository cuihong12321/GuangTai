package com.guangtai.model;

import com.guangtai.model.domain.User;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * ResultModel
 */
public class ResultModels<T> implements Serializable {
    private boolean success;
    private T data;
    private String id;
    private List<Integer> ids;
    private User user;

    public ResultModels() {
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<Integer> getIds() {
        return ids;
    }

    public void setIds(List<Integer> ids) {
        this.ids = ids;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}