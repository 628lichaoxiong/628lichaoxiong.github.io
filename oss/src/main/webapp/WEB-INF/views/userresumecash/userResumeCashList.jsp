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
<title>运营支撑系统OSS-译员提现管理</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<%-- <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script> --%>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody" style="padding: 10px 35px 13px">
		<div class="tl clear" style="height: 30px; line-height: 30px; margin-bottom: 10px;">
            <div class="tiaojian_wrap tr clear" style="float: left; height:30px;padding: 0;">
    			<div class="search search1 clear" style="float:left; ">
    				<select id="optype" name="optype">
    				  <option value="1" <c:if test="${params.serviceId!=null}">selected</c:if>>订单编号</option>
    				  <option value="2" <c:if test="${params.usernumber!=null}">selected</c:if>>译员编号</option>
    				  <option value="3" <c:if test="${params.username!=null}">selected</c:if>>译员姓名</option>
    				  <option value="4" <c:if test="${params.userphonenumber!=null}">selected</c:if>>手机号</option>
    				</select>
    			</div>
    		    <input type="text" class="search_key" id="search_key" value="${params.search}" style="float: left; width: 140px;background: #fff;">	
    		</div>
    		<div class="search search1 clear">
                    <p>是否导出</p>
                    <select id="export" name="export">
                          <option value="">全部</option> 
                          <option value="0" <c:if test="${params.export=='0'}">selected</c:if>>否</option>
                          <option value="1" <c:if test="${params.export=='1'}">selected</c:if>>是</option>
                    </select>
                </div>
            <input type="button" class="sub_btn" value="查找" onclick="searchMeeting()" style="margin-top: -24px;">
    		<span class="cardurl" style="display:inline-block; margin-left:40px;">
                <a href="#" onclick="exportExcel();" class="op_btn btn">导出EXCEL</a>
            </span>
    		
		</div>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="10%">编号</th>
						<th width="10%">译员编号</th>
						<th width="10%">译员姓名</th>
						<th width="10%">译员手机号</th>
						<th width="10%">订单编号</th>
						<th width="10%">提现金额</th>
						<th width="10%">是否导出</th>
						<th width="10%">提交时间</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.id}</td>
							<td align="center">${list.usernumber}</td>
							<td align="center">${list.username}</td>
							<td align="center">${list.userphonenumber}</td>
							<td align="center">${list.serviceId}</td>
							<td align="center">${list.money}</td>
							<td align="center">
								<c:choose>
								  <c:when test="${list.export ==1}" >是</c:when>
								  <c:otherwise>否</c:otherwise>
								</c:choose>
							</td>
							<td align="center">${list.times}</td>
							<%-- <td align="center" class="cus_td">
						           <p style="position:relative;">
						          		<input type="button" class="op_btn btn" value="修改" onclick="toUpdateLabel(${list.id},${list.labelName});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="删除" onclick="deleteLabel(${list.id});" style="margin-left:0px;">
						           </p>
						    </td> --%>
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
							linkBaseUrl="getUserResumeCashList?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getUserResumeCashList?1=1">
					</pageNation:PageNation>
					</c:otherwise>
					</c:choose>
					</ul>
          </nav><!-- 分页结束 -->
		</div>
	</div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script type="text/javascript">

$(function(){
    setMenu();

});
function setMenu() {//或者自己设定导航逻辑
    var str = '<span>译员提现管理</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}
function setParam(){
	var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    var exports =$.trim($("#export").val());
    var search="export="+exports+"&";
    var url="export="+exports+"&";
    if(optype==1){
        var url=url+"serviceId="+search_key;
        search =search+"serviceId="+search_key;
    }
    if(optype==2){
        var url=url+"usernumber="+search_key;
        search=search+"usernumber="+search_key;
    }
    if(optype==3){
        var url=url+"username="+search_key;
        search=search+"username="+search_key;
    }
    if(optype==4){
        var url=url+"userphonenumber="+search_key;
        search=search+"userphonenumber="+search_key;
    }
    search =search+"&search="+search_key+"&url="+url;
    return search;
}
function exportExcel(){
	var search =setParam();
    window.location.href="${rc.contextPath}/userResumeCash/exportExcel?"+search;
}

function searchMeeting(){
	var search =setParam();
    window.location.href="${rc.contextPath}/userResumeCash/getUserResumeCashList?"+search;
}

</script>
</body>
</html>
