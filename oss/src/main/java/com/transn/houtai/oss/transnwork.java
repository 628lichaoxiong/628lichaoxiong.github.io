package com.transn.houtai.oss;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.PoiService;
import com.transn.houtai.util.Saveimage;
import com.transn.houtai.util.StringUtil;
import com.transn.houtai.util.poiservice2;
import com.transn.houtai.util.permission.AnnotationForController;

@Controller
@RequestMapping("/transnwork")
@AnnotationForController( menuCode = 9999)
public class transnwork extends BaseController {
    Logger logger = LoggerFactory.getLogger(transnwork.class);
    @Resource(name = "poiService")
    public PoiService service;

    @Autowired
    Saveimage saveimage;

    @Autowired
    private poiservice2 service2;

    public transnwork() {

    }

    /**
     * 传神任务列表
     */
    @RequestMapping("/transnworklist")
    private ModelAndView userList(HttpServletRequest request) {
        try {
            request.setCharacterEncoding("utf-8");
        } catch (UnsupportedEncodingException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        String keyword = null;
        String name = (String) request.getSession().getAttribute("name");
        keyword = request.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }
        // 当前第几页
        String pagenumber = request.getParameter("n");

        if (pagenumber == null) {
            pagenumber = "1";
        }
        // 每页条数
        String pagelines = request.getParameter("s");
        if (pagelines == null) {
            pagelines = "20";
        }
        ModelAndView modelview = new ModelAndView();
        // getUserList(keyword, pagenumber, pagelines);
        JSONObject objj = getTransnworkList(keyword, pagenumber, pagelines, name);
        modelview.addObject("transnworklist", objj);
        // logger.info(request.getSession().getAttribute("name")+"刷新用户列表操作的用户"+request.getSession().getAttribute("name"));
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName()
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        modelview.setViewName("newtransnwork/transnworkList");
        return modelview;
    }

    /**
     * 创建传神任务
     *
     * @param request
     * @return
     */
    @RequestMapping("/addtransnwork")
    public String addtransnwork(HttpServletRequest request) {

        String id = request.getParameter("id");
        String meetingname = request.getParameter("meetingname");
        String workinfo = request.getParameter("workinfo");
        String info = request.getParameter("workinfo");
        String category = request.getParameter("category");
        String language1 = request.getParameter("language1");
        String language2 = request.getParameter("language2");
        String meetingtime1 = request.getParameter("meetingtime1");
        String meetingtime2 = request.getParameter("meetingtime2");
        String city = request.getParameter("city");
        String longtime1 = request.getParameter("longtime1");
        if (StringUtil.isBlank(longtime1)) {
            longtime1 = "0";
        }
        int f1 = Integer.parseInt(longtime1);

        String longtime2 = request.getParameter("longtime2");
        if (StringUtil.isBlank(longtime2)) {
            longtime2 = "0";
        }
        int f2 = Integer.parseInt(longtime2);

        String meetingfrom = request.getParameter("meetingfrom");
        String type = request.getParameter("type");
        String selecttype = request.getParameter("selecttype");
        String userphonenumber = request.getParameter("userphonenumber");
        String address = request.getParameter("address");
        String meetinguser = request.getParameter("meetinguser");
        String isusergetin = request.getParameter("isusergetin");
        String userid = (String) request.getSession().getAttribute("name");
        String transnrichenglist = request.getParameter("liuchenglist");


        String timeout = request.getParameter("timeout");


        if (StringUtil.isBlank(timeout)) {
            timeout = "";
        }
//		transnrichenglist=transnrichenglist.replaceAll("\r\n", "");
//		transnrichenglist=transnrichenglist.replaceAll("，", ",");
        if (StringUtil.isBlank(id)) {
            id = "0";
        }
        if (!StringUtil.isBlank(selecttype)) {
            type = selecttype;
        }

        ModelAndView modelview = new ModelAndView();
        Map m = new HashMap();
        m.put("id", id);
        m.put("meetingname", meetingname);
        m.put("workinfo", workinfo);
        m.put("info", info);
        m.put("category", category);
        m.put("language", language1 + "-" + language2);
        m.put("meetingtime", meetingtime1 + "~" + meetingtime2);
        m.put("meetingfrom", "传神");
        m.put("type", type);
        m.put("userphonenumber", userphonenumber);
        m.put("address", address);
        m.put("isusergetin", isusergetin);
        m.put("userid", userid);
        m.put("city", city);
        m.put("meetinguser", meetinguser);
        m.put("days", f1);
        m.put("halfdays", f2);
        m.put("longtime",(f1+f2)+"天");
        m.put("timeout", timeout);
        m.put("transnrichenglist", transnrichenglist);
        m.put("logoimage", "http://7xr70a.com2.z0.glb.qiniucdn.com/transnworktransnlogo.png");
        m.put("bgimage", "http://7xr70a.com2.z0.glb.qiniucdn.com/transnworkfind_bg%402x.png");
        m.put("istransn", 1);
        addtransnwork(m);
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        return "redirect:/transnwork/transnworklist";
    }


