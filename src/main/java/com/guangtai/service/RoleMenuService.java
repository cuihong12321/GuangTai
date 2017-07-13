package com.guangtai.service;

import com.guangtai.model.domain.RoleMenu;

import java.util.List;

/**
 * Created by Ruibu003 on 2017/6/5.
 */
public interface RoleMenuService {

    List<RoleMenu> getRoleMenu();

    RoleMenu getById(Class<RoleMenu> roleMenu, int id);

    void add(RoleMenu roleMenu);

    void edit(RoleMenu roleMenu);

    void delete(RoleMenu roleMenu);

}
