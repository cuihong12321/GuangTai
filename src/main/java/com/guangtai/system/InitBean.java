package com.guangtai.system;


import io.ruibu.util.RongLianUtil;
import io.ruibu.util.WeChatUtil;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.event.ContextRefreshedEvent;

/**
 * Created by Brooks on 2016-01-19.
 * InitBean
 */
@Configuration
public class InitBean implements ApplicationListener<ContextRefreshedEvent> {

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        try {
            if (event.getApplicationContext().getParent() == null) {
                //需要执行的逻辑代码，当spring容器初始化完成后就会执行该方法。

                //初始化
                WeChatUtil.init("config/WeChat.properties");
                RongLianUtil.init("config/RongLian.properties");

//                UserService userService = (UserService) SystemContext.getBean("UserService");
//                List<User> listUser = userService.getTempUsers();
//
//                for (User u : listUser) {
//                    if (u.getUsername().equals("admin")) {
//                        u.setPassword(SecurityUtil.encrypt("Netmegavisi741212", SecurityUtil.AlgorithmType.SHA512));
//                    } else {
//                        u.setPassword(SecurityUtil.encrypt("888888", SecurityUtil.AlgorithmType.SHA512));
//                    }
//
//                    userService.edit(u);
//                }
//
//                String menu = WeChatUtil.getMenu();
//
//                System.out.println(menu);
//
//                WeChatUtil.deleteMenu();
//
//                menu = "{\n" +
//                        "\t\"button\": [{\n" +
//                        "\t\t\"type\": \"view\",\n" +
//                        "\t\t\"name\": \"爱车无限\",\n" +
//                        "\t\t\"url\": \"https://www.ruibu.info/Home/Login\",\n" +
//                        "\t\t\"sub_button\": []\n" +
//                        "\t},\n" +
//                        "\t{\n" +
//                        "\t\t\"type\": \"view\",\n" +
//                        "\t\t\"name\": \"官网\",\n" +
//                        "\t\t\"url\": \"https://www.ruibu.info\",\n" +
//                        "\t\t\"sub_button\": []\n" +
//                        "\t}\n" +
//                        "}";
//
//                WeChatUtil.createMenu(menu);
//
//                System.out.println(menu);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}