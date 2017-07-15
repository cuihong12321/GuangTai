package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Company;
import com.guangtai.service.CompanyService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * CompanyServiceImpl 公司接口实现类
 */
@Service
public class CompanyServiceImpl implements CompanyService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Company> getCompany() {
        String hql = "FROM Company";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Company> list = query.list();
        return list;
    }

    //根据id获取
    @Override
    @Transactional
    public Company getById(Class<Company> company, int id) {
        Company r = (Company) baseDAO.get(company, id);
        return r;
    }

    //添加
    @Override
    @Transactional
    public void add(Company company) {
        baseDAO.save(company);
    }

    //修改
    @Override
    @Transactional
    public void edit(Company Company) {
        baseDAO.update(Company);
    }

    //删除
    @Override
    @Transactional
    public void delete(Company Company) {
        baseDAO.delete(Company);
    }

}
