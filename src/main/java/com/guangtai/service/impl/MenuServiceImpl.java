package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Menu;
import com.guangtai.service.MenuService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Ruibu006 on 2017/3/17.
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Menu> getMenu() {
        String hql = "from Menu m ";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Menu> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public Menu getById(Class<Menu> menu, int id) {
        Menu h = (Menu) baseDAO.get(menu, id);
        return h;
    }

    @Override
    @Transactional
    public void add(Menu menu) {
        baseDAO.save(menu);
    }

    @Override
    @Transactional
    public void edit(Menu menu) {
        baseDAO.update(menu);
    }

    @Override
    @Transactional
    public void delete(Menu menu) {
        baseDAO.delete(menu);
    }

}
