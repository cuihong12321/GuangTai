package com.guangtai.service;

import com.guangtai.model.RoleMenuTreeModel;
import com.guangtai.model.domain.RoleMenu;

import java.util.List;

/**
 * Created by Ruibu003 on 2017/6/5.
 */
public interface RoleMenuService {
    List<RoleMenu> getRoleMenu();

    List<Integer> getMenuList(int roleid);

    List<RoleMenuTreeModel> getRoleMenuList(int roleid);

    List<RoleMenu> getRoleMenu(int roleid);

    void addRoleMenu(RoleMenu roleMenu);

    void editRoleMenu(RoleMenu roleMenu);

    void delRoleMenu(RoleMenu roleMenu);
}