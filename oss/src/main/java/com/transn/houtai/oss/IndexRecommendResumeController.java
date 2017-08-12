package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;
/**
 * 首页推荐管理
 * @author james.li
 * @time  2017年7月3日 下午12:17:33
 */
@Controller
@RequestMapping("/indexResumeRecommend")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100703)
public class IndexRecommendResumeController extends BaseController {
	Logger logger = LoggerFactory.getLogger(IndexRecommendResumeController.class);
	
	/**
	 * 首页译员推荐列表
	 * @Title: getResumeRecommendList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getResumeRecommendList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getResumeRecommendList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetResumeRecommendList(n,s,map);
			Map<String,Object> params = new HashMap<String, Object>();
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取首页译员推荐信息", e);
			e.printStackTrace();
		}
		return "resumeRecommend/resumeRecommendList";
	}
	
	/**
	 * 
	 * @Title: addResumeRecommend  
	 * @Description: 添加首页译员推荐
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addResumeRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addResumeRecommend(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String resumeRecommendName=request.getParameter("resumeRecommendName");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("resumeRecommendName", resumeRecommendName);
			map.put("type", 1+"");//默认1
			obj=OssAddResumeRecommend(map);
		} catch (Exception e) {
			logger.info("oss添加首页译员推荐", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 
	 * @Description: 修改首页译员推荐
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updateResumeRecommendSortNum")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateResumeRecommendSortNum(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String id=request.getParameter("id");
			String oldId=request.getParameter("oldId");
			String sortNum=request.getParameter("sortNum");
			String oldSortNum=request.getParameter("oldSortNum");
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("sortNum", sortNum);
			map.put("oldId", oldId);
			map.put("oldSortNum", oldSortNum);
			map.put("id", id);//陪同版 Templte请求不支持Integer
			obj=OssUpdateResumeRecommendSortNum(map); 
		} catch (Exception e) {
			logger.info("修改首页译员推荐", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 
	 * @Title: deleteResumeRecommend  
	 * @Description: 删除首页译员推荐
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/deleteResumeRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object deleteResumeRecommend(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String id=request.getParameter("id");
			obj=ossGetDeleteResumeRecommend(id); 
		} catch (Exception e) {
			logger.info("删除首页译员推荐", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	
	private JSONObject ossGetDeleteResumeRecommend(String id) {
		String url = Config.YXTSERVER3 + "ossRecommendResume/deleteRecommendResume?id="+id;
		return getRestApiData(url);
	}
	private JSONObject ossGetResumeRecommendList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossRecommendResume/getRecommendResumeList?n="+n+"&s="+s;
		return getRestApiData(url,requestParams); 
	}
	private JSONObject OssUpdateResumeRecommendSortNum(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossRecommendResume/updateResumeRecommendSortNum";
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssAddResumeRecommend(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossRecommendResume/saveResumeRecommendSystem";
		return getRestApiData(url,requestParams);
	}
}
