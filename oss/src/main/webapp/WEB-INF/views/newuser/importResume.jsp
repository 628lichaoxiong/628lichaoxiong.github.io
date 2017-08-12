<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
                           <c:forEach
								items="${resuserList.data.result.userexperience}"
								var="Resource" varStatus="key">
								<c:if test="${Resource.userid==null}">
							<c:forEach
								items="${Resource.otherjianli}"
								var="Resource2" varStatus="key">
								<tr>
								<td></td>
								<td align="center">${key.count}</td>
								<td align="center">${Resource2.meetingname}</td>
								<td align="center">${Resource2.language}</td>
								<td align="center">${Resource2.category}</td>
								<td align="center">${Resource2.meetingfrom}</td>
								<td align="center">${Resource2.type}</td>
								<td align="center">${Resource2.jianlitime}</td>
								<%-- <td align="center"><a
							href="${cbasePath}user/deleteuserjianli?jianliid=${Resource2.id}&userid=${resuserList.data.result.userResume.userid}">
									删除</a></td> --%>
							    <td align="center"><a href="javascript:void(0);" onclick="del(${Resource2.id},${resuserList.data.result.userResume.userid});">删除</a></td>
							</tr>
							</c:forEach>
								
							</c:if>
							</c:forEach>