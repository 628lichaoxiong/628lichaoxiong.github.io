package com.transn.houtai.oss;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.StringUtil;
import com.transn.houtai.util.qiniu;
import com.transn.houtai.util.permission.AnnotationForController;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Controller
@RequestMapping("/product")
@AnnotationForController( menuCode = 9999)
public class ProductController extends BaseController{
	
	Logger logger = LoggerFactory.getLogger(ProductController.class);
	/**
	 * 
	 * @Title: addProduct  
	 * @Description: 添加商品
	 * @return
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value="/addOrUpdateProduct" ,method = RequestMethod.POST)
	public void addProduct(HttpServletRequest request,@RequestParam("file1") CommonsMultipartFile file1,@RequestParam("file2") CommonsMultipartFile file2,
			@RequestParam("file3") CommonsMultipartFile file3){
		try {
			 Map<String,Object> map=new HashMap<String,Object>();
	         if(file1 !=null){
	        	 String filename=file1.getOriginalFilename();
	        	 filename= StringUtil.rename(filename);
	        	 String imgUrl=qiniu.updateImg(file1.getInputStream(), filename);
	        	 if(StringUtils.isNotBlank(request.getParameter("imgUrl"))){
	        		 String key=request.getParameter("imgUrl").substring(Config.QINIU_PRE.length());
	        		 qiniu.deleteImg(key);
	        	 }
	        	map.put("imgUrl", imgUrl);
	         }
	         if(file2 !=null){
	        	 String filename=file2.getOriginalFilename();
	        	 filename=StringUtil.rename(filename);
	        	 String imgUrl2=qiniu.updateImg(file1.getInputStream(), filename);
	        	 if(StringUtils.isNotBlank(request.getParameter("imgUrl2"))){
	        		 String key=request.getParameter("imgUrl2").substring(Config.QINIU_PRE.length());
	        		 qiniu.deleteImg(key);
	        	 }
	        	 map.put("imgUrl2", imgUrl2);
	         }
	         if(file3 !=null){
	        	 String filename=file2.getOriginalFilename();
	        	 filename=StringUtil.rename(filename);
	        	 String imgUrl3=qiniu.updateImg(file1.getInputStream(), filename);
	        	 if(StringUtils.isNotBlank(request.getParameter("imgUrl3"))){
	        		 String key=request.getParameter("imgUrl3").substring(Config.QINIU_PRE.length());
	        		 qiniu.deleteImg(key);
	        	 }
	        	 map.put("imgUrl3", imgUrl3);
	         }
	         map.put("name", request.getParameter("name"));//商品名称
	         map.put("type", request.getParameter("type"));//商品类型
	         map.put("maxAmount", request.getParameter("maxAmount"));//库存数量
	         map.put("platformType", request.getParameter("platformType"));//平台类型
	         map.put("price", request.getParameter("price"));//商品积分
	         map.put("marketPrice", request.getParameter("marketPrice"));//市场参考价
	         map.put("productInfo", request.getParameter("productInfo"));//商品介绍
	         map.put("useRange", request.getParameter("useRange"));//使用范围
	         map.put("endTime", request.getParameter("endTime"));//有效期
	         map.put("process", request.getParameter("process"));//兑换流程
	         map.put("notes", request.getParameter("notes"));//注意事项
	         map.put("telphone", request.getParameter("telphone"));//客服电话
	         map.put("id", request.getParameter("id"));//商品id
	         JSONObject jsonObject=addProduct(map);
	         System.out.println(jsonObject.toString());
		} catch (Exception e) {
			logger.info("oss端添加商品失败", e);
			e.printStackTrace();
		}
	}
	/**
	 * 
	 * @Title: toaddProduct  
	 * @Description: 跳转到添加商品页面 
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/toaddProduct")
	public String toaddProduct(){
		return "product/addproduct";
	}
	/**
	 * 
	 * @Title: editProduct  
	 * @Description: 修改商品 
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/editProduct")
	public String  editProduct(Integer id,ModelMap modelMap){
		 JSONObject objj=getProduct(id);
		 modelMap.addAttribute("objj", objj);
		return "product/editProduct";
		
	}
	/**
	 * 
	 * @Title: delProduct  
	 * @Description: 删除商品 
	 * @param id
	 * @return
	 * @return JSONObject
	 */
	@RequestMapping(value="delProduct",method = RequestMethod.POST)
	public @ResponseBody JSONObject delProduct(Integer id){
		JSONObject objj=null;
		try {
			JSONObject product=getProduct(id);
			String imgUrl=(String) product.get("imgUrl");
			String imgUrl2=(String) product.get("imgUrl2");
			String imgUrl3=(String) product.get("imgUrl3");
			if(StringUtils.isNotBlank(imgUrl)){
				String key=imgUrl.substring(Config.QINIU_PRE.length());
				qiniu.deleteImg(key);
			}
			if(StringUtils.isNotBlank(imgUrl2)){
				String key=imgUrl2.substring(Config.QINIU_PRE.length());
				qiniu.deleteImg(key);
			}
			if(StringUtils.isNotBlank(imgUrl3)){
				String key=imgUrl3.substring(Config.QINIU_PRE.length());
				qiniu.deleteImg(key);
			}
		   objj =deleteProduct(id);
		} catch (Exception e) {
			logger.info("oss端删除商品失败", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: setShow  
	 * @Description: 设置商品上下架 
	 * @param id
	 * @param isshow
	 * @return
	 * @return JSONObject
	 */
	@RequestMapping(value="setShow",method = RequestMethod.POST)
	public @ResponseBody JSONObject setShow(Integer id,Integer isshow){
		JSONObject objj=null;
		try {
			objj=setProductShow(id,isshow);
		} catch (Exception e) {
			logger.info("oss端设置商品上下架", e);
			e.printStackTrace();
		}
		return objj;
	}
	/**
	 * 
	 * @Title: getProductPager  
	 * @Description: 获取商品列表信息
	 * @param request
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/getProductPager" ,method = RequestMethod.GET)
	public String getProductPager(HttpServletRequest request, Integer n,  Integer s,ModelMap modelMap){
		try {
			 Map<String,Object> map=new HashMap<String,Object>();
			 map.put("type", request.getParameter("type"));
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=20;
			 }
			 JSONObject objj =getProductList(n,s,map);
			 modelMap.addAttribute("list", objj);
			 modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss端获取商品列表信息", e);
			e.printStackTrace();
		}
		return "product/productList";	
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private JSONObject addProduct(Map requestParams) {
		String url = Config.YXTSERVER8 + "oss/addProduct";
		return getRestApiData(url, requestParams);
	}
	
	
	private JSONObject getProduct(Integer id) {
		String url = Config.YXTSERVER8 + "oss/getProductById?id="+id;
		return getRestApiData(url);
	}
	
	private JSONObject deleteProduct(Integer id) {
		String url = Config.YXTSERVER8 + "oss/delproduct?id="+id;
		return getRestApiData(url);
	}
	
	private JSONObject setProductShow(Integer id,Integer isshow) {
		String url = Config.YXTSERVER8 + "oss/setShow?id="+id+"&isshow="+isshow;
		return getRestApiData(url);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked" })
	private JSONObject getProductList(Integer page,Integer pageSize, Map requestParams) {
		String url = Config.YXTSERVER8 + "oss/getProductPager?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url,requestParams);
	}
	
}
