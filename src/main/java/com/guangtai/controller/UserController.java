package com.guangtai.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.guangtai.model.domain.User;
import com.guangtai.service.*;
import io.ruibu.model.ResultModel;
import io.ruibu.model.wechat.UnionUserModel;
import io.ruibu.util.*;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


/**
 * Created by Ruibu005 on 2017/2/10.
 * UserController
 */
@Controller
@RequestMapping(value = "/User")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private RoleService roleService;

    @RequestMapping(value = "/IsSubscribe")
    @ResponseBody
    public String IsSubscribe(HttpServletRequest request) {
        try {
            UnionUserModel unionUserModel = WeChatUtil.getUnionUser(request.getParameter("openid"));
            ResultModel<String> resultModel = new ResultModel<>();
            if (unionUserModel.getSubscribe() == 1) {
                resultModel.setSuccess(true);
                resultModel.setData("已关注！");
            } else {
                resultModel.setSuccess(false);
                resultModel.setData("请关注【挣点油钱】公众号再访问！");
            }
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (JsonProcessingException e) {
            LogManager.getLogger().error(e.toString());
        }

        return "";
    }

//    @RequestMapping(value = "/AddUser")
//    @ResponseBody
//    public String addUser(HttpServletRequest request) {
//        ResultModel<String> resultModel = new ResultModel<>();
//        InputStream inputStream = null;
//        FileOutputStream fileOutputStream = null;
//
//        try {
//            String password = request.getParameter("password").trim();
//            String telephone = request.getParameter("telephone").trim();
//            String code = request.getParameter("code").trim();
//            String referrerid = request.getParameter("referrerid").trim();
//
//            if (telephone.equals("")) {
//                resultModel.setSuccess(false);
//                resultModel.setData("手机号不能为空！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//
//            if (code.equals("")) {
//                resultModel.setSuccess(false);
//                resultModel.setData("验证码不能为空！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//
//            String regex = "^[1][\\d]{10}$";
//            Pattern pattern = Pattern.compile(regex);
//            if (!pattern.matcher(telephone).matches()) {
//                resultModel.setSuccess(false);
//                resultModel.setData("手机号格式不正确！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//
//            User userphone = userService.getByTelephone(telephone);
//            ValidateCode validateCode = validateCodeService.getByValidateCode(code);
//
//            if (userphone != null) {
//                resultModel.setSuccess(false);
//                resultModel.setData("手机号已被注册！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//
//            if (validateCode == null) {
//                resultModel.setSuccess(false);
//                resultModel.setData("验证码错误，请重新填写！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//
//            User user = userService.getByWeChatID(request.getParameter("wechatid"));
//            if (user == null) {
//                user = new User();
//
//                LocalDateTime localDateTime1 = LocalDateTime.parse(validateCode.getSmssendtime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
//                LocalDateTime localDateTime2 = LocalDateTime.now();
//                long mintue = DateTimeUtil.getTimeBetween(localDateTime1, localDateTime2, ChronoUnit.MINUTES);
//
//                if (mintue > validateCode.getSmsperiodtime()) {
//                    resultModel.setSuccess(false);
//                    resultModel.setData("验证码失效，请重新获取！");
//                    return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//                }
//
//                if (!StringUtils.isEmpty(referrerid)) {
//                    User userReferrer = userService.getById(User.class, Integer.parseInt(referrerid));
//                    int regionid = userReferrer.getRegionid();
//                    user.setReferrerid(Integer.valueOf(referrerid));
//                    user.setRegionid(regionid);
//                }
//
//                user.setUsername("jr" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
//                user.setPassword(SecurityUtil.encrypt(password, SecurityUtil.AlgorithmType.SHA512));
//                user.setTelephone(telephone);
//                user.setWechatid(request.getParameter("wechatid"));
//
//                //获取微信头像
//                HttpEntity httpEntity = HttpUtil.doGetMore(request.getParameter("headicon"));
//                inputStream = httpEntity.getContent();
//
//                LocalDateTime localDateTime = LocalDateTime.now();
//                DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
//                String saveFileName = LocalDateTime.now().format(dateTimeFormatter) + SystemUtil.getRandomString(12) + ".jpg";
//                String saveDir = request.getServletContext().getRealPath("/resources/uploads/") + "/" + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue();
//                File dir = new File(saveDir);
//                if (!dir.exists()) {
//                    if (!dir.mkdirs()) {
//                        return "";
//                    }
//                }
//
//                String saveAbsolutePath = saveDir + File.separator + saveFileName;
//                String saveRelativePath = "/resources/uploads/" + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue() + "/" + saveFileName;
//                File saveFile = new File(saveAbsolutePath);
//                fileOutputStream = new FileOutputStream(saveFile);
//                int length;
//                byte[] buffer = new byte[1024];
//                while ((length = inputStream.read(buffer)) != -1) {
//                    fileOutputStream.write(buffer, 0, length);
//                }
//
//                fileOutputStream.flush();
//
//                user.setRoleid(5);
//                user.setBalance(BigDecimal.valueOf(0));
//                user.setPoint(0);
//                user.setHeadicon(saveRelativePath);
//                user.setIsdisabled(false);
//                user.setRegistertime(String.valueOf(LocalDateTime.now()));
//
//                userService.add(user);
//            } else {
//                LocalDateTime localDateTime1 = LocalDateTime.parse(validateCode.getSmssendtime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S"));
//                LocalDateTime localDateTime2 = LocalDateTime.now();
//                long mintue = DateTimeUtil.getTimeBetween(localDateTime1, localDateTime2, ChronoUnit.MINUTES);
//
//                if (mintue > validateCode.getSmsperiodtime()) {
//                    resultModel.setSuccess(false);
//                    resultModel.setData("验证码失效，请重新获取！");
//                    return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//                }
//
//
//                if (!StringUtils.isEmpty(referrerid)) {
//                    User userReferrer = userService.getById(User.class, Integer.parseInt(referrerid));
//                    int regionid = userReferrer.getRegionid();
//                    user.setReferrerid(Integer.valueOf(referrerid));
//                    user.setRegionid(regionid);
//                }
//
//                user.setUsername("jr" + LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss")));
//                user.setPassword(SecurityUtil.encrypt(password, SecurityUtil.AlgorithmType.SHA512));
//                user.setTelephone(telephone);
//                user.setWechatid(request.getParameter("wechatid"));
//
//                //获取微信头像
//                HttpEntity httpEntity = HttpUtil.doGetMore(request.getParameter("headicon"));
//                inputStream = httpEntity.getContent();
//
//                LocalDateTime localDateTime = LocalDateTime.now();
//                DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
//                String saveFileName = LocalDateTime.now().format(dateTimeFormatter) + SystemUtil.getRandomString(12) + ".jpg";
//                String saveDir = request.getServletContext().getRealPath("/resources/uploads/") + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue();
//                File dir = new File(saveDir);
//                if (!dir.exists()) {
//                    if (!dir.mkdirs()) {
//                        return "";
//                    }
//                }
//
//                String saveAbsolutePath = saveDir + File.separator + saveFileName;
//                String saveRelativePath = "/resources/uploads/" + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue() + "/" + saveFileName;
//                File saveFile = new File(saveAbsolutePath);
//                fileOutputStream = new FileOutputStream(saveFile);
//                int length;
//                byte[] buffer = new byte[1024];
//                while ((length = inputStream.read(buffer)) != -1) {
//                    fileOutputStream.write(buffer, 0, length);
//                }
//
//                fileOutputStream.flush();
//
//                if (user.getRoleid() == null || user.getRoleid() > 4) {
//                    user.setRoleid(5);
//                }
//
//                user.setHeadicon(saveRelativePath);
//                user.setIsdisabled(false);
//                user.setRegistertime(String.valueOf(LocalDateTime.now()));
//
//                userService.edit(user);
//            }
//
//            resultModel.setSuccess(true);
//            resultModel.setData(String.valueOf(user.getId()));
//
//            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//        } catch (Exception e) {
//            resultModel.setSuccess(false);
//            resultModel.setData("注册失败！");
//
//            try {
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            } catch (JsonProcessingException ex) {
//                LogManager.getLogger().error(e.toString());
//            }
//        } finally {
//            if (fileOutputStream != null) {
//                try {
//                    fileOutputStream.close();
//                } catch (IOException e) {
//                    LogManager.getLogger().error(e.toString());
//                }
//            }
//
//            if (inputStream != null) {
//                try {
//                    inputStream.close();
//                } catch (IOException e) {
//                    LogManager.getLogger().error(e.toString());
//                }
//            }
//        }
//
//        return null;
//    }

//    @RequestMapping(value = "/AddServiceUser")
//    @ResponseBody
//    public String addServiceUser(HttpServletRequest request, HttpServletResponse response) {
//        ResultModel<String> resultModel = new ResultModel<>();
//        try {
//            User user = new User();
//
//            String name = request.getParameter("realname");
//            String password = request.getParameter("password");
//            String telephone = request.getParameter("telephone");
//            String referrerid = request.getParameter("referrerid");
//
//            User userphone = userService.getByTelephone(telephone);
//            if (userphone != null) {
//                resultModel.setSuccess(false);
//                resultModel.setData("手机号已被注册！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//            if (referrerid != null && referrerid.length() > 0) {
//                user.setReferrerid(Integer.valueOf(referrerid));
//            }
//
//            user.setRealname(name);
//            user.setPassword(SecurityUtil.encrypt(password, SecurityUtil.AlgorithmType.SHA512));
//            user.setTelephone(telephone);
//            user.setReferrerid(Integer.valueOf(referrerid));
//            user.setRegistertime(String.valueOf(LocalDateTime.now()));
//            userService.add(user);
//
//            ServiceProvider serviceProvider = new ServiceProvider();
//            String name1 = request.getParameter("name");
//            String content = request.getParameter("content");
//            String address = request.getParameter("address");
//            String telephone1 = request.getParameter("telephone1");
//
//            serviceProvider.setName(name1);
//            serviceProvider.setOwnerid(user.getId());
//            serviceProvider.setContent(content);
//            serviceProvider.setAddress(address);
//            serviceProvider.setTelephone(telephone1);
//            serviceProvider.setCreatetime(String.valueOf(LocalDateTime.now()));
//            serviceProviderService.addServiceProvider(serviceProvider);
//
//            resultModel.setSuccess(true);
//            resultModel.setData("注册成功！");
//
//            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//        } catch (Exception e) {
//            resultModel.setSuccess(false);
//            resultModel.setData("注册失败！");
//            try {
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            } catch (JsonProcessingException ex) {
//                ex.printStackTrace();
//            }
//        }
//        return null;
//    }

//    @RequestMapping(value = "/Search")
//    @ResponseBody
//    public String Search(HttpServletRequest request) {
//        ResultModels<String> resultModels = new ResultModels<>();
//        try {
//            String telephone = request.getParameter("telephone");
//            Integer userid = Integer.parseInt(request.getParameter("userid"));
//            if (StringUtils.isEmpty(telephone)) {
//                resultModels.setSuccess(false);
//                resultModels.setData("手机号不能为空！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//            }
//
//            String regex = "^[1][\\d]{10}$";
//            Pattern pattern = Pattern.compile(regex);
//            if (!pattern.matcher(telephone).matches()) {
//                resultModels.setSuccess(false);
//                resultModels.setData("手机号格式不正确！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//            }
//            User user = userService.getByTelephone(telephone);
//            User u = userService.getById(User.class, userid);
//            if (user != null) {
//                if (user.getRegionid() == null){
//                    resultModels.setSuccess(false);
//                    resultModels.setData("请扫其他用户二维码，设置推荐人！");
//                    return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//                }
//                if (!user.getRegionid().equals(u.getRegionid())) {
//                    resultModels.setSuccess(false);
//                    resultModels.setData("该用户和您不在同一区域，不能进行此操作！");
//                    return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//                } else {
//                    if (user.getRoleid() <= 3) {
//                        resultModels.setSuccess(false);
//                        resultModels.setData("只可以给会员或游客开通服务商！");
//                        return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//                    } else {
//                        resultModels.setSuccess(true);
//                        resultModels.setData("该用户可以开通为服务商！");
//                        resultModels.setId(String.valueOf(user.getId()));
//                        return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//                    }
//                }
//            } else {
//                resultModels.setSuccess(true);
//                resultModels.setData("该用户可以开通为服务商！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModels);
//            }
//        } catch (JsonProcessingException e) {
//            e.printStackTrace();
//        }
//        return "";
//    }

//    @RequestMapping(value = "/SendSMS")
//    @ResponseBody
//    public String SendSms(HttpServletRequest request) {
//        ResultModel<String> resultModel = new ResultModel<>();
//        try {
//            String telephone = request.getParameter("telephone");
//            int validateCode = 6;
//            String minute = "10";
//            String code = SystemUtil.getRandomNumber(validateCode);
//            if (telephone == null) {
//                resultModel.setSuccess(false);
//                resultModel.setData("发送失败，请填写手机号！");
//            } else {
//                RongLianUtil.sendSMS(telephone, code, minute);
//                resultModel.setSuccess(true);
//                resultModel.setData("发送成功！");
//                ValidateCode validatecode = validateCodeService.getByTelephone(telephone);
//                ValidateCode validateCode1 = new ValidateCode();
//                if (validatecode == null) {
//
//                    validateCode1.setTelephone(telephone);
//                    validateCode1.setCode(code);
//                    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//                    validateCode1.setSmssendtime(LocalDateTime.now().format(dateTimeFormatter));
//                    validateCode1.setSmsperiodtime(Integer.valueOf(minute));
//                    validateCodeService.addValidateCode(validateCode1);
//                } else {
//                    validatecode.setCode(code);
//                    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
//                    validatecode.setSmssendtime(LocalDateTime.now().format(dateTimeFormatter));
//                    validateCodeService.editValidateCode(validatecode);
//                }
//
//            }
//            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        return "";
//    }

//    //修改密码
//    @RequestMapping(value = "/ResetPassword")
//    @ResponseBody
//    public String ResetPassword(HttpServletRequest request, HttpServletResponse response) {
//        ResultModel<String> resultModel = new ResultModel<>();
//        try {
//            String telephone = request.getParameter("telephone");
//            User user = new User();
//            if (telephone.equals("@")) {
//                user = userService.getByEmail(telephone);
//            } else {
//                user = userService.getByTelephone(telephone);
//            }
//            if (user == null) {
//                resultModel.setSuccess(false);
//                resultModel.setData("手机号或邮箱有误！");
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            }
//
//            user.setPassword(SecurityUtil.encrypt(request.getParameter("password"), SecurityUtil.AlgorithmType.SHA512));
//            userService.edit(user);
//            resultModel.setSuccess(true);
//            resultModel.setData("重置密码成功！");
//            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//        } catch (Exception e) {
//            resultModel.setSuccess(false);
//            resultModel.setData("重置密码失败！");
//            try {
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            } catch (JsonProcessingException ex) {
//                ex.printStackTrace();
//            }
//        }
//
//        return "";
//    }


    @RequestMapping(value = "/GetUser")
    @ResponseBody
    public String GetUser(HttpServletRequest request) {
        int userid = Integer.parseInt(request.getParameter("userid"));
        User u = userService.getById(User.class, userid);
        try {
            return SystemUtil.getObjectMapper().writeValueAsString(u);
        } catch (JsonProcessingException e) {
            return e.getMessage();
        }
    }

//    //添加用户
//    @RequestMapping(value = "/Add")
//    @ResponseBody
//    public String Add(HttpServletRequest request, @RequestParam String telephone, @RequestParam String idcardnumber) {
//        ResultModel<String> resultModel = new ResultModel<>();
//
//        try {
//            List<String> listSearch = new ArrayList<>();
//
//            String username = request.getParameter("username");
//            String password = request.getParameter("password");
//            String role = request.getParameter("role");
//            String realname = request.getParameter("realname");
//            telephone = request.getParameter("telephone");
//            String sex = request.getParameter("sex");
//            String birthday = request.getParameter("birthday");
//            idcardnumber = request.getParameter("idcardnumber");
//            String drivinglicensetype = request.getParameter("drivinglicensetype");
//            String drivinglicensenumber = request.getParameter("drivinglicensenumber");
//            String email = request.getParameter("email");
//            String region = request.getParameter("region");
//            String address = request.getParameter("address");
//            String referrer = request.getParameter("referrer");
//            String point = request.getParameter("point");
//            String balance = request.getParameter("balance");
//            String isdisabled = request.getParameter("isdisabled");
//            String remark = request.getParameter("remark");
//
//            listSearch.add(username);
//            listSearch.add(realname);
//            listSearch.add(telephone);
//
//            String fuzzysearch = StringUtils.join(listSearch, ",");
//
//            User user = new User();
//
//            MultipartHttpServletRequest fileRequest = (MultipartHttpServletRequest) request;//request强制转换注意
//            MultipartFile file = fileRequest.getFile("headicon");
//
//            if (file != null && !file.isEmpty()) {
//                String fileName = file.getOriginalFilename();
//                String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
//
//                if (!fileExtension.equals(".bmp") && !fileExtension.equals(".png") && !fileExtension.equals(".jpeg") && !fileExtension.equals(".gif") && !fileExtension.equals(".jpg")) {
//                    resultModel.setSuccess(false);
//                    resultModel.setData("图片格式不正确！");
//                    return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//                }
//
//                LocalDateTime localDateTime = LocalDateTime.now();
//                DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
//                String saveFileName = LocalDateTime.now().format(dateTimeFormatter) + fileExtension;
//                String saveDir = request.getServletContext().getRealPath("/resources/uploads/") + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue();
//                File dir = new File(saveDir);
//                if (!dir.exists()) {
//                    if (!dir.mkdirs()) {
//                        resultModel.setSuccess(false);
//                        resultModel.setData("上传文件失败！");
//                        return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//                    }
//                }
//                String saveAbsolutePath = saveDir + File.separator + saveFileName;
//                String saveRelativePath = "/resources/uploads/" + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue() + "/" + saveFileName;
//                File saveFile = new File(saveAbsolutePath);
//                file.transferTo(saveFile);
//                user.setHeadicon(saveRelativePath);
//            }
//
//            user.setUsername(username);
//            user.setPassword(SecurityUtil.encrypt(password, SecurityUtil.AlgorithmType.SHA512));
//            user.setRoleid(Integer.valueOf(role));
//            user.setRealname(realname);
//            user.setTelephone(telephone);
//            user.setSex(Integer.valueOf(sex));
//
//            if (!StringUtils.isEmpty(birthday)) {
//                user.setBirthday(birthday);
//            }
//
//            user.setIdcardnumber(idcardnumber);
//            user.setDrivinglicensetype(drivinglicensetype);
//            user.setDrivinglicensenumber(drivinglicensenumber);
//            user.setEmail(email);
//            user.setRegionid(Integer.valueOf(region));
//            user.setAddress(address);
//            user.setReferrerid(Integer.valueOf(referrer));
//
//            if (StringUtils.isEmpty(point)) {
//                user.setPoint(0);
//            } else {
//                user.setPoint(Integer.valueOf(point));
//            }
//
//            if (StringUtils.isEmpty(balance)) {
//                user.setBalance(new BigDecimal(0));
//            } else {
//                user.setBalance(new BigDecimal(balance));
//            }
//
//            user.setIsdisabled(Boolean.valueOf(isdisabled));
//            user.setRemark(remark);
//            user.setRegistertime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
//            user.setFuzzysearch(fuzzysearch);
//            //执行添加方法
//            userService.add(user);
//
//            resultModel.setSuccess(true);
//            resultModel.setData("添加成功！");
//            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//        } catch (Exception e) {
//            resultModel.setSuccess(false);
//            resultModel.setData("添加失败！");
//            try {
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            } catch (JsonProcessingException ex) {
//                ex.printStackTrace();
//            }
//        }
//
//        return "";
//    }

//    //修改用户
//    @RequestMapping(value = "/Edit")
//    @ResponseBody
//    public String Edit(HttpServletRequest request) {
//        ResultModel<String> resultModel = new ResultModel<>();
//
//        try {
//            String id = request.getParameter("id");
//            String username = request.getParameter("username");
//            String password = request.getParameter("password");
//            String password1 = request.getParameter("password1");
//            String role = request.getParameter("role");
//            String realname = request.getParameter("realname");
//            String telephone = request.getParameter("telephone");
//            String sex = request.getParameter("sex");
//            String birthday = request.getParameter("birthday");
//            String idcardnumber = request.getParameter("idcardnumber");
//            String drivinglicensetype = request.getParameter("drivinglicensetype");
//            String drivinglicensenumber = request.getParameter("drivinglicensenumber");
//            String email = request.getParameter("email");
//            String region = request.getParameter("region");
//            String address = request.getParameter("address");
//            String referrer = request.getParameter("referrer");
//            String point = request.getParameter("point");
//            String balance = request.getParameter("balance");
//            String isdisabled = request.getParameter("isdisabled");
//            String remark = request.getParameter("remark");
//
//
//
//            User user = userService.getById(User.class,Integer.valueOf(id));
//            MultipartHttpServletRequest fileRequest = (MultipartHttpServletRequest) request;//request强制转换注意
//            MultipartFile file = fileRequest.getFile("headicon");
//
//            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
//
//            if (file != null && !file.isEmpty()) {
//                String fileName = file.getOriginalFilename();
//                String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
//
//                if (!fileExtension.equals(".bmp") && !fileExtension.equals(".png") && !fileExtension.equals(".jpeg") && !fileExtension.equals(".gif") && !fileExtension.equals(".jpg")) {
//                    resultModel.setSuccess(false);
//                    resultModel.setData("图片格式不正确！");
//                    return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//                }
//
//                LocalDateTime localDateTime = LocalDateTime.now();
//
//                String saveFileName = LocalDateTime.now().format(dateTimeFormatter) + SystemUtil.getRandomString(6) + fileExtension;
//                String saveDir = request.getServletContext().getRealPath("/resources/uploads/" + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue());
//                File dir = new File(saveDir);
//                if (!dir.exists()) {
//                    if (!dir.mkdirs()) {
//                        resultModel.setSuccess(false);
//                        resultModel.setData("上传文件失败！");
//                        return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//                    }
//                }
//
//                String saveAbsolutePath = saveDir + File.separator + saveFileName;
//                String saveRelativePath = "/resources/uploads/" + localDateTime.getYear() + "/" + localDateTime.getMonth().getValue() + "/" + saveFileName;
//                File saveFile = new File(saveAbsolutePath);
//                file.transferTo(saveFile);
//                user.setHeadicon(saveRelativePath);
//            }
//
//            user.setUsername(username);
//            if(!StringUtils.isEmpty(password)){
//                user.setPassword(SecurityUtil.encrypt(password, SecurityUtil.AlgorithmType.SHA512));
//            }
//
//            int roleid = Integer.valueOf(role);
//            if (roleid == 3 || roleid == 4) {
//                String negotiationurl = "https://www.ruibu.info/Home/Index?referrerid=" + Integer.valueOf(id);
//                negotiationurl = WeChatUtil.getRedirectUrl(negotiationurl, WeChatUtil.GrantType.USERINFO);
//                dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS");
//                String imagename = dateTimeFormatter.format(LocalDateTime.now()) + SystemUtil.getRandomString(6) + ".jpg";
//                String qrcodeimageurl = "/home/ubuntu/jettybase/webapps/JinRun/resources/uploads/" + imagename;
//                SystemUtil.createQrCode(200, 200, negotiationurl, qrcodeimageurl, "jpg");
//                String url = request.getContextPath() + "/resources/uploads/" + imagename;
//                user.setQrcode(url);
//            }
//            user.setRoleid(Integer.valueOf(role));
//            user.setRealname(realname);
//            user.setTelephone(telephone);
//            user.setSex(Integer.valueOf(sex));
//            user.setBirthday(birthday);
//            user.setIdcardnumber(idcardnumber);
//            user.setDrivinglicensetype(drivinglicensetype);
//            user.setDrivinglicensenumber(drivinglicensenumber);
//            user.setEmail(email);
//            user.setRegionid(Integer.valueOf(region));
//            user.setAddress(address);
//            user.setReferrerid(Integer.valueOf(referrer));
//            user.setIsdisabled(Boolean.valueOf(isdisabled));
//
//            if (StringUtils.isEmpty(point)) {
//                user.setPoint(0);
//            } else {
//                user.setPoint(Integer.valueOf(point));
//            }
//
//            if (StringUtils.isEmpty(balance)) {
//                user.setBalance(new BigDecimal(0));
//            } else {
//                user.setBalance(new BigDecimal(balance));
//            }
//
//            user.setRemark(remark);
//            user.setRegistertime(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
//            //执行修改方法
//            userService.edit(user);
//
//            resultModel.setSuccess(true);
//            resultModel.setData("修改成功！");
//            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//        } catch (Exception e) {
//            resultModel.setSuccess(false);
//            resultModel.setData("修改失败！");
//            try {
//                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
//            } catch (JsonProcessingException ex) {
//                ex.printStackTrace();
//
//            }
//        }
//
//        return "";
//    }

    //删除用户
    @RequestMapping(value = "/Delete")
    @ResponseBody
    public String delete(@RequestParam int id) {
        ResultModel<String> resultModel = new ResultModel<>();
        try {
            User user = userService.getById(User.class, id);
            userService.delete(user);
            resultModel.setSuccess(true);
            resultModel.setData("删除成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            resultModel.setSuccess(false);
            resultModel.setData("删除失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }

        return "";
    }

    @RequestMapping(value = "/Test")
    @ResponseBody
    public String Test(HttpServletRequest request, @RequestParam("file") CommonsMultipartFile[] files) {
        ResultModel<String> resultModel = new ResultModel<>();
        try {
            for (MultipartFile file : files) {
                System.out.println(file.getName());
            }

            String UserName = request.getParameter("UserName");
            String Password = request.getParameter("Password");
            System.out.println(UserName + " --- " + Password);

            resultModel.setSuccess(true);
            resultModel.setData("测试成功！");
            return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
        } catch (Exception e) {
            resultModel.setSuccess(false);
            resultModel.setData("测试失败！");
            try {
                return SystemUtil.getObjectMapper().writeValueAsString(resultModel);
            } catch (JsonProcessingException ex) {
                ex.printStackTrace();
            }
        }

        return "";
    }

}