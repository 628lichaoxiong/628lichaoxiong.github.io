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
<title>运营支撑系统OSS-搜索推荐</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<%-- <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script> --%>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/blur.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody" style="padding: 20px 35px 13px">
	   <div class="tl clear">
	        <span class="cardurl clear">
                <a href="#" onclick="addSearch()" class="op_btn btn">添加搜索推荐</a>
            </span>
           <form id="searchFrom">
             <!-- 隐藏分页数据和下拉查询的参数 -->
             <input type ="hidden" value="1" name="n" id ="n"/>
             <input type ="hidden" value="20" name="s" id ="s"/>
            </form>
        </div>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="20%">搜索编号</th>
						<th width="20%">搜索标题</th>
						<th width="10%">开始时间</th>
						<th width="10%">结束时间</th>
						<th width="8%">语种</th>
						<th width="8%">城市</th>
						<th width="20%">标签</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.id}</td>
							<td align="center">${list.showName}</td>
							<td align="center">${list.startTime}</td>
							<td align="center">${list.endTime}</td>
							<td align="center">${list.language}</td>
							<td align="center">${list.city}</td>
							<td align="center">${list.label}</td>
							<td align="center" class="cus_td">
						           <p style="position:relative;">
						          		<input type="button" class="op_btn btn" value="编辑" onclick="update(${list.id});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="删除" onclick="del(${list.id});" style="margin-left:0px;">
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
    var str = '<span>搜索推荐列表</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}

function searchMeeting(n,s){
    $("#n").val(n);
    $("#s").val(s);
    $("#searchFrom").attr("action", "${rc.contextPath}/searchRecommend/getSearchRecommendList");
    $("#searchFrom").attr("method", "GET");
    $("#searchFrom").submit(); 
}

function addSearch(){
	window.location="${rc.contextPath}/searchRecommend/toAddSearchRecommend";
}
function update(id){
	window.location="${rc.contextPath}/searchRecommend/toUpdateSearchRecommend?id="+id;
}

function del(id){
    if(confirm('你确定要删除该记录') ){
            $.ajax({
                url :'${rc.contextPath}'+"/searchRecommend/deleteSearchRecommend", 
                type : "post",
                dataType : "json",
                data : {id:id},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = '${rc.contextPath}'+"/searchRecommend/getSearchRecommendList";
                    }else{
                        alert(resonpe.msg);
                    }
                },
                error : function(data) {
                        alert("服务器异常！请稍后重试");
                }
            }); 
    }
}

</script>
</body>
</html>
