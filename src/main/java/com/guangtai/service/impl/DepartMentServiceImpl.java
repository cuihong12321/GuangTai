package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.DepartMent;
import com.guangtai.service.DepartMentService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * DepartMentServiceImpl 部门接口实现类
 */
@Service
public class DepartMentServiceImpl implements DepartMentService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<DepartMent> getDepartMent() {
        String hql = "FROM DepartMent";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<DepartMent> list = query.list();
        return list;
    }

    //根据id获取
    @Override
    @Transactional
    public DepartMent getById(Class<DepartMent> departMent, int id) {
        DepartMent r = (DepartMent) baseDAO.get(departMent, id);
        return r;
    }

    //添加
    @Override
    @Transactional
    public void add(DepartMent departMent) {
        baseDAO.save(departMent);
    }

    //修改
    @Override
    @Transactional
    public void edit(DepartMent departMent) {
        baseDAO.update(departMent);
    }

    //删除
    @Override
    @Transactional
    public void delete(DepartMent departMent) {
        baseDAO.delete(departMent);
    }

}
