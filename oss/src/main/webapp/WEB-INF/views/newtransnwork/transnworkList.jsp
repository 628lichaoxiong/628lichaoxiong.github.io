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
<title>运营支撑系统OSS-会议列表</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet"
	type="text/css" />
<link href="${sourcePath}/resources/css/main.css" rel="stylesheet"
	type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet"
	type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet"
	type="text/css" />
	<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript"
	src="${sourcePath}/resources/js/sele.js" charset="UTF-8"></script>
	<script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
</head>
<body>
	<div id="loading">
		<div class="msg"></div>
	</div>
	<div class="mainBody">
		<div class="tiaojian_wrap tr">
		<%-- 	<div class="uboxstyle ubox_sele">
				<select id="optype" name="optype">
					<option value="keyword" selected>会议名称</option>
					<!-- <option value="">行业</option>
					<option value="">类型</option>
					<option value="">语种</option> -->
				</select>
			</div>
			<input type="text" class="search_key" id="search_key" value="">
			<input type="button" class="sub_btn" value="查找"
				onclick="searchMeeting()"> --%>
				
				<form class="form-inline" action="${sourcePath}transnwork/transnworklist"
					method="get" role="form">
					<div class="form-group">
						<label class="sr-only" for="keyword">Search:</label> <input
							class="form-control" id="keyword" name="keyword"
							placeholder="输入任务名称" value="${keyword}">
					</div>

					<button id="searchIt" type="submit" class="btn btn-default">搜索</button>
				</form>

			<div class="nav_btn">
				<a href="${sourcePath}transnwork/addtransnworkform" class="btn">创建会议</a>
			</div>
		</div>
		<div class="table-list">
			<table width="100%" cellspacing="0">
				<thead>
					<tr>
						<th width="6%">ID编号</th>
						<th width="10%">任务名称</th>
						<th width="7%">创建者</th>
						<!-- <th width="10%">创建时间</th> -->
						<th width="18%">会议时间</th>
						<th width="7%">语种</th>
						<th width="7%">类型</th>
						<th width="14%">行业</th>
						<th width="5%">来源</th>
						<th width="12%">城市</th>
						<!-- <th width="6%">报名数</th> -->
						<th width="6%">状态</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody id="meetingList">
					<c:forEach items="${transnworklist.data.result.datas}"
						varStatus="key" var="Recourse">
						<tr>
							<td align="center">${key.count}</td>
							<td align="center"><a
								href="${sourcePath}transnwork/gettransnworkinfo?transnworkid=${Recourse.id}">${Recourse.meetingname}</a></td>
							<td align="center">${Recourse.userid}</td>
							<%-- <td align="center"><Date:date value="${Recourse.time}"></Date:date></td> --%>
							<td align="center">${Recourse.meetingtime}</td>
							<td align="center">${Recourse.language}</td>
							<td align="center">${Recourse.type}</td>
							<td align="center">${Recourse.category}</td>
							<td align="center">${Recourse.meetingfrom}</td>
							<td align="center">${Recourse.address}</td>
							<!-- <td align="center"><a href="meeting_sign.html">24</a></td> -->
							<c:if test="${Recourse.flag == '0'}">
								<td align="center">正常</td>
							</c:if>
							<c:if test="${Recourse.flag != '0'}">
								<td align="center">已取消</td>
							</c:if>
							<c:if test="${Recourse.flag == '0'}">
								<td align="center"><a
									href="${sourcePath}transnwork/deletetransnwork?id=${Recourse.id}"  onclick="return makeDown(this)">取消</a>
									&nbsp&nbsp<a
									href="${sourcePath}usertransnwork/getusertransnworklist?transnworkid=${Recourse.id}&meetingname=${Recourse.meetingname}">审核</a></td>
							</c:if>
							<c:if test="${Recourse.flag != '0'}">
								<td align="center">
									<span style="color:#999; margin-right:6px; background:none; border:none;" >取消</span>
									<!-- <input type="button" class="disabled"value="取消" onclick="return makeDown(this)"> -->
									<%-- <a href="${sourcePath}usertransnwork/getusertransnworklist?transnworkid=${Recourse.id}&meetingname=${Recourse.meetingname}">审核</a> --%>
									<span style="color:#999; margin-right:6px; background:none; border:none;">审核</span>
								</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<%-- <div id="meeting_page" class="page">
				<input type="hidden" name="currentPage" value="1">
				<!-- 当前显示页，默认1。总页数，默认1。每页显示条数，默认20 -->
				<input type="hidden" name="totalPage" value="1"> <input
					type="hidden" name="size" value="20">
				<div class="pagego">
					前往 <input type="text" name="" value=""
						onchange="getPageList(this, this.value, 'loadMeetingList')">
					页
				</div>
				<div class="pageurl"></div>
				<div class="pageset">
					共<span class="totalpage">0</span>页共<span class="totalmsg">0</span>条数据，设置每页显示条数
					<input type="text" value="20"
						onchange="setPageSize(this, this.value, 'loadMeetingList')">
				</div>
			</div> --%>

			<nav> <!-- 分页开始 -->
			<ul class="pagination">
				<pageNation:PageNation
					currPage="${transnworklist.data.result.size+1}"
					totalPages="${transnworklist.data.result.totalpage}"
					perPageRows="20" totalRows="${transnworklist.data.result.total}"
					linkBaseUrl="${sourcePath}transnwork/transnworklist?id=">
				</pageNation:PageNation>
			</ul>

			<!-- 分页结束 --> </nav>
		</div>
	</div>
	<script type="text/javascript"
		src="${sourcePath}/resources/js/common.js"></script>
	<script type="text/javascript">
	<!--
		//以下函数请根据数据接口完善
		var loading = false;
		pageInfoInit('#meeting_page');
		function loadMeetingList() {
			if (loading == true)
				return;
			var pageArr = getPageInfo('#meeting_page').split('|');
			var currentPage = pageArr[0];
			var totalPage = pageArr[1];
			var size = pageArr[2];

			if (currentPage > totalPage)
				return;
			$("#loading").show(); // 显示加载器
			loading = true;//标记开始加载

			//获取列表并显示
			//$.post('', { size: size, page: currentPage},
			//function(msg){
			$("#loading").hide(); //隐藏加载器

			totalPage = 6;
			totalmsg = 10;//信息总条数

			// 生成HTML
			var str = '';
			$('#meetingList').html(str);
			if (totalPage > 1) {
				if (currentPage == 1) {
					$('#meeting_page').find('.totalmsg').html(totalmsg);
					$('#meeting_page').find('.totalpage').html(totalPage);
				}
				var pagestr = showPage('#meeting_page', totalPage, currentPage,
						'loadMeetingList');//显示分页跳转
				$('#meeting_page').find('input[name="totalPage"]').val(
						totalPage);
				$('#meeting_page').find('.pageurl').empty().html(pagestr);
			} else if (totalPage == 1) {
				$('#meeting_page').hide();
			}
			currentPage++;
			$('#meeting_page').find('input[name="currentPage"]').val(
					currentPage);
			loading = false;//ajax加载完毕重置
			//});
		}

		function searchMeeting() {
			var type = $('#optype').val();
			var key = $('#search_key').val();

			//查找数据....
			$('#meeting_page').find('input[name="currentPage"]').val(1);
			$('#meeting_page').find('input[name="totalPage"]').val(1);
			$('#meeting_page').find('input[name="size"]').val(20);
		}
		function setMenu() {//或者自己设定导航逻辑
			var str = '<span>会议列表</span>';
			$('#current_pos', parent.document).html(str);
			return true;
		}

		function makeDown(dom){//下架
		    if(!$(dom).hasClass('disable') && confirm('如果执行取消操作，则此条会议在app发现中将不可见，确认要执行此操作吗？')) {
		      return true;
		    }
		    return false;
		  }

		setMenu();
	//-->
	</script>
</body>
</html>

