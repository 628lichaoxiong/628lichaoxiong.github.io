<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>Report</title>
    
	
  </head>
  
  <body>
    <%-- <c:url var="exportUrl" value="/report/export" />   --%>
    <c:url var="readUrl" value="/user/importUser?userid=${userid}" />  
      
      <br><br><br><br><br><br><br><br><br>
    <h3>Excel批量导入用户：</h3>  
    <br />  
    <form  id="readReportForm" action="${readUrl}" method="post" enctype="multipart/form-data"  >  
            <label for="file">Excel文件（格式为:会议名称 会议简介  会议时间  会议类型  行业   语言   地址 1(注解：结束符1)）：</label>  
            <input id="file" type="file" name="file" />  
            <p><button type="submit">Read</button></p>    
        </form>  
  </body>
</html>