    /**
     * 创建传神任务
     *
     * @param request
     * @return
     */
    @RequestMapping("/updatetransnwork")
    public String updatetransnwork(HttpServletRequest request) {

        String id = request.getParameter("id");
        String meetingname = request.getParameter("meetingname");
        String workinfo = request.getParameter("info");
        String info = request.getParameter("info");
        String category = request.getParameter("category");
        String language = request.getParameter("language");
        String meetingtime = request.getParameter("meetingtime");
        String city = request.getParameter("city");
        String longtime = request.getParameter("longtime");

        String meetingfrom = request.getParameter("meetingfrom");
        String type = request.getParameter("type");
        String selecttype = request.getParameter("selecttype");
        String userphonenumber = request.getParameter("userphonenumber");
        String address = request.getParameter("address");
        String meetinguser = request.getParameter("meetinguser");
        String isusergetin = request.getParameter("isusergetin");
        String userid = (String) request.getSession().getAttribute("name");
        String transnrichenglist = request.getParameter("liuchenglist");

        String days = request.getParameter("days");
        String halfdays = request.getParameter("halfdays");


        String timeout = request.getParameter("timeout");


        if (StringUtil.isBlank(timeout)) {
            timeout = "";
        }
//		transnrichenglist=transnrichenglist.replaceAll("\r\n", "");
//		transnrichenglist=transnrichenglist.replaceAll("，", ",");
        if (StringUtil.isBlank(id)) {
            id = "0";
        }
        if (!StringUtil.isBlank(selecttype)) {
            type = selecttype;
        }

        ModelAndView modelview = new ModelAndView();
        Map m = new HashMap();
        m.put("id", id);
        m.put("meetingname", meetingname);
        m.put("workinfo", workinfo);
        m.put("info", info);
        m.put("category", category);
        m.put("language", language);
        m.put("meetingtime", meetingtime);
        m.put("meetingfrom", "传神");
        m.put("type", type);
        m.put("userphonenumber", userphonenumber);
        m.put("address", address);
        m.put("isusergetin", isusergetin);
        m.put("userid", userid);
        m.put("city", city);
        m.put("meetinguser", meetinguser);
        m.put("days", days);
        m.put("halfdays", halfdays);
        m.put("longtime", longtime + "天");
        m.put("timeout", timeout);
        m.put("transnrichenglist", transnrichenglist);
        m.put("logoimage", "http://7xr70a.com2.z0.glb.qiniucdn.com/transnworktransnlogo.png");
        m.put("bgimage", "http://7xr70a.com2.z0.glb.qiniucdn.com/transnworkfind_bg%402x.png");
        m.put("istransn", 1);
        addtransnwork(m);
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        return "redirect:/transnwork/transnworklist";
    }


    /**
     * 删除传神任务
     *
     * @param request
     * @return
     */
    @RequestMapping("/deletetransnwork")
    public String deletetransnwork(HttpServletRequest request) {
        ModelAndView modelview = new ModelAndView();
        String id = request.getParameter("id");
        deletetransnwork(id);
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        return "redirect:/transnwork/transnworklist";

    }


    /**
     * 获取传神任务详情
     *
     * @param request
     * @return
     */
    @RequestMapping("/gettransnworkinfo")
    public ModelAndView gettransnworkinfo(HttpServletRequest request) {
        ModelAndView modelview = new ModelAndView();
        String transnworkid = request.getParameter("transnworkid");
        JSONObject j = gettransnworkinfo(transnworkid);
        modelview.addObject("transnworkinfo", j);
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        modelview.setViewName("newtransnwork/transnworkinfo");
        return modelview;

    }


