package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Interviewee;
import com.guangtai.service.IntervieweeService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * IntervieweeServiceImpl 被访人接口实现类
 */
@Service
public class IntervieweeServiceImpl implements IntervieweeService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Interviewee> getInterviewee() {
        String hql = "FROM Interviewee";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Interviewee> list = query.list();
        return list;
    }

    //根据id获取
    @Override
    @Transactional
    public Interviewee getById(Class<Interviewee> interviewee, int id) {
        Interviewee r = (Interviewee) baseDAO.get(interviewee, id);
        return r;
    }

    //添加
    @Override
    @Transactional
    public void add(Interviewee interviewee) {
        baseDAO.save(interviewee);
    }

    //修改
    @Override
    @Transactional
    public void edit(Interviewee interviewee) {
        baseDAO.update(interviewee);
    }

    //删除
    @Override
    @Transactional
    public void delete(Interviewee interviewee) {
        baseDAO.delete(interviewee);
    }

}
