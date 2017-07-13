package com.guangtai.service;

import com.guangtai.model.domain.User;

import java.util.List;

/**
 * Created by Brooks on 2016/11/30.
 * UserService
 */
public interface UserService {

    List<User> getUser();

    User getById(Class<User> user, int id);

    void add(User user);

    void edit(User user);

    void delete(User user);

    User getByUserNameAndPassword(String userName, String password);

    User getByName(String name);
}