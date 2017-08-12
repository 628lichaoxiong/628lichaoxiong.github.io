package com.transn.houtai.oss;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.ExcelOutPOJO3;
import com.transn.houtai.util.PoiService;
import com.transn.houtai.util.Saveimage;
import com.transn.houtai.util.poiservice2;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;

@Controller
@RequestMapping("/user")
@AnnotationForController( menuCode = 9999)//不需要权限验证
public class user extends BaseController {
	Logger logger = LoggerFactory.getLogger(user.class);
	@Resource(name = "poiService")
	public PoiService service;

	@Autowired
    Saveimage saveimage;
	
	@Autowired
	private poiservice2 service2;

	public user() {

	}
	
	/**
	 * 分页获得系统的所有账户 支持搜索功能 字段： 用户名 手机号 邮箱 支持排序 （按时间倒序，正序,其他字段）
	 * 
	 */
	@RequestMapping("/getuserinfo")
	private ModelAndView getuserinfo(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String userid = null;

		userid = request.getParameter("userid");


		ModelAndView modelview = new ModelAndView();

		// getUserList(keyword, pagenumber, pagelines);

		JSONObject objj = getuserinfo(userid);
		modelview.addObject("resuserList", objj);
		
		//日历信息
		JSONObject objj1=getDate(userid);
		objj1=(JSONObject) objj1.get("data");
		JSONArray array=objj1.getJSONArray("result");
		modelview.addObject("dates", array);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("newuser/userDetail");
		return modelview;
	}
	
	
	
	/**
	 * 删除用户简历
	 * 
	 */
	@RequestMapping(value="/deleteuserjianli", method = RequestMethod.POST)
	private  String deleteuserinfo(HttpServletRequest request,String jianliid,String userid,ModelMap mm) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		/*String jianliid = null;
		jianliid = request.getParameter("jianliid");
		String userid = request.getParameter("userid");*/
		 //ModelAndView modelview = new ModelAndView();
		 //getUserList(keyword, pagenumber, pagelines);
		
