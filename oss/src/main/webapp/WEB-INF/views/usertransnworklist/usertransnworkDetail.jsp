<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>用户管理</title>
<script src="${sourcePath}/resources/assets/js/jquery.min.js"></script>
<script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${sourcePath}/resources/assets/css/font.css"
	rel="stylesheet">
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
			<li><a href="#">任务报名</a></li>
			<li><a href="${cbasePath}user/usertransnwork">报名列表</a></li>
			<li class="active">报名详情<small> </small>
			</li>
		</ol>
		<div class="panel panel-default">
			<div class="panel-body">
				<div class="row">

					<div class="col-xs-2">
						<%-- <a
							href="${cbasePath}topic/updateTopicItemsForm?topicid=${topicDetail.data.result.topicId }">
							<button type="button" class="edit btn-warning btn-block">编辑</button>
						</a><br> <a
							href="${cbasePath}topic/deleteTopic?topicid=${topicDetail.data.result.topicId }">
							<button type="button" data="${topicDetail.data.result.topicId}"
								class="deletetopic btn-warning btn-block">删除</button>
						</a><br> <a
							href="${cbasePath}topic/addPostByTopicIdForm?topicid=${topicDetail.data.result.topicId }">
							<button name="addpost" data="${topicDetail.data.result.topicId}"
								type="button" class="addpost btn-warning btn-block">添加主楼回复</button>
						</a>
						<hr /> --%>
						<img class="thumbnail col-xs-12"
							src="${usertransnworkinfo.data.result.user.logoimage }" alt="" />
							 <a
							href="${cbasePath}usertransnwork/checkusertransnwork?userid=${usertransnworkinfo.data.result.user.userid}&transnworkid=${usertransnworkinfo.data.result.transnwork.id}&flag=1&usertransnworkid=${usertransnworkinfo.data.result.id}">
							<button type="button" class="edit btn-warning btn-block">审核通过</button>
						</a><br>
						<a
							href="${cbasePath}usertransnwork/checkusertransnwork?userid=${usertransnworkinfo.data.result.user.userid}&transnworkid=${usertransnworkinfo.data.result.transnwork.id}&flag=2&usertransnworkid=${usertransnworkinfo.data.result.id}">
							<button type="button" class="edit  btn-block">审核不通过</button>
						</a><br>
					</div>
					<c:if test="${usertransnworkinfo.status == '200'}">
						<div id="userInfoDiv" class="col-xs-10" style="">
							<div class="row" style="padding: 20px;">
								<h4 style="margin-left: 12px;">
									会议标题：${usertransnworkinfo.data.result.transnwork.meetingname}</h4>

								<div class="col-xs-6">会议时间：${usertransnworkinfo.data.result.transnwork.meetingtime}</div>
								<div class="col-xs-6">会议简介：${usertransnworkinfo.data.result.transnwork.info}</div>
								<div class="col-xs-6">会议类型：${usertransnworkinfo.data.result.transnwork.type}</div>
								<div class="col-xs-6">会议行业：${usertransnworkinfo.data.result.transnwork.category}</div>
								<div class="col-xs-6">会议语言：${usertransnworkinfo.data.result.transnwork.language}</div>
								<div class="col-xs-6">会议地点：${usertransnworkinfo.data.result.transnwork.address}</div>
							</div>

							<div class="row" style="padding: 20px;">
								<h4 style="margin-left: 12px;">用户信息：</h4>
								<div class="col-xs-6">用户名称：${usertransnworkinfo.data.result.user.username}</div>
								<div class="col-xs-6">用户语言：${usertransnworkinfo.data.result.user.language}</div>
								<div class="col-xs-6">国家：${usertransnworkinfo.data.result.user.country}</div>
								<c:if test="${usertransnworkinfo.data.result.user.sex== '0'}">
									<div class="col-xs-6">性别：男</div>
								</c:if>
								<c:if test="${usertransnworkinfo.data.result.user.sex== '1'}">
									<div class="col-xs-6">性别：女</div>
								</c:if>
								<div class="col-xs-6">年龄：${usertransnworkinfo.data.result.user.age}</div>
								<div class="col-xs-6">工作时间：${usertransnworkinfo.data.result.user.workyears}</div>
								<c:if
									test="${usertransnworkinfo.data.result.user.worktype== '1'}">
									<div class="col-xs-6">工作性质：同传</div>
								</c:if>
								<c:if
									test="${usertransnworkinfo.data.result.user.worktype== '2'}">
									<div class="col-xs-6">工作性质：交传</div>
								</c:if>
							</div>

							<div class="row" style="padding: 20px;">
								<h4 style="margin-left: 12px;">用户学历1：</h4>
								<div class="col-xs-6">学历：${usertransnworkinfo.data.result.user.education1}</div>
								<div class="col-xs-6">入学时间：${usertransnworkinfo.data.result.user.intime1}</div>
								<div class="col-xs-6">毕业时间：${usertransnworkinfo.data.result.user.outtime1}</div>
								<div class="col-xs-6">学校：${usertransnworkinfo.data.result.user.school1}</div>
								<div class="col-xs-6">专业：${usertransnworkinfo.data.result.user.major1}</div>
							</div>

							<div class="row" style="padding: 20px;">
								<h4 style="margin-left: 12px;">用户学历2：</h4>
								<div class="col-xs-6">学历：${usertransnworkinfo.data.result.user.education2}</div>
								<div class="col-xs-6">入学时间：${usertransnworkinfo.data.result.user.intime2}</div>
								<div class="col-xs-6">毕业时间：${usertransnworkinfo.data.result.user.outtime2}</div>
								<div class="col-xs-6">学校：${usertransnworkinfo.data.result.user.school2}</div>
								<div class="col-xs-6">专业：${usertransnworkinfo.data.result.user.major2}</div>
							</div>


							<h4 style="margin-left: 12px;">用户工作经历</h4>
							<c:forEach
								items="${usertransnworkinfo.data.result.user.userindestry}"
								var="Resource" varStatus="key">
								<div class="row" style="padding: 20px;">
									<div class="col-xs-1">
										<h5 style="margin-top: 40px;">
											<span class="label label-default">${key.count}</span>
										</h5>
									</div>
									<small>会议名称：${Resource.meetingname}</small>
									<small>会议简介：${Resource.info}</small>
									<small>会议语言：${Resource.language}</small>
									<small>会议方向：${Resource.category}</small>
									<small>会议来源：${Resource.meetingfrom}</small>
									<small>会议类型：${Resource.type}</small>
									<%-- <div class="col-xs-6">会议时间：<Date:date
												value="${Recourse.time}"></Date:date></div> --%>
								</div>
							</c:forEach>


						</div>
				</div>
			</div>
		</div>
		</c:if>

		<script>
			$(function() {
				/* $("#searchIt").click(function(){
					window.location.href = "${cbasePath}user/userList?keyword="+encodeURI($("#keyword").val());
				}); */
				//处理封面图片问题
				var imgUrl = '${topicDetail.data.result.picUrl}';//原封面图片
				var imgAry = eval('(' + '${topicDetail.data.result.images}'
						+ ')');
				if (imgUrl == '' && imgAry.length > 0) {
					$("#coverPic").attr("src", imgAry[0].picUrl);
				}

				$(".postdelete")
						.click(
								function() {
									if (window.confirm('你确定要删除主楼回复吗？')) {

										window.location.href = "${cbasePath}topic/deleteTopic?postid="
												+ $(this).attr("data")
												+ "&topicid="
												+ '${topicDetail.data.result.topicId}';
									} else {

									}
								});

				$(".postedit").click(function() {

					alert("postedit");

				});

				$(".subpostdelete").click(function() {
					if (window.confirm('你确定要删除吗？')) {
						alert("subpostdelete");
						//window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");
					} else {

					}
				});

				$(".subpostedit").click(function() {

					alert("subpostedit");
					//window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");

				});

				$(".addpost")
						.click(
								function() {

									window.location.href = "${cbasePath}topic/addPostByTopicIdForm?topicid="
											+ $(this).attr("data");

								});

				$(".deletetopic").click(function() {
					if (window.confirm('你确定要删除吗？')) {
						alert("topic");
						//window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");
					} else {

					}
				});

			});
		</script>
</body>
</html>

