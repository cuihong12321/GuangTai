package com.guangtai.controller;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;
import io.ruibu.model.wechat.CommonMessage;
import io.ruibu.model.wechat.CommonTextMessage;
import io.ruibu.model.wechat.EventSubscribeMessage;
import io.ruibu.util.DateTimeUtil;
import io.ruibu.util.SystemUtil;
import io.ruibu.util.WeChatUtil;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.Date;

/**
 * Created by Ruibu002 on 2017/3/8.
 * WeChatController
 */
@Controller
@RequestMapping(value = "/WeChat")
public class WeChatController {
    @RequestMapping(value = "/")
    public String Login() {
        return "/Login";
    }


    @RequestMapping(value = "/Reply")
    @ResponseBody
    public void Reply(HttpServletRequest request, HttpServletResponse response) {
        try {
            String signature = request.getParameter("signature");
            String timestamp = request.getParameter("timestamp");
            String nonce = request.getParameter("nonce");
            String echostr = request.getParameter("echostr");
            String token = WeChatUtil.token;

            if (request.getMethod().equals("GET")) {
                String sign = WeChatUtil.getCommonSign(new String[]{token, timestamp, nonce}, WeChatUtil.AlgorithmType.SHA1);
                if (signature.equals(sign)) {
                    response.getWriter().print(echostr);
                } else {
                    response.getWriter().print("");
                }
            } else if (request.getMethod().equals("POST")) {
                String xml = SystemUtil.getServletInputStreamString(request.getInputStream());
                Document document = DocumentHelper.parseText(xml);
                Element root = document.getRootElement();
                String msgType = root.elementText("MsgType");
                XStream xStream = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));

                xml = SystemUtil.removeCDATA(xml);
                String eventType;

                //收到文本消息
                if (msgType.equals(WeChatUtil.MessageType.TEXT.getValue())) {
                    xStream.processAnnotations(CommonTextMessage.class);
                    CommonTextMessage recieveTextMessage = (CommonTextMessage) xStream.fromXML(xml);

                    xStream.omitField(CommonMessage.class, "MsgId");
                    CommonTextMessage commonTextMessage = new CommonTextMessage();
                    commonTextMessage.setFromUserName(SystemUtil.addCDATA(WeChatUtil.wechatid));
                    commonTextMessage.setToUserName(SystemUtil.addCDATA(recieveTextMessage.getFromUserName()));
                    commonTextMessage.setCreateTime(new Date().getTime() / 1000);
                    commonTextMessage.setMsgType(SystemUtil.addCDATA(WeChatUtil.MessageType.TEXT.getValue()));
                    commonTextMessage.setContent(SystemUtil.addCDATA("您好，请问有什么需要帮助的？"));

                    xml = URLDecoder.decode(xStream.toXML(commonTextMessage), "UTF-8");
                    response.getWriter().write(xml);
                } else if (msgType.equals(WeChatUtil.MessageType.IMAGE.getValue())) {
                    //收到图片消息
                } else if (msgType.equals(WeChatUtil.MessageType.LOCATION.getValue())) {
                    //收到地理位置消息

                } else if (msgType.equals(WeChatUtil.MessageType.EVENT.getValue())) {
                    eventType = root.elementText("Event");

                    //用户关注
                    if (eventType.equals(WeChatUtil.MessageEventType.SUBCRIBE.getValue())) {
                        xStream.processAnnotations(EventSubscribeMessage.class);
                        EventSubscribeMessage eventSubscribeMessage = (EventSubscribeMessage) xStream.fromXML(xml);

                        xStream = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
                        xStream.processAnnotations(CommonTextMessage.class);
                        xStream.omitField(CommonMessage.class, "MsgId");
                        CommonTextMessage commonTextMessage = new CommonTextMessage();
                        commonTextMessage.setFromUserName(SystemUtil.addCDATA(WeChatUtil.wechatid));
                        commonTextMessage.setToUserName(SystemUtil.addCDATA(eventSubscribeMessage.getFromUserName()));
                        commonTextMessage.setCreateTime(Long.valueOf(DateTimeUtil.getTimeStamp()));
                        commonTextMessage.setMsgType(SystemUtil.addCDATA(WeChatUtil.MessageType.TEXT.getValue()));
                        commonTextMessage.setContent(SystemUtil.addCDATA("您好，欢迎关注挣点油钱！"));

                        xml = URLDecoder.decode(xStream.toXML(commonTextMessage), "UTF-8");
                        response.getWriter().write(xml);
                    } else if (eventType.equals(WeChatUtil.MessageEventType.LOCATION.getValue())) {

                    } else if (eventType.equals(WeChatUtil.MessageEventType.CLICK.getValue())) {

                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