    /**
     * 获取传神任务详情
     *
     * @param request
     * @return
     */
    @RequestMapping("/updatetransnworkinfo")
    public ModelAndView updatetransnworkinfo(HttpServletRequest request) {
        ModelAndView modelview = new ModelAndView();
        String transnworkid = request.getParameter("transnworkid");
        JSONObject j = gettransnworkinfo(transnworkid);
        modelview.addObject("transnworkinfo", j);
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        modelview.setViewName("newtransnwork/updatetransnworkForm");
        return modelview;

    }


    @RequestMapping("/addtransnworkform")
    public ModelAndView addtransnworkform(HttpServletRequest request) {
        ModelAndView modelview = new ModelAndView();
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        List l = new ArrayList();
        modelview.setViewName("newtransnwork/createtransnworkForm");
        return modelview;
    }


    @RequestMapping("/test")
    public ModelAndView test(HttpServletRequest request) {
        ModelAndView modelview = new ModelAndView();
        String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath
                + "/";
        modelview.addObject("cbasePath", cbasePath);
        modelview.addObject("sourcePath", Config.YXTSERVER5);
        modelview.setViewName("transnwork/show");
        return modelview;
    }


    /**
     * @param name
     * @param pathrule
     * @return String
     * @throws
     * @Title: getFileName
     * @Description: 根据pathrule回去新的文件名
     */
    @RequestMapping("/getFileName")
    @ResponseBody
    public String getFileName(String name, String pathrule) {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMM");
        String time = format.format(System.currentTimeMillis());
        String ext = name.substring(name.lastIndexOf(".") + 1);
        String temp = pathrule.replace("{yyyymm}", time);
        String doc = "pdf,doc,docx,xls,xlsx,ppt,pptx";
        String img = "jpg,jpeg,gif,png";
        if (doc.indexOf(ext) != -1) {
            temp = temp.replace("video", "doc");
        } else if (img.indexOf(ext) != -1) {
            temp = temp.replace("video", "imgs");
        }
        UUID uuid = UUID.randomUUID();
        return temp + uuid.toString() + "." + ext;
    }


    private JSONObject getTransnworkList(String keyword, String n, String s, String name) {
        String url = Config.YXTSERVER3 + "osstransnwork/ossgettransnworklist?n=" + n + "&s=" + s + "&name=" + name + "&keyword=" + keyword;
        return getRestApiData(url);
    }

    private JSONObject addtransnwork(Map m) {
        String url = Config.YXTSERVER3 + "osstransnwork/ossaddTransnwork?id=" + m.get("id") + "&meetingname=" + m.get("meetingname") + "&workinfo=" + m.get("workinfo") + "&info=" + m.get("info") + "&category=" + m.get("category") + "&language=" + m.get("language") + "&meetingtime=" + m.get("meetingtime") + "&meetingfrom=" + m.get("meetingfrom") + "&type=" + m.get("type") + "&userphonenumber=" + m.get("userphonenumber") + "&address=" + m.get("address") + "&isusergetin=" + m.get("isusergetin") + "&userid=" + m.get("userid") + "&city=" + m.get("city") + "&meetinguser=" + m.get("meetinguser") + "&longtime=" + m.get("longtime") + "&timeout=" + m.get("timeout") + "&transnrichenglist=" + m.get("transnrichenglist") + "&logoimage=" + m.get("logoimage") + "&bgimage=" + m.get("bgimage")+"&istransn="+m.get("istransn")+"&days="+m.get("days")+"&halfdays="+m.get("halfdays");
        return getRestApiData(url);
    }

    private JSONObject deletetransnwork(String id) {
        String url = Config.YXTSERVER3 + "osstransnwork/ossdeleteTransnwork?transnworkid=" + id;
        return getRestApiData(url);
    }

    private JSONObject gettransnworkinfo(String id) {
        String url = Config.YXTSERVER3 + "osstransnwork/ossgetTransnworkInfo?transnworkid=" + id;
        return getRestApiData(url);
    }

}
