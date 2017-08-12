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
 * 搜索推荐管理
 * @author james.li
 * @time  2017年7月19日 下午2:54:44
 */
@Controller
@RequestMapping("/searchRecommend")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100704)
public class SearchRecommendController extends BaseController {
	Logger logger = LoggerFactory.getLogger(SearchRecommendController.class);
	
	/**
	 * 搜索推荐列表
	 * @Title: getSearchRecommendList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getSearchRecommendList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getSearchRecommendList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String labelName=request.getParameter("username");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("labelName", labelName);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetSearchRecommendList(n,s,map);
			Map<String,Object> params = new HashMap<String, Object>();
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("oss获取搜索推荐信息", e);
			e.printStackTrace();
		}
		return "searchrecommend/searchRecommendList";
	}
	
	/**
	 * @Title: toAddSearchRecommend  
	 */
	@RequestMapping("/toAddSearchRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String  toAddSearchRecommend(){ 
		return "searchrecommend/addOrUpdateSearch";
	}
	/**
	 * @Title: toAddSearchRecommend  
	 */
	@RequestMapping("/toUpdateSearchRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String  toUpdateSearchRecommend(Integer id,ModelMap modelMap){ 
		JSONObject obj=ossGetSearchRecommendDetail(id);
		modelMap.put("objj", obj);
		return "searchrecommend/addOrUpdateSearch";
	}
	
	/**
	 * 
	 * @Title: addSearchRecommend  
	 * @Description: 添加搜索推荐
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addSearchRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addSearchRecommend(HttpServletRequest request){
		JSONObject obj=null;
		try {
			Map<String, Object> map =new HashMap<String, Object>();
			setPramars(request, map);
			obj=OssAddOrUpdateSearch(map);
		} catch (Exception e) {
			logger.info("oss添加搜索推荐", e);
			e.printStackTrace();
		}
		return obj;
	}
	/**
	 * 设置参数
	 * @param request
	 * @param map
	 */
	private void setPramars(HttpServletRequest request,Map<String, Object> map ){
		String showName=request.getParameter("showName");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String language=request.getParameter("language");
		String label=request.getParameter("label");
		String city=request.getParameter("city");
		map.put("showName", showName);
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("language", language);
		map.put("label", label);
		map.put("city", city);
	}
	/**
	 * 
	 * @Title: updateSearchRecommend  
	 * @Description: 修改搜索推荐
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updateSearchRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateSearchRecommend(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String id=request.getParameter("id");
			Map<String, Object> map =new HashMap<String, Object>();
			setPramars(request, map);
			map.put("id", id);
			obj=OssAddOrUpdateSearch(map); 
		} catch (Exception e) {
			logger.info("修改搜索推荐", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	/**
	 * 
	 * @Title: deleteSearchRecommend  
	 * @Description: 删除搜索推荐
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/deleteSearchRecommend")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object deleteSearchRecommend(Integer id,HttpServletRequest request){
		JSONObject obj=null;
		try {
			obj=ossGetDeleteSearchRecommend(id); 
		} catch (Exception e) {
			logger.info("删除搜索推荐", e);
			e.printStackTrace();
		}
		return obj;
	}
	
	
	private JSONObject ossGetSearchRecommendDetail(Integer id) {
		String url = Config.YXTSERVER3 + "ossSearchrecommend/getSearchDetail?id="+id;
		return getRestApiData(url);
	}
	private JSONObject ossGetDeleteSearchRecommend(Integer id) {
		String url = Config.YXTSERVER3 + "ossSearchrecommend/delSearchSystem?id="+id;
		return getRestApiData(url);
	}
	private JSONObject ossGetSearchRecommendList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossSearchrecommend/getSearchRecommendList?n="+n+"&s="+s;
		return getRestApiData(url,requestParams); 
	}
	private JSONObject OssAddOrUpdateSearch(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossSearchrecommend/addOrUpdateSearch";
		return getRestApiData(url,requestParams);
	}
}
