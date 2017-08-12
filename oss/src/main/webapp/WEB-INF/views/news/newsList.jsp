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
<title>运营支撑系统OSS-文章管理</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/news.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/blur.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody" style="padding: 20px 35px 13px">
		<div class="tl clear">
			<span class="cardurl clear">
				<a href="#" onclick="addNews()" class="btn">添加新闻动态</a>
				<a href="#" onclick="addActivity()" class="btn">添加活动</a>
			</span>
        <form id="searchFrom">
             <!-- 隐藏分页数据和下拉查询的参数 -->
             <input type ="hidden" value="1" name="n" id ="n"/>
	         <input type ="hidden" value="20" name="s" id ="s"/>
    		<div class="tiaojian_wrap tr tiaojian_search clear">
				<div class="search clear">
					<label><input name="isActivity" type="checkbox" value="${params.isActivity}" class="activity_button"/>首页活动 </label> 
				</div>		
				<div class="search search1 clear">
					<label><input name="isRecommend" type="checkbox" value="${params.isRecommend }" class="recommend_button"/>推荐位 </label> 
				</div>
				<div class="search search1 clear">
					<label><input name="isUp" type="checkbox" value="${params.isUp }" class="top_button"/>置顶 </label> 
				</div>
				<div class="search search1 clear">
					<p>文章类型</p>
			    	<select  name="type">
						  <option value="" <c:if test="${empty params.type}">selected</c:if>>全部</option>
						  <option value="1" <c:if test="${params.type==1}">selected</c:if>>新闻动态</option>
						  <option value="2" <c:if test="${params.type==2}">selected</c:if>>活动</option>
					</select>
				</div>
				<div class="search search1 clear">
					<p>搜索标题</p>
			    	<input type="text" name="title" placeholder="输入关键字" value="${params.title}"/>
				</div>				
				<input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,10)" id="search-btn">
			</div>
    	 </form>
		</div>

		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="5%">编号</th>
						<th width="22%">文章标题</th>
						<th width="10%">文章类型</th>
						<th width="10%">首页活动</th>
						<th width="9%">推荐位</th>
						<th width="10%">列表置顶</th>
						<th width="14%">创建时间</th>
						<th width="20%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${objj.data.result.datas}" varStatus="key" var="news">
						<tr>
							<input type="hidden" value="${news.id}" >
							<td align="center">${key.count}</td>
							<td align="center" class="title">${news.title}</td>
							<c:if test="${news.type==1 }">
								<td align="center">新闻动态</td>
							</c:if>
							<c:if test="${news.type==2}">
								<td align="center">活动</td>
							</c:if>
							<c:if test="${news.isActivity==0 }">
								<td align="center">否</td>
							</c:if>
							<c:if test="${news.isActivity==1 }">
								<td align="center">是</td>
							</c:if>
							<c:if test="${news.isRecommend==0 }">
								<td align="center">否</td>
							</c:if>
							<c:if test="${news.isRecommend==1 }">
								<td align="center">是</td>
							</c:if>
							<c:if test="${news.isUp==0 }">
								<td align="center">否</td>
							</c:if>
							<c:if test="${news.isUp==1 }">
								<td align="center">是</td>
							</c:if>
							<td align="center"><Date:date value="${news.createTime}"></Date:date></td>
							<td align="center">
								<button class="look">查看</button>
								<button class="edit">编辑</button>
								<button class="delete">删除</button>	
                            </td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			 <nav> <!-- 分页开始 -->
					<ul class="pagination">
						<pageNation:PageNation currPage="${objj.data.result.size+1}"
								totalPages="${objj.data.result.totalpage}" perPageRows="${objj.data.result.limit}"
								totalRows="${objj.data.result.total}"
								clickMethodName="searchMeeting">
						</pageNation:PageNation>
					</ul>
          </nav><!-- 分页结束 -->
		</div>
	</div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script type="text/javascript">
$(function(){
    setMenu();
	if($(".activity_button").val()==1){
		$('.activity_button').prop("checked",true); 
	}
	if($(".recommend_button").val()==1){
		$('.recommend_button').prop("checked",true); 
	}
	if($(".top_button").val()==1){
		$('.top_button').prop("checked",true); 
	}
});
function setMenu() {//或者自己设定导航逻辑
    var str = '<a>官网管理</a><b>></b><span>文章管理</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}
var activity,recommend,top;
function searchMeeting(n,s){
	 $("#n").val(n);
	 $("#s").val(s);
	//首页活动
	if($('.activity_button').is(':checked')) {
		$(".activity_button").val("1");
	}
	//推荐位
	if($('.recommend_button').is(':checked')) {
		$(".recommend_button").val("1");
	}
	//置顶
	if($('.top_button').is(':checked')) {
		$(".top_button").val("1");
	}
    $("#searchFrom").attr("action", "${rc.contextPath}/ossNews/getNewsList");
    $("#searchFrom").attr("method", "GET");
    $("#searchFrom").submit(); 
}
//添加新闻动态
function addNews(){
	window.location="${rc.contextPath}/ossNews/toArticleNews";
}
//添加活动
function addActivity(){
	window.location="${rc.contextPath}/ossNews/toActivityNews";
}

//查看
$('#mytable').on('click','.look',function(){
	
})
//编辑
$('#mytable').on('click','.edit',function(){
	var id = $(this).parents('tr').find('input').val();
	/*  $.ajax({
	        type:'post',
	        url:'${rc.contextPath}/ossNews/editNews',
	        data:{id:id},
	        dataType:"html",
	        async:false,
	        success:function(result){
	            $("#serviceLogList").html(result);
	        }
	   }); */
	   window.location.href="${rc.contextPath}/ossNews/editNews?id="+id
})
//删除
$('#mytable').on('click','.delete',function(){
	var that = $(this);
	var id = $(this).parents('tr').find('input').val();
	zdconfirm('<img src="'+'${rc.contextPath}'+'/resources/images/tishi@2x.png"','你确定要删除该用户',function(r) {
        if(r){
            $.ajax({
                url :"${rc.contextPath}/ossNews/deleteNews", 
                type : "post",
                dataType : "json",
                data : {id:id},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                    	that.parents('tr').remove();
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
})
</script>
</body>
</html>