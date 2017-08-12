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
<title>用户管理</title>
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
				 
				<c:if test="${resuserList.status == '200'}">
				<a href="${cbasePath}user/user2excel">
			<button type="button" class="btn btn-primary">下载用户统计EXCEL表格</button>
			</a>
					<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${resuserList.data.curr_page}"
							totalPages="${resuserList.data.page_rows}" perPageRows="10"
							totalRows="${resuserList.data.total_rows}"
							linkBaseUrl="${cbasePath}user/seniorMembers?keyword=${keyword}&registType=${registType}">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>

					<!---数据显示区域-->

					<c:forEach items="${resuserList.data.result}" varStatus="key" var="Recourse">
						<div class="row" style="padding: 20px;">
							<div class="col-xs-1">
								<h5 style="margin-top:40px;"><span class="label label-default">${key.count}</span></h5>
							</div>
							 
							
							<div class="col-xs-10">
								<h4 style="margin-left:12px;">
									<a href="${cbasePath}user/userDetail?userid=${Recourse.id}">
										用户昵称：${Recourse.nickName} </a><small><small
										class="pull-right">注册时间：<Date:date
												value="${Recourse.ctime}"></Date:date></small></small>
								</h4>
								<div class="col-xs-4">
									用户名：${Recourse.userName}
								</div>
								 <div class="col-xs-4">
									手机号：${Recourse.phoneNumber}
								</div>
								 <div class="col-xs-4">
									微信号：${Recourse.weiXinNumber}
								</div> 

							</div>
						</div>
					</c:forEach>
					<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${resuserList.data.curr_page}"
							totalPages="${resuserList.data.page_rows}" perPageRows="10"
							totalRows="${resuserList.data.total_rows}"
							linkBaseUrl="${cbasePath}user/seniorMembers?keyword=${keyword}&registType=${registType}">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>
				</c:if>
			</div>
		</div>
	</div>
 
</body>
</html>

