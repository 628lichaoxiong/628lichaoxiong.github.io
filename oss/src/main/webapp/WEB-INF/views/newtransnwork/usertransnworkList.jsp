<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>



<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-报名列表</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet"
	type="text/css" />
<link href="${sourcePath}/resources/css/main.css" rel="stylesheet"
	type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet"
	type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet"
	type="text/css" />
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/sele.js" charset="UTF-8"></script>
</head>
<body>
	<div id="loading">
		<div class="msg"></div>
	</div>
	<div class="mainBody">
		<div class="tiaojian_wrap tr">
			<div class="nav_btn">
			 <a href="${cbasePath}usertransnwork/checkusertransnwork?transnworkid=${transnworkid}&flag=2&meetingname=${meetingname}">
				<input type="button" class="btn" value="一键拒绝未审核用户" onclick="">
				</a>
			</div>
		</div>
		<div class="table-list">
			<table width="100%" cellspacing="0">
				<thead>
					<tr>
						<th width="8%">ID编号</th>
						<th width="13%">姓名</th>
						<th width="8%">性别</th>
						<th width="8%">手机号</th>
						<th width="8%">年龄</th>
						<th width="8%">城市</th>
						<th width="8%">报价</th>
							<th width="13%">审核状态</th>
						<th width="13%">操作</th>
					</tr>
				</thead>
				
				<tbody id="signList">
					<c:forEach items="${usertransnworklist.data.result.datas}"
						varStatus="key" var="Recourse">
						<tr>
							<td align="center">${key.count}</td>
							<td align="center"><a
								href="${sourcePath}user/getuserinfo?userid=${Recourse.user.userid}">${Recourse.user.username}</a></td>
							<td align="center">${Recourse.user.sex}</td>
							<td align="center">${Recourse.user.userphonenumber}</td>
							<td align="center">${Recourse.user.age}</td>
							<td align="center">${Recourse.user.country}</td>
							<td align="center">${Recourse.baominguser.money}</td>
							<c:if test="${Recourse.flag == '0'}">	
								<td align="center">未审核</td></c:if>
								<c:if test="${Recourse.flag == '1'}">	
								<td align="center"><font color="green">审核通过</font></td></c:if>
								<c:if test="${Recourse.flag == '2'}">	
								<td align="center"><font color="red">未通过</font></td>
								</c:if>
							
							<td align="center"><a
								href="${sourcePath}usertransnwork/checkusertransnwork?userid=${Recourse.user.userid}&transnworkid=${Recourse.transnwork.id}&flag=1&usertransnworkid=${Recourse.id}">通过</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
								href="${sourcePath}usertransnwork/checkusertransnwork?userid=${Recourse.user.userid}&transnworkid=${Recourse.transnwork.id}&flag=2&usertransnworkid=${Recourse.id}">不通过</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<%-- <div id="sign_page" class="page">
				<input type="hidden" name="currentPage" value="1">
				<!-- 当前显示页，默认1。总页数，默认1。每页显示条数，默认20 -->
				<input type="hidden" name="totalPage" value="1"> <input
					type="hidden" name="size" value="20">
				<div class="pagego">
					前往 <input type="text" name="" value=""
						onchange="getPageList(this, this.value, 'loadSignList')">
					页
				</div>
				<div class="pageurl">
					<span class="page_prev"></span> <span>1</span> <a href="#">2</a> <a
						href="#">3</a> <a href="#">...</a> <a href="#">6</a> <a href="#"
						class="page_next"></a>
				</div>
				<div class="pageset">
					共<span class="totalpage">0</span>页共<span class="totalmsg">0</span>条数据，设置每页显示条数
					<input type="text" value="20"
						onchange="setPageSize(this, this.value, 'loadSignList')">
				</div>
			</div> --%>
			
			<nav> <!-- 分页开始 -->
					<ul class="pagination">
					<pageNation:PageNation currPage="${usertransnworklist.data.result.size+1}"
							totalPages="${usertransnworklist.data.result.totalpage}" perPageRows="20"
							totalRows="${usertransnworklist.data.result.total}"
							linkBaseUrl="${cbasePath}usertransnwork/transnworklist?id=">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>
		</div>
	</div>
	<script type="text/javascript"
		src="${sourcePath}/resources/js/common.js"></script>
	<script type="text/javascript">
	<!--
		function setMenu() {//或者自己设定导航逻辑
			var str = '<a href="javascript:;" onclick="url_jump(\'${sourcePath}transnwork/transnworklist\')">会议列表</a><b>&gt;</b><span>${meetingname}</span>';
			$('#current_pos', parent.document).html(str);
			return true;
		}
		setMenu();
	//-->
	</script>
</body>
</html>

