package com.guangtai.service;

import com.guangtai.model.domain.Company;

import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * CompanyService 公司接口
 */
public interface CompanyService {

    List<Company> getCompany();

    Company getById(Class<Company> company, int id);

    void add(Company company);

    void edit(Company company);

    void delete(Company company);

}
