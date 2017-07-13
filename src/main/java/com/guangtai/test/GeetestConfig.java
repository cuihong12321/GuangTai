package com.guangtai.test;

/**
 * GeetestWeb配置文件,mobile版本的id与key
 */
public class GeetestConfig {
    // 填入自己的captcha_id和private_key
    private static final String geetest_id = "28b2370dff6dbf9181f7e5ad18099f85";
    private static final String geetest_key = "0eae37d15246ce82a8b8bcd440b65026";

    public static final String getGeetest_id() {
        return geetest_id;
    }

    public static final String getGeetest_key() {
        return geetest_key;
    }
}