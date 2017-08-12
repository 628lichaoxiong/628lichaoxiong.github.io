<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:choose>
	<c:when test="${objj.data.result.total==0}">
		<p style="width:100%; height:auto; padding:30px; text-align:center; color:#999; font-size:12px;">
			    没有查到你想要的数据
		</p>
	</c:when>
	<c:otherwise>
		<table width="100%" cellspacing="0" id="mytable">
   <thead>
      <tr>
          <th width="6%">译员编号</th>
          <th width="6%">姓名</th>
          <th width="6%">性别</th>
          <th width="6%">年龄</th>
          <th width="8%">擅长语种</th>
          <th width="8%">位置区域</th>
          <th width="6%">服务次数</th>
          <th width="6%">手机号</th>
          <th width="6%">海外经历</th>
          <th width="10%"><span style="font-size:10px;">语言方向</span><br /><span>源语言</span></th>
          <th width="10%"><span style="font-size:10px;">语言方向</span><br /><span>目标语言</span></th>
          <th width="16%">操作</th>
      </tr>
   </thead>
    <tbody id="meetingList">
        <c:forEach items="${objj.data.result.datas}" varStatus="key" var="userReusme">
             <tr class="parent_tr">
				<td align="center" class="td_text">${userReusme.usernumber}</td>
				<td align="center" class="td_text">${userReusme.realusername}</td>
				<td align="center" class="td_text">${userReusme.sex}</td>
				<td align="center" class="td_text">${userReusme.age}</td>
				<td align="center" class="">${userReusme.language}</td>
				<td align="center" class="td_text">${userReusme.country }</td>
				<td align="center" class="td_text">${userReusme.servicetime}</td>
				<td align="center" class="td_text">${userReusme.userphonenumber}</td>
				<td align="center" class="td_text">${userReusme.othercountry}</td>
				<%-- <td align="center" class="td_text">
					<c:forEach items="${userReusme.userindestry}" varStatus="key" var="industry">
						${industry.hangye}
					</c:forEach>
				</td> --%>
				<td>
                     <div class="styled_select">
                          <select id="yyy_${userReusme.id}" name="yyy_${userReusme.id}" class="fromLan select_list">
                            <option value="中文" selected>中文</option>
                            <c:forEach items="${userReusme.arrayLanguage}" varStatus="key" var="language">
                          	 	<option value="${language}" >${language}</option>
                            </c:forEach>
                          </select>
                     </div>
                 </td>
                 <td>
                     <div class="styled_select">
                         <select id="mbyy_${userReusme.id}" name="mbyy_${userReusme.id}" class="toLan select_list">
                          <c:forEach items="${userReusme.arrayLanguage}" varStatus="key" var="language">
                          	 <option value="${language}" >${language}</option>
                          </c:forEach>
                         </select>
                     </div>
                </td>
		        <%-- <td align="center"><input type="text" value="中文" class="fromLan"/></td>
		        <c:choose>
		        	<c:when test="${fn:indexOf(userReusme.language, '/')>0 }">
		        		 <td align="center"><input type="text" value="${fn:substring(userReusme.language, 0,fn:indexOf(userReusme.language, '/'))}" class="toLan"/></td>
		        	</c:when>
		        	<c:otherwise>
		        		<td align="center"><input type="text" value="${userReusme.language}" class="toLan"/></td>
		        	</c:otherwise>
		        </c:choose> --%>
				                 
				<td align="center" class="cus_td">
					<input type="hidden" value="${userReusme.userid}" class="searchreusme reusme"/>
					<input type="button" class="op_btn btn scanDate"  value="查看档期" >
					<input type="button" class="op_btn btn add"  value="加至推送" >
				</td>
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
