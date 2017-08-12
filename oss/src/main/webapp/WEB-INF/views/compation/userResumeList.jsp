<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
	<table width="100%" cellspacing="0" id="mytable">
					 <thead>
                        <tr>
                            <th width="8%">译员编号</th>
                            <th width="6%">姓名</th>
                            <th width="6%">性别</th>
                            <th width="6%">年龄</th>
                            <th width="8%">位置区域</th>
                            <th width="6%">服务次数</th>
                            <th width="6%">手机号</th>
                            <th width="6%">海外经历</th>
                            <th width="10%">语言方向</th>
                            <th width="10%">报价</th>
                            <th width="10%">修改前价</th>
                            <th width="10%">客户选中</th>
                            <th width="10%">操作</th>
                        </tr>
                    </thead>
					<tbody id="add_appointment_list" class="add_appointment_list">
					<input type="hidden" value="${objj.data.result.count}" id="resumeCount">
					<c:forEach items="${objj.data.result.list}" varStatus="key" var="userReusme">
						<tr class="userResumeList_tr">
							<td align="center">${userReusme.usernumber}</td>
							<td align="center">${userReusme.realusername}</td>
							<td align="center">${userReusme.sex}</td>
							<td align="center">${userReusme.age}</td>
							<td align="center">${userReusme.country }</td>
							<td align="center">${userReusme.servicetime}</td>
							<td align="center">${userReusme.userphonenumber}</td>
							<td align="center">${userReusme.othercountry}</td>
	                        <td align="center">${userReusme.orderLanguage}</td>
	                        <td align="center" class="orderPrice">${userReusme.orderPrice}</td>
	                        <td align="center" class="oldPrice">${userReusme.oldPrice}</td>
	                        <td align="center" >
	                          <c:choose>
                                   <c:when test="${userReusme.customerStatus ==1}">
                                                                                            是
                                   </c:when>
                                   <c:otherwise>否</c:otherwise>
                               </c:choose>  
	                        </td>
							<td align="center" class="cus_td">
								<input type="hidden" value="${userReusme.userid}" class="reusme"/>
								<input type="button" class="op_btn btn scan"  value="查看档期" >
								<c:if test="${type == 0}">
									<input type="button" class="op_btn btn updatePrice" value="修改成本价" >
									<input type="button" class="op_btn btn delete" value="删除" >
								</c:if>
							</td>
						</tr>	
					</c:forEach> 			
				</tbody>
	</table> 
	