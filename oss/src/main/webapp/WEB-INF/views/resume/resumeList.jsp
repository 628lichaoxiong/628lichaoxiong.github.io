<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-译员列表</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/blur.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<div class="tl">
			<a href="${rc.contextPath}/resume/toImportResume" class="op_btn btn">批量导入译员简历</a>&nbsp&nbsp
			<a href="${rc.contextPath}/resume/toAddUserResume" class="op_btn btn">新增译员</a>
		</div>
		
		<form id="searchFrom">
             <!-- 隐藏分页数据和下拉查询的参数 -->
             <input type ="hidden" value="1" name="n" id ="n"/>
             <input type ="hidden" value="20" name="s" id ="s"/>
             <input type ="hidden" value="${params.usernumber}" name="usernumber" id ="usernumber"/>
             <input type ="hidden" value="${params.username}" name="username" id ="username"/>
             <input type ="hidden" value="${params.userphonenumber}" name="userphonenumber" id ="userphonenumber"/>
            <%-- <div class="tiaojian_wrap tr tiaojian_search clear">
	            <div class="search clear"></div>
				<div class="uboxstyle ubox_sele">
					<select id="optype" name="optype">
					  <option value="0" <c:if test="${params.usernumber!=null}">selected</c:if>>译员编号</option>
					  <option value="1" <c:if test="${params.sex!=null}">selected</c:if>>性别</option>
					  <option value="2" <c:if test="${params.language!=null}">selected</c:if>>语种</option>
					  <option value="3" <c:if test="${params.userphonenumber!=null}">selected</c:if>>手机号</option>
					</select>
				</div>
			    <input type="text" class="search" id="search" value="${params.search}">
				<input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,20)">
			</div> --%>
			<div class="tiaojian_wrap tr tiaojian_search clear">
				<div class="search clear">
					<div class="uboxstyle ubox_sele">
						<select id="optype">
						  <option value="0" <c:if test="${not empty params.username}">selected</c:if>>姓名</option>
						  <option value="1" <c:if test="${not empty params.usernumber}">selected</c:if>>译员编号</option>
						  <option value="2" <c:if test="${not empty params.userphonenumber}">selected</c:if>>手机号</option>
						</select>
					</div>
			    	<input type="text" class="search_key"   id="search" value="${params.search}" name="search">
				</div>		
				<div class="search search1 clear">
					<p>常驻地</p>
			    	<input type="text" value="${params.country}" name="country"/>
				</div>
				<div class="search search1 clear">
					<p>语种</p>
			    	<input type="text" value="${params.language}" name="language"/>
				</div> 
				<div class="search search1 clear">
					<p>性别</p>
			    	<select id="sex" name="sex">
					  <option  value="" <c:if test="${empty params.sex}">selected</c:if>>全部</option>
					  <option value="男" <c:if test="${params.sex=='男'}">selected</c:if>>男</option>
					  <option value="女" <c:if test="${params.sex=='女'}">selected</c:if>>女</option>
					</select>
				</div>
				<div class="search search1 clear">
					<p>禁用状态</p>
			    	<select id="isshow" name="isshow">
						  <option  value="" <c:if test="${empty params.isshow}">selected</c:if>>全部</option>
						  <option value="0" <c:if test="${params.isshow=='0'}">selected</c:if>>已禁用</option>
						  <option value="1" <c:if test="${params.isshow=='1'}">selected</c:if>>未禁用</option>
					</select>
				</div>				
				<input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,20)" id="search-btn">
			</div>
			<div class="sort clear">
				<div class="search search1 clear">
					<p>排序方式</p>
					<select id="order" name="order"  onchange="searchMeeting(1,20)">
		                <option value="time.desc" <c:if test="${empty params.order||params.order=='time.desc'}">selected</c:if>>创建时间倒序</option>
		                <option value="usernumber.desc" <c:if test="${params.order=='usernumber.desc'}">selected</c:if>>译员编号倒序</option>
		                <option value="age.asc" <c:if test="${params.order=='age.asc'}">selected</c:if>>年龄倒序</option>
		                <option value="sumtimes.desc" <c:if test="${params.order=='sumtimes.desc'}">selected</c:if>>服务次数倒序</option>
		                <option value="workyears+0.desc" <c:if test="${params.order=='workyears+0.desc'}">selected</c:if>>工作年限倒序</option>
		            </select>
				</div>
			</div>
		</form>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="10%">注册时间</th>
						<th width="8%">译员编号</th>
						<th width="8%">姓名</th>
						<th width="8%">手机号</th>
						<th width="8%">语种</th>
						<th width="8%">性别</th>
						<th width="8%">年龄</th>
						<th width="8%">常驻地</th>
						<th width="8%">工作年限</th>
						<th width="8%">服务次数</th>
						<th width="8%">是否禁用</th>
						<th width="8%">操作</th>
					</tr>
				</thead>
				<tbody id="tablelist_tr">
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="Resume">
						<tr>
							<td align="center"><Date:date value="${Resume.time}"></Date:date></td>
							<td align="center">${Resume.usernumber}</td>
							<td align="center">${Resume.username}</td>
							<td align="center">${Resume.userphonenumber}</td>
							<td align="center">${Resume.language}</td>
							<td align="center">${Resume.sex}</td>
							<td align="center">${Resume.age}</td>
							<td align="center">${Resume.country}</td>
							<td align="center">${Resume.workyears}</td>
							<td align="center">${Resume.servicetime+Resume.addtimes}</td>
							<td align="center">
							 <c:if test="${Resume.isshow ==0}">
							      是
							 </c:if>
							 <c:if test="${Resume.isshow ==1}">
                                                                                   否
                             </c:if>
							</td>
							<td align="center" class="cus_td">
										<input type="button" class="op_btn btn" value="查看详情" onclick="info(${Resume.userid});">
										<%-- <input type="button" class="op_btn btn" value="更新档期" onclick="change(${Resume.userid});"> --%>
						   <%--  <c:choose>
						    	<c:when test="${Resume.image!='null'}">
						    		<input type="button" class="op_btn disabled" disabled="disabled" value="上传头像" onclick="info(${Resume.userid});">
						    	</c:when>
						    	<c:otherwise>
						    		<input type="button" class="op_btn btn"  value="上传头像" onclick="info(${Resume.userid});">
						    	</c:otherwise>
						    </c:choose>	 --%>
						    </td>
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
							clickMethodName="searchMeeting">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							clickMethodName="searchMeeting">
					</pageNation:PageNation>
					</c:otherwise>
					</c:choose>
					</ul>
          </nav><!-- 分页结束 -->
		</div>
	</div>
