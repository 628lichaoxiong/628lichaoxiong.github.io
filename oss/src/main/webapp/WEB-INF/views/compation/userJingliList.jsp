<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style type="text/css">
#gzjl_list tr td:last-child{ text-align:left;}
</style>
<c:choose>
	<c:when test="${objj.data.result.total==0}">
		<p style="width:100%; height:auto; padding:30px; text-align:center; color:#999; font-size:12px;">
			    该译员还没有工作经历
		</p>
	</c:when>
	<c:otherwise>
		<table width="100%" cellspacing="0">
	<thead>
		<tr>
			<th width="18%">序号</th>
			<th width="20%">工作时间</th>
			<th>工作内容</th>
		</tr>
	</thead>
	<tbody id="gzjl_list">
	   <c:forEach items="${objj.data.result.datas}" varStatus="key" var="userjingli">
	   		<tr>
	   			<td align="center">${key.count}</td>
	   		    <c:set value="${ fn:split(userjingli.meetingname, '#') }" var="meetings" />
	   		    <c:forEach items="${meetings}" var="meeting">
					<td align="center">${meeting}</td>
				</c:forEach>
	   		</tr>
	   </c:forEach>
	</tbody>
	</table>
<!--page start-->
    <div  class="page">
    	<div class="pageset">共<span class="totalpage">${objj.data.result.totalpage}</span>页共<span class="totalmsg">${objj.data.result.total}</span>条数据</div>
		<div class="pageurl">
			<c:choose>
				<c:when test="${objj.data.result.size==1}">
					  <b class="page_prev"></b>  
				</c:when>
				<c:otherwise>
					<b class="page_prev_hover pager" index="${objj.data.result.size-1}"></b> 
				</c:otherwise>
			</c:choose>
			<c:forEach items="${objj.data.result.navPagerNumbers}" varStatus="key" var="pageNumber">
				<c:choose>
					<c:when test="${pageNumber==objj.data.result.size}">
						<span class="page_hover">${pageNumber}</span>
					</c:when>
					<c:otherwise>
						<span class="pager" index="${pageNumber}">${pageNumber}</span>
					</c:otherwise>
				</c:choose>
				
			</c:forEach>
			<c:choose>
				<c:when test="${objj.data.result.size==objj.data.result.totalpage}">
					<b class="page_next"></b>
				</c:when>
				<c:otherwise>
					<b class="page_next_hover pager" index="${objj.data.result.size+1}"></b>
				</c:otherwise>
			</c:choose>
	    </div>
	    
   </div>
   <!--page end-->	
	</c:otherwise>
</c:choose>
