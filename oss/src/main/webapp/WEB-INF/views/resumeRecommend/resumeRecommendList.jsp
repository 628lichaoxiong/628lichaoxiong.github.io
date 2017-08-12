<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ZH-cn"> 
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-首页译员推荐</title>
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

           <%--  <div class="tiaojian_wrap tr clear" style="float: right; height:30px;">
    			<div class="uboxstyle ubox_sele card_select" style="float:left; ">
    				<select id="optype" name="optype">
    				  <option value="1" <c:if test="${params.resumeRecommendName!=null}">selected</c:if>>标签名称</option>
    				</select>
    			</div>

    		    <input type="text" class="search_key" id="search_key" value="${params.search}" style="float: left; width: 140px;">
    			<input type="button" class="sub_btn" value="查找" onclick="searchMeeting()">
    		</div> --%>
		</div>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="10%">序号</th>
						<th width="10%">译员编号</th>
						<th width="10%">译员姓名</th>
						<th width="10%">昵称</th>
						<th width="10%">第一语种</th>
						<th width="10%">创建时间</th>
						<th width="20%">操作</th>
					</tr>
				</thead>
				<tbody>
				   <c:set var="length" value="${fn:length(list.data.result.datas)}"></c:set>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${key.index+1}</td>
							<td align="center">${list.usernumber}</td>
							<td align="center">${list.username}</td>
							<td align="center">${list.nickName}</td>
							<td align="center">${list.language}</td>
							<td align="center">
							    <Date:date value="${list.created}"></Date:date>
							</td>
							<td align="center" class="cus_td">
						           <p style="position:relative;">
						          <input type="hidden" name="sortNum" value="${list.sortNum}" id="sortNum">
						          <input type="hidden" name="id" value="${list.id}" id="id">
						          		<input type="button" class="op_btn btn" value="删除" onclick="deleteResumeRecommend(${list.id});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="查看详情" onclick="toDetailResumeRecommend(${list.resumeId});" style="margin-left:0px;">
						          		<c:if test="${(key.index+1) !=1}">
						          		  <input type="button" class="op_btn btn" value="上移" id="1" onclick="updateResumeRecommendSortNum(${list.id},${list.sortNum},1,event);" style="margin-left:0px;">
						          		</c:if>
						          		<c:if test="${(key.index+1) != length}">
						          		  <input type="button" class="op_btn btn" value="下移" id="2" onclick="updateResumeRecommendSortNum(${list.id},${list.sortNum},2,event);" style="margin-left:0px;">
						               </c:if>
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
							linkBaseUrl="getResumeRecommendList?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getResumeRecommendList?1=1">
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
    var str = '<span>系统标签管理</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}
function toDetailResumeRecommend(resumeId){
	window.location.href="${rc.contextPath}/user/getuserinfo?userid="+resumeId;
}

function searchMeeting(){
    var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    if(optype==1){
        var url="resumeRecommendName="+search_key;
        window.location.href="${rc.contextPath}/indexResumeRecommend/getResumeRecommendList?resumeRecommendName="+search_key+"&search="+search_key+"&url="+url;
    }
}

function deleteResumeRecommend(id){
    zdconfirm('<img src="'+'${rc.contextPath}'+'/resources/images/tishi@2x.png"','你确定要删除该记录',function(r) {
        if(r){
            $.ajax({
                url :'${rc.contextPath}'+"/indexResumeRecommend/deleteResumeRecommend", 
                type : "post",
                dataType : "json",
                data : {id:id},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = '${rc.contextPath}'+"/indexResumeRecommend/getResumeRecommendList";
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
function updateResumeRecommendSortNum(id,sortNum,flag,event){
	var that = event.srcElement;
	var $that = $(that);
	var oldSortNum=null;
	var oldId=null;
	 if(flag ==1){
		   //上移。找到当前记录的上一条记录
		 oldSortNum=$(that).parents('tr').prev().find('#sortNum').val();
		 oldId=$(that).parents('tr').prev().find('#id').val();
	   }else{
		 //x移。找到当前记录的上一条记录
		   oldId=$(that).parents('tr').next().find('#id').val();
	       oldSortNum=$(that).parents('tr').next().find('#sortNum').val();
	   } 
            $.ajax({
                url :'${rc.contextPath}'+"/indexResumeRecommend/updateResumeRecommendSortNum", 
                type : "post",
                dataType : "json",
                data : {id:id,sortNum:sortNum,oldId:oldId,oldSortNum:oldSortNum},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = '${rc.contextPath}'+"/indexResumeRecommend/getResumeRecommendList";
                    }else{
                        alert(resonpe.msg);
                    }
                },
                error : function(data) {
                        alert("服务器异常！请稍后重试");
                }
            });
}
</script>
</body>
</html>