<script type="text/javascript">
$(function(){
	setMenu();
	
});
function setMenu() {//或者自己设定导航逻辑
	var str = '<span>译员列表</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}
function searchMeeting(n,s){
    $("#n").val(n);
    $("#s").val(s);
    var search=$.trim($("#search").val());
    var optype=$("#optype").val();
    //下拉查询时，需要把其他的查询条件置为空
    if(optype==0){
    	$("#username").val(search);
    	$("#usernumber").val("");
    	$("#userphonenumber").val("");
    }
    if(optype==1){
    	$("#username").val("");
    	$("#usernumber").val(search);
    	$("#userphonenumber").val("");
    }
    if(optype==2){
    	$("#username").val("");
    	$("#usernumber").val("");
    	$("#userphonenumber").val(search);
    }
    $("#searchFrom").attr("action", "${rc.contextPath}/resume/getUserResumeList");
    $("#searchFrom").attr("method", "GET");
    $("#searchFrom").submit(); 
}
/* function searchMeeting(){
	var search_key=$.trim($("#search_key").val());
	var optype=$("#optype").val();
	if(optype==0){
		var url="usernumber="+search_key;
		window.location.href="${rc.contextPath}/resume/getUserResumeList?usernumber="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==1){
		var url="sex="+search_key;
		window.location.href="${rc.contextPath}/resume/getUserResumeList?sex="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==2){
		var url="language="+search_key;
		window.location.href="${rc.contextPath}/resume/getUserResumeList?language="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==3){
		var url="userphonenumber="+search_key;
		window.location.href="${rc.contextPath}/resume/getUserResumeList?userphonenumber="+search_key+"&search="+search_key+"&url="+url;
	}
} */
function info(id){
	window.location.href="${rc.contextPath}/user/getuserinfo?userid="+id;
}
function change(id){
	window.location.href="${rc.contextPath}/resume/toCalendar?userid="+id;
}
</script>
</body>
</html>