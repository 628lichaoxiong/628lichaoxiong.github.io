<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<title>APP反馈列表</title>
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
						<th width="5%">用户昵称</th>
						<th width="8%">反馈时间</th>
						<th width="5%">设备型号</th>
						<th width="8%">客户类型</th>
						<th width="8%">反馈内容</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${fadebacklist.data.result.datas}"
						varStatus="key" var="fadeback">
						<tr>
							<td align="center">${key.count}</td>
							<td align="center">${fadeback.username}</td>
							<td align="center"><Date:date value="${fadeback.time}"></Date:date></td>
							<td align="center">${fadeback.type}</td>
							<c:choose>
								<c:when test="${empty fadeback.source||fadeback.source=='null'}">
									<td align="center">译员端</td>
								</c:when>
								<c:otherwise>
									<td align="center">${fadeback.source}</td>
								</c:otherwise>
							</c:choose>
							<td align="center">${fadeback.message}</td>
						</tr>
					</c:forEach> 
					
				</tbody>
			</table>
			<nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${fadebacklist.data.result.size+1}"
								totalPages="${fadebacklist.data.result.totalpage}" perPageRows="${fadebacklist.data.result.limit}"
								totalRows="${fadebacklist.data.result.total}"
								linkBaseUrl="getfadebacklist?1=1">
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
	var str = '<span>APP反馈列表</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}
</script>
</body>
</html>