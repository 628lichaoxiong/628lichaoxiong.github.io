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
<title>运营支撑系统OSS-OSS角色管理</title>
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
				<a href="#" onclick="toAddRole();" class="op_btn btn">添加角色</a>
			</span>

            <div class="tiaojian_wrap tr clear" style="float: right; height:30px;">
    			<div class="uboxstyle ubox_sele card_select" style="float:left; ">
    				<select id="optype" name="optype">
    				  <option value="2" <c:if test="${params.roleName!=null}">selected</c:if>>角色名称</option>
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
						<th width="10%">角色编号</th>
						<th width="10%">角色名称</th>
						<th width="10%">创建时间</th>
						<th width="35%">操作</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.roleId}</td>
							<td align="center">${list.roleName}</td>
							<td align="center">
							    <Date:date value="${list.created}"></Date:date>
							</td>
							<td align="center" class="cus_td">
						           <p style="position:relative;">
						          		<input type="button" class="op_btn btn" value="修改" onclick="toUpdateRole(${list.roleId});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="删除" onclick="deleteRole(${list.roleId});" style="margin-left:0px;">
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
							linkBaseUrl="getRoleList?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getRoleList?1=1">
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
    var str = '<span>OSS角色管理列表</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}
function toAddRole(){
	window.location.href="${rc.contextPath}/ossRole/toAddRole";
}
function toUpdateRole(roleId){
	window.location.href="${rc.contextPath}/ossRole/toUpdateRole?roleId="+roleId;
}

function searchMeeting(){
    var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    if(optype==1){
        var url="roleName="+search_key;
        window.location.href="${rc.contextPath}/ossRole/getRoleList?roleName="+search_key+"&search="+search_key+"&url="+url;
    }
}

function deleteRole(roleId){
    zdconfirm('<img src="'+'${rc.contextPath}'+'/resources/images/tishi@2x.png"','你确定要删除该角色',function(r) {
        if(r){
            $.ajax({
                url :'${rc.contextPath}'+"/ossRole/deleteRole", 
                type : "post",
                dataType : "json",
                data : {roleId:roleId},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = '${rc.contextPath}'+"/ossRole/getRoleList";
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
