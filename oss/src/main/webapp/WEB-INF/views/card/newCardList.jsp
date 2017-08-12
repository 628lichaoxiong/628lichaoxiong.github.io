<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-N卡管理</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body style="padding:20px 0 0 30px">
<div id="loading"><div class="msg"></div></div>
	<!-- <div class="mainBody">
        <div class="new_count clear">
            <p>
                未绑定N卡：<span>234</span>张
            </p>
            <p>
                未绑定S卡：<span>456</span>张
            </p>
        </div>
         -->
        <ul class="new_state clear">
            <li>
                <input type="checkbox" id="first" name="first" value="1" <c:if test="${params.first =='1'}">checked="checked"</c:if> >
                N卡
            </li>
            <li>
                <input type="checkbox" id="second"name="second" value="2" <c:if test="${params.second =='2'}">checked="checked"</c:if> >
                S卡
            </li>
            <li>
                <input type="checkbox" id="three" name="three" value="3" <c:if test="${params.three =='3'}">checked="checked"</c:if> >
                已领取
            </li>
            <li>
                <input type="checkbox" id="four" name="four" value="4" <c:if test="${params.four =='4'}">checked="checked"</c:if> >
                待领取
            </li>
            <li>
                <input type="button" id="searchMeeting" onclick="searchMeeting();" value="搜索">
            </li>
        </ul>
		<div class="new-table">
			 <table width="100%" cellspacing="0" border="1px" borderColor="#D2D4D7">
				<thead>
					<tr>
						<th width="22%">卡号</th>
						<th width="22%">创建时间</th>
						<th width="13%">卡片类型</th>
						<th width="15%">卡片状态</th>
						<th width="14%">销售名称</th>
						<th width="14%">创建者</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list.data.result.datas}"
                        varStatus="key" var="list">
					<tr>
					   <td>${list.cardNumber}</td>
					   <td><Date:date value="${list.time}"></Date:date></td>
					   <td><c:if test="${list.cardType ==1}">
                                        N卡
                              </c:if>
                              <c:if test="${list.cardType ==2}">
                                        S卡
                              </c:if>
                       </td>
					   <td><transn:cardStatus value="${list.cardStatus}"></transn:cardStatus></td>
					   <td>${list.salesName}</td>
					   <td>${list.ossUserId}</td>
					</tr>
                </c:forEach>
                    
			</table>
			 <nav> <!-- 分页开始 -->
					<ul class="pagination">
					<c:choose>
					<c:when test="${not empty params.url}">
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getNewCardInfoParams?first=${params.first}&second=${params.second}&three=${params.three}&four=${params.four}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getNewCardInfoParams?1=1&first=${params.first}&second=${params.second}&three=${params.three}&four=${params.four}">
					</pageNation:PageNation>
					</c:otherwise>
					</c:choose>
					</ul>
          </nav><!-- 分页结束 -->
		</div>

<script type="text/javascript">

$(function(){
    setMenu();
  //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/card/getCardInfoParams\')">N卡管理列表</a><b>&gt;</b><span>新卡管理</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
});
function setParams(){
	 var first,second,three,four='0';
     first=$("#first:checked").attr("value");
     if(first == undefined){
    	 first='0';
     }
     second=$("#second:checked").attr("value");
     if(second ==undefined){
    	 second='0';
     }
     three=$("#three:checked").attr("value");
     if(three ==undefined){
    	 three='0';
     }
     four=$("#four:checked").attr("value");
     if(four ==undefined){
    	 four='0';
     }
     return "first="+first+"&second="+second+"&three="+three+"&four="+four;
}
function searchMeeting(){
        window.location.href="${rc.contextPath}/card/getNewCardInfoParams"
        +"?"+setParams();
}
</script>
</body>
</html>
