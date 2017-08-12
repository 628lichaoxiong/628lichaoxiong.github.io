package com.transn.houtai.oss;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Constants;
import com.transn.houtai.util.qiniu;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;
/**
 * 轮播管理
 * @author james.li
 * @time  2017年3月29日 下午2:20:48
 */
@Controller
@RequestMapping("/indexImage")
@SuppressWarnings({ "unchecked", "rawtypes" })
@AnnotationForController( menuCode = 100701)
public class IndexImageController extends BaseController {
	Logger logger = LoggerFactory.getLogger(IndexImageController.class);
	
	/**
	 * OSS轮播列表
	 * @Title: getIndexImageList  
	 * @Description: oss获取信息  
	 * @param request
	 * @return
	 * @return Object
	 */
	@RequestMapping("/getIndexImageList")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String getIndexImageList(HttpServletRequest request,ModelMap modelMap){
		JSONObject obj=null;
		try {
			String n=request.getParameter("n");
			String s=request.getParameter("s");
			String imageName=request.getParameter("imageName");
			Map<String, Object> map =new HashMap<String, Object>();
			if(n==null){
				n="1";
			}
			if(s==null){
				s="10";
			}
			map.put("n", n);
			map.put("s", s);
			map.put("imageName", imageName);
		    map.put("search",  request.getParameter("search"));
			map.put("url", request.getParameter("url"));
			obj=ossGetIndexImageList(n,s,map);
			Map<String,Object> params = new HashMap<String, Object>();
			modelMap.addAttribute("params",params);
			modelMap.addAttribute("list", obj); 
		} catch (Exception e) {
			logger.info("轮播列表", e);
			e.printStackTrace();
		}
		return "indeximage/indexImageList";
	}
	
	/**
	 * @Title: toAddIndexImage  
	 */
	@RequestMapping("/toAddIndexImage")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String  toAddIndexImage(ModelMap modelMap){ 
		modelMap.put("operaName", "新增");
		return "indeximage/modifyIndexImage";
	}
	/**
	 * @Title: toAddIndexImage  
	 */
	@RequestMapping("/toUpdateIndexImage")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String  toUpdateIndexImage(Integer id,ModelMap modelMap){ 
		JSONObject obj=ossGetIndexImageInfo(id) ;
		JSONObject objj1= (JSONObject) obj .get("data");
		JSONObject objj2=(JSONObject) objj1.get("result");
		modelMap.put("indexImage", objj2);
		modelMap.put("operaName", "修改");
		return "indeximage/modifyIndexImage";
	}
	
	/**
	 * 
	 * @Title: addIndexImage  
	 * @Description: 添加轮播
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/addIndexImage")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object addIndexImage(@RequestParam MultipartFile uploadfile,
			@RequestParam MultipartFile uploadfile1,HttpServletRequest request){
		JSONObject objj=null;
		try { 
			Map<String, Object> map =setParams(uploadfile, uploadfile1, request);
			objj=OssAddOrUpdateIndexImage(map);
		} catch (Exception e) {
			logger.info("oss添加轮播", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: updateIndexImage  
	 * @Description: 修改轮播
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/updateIndexImage")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object updateIndexImage(@RequestParam MultipartFile uploadfile,
			@RequestParam MultipartFile uploadfile1,HttpServletRequest request){
		JSONObject objj=null;
		try { 
			Map<String, Object> map =setParams(uploadfile, uploadfile1, request);
			objj=OssAddOrUpdateIndexImage(map);
		} catch (Exception e) {
			logger.info("修改轮播", e);
			e.printStackTrace();
		}
		return objj;
	}
    private Map<String, Object> setParams(MultipartFile uploadfile,MultipartFile uploadfile1,ServletRequest request) throws IOException{
		String imageName=request.getParameter("imageName");
		String skipUrl=request.getParameter("skipUrl");
		String type=request.getParameter("type");
		String urlType=request.getParameter("urlType");
		String imageUrl=request.getParameter("imageUrl");
		String serarchId=request.getParameter("serarchId");
		String photoSecond=request.getParameter("photoSecond");
		String id =request.getParameter("id"); 
		String photoSecond1=request.getParameter("photoSecond1");
		String imageSubjectUrl="";
		if(uploadfile.getSize()>0){
			//上传图片
			String key=UUID.randomUUID().toString();
             imageUrl=qiniu.updateImg(uploadfile.getInputStream(),  key);
		}else{//第二次图片地址
			imageUrl=photoSecond;
		}
		String imageSubjectSize="";
		if(uploadfile1.getSize()>0){
			//上传图片
			String key=UUID.randomUUID().toString();
			imageSubjectUrl=qiniu.updateImg(uploadfile1.getInputStream(),  key);
			BufferedImage src =ImageIO.read( uploadfile1.getInputStream());
            imageSubjectSize =src.getWidth()+","+src.getHeight();
		}else{//第二次图片地址
			imageSubjectUrl=photoSecond1;
		}
		Map<String, Object> map =new HashMap<String, Object>();
		map.put("imageName", imageName);
		map.put("skipUrl", skipUrl);
		map.put("type", type);
		map.put("imageUrl", imageUrl);
		map.put("imageSubjectUrl", imageSubjectUrl);
		map.put("serarchId", serarchId);
		map.put("urlType", urlType);
		map.put("id", id);
		map.put("imageSubjectSize", imageSubjectSize);
		return map;
	}
	/**
	 * 
	 * @Title: deleteIndexImage  
	 * @Description: 删除轮播
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping("/deleteIndexImage")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.DELETE)
	public Object deleteIndexImage(HttpServletRequest request){
		JSONObject obj=null;
		try {
			String id=request.getParameter("id");
			obj=ossGetDeleteIndexImage(id,getOssUserName(request)); 
		} catch (Exception e) {
			logger.info("删除轮播", e);
			e.printStackTrace();
		}
		return obj;
	}
	private JSONObject ossGetDeleteIndexImage(String id,String ossName) {
		String url = Config.YXTSERVER3 + "ossIndexImage/deleteIndexImage?id="+id+"&ossName="+ossName;
		return getRestApiData(url);
	}
	private JSONObject ossGetIndexImageList(String n,String s,Map requestParams) {
		String url = Config.YXTSERVER3 + "ossIndexImage/getIndexImageList?page="+n+"&pageSize="+s;
		return getRestApiData(url,requestParams);
	}
	private JSONObject OssAddOrUpdateIndexImage(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossIndexImage/addOrUpdateIndexImage";
		return getRestApiData(url,requestParams);
	}
	private JSONObject ossGetIndexImageInfo(Integer id) {
		String url = Config.YXTSERVER3 + "ossIndexImage/getIndexImageInfo?id="+id;
		return getRestApiData(url);
	}
	
}