		JSONObject objj = deleteuserjianli(jianliid);
		JSONObject objj2 = getuserinfo(userid);
		//modelview.addObject("resuserList", objj2);
		mm.addAttribute("resuserList", objj2);
		/*String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);*/
		//modelview.setViewName("newuser/jianli");
		return "newuser/importResume";
	}
	
	
	
	
	/**
	 * 添加用户简历
	 * 
	 */
	@RequestMapping("/adduserjianli")
	private ModelAndView adduserjianli(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String userid = null;
		userid = request.getParameter("userid");
		
		String meetingname = request.getParameter("meetingname");
		String meetingfrom = request.getParameter("meetingfrom");
		String info = request.getParameter("info");
		String category = request.getParameter("category");
		String language = request.getParameter("language");
		String type = request.getParameter("type");
		String jianlitime = request.getParameter("jianlitime");
		String address = request.getParameter("address");
		
		Map m=new HashMap();
		m.put("userid", userid);
		m.put("richengid", "0");
		m.put("meetingname", meetingname);
		m.put("meetingfrom", meetingfrom);
		m.put("info", info);
		m.put("category", category);
		m.put("language", language);
		m.put("type", type);
		m.put("jianlitime", jianlitime);
		m.put("address", address);
		
		
		ModelAndView modelview = new ModelAndView();
		// getUserList(keyword, pagenumber, pagelines);

		JSONObject objj = adduserjianli(m);
		modelview.addObject("userid", userid);

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/createUserForm");
		return modelview;
	}
	
	
	
	
	/**
	 * 添加用户简历 展示页
	 * 
	 */
	@RequestMapping("/adduserjianliform")
	private ModelAndView adduserjianliform(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String userid = null;
		userid = request.getParameter("userid");
		
//		String userid = request.getParameter("userid");
		ModelAndView modelview = new ModelAndView();
		// getUserList(keyword, pagenumber, pagelines);

		
		modelview.addObject("userid", userid);

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/createUserForm");
		return modelview;
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
			pagelines = "20";
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
		modelview.setViewName("newuser/userList");
		return modelview;
	}
	
	
	
	
	

	/**
	 * 获取用户报名表
	 * 
	 */
	@RequestMapping("/usertransnwork")
	private ModelAndView usertransnwork(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String keyword = null;

		keyword = request.getParameter("keyword");
		
		if (keyword == null) {
			keyword = "";
		}
		if(keyword!=null){
			keyword=keyword.trim();
		}

		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "20";
		}

		ModelAndView modelview = new ModelAndView();

		// getUserList(keyword, pagenumber, pagelines);

		JSONObject objj = getusertransnwork(keyword, pagenumber, pagelines);
		modelview.addObject("usertransnworklist", objj);
		logger.info(request.getSession().getAttribute("name") + "刷新用户花名册列表操作的用户" + request.getSession().getAttribute("name"));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("keyword", keyword);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("newtransnwork/transnworkList");
		return modelview;
	}

	/**
	 * 分页获得系统的所有账户 支持搜索功能 字段： 用户名 手机号 邮箱 支持排序 （按时间倒序，正序,其他字段）
	 * 
	 */
	@RequestMapping("/roboitList")
	private ModelAndView roboitList(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String keyword = null;

		keyword = request.getParameter("keyword");

		if (keyword == null) {
			keyword = "";
		}

		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "10";
		}

		ModelAndView modelview = new ModelAndView();

		// getUserList(keyword, pagenumber, pagelines);

		JSONObject objj = findRoboit(keyword, pagenumber, pagelines);
		modelview.addObject("resuserList", objj);
		String s = objj.getString("msg");
		System.out.println(s);

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("keyword", keyword);
		modelview.setViewName("user/roboitList");
		return modelview;
	}

	
	/**
	 * 一个用户的详细信息 用户加入的群组 用户发的话题在哪个群组里 用户发的干货和课程
	 */
	@RequestMapping("/userDetail")
	public ModelAndView userDetail(HttpServletRequest request) {
		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();
		JSONObject j = getUserDetail(userid);
		// data.result.openFireUser
		JSONObject j2 = (JSONObject) j.get("data");
		JSONObject j3 = (JSONObject) j2.get("result");
		System.out.println(j3);
		try {
			JSONObject j4 = (JSONObject) j3.get("openFireUser");
			System.out.println(j4.toString());
			if (j4.toString().equals("null")) {
				j3.put("openFireUser", "error");
				System.out.println(j3);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		}

		// modelview.addObject("resuserDetail", getUserDetail(userid));
		modelview.addObject("resuserDetail", j3);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userDetail");
		return modelview;

	}

	/**
	 * 一个用户的详细信息 用户加入的群组 用户发的话题在哪个群组里 用户发的干货和课程
	 */
	@RequestMapping("/userTopic")
	public ModelAndView userTopic(HttpServletRequest request) {
		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "10";
		}
		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resuserDetail", getUserDetail(userid));
		modelview.addObject("resuserTopic", getUserTopic(userid, pagenumber, pagelines));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userTopic");
		return modelview;

	}

	/**
	 * 一个用户的详细信息 用户加入的群组 用户发的话题在哪个群组里 用户发的干货和课程
	 */
	@RequestMapping("/userGroup")
	public ModelAndView userGroup(HttpServletRequest request) {
		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "100";
		}
		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resuserDetail", getUserDetail(userid));
		modelview.addObject("resuserGroup", getUserGroup(userid, pagenumber, pagelines));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userGroup");
		return modelview;

	}

	/**
	 * 一个用户的详细信息 用户加入的群组 用户发的话题在哪个群组里 用户发的干货和课程
	 */
	@RequestMapping("/userDry")
	public ModelAndView userDry(HttpServletRequest request) {
		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "10";
		}
		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();
		modelview.addObject("resuserDetail", getUserDetail(userid));
		modelview.addObject("resuserTopic", getUserDry(userid, pagenumber, pagelines));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userDry");
		return modelview;

	}

	/**
	 * 一个用户的详细信息 用户加入的群组 用户发的话题在哪个群组里 用户发的干货和课程
	 */
	@RequestMapping("/userCourse")
	public ModelAndView userCourse(HttpServletRequest request) {
		// 当前第几页
		String pagenumber = request.getParameter("n");

		if (pagenumber == null) {
			pagenumber = "0";
		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {
			pagelines = "10";
		}
		String courSharResoStr3;
		String userid = request.getParameter("userid");

		RestTemplate restTemplate = new RestTemplate();
		ModelAndView modelview = new ModelAndView();

		courSharResoStr3 = restTemplate.getForObject(Config.YXTSERVER3 + "oss/user/getMyCourse?userid=" + userid, String.class);

		try {
			// courSharReso = new ObjectMapper().readValue(courSharResoStr,
			// CourseShareResponse.class);
			JSONObject objj3 = JSONObject.parseObject(courSharResoStr3);

			modelview.addObject("resuserDetail", getUserDetail(userid));
			modelview.addObject("resuserTopic", objj3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userCourse");
		return modelview;

	}


	/**
	 * 提交大咖用户的背景图片
	 * 
	 * 
	 */
	@RequestMapping("/submitvuserbgurl")
	private String submitvuserbgurl(HttpServletRequest request) {
		String fileUrl = request.getParameter("logoUrl");
		if(fileUrl == null || "".equals(fileUrl)){
			fileUrl = request.getParameter("oldLogoUrl");
		}
		String height = request.getParameter("height");
		String width = request.getParameter("width");
		String userid = request.getParameter("id");
		ModelAndView modelview = new ModelAndView();
		getUpdatevUsergburl(userid,width,height,fileUrl);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		
		return  "redirect:/user/VuserList";
		
		
	}

	/**
	 * 提交大咖用户的背景图片 展示页
	 * 
	 * 
	 */
	@RequestMapping("/submitvuserbgurlform")
	private ModelAndView submitvuserbgurlform(HttpServletRequest request, String userid) {
		ModelAndView modelview = new ModelAndView();

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("resuserDetail", getUserDetail(userid));
		modelview.setViewName("user/sumbitvuserbgurl");
		return modelview;

	}

	/**
	 * 
	 * 
	 * 编辑用户信息的表单，处理提交的数据
	 */
	@RequestMapping("/updateUser")
	private String updateUser(HttpServletRequest request, @RequestParam MultipartFile file) {
		String station = request.getParameter("station");
		if ("null".equals(station)) {
			station = "";
		}
		String sex = request.getParameter("sex");
		if ("null".equals(sex)) {
			sex = "";
		}
		String userid = request.getParameter("userid");
		String categoryids[] = request.getParameterValues("categoryids");
		String categoryid = request.getParameter("categoryids2");
		if (categoryids != null && categoryids.length != 0) {
			if (categoryids.length == 1) {
				categoryid = categoryids[0];
			} else {
				categoryid = categoryids[0];
				for (int i = 1; i < categoryids.length; i++) {
					categoryid += "," + categoryids[i];
				}
			}

		}
		String phoneNumber = request.getParameter("phoneNumber");
		if ("null".equals(phoneNumber)) {
			phoneNumber = "";
		}
		String email = request.getParameter("email");
		if ("null".equals(email)) {
			email = "";
		}
		String tag = request.getParameter("tag");
		String robot = request.getParameter("robot");
		String logoURL = request.getParameter("logoURL");
		try {
			if (file.getSize() != 0) {
				String t[] = file.getContentType().split("/");
				String tt = "." + t[1];
				Long l = System.currentTimeMillis();
				String urlString = "/data/ossImgTemp";
				String urlString2 = userid + l + tt;
				InputStream stream = file.getInputStream();
				logoURL = saveimage.save(urlString, urlString2, stream, "user");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String intro = request.getParameter("intro");
		if ("null".equals(intro)) {
			intro = "";
		}
		String nickName = request.getParameter("nickName");
		if ("null".equals(nickName)) {
			nickName = "";
		}
		String Vinfo = request.getParameter("Vinfo");
		if ("null".equals(Vinfo)) {
			Vinfo = "";
		}
		ModelAndView modelview = new ModelAndView();
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		logger.info(request.getSession().getAttribute("name") + "更新用户操作的管理员 " + request.getSession().getAttribute("name") + "====修改的用户的id：" + userid);
		modelview.addObject("resupdateUser",
				getUpdateUser(station, userid, sex, phoneNumber, email, tag, logoURL, intro, nickName, robot, categoryid,Vinfo));

		if ("1".equals(robot)) {
			return "redirect:/user/roboitList";
		} else {
			return "redirect:/user/userList";
		}

	}

	/**
	 * 
	 * 
	 * 编辑用户信息的展示页
	 */
	@RequestMapping("/updateUserForm")
	private ModelAndView updateUserForm(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();
		JSONObject user = getUserDetail(userid);
		JSONObject user2 = (JSONObject) user.get("data");
		JSONObject user3 = (JSONObject) user2.get("result");
		Object categorys[] = null;
		try {
			JSONArray user4 = user3.getJSONArray("isVcategoryIds");
			if (user4.size() != 0) {
				categorys = user4.toArray();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block

			e.printStackTrace();
		}
		String id = "";
		String categoryName = "";
		if (categorys != null && categorys.length != 0) {
			for (int i = 0; i < categorys.length; i++) {
				JSONObject currChildCategory = categoryDetail((String) categorys[i]);
				JSONObject e = (JSONObject) currChildCategory.get("data");
				JSONObject ee = (JSONObject) e.get("result");
				id += ee.getString("id") + ",";
				categoryName += ee.getString("categoryName") + ",";
			}

			id = id.substring(0, id.length() - 1);
			categoryName = categoryName.substring(0, categoryName.length() - 1);

		}

		// JSONObject currChildCategory =
		// categoryDetail(ttt.getString("childCategoryId"));
		/**
		 * 获取一级分类列表
		 */
		JSONObject category = categoryList();
		JSONArray categoryList = category.getJSONObject("data").getJSONArray("result");
		JSONObject childcategory = (JSONObject) categoryList.get(0);
		JSONObject currCategory = categoryDetail(childcategory.getString("id"));
		modelview.addObject("currCategory", currCategory);// 干货的当前分类信息
		modelview.addObject("categoryList", categoryList);// 一级分类列表
		modelview.addObject("resuserDetail", getUserDetail(userid));

		modelview.addObject("categoryids", id);
		modelview.addObject("categorynames", categoryName);

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/editUser");
		return modelview;
	}

	/**
	 * 以下为分类相关方法
	 */
	private JSONObject categoryList() {
		String url = Config.YXTSERVER3 + "category/all";
		return getRestApiData(url);
	}

	private JSONObject categoryDetail(String id) {
		String url = Config.YXTSERVER3 + "category/one?categoryId=" + id;
		return getRestApiData(url);
	}

	/**
	 * 
	 * 
	 * 编辑用户信息的展示页
	 */
	@RequestMapping("/setuserV")
	private String setuserV(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resuserDetail", setuserV(userid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/userList";
	}

	/**
	 * 
	 * 
	 * 编辑用户信息的展示页
	 */
	@RequestMapping("/setVuser")
	private String setVuser(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resuserDetail", setVuser(userid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/VuserList";
	}

	/**
	 * 批量导入用户 展示页 1.页面提交多个表单 2.页面excel csv
	 * 
	 * 
	 */
	@RequestMapping("/importUserView")
	private String importUserView(HttpServletRequest request,Model model) {
		String userid=request.getParameter("userid");
		String username=request.getParameter("username");
		String userlogo=request.getParameter("userlogo");
		// TODO Auto-generated method stub
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		model.addAttribute("cbasePath", cbasePath);
		model.addAttribute("sourcePath", Config.YXTSERVER5);
		model.addAttribute("userid",userid);
		model.addAttribute("username",username);
		model.addAttribute("userlogo",userlogo);
		return "newuser/report";
	}

	/**
	 * 批量导入用户 1.页面提交多个表单 2.页面excel csv
	 * 
	 * 
	 */
	@RequestMapping(value = "/importUser", method = RequestMethod.POST)
	public String importUser(@RequestParam MultipartFile file, Model model,HttpServletRequest request) throws IOException {
		String userid=request.getParameter("userid");
		String username=request.getParameter("username");
		String userlogo=request.getParameter("userlogo");
		List<String> list = service.readReport(file.getInputStream(),Integer.parseInt(userid));
		model.addAttribute("errousers", list);
		model.addAttribute("sourcePath", Config.YXTSERVER5);
		model.addAttribute("userid", userid);
		model.addAttribute("username", username);
		model.addAttribute("userlogo", userlogo);
		return "newuser/import";

	}



	/**
	 * 修改用户服务次数
	 *
	 *
	 */
	@RequestMapping(value = "/importUser2", method = RequestMethod.POST)
	public String importUser2(@RequestParam MultipartFile file,ModelMap modelMap,HttpServletRequest request) throws IOException {
		List<String> list = service.readReport2(file.getInputStream());

			Map<String,Object> map=new HashMap<String,Object>();
			map.put("usernumber", null);
			map.put("sex", null);
			map.put("language", null);
			map.put("userphonenumber", null);
			map.put("search",  null);
			map.put("url", null);
			int n=1;
			int s=20;
			JSONObject objj =getList(n,s,map);
			modelMap.addAttribute("list", objj);
			modelMap.addAttribute("params",map);

		return "resume/resumeList";

	}



//	/**
//	 * 修改用户城市跟行业分类
//	 *
//	 *
//	 */
//	@RequestMapping(value = "/importUser3", method = RequestMethod.POST)
//	public String importUser3(@RequestParam MultipartFile file, Model model,HttpServletRequest request) throws IOException {
//		String userid=request.getParameter("userid");
//		String username=request.getParameter("username");
//		String userlogo=request.getParameter("userlogo");
//		List<String> list = service.readReport2(file.getInputStream(),Integer.parseInt(userid));
//		model.addAttribute("errousers", list);
//		model.addAttribute("sourcePath", Config.YXTSERVER5);
//		model.addAttribute("userid", userid);
//		model.addAttribute("username", username);
//		model.addAttribute("userlogo", userlogo);
//		return "newuser/import";
//
//	}



	/**
	 * 创建机器人 1.正常创建一个用户 2.取用户的id存入机器人bean
	 * 
	 * 
	 */
	@RequestMapping("/createRobotAction")
	private String createRobotAction(HttpServletRequest request) {

		String userName = request.getParameter("userName");
		String passWord = request.getParameter("passWord");
		logger.info(request.getSession().getAttribute("name") + "创建马甲用户操作的管理员 " + request.getSession().getAttribute("name") + "======马甲用户的名称："
				+ userName);
		ModelAndView modelview = new ModelAndView();
		try {
			modelview.addObject("rescreateRobot", getCreateRobot(userName, passWord));
		} catch (Exception e) {
			e.printStackTrace();
		}
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/roboitList";
	}

	/**
	 * 创建机器人 展示页
	 * 
	 * 
	 */
	@RequestMapping("/createRobotForm")
	private ModelAndView createRobotForm(HttpServletRequest request) {

		ModelAndView modelview = new ModelAndView();
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/createUserForm");
		return modelview;
	}

	/**
	 * 榜单 1.最新注册的100用户 2.加入群组最多的10 3.
	 * 
	 * 
	 */
	@RequestMapping("/userBoard")
	private void userBoard(HttpServletRequest request) {
		// TODO Auto-generated method stub

	}

	/**
	 * 密码重置 展示页
	 * 
	 * 
	 */
	@RequestMapping("/resetPasswordForm")
	private ModelAndView resetPasswordForm(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String uid = request.getParameter("uid");

		ModelAndView modelview = new ModelAndView();
		try {
			modelview.addObject("resuserDetail", getUserDetail(uid));
		} catch (Exception e) {
			e.printStackTrace();
		}

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/updateUserPasswdForm");
		return modelview;

	}

	/**
	 * 密码重置
	 * 
	 * 
	 */
	@RequestMapping("/resetPassword")
	private ModelAndView resetPassword(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String uid = request.getParameter("uid");
		String password = request.getParameter("password");

		ModelAndView modelview = new ModelAndView();
		try {
			// CourseShareResponse.class);
			logger.info(request.getSession().getAttribute("name") + "更改用户密码的管理员 " + request.getSession().getAttribute("name") + "====修改的用户id：" + uid);
			modelview.addObject("resresetPassword", getResetPassword(uid, password));
		} catch (Exception e) {
			e.printStackTrace();
		}
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/show");
		return modelview;

	}

	/**
	 * 删除用户 普通用户
	 * 
	 * 
	 */
	@RequestMapping("/deleteUser")
	private String deleteUser(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String uid = request.getParameter("userid");
		logger.info(request.getSession().getAttribute("name") + "删除用户操作的管理员 " + request.getSession().getAttribute("name") + "====删除的用户id:" + uid);
		getDeleteUser(uid);
		return "redirect:/user/userList";

	}

	/**
	 * 删除用户 马甲用户
	 * 
	 * 
	 */
	@RequestMapping("/deleteRoboitUser")
	private String deleteRoboitUser(HttpServletRequest request) {
		// TODO Auto-generated method stub
		String uid = request.getParameter("userid");
		logger.info(request.getSession().getAttribute("name") + "删除用户操作的管理员 " + request.getSession().getAttribute("name") + "====删除的用户id:" + uid);
		getDeleteUser(uid);
		return "redirect:/user/roboitList";

	}

	/**
	 * 根据用户id查找出所有话题
	 */
	@RequestMapping("/getMyTopic")
	private ModelAndView getMyTopic(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resgetMyTopic", getMyTopic(userid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userDetail");
		return modelview;

	}

	/**
	 * 根据用户id查找出所有干货
	 */
	@RequestMapping("/getMyDry")
	private ModelAndView getMyDry(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resMyDry", getMyDry(userid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userDetail");
		return modelview;

	}

	/**
	 * 根据用户id查找出所有群组
	 */
	@RequestMapping("/getMyGroup")
	private ModelAndView getMyGroup(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resMyGroup", getMyGroup(userid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userDetail");
		return modelview;

	}

	/**
	 * 根据用户id查找出所有课程
	 */
	@RequestMapping("/getMyCourse")
	private ModelAndView getMyCourse(HttpServletRequest request) {

		String userid = request.getParameter("userid");

		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resMyCourse", getMyCourse(userid));
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userDetail");
		return modelview;

	}

	/**
	 * 
	 * 为某一个用户id创建群 展示页
	 */
	@RequestMapping("/createGroupForUserForm")
	public ModelAndView createGroupForUserForm(HttpServletRequest request) {
		String courSharResoStr;
		// 当前第几页
		String userid = request.getParameter("userid");
		RestTemplate restTemplate = new RestTemplate();
		ModelAndView modelview = new ModelAndView();

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("user", userid);

		modelview.setViewName("user/createGroupForm");
		return modelview;
	}

	/**
	 * 
	 * 为某一个用户id创建群
	 */
	@RequestMapping("/createGroupForUserAction")
	public ModelAndView createGroupForUserAction(HttpServletRequest request) {
		String courSharResoStr;
		String pagenumber = request.getParameter("n");
		if (pagenumber == null) {

			pagenumber = "0";

		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {

			pagelines = "100";

		}

		String userid = request.getParameter("id");
		String groupName = request.getParameter("groupName");
		String groupDesc = request.getParameter("groupDesc");
		ModelAndView modelview = new ModelAndView();
		RestTemplate restTemplate = new RestTemplate();

		// Map<String, String> rp = new HashMap<String, String>();
		//
		// rp.put("id", userid);
		// rp.put("groupName", groupName.trim());
		// rp.put("intro", groupDesc.trim());

		courSharResoStr = restTemplate.postForObject(
				Config.YXTSERVER3 + "oss/group/create?uid=" + userid + "&groupName=" + groupName + "&intro=" + groupDesc, null, String.class);
		JSONObject objj = JSONObject.parseObject(courSharResoStr);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("creategroup", objj);
		modelview.addObject("resuserDetail", getUserDetail(userid));

		modelview.addObject("resuserGroup", getUserGroup(userid, pagenumber, pagelines));
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/userGroup");
		return modelview;

	}

	/**
	 * 
	 * 查询用户所有主楼回复
	 */
	@RequestMapping("/findAllUserPost")
	public ModelAndView findAllUserPost(HttpServletRequest request) {
		// 当前第几页
		String userid = request.getParameter("userid");
		ModelAndView modelview = new ModelAndView();

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("userpost", getAllUserPost(userid));
		modelview.addObject("uid", userid);
		modelview.setViewName("user/userPostList");
		return modelview;
	}

	/**
	 * 
	 * 查询用户所有副楼回复
	 */
	@RequestMapping("/findAllUserSubPost")
	public ModelAndView findAllUserSubPost(HttpServletRequest request) {
		// 当前第几页
		String userid = request.getParameter("userid");
		ModelAndView modelview = new ModelAndView();

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.addObject("usersubpost", getAllUserSubPost(userid));
		modelview.addObject("uid", userid);
		modelview.setViewName("user/userSubPostList");
		return modelview;
	}

	/**
	 * 
	 * 根据话题id删除主楼回复
	 */
	@RequestMapping("/deletePostByTopicId")
	public String deletePostByTopicId(HttpServletRequest request) {

		// 当前第几页
		String topicid = request.getParameter("topicid");
		String postid = request.getParameter("postid");
		String uid = request.getParameter("uid");
		ModelAndView modelview = new ModelAndView();

		modelview.addObject("resuserTopic", deletePost(topicid, postid));

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		logger.info(request.getSession().getAttribute("name") + "删除主楼回复的管理员 " + request.getSession().getAttribute("name") + "====主楼回复的id：" + postid);
		return "redirect:/user/findAllUserPost?userid=" + uid;
	}

	/**
	 * 
	 * 根据主楼id删除副楼回复
	 */
	@RequestMapping("/deleteSubPostByTopicId")
	public String deleteSubPostByTopicId(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		// 当前第几页
		String postid = request.getParameter("postid");
		String subpostid = request.getParameter("subpostid");
		String uid = request.getParameter("uid");
		logger.info(
				request.getSession().getAttribute("name") + "删除副楼回复操作的管理员 " + request.getSession().getAttribute("name") + "====副楼id：" + subpostid);
		modelview.addObject("subpostList", deleteSubPost(postid, subpostid));

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/findAllUserSubPost?userid=" + uid;
	}

	/**
	 * 
	 * 创建用户花名册 展示页
	 */
	@RequestMapping("/createUserNickNameForm")
	public ModelAndView createUserNickNameForm(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		// 当前第几页

		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/createUserNickNameForm");
		return modelview;
	}

	/**
	 * 
	 * 创建用户花名册
	 */
	@RequestMapping("/createUserNickNameAction")
	public String createUserNickNameAction(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		// 当前第几页
		String nickname = request.getParameter("nickname");
		logger.info(request.getSession().getAttribute("name") + "创建用户花名册操作的管理员 " + request.getSession().getAttribute("name") + "====名称：" + nickname);
		createUserNickName(nickname);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/userNickNameList";
	}

	/**
	 * 
	 * 更新用户花名册 展示页
	 */
	@RequestMapping("/updateUserNickNameForm")
	public ModelAndView updateUserNickNameForm(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		// 当前第几页
		String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("id", id);
		modelview.addObject("nickname", nickname);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/updateUserNickNameForm");
		return modelview;
	}

	/**
	 * 
	 * 更新用户花名册
	 */
	@RequestMapping("/updateUserNickNameAction")
	public String updateUserNickNameAction(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		String id = request.getParameter("id");
		String nickname = request.getParameter("nickname");
		// 当前第几页
		logger.info(request.getSession().getAttribute("name") + "更新用户花名册操作的管理员 " + request.getSession().getAttribute("name") + "====id：" + id
				+ "===名称" + nickname);
		updateUserNickName(nickname, id);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/userNickNameList";
	}
	
	
	/**
	 * 
	 * 高级注册用户列表
	 */
	@RequestMapping("/seniorMembers")
	public ModelAndView seniorMembers(HttpServletRequest request) {
		String pagenumber = request.getParameter("n");
		if (pagenumber == null) {

			pagenumber = "0";

		}

		// 每页条数

		String pagelines = request.getParameter("s");

		if (pagelines == null) {

			pagelines = "10";

		}
		ModelAndView modelview = new ModelAndView();
		JSONObject j=SeniorMember(pagenumber, pagelines);
		modelview.addObject("resuserList", j);
		// 当前第几页
		 
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		modelview.setViewName("user/seniorMember");
		return modelview;
	}
	
	
	@RequestMapping("/user2excel")
	public String count2excel(HttpServletRequest request, Model model,HttpServletResponse response) {
		List<ExcelOutPOJO3> l=new ArrayList<ExcelOutPOJO3>();
		
		JSONObject j=SeniorMember("0", "1000000");
		 
		JSONObject jj=(JSONObject) j.get("data");
		JSONArray jjj=jj.getJSONArray("result");
		
		
		for(int i=0;i<jjj.size();i++){
			ExcelOutPOJO3 e=new ExcelOutPOJO3();
			JSONObject user=(JSONObject) jjj.get(i);
			e.setUserName(user.getString("userName"));
			e.setNickName(user.getString("nickName"));
			e.setPhoneNumber(user.getString("phoneNumber"));
			e.setProgramType(user.getString("programType"));
			e.setProgramMode(user.getString("programMode"));
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd H:m:s");
			e.setCtime(format.format(new java.util.Date(user.getLong("ctime"))));
			e.setWeiXinNumber(user.getString("weiXinNumber"));
			l.add(e);
		}
		
		service2.exportXLS3(response,l);
		
		return "redirect:/user/seniorMembers";
	}

	/**
	 * 
	 * 删除用户花名册
	 */
	@RequestMapping("/deleteUserNickName")
	public String deleteUserNickName(HttpServletRequest request) {
		ModelAndView modelview = new ModelAndView();
		// 当前第几页
		String nickname = request.getParameter("nickname");
		logger.info(request.getSession().getAttribute("name") + "删除用户花名册操作的管理员 " + request.getSession().getAttribute("name") + "===名称" + nickname);
		deleteUsernickname(nickname);
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		modelview.addObject("cbasePath", cbasePath);
		modelview.addObject("sourcePath", Config.YXTSERVER5);
		return "redirect:/user/userNickNameList";
	}
	/**
	 * 
	 * @Title: getUserEvaluate  
	 * @Description: 译员评价
	 * @param userid
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getUserEvaluate" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getUserEvaluate(String userid,Integer n,  Integer s,ModelMap modelMap){
		JSONObject objj=null;
		try {
			if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=10;
			 }
			objj=ossGetUserEvaluate(n,s,userid);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端获取译员评价", e);
			e.printStackTrace();
		}
		return "newuser/userEvaluate";
	}
	/**
	 * 
	 * @Title: getResumeOrder  
	 * @Description: 译员订单列表
	 * @param userid
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getResumeOrder" ,method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getResumeOrder(String userid,Integer n,  Integer s,ModelMap modelMap){
		JSONObject objj=null;
		try {
			if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=10;
			 }
			objj=ossGetResumeOrder(n,s,userid);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端获取译员订单", e);
			e.printStackTrace();
		}
		return "newuser/userOrder";
	}
	/**
	 * 
	 * @Title: getUserPhoto  
	 * @Description: 获取图片地址
	 * @param userid
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getUserPhoto" ,method = RequestMethod.POST)
	@ResponseBody
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object getUserPhoto(String userid,ModelMap modelMap){
		JSONObject objj=null;
		try {
			objj=ossGetResumePhoto(userid);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端获取图片地址", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: recomendResume  
	 * @Description: 推荐译员首页  
	 * @param userid
	 * @param modelMap
	 * @return
	 * @return Object
	 */
	@RequestMapping(value="/recomendResume" ,method = RequestMethod.POST)
	@ResponseBody
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object recomendResume(String userid,ModelMap modelMap){
		JSONObject objj=null;
		try {
			objj=ossGetRecomendResume(userid);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端推荐译员", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: cancelRecomendResume  
	 * @Description: oss端取消推荐译员  
	 * @param userid
	 * @param modelMap
	 * @return
	 * @return Object
	 */
	@RequestMapping(value="/cancelRecomendResume" ,method = RequestMethod.POST)
	@ResponseBody
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object cancelRecomendResume(String userid,ModelMap modelMap){
		JSONObject objj=null;
		try {
			objj=ossDelRecomendResume(userid);
			modelMap.addAttribute("objj", objj);
		} catch (Exception e) {
			logger.info("oss端取消推荐译员", e);
			e.printStackTrace();
		}
		return objj;
	}
	
	private JSONObject deleteUsernickname(String nikename) {
		String url = Config.YXTSERVER3 + "oss/user/deleteusenickname?nickname=" + nikename;
		return getRestApiData(url);
	}

	private JSONObject updateUserNickName(String nikename, String id) {
		String url = Config.YXTSERVER3 + "oss/user/updateusernickname?nickname=" + nikename + "&id=" + id;
		return getRestApiData(url);
	}
	
	private JSONObject SeniorMember(String n, String s) {
		String url = Config.YXTSERVER3 + "oss/user/findSeniorMember?n=" + n + "&s=" + s;
		return getRestApiData(url);
	}

	private JSONObject createUserNickName(String nikename) {
		String url = Config.YXTSERVER3 + "oss/user/createusenickname?nickname=" + nikename;
		return getRestApiData(url);
	}

	private JSONObject getUserList(String keyword, String registType, String n, String s) {
		String url = Config.YXTSERVER3 + "ossuser/getossuserlist?n="+n+"&s="+s+"&keyword="+keyword+"&registType="+registType;
		return getRestApiData(url);
	}

	private JSONObject getusertransnwork(String keyword, String n, String s) {
		String url = Config.YXTSERVER3 + "osstransnwork/ossgetusertransnworklist?n=" + n + "&s=" + s+"&key="+keyword ;
		return getRestApiData(url);
	}

	private JSONObject getUserDetail(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/one/" + userid;
		return getRestApiData(url);
	}

	private JSONObject setuserV(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/changeV?userIds=[" + userid + "]" + "&vFlag=1";
		return getRestApiData(url);
	}

	private JSONObject setVuser(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/changeV?userIds=[" + userid + "]" + "&vFlag=0";
		return getRestApiData(url);
	}

	private JSONObject getUserTopic(String userid, String n, String s) {
		String url = Config.YXTSERVER3 + "oss/user/getMyTopic?userid=" + userid + "&n=" + n + "&s=" + s;
		return getRestApiData(url);
	}

	private JSONObject getUserGroup(String userid, String n, String s) {
		String url = Config.YXTSERVER3 + "oss/group/findMyGroups/" + userid;
		return getRestApiData(url);
	}

	private JSONObject getUserDry(String userid, String n, String s) {
		String url = Config.YXTSERVER3 + "oss/user/getMyDry?userid=" + userid + "&n=" + n + "&s=" + s;
		return getRestApiData(url);
	}


	private JSONObject getUpdateUser(String station, String userid, String sex, String phoneNumber, String email, String tag, String logoURL,
			String intro, String nickName, String robot, String categoryid,String Vinfo) {
		String url = "";
		if ("".equals(categoryid)) {
			url = Config.YXTSERVER3 + "oss/user/update/" + userid + "?sex=" + sex + "&phoneNumber=" + phoneNumber + "&email=" + email + "&tag=" + tag
					+ "&logoURL=" + logoURL + "&intro=" + intro + "&nickName=" + nickName + "&robot=" + robot + "&station=" + station+ "&Vinfo=" + Vinfo;
		} else {
			url = Config.YXTSERVER3 + "oss/user/update/" + userid + "?sex=" + sex + "&phoneNumber=" + phoneNumber + "&email=" + email + "&tag=" + tag
					+ "&logoURL=" + logoURL + "&intro=" + intro + "&nickName=" + nickName + "&robot=" + robot + "&isVcategoryIds=" + categoryid
					+ "&station=" + station+ "&Vinfo=" + Vinfo;
		}

		return getRestApiData(url);
	}

	private JSONObject getUpdatevUsergburl(String userid, String picWidth, String picHeight, String bgUrl) {

		String url = Config.YXTSERVER3 + "oss/user/changevuserbgurl/" + userid + "?bgUrl=" + bgUrl + "&picHeight=" + picHeight + "&picWidth="
				+ picWidth;

		return getRestApiData(url);
	}

	private JSONObject getCreateRobot(String userName, String passWord) {
		String url = Config.YXTSERVER3 + "oss/user/registPc?userName=" + userName + "&passWord=" + passWord + "&robot=1";
		return getRestApiData(url);
	}

	private JSONObject getResetPassword(String uid, String password) {
		String url = Config.YXTSERVER3 + "oss/user/resetPassword?uid=" + uid + "&passWord=" + password;
		return getRestApiData(url);
	}

	private JSONObject getDeleteUser(String uid) {
		String url = Config.YXTSERVER3 + "oss/user/deleuser?uid=" + uid;
		return getRestApiData(url);
	}

	private JSONObject getMyTopic(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/getMyTopic?userid=" + userid;
		return getRestApiData(url);
	}

	private JSONObject getMyDry(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/getMyDry?userid=" + userid;
		return getRestApiData(url);
	}

	private JSONObject getMyGroup(String userid) {
		String url = Config.YXTSERVER3 + "oss/group/findMyGroups/" + userid;
		return getRestApiData(url);
	}

	private JSONObject getMyCourse(String userid) {
		String url = Config.YXTSERVER3 + "oss/course/userCourseList/" + userid;
		return getRestApiData(url);
	}

	private JSONObject findRoboit(String keyword, String n, String s) {
		// String url = Config.YXTSERVER3 + "oss/user/searchbyinfo?n=" + n +
		// "&s=" + s + "&robot=1";
		String url = Config.YXTSERVER3 + "oss/user/searchbyinfo?n=" + n + "&s=" + s + "&robot=1" + "&keyword=" + keyword;
		return getRestApiData(url);
	}

	private JSONObject getuserinfo(String userid) {
		String url = Config.YXTSERVER3 + "ossuser/getuserinfo?userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject deleteuserjianli(String jianliid) {
		String url = Config.YXTSERVER3 + "ossuser/deleteuserjianli?jianliid="+jianliid;
		return getRestApiData(url);
	}
	
	private JSONObject adduserjianli(Map m) {
		String url = Config.YXTSERVER3 + "ossuser/adduserjianli";
		return getRestApiData(url,m);
	}

	private JSONObject getAllUserPost(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/getAllUserPost?uid=" + userid;
		return getRestApiData(url);
	}

	private JSONObject getAllUserSubPost(String userid) {
		String url = Config.YXTSERVER3 + "oss/user/getAllUserSubPost?uid=" + userid;
		return getRestApiData(url);
	}

	private JSONObject deletePost(String topicid, String postid) {
		String url = Config.YXTSERVER3 + "oss/topic/deletePost?topicid=" + topicid + "&postid=" + postid;
		return getRestApiData(url);
	}

	private JSONObject deleteSubPost(String postid, String subpostid) {
		String url = Config.YXTSERVER3 + "oss/topic/deleteSubPost?postid=" + postid + "&subpostid=" + subpostid;
		return getRestApiData(url);
	}
	
	
	
	private JSONObject getDate(String userid) {
		String url = Config.YXTSERVER3 + "ossResume/getDate?userid="+userid;
		return getRestApiData(url);
	}

	@SuppressWarnings({"rawtypes", "unchecked"})
	private JSONObject getList(Integer page,Integer pageSize, Map requestParams) {
		String url = Config.YXTSERVER3 + "ossResume/getUserResumeList?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url, requestParams);
	}
	
	private JSONObject ossGetUserEvaluate(Integer page,Integer pageSize,String userid) {
		String url = Config.YXTSERVER3 + "ossResume/getCustomerEvaluate?page="+page+"&pageSize="+pageSize+"&userid="+userid;
		return getRestApiData(url);
	}
	private JSONObject ossGetResumeOrder(Integer page,Integer pageSize,String userid) {
		String url = Config.YXTSERVER3 + "ossResume/getResumeOrder?page="+page+"&pageSize="+pageSize+"&userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject ossGetResumePhoto(String userid) {
		String url = Config.YXTSERVER3 + "ossResume/getResumePhoto?userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject ossGetRecomendResume(String userid) {
		String url = Config.YXTSERVER3 + "ossResume/recomendResume?userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject ossDelRecomendResume(String userid) {
		String url = Config.YXTSERVER3 + "ossResume/cancelrecomendResume?userid="+userid;
		return getRestApiData(url);
	}
}
