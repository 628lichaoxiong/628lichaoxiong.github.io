<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>

<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-用户信息</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/sele.js" charset="UTF-8"></script>
</head>
<body>
	<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<div class="tiaojian_wrap tr">
			<form method="post" action="${sourcePath}/user/userList">
			<div class="uboxstyle ubox_sele">
				<select id="optype" name="optype">
				  <option value="username" selected>姓名</option>
				  <option value="userphonenumber">手机号</option>
				  <option value="sex">性别</option>
				  <option value="language">语种</option>
				 <!--  <option value="hange">行业标签</option> -->
				 <!--  <option value="">参与任务</option> -->
				</select>
			</div>
			<input type="text" class="search_key" id="keyword" name="keyword" value="">
			<input type="submit" class="sub_btn" value="查找">
			</form>
		</div>
		<c:if test="${registType == 'username'}">
		按姓名查询结果：</br></br>
		</c:if>
		<c:if test="${registType == 'userphonenumber'}">
		按手机号查询结果：</br></br>
		</c:if>
		<c:if test="${registType == 'sex'}">
		按性别查询结果：</br></br>
		</c:if>
		<c:if test="${registType == 'language'}">
		按语言查询结果：</br></br>
		</c:if>
		<div class="table-list">
			<table width="100%" cellspacing="0">
				<thead>
					<tr>
						<th width="6%">ID编号</th>
						<th width="10%">姓名</th>
						<th width="6%">性别</th>
						<th width="6%">年龄</th>
						<th width="8%">语种</th>
						<th width="13%">注册时间</th>
						<!-- <th width="8%">参与任务数</th> -->
						<!-- <th width="13%">最近上线时间</th> -->
						<th width="8%">手机号</th>
						<!-- <th width="8%">操作</th> -->
					</tr>
				</thead>
				<tbody id="userList">
				<c:forEach items="${resuserList.data.result.datas}" varStatus="key" var="Recourse">
					<tr>
						<td align="center">${key.count}</td>
						<%-- <td align="center">${Recourse.username}</td> --%>
						<td align="center"><a href="${cbasePath}user/getuserinfo?userid=${Recourse.userid}">${Recourse.username}</a></td>
						<td align="center">${Recourse.sex}</td>
						<td align="center">${Recourse.age}</td>
						<td align="center">${Recourse.language}</td>
						<td align="center"><Date:date value="${Recourse.time}"></Date:date></td>
						<!-- <td align="center"><a href="meeting.html">4</a></td> -->
						<!-- <td align="center">2016-05-02 12:30</td> -->
						<td align="center">${Recourse.userphonenumber}</td>
						<!-- <td align="center"><a href="" onclick=" return setBlack()" data-id="11">拉黑</a></td> -->
					</tr>
					</c:forEach>
				</tbody>
			</table>
			<%-- <div id="user_page" class="page">
				<input type="hidden" name="currentPage" value="0"><!-- 当前显示页，默认1。总页数，默认1。每页显示条数，默认20 -->
				<input type="hidden" name="totalPage" value="${resuserList.data.result.totalpage}">
				<input type="hidden" name="size" value="20">
				<div class="pagego">前往 <input type="text" name="" value="" onchange=""> 页</div>
				<div class="pageurl">
					<span class="page_prev"></span>
					<span>1</span>
					<a href="#">2</a>
					<a href="#">...</a>
					<a href="#">6</a>
					<a href="#" class="page_next"></a>
				</div>
					
				<div class="pageset">共<span class="totalpage">${resuserList.data.result.totalpage}</span>页共<span class="totalmsg">${resuserList.data.result.total}</span>条数据，设置每页显示条数 <input type="text" value="20" onchange=""></div>
			</div> --%>
			<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${resuserList.data.result.size+1}"
							totalPages="${resuserList.data.result.totalpage}" perPageRows="20"
							totalRows="${resuserList.data.result.total}"
							linkBaseUrl="${cbasePath}user/userList?keyword=${keyword}&optype=${registType}">
						</pageNation:PageNation>
					</ul>

					<!-- 分页结束 --> </nav>
	</div>
<script type="text/javascript" src="${sourcePath}/resources/js/common.js"></script>
<script type="text/javascript">
<!--
	//以下函数请根据数据接口完善

	function setBlack(dom){
		if(confirm('确定要拉黑这个译员吗？')) {//拉黑
			return true;
		}
		return false;
	}
	function setMenu(){//或者自己设定导航逻辑
		var str = '<span>用户列表</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	setMenu();
//-->
</script>
</body>
</html>

