package com.guangtai.service;

import com.guangtai.model.domain.DepartMent;

import java.util.List;
/**
 * Created by Rojackios on 2017/2/14.
 * DepartMentService 部门接口
 */
public interface DepartMentService {

    List<DepartMent> getDepartMent();

    DepartMent getById(Class<DepartMent> departMent, int id);

    void add(DepartMent departMent);

    void edit(DepartMent departMent);

    void delete(DepartMent departMent);

}
