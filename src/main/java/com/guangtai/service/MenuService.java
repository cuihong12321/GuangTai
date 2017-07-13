package com.guangtai.service;

import com.guangtai.model.domain.Menu;

import java.util.List;

public interface MenuService {

    List<Menu> getMenu();

    Menu getById(Class<Menu> menu, int id);

    void add(Menu menu);

    void edit(Menu menu);

    void delete(Menu menu);

}
