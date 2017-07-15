package com.guangtai.service;

import com.guangtai.model.domain.Visitor;

import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * VisitorService 访客接口
 */
public interface VisitorService {

    List<Visitor> getVisitor();

    Visitor getById(Class<Visitor> visitor, int id);

    void add(Visitor visitor);

    void edit(Visitor visitor);

    void delete(Visitor visitor);

}
