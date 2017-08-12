package com.transn.houtai.oss;



import java.io.BufferedInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Constants;
import com.transn.houtai.domain.UserResume;
import com.transn.houtai.domain.userservicelog;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.Converter;
import com.transn.houtai.util.DateUtil;
import com.transn.houtai.util.File2PdfService;
import com.transn.houtai.util.FileUtils;
import com.transn.houtai.util.PoiService;
import com.transn.houtai.util.SystemConfig;
import com.transn.houtai.util.qiniu;
import com.transn.houtai.util.impl.Doc2PdfServiceImpl;
import com.transn.houtai.util.impl.Excel2PdfServiceImpl;
import com.transn.houtai.util.impl.PPT2PdfServiceImpl;
import com.transn.houtai.util.impl.Txt2PdfServiceImpl;
import com.transn.houtai.util.permission.AnnotationForController;
import com.transn.houtai.util.permission.AnnotationForControllerMethod;

@Controller
@RequestMapping("/resume")
@AnnotationForController( menuCode = 100101)
public class ResumeController extends BaseController {
	Logger logger = LoggerFactory.getLogger(ResumeController.class);
	@Resource(name = "poiService")
	private PoiService service;
	/**
	 * 
	 * @Title: importResume
	 * @Description: 跳转到导入简历页面  
	 * @param request
	 * @param model
	 * @return
	 * @return String
	 */
	@RequestMapping("/toImportResume")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.IMPORT)
	private String toImportResume(HttpServletRequest request,Model model) {
		String cpath = request.getContextPath();
		String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
		model.addAttribute("cbasePath", cbasePath);
		model.addAttribute("sourcePath", Config.YXTSERVER5);
		return "resume/resumeReport";
	} 
	/**
	 * 
	 * @Title: importResume  
	 * @Description: 导入简历 
	 * @param file
	 * @return
	 * @throws IOException
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "/importResume", method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.IMPORT)
	public  Object importResume(@RequestParam MultipartFile multfile) throws IOException {
		JSONObject  objj=service.readResume(multfile.getInputStream());
		return objj;
	}
	/**
	 * 
	 * @Title: getUserResumeList  
	 * @Description: 获取译员列表
	 * @param request
	 * @param n
	 * @param s
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	@RequestMapping(value="/getUserResumeList" ,method = RequestMethod.GET)
	public  String getUserResumeList(HttpServletRequest request, Integer n,  Integer s,ModelMap modelMap){
		try {
			 Map<String,Object> map=new HashMap<String,Object>();
			 map.put("usernumber", request.getParameter("usernumber"));
			 map.put("sex", request.getParameter("sex"));
			 map.put("language", request.getParameter("language"));
			 map.put("userphonenumber", request.getParameter("userphonenumber"));
			 map.put("search",  request.getParameter("search"));
			 map.put("username", request.getParameter("username"));
			 map.put("country", request.getParameter("country"));
			 map.put("order", request.getParameter("order"));
			 map.put("isshow", request.getParameter("isshow"));
			 if(n==null){
				 n=1;
			 }
			 if(s==null){
				 s=20;
			 }
			 JSONObject objj =getList(n,s,map);
			 modelMap.addAttribute("list", objj);
			 modelMap.addAttribute("params",map);
		} catch (Exception e) {
			logger.info("oss端获取译员列表信息", e);
			e.printStackTrace();
		}
		return "resume/resumeList";	
	}
	/**
	 * 
	 * @Title: uploadImage  
	 * @Description: 上传头像 
	 * @param multfile
	 * @return
	 * @throws IOException
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPLOAD)
	public  Object uploadImage(@RequestParam MultipartFile file,String userid,String imgName) throws IOException {
		JSONObject objj=null;
		Map<String,Object> params=new HashMap<String, Object>();
		if(file==null){
			objj=new JSONObject();
			objj.put("status", "201");
			objj.put("msg", "上传的文件不存在");
			return objj;
		}
		if(imgName.indexOf("defult")==-1){
			String key=imgName.substring(imgName.lastIndexOf("/")+1, imgName.length());
			qiniu.deleteImg(key);
		}
		String key=UUID.randomUUID().toString();
		String result=qiniu.updateImg(file.getInputStream(),  key);
		params.put("imageUrl", result);
		params.put("userid", userid);
		objj=updateResume(params);
		if((Integer)objj.get("status")!=200){
			qiniu.deleteImg(key);
		}
		return objj;
	}
	
	@ResponseBody
    @RequestMapping(value = "/uploadResume", method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPLOAD)
    public Object uploadResume(MultipartFile fileToUpload, String userId) throws IOException {
        String fileName = fileToUpload.getOriginalFilename();
        String fileType = fileName.substring(fileName.lastIndexOf("."));
        String type =fileType.toUpperCase();
        if(type.equals(".DOCX")||type.equals(".DOC")||type.equals(".XLSX")||type.equals(".XLS")
        		||type.equals(".TXT")||type.equals(".PPTX")||fileType.equals(".PPT")
        		||type.equals(".PDF")){
        }else{
        	Map<String,Object> map =new HashMap<String, Object>();
        	map.put("status", 201);
        	map.put("msg", "不支持该文件类型");
        	return map;
        }
        String randomUUID = UUID.randomUUID().toString();
        String newFilepath = randomUUID+fileType;
        String pdfFilepath = randomUUID+".pdf";
        String filePath = SystemConfig.getInstance().getValue("RESUME_FILE_PATH");
        File file = new File(filePath);
        if(!file.exists()){
            file.mkdirs();
        }
        File uploadFile = new File(filePath+newFilepath);
        File pdfFile = new File(filePath+pdfFilepath);
        newFilepath =qiniu.updateImg(fileToUpload.getInputStream(),  newFilepath);
        //保存到磁盘
        fileToUpload.transferTo(uploadFile);
        
        //路径保存到数据库
        UserResume userResume = new  UserResume();
        userResume.setUserid(Integer.valueOf(userId));
        userResume.setResumeFilePath(newFilepath);
        userResume.setResumeFileName(fileName);
        userResume.setResumeFileFormat(fileType);
        //将word,excel,ppt,txt转换为PDF
        if(!".PDF".equals(fileType.toUpperCase())){
            //开启线程进行转换
        	file2Pdf(uploadFile, pdfFile, fileType);
            pdfFilepath =qiniu.updateFile(pdfFile, pdfFilepath);
            userResume.setResumePdfPath(pdfFilepath);
        }else{
        	userResume.setResumePdfPath(newFilepath);
        }
        //然后删除自己服务器的文件
        Map<String, String> paramMap = new HashMap<String, String>();
        paramMap.put("userResume", JSON.toJSON(userResume).toString());
        return updateResumeFile(paramMap);
	}
	public void file2Pdf(File uploadFile,File  pdfFile, String fileType) {
        File2PdfService file2PdfService = null;
        if(".DOCX".equals(fileType.toUpperCase()) || ".DOC".equals(fileType.toUpperCase())){
            file2PdfService = new Doc2PdfServiceImpl();
        } else if(".PPTX".equals(fileType.toUpperCase()) || ".PPT".equals(fileType.toUpperCase())){
            file2PdfService = new PPT2PdfServiceImpl();
        } else if(".XLSX".equals(fileType.toUpperCase()) || ".XLS".equals(fileType.toUpperCase())){
            file2PdfService = new Excel2PdfServiceImpl();
        } else if(".TXT".equals(fileType.toUpperCase())){
            file2PdfService = new Txt2PdfServiceImpl();
        } else {
            logger.error("不支持的文件格式:"+fileType);
            return;
        }
        InputStream inputStream = null;
        OutputStream outputStream = null;
        try{
            inputStream = new FileInputStream(uploadFile);
            outputStream = new FileOutputStream(pdfFile);
            file2PdfService.convert2Pdf(inputStream, outputStream);
        } catch (IOException e){
            logger.error("找不到对应文件", e);
        } finally{
        	if(inputStream!=null){
        		inputStream=null;
        	}
        	if(outputStream!=null){
        		outputStream=null;
        	}
        }
    }
	/**
	 * 跳转到预览页面
	 * @return
	 */
	@RequestMapping(value = "/preview", method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
    public String preview(HttpServletRequest request, Model model){
	    String cpath = request.getContextPath();
        String cbasePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + cpath + "/";
        model.addAttribute("cbasePath", cbasePath);
	    return "resume/resumeViewer";
	}
	
	/**
	 * 预览原始简历
	 * @param response
	 */
	@ResponseBody
	@RequestMapping(value = "/previewResume_{resumePdfPath}")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public void previewResume(@PathVariable("resumePdfPath") String resumePdfPath, HttpServletRequest request, HttpServletResponse response){
	    response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/pdf;charset=UTF-8");
        InputStream iStream = null;
        BufferedInputStream input = null;
        OutputStream output = null;
        try{
            String filePath = SystemConfig.getInstance().getValue(Constants.RESUME_FILE_PATH);
            iStream = new FileInputStream(new File(filePath+resumePdfPath));
            input = new BufferedInputStream(iStream);
            output = response.getOutputStream();
            byte buffBytes[] = new byte[1024];
            int read = 0;
            while ((read = input.read(buffBytes)) != -1) {
                output.write(buffBytes, 0, read);
            }
        } catch(Exception e){
            logger.error("预览原始简历异常", e);
        } finally{
            try {
                output.flush();
                output.close();
                input.close();
                iStream.close();
            } catch (IOException e) {}    
        }
	}
	
	/**
	 * 下载简历
	 * @param resumeFilePath
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
    @RequestMapping(value = "/downloadResume", method = RequestMethod.GET)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.DOWNLOAD)
    public void downloadResume(String resumeFilePath, String resumeFileName, HttpServletResponse response) throws IOException {
	  //获取订单文件存放路径
        String filePath = SystemConfig.getInstance().getValue(Constants.RESUME_FILE_PATH);
        //下载远程服务器文件直接下载到本地有问题。只能先下载到本地服务器，然后再下载
        try {
//        	resumeFilePath.replaceAll("\\", "\\\\");
        	//先把文件下载到自己的服务器 resumeFilePath远程服务器地址
            FileUtils.downLoadFromUrl(resumeFilePath, resumeFileName,filePath, null);
            //然后把文件下载到本地
            FileUtils.downloadFile(filePath+resumeFileName, resumeFileName, response);
            //然后删除自己服务器的文件
            FileUtils.deleteFile(filePath+resumeFileName);
        } catch (Exception e) {
            logger.error("下载原始简历文件出错", e);
        }
	}
	
	/**
	 * 
	 * @Title: toCalendar  
	 * @Description: 跳转到档期管理
	 * @return
	 * @return String
	 */
	@RequestMapping("/toCalendar")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String toCalendar(String userid,ModelMap modelMap){
		JSONObject objj=getDate(userid);
		objj=(JSONObject) objj.get("data");
		JSONArray array=objj.getJSONArray("result");
		modelMap.addAttribute("userid", userid);
		modelMap.addAttribute("dates", array);
		return "resume/calendar";
		
	}
	/**
	 * 
	 * @Title: getCalendar  
	 * @Description: 获取日历数据 
	 * @param userid
	 * @param modelMap
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/getCalendar",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object getCalendar(String userid,ModelMap modelMap){
		JSONObject objj=getDate(userid);
		objj=(JSONObject) objj.get("data");
		JSONArray array=objj.getJSONArray("result");
		modelMap.addAttribute("userid", userid);
		modelMap.addAttribute("dates", array);
		return objj;
		
	}
	/**
	 * 
	 * @Title: toAddUserResume  
	 * @Description:跳转到新增译员页面  
	 * @return
	 * @return String
	 */
	@RequestMapping("/toAddUserResume")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public String toAddUserResume(ModelMap modelMap){
		JSONObject labelObj=getSysLabel();
		JSONObject objj=getLanguage();
		modelMap.addAttribute("objj", objj);
		modelMap.addAttribute("labelObj", labelObj);
		return "resume/addUserResume";
	}
	/**
	 * 
	 * @Title: addUserResume  
	 * @Description: 添加译员信息 
	 * @param uploadfile
	 * @param userResume
	 * @param eduBeginTime1
	 * @param eduEndTime1
	 * @param eduSchool1
	 * @param eduBeginTime2
	 * @param eduEndTime2
	 * @param eduSchool2
	 * @param wrokBeginTime1
	 * @param wrokEndTime1
	 * @param company1
	 * @param wrokBeginTime2
	 * @param wrokEndTime2
	 * @param company2
	 * @param wrokBeginTime3
	 * @param wrokEndTime3
	 * @param company3
	 * @param wrokBeginTime4
	 * @param wrokEndTime4
	 * @param company4
	 * @param wrokBeginTime5
	 * @param wrokEndTime5
	 * @param company5
	 * @param hangye
	 * @return
	 * @throws IOException
	 * @return Object
	 */
    @ResponseBody
	@RequestMapping(value="/addUserResume",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.ADD)
	public Object addUserResume(@RequestParam MultipartFile uploadfile,UserResume userResume,String eduBeginTime1,
			String eduEndTime1,String eduSchool1,String eduBeginTime2,String eduEndTime2,String eduSchool2,String wrokBeginTime1,
			String wrokEndTime1,String company1,String wrokBeginTime2,String wrokEndTime2,String company2,String wrokBeginTime3,
			String wrokEndTime3,String company3,String wrokBeginTime4,String wrokEndTime4,String company4,String wrokBeginTime5,
			String wrokEndTime5,String company5,String hangye,String photoSecond,String firstPrice,String secondPrice,String evaluate) throws IOException{
		    String jingli1;String jingli2;String jingli3;String jingli4;
		    String jingli5; JSONObject  objj=null;String key = null;
		    Map<String, String> map =new HashMap<String, String>();
			if(uploadfile !=null){
				if(uploadfile.getSize()==0){
					if(userResume.getUserid()==0 && StringUtils.isBlank(photoSecond)){
						objj =new JSONObject();
						objj.put("status", "201");
						objj.put("msg", "请上传译员头像");
						return objj;
					}
				}
				if(uploadfile.getSize()>0){
					//上传图片
					 key=UUID.randomUUID().toString();
                    String result=qiniu.updateImg(uploadfile.getInputStream(),  key);
					 userResume.setLogoimage(result);
		             userResume.setBgimage(result);
				}else{//第二次图片地址
					 userResume.setLogoimage(photoSecond);
		             userResume.setBgimage(photoSecond);
				}
				if(StringUtils.isNotBlank(eduBeginTime1)&&StringUtils.isNotBlank(eduEndTime1)&&StringUtils.isNotBlank(eduSchool1)){
					String school1=DateUtil.convertFormat(eduBeginTime1)+"~"+
							DateUtil.convertFormat(eduEndTime1)+"#"+eduSchool1;
					userResume.setSchool1(school1);
				}
				if(StringUtils.isNotBlank(eduBeginTime2)&&StringUtils.isNotBlank(eduEndTime2)&&StringUtils.isNotBlank(eduSchool2)){
					String school2=DateUtil.convertFormat(eduBeginTime2)+"~"+
							DateUtil.convertFormat(eduEndTime2)+"#"+eduSchool2;
					userResume.setSchool2(school2);
				}
				if(StringUtils.isNotBlank(wrokBeginTime1)&&StringUtils.isNotBlank(wrokEndTime1)&&StringUtils.isNotBlank(company1)){
					jingli1=DateUtil.convertFormat(wrokBeginTime1)+"~"+
							DateUtil.convertFormat(wrokEndTime1)+"#"+company1;
				}else{
					jingli1="";
				}
				if(StringUtils.isNotBlank(wrokBeginTime2)&&StringUtils.isNotBlank(wrokEndTime2)&&StringUtils.isNotBlank(company2)){
					jingli2=DateUtil.convertFormat(wrokBeginTime2)+"~"+
							DateUtil.convertFormat(wrokEndTime2)+"#"+company2;
				}else{
					jingli2="";
				}
				if(StringUtils.isNotBlank(wrokBeginTime3)&&StringUtils.isNotBlank(wrokEndTime3)&&StringUtils.isNotBlank(company3)){
					jingli3=DateUtil.convertFormat(wrokBeginTime3)+"~"+
							DateUtil.convertFormat(wrokEndTime3)+"#"+company3;
				}else{
					jingli3="";
				}
				if(StringUtils.isNotBlank(wrokBeginTime4)&&StringUtils.isNotBlank(wrokEndTime4)&&StringUtils.isNotBlank(company4)){
					jingli4=DateUtil.convertFormat(wrokBeginTime4)+"~"+
							DateUtil.convertFormat(wrokEndTime4)+"#"+company4;
				}else{
					jingli4="";
				}
				if(StringUtils.isNotBlank(wrokBeginTime5)&&StringUtils.isNotBlank(wrokEndTime5)&&StringUtils.isNotBlank(company5)){
					jingli5=DateUtil.convertFormat(wrokBeginTime5)+"~"+
							DateUtil.convertFormat(wrokEndTime5)+"#"+company5;
				}else{
					jingli5="";
				}
				if(StringUtils.isNotBlank(hangye)){
					//hangye =hangye.replaceAll(",", "#");
					userResume.setLabelSystem(hangye);
				}
				if(StringUtils.isNotBlank(userResume.getPerlabel())&&(userResume.getPerlabel().indexOf(",")>0)){
					userResume.setPerlabel(userResume.getPerlabel().replaceAll(",", "#"));
				}
				if(StringUtils.isNotBlank(userResume.getUsertechnical())&&(userResume.getUsertechnical().indexOf(",")>0)){
					userResume.setUsertechnical(userResume.getUsertechnical().replaceAll(",", "#"));
				}
				map.put("userResume", JSON.toJSON(userResume).toString());
				map.put("jingli1", jingli1);
				map.put("jingli2", jingli2);
				map.put("jingli3", jingli3);
				map.put("jingli4", jingli4);
				map.put("jingli5", jingli5);
				map.put("hangye", hangye);
				map.put("firstPrice", firstPrice);
				map.put("secondPrice", secondPrice);
			    objj=addUserResume(map);
			    /*if((Integer)objj.get("status")!=200&&key!=null){
					qiniu.deleteImg(key);
				}*/ 
			}
		return objj;
		
	}
	/**
	 * 
	 * @Title: toUpdateUserResume  
	 * @Description: 跳转到修改页面
	 * @param userid
	 * @param modelMap
	 * @return
	 * @return String
	 */
	@RequestMapping("/toUpdateUserResume")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String toUpdateUserResume(String userid,ModelMap modelMap){
		JSONObject objj=getLanguage();
		modelMap.addAttribute("objj", objj);
		JSONObject objj1=getUserResume(userid);
		modelMap.addAttribute("objj1", objj1);
		return "resume/updateUserResume";
	}
	/**
	 * 
	 * @Title: getDate  
	 * @Description: 更新档期
	 * @param arrdata
	 * @param userid
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/getDate",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object getDate(String arrdata,String userid){
		Map<String,Object> map=new HashMap<String, Object>();
		
		map.put("arrdata", arrdata);
		map.put("userid", userid);
		JSONObject objj=updateDate(map);
		return objj;	
	}
	/**
	 * 
	 * @Title: changeState  
	 * @Description: 修改译员启用状态 
	 * @param userid
	 * @param state
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/changeState",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public Object changeState(Integer userid,Integer state){
		JSONObject objj=updateState(userid,state);
		return objj;	
	}
	/**
	 * 
	 * @Title: getLabel  
	 * @Description:获取标签  
	 * @return
	 * @return Object
	 */
	@ResponseBody
	@RequestMapping(value="/getLabel",method = RequestMethod.POST)
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public Object getLabel(){
		JSONObject objj=getSysLabel();
		return objj;	
	}
	/**
	 * 
	 * @Title: addUserEvaluate  
	 * @Description: 跳转到添加译员评价 
	 * @return
	 * @return String
	 */
	@RequestMapping(value="/toAddUserEvaluate")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.SELECT)
	public String toAddUserEvaluate(String resumeId,ModelMap modelMap,HttpServletRequest request){
		modelMap.addAttribute("resumeId", resumeId);
		String mobile=(String) request.getSession().getAttribute("phonenumber");
		if(StringUtils.isNotBlank(mobile)){
			modelMap.addAttribute("mobile", mobile);
		}else{
			modelMap.addAttribute("mobile", "18612937773");
		}
		
		return "resume/addUserEvaluate";
	}
	/**
	 * 
	 * @Title: addUserEvaluate  
	 * @Description: 添加译员评价
	 * @param language
	 * @param major
	 * @param service
	 * @param social
	 * @param other
	 * @return
	 * @return Object
	 */
	@RequestMapping(value="/addUserEvaluate")
	@AnnotationForControllerMethod( funcCode = Constants.FuncCode.UPDATE)
	public String addUserEvaluate(String language,String major,String service,String social,String other,String resumeId,String mobile,RedirectAttributes attr){
		Map<String,String> map = new HashMap<String, String>();
		map.put("language", language);
		map.put("major", major);
		map.put("service", service);
		map.put("social", social);
		map.put("other", other);
		map.put("resumeId", resumeId);
		map.put("mobile", mobile);
		addEvaluate(map);
		attr.addAttribute("userid",resumeId);
		return "redirect:/user/getuserinfo";
		
		
	}
	@SuppressWarnings({"rawtypes", "unchecked"})
	private JSONObject getList(Integer page,Integer pageSize, Map requestParams) {
		String url = Config.YXTSERVER3 + "ossResume/getUserResumeList?page="+page+"&pageSize="+pageSize;
		return getRestApiData(url, requestParams);
	}
	
	
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	private JSONObject updateResume(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossResume/updateUserResume";
		return getRestApiData(url, requestParams);
	}
	
	@SuppressWarnings({"rawtypes", "unchecked"})
	private JSONObject updateDate(Map requestParams) {
		String url = Config.YXTSERVER3 + "ossResume/updateDate";
		return getRestApiData(url, requestParams);
	}
	
	private JSONObject getDate(String userid) {
		String url = Config.YXTSERVER3 + "ossResume/getDate?userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject getLanguage(){
		String url = Config.YXTSERVER3 + "sysCommon/getLanguagePrice";
		return getRestApiData(url);
	}
	
	private JSONObject addUserResume(Map<String, String> requestParams){
		String url = Config.YXTSERVER3 + "ossResume/addResume";
		return getRestApiData(url, requestParams);
	}
	
	private JSONObject getUserResume(String userid){
		String url = Config.YXTSERVER3 + "/ossResume/getUserResume?userid="+userid;
		return getRestApiData(url);
	}
	
	private JSONObject updateState(Integer userid,Integer state){
		String url = Config.YXTSERVER3 + "/ossResume/updateState?userid="+userid+"&state="+state;
		return getRestApiData(url);
	}
	
	/**
	 * 更新原始简历
	 * @param requestParams
	 * @return
	 */
	private JSONObject updateResumeFile(Map<String, String> requestParams){
        String url = Config.YXTSERVER3 + "/ossResume/updateResumeFile";
        return getRestApiData(url, requestParams);
    }
	/**
	 * 
	 * @Title: getLanguage  
	 * @Description: TODO  
	 * @return
	 * @return JSONObject
	 */
	private JSONObject getSysLabel(){
		String url = Config.YXTSERVER3 + "osslabel/getAllLabelSystem";
		return getRestApiData(url);
	}
	
	private JSONObject addEvaluate(Map<String, String> requestParams){
		String url = Config.YXTSERVER3 + "ossResume/addUserEvaluate";
		return getRestApiData(url,requestParams);
	}
}
