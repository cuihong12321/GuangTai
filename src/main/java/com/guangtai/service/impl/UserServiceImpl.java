package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.User;
import com.guangtai.service.UserService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * UserServiceImpl
 */
@Service("UserService")
public class UserServiceImpl implements UserService {
    @Resource
    private BaseDAO baseDAO;

    @Override
    @Transactional
    public List<User> getUser() {
        String hql = "FROM User";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<User> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public User getById(Class<User> user, int id) {
        User u = (User) baseDAO.get(user, id);
        return u;
    }

    @Override
    @Transactional
    public void add(User user) {
        baseDAO.save(user);
    }

    @Override
    @Transactional
    public void edit(User user) {
        baseDAO.update(user);
    }

    @Override
    @Transactional
    public void delete(User user) {
        baseDAO.delete(user);
    }

    @Override
    @Transactional
    public User getByUserNameAndPassword(String username, String password) {
        String hql = "from User u " +
                "where (u.telephone = :telephone or u.username = :username) and u.password =:password ";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        query.setParameter("username", username);
        query.setParameter("telephone", username);
        query.setParameter("password", password);
        List<User> listUser = query.list();

        if (listUser == null || listUser.size() == 0) {
            return null;
        } else {
            return listUser.get(0);
        }
    }

    @Override
    @Transactional
    public User getByName(String name) {
        String hql = "from User u " +
                "where u.username = :name";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        query.setParameter("name", name);
        List<User> listUser = query.list();

        if (listUser == null || listUser.size() == 0) {
            return null;
        } else {
            return listUser.get(0);
        }
    }

}