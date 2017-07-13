package com.guangtai.controller;

import com.guangtai.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Brooks on 3/21/2017.
 * TestController
 */
@Controller
@RequestMapping(value = "/Test")
public class TestController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/QRCodeTest")
    @ResponseBody
    public String QRCodeTest(HttpServletRequest request) {
        try {
//            List<User> listUser = userService.getAllUsers();
//
//            for (User u : listUser) {
//                if (!StringUtils.isEmpty(u.getQrcode())) {
//                    File file = new File(request.getServletContext().getRealPath((u.getQrcode())));
//                    if (file.exists()) {
//                        file.delete();
//                    }
//
//                    String negotiationurl = "https://www.ruibu.info/Home/Index?referrerid=" + u.getId();
//                    negotiationurl = WeChatUtil.getRedirectUrl(negotiationurl, WeChatUtil.GrantType.USERINFO);
//
//                    LocalDateTime localDateTime = LocalDateTime.now();
//                    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
//
//                    String parentDir = localDateTime.getYear() + File.separator + localDateTime.getMonth().getValue();
//                    String saveDir = request.getServletContext().getRealPath("/resources/uploads/") + File.separator + parentDir;
//
//                    File fileDir = new File(saveDir);
//                    if (!fileDir.exists()) {
//                        fileDir.mkdirs();
//                    }
//
//                    String imagename = localDateTime.format(dateTimeFormatter) + ".jpg";
//                    String qrcodeimageurl = saveDir + File.separator + imagename;
//                    SystemUtil.createQrCode(200, 200, negotiationurl, qrcodeimageurl, "jpg");
//                    String url = request.getContextPath() + File.separator + "resources" + File.separator + "uploads" + File.separator + parentDir + File.separator + imagename;
//
//                    u.setQrcode(url);
//
//                    userService.edit(u);
//                }
//            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "Success";
    }
}