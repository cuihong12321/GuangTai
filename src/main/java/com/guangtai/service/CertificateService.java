package com.guangtai.service;

import com.guangtai.model.domain.Certificate;

import java.util.List;

/**
 * Created by Rojackios on 2017/2/14.
 * CertificateService 证件接口
 */
public interface CertificateService {

    List<Certificate> getCertificate();

    Certificate getById(Class<Certificate> certificate, int id);

    void add(Certificate certificate);

    void edit(Certificate certificate);

    void delete(Certificate certificate);

}
