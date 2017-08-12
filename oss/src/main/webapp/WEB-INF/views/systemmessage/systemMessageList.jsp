<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>系统消息</title>
<script src="${sourcePath}/resources/assets/js/jquery.min.js"></script>
<script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${sourcePath}/resources/assets/css/font.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid">
		<jsp:include page="header.jsp"></jsp:include>
		<div class="panel panel-default">
			<div class="panel-body">
<%-- 				<form class="form-inline" action="${cbasePath}user/userList"
					method="get" role="form">
					<div class="form-group">
						<label class="sr-only" for="keyword">Search:</label> <input
							class="form-control" id="keyword" name="keyword"
							placeholder="Enter keyword" value="${keyword }">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<select class="form-control" name="registType" id="registType" onchange="javascript:selectUserType(this);">
							<option value="">全部用户</option>
							<option value="01">手机注册用户</option>
							<option value="02">邮箱注册用户</option>
							<option value="11">QQ第三方登录</option>
							<option value="12">微信第三方登录</option>
							<option value="13">新浪微博第三方登录</option>
						</select>
						&nbsp;&nbsp;&nbsp;&nbsp;
					</div>

					<button id="searchIt" type="submit" class="btn btn-default">Search
						it!</button>
				</form> --%>
				<c:if test="${systemmessagelist.status == '200'}">
					<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${systemmessagelist.data.result.size+1}"
							totalPages="${systemmessagelist.data.result.totalpage}" perPageRows="10"
							totalRows="${systemmessagelist.data.result.total}"
							linkBaseUrl="${sourcePath}system/getsystemmessagelist?id=">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>

					<!---数据显示区域-->

					<c:forEach items="${systemmessagelist.data.result.datas}" varStatus="key" var="Recourse">
						<div class="row" style="padding: 20px;">
							<div class="col-xs-1">
								<h5 style="margin-top:40px;"><span class="label label-default">${key.count}</span></h5>
							</div>
							<div class="col-xs-1">
								<div class="row">
									<img class="col-xs-12 thumbnail" src="${Recourse.logo}"
										style="margin-top: 10px;" alt="" />
								</div>
							</div>
							<div class="col-xs-10">
								<h4 style="margin-left:12px;">
									<a href="${sourcePath}system/getsystemmessageinfo?id=${Recourse.id}">
										消息：${Recourse.title}<!--  </a> --><small><small
										class="pull-right">注册时间：<Date:date
												value="${Recourse.time}"></Date:date></small></small>
								</h4>
								

							</div>
						</div>
					</c:forEach>
					<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${systemmessagelist.data.result.size+1}"
							totalPages="${systemmessagelist.data.result.totalpage}" perPageRows="10"
							totalRows="${systemmessagelist.data.result.total}"
							linkBaseUrl="${sourcePath}system/getsystemmessagelist?id=">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>
				</c:if>
			</div>
		</div>
	</div>
	<script>
		function selectUserType(obj){
			var type = $(obj).val();
			window.location.href= '${cbasePath}user/userList?keyword=' + encodeURI($("#keyword").val()) + '&registType=' + type;
		}
		$(function() {
			/* $("#searchIt").click(function(){
				window.location.href = "${cbasePath}user/userList?keyword="+encodeURI($("#keyword").val());
			}); */
			$("#registType option[value='${registType}']").attr("selected", true);
			$(".deleteBtn").click(function(){
				if(window.confirm('你确定要删除吗？')){
					alert("${cbasePath}user/deleteUser?userid="+$(this).attr("data"));
					window.location.href="${cbasePath}user/deleteUser?userid="+$(this).attr("data");
				}else{
					
				}
			});
		
			$(".look").click(function(){
				
					window.location.href="${cbasePath}user/userDetail?userid="+$(this).attr("data");  
			});
			
			$(".changepasswd").click(function(){
					window.location.href="${cbasePath}user/resetPasswordForm?uid="+$(this).attr("data");  
				 
			});
			
			$(".edit").click(function(){
				window.location.href="${cbasePath}user/updateUserForm?userid="+$(this).attr("data"); 
				 
			});
			
			$(".setV").click(function(){
				window.location.href="${cbasePath}user/setuserV?userid="+$(this).attr("data"); 
				 
			});
		});
	</script>
</body>
</html>

