<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>系统消息管理</title>
<script src="${sourcePath}/resources/assets/js/jquery.min.js"></script>
<script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${sourcePath}/resources/assets/css/font.css" rel="stylesheet">
<style>
#userInfoDiv div {
	padding: 10px;
}

#btnGroupDiv button {
	margin: 10px;
}
</style>
</head>
<body>
 
	<div class="container-fluid">
		<jsp:include page="header.jsp"></jsp:include>
		<ol class="breadcrumb">
			<li><a href="#">系统消息</a></li>
			<li><a href="${sourcePath}system/getsystemmessagelist">消息列表</a></li>
			<li class="active">编辑消息<small>
					 </small>
			</li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">
				<div class="col-xs-2">
					<img class="thumbnail col-xs-12"
							src="${systemmessage.data.result.logo}" alt="" />
							
					</div>
					<div class="col-xs-2">
						<a href="${sourcePath}system/addsystemmessageform?id=${systemmessage.data.result.id}&title=${systemmessage.data.result.title}&content=${systemmessage.data.result.content}&image=${systemmessage.data.result.image}">
						<button type="button" class="edit btn-warning btn-block">编辑</button></a><br>
						<a href="${sourcePath}system/deletesystemmessage?id=${systemmessage.data.result.id}">
						<button type="button"  class="deletetopic btn-warning btn-block">删除</button></a><br>
					</div>
					
					
					 	
					<div id="userInfoDiv" class="col-xs-10" style="">
						<h4 style="margin-left: 12px;">
							话题标题：${systemmessage.data.result.title} <small><small
								class="pull-right">注册时间：<Date:date
										value="${systemmessage.data.result.time}"></Date:date></small></small>
						</h4>
						  
						<div class="col-xs-6">话题内容：${systemmessage.data.result.content}
						</div><br> 
						
						<br><br>
						<%-- <c:if test="${topicDetail.data.result.images!=null}">
							<c:forEach items="${topicDetail.data.result.images}" var="image" varStatus="sta">
								<img 
								src="${image.picUrl}"
								width="150" height="150"  alt=""  id="coverPic"/>
								<c:if test="${sta.index%3==0&&sta.index!=0}">
								<br/>
							</c:if>
							</c:forEach>
						</c:if> --%>
				</div>
			</div>
		</div>
	</div>
	
						 
	<script>
		$(function() {
			/* $("#searchIt").click(function(){
				window.location.href = "${cbasePath}user/userList?keyword="+encodeURI($("#keyword").val());
			}); */
			//处理封面图片问题
			var imgUrl = '${topicDetail.data.result.picUrl}';//原封面图片
			var imgAry = eval('(' + '${topicDetail.data.result.images}' + ')');
			if(imgUrl == '' && imgAry.length > 0){
				$("#coverPic").attr("src", imgAry[0].picUrl);
			} 
			
			
			$(".postdelete").click(function(){
				if(window.confirm('你确定要删除主楼回复吗？')){
					 
					 window.location.href="${cbasePath}topic/deleteTopic?postid="+$(this).attr("data")+"&topicid="+'${topicDetail.data.result.topicId}';
				}else{
					
				}
			}); 
			
			$(".postedit").click(function(){
				 
					alert("postedit");
			 
			}); 
			
			$(".subpostdelete").click(function(){
				if(window.confirm('你确定要删除吗？')){
					alert("subpostdelete");
					//window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");
				}else{
					
				}
			}); 
			
			$(".subpostedit").click(function(){
				 
					alert("subpostedit");
					//window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");
			 
			}); 
			
			$(".addpost").click(function(){
				 
				 
				window.location.href="${cbasePath}topic/addPostByTopicIdForm?topicid="+$(this).attr("data");
		 
		});
			
			
			
			$(".deletetopic").click(function(){
				if(window.confirm('你确定要删除吗？')){
					alert("topic");
					//window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");
				}else{
					
				}
			}); 
			
			
		});
	</script>
</body>
</html>

