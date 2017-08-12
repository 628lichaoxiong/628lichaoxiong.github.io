package com.transn.houtai.oss;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.domain.News;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.StringUtil;
import com.transn.houtai.util.qiniu;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;

@Controller
@RequestMapping("ossNews")
@AnnotationForController( menuCode = 100801)
public class NewsController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	/**
	 * 
	 * @Title: getNewsList  
	 * @Description: 新闻列表
	 * @param model
	 * @param request
	 * @return
	 * @return String
	 */
	@RequestMapping(value = {"/getNewsList"}, method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getNewsList(Model model,HttpServletRequest request){
		Map<String,Object> map =new HashMap<String,Object>();
    	map.put("type", request.getParameter("type"));//新闻类别（活动和文章）
    	map.put("isUp", request.getParameter("isUp"));//是否置顶
    	map.put("isRecommend", request.getParameter("isRecommend"));//是否推荐
    	map.put("isActivity", request.getParameter("isActivity"));//是否活动
    	map.put("title", request.getParameter("title"));//标题
    	String n=request.getParameter("n");
        String s=request.getParameter("s");
        if(StringUtil.isBlank(n)||StringUtil.isBlank(s)){
          n="1";
          s="10";
        }
        JSONObject objj= getnewslist(n,s,map);
        model.addAttribute("objj", objj);
        model.addAttribute("params", map);
		return "news/newsList";
	}
	/**
	 * 
	 * @Title: toArticleNews  
	 * @Description: 跳转到添加文章新闻 
	 * @return
	 * @return String
	 */
	@RequestMapping(value = {"/toArticleNews"}, method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String toArticleNews(){
		return "news/articleNews";
	}
	/**
	 * 
	 * @Title: toActivityNews  
	 * @Description:跳转到添加活动新闻
	 * @return
	 * @return String
	 */
	@RequestMapping(value = {"/toActivityNews"}, method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String toActivityNews(){
		return "news/activityNews";
	}
	/**
	 * 
	 * @Title: newsInfoScan  
	 * @Description: 查看新闻详情
	 * @param model
	 * @param request
	 * @return
	 * @return String
	 */
	@RequestMapping(value = {"/newsInfoScan"}, method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String newsInfoScan(Model model,HttpServletRequest request){
		String id=request.getParameter("id");
        JSONObject getnews =getnewsInfo(id);
        JSONObject data = getnews.getJSONObject("data");
        JSONObject result = data.getJSONObject("result");
        model.addAttribute("news",result);
        return "news/viewNews";
	}
	/**
	 * 
	 * @Title: editNews  
	 * @Description: 编辑新闻 
	 * @param model
	 * @param request
	 * @return
	 * @return String
	 */
	@RequestMapping(value = {"/editNews"}, method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
    public String editNews(Model model,HttpServletRequest request) {
		String id=request.getParameter("id");
        JSONObject getnews =getnewsInfo(id);
        JSONObject data = getnews.getJSONObject("data");
        JSONObject result = data.getJSONObject("result");
        model.addAttribute("news",result);
        if(result.getInteger("type")==1){//新闻类型 1:新闻动态 2:新闻活动
        	return "news/articleNews";
        }
        if(result.getInteger("type")==2){
        	return "news/activityNews";
        }
        return null;
    }
	/**
	 * 
	 * @Title: addOrUpdateNews  
	 * @Description: 添加或者更新文章 
	 * @param model
	 * @param request
	 * @param coverImage
	 * @param activityImage
	 * @param news
	 * @return
	 * @return String
	 */
	@RequestMapping("addOrUpdateNews")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String addOrUpdateNews(Model model, HttpServletRequest request, 
			@RequestParam MultipartFile coverImage,@RequestParam MultipartFile activityImage,
			News news,Integer type){
		if(!coverImage.isEmpty()){
			try {
				 String fileName = coverImage.getOriginalFilename();
			     String fileType = fileName.substring(fileName.lastIndexOf("."));
			     String randomUUID = UUID.randomUUID().toString();
			     String newFilepath = randomUUID+fileType;
			     String coverUrl=qiniu.updateImg(coverImage.getInputStream(),  newFilepath);
			     news.setCoverurl(coverUrl);
			} catch (IOException e) {
				logger.error("上传封面图片报错:"+e);
				throw new RuntimeException("上传封面失败"); 
			}
        }
		if(!activityImage.isEmpty()){
			try {
				 String fileName = activityImage.getOriginalFilename();
			     String fileType = fileName.substring(fileName.lastIndexOf("."));
			     String randomUUID = UUID.randomUUID().toString();
			     String newFilepath = randomUUID+fileType;
			     String activityUrl=qiniu.updateImg(activityImage.getInputStream(),  newFilepath);
			     news.setActivityurl(activityUrl);
			} catch (IOException e) {
				logger.error("上传活动图片报错:"+e);
				throw new RuntimeException("上传活动图片失败"); 
			}
        }
		if(type==1){
			news.setIsSend(0);//预览
		}
		if(type==2){
			news.setIsSend(1);//发布
		}
		String newsstr=JSON.toJSONString(news);
		JSONObject getnews=addOrUpdateNews(newsstr);
	    JSONObject data = getnews.getJSONObject("data");
	    JSONObject result = data.getJSONObject("result");
	    model.addAttribute("news",result);
	    if(type==1){//预览
	    	return "news/viewNews";
	    }else{
	    	return "redirect:/ossNews/getNewsList";
	    }
		
	}
	/**
	 * 
	 * @Title: deleteNews  
	 * @Description: 删除新闻
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("deleteNews")
	@ResponseBody
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object deleteNews(HttpServletRequest request){
		String id=request.getParameter("id");
		JSONObject objj=deleteNews(id);
		return objj;
	}
	
	
	private JSONObject getnewslist(String n,String s,Map requestParams) {
        String url = Config.YXTSERVER3+"/ossNews/getNewsPager?n="+n+"&s="+s;
        return getRestApiData(url,requestParams);
    }
	
	private JSONObject getnewsInfo(String id) {
        String url = Config.YXTSERVER3+"/ossNews/getNewsInfo?newsId="+id;
        return getRestApiData(url);
    }
	
	private JSONObject addOrUpdateNews(String newsstr) {
        String url = Config.YXTSERVER3+"/ossNews/addOrupdateNews?newsstr="+newsstr;
        return getRestApiData(url);
    }
	private JSONObject deleteNews(String id) {
        String url = Config.YXTSERVER3+"/ossNews/delNews?newsId="+id;
        return getRestApiData(url);
    }
}
