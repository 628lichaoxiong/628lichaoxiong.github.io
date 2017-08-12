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
<title>传神任务创建</title>
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
			<li><a href="${cbasePath}transnworklist">传神任务</a></li>
			<li><a href="${cbasePath}transnworklist">传神任务列表</a></li>
			 
			<li class="active">传神任务创建</li>
		</ol>

		<div class="row">
			<div class="col-xs-9">
				<form role="form" method="post"
					action="${cbasePath}addtransnwork">
					<div class="form-group">
						<label for="exampleInputEmail1">会议名称</label> <input type="text"
							name="meetingname" class="form-control" id="exampleInputEmail1"
							placeholder="">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议简介</label>
						<!-- <input type="text"
							name="content" class="form-control" id="exampleInputEmail1"
							placeholder="" style="width:652px;height:150px"> -->
							<textarea name="workinfo" class="form-control" rows="3" cols="20"></textarea>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议行业</label> <input type="text"
							name="category" class="form-control" id="exampleInputEmail1"
							placeholder="">例如：
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议语言</label> <input type="text"
							name="language" class="form-control" id="exampleInputEmail1"
							placeholder="">例如：英语，法语
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议时间</label> <input type="text"
							name="meetingtime" class="form-control" id="exampleInputEmail1"
							placeholder="">例如：2016.3.4~2016.3.6
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议来源</label> <input type="text"
							name="meetingfrom" class="form-control" id="exampleInputEmail1"
							placeholder="">例如：传神
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议类型</label> <input type="text"
							name="type" class="form-control" id="exampleInputEmail1"
							placeholder="">例如：同传，交传
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议联系人手机号</label> <input type="text"
							name="userphonenumber" class="form-control" id="exampleInputEmail1"
							placeholder="">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议地址</label> <input type="text"
							name="address" class="form-control" id="exampleInputEmail1"
							placeholder="">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">是否安排住宿</label> <input type="text"
							name="isusergetin" class="form-control" id="exampleInputEmail1"
							placeholder="">例如：是：1  否：0
					</div>
					
					<button type="submit" class="btn btn-default">提交</button>
				</form>
			</div>
		</div>
		
	</div>
</body>
</html>

