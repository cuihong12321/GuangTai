package com.guangtai.system;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.hibernate5.HibernateTransactionManager;
import org.springframework.orm.hibernate5.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.util.Properties;

/**
 * Created by wangsen on 1/19/15.
 * DefaultConfig
 */
@Configuration
@EnableTransactionManagement
@ComponentScan(basePackages = {"com.guangtai"})
public class DefaultConfig {
    @Bean
    public InternalResourceViewResolver internalResourceViewResolver() {
        InternalResourceViewResolver internalResourceViewResolver = new InternalResourceViewResolver();
        internalResourceViewResolver.setPrefix("/WEB-INF/Views/");
        internalResourceViewResolver.setSuffix(".jsp");
        return internalResourceViewResolver;
    }

    String driverClass = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/guangtai?characterEncoding=UTF-8&useSSL=false";
    String user = "root";
    String password = "mysql#";

    @Bean
    public DataSource dataSource() throws PropertyVetoException {
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        dataSource.setDriverClass(driverClass);
        dataSource.setJdbcUrl(url);
        dataSource.setUser(user);
        dataSource.setPassword(password);
        dataSource.setCheckoutTimeout(30000);//当连接池用完时客户端调用getConnection()后等待获取新连接的时间，超时后将抛出SQLException,如设为0则无限期等待。单位毫秒。Default: 0
        dataSource.setMaxStatements(0);//用以控制数据源内加载的PreparedStatements数量
        dataSource.setNumHelperThreads(3);//c3p0是异步操作的，有效的提升性能
        dataSource.setAcquireIncrement(10);//连接池中连接耗尽时c3p0一次获取的连接数
        dataSource.setIdleConnectionTestPeriod(10);//每60秒检查所有连接池中的空闲连接
        dataSource.setInitialPoolSize(10);//初始化时获取的连接数量
        dataSource.setMaxPoolSize(300);//连接池中最大连接数量
        dataSource.setMaxIdleTime(60);//最大空闲时间
        dataSource.setTestConnectionOnCheckin(true);
        dataSource.setTestConnectionOnCheckout(true);
        dataSource.setAutoCommitOnClose(false);
        dataSource.setAutomaticTestTable("C3P0TestTable");
        return dataSource;
    }

    @Bean
    public LocalSessionFactoryBean sessionFactory() throws PropertyVetoException {
        LocalSessionFactoryBean sessionFactoryBean = new LocalSessionFactoryBean();
        sessionFactoryBean.setDataSource(dataSource());
        sessionFactoryBean.setPackagesToScan("com.guangtai.model");
        Properties hibernateProperties = new Properties();
        hibernateProperties.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL57InnoDBDialect");
        hibernateProperties.setProperty("hibernate.show_sql", "false");
        hibernateProperties.setProperty("hibernate.autoReconnect", "true");
        hibernateProperties.setProperty("hibernate.query.substitutions", "true 1, false 0");
        sessionFactoryBean.setHibernateProperties(hibernateProperties);
        return sessionFactoryBean;
    }

    @Bean
    public HibernateTransactionManager txManager() throws PropertyVetoException {
        HibernateTransactionManager txManager = new HibernateTransactionManager();
        txManager.setSessionFactory(sessionFactory().getObject());
        return txManager;
    }

    @Bean
    public JdbcTemplate jdbcTemplate() throws PropertyVetoException {
        return new JdbcTemplate(dataSource());
    }

    @Bean
    public CommonsMultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding("UTF-8");
        multipartResolver.setMaxUploadSize(1024 * 1024 * 500);//500 MB，单位 byte
        multipartResolver.setMaxInMemorySize(512);
        return multipartResolver;
    }

    @Bean
    public StandardServletMultipartResolver portletMultipartResolver() {
        return new StandardServletMultipartResolver();
    }

    @Bean
    public InitBean initBean() {
        return new InitBean();
    }

    @Bean
    public SystemContext systemContext() {
        return new SystemContext();
    }
}