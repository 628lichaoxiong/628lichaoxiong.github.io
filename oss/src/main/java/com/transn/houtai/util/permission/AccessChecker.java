package com.transn.houtai.util.permission;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.client.RestTemplate;

import com.alibaba.fastjson.JSONObject;
import com.transn.houtai.util.Config;
import com.transn.houtai.util.RedisUtils;
import com.transn.houtai.util.RedisValue;
/**
 * 根据用户信息，菜单号，以及操作方法，验证是否具有操作权限
 * @author james.li
 * @time  2017年3月23日 下午3:37:12
 */
@SuppressWarnings("unchecked")
public class AccessChecker
{
	private final static Log LOG = LogFactory.getLog(AccessChecker.class);
  /**
   * 检查用户是否有操作权限
   * 
   * @param strMenuCode 菜单号
   * @param userinfo 当前用户信息
   * @param strMethod 操作方法（ADD,UPDATE,DELETE,SELECT等）
   * @return blnCheckResult 是否通过权限验证（true 或false）
   */

public static boolean securityCheckFuncCode (Integer userId, Integer strMenuCode, String strMethod )
  {
    boolean blnCheckResult  = false;
    String  strMessage      = "";
    
    if ( userId == null )
    {
      strMessage = "验证权限失败，userInfo为空。";
      LOG.error( strMessage, new Exception( strMessage ) );
      return false;
    }
    strMessage = "开始权限验证：userid:" + userId + "，MenuCode：" + strMenuCode + "，Method:" + strMethod;
    LOG.debug( strMessage );
    if ( strMenuCode == null )
    {
      strMessage = "未通过权限验证：没有获取到交易代码。";
      LOG.error( strMessage, new Exception( strMessage ) );
      return false;
    }
    if ( strMenuCode.equals("9999") )
    {
      strMessage = "通过权限验证：无需权限验证的交易代码。";
      LOG.error( strMessage, new Exception( strMessage ) );
      return true;
    }
    if ( strMethod == null )
    {
      strMessage = "未通过权限验证：没有获取到操作方法。";
      LOG.error( strMessage, new Exception( strMessage ) );
      return false;
    }
    /**
     * redis 缓存
     * 3 所有的用户权限  nasha_user_perm  
     * 获取所有的用户，得到对应的角色，得到所有权限
     *  存储nasha_user_perm 值为 userid_menuid_update  唯一的！
     * 此处判断所传入的参数为 userid menuid 操作方法。唯一匹配
     * 
     * 2，菜单缓存
     * 登录成功后，返回菜单缓存 用户菜单nasha_user_menu(可或不可都行)
     * 
     * 
     * 1，设置 角色的时候，缓存3
     * 设置角色权限的时候 ，缓存3
     */
    //获取用户所有的操作权限，看是否包含该操作userid_menuid_update
    List<String> userPermList =RedisUtils.lrange(RedisValue.SysUserPermName+RedisValue.SplitIdAndName+userId);//当前用户的角色
  //如果缓存没有获取到，则直接从数据库获取
    if(userPermList==null || userPermList.size() ==0){
    	JSONObject objj =OssGetUserPermList(userId);
		JSONObject objj1= (JSONObject) objj .get("data");
		JSONObject objj2=(JSONObject) objj1.get("result");
		if(objj2.get("list") !=null){
			userPermList= (List<String>) objj2.get("list");
		}
    }
    String currUserPerm=userId+RedisValue.SplitIdAndName+strMenuCode+RedisValue.SplitIdAndName+strMethod;
    if(userPermList!=null && userPermList.contains(currUserPerm)){
    	blnCheckResult =true;
    }
    LOG.debug( "权限验证完毕。");
    return blnCheckResult;
  }
  private static JSONObject OssGetUserPermList(Integer userId) {
		String url = Config.YXTSERVER9 + "ossPerm/getUserPermList?userId="+userId;
		String courSharResoStr;
		RestTemplate restTemplate = new RestTemplate();
		courSharResoStr = restTemplate.postForObject(url, null, String.class);
		try {
			JSONObject objj = JSONObject.parseObject(courSharResoStr);
			return objj;
		} catch (Exception e) {
			return null;
		}
	}
}