<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
      
          <table width="100%" cellspacing="0" id="mytable">
                <thead>
                    <tr>
                        <th width="16%">到账时间</th>
                        <c:if test="${params.cardType ==1}">
	                        <th width="16%">充值金额</th>
	                        <th width="16%">充值后余额</th>
                        </c:if>
                        <c:if test="${params.cardType ==2}">
                            <th width="16%">还款金额</th>
                            <th width="16%">剩余账单额</th>
                        </c:if>
                        <th width="16%">收款销售</th>
                        <th width="16%">OSS操作人</th>
                        <th width="16%">操作时间</th>
                    </tr>
                </thead>
                <tbody>
                     <c:forEach items="${list.data.result.datas}"
                        varStatus="key" var="list">
                        <tr>
                            <td align="center">${list.consumeTime}</td>
                            <td align="center">${list.cardMoney}</td>
                            <td align="center">${list.rechargeAfterMoney}</td>
                            <td align="center">${list.impowerName}</td>
                            <td align="center">${list.serviceType}</td>
                            <td align="center"><Date:date value="${list.time}"></Date:date></td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
             <!-- 分页开始 -->
             <div  class="page">
        <div class="pageset">共<span class="totalpage">${list.data.result.totalpage}</span>页共<span class="totalmsg">${list.data.result.total}</span>条数据</div>
        <div class="pageurl">
            <c:choose>
                <c:when test="${list.data.result.size==1}">
                      <b class="page_prev"></b>  
                </c:when>
                <c:otherwise>
                    <b class="page_prev_hover pager" index="${list.data.result.size-1}"></b> 
                </c:otherwise>
            </c:choose>
            <c:forEach items="${list.data.result.navPagerNumbers}" varStatus="key" var="pageNumber">
                <c:choose>
                    <c:when test="${pageNumber==list.data.result.size}">
                        <span class="page_hover">${pageNumber}</span>
                    </c:when>
                    <c:otherwise>
                        <span class="pager" index="${pageNumber}">${pageNumber}</span>
                    </c:otherwise>
                </c:choose>
                
            </c:forEach>
            <c:choose>
                <c:when test="${list.data.result.size==list.data.result.totalpage}">
                    <b class="page_next"></b>
                </c:when>
                <c:otherwise>
                    <b class="page_next_hover pager" index="${list.data.result.size+1}"></b>
                </c:otherwise>
            </c:choose>
        </div>
     </div>
               <!-- 分页结束 -->
      