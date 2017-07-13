package com.guangtai.test;

import java.io.Serializable;

/**
 * Created by Brooks on 2017/2/9.
 * GeeTestResultModel
 */
public class GeeTestResultModel implements Serializable {
    private String status;
    private String version;

    public GeeTestResultModel() {
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }
}