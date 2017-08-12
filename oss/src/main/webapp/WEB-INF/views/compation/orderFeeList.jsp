<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
		<c:forEach items="${objj.data.result.list}" varStatus="key" var="userReusme">
			<tr>
			        <input type="hidden" value="${userReusme.userid}" class="user_id">
          			<td>${userReusme.usernumber}</td>
          			<td>${userReusme.realusername}</td>
          			<td>${userReusme.orderLanguage}</td>
          			<td>${userReusme.orderPrice}
          				<%-- <div class="price_num_input">
                              <input type="text" class="op_btn order_input list_Orderprice fee_monery" value="${userReusme.orderPrice}" placeholder="">
                              <img src="${rc.contextPath}/resources/images/icon_edit@2x.png">
                          </div> --%>
          			</td>
          			<td class="">${days}</td>
          			<td class="transn-time">${argDate}</td>
          			<td class="fee">${userReusme.orderPrice*argDate}</td>
          			<c:if test="${key.count==1}">
          				<td rowspan="${objj.data.result.count}" class="total-fee" id="sumOrdermoney">${objj.data.result.sumMonery}</td>
          			</c:if>
          			
          	</tr>
	 </c:forEach>