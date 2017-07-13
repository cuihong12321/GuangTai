package com.guangtai.model;

import java.io.Serializable;

/**
 * Created by Brooks on 2016/11/30.
 * ResultModel
 */
public class ResultModels<T> implements Serializable {
    private boolean success;
    private T data;
    private String id;

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
}