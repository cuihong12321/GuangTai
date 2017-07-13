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
    private BaseDAO<User> baseDAO;

    @Override
    public List<User> getUser() {
        return null;
    }

    @Override
    public User getById(Class<User> user, int id) {
        return null;
    }

    @Override
    public void add(User user) {

    }

    @Override
    public void edit(User user) {

    }

    @Override
    public void delete(User user) {

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