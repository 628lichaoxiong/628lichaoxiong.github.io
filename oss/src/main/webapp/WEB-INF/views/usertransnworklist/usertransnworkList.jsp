<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>传神任务报名表</title>
<script src="${sourcePath}/resources/assets/js/jquery.min.js"></script>
<script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${sourcePath}/resources/assets/css/font.css" rel="stylesheet">
</head>

<body>

	<div class="container-fluid">
	<%-- <jsp:include page="header.jsp"></jsp:include> --%>
		<div class="panel panel-default">
			<div class="panel-body">
				<form class="form-inline" action="${cbasePath}user/usertransnwork"
					method="get" role="form">
					<div class="form-group">
						<label class="sr-only" for="keyword">Search:</label> <input
							class="form-control" id="keyword" name="keyword"
							placeholder="输入任务名称" value="${keyword}">
					</div>

					<button id="searchIt" type="submit" class="btn btn-default">搜索</button>
				</form>
				</br>
				建议您过了报名有效期后再执行此项操作</br>
				 <a href="${cbasePath}usertransnwork/checkusertransnwork?transnworkid=${transnworkid}&flag=2">
				<button id="searchIt" type="submit" class="btn btn-danger">一键拒绝未审核用户</button>
				</a>
				<c:if test="${usertransnworklist.status == '200'}">
					<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${usertransnworklist.data.result.size+1}"
							totalPages="${usertransnworklist.data.result.totalpage}" perPageRows="10"
							totalRows="${usertransnworklist.data.result.total}"
							linkBaseUrl="${cbasePath}usertransnwork/transnworklist?keyword=">
						</pageNation:PageNation>
					</ul>
					<!-- 分页结束 --> </nav>

					<!---数据显示区域-->

					<c:forEach items="${usertransnworklist.data.result.datas}" varStatus="key" var="Recourse">
						<div class="row" style="padding: 20px;">
							<div class="col-xs-1">
								<h5 style="margin-top:40px;"><span class="label label-default">${key.count}</span></h5>
							</div>
							 
							<div class="col-xs-10">
								<h4 style="margin-left:12px;">
									<a href="${cbasePath}usertransnwork/usertransnworkinfo?usertransnworkid=${Recourse.id}">
										报名用户：${Recourse.user.username}</a><br><br>
										<small>会议内容：
										<c:if test="${Recourse.transnwork.info != null && Recourse.transnwork.info != 'null'}">					
											<c:choose>
									          <c:when test="${fn:length(Recourse.transnwork.info) > 30}"> 
									          
									              <c:out value="${fn:substring(Recourse.transnwork.info, 0, 30)}......" />
									         </c:when>
									         <c:when test="${fn:length(Recourse.transnwork.info) <= 30}"> 
									            <c:out value="${Recourse.transnwork.info}" />
									          </c:when>
									      </c:choose>
									      </c:if> </small>
										<small><small
										class="pull-right">会议创建时间：<Date:date
												value="${Recourse.transnwork.time}"></Date:date></small></small>
												
								</h4>
								<small>会议名称： ${Recourse.transnwork.meetingname} </small><br>
								<small>会议开始时间：${Recourse.transnwork.meetingtime}</small><br>
								<small>会议类型：${Recourse.transnwork.type}</small><br>
								<small>会议地址：${Recourse.transnwork.address}</small><br>
								<small>会议联系人手机：${Recourse.transnwork.userphonenumber}</small><br>
								<br>
								<small>用户名称：${Recourse.user.username}</small><br>
								<small>用户优势：${Recourse.baominguser.userinfo}</small><br>
								<small>用户报价：${Recourse.baominguser.money}</small><br>
								
								<c:if test="${Recourse.flag == '0'}">	
								<small>用户审核状态：未审核</small><br></c:if>
								<c:if test="${Recourse.flag == '1'}">	
								<small>用户审核状态：<font color="green">审核通过</font></small><br></c:if>
								<c:if test="${Recourse.flag == '2'}">	
								<small>用户审核状态：<font color="red">未通过</font></small><br>
								</c:if>
								<%-- <div class="col-xs-12 btn-group-sm">
									<button data="${Recourse.id}" type="button" class="deleteBtn btn btn-primary">删除</button>
									
									<button data="${Recourse.id}" type="button"
										class="info btn btn-primary">详情</button>
									<c:if test="${Recourse.sourceId==''}">
									<a 
										class="btn btn-success" href="${cbasePath}topic/updateTopicForm?topicid=${Recourse.topicId}">
										关联群组 </a>
									<button data="${Recourse.id}" type="button" class="deleteBtn btn btn-primary">关联群组</button>
									</c:if>
									 
								</div> --%>

							</div>
						</div>
					</c:forEach>
					<nav> <!-- 分页开始 -->
					<ul class="pagination">
					<pageNation:PageNation currPage="${usertransnworklist.data.result.size+1}"
							totalPages="${usertransnworklist.data.result.totalpage}" perPageRows="10"
							totalRows="${usertransnworklist.data.result.total}"
							linkBaseUrl="${cbasePath}usertransnwork/transnworklist?id=">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>
				</c:if>
			</div>
		</div>
		
		<!-- Modal -->
		<!-- Modal -->
	</div>
	<script>
		$(function() {
			/* $("#searchIt").click(function(){
				window.location.href = "${cbasePath}user/userList?keyword="+encodeURI($("#keyword").val());
			}); */
			
			$(".deleteBtn").click(function(){
				if(window.confirm('你确定要删除吗？')){
					//alert("${cbasePath}dry/deleteDry?dryid="+$(this).attr("data"));
					window.location.href="${cbasePath}topic/deleteTopic?topicid="+$(this).attr("data");
				}else{
					
				}
			}); 
			
			
			$(".info")
			.click(
					function() {
						 
							//alert("info");
							window.location.href = "${cbasePath}topic/topicDetail?topicid="
									+ $(this).attr("data");
						 
					});
			
		});
	</script>
</body>
</html>

