package com.guangtai.controller;

import io.ruibu.util.ConvertUtil;
import io.ruibu.util.HttpUtil;
import io.ruibu.util.SystemUtil;
import io.ruibu.util.WeChatUtil;
import org.apache.http.HttpEntity;
import org.apache.http.util.EntityUtils;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Brooks on 2016/12/9.
 * SystemController
 */
@Controller
@RequestMapping(value = "/System")
public class SystemController {

    @RequestMapping(value = "/UploadFile", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    public void uploadFile(HttpServletRequest request, HttpServletResponse response) {
        try {
            MultipartHttpServletRequest fileRequest = (MultipartHttpServletRequest) request;//request强制转换注意
            MultipartFile file = fileRequest.getFile("imgFile");
            if (file.isEmpty()) {
                return;
            }

            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
                String saveFileName = LocalDateTime.now().format(dateTimeFormatter) + fileExtension;
                String saveDir = request.getServletContext().getRealPath("/resources/uploads/");
                File dir = new File(saveDir);
                if (!dir.exists()) {
                    if (!dir.mkdirs()) {
                        return;
                    }
                }

                String saveAbsolutePath = request.getServletContext().getRealPath("/resources/uploads/" + saveFileName);
                String saveRelativePath = request.getContextPath() + "/resources/uploads/" + saveFileName;
                File saveFile = new File(saveAbsolutePath);
                file.transferTo(saveFile);

                Map<String, Object> map = new HashMap<>();
                map.put("error", 0);
                map.put("url", saveRelativePath);
                response.getWriter().write(SystemUtil.getObjectMapper().writeValueAsString(map));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    @RequestMapping(value = "/DownloadImage")
    @ResponseBody
    public String downloadImage(@RequestParam("media_id") String media_id, HttpServletRequest request) {
        HttpEntity httpEntity = null;
        String saveRelativePath = "";

        try {
            httpEntity = HttpUtil.doGetMore("http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + WeChatUtil.getAccessToken(false) + "&media_id=" + media_id);
            if (!httpEntity.getContentType().getValue().equals("image/jpeg")) {
                httpEntity = HttpUtil.doGetMore("http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + WeChatUtil.getAccessToken(true) + "&media_id=" + media_id);
            }

            byte[] bytes = EntityUtils.toByteArray(httpEntity);

            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
            String saveFileName = LocalDateTime.now().format(dateTimeFormatter) + SystemUtil.getRandomString(12) + ".jpg";
            String saveDir = request.getServletContext().getRealPath("/resources/uploads/");
            File dir = new File(saveDir);
            if (!dir.exists()) {
                if (!dir.mkdirs()) {
                    return "";
                }
            }

            String saveAbsolutePath = request.getServletContext().getRealPath("/resources/uploads/" + saveFileName);
            saveRelativePath = request.getContextPath() + "/resources/uploads/" + saveFileName;

            ConvertUtil.bytesToFile(bytes, saveAbsolutePath);
        } catch (Exception e) {
            LogManager.getLogger().error(e.toString());
        } finally {
            if (httpEntity != null) {
                try {
                    EntityUtils.consume(httpEntity);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return saveRelativePath;
    }

    @RequestMapping(value = "/Test/{path}")
    @ResponseBody
    public String Test(HttpServletRequest request, HttpServletResponse response, @PathVariable String path) {
        try {
            String reportPath = request.getServletContext().getRealPath("/resources/report") + "/" + path;
            return reportPath;
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}