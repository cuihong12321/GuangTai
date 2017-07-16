package com.guangtai.service.impl;

import com.guangtai.dao.BaseDAO;
import com.guangtai.model.domain.Reservation;
import com.guangtai.service.ReservationService;
import org.hibernate.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * ReservationServiceImpl 预约单接口实现类
 */
@Service
public class ReservationServiceImpl implements ReservationService {
    @Resource
    BaseDAO baseDAO;

    @Override
    @Transactional
    public List<Reservation> getNewReservation() {
        String hql = "FROM Reservation r where r.state < 1";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Reservation> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public List<Reservation> getEditReservation() {
        String hql = "FROM Reservation r where r.state >= 1";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Reservation> list = query.list();
        return list;
    }

    @Override
    @Transactional
    public List<Reservation> getReservation() {
        String hql = "FROM Reservation";
        Query query = baseDAO.getSessionFactory().getCurrentSession().createQuery(hql);
        List<Reservation> list = query.list();
        return list;
    }

    //根据id获取
    @Override
    @Transactional
    public Reservation getById(Class<Reservation> reservation, int id) {
        Reservation r = (Reservation) baseDAO.get(reservation, id);
        return r;
    }

    //添加
    @Override
    @Transactional
    public void add(Reservation reservation) {
        baseDAO.save(reservation);
    }

    //修改
    @Override
    @Transactional
    public void edit(Reservation reservation) {
        baseDAO.update(reservation);
    }

    //删除
    @Override
    @Transactional
    public void delete(Reservation reservation) {
        baseDAO.delete(reservation);
    }

}
