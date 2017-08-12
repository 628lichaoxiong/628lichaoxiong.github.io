<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style type="text/css">
#gzjl_list tr td:last-child{ text-align:center;}
</style>
<c:choose>
	<c:when test="${objj.data.result.total==0}">
		<p style="width:100%; height:auto; padding:30px; text-align:center; color:#999; font-size:12px;">
			    该译员还没有订单
		</p>
	</c:when>
	<c:otherwise>
		<table width="100%" cellspacing="0">
	<thead>
		<tr>
			<th width="18%">订单编号</th>
			<th width="12%">下单时间</th>
			<th width="12%">客户手机号</th>
			<th width="12%">服务类型</th>
			<th width="12%">服务地点</th>
			<th width="12%">服务语种</th>
			<th width="12%">本次订单收入</th>
			<th width="22%">订单状态</th>
		</tr>
	</thead>
	<tbody id="gzjl_list">
	   <c:forEach items="${objj.data.result.datas}" varStatus="key" var="userOrder">
	   		<tr>
	   			<td align="center">${userOrder.serviceid}</td>
	   			<td align="center">${userOrder.time}</td>
	   			<td align="center">${userOrder.meetinguserphone}</td>
	   			<td align="center">${userOrder.categoryType}</td>
	   			<td align="center">${userOrder.meetingcity}</td>
	   			<td align="center">${userOrder.language}</td>
	   			<td align="center">${userOrder.quotePrice-userOrder.servicePrice}</td>
	   			<c:if test="${userOrder.payflag==0}">
	   				<td align="center">已提交</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==1}">
	   				<td align="center">待确认</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==2}">
	   				<td align="center">未付款</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==3}">
	   				<td align="center">预约成功</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==5}">
	   				<td align="center">已发布</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==6}">
	   				<td align="center">项目进行中</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==7}">
	   				<td align="center">待评价</td>
	   			</c:if>
	   			<c:if test="${userOrder.payflag==8}">
	   				<td align="center">已完成</td>
	   			</c:if>
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
