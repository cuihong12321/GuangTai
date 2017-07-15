package com.guangtai.service;

import com.guangtai.model.domain.Reservation;

import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * ReservationService 预约单接口
 */
public interface ReservationService {

    List<Reservation> getReservation();

    Reservation getById(Class<Reservation> reservation, int id);

    void add(Reservation reservation);

    void edit(Reservation reservation);

    void delete(Reservation reservation);

}
