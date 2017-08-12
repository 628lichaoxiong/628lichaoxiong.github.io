<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-OSS用户管理</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody" style="padding: 10px 35px 13px">
		<div class="tl clear" style="height: 30px; line-height: 30px; margin-bottom: 10px;">
			<span class="cardurl" style="display:inline-block; margin-right:20px;position: relative; float: left;">
				<a href="#" onclick="toAddUser();" class="op_btn btn">添加用户</a>
			</span>

            <div class="tiaojian_wrap tr clear" style="float: right; height:30px;">
    			<div class="uboxstyle ubox_sele card_select" style="float:left; ">
    				<select id="optype" name="optype">
    				  <option value="1" <c:if test="${params.phonenumber!=null}">selected</c:if>>手机号</option>
    				  <option value="2" <c:if test="${params.username!=null}">selected</c:if>>登录名称</option>
    				  <option value="3" <c:if test="${params.name!=null}">selected</c:if>>用户名</option>
    				</select>
    			</div>

    		    <input type="text" class="search_key" id="search_key" value="${params.search}" style="float: left; width: 140px;">
    			<input type="button" class="sub_btn" value="查找" onclick="searchMeeting()">
    		</div>
		</div>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="10%">用户编号</th>
						<th width="10%">登录名称</th>
						<th width="10%">手机号</th>
						<th width="10%">用户名称</th>
						<th width="15%">用户邮箱</th>
						<th width="15%">用户角色</th>
						<th width="10%">创建时间</th>
						<th width="20%">操作</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.id}</td>
							<td align="center">${list.name}</td>
							<td align="center">${list.phonenumber}</td>
							<td align="center">${list.username}</td>
							<td align="center">${list.useremail}</td>
							<td align="center">                                                                                                                                                                                                                                                                                                                                           
							   <c:forEach items="${list.roleNameList}" varStatus="roleNamekey" var="roleNames">
                                  ${roleNames}<br/>
                               </c:forEach>
							</td>
							<td align="center">
							    <Date:date value="${list.time}"></Date:date>
							</td>
							<td align="center" class="cus_td">
						           <p style="position:relative;">
						          		<input type="button" class="op_btn btn" value="修改" onclick="toUpdateUser(${list.id});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="删除" onclick="deleteUser(${list.id});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="设置角色" onclick="setRole(${list.id});" style="margin-left:0px;">
						           </p>
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
							linkBaseUrl="getUserList?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getUserList?1=1">
					</pageNation:PageNation>
					</c:otherwise>
					</c:choose>
					</ul>
          </nav><!-- 分页结束 -->
		</div>
	</div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script type="text/javascript">

$(function(){
    setMenu();

});
function setMenu() {//或者自己设定导航逻辑
    var str = '<span>OSS用户管理列表</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}
function toAddUser(){
	window.location.href="${rc.contextPath}/ossUser/toAddUser";
}
function toUpdateUser(userId){
	window.location.href="${rc.contextPath}/ossUser/toUpdateUser?userId="+userId;
}
function setRole(userId){
	window.location.href="${rc.contextPath}/ossUser/toSetRole?userId="+userId;
}

function searchMeeting(){
    var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    if(optype==1){
        var url="phonenumber="+search_key;
        window.location.href="${rc.contextPath}/ossUser/getUserList?phonenumber="+search_key+"&search="+search_key+"&url="+url;
    }
    if(optype==2){
        var url="username="+search_key;
        window.location.href="${rc.contextPath}/ossUser/getUserList?username="+search_key+"&search="+search_key+"&url="+url;
    }
    if(optype==3){
        var url="name="+search_key;
        window.location.href="${rc.contextPath}/ossUser/getUserList?name="+search_key+"&search="+search_key+"&url="+url;
    }
}

function deleteUser(userId){
    zdconfirm('<img src="'+'${rc.contextPath}'+'/resources/images/tishi@2x.png"','你确定要删除该用户',function(r) {
        if(r){
            $.ajax({
                url :'${rc.contextPath}'+"/ossUser/deleteUser", 
                type : "post",
                dataType : "json",
                data : {userId:userId},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = '${rc.contextPath}'+"/ossUser/getUserList";
                    }else{
                        alert(resonpe.msg);
                    }
                },
                error : function(data) {
                        alert("服务器异常！请稍后重试");
                }
            });
        }
        });
    
}
</script>
</body>
</html>
