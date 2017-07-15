package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Certificate;
import com.guangtai.service.CertificateService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * CertificateServiceImpl 证件接口实现类
 */
@Service
public class CertificateServiceImpl implements CertificateService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Certificate> getCertificate() {
        String hql = "FROM Certificate";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Certificate> list = query.list();
        return list;
    }

    //根据id获取
    @Override
    @Transactional
    public Certificate getById(Class<Certificate> role, int id) {
        Certificate r = (Certificate) baseDAO.get(role, id);
        return r;
    }

    //添加
    @Override
    @Transactional
    public void add(Certificate certificate) {
        baseDAO.save(certificate);
    }

    //修改
    @Override
    @Transactional
    public void edit(Certificate certificate) {
        baseDAO.update(certificate);
    }

    //删除
    @Override
    @Transactional
    public void delete(Certificate certificate) {
        baseDAO.delete(certificate);
    }

}
