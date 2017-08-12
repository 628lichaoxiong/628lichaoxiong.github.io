<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-设置角色权限</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/scanCalendar.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/permission.css" rel="stylesheet" type="text/css" />
<style>
.table-list{ margin-bottom:20px;}
.small_title_p{ margin-bottom:10px; }
</style>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
</head>
<body style="padding: 10px 30px 0 30px">
    <div id="jump_mask" class="jump_mask" style="display:none;"></div>
    <div id="loading"><div class="msg"></div></div>
    <form id="formID">
    <div class="new_back">
        <h4>设置用户权限</h4>
        <div class="panel_search">
        <div class="fl">
        	<table border="0" cellpadding="0" cellspacing="5" class=role>
	            <tr>
	                <td>角色</td>
	                <td align="left" style="width:100px">
	                    <select name="roleId" id="roleId" style="width: 180px; height: 36px;">
	                        <option value="0">全部</option>
	                          <c:forEach items="${result.roles}" var="role">
	                            <option <c:if test="${roleId == role.roleId}"> selected="selected"</c:if> 
	                              value="${role.roleId}">${role.roleName}</option>
	                          </c:forEach>
	                    </select>
	                </td>
	                <!-- <td></td>
	               <td><input type="submit" value="查询" id="submitRole"/></td> -->
	            </tr>
	        </table>
        </div>
        <%-- <table border="0" cellpadding="0" cellspacing="5">
         <c:forEach items="${result.map}" var="map">
           <tr style ="text-align:left;">  
                <th><transn:menuName value="${map.key}"></transn:menuName>
                    <input type="checkbox" id="${map.key}" name="menu_${map.key}" value="${map.key}" onclick="checkFuncs(${map.key})"/>
                </th> 
           </tr>   
           <tr> 
            <td style ="text-align:left;">
                <c:forEach items="${map.value}" var="func" varStatus="stats">
	            <c:set var="strArray">${func.menuId}_${func.funcCode}</c:set>
	            <input type="checkbox" class="menufunc_${func.menuFirstId}" name="menufuncs" id="${func.menuId}"  
	              <c:if test="${not empty  result.roleMap[strArray]}"> checked </c:if>
	              value="${func.menuId}_${func.funcCode}"/> ${func.funcName}
	                     <c:if test="${(stats.index+1)%6 ==0}"><br/></c:if>   
                 </c:forEach> 
           </td>
           </tr> 
         </c:forEach>
        </table> --%>
        <div class="list">
	        <c:forEach items="${result.map}" var="map">
	        	<div class="fl">
	        		<div class="fl_head clear">
	                	<input type="checkbox" id="${map.key}" name="menu_${map.key}" value="${map.key}" onclick="checkFuncs(${map.key})"/>
	                	<p><transn:menuName value="${map.key}"></transn:menuName></p>
	        		</div>
	        		<div class="fl_content">
	        			<ul class="clear">
	        				<c:forEach items="${map.value}" var="func" varStatus="stats">
		        				<li>
			            			<c:set var="strArray">${func.menuId}_${func.funcCode}</c:set>
					            	<input type="checkbox" class="menufunc_${func.menuFirstId}" name="menufuncs" id="${func.menuId}"  
					              	<c:if test="${not empty  result.roleMap[strArray]}"> checked </c:if>
					              		value="${func.menuId}_${func.funcCode}"/> 
					              	<p>${func.funcName}</p>
					                <c:if test="${(stats.index+1)%6 ==0}"></c:if>   	
		        				</li>
	        				</c:forEach>
	        			</ul>
	        		</div>
	        	</div>
        	</c:forEach>
        </div>
    </div>
</div>
<input type="button" name="submit" id="submit" value="提交修改" onclick="modify();" style="position: absolute; left: 40%;"/>
</form>
<!--错误提示弹窗-->
    <div id="showEorr"></div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/ossUser.js"></script>
<script type="text/javascript">
var ctx="${rc.contextPath}";
$(function(){
    setMenu();
    //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/ossUser/getUserList\')">角色权限管理</a>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
   
});
$("#roleId").change(function(){
    var roleId =$("#roleId  option:selected").val();
    window.location.href = ctx+"/sysPermission/getSysRolePermList?roleId="+roleId;
})
  
$("#submitRole").click(function(){
     var roleId =$("#roleId  option:selected").val(); 
     alert(roleId); 
    window.location.href = ctx+"/sysPermission/getSysRolePermList?roleId="+roleId;
})

//选择该菜单下的所有功能
function checkFuncs(menuId){
var checked = $("#"+menuId).attr("checked");
 //选中，则选中所有的
 if(checked == 'checked'){
    var funcAll = $("input[class='menufunc_"+menuId+"']");
    funcAll.each(function(){
      if(!$(this).attr("checked")) {
        $(this).attr("checked",true);
      }
    });
 }else{
  var funcAll = $("input[class='menufunc_"+menuId+"']");
    funcAll.each(function(){ 
      $(this).removeAttr("checked");
    });
    
 }
 
}
function modify(){
    var roleId =$("#roleId  option:selected").val();
    if(roleId ==null || roleId==''){
      alert('请选择要修改的角色');
       return false;
    }
    var checked =  $("input[type='checkbox']").is(':checked');
    if(checked ==null || checked==''){
        alert('请选择要修改的权限');
         return false;
      }
    $(".jump_mask").show();
        $.ajax({
                url : ctx+"/sysPermission/updatePerm",
                type : "post",
                dataType : "json",
                data : $("#formID").serialize(),
                success : function(resonpe) {
                	$(".jump_mask").hide();
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = ctx+"/sysPermission/getSysRolePermList?roleId="+roleId;
                    }else{
                        alert(resonpe.msg);
                    }
                },
                error : function(data) {
                        alert("服务器异常！请稍后重试");
                        $(".jump_mask").hide();
                }
        });
}
</script>

</body>
</html>
