package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;

import com.guangtai.model.domain.RoleMenu;
import com.guangtai.service.RoleMenuService;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Ruibu003 on 2017/6/5.
 */
@Service
public class RoleMenuServiceImpl implements RoleMenuService {
    @Autowired
    private BaseDAO baseDAO;

    @Override
    public List<RoleMenu> getRoleMenu() {
        String hql = "from RoleMenu m ";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<RoleMenu> list = query.list();
        return list;
    }

    @Override
    public RoleMenu getById(Class<RoleMenu> roleMenu, int id) {
        RoleMenu r = (RoleMenu) baseDAO.get(roleMenu, id);
        return r;
    }

    @Override
    public void add(RoleMenu roleMenu) {
        baseDAO.save(roleMenu);
    }

    @Override
    public void edit(RoleMenu roleMenu) {
        baseDAO.update(roleMenu);
    }

    @Override
    public void delete(RoleMenu roleMenu) {
        baseDAO.delete(roleMenu);
    }
}
