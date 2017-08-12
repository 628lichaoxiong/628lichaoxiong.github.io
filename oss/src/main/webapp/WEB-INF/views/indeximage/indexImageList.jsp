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
<title>运营支撑系统OSS-轮播管理</title>
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
				<a href="#" onclick="toAddIndexImage();" class="op_btn btn">添加轮播</a>
			</span>

            <div class="tiaojian_wrap tr clear" style="float: right; height:30px;">
    			<div class="uboxstyle ubox_sele card_select" style="float:left; ">
    				<select id="optype" name="optype">
    				  <option value="1" <c:if test="${params.imageName!=null}">selected</c:if>>轮播名称</option>
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
						<th width="8%">轮播编号</th>
						<th width="8%">轮播类型</th>
						<th width="8%">跳转类型</th>
						<th width="10%">轮播名称</th>
						<th width="10%">轮播图片</th>
						<th width="10%">专题图片</th>
						<th width="10%">搜索编号</th>
						<th width="15%">跳转地址</th>
						<th width="10%">创建时间</th>
						<th width="20%">操作</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.id}</td>
							<td align="center">
							  <c:if test="${list.type ==1}">红包轮播</c:if>
							  <c:if test="${list.type ==2}">客户端首页轮播</c:if>
							  <c:if test="${list.type ==3}">译员端首页轮播</c:if>
							</td>
							<td align="center">
                              <c:if test="${list.urlType ==0}">链接</c:if>
                              <c:if test="${list.urlType ==1}">专题</c:if>
                            </td>
							<td align="center">${list.imageName}</td>
							<td align="center">
							  <c:choose>
								<c:when test="${not empty list.imageUrl}">
								  <img src="${list.imageUrl}" width="60" height="60" alt="无图片" />
								</c:when>
							    <c:otherwise> 
							                 无图片
							    </c:otherwise>
							 </c:choose>
			                </td>
			                <td align="center">
                              <c:choose>
                                <c:when test="${not empty list.imageSubjectUrl}">
                                  <img src="${list.imageSubjectUrl}" width="60" height="60" alt="无图片" />
                                </c:when>
                                <c:otherwise> 
                                                                无图片
                                </c:otherwise>
                             </c:choose>
                            </td>
                            <td align="center">${list.serarchId}</td>
							<td align="center">${list.skipUrl}</td>
							<td align="center">
							    <Date:date value="${list.created}"></Date:date>
							</td>
							<td align="center" class="cus_td">
						           <p style="position:relative;">
						          		<input type="button" class="op_btn btn" value="修改" onclick="toUpdateIndexImage(${list.id});" style="margin-left:0px;">
						          		<input type="button" class="op_btn btn" value="删除" onclick="deleteIndexImage(${list.id});" style="margin-left:0px;">
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
							linkBaseUrl="getIndexImageList?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="getIndexImageList?1=1">
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
    var str = '<span>轮播管理列表</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}
function toAddIndexImage(){
	window.location.href="${rc.contextPath}/indexImage/toAddIndexImage";
}
function toUpdateIndexImage(id){
	window.location.href="${rc.contextPath}/indexImage/toUpdateIndexImage?id="+id;
}

function searchMeeting(){
    var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    if(optype==1){
        var url="imageName="+search_key;
        window.location.href="${rc.contextPath}/indexImage/getIndexImageList?imageName="+search_key+"&search="+search_key+"&url="+url;
    }
}

function deleteIndexImage(id){
    zdconfirm('<img src="'+'${rc.contextPath}'+'/resources/images/tishi@2x.png"','你确定要删除该轮播',function(r) {
        if(r){
            $.ajax({
                url :'${rc.contextPath}'+"/indexImage/deleteIndexImage", 
                type : "post",
                dataType : "json",
                data : {id:id},
                success : function(resonpe) {
                    if (resonpe.status == 200) {
                        //修改成功
                        alert("操作成功！");
                        window.location.href = '${rc.contextPath}'+"/indexImage/getIndexImageList";
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
