package com.guangtai.test;

import io.ruibu.util.SecurityUtil;

/**
 * Created by Ruibu001 on 2017/2/7.
 * Test
 */
public class Test {
    private static String unicodeToStr(String unicode) {
        /** 以 \ u 分割，因为java注释也能识别unicode，因此中间加了一个空格*/
        String[] strs = unicode.split("\\\\u");
        StringBuilder returnStr = new StringBuilder();
        // 由于unicode字符串以 \ u 开头，因此分割出的第一个字符是""。
        for (int i = 1; i < strs.length; i++) {
            returnStr.append((char) Integer.valueOf(strs[i], 16).intValue());
        }
        return returnStr.toString();
    }

    private static String strToUnicode(String str) {
        char[] chars = str.toCharArray();
        StringBuilder returnStr = new StringBuilder();
        for (char aChar : chars) {
            returnStr.append("\\u").append(Integer.toString(aChar, 16));
        }
        return returnStr.toString();
    }

    public static void main(String[] args) {
        try {
//            String url = "http://123.206.13.240/JinRun/Home/WeChatRegister";
//            url = WeChatUtil.getRedirectUrl(url, WeChatUtil.GrantType.USERINFO);

//            BigDecimal bigDecimal = new BigDecimal("99.0");
//            String result = SystemUtil.removeZero(bigDecimal.toString());
////
//            System.out.println(result);
//
//            System.exit(0);
//            String[] province = {"北京市", "天津市", "河北省", "河南省", "山西省", "山东省", "内蒙古自治区", "辽宁省", "吉林省", "黑龙江省", "上海市", "江苏省", "浙江省", "福建省", "江西省", "安徽省", "湖北省", "湖南省", "广东省", "广西壮族自治区", "海南省", "重庆市", "四川省", "贵州省", "云南省", "西藏自治区", "陕西省", "甘肃省", "青海省", "宁夏回族自治区", "新疆维吾尔自治区", "台湾省", "香港特别行政区", "澳门特别行政区"};
//            String[] city = {"北京市"};
//
//            RegionService regionService = (RegionService) SystemContext.getBean("RegionService");
//            Region region;
//            List<String> listSearch = new ArrayList<>();
//            for (int i = 0; i < province.length; i++) {
//                listSearch.clear();
//
//                region = new Region();
//                region.setName(province[i]);
//
//                listSearch.add(province[i]);
//                listSearch.add(SystemUtil.getChineseFullLetter(province[i]));
//                listSearch.add(SystemUtil.getChineseFirstLetter(province[i]));
//
//                String search = StringUtils.join(listSearch, ",");
//                region.setFuzzysearch(search);
//
//                regionService.addRegion(region);
//                for (int j = 0; j < city.length; j++) {
//                    listSearch.clear();
//
//                    region = new Region();
//                    region.setName(city[i]);
//                    Region regionProvince = regionService.getRegionByName(province[i]);
//                    region.setParentid(regionProvince.getId());
//
//                    listSearch.add(province[i]);
//                    listSearch.add(SystemUtil.getChineseFullLetter(province[i]));
//                    listSearch.add(SystemUtil.getChineseFirstLetter(province[i]));
//
//                    String searchs = StringUtils.join(listSearch, ",");
//                    region.setFuzzysearch(searchs);
//
//                    regionService.addRegion(region);
//                }
//            }

//            String url = "";
//            SystemUtil.createQrCode(400, 400, "http://localhost:8080/JinRun/UserRegister?referrerid=1", "D:\\test.png", "png");

//            String cardnumber = "6215482456811555365";
//
//            String realString = replaceString(0, cardnumber.length() - 4, cardnumber, "*");
//            System.out.println(realString.length() + " --- " + realString);
//
//            String telephonenumber = "15952187581";
//
//            String realNumber = replaceString(3, 7, telephonenumber, "*");
//            System.out.println(realNumber.length() + " --- " + realNumber);

//            String url = "http://www.sskkss.com/MaintainOrder/MaintainOrders?ticketid=3";
//            SystemUtil.createQrCode(400, 400, url, "D:\\ticket.jpg", "jpg");

            //System.out.println(ProjectUtil.getNumber());
//            String url = "http://wx.qlogo.cn/mmopen/PiajxSqBRaEKpV9mGCmia5rUqB2ZAEYwfAcaVkuicpgicIoAtysKz2mbqhQjGUe53jz7BvbibQfibJ94BXG6P2iaFjLibfbK1H5Xiboib1OfAeYKC6lFw/0";
//
//            System.exit(0);
//            String xml = "<xml><appid><![CDATA[wx3ccbf9cd24dbf1fb]]></appid>\n" +
//                    "<bank_type><![CDATA[CFT]]></bank_type>\n" +
//                    "<cash_fee><![CDATA[100]]></cash_fee>\n" +
//                    "<device_info><![CDATA[WEB]]></device_info>\n" +
//                    "<fee_type><![CDATA[CNY]]></fee_type>\n" +
//                    "<is_subscribe><![CDATA[Y]]></is_subscribe>\n" +
//                    "<mch_id><![CDATA[1333743101]]></mch_id>\n" +
//                    "<nonce_str><![CDATA[bb1vexikx64aw39ykrww10bkb9e75e5u]]></nonce_str>\n" +
//                    "<openid><![CDATA[oFaLYwYXTo58fubCFoZKCGnlHbIk]]></openid>\n" +
//                    "<out_trade_no><![CDATA[20170512103529980]]></out_trade_no>\n" +
//                    "<result_code><![CDATA[SUCCESS]]></result_code>\n" +
//                    "<return_code><![CDATA[SUCCESS]]></return_code>\n" +
//                    "<sign><![CDATA[E980DA1EBFB8ACABB97C6D563879841F]]></sign>\n" +
//                    "<time_end><![CDATA[20170511172537]]></time_end>\n" +
//                    "<total_fee>100</total_fee>\n" +
//                    "<trade_type><![CDATA[JSAPI]]></trade_type>\n" +
//                    "<transaction_id><![CDATA[4006512001201705110430189011]]></transaction_id>\n" +
//                    "</xml>";
//
//            String result = HttpUtil.doPost("http://192.168.1.123:8080/JinRun/Order/Callback", xml, ContentType.APPLICATION_XML);
//            System.out.println(result);

//            String password = "123456";
//            password = SecurityUtil.encrypt(password, SecurityUtil.AlgorithmType.SHA512);
//            System.out.println(password);

//            String url = "https://www.sskkss.com/Person/PersonDetail?userid=1";
//            url = WeChatUtil.getRedirectUrl(url, WeChatUtil.GrantType.BASE);
//
//            System.out.println(url);

//            String text = "/home/ubuntu/套餐换油统计模板.xlsx";
//            String encode = strToUnicode(text);
//
//            System.out.println(encode);

            String password = SecurityUtil.encrypt("123", SecurityUtil.AlgorithmType.SHA512);
            System.out.println(password);
            System.exit(0);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}