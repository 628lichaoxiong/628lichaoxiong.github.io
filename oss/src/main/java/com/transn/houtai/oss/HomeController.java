package com.transn.houtai.oss;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.MD5;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends BaseController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("sourcePath", Config.YXTSERVER6);
		return "login";
	}


	@RequestMapping(value = "/login")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public  String login(HttpServletRequest request,ModelMap modelMap) {
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String randomCode = request.getParameter("randomCode");
		if(!randomCode.equalsIgnoreCase(request.getSession().getAttribute("randomCode").toString())){
			modelMap.addAttribute("msg","输入的验证码错误!");
			return "login";
		}
		JSONObject j = osslogin(name, MD5.MD5tool(password));
		Integer integer = (Integer) j.get("status");
		if (integer == 200) {
			JSONObject jj = (JSONObject) j.get("data");
			JSONObject jjj = (JSONObject) jj.get("result");
			Integer loginId=(Integer)jjj.get("id");
			String names = (String) jjj.get("name");
			String username = (String) jjj.get("username");
			String phonenumber = (String) jjj.get("phonenumber");
			String groups = (String) jjj.get("groups");
//			String passwd = (String) jjj.get("passwd");
			HttpSession  session= request.getSession(true);
//			session.setMaxInactiveInterval(60);//秒
			session.setAttribute("name", names);
			session.setAttribute("group", groups);
			session.setAttribute("username", username);
			session.setAttribute("phonenumber", phonenumber);
			session.setAttribute("loginId", loginId);
			return "home";
		} else {
			modelMap.addAttribute("msg",j.get("msg"));
			return "login";
		}

	}
	@ResponseBody
	@RequestMapping("/updatePasswd")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.DISABLE)
	public Object updatePasswd(HttpServletRequest request){
		JSONObject obj=null;
		try { 
			String loginId = request.getParameter("loginId");
			String oldPasswd = request.getParameter("oldPasswd");
			String newPasswd = request.getParameter("newPasswd");
			obj=ossUpdatePasswd(loginId,MD5.MD5tool(oldPasswd),MD5.MD5tool(newPasswd));
		} catch (Exception e) {
			logger.info("oss修改密码", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	private JSONObject ossUpdatePasswd(String loginId, String oldPasswd,String newPasswd) {
		String url = Config.YXTSERVER3 + "ossuser/updatePasswd?loginId=" + loginId+"&newPasswd="+newPasswd+ "&oldPasswd=" + oldPasswd;
		return getRestApiData(url);
	}
	private JSONObject osslogin(String name, String passwd) {
		String url = Config.YXTSERVER3 + "ossuser/checkossuser?name=" + name + "&passwd=" + passwd;
		return getRestApiData(url);
	}
	@RequestMapping(value = "/404")
	public String notFound(HttpServletRequest request) {

		return "404";

	}
	@RequestMapping(value = "/index/leftFrame", method = RequestMethod.POST)
//	@ResponseBody  
	public String leftFrame(HttpServletRequest request,HttpServletResponse response,Model model) throws UnsupportedEncodingException {
		String treeMenuList=""; 
		//获取用户的权限菜单
    	JSONObject objj =OssGetUserMenuList(getOssUserId(request));
		JSONObject objj1= (JSONObject) objj .get("data");
		JSONObject objj2=(JSONObject) objj1.get("result");
		if(objj2.get("firstMenuList") !=null ){
			//1级菜单 
			List<String> firstMenuList= (List<String>) objj2.get("firstMenuList");
			//2级菜单
			Map<String,List<String>> secondMenuMap=(Map<String, List<String>>) objj2.get("secondMenuList");
			//拼接2级菜单到1级菜单下
			int num=0;//从0开始
			for(String firstMenu:firstMenuList){
				String firstMenuH ="<h3 id='menu"+num+"' class='menu"+num+"'><i></i></span><a href >"+firstMenu+"</a>";
				List<String> secondMenuList=secondMenuMap.get(firstMenu);//第二级菜单
				StringBuffer secondUl=new StringBuffer("<ul>");
				boolean isFirstSecond=true;//第一个二级菜单，拼接一级菜单点击跳转第一个二级菜单
				if(secondMenuList!=null && secondMenuList.size()>0){
					for(String secondMenu:secondMenuList){
						String secondMenuSplit[]=secondMenu.split("-");// /customer/getCustomerList-客户管理
						String url =secondMenuSplit[0];//
						String secondMenuName =secondMenuSplit[1];//
						String secondMenuLi="<li onclick=\"_MP('"+url+"', "+num+")\">"+secondMenuName+"</li>";
						secondUl.append(secondMenuLi);
						if(isFirstSecond){
							firstMenuH = firstMenuH.replace("href", "onclick=\"_MP('"+url+"', "+num+")\"");
							isFirstSecond=false;
						}
					}
					secondUl.append("</ul>");
					num++;
				}else{
					//如果没有二级菜单，不拼接一级菜单
					num++;
					continue; 
				}
				String firstMenuHEnd ="</h3>";
				
				treeMenuList=treeMenuList+firstMenuH+secondUl.toString()+firstMenuHEnd;
			}
		}
		/*treeMenuList=treeMenuList+"<h3 firstMenuHEndid='menu0' class='menu0'><i></i><a href='javascript:;' onclick=\"_MP('resume/getUserResumeList', 0)\">译员管理</a></h3>"
		+"<h3 id='menu1' class='menu1'><i></i></span><a href='javascript:;' onclick=\"_MP('customer/getCustomerList', 1)\">客户管理</a></h3>"
		+"<h3 id='menu2' class='menu2'><i></i></span><a href='javascript:;' onclick=\"_MP('compation/getcompationList', 2)\">订单管理</a></h3>"
		+"<h3 id='menu4' class='menu4'><i></i><a href='javascript:;'>N卡管理</a>"
		+ "<ul><li onclick=\"_MP('card/getCardInfoParams', 4)\">卡片列表</li><li onclick=\"_MP('card/getNewCardInfoParams', 4)\">新卡管理</li><li onclick=\"_MP('card/countCards', 4)\">数据管理</li></ul></h3>"
		+"<h3 id='menu3' class='menu3'><i></i><a href='javascript:;' onclick=\"_MP('fadeback/getfadebacklist', 3)\">APP反馈</a></h3>"
		+"<h3 id='menu5' class='menu5'><i></i><a href='javascript:;' onclick=\"_MP('sysLog/getSysLogList', 5)\">日志管理</a></h3>";
		treeMenuList =treeMenuList +""; */
		model.addAttribute("treeMenuList", treeMenuList);
		return "leftFrame";  
		
	}
   private  JSONObject OssGetUserMenuList(Integer userId) {
			String url = Config.YXTSERVER9 + "ossPerm/getUserMenuList?userId="+userId;
			return getRestApiData(url);
	}

}
