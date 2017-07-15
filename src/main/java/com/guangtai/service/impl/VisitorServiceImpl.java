package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Visitor;
import com.guangtai.service.VisitorService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * VisitorServiceImpl 访客接口实现类
 */
@Service
public class VisitorServiceImpl implements VisitorService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Visitor> getVisitor() {
        String hql = "FROM Visitor";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Visitor> list = query.list();
        return list;
    }

    //根据id获取
    @Override
    @Transactional
    public Visitor getById(Class<Visitor> visitor, int id) {
        Visitor r = (Visitor) baseDAO.get(visitor, id);
        return r;
    }

    //添加
    @Override
    @Transactional
    public void add(Visitor visitor) {
        baseDAO.save(visitor);
    }

    //修改
    @Override
    @Transactional
    public void edit(Visitor visitor) {
        baseDAO.update(visitor);
    }

    //删除
    @Override
    @Transactional
    public void delete(Visitor visitor) {
        baseDAO.delete(visitor);
    }

}
