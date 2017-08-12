<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<title>留言反馈</title>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-留言反馈</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="5%">序号</th>
						<th width="5%">订单编号</th>
						<th width="8%">订单名称</th>
						<th width="5%">联系人姓名</th>
						<th width="8%">联系人电话</th>
						<th width="8%">时间</th>
						<th width="25%">留言内容</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="Order">
						<tr>
							<td align="center">${key.count}</td>
							<td align="center">${Order.orderId}</td>
							<td align="center">${Order.meeting}</td>
							<td align="center">${Order.name}</td>
							<td align="center">${Order.mobile}</td>
							<td align="center"><Date:date value="${Order.time}"></Date:date></td>
							<td align="center">${Order.message}</td>
						</tr>
					</c:forEach> 
					
				</tbody>
			</table>
			<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${list.data.result.size+1}"
								totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
								totalRows="${list.data.result.total}"
								linkBaseUrl="feedbackOrderPager?1=1">
						</pageNation:PageNation>
					</ul>
          </nav><!-- 分页结束 -->
		</div>
	</div>
<script type="text/javascript">
$(function(){
	setMenu();
	
});
function setMenu() {//或者自己设定导航逻辑
	var str = '<span>反馈列表</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}
</script>
</body>
</html>