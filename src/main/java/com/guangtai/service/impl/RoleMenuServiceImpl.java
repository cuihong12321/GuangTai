package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.RoleMenuTreeModel;
import com.guangtai.model.domain.RoleMenu;
import com.guangtai.service.RoleMenuService;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Ruibu003 on 2017/6/5.
 */
@Service
public class RoleMenuServiceImpl implements RoleMenuService {
    @Autowired
    private BaseDAO baseDAO;

    @Override
    @Transactional
    public List<RoleMenu> getRoleMenu() {
        String hql = "from RoleMenu rm ";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<RoleMenu> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public List<Integer> getMenuList(int roleid) {
        String hql = "select rm.menuid " +
                "from RoleMenu rm " +
                "where rm.roleid = :roleid " +
                "order by rm.menuid";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        query.setParameter("roleid", roleid);
        List<Integer> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public List<RoleMenuTreeModel> getRoleMenuList(int roleid) {
        String hql = "select new com.guangtai.model.RoleMenuTreeModel(rm.menuid, m.name, m.parentid,m.url) " +
                "from RoleMenu rm " +
                "join Menu m on rm.menuid = m.id " +
                "where rm.roleid = :roleid " +
                "order by rm.menuid";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        query.setParameter("roleid", roleid);
        List<RoleMenuTreeModel> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public List<RoleMenu> getRoleMenu(int roleid) {
        String hql = " from RoleMenu rm where rm.roleid = :roleid";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        query.setParameter("roleid", roleid);
        List<RoleMenu> list = query.list();
        return list;
    }

    //添加权限
    @Override
    @Transactional
    public void addRoleMenu(RoleMenu roleMenu) {
        baseDAO.save(roleMenu);
    }

    //修改权限
    @Override
    @Transactional
    public void editRoleMenu(RoleMenu roleMenu) {
        baseDAO.update(roleMenu);
    }

    //删除权限
    @Override
    @Transactional
    public void delRoleMenu(RoleMenu roleMenu) {
        baseDAO.delete(roleMenu);
    }
}