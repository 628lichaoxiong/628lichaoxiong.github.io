<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%
	String contextPath = request.getContextPath();
%>

<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-批量导入工作经历</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/main.css?id=1" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/sele.js" charset="UTF-8"></script>
</head>
<body>
<script type="text/javascript">
<!--
		//window.top.art.dialog({title:'导入工作经历', id:'edit', iframe:'message.html' ,width:'500px',height:'200px'}, 	function(){window.top.art.dialog({id:'edit'}).close();}, function(){window.top.art.dialog({id:'edit'}).close()});
          //${sourcePath}user/importUserView?userid=${userid}&username=${username}&userlogo=${userlogo}
          //window.location.href="${sourcePath}user/importUserView?userid=${userid}&username=${username}&userlogo=${userlogo}"
		//导入成功执行
		window.top.art.dialog('导入成功！', function () {window.location.href="${sourcePath}user/importUserView?userid=${userid}&username=${username}&userlogo=${userlogo}"});

		//导入失败执行以下
		//window.top.art.dialog('导入失败文案：导入失败，请重新导入！', function () {});
//-->
</script>
</body>
</html>