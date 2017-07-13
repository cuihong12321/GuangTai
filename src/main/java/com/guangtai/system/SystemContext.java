package com.guangtai.system;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * Created by Brooks on 2016-01-19.
 * SystemContext 获取系统 Spring Context
 */
public final class SystemContext implements ApplicationContextAware {
    private static ApplicationContext applicationContext = null;

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        if (SystemContext.applicationContext == null) {
            SystemContext.applicationContext = applicationContext;
        }
    }

    public static Object getBean(String name) {
        return SystemContext.applicationContext.getBean(name);
    }
}