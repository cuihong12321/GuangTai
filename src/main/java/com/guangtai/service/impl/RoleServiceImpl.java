package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Role;
import com.guangtai.service.RoleService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * RoleServiceImpl 角色接口实现类
 */
@Service
public class RoleServiceImpl implements RoleService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Role> getRole() {
        String hql = "FROM Role";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Role> list = query.list();
        return list;
    }

    //根据id获取角色
    @Override
    @Transactional
    public Role getById(Class<Role> role, int id) {
        Role r = (Role) baseDAO.get(role, id);
        return r;
    }

    //添加角色
    @Override
    @Transactional
    public void add(Role role) {
        baseDAO.save(role);
    }

    //修改角色
    @Override
    @Transactional
    public void edit(Role role) {
        baseDAO.update(role);
    }

    //删除角色
    @Override
    @Transactional
    public void delete(Role role) {
        baseDAO.delete(role);
    }

}
