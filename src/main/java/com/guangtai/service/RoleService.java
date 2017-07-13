package com.guangtai.service;

import com.guangtai.model.domain.Role;

import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * RoleService 角色接口
 */
public interface RoleService {

    List<Role> getRole();

    Role getById(Class<Role> role, int id);

    void add(Role role);

    void edit(Role role);

    void delete(Role role);

}
