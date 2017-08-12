package com.transn.houtai.util.permission;
import java.lang.reflect.Method;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.transn.houtai.oss.ExceptionController;
import com.transn.houtai.oss.HomeController;

/**
 * 权限校验器
 * @author james.li
 * @time  2017年3月23日 下午3:38:32
 */
public class AuthenticateCheck implements HandlerInterceptor
{
	private final static Log LOG = LogFactory.getLog(AuthenticateCheck.class);
  @Override
  public void afterCompletion ( HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3 ) throws Exception
  {
  }

  @Override
  public void postHandle ( HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3 ) throws Exception
  {
    
  }
  /**
	 * 判断ajax请求
	 * @param request
	 * @return
	 */
	public static boolean isAjax(HttpServletRequest request){
	    return  (request.getHeader("X-Requested-With") != null  && "XMLHttpRequest".equals( request.getHeader("X-Requested-With").toString())   ) ;
	}
  @Override
  public boolean preHandle ( HttpServletRequest arg0, HttpServletResponse arg1, Object arg2 ) throws Exception
  {

    boolean blnCheckResult = false; // 权限检查结果
    int  strMenuCode    = 0;    // menucode 菜单号
    String  strFuncCode    = "";    // funccode 功能号
    Object  objAction      = null;  // Action 类
    Method  method         = null;  // 执行的方法
    String redirectUrl = "/oss/exception/error?msg=";//重定向跳转地址
    if(isAjax(arg0)){ 
    	redirectUrl ="/oss/exception/errorJson?msg=";
    }
    //如果访问静态页面，直接返回
   /* String uri = arg0.getRequestURI();  
    if(uri.contains(".html")){
    	 return true;
    }*/
    LOG.info("┏━ ▼▼ 开始验证权限");
    HandlerMethod handlerMethod = null;
    // 0、获取action
    if(arg2 instanceof HandlerMethod )
    {
      handlerMethod = (HandlerMethod) arg2;
      objAction = ( (HandlerMethod) arg2 ).getBean();
    }else{
    	 return true;//如果不是，则直接返回。预览简历
    }
    // 登陆，注销，菜单树等不需要判权限
   if(objAction  instanceof HomeController|| objAction instanceof ExceptionController)
    {
      LOG.debug("登录，菜单，首页，地址，分类 时间查询 不做权限验证。");
      LOG.info("┗━ ▲▲结束验证权限");
      return true;
    }
    // 1、获取菜单号
    if( objAction.getClass().isAnnotationPresent( AnnotationForController.class ) )
    {
      strMenuCode = objAction.getClass().getAnnotation(AnnotationForController.class).menuCode();
    }else
    {
      String errMsg = "配置错误！类"+objAction.getClass().getName()+"没有配置AnnotationForController注解，获取不到对应的menucode";
      LOG.error(errMsg);
      arg1.sendRedirect( redirectUrl+ URLEncoder.encode("配置错误！请联系管理员！", "UTF-8"));
      return false;
    }
    if ( strMenuCode ==9999)
    {
      LOG.error( "通过权限验证：无需权限验证的交易代码。");
      return true;
    }
    // 2、获取操作功能号
    method = handlerMethod.getMethod();
    if( method.isAnnotationPresent( AnnotationForControllerMethod.class ))
    {
      strFuncCode = method.getAnnotation( AnnotationForControllerMethod.class ).funcCode();
      //一个controller的方法对应多个菜单是适用
      int strFuncMenuCode = method.getAnnotation( AnnotationForControllerMethod.class ).menuCode();
      if(strFuncMenuCode > 0){
    	  strMenuCode = strFuncMenuCode;
      }
    }else
    {
      String errMsg = "配置错误！没有为"+objAction.getClass().getName()+"的方法"+method.getName()+"配置对应的funccode。如：@AnnotationForActionMethod( funcCode = \"INSERT\")";
      LOG.error(errMsg);
      arg1.sendRedirect( redirectUrl+ URLEncoder.encode("系统配置错误！请联系管理员！", "UTF-8"));
      return false;
    }
    
 // 3、获取当前用户登录信息
    //  UserInfo userinfo = (UserInfo)arg0.getSession().getAttribute("loginId");
    Integer userId = (Integer) arg0.getSession().getAttribute("loginId");// CookieUtil.getUserId(arg0);
    if ( userId == null )
    {
      LOG.error( "没有获取到用户的登录信息",new Exception("没有获取到用户的登录信息。") );
      arg1.sendRedirect("/oss" );
      return false; 
    }
    // 4、执行权限校验
    blnCheckResult = AccessChecker.securityCheckFuncCode(userId, strMenuCode, strFuncCode);
    
    // 5、校验不通过，再校验附加权限配置
    if(!blnCheckResult)
    {
      if( method.isAnnotationPresent( PrivateAppend.class ) )
      {
        String strMenuFuncs = method.getAnnotation(PrivateAppend.class).menuFuncs();// 1209:SELECT,1208:UPDATE
        if(strMenuFuncs!=null && !strMenuFuncs.equals( "" ))
        {
          String[] menuFuncs = strMenuFuncs.split( "," ); // 得到1209:SELECT
          for(String menuFunc:menuFuncs)
          {
            String[] menuFuncPair = menuFunc.split( ":" );
            if(menuFuncPair!=null && menuFuncPair.length==2)
            {
              strMenuCode = Integer.valueOf(menuFuncPair[0]); // 得到1209
              strFuncCode = menuFuncPair[1]; // 得到SELECT
              blnCheckResult = AccessChecker.securityCheckFuncCode(userId, strMenuCode, strFuncCode);
              if( blnCheckResult ) break; // 只要通过一个，则不再校验
            }
          }
        }
      }
    }
    
    if ( !blnCheckResult )
    {
      String errMsg = "未通过权限验证，用户：" + userId + "，菜单号：" + strMenuCode + "，操作方法：" + strFuncCode + "。";
      LOG.debug( errMsg);
      arg1.sendRedirect( redirectUrl+ URLEncoder.encode("您没有该操作权限！", "UTF-8"));
     return false;
    }else
    {
      LOG.info( "通过权限验证。" );
      LOG.info("┗━ ▲▲ 结束验证权限 ");
      return true;
    }
  }
}
