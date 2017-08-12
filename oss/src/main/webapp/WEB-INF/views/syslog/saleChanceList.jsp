<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-销售机会管理</title>
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
	<div class="mainBody" style="padding: 10px 35px 13px">
		<div class="tl clear" style="height: 30px; line-height: 30px; margin-bottom: 10px;">
			<%--<span class="cardurl" style="display:inline-block; margin-right:20px;position: relative; float: left;">
				<a href="#" onclick="countCards()" class="op_btn btn">卡片数据</a>
				<a href="#" onclick="cardManager()" class="op_btn btn">生成卡片</a>
				<a href="#" onclick="getNewCardInfoParams()" class="op_btn btn">新卡管理</a>
			</span>
			  --%>

            <div class="tiaojian_wrap tr clear" style="float: right; height:30px;">
    			<div class="uboxstyle ubox_sele card_select" style="float:left; ">
    				<select id="optype" name="optype">
    				  <option value="1" <c:if test="${params.userName !=null}">selected</c:if>>手机号</option>
    				</select>
    			</div>
				
    		     <input type="text" class="search_key" id="search_key" value="${params.search}" style="float: left; width: 140px;">
    			<input type="button" class="sub_btn" value="查找" onclick="searchMeeting()">
    		</div>
		</div>

		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="10%">手机号</th>
						<th width="10%">创建时间</th>
						<th width="8%">操作类型</th>
						<th width="8%">客户订单数</th>
						<th width="8%">完成订单数</th>
						<th width="42%">操作描述</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.userName}</td>
							<td align="center">
                             <Date:date value="${list.created}"></Date:date>
                            </td>
							<td align="center">
							<c:if test="${list.type ==2}">发布</c:if>
							<c:if test="${list.type ==3}">预约</c:if>
							</td>
							<td align="center">${list.userType}</td>
							<td align="center">${list.businessId}</td>
							<td align="center">${list.resultTxt}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			 <nav> <!-- 分页开始 -->
					<ul class="pagination">
					<c:choose>
					<c:when test="${not empty params.url}">
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getSaleChanceList?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getSaleChanceList?1=1">
					</pageNation:PageNation>
					</c:otherwise>
					</c:choose>
					</ul>
          </nav><!-- 分页结束 -->
		</div>
	</div>

<script type="text/javascript">

$(function(){
    setMenu();

});
function setMenu() {//或者自己设定导航逻辑
    var str = '<span>销售机会管理</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}

function searchMeeting(){
    var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    if(optype==1){
        var url="userName="+search_key;
        window.location.href="${rc.contextPath}/sysLog/getSaleChanceList?userName="+search_key+"&search="+search_key+"&url="+url;
    }
    
}
</script>
</body>
</html>
