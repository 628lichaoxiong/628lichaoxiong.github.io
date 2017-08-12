<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ZH-cn">
<head>
<meta charset="utf-8">
<meta name="author" content="">
<meta name="copyright" content="">
<title>运营支撑系统OSS-更新档期</title>
<style>
*{margin:0; padding:0; list-style:none;}

</style>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/calendar.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jq.js"></script>
<script>
window.onload=function(){
	myCalendar('startDate');
};
</script>
</head>

<body>
<!--为HTMLElement提供缓存--> 
<div id="xx" style="display:none;"></div> 
<input type="hidden" id="rc" value="${rc.contextPath}">
<input type="hidden" id="userid" value="${userid}">
<div id="dates" style="display:none;">
	${dates }
</div>
<input type="text" name="startDate" id="startDate" value="" size="1" placeholder="请选择日期" style="display:none;" />
<script>
$(function(){
	setMenu();
	
});
function setMenu() {//或者自己设定导航逻辑
	//var str = '<span>档期管理</span>';
	var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/resume/getUserResumeList\')">译员列表</a><b>&gt;</b><span>更新档期</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}
</script>
</body>
</html>




