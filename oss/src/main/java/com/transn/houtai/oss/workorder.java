package com.transn.houtai.oss;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.StringUtil;
import com.transn.houtai.util.permission.AnnotationForController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by xuxiaohe on 16/8/4.
 */


@Controller
@RequestMapping("/workorder")
@AnnotationForController( menuCode = 9999)//不需要权限验证
public class workorder extends BaseController {

    Logger logger = LoggerFactory.getLogger(workorder.class);

    /**
     * 获取订单列表
     *
     * @param request
     * @param m
     * @return
     */
    @RequestMapping(value = "/getworkorderlist")
    public String getworkorderlist(HttpServletRequest request, ModelMap m) {
        String keyword = request.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }

        String n = request.getParameter("n");
        String s = request.getParameter("s");
        if (StringUtil.isBlank(n)) {
            n = "0";
        }
        if (StringUtil.isBlank(s)) {
            s = "20";
        }
        ModelAndView modelview = new ModelAndView();
        m.put("orderlist", getAllUserSubPost(n, s, keyword));
        m.put("sourcePath", Config.YXTSERVER5);

        return "newCustomerOrder/workOrderList";
    }

    /**
     * 获取订单详情
     *
     * @param request
     * @param m
     * @return
     */
    @RequestMapping(value = "/gettransnworkinfo")
    public String gettransnworkinfo(HttpServletRequest request, ModelMap m) {
        String workorderid = request.getParameter("workorderid");
        int totalmoney=0;
        ModelAndView modelview = new ModelAndView();
        JSONObject j = gettransnworkinfo(Integer.parseInt(workorderid));
        List getmachineinfo = getmachineinfo(workorderid);
        if(getmachineinfo.size()!=0){
            for(int i=0;i<getmachineinfo.size();i++){
                Map k= (Map) getmachineinfo.get(i);
                if(!StringUtil.isBlank((String) k.get("summoney"))){
                        totalmoney+=Integer.parseInt((String) k.get("summoney"));
                }
            }
        }

        Map getfapiaoinfo = getfapiaoinfo(workorderid);
        m.put("workorderinfo", j);
        m.put("totalmachinemoney",totalmoney);
        m.put("ll", getmachineinfo);
        m.put("sourcePath", Config.YXTSERVER5);
        m.putAll(getfapiaoinfo);
        return "newCustomerOrder/workorderInfo";
    }


    /**
     * 提交设备报价
     *
     * @param request
     * @param m
     * @return
     */
    @RequestMapping(value = "/submitmachineinfo")
    public String submitmachineinfo(HttpServletRequest request, ModelMap m) {
        String workorderid = request.getParameter("workorderid");

        String[] name = request.getParameterValues("name");
        String[] price = request.getParameterValues("price");
        String[] per = request.getParameterValues("per");
        String[] number = request.getParameterValues("number");
        String[] days = request.getParameterValues("days");
        String[] summoney = request.getParameterValues("summoney");
        String[] note = request.getParameterValues("note");
        String machineinfo = "";
        int totalmoney = 0;
        if (name.length != 0) {
            for (int i = 0; i < name.length; i++) {
                machineinfo += name[i] + "," + price[i] + "," + per[i] + "," + number[i] + "," + days[i] + "," + summoney[i] + "," + note[i] + "-";
                if (!StringUtil.isBlank(summoney[i])) {
                    totalmoney += Integer.parseInt(summoney[i]);
                }
            }
        }
        machineinfo = machineinfo.substring(0, machineinfo.length() - 1);


        ModelAndView modelview = new ModelAndView();
        Map getfapiaoinfo = getfapiaoinfo(workorderid);
        updatedeviceinfo(Integer.parseInt(workorderid), machineinfo, totalmoney);
        List getmachineinfo = getmachineinfo(workorderid);
        m.put("ll", getmachineinfo);
        m.put("totalmachinemoney",totalmoney);
        m.put("workorderinfo", gettransnworkinfo(Integer.parseInt(workorderid)));
        m.put("sourcePath", Config.YXTSERVER5);
        m.putAll(getfapiaoinfo);
        return "newCustomerOrder/workorderInfo";
    }


    /**
     * 分页获得系统的所有账户 支持搜索功能 字段： 用户名 手机号 邮箱 支持排序 （按时间倒序，正序,其他字段）
     *
     */
    @RequestMapping("/userList")
    private ModelAndView userList(HttpServletRequest request) {
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        String keyword = null;

        keyword = request.getParameter("keyword");
        String transnworkid = request.getParameter("transnworkid");
        String workorderid = request.getParameter("workorderid");

        String optype = request.getParameter("optype");

        if (keyword == null) {
            keyword = "";
        }
        if (optype == null) {
            optype = "";
        }
        if(keyword!=null){
            keyword=keyword.trim();
        }

        String registType = request.getParameter("registType");

        if (registType == null) {
            registType = "";
        }

        // 当前第几页
        String pagenumber = request.getParameter("n");

        if (pagenumber == null) {
            pagenumber = "0";
        }

        // 每页条数

        String pagelines = request.getParameter("s");

        if (pagelines == null) {
            pagelines = "200";
        }

        ModelAndView modelview = new ModelAndView();

        // getUserList(keyword, pagenumber, pagelines);

        JSONObject objj = getUserList(keyword, optype, pagenumber, pagelines);
        modelview.addObject("resuserList", objj);
        // logger.info(request.getSession().getAttribute("name")+"刷新用户列表操作的用户"+request.getSession().getAttribute("name"));
//		String s = objj.getString("msg");
//		System.out.println(s);

        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        modelview.addObject("keyword", keyword);
        modelview.addObject("registType", optype);
        modelview.addObject("transnworkid", transnworkid);
        modelview.addObject("workorderid", workorderid);
        modelview.setViewName("newCustomerOrder/workorderInfo");
        return modelview;
    }


    /**
     * 提交译员加入会议
     *
     * @param request
     * @param m
     * @return
     */
    @RequestMapping(value = "/submituserin")
    public String submituserin(HttpServletRequest request, ModelMap m) {
        String money = request.getParameter("money");
//        String userid = request.getParameter("userid");
        String phonenumber = request.getParameter("phonenumber");
        String userinfo = request.getParameter("userinfo");
        String transnworkid = request.getParameter("transnworkid");
        String workorderid = request.getParameter("workorderid");


        sumbituser(money,Integer.parseInt("0"),Integer.parseInt(transnworkid),Integer.parseInt(workorderid),phonenumber);

        int totalmoney=0;
        ModelAndView modelview = new ModelAndView();
        JSONObject j = gettransnworkinfo(Integer.parseInt(workorderid));
        List getmachineinfo = getmachineinfo(workorderid);
        if(getmachineinfo.size()!=0){
            for(int i=0;i<getmachineinfo.size();i++){
                Map k= (Map) getmachineinfo.get(i);
                if(!StringUtil.isBlank((String) k.get("summoney"))){
                    totalmoney+=Integer.parseInt((String) k.get("summoney"));
                }
            }
        }

        Map getfapiaoinfo = getfapiaoinfo(workorderid);
        m.put("workorderinfo", j);
        m.put("totalmachinemoney",totalmoney);
        m.put("ll", getmachineinfo);
        m.put("sourcePath", Config.YXTSERVER5);
        m.putAll(getfapiaoinfo);
        return "newCustomerOrder/workorderInfo";
    }



    /**
     * 确认订单
     *
     * @param request
     * @param m
     * @return
     */
    @RequestMapping(value = "/comfirmorder")
    public String comfirmorder(HttpServletRequest request, ModelMap m) {
        String workorderid = request.getParameter("workorderid");
        confirmorder(Integer.parseInt(workorderid));

        int totalmoney=0;
        ModelAndView modelview = new ModelAndView();
        JSONObject j = gettransnworkinfo(Integer.parseInt(workorderid));
        List getmachineinfo = getmachineinfo(workorderid);
        if(getmachineinfo.size()!=0){
            for(int i=0;i<getmachineinfo.size();i++){
                Map k= (Map) getmachineinfo.get(i);
                if(!StringUtil.isBlank((String) k.get("summoney"))){
                    totalmoney+=Integer.parseInt((String) k.get("summoney"));
                }
            }
        }

        Map getfapiaoinfo = getfapiaoinfo(workorderid);
        m.put("workorderinfo", j);
        m.put("totalmachinemoney",totalmoney);
        m.put("ll", getmachineinfo);
        m.put("sourcePath", Config.YXTSERVER5);
        m.putAll(getfapiaoinfo);
        return "newCustomerOrder/workorderInfo";
    }






    private JSONObject getAllUserSubPost(String n, String s, String key) {
        String url = Config.YXTSERVER3 + "ossCustomer/ossgetworkorderlist?n=" + n + "&s=" + s + "&keyword=" + key;
        return getRestApiData(url);
    }

    private JSONObject gettransnworkinfo(int workorderid) {
        String url = Config.YXTSERVER3 + "ossCustomer/getWorkOrderInfo?workorderid=" + workorderid;
        return getRestApiData(url);
    }

    private JSONObject updatedeviceinfo(int workorderid, String machineinfo, int money) {
        String url = Config.YXTSERVER3 + "ossCustomer/updatedeviceinfo?orderid=" + workorderid + "&deviceinfo=" + machineinfo + "&machinemoney=" + money;
        return getRestApiData(url);
    }

    private JSONObject getfapiaoaddress(int customerid) {
        String url = Config.YXTSERVER7 + "address/ossfindAddress?customerid=" + customerid;
        return getRestApiData(url);
    }

    private JSONObject getUserList(String keyword, String registType, String n, String s) {
        String url = Config.YXTSERVER3 + "ossuser/getossuserlist?n="+n+"&s="+s+"&keyword="+keyword+"&registType="+registType;
        return getRestApiData(url);
    }

    private JSONObject sumbituser(String money, int userid, int transnworkid, int workorderid,String phonenumber) {
        String url = Config.YXTSERVER3 + "ossCustomer/autoselectuser?money="+money+"&userid="+userid+"&transnworkid="+transnworkid+"&workorderid="+workorderid+"&phonenumber="+phonenumber;
        return getRestApiData(url);
    }


    private JSONObject confirmorder(int orderid) {
        String url = Config.YXTSERVER3 + "ossCustomer/confirmorder?orderid="+orderid;
        return getRestApiData(url);
    }



    public List getmachineinfo(String workorderid) {
        String backcontent = "";
        JSONObject j = gettransnworkinfo(Integer.parseInt(workorderid));
        JSONObject jj = (JSONObject) j.get("data");
        JSONObject jjj = (JSONObject) jj.get("result");
        if (!jjj.isEmpty()) {
            backcontent = jjj.getString("backcontent");
        }
        List ll = new ArrayList();
        String[] a = backcontent.split("-");
        if (a.length != 0) {
            for (String k : a) {
                String[] b = k.split(",");
                if (b.length != 0) {
                    Map m1 = new HashMap();
                    for (int t = 0; t < b.length; t++) {
                        if("null".equals(b[t])){
                            b[t]="";
                        }
                        switch (t) {
                            case 0: {
                                m1.put("name", b[t]);
                                break;
                            }
                            case 1: {
                                m1.put("price", b[t]);
                                break;
                            }
                            case 2: {
                                m1.put("per", b[t]);
                                break;
                            }
                            case 3: {
                                m1.put("number", b[t]);
                                break;
                            }
                            case 4: {
                                m1.put("days", b[t]);
                                break;
                            }
                            case 5: {
                                m1.put("summoney", b[t]);
                                break;
                            }
                            case 6: {
                                m1.put("note", b[t]);
                                break;
                            }

                        }
                    }

                    ll.add(m1);

                }

            }

        }
        return ll;
    }



    public Map getfapiaoinfo(String workorderid) {
        Map m=new HashMap();
        JSONObject fapiao = null;
        JSONObject address=null;
        JSONObject j = gettransnworkinfo(Integer.parseInt(workorderid));
        JSONObject jj = (JSONObject) j.get("data");
        JSONObject jjj = (JSONObject) jj.get("result");

        if(!"null".equals(jjj.get("fapiao").toString())&&!"".equals(jjj.get("fapiao").toString())){
//            if (!jjj.isEmpty()&&jjj.get("fapiao")!=null&&jjj.has("fapiao")) {
                fapiao =  (JSONObject)jjj.get("fapiao");
//             parse = (CustomerBill) JSON.parse(fapiao);
//                if(fapiao!=null){
//                    int i=fapiao.getInt("customerId");
//                    address= getfapiaoaddress(i);
//                }
//            }
        }

        m.put("fapiao",fapiao);
//        m.put("address",address);
        return m;
    }



}
