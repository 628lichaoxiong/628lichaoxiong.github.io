<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:choose>
<c:when test="${objj.data.result.total==0}">
	<p style="width:100%; height:auto; padding:30px; text-align:center; color:#999; font-size:12px;">
			 没有反馈记录
	</p>
</c:when>
<c:otherwise>
	<div class="table-list">
	   	<table width="100%" cellspacing="0" id="mytable">
			 <thead>
	              <tr>
	                  <th width="8%">反馈时间</th>
	                  <th width="6%">反馈人</th>
	                  <th width="6%">反馈阶段</th>
	                  <th width="12%">反馈内容</th>
	                  <th width="8%">反馈人联系方式</th>
	                  <th width="10%">处理记录</th>
	              </tr>
		     </thead>
			<tbody id="meetingList" class="">
				<c:forEach items="${objj.data.result.datas}" varStatus="key" var="feedbackOrder">
					<tr class="feedback">
						<input type="hidden" value="${feedbackOrder.id}" class="feedbackId">
						<td align="center"><Date:date value="${feedbackOrder.time}"></Date:date></td>
						<td align="center">${feedbackOrder.name}</td>
						<c:choose>
							<c:when test="${feedbackOrder.payflag>=3}">
								<td align="center">售后</td>
							</c:when>
							<c:otherwise>
								<td align="center">售前</td>
							</c:otherwise>
						</c:choose>
						<td align="center">
							<p>${fn:substring(feedbackOrder.message, 0, 12)}...</p>
							<a href="javascript:;" class="look_more" style="color:#999;" >查看更多</a>
							<div class="more_content none">
								<div class="more_content_close">×</div>
								<h4>反馈内容</h4>
								<P>${feedbackOrder.message}</P>
							</div>
					   </td>
					   <td align="center">${feedbackOrder.mobile}</td>
					   <td align="center">
						<div class="feedBack_list">
							<div class="feedBack_input">
								<c:choose>
									<c:when test="${not empty feedbackOrder.method&&feedbackOrder.method!='null'}">
										<input type="text"  value="${feedbackOrder.method}" readonly />
								    </c:when>
								    <c:otherwise>
								    	<input type="text"  value="" readonly />
								    </c:otherwise>
								</c:choose>
	                            <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
	                           </div>
	                           <div class="feedBack_edit_input none">
	                           <c:choose>
	                           		<c:when test="${not empty feedbackOrder.method&&feedbackOrder.method!='null'}">
	                           				<input type="text"  placeholder="${feedbackOrder.method}" value="" />
	                           		</c:when>
	                           		<c:otherwise>
	                           			<input type="text"  placeholder="请输入处理记录" value="" />
	                           		</c:otherwise>
	                           </c:choose>
	                           
	                           	<span class="span_img_1" ></span>
	                           	<span class="span_img_2" ></span>
	                           </div>
	                        </div>   
					  </td> 
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
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
</c:otherwise>
</c:choose>
	