<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<c:choose>
	<c:when test="${pager.total>0}">
		<div class="table-list">
                <table width="100%" border="1" bordercolor="#D2D4D7" cellspacing="0" id="mytable">
                    <thead>
                        <tr>
                            <th width="20%">时间</th>
                            <th width="10%">添加人</th>
                            <th>内容</th>
                        </tr>
                    </thead>
                    <tbody id="add_journal_list" class="add_journal_list">
                    	<c:forEach items="${pager.datas}" varStatus="key" var="serviceLog">
							<tr>
	                            <td align="center"><Date:date value="${serviceLog.time}"></Date:date></td>
	                            <td align="center">${serviceLog.ossusername}</td>
	                            <td align="left" style="text-align:left; padding:0px 20px;">${serviceLog.info}</td>
                            </tr>
					    </c:forEach>
                    </tbody>
                </table> 	
            </div> 
	<!--page start-->
    <div  class="page">
    	<div class="pageset">共<span class="totalpage">${pager.totalpage}</span>页共<span class="totalmsg">${pager.total}</span>条数据</div>
		<div class="pageurl">
			<c:choose>
				<c:when test="${pager.size==1}">
					  <b class="page_prev"></b>  
				</c:when>
				<c:otherwise>
					<b class="page_prev_hover pager" index="${pager.size-1}"></b> 
				</c:otherwise>
			</c:choose>
			<c:forEach items="${pager.navPagerNumbers}" varStatus="key" var="pageNumber">
				<c:choose>
					<c:when test="${pageNumber==pager.size}">
						<span class="page_hover">${pageNumber}</span>
					</c:when>
					<c:otherwise>
						<span class="pager" index="${pageNumber}">${pageNumber}</span>
					</c:otherwise>
				</c:choose>
				
			</c:forEach>
			<c:choose>
				<c:when test="${pager.size==pager.totalpage}">
					<b class="page_next"></b>
				</c:when>
				<c:otherwise>
					<b class="page_next_hover pager" index="${pager.size+1}"></b>
				</c:otherwise>
			</c:choose>
	    </div>
	    
   </div>
   <!--page end-->	 
	</c:when>
	<c:otherwise>
		
	</c:otherwise>
</c:choose>
            