<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-设置用户角色</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/scanCalendar.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
<style>
.table-list{ margin-bottom:20px;}
.small_title_p{ margin-bottom:10px; }
</style>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/scanCalendar.js"></script>
</head>
<body style="padding: 10px 30px 0 30px">
    <div id="jump_mask" class="jump_mask" style="display:none;"></div>
    <div id="loading"><div class="msg"></div></div>
    <form id="formID">
    <div class="new_back">
        <h4>设置用户角色</h4>
        <div class="clearfix">
            <div class="add_card fl">
                <div class="order_information_left_c">
                 <input type="hidden" name="userId" id="userId" value="${result.userId}">
                <c:forEach items="${result.map}" var="map">
				   <c:forEach items="${map.value}" var="list">
				          <c:set var="strArray">${list.roleId}</c:set>
				         <input type="checkbox" class="userRole_${result.userId}" name="userRoles" id="${result.userId}"  
                             <c:if test="${not empty  result.roleMap[strArray]}"> checked </c:if>
		                     value="${result.userId}_${list.roleId}" />
                            ${list.roleName} &nbsp;&nbsp;
                            <c:if test="${status.index ==3}"><br/></c:if>    
				    </c:forEach>
				</c:forEach>
                </div>
                <div class="btn-group clear">
                    <input type="button" id="submitCard" onclick="setRole()" value="确定" class="save-btn">
                </div>
             </div>
         </div>
</div>
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
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/ossUser/getUserList\')">OSS用户管理列表</a><b>&gt;</b><span>新增用户</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
});
function setRole(){
	 $(".jump_mask").show();
     $.ajax({
             url :  ctx+"/ossUser/setRole",
             type : "post",
             dataType : "json",
             data : $("#formID").serialize(),
             success : function(resonpe) {
            	 $(".jump_mask").hide();
                 if (resonpe.status == 200) {
                     //修改成功
                     alert("操作成功！");
                     window.location.href = ctx+"/ossUser/getUserList";
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
