<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%
	String contextPath = request.getContextPath();
%>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>系统消息创建</title>
<script src="<%=contextPath %>/resources/assets/js/jquery.min.js"></script>
	<script src="<%=contextPath %>/resources/assets/js/bootstrap.min.js"></script>
	<link href="<%=contextPath %>/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
	<link href="<%=contextPath %>/resources/assets/css/font.css" rel="stylesheet">
<style>
#userInfoDiv div {
	padding: 10px;
}
</style>
</head>
<body>
	<div class="container-fluid">

		<ol class="breadcrumb">
			<li><a href="${sourcePath}system/getsystemmessagelist">系统消息</a></li>
			<li><a href="${sourcePath}system/getsystemmessagelist">系统消息列表</a></li>
			 
			<li class="active">系统消息创建</li>
		</ol>

		<div class="row">
			<div class="col-xs-9">
				<form role="form" method="post"
					action="${sourcePath}system/addsystemmessage">
					<input type="hidden" name="id" value="${id}">
					<div class="form-group">
						<label for="exampleInputEmail1">消息名称</label> <input type="text"
							name="title" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${title}">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">消息内容</label>
						<!-- <input type="text"
							name="content" class="form-control" id="exampleInputEmail1"
							placeholder="" style="width:652px;height:150px"> -->
							<textarea name="content" class="form-control" rows="3" cols="20">${content}</textarea>
					</div>
					<%-- <div class="form-group">
						<label for="exampleInputEmail1">图片</label> <input type="text"
							name="image" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${image}"> 
					</div> --%>
					<div class="form-group">
						<label for="exampleInputEmail1">消息类型</label> <input type="text"
							name="logo" class="form-control" id="exampleInputEmail1"
							placeholder="" value="">填写（1或者2或者3） 1：活动   2：问卷  3：更新
					</div>
					
					<button type="submit" class="btn btn-default">提交</button>
				</form>
			</div>
		</div>
		
	</div>
</body>
</html>

