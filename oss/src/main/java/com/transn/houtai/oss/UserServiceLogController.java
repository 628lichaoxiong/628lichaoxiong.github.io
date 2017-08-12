package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.transn.houtai.domain.userservicelog;
import com.transn.houtai.service.coreservice.UserServiceLogInter;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.utils.page.Pager;
import com.transn.houtai.utils.page.QueryModelMul;


@Controller
@RequestMapping("/userServiceLog")
@AnnotationForController( menuCode = 9999)//不需要权限验证
public class UserServiceLogController extends BaseController {
	
	Logger logger = LoggerFactory.getLogger(UserServiceLogController.class);
	
	@Autowired
	private UserServiceLogInter userServiceLogInter;
	/**
	 * 
	 * @Title: getUserServiceLog  
	 * @Description: 获取订单日志  
	 * @param n
	 * @param s
	 * @param serviceid
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getUserServiceLog" ,method = RequestMethod.POST)
	public String getUserServiceLog(QueryModelMul dm,String serviceid,ModelMap modelMap){
		Pager<userservicelog> pager=null;
		try {
			pager =userServiceLogInter.getBypageAndServiceid(dm,Integer.parseInt(serviceid));
			modelMap.put("pager", pager);
		} catch (Exception e) {
			logger.info("oss获取订单日志失败", e);
			e.printStackTrace();
		}
		return "compation/serviceLogList";
	}
	/**
	 * 
	 * @Title: addUserServiceLog  
	 * @Description: 添加订单日志  
	 * @param name
	 * @param info
	 * @param userid
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/addUserServiceLog" ,method = RequestMethod.POST)
	public Object addUserServiceLog(String name,String info,String userid,String serviceid){
		Map<String,Object> map=new HashMap<String, Object>();
		try {
			userservicelog u=new userservicelog();
			u.setOssuserid(Integer.parseInt(userid));
			u.setInfo(info);
			u.setOssusername(name);
			u.setTime(System.currentTimeMillis()+"");
			u.setServiceid(Integer.parseInt(serviceid));
			userServiceLogInter.saveUserServiceLog(u);
			map.put("status", 200);
			map.put("data", u);
		} catch (Exception e) {
			logger.info("oss添加订单日志失败", e);
			e.printStackTrace();
			map.put("status", 201);
			map.put("msg", "服务器出错，添加订单日志失败");
			return map;
		}
		return map;
	}
}
