<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-反馈列表</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
</head>
<body>
<div id="jump_mask" class="jump_mask" style="display:none;"></div>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
	    <div class="tiaojian_wrap tr">
			<div class="uboxstyle ubox_sele">
				<select id="optype" name="optype">
				  <option value="0" <c:if test="${params.orderId!=null}">selected</c:if>>订单编号</option>
				<%--   <option value="1" <c:if test="${params.meeting!=null}">selected</c:if>>项目名称</option> --%>
				  <option value="2" <c:if test="${params.name!=null}">selected</c:if>>反馈人</option>
				</select>
			</div>
		    <input type="text" class="search_key" id="search_key" value="${params.search}">
			<input type="button" class="sub_btn" value="查找" onclick="searchMeeting()">
		</div>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="8%">订单编号</th>
						<th width="8%">反馈时间</th>
						<th width="8%">反馈人</th>
						<th width="8%">反馈阶段</th>
						<th width="12%">反馈内容</th>
						<th width="8%">反馈人联系方式</th>
						<th width="12%">操作</th>
					</tr>
				</thead>
				<tbody id="mybody">
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr class="feedback">
							<td align="center" class="orderId">${list.orderId}</td>
							<td align="center"><Date:date value="${list.time}"></Date:date></td>
							<c:choose>
								<c:when test="${list.name=='null'}">
									<td align="center" class="name"></td>
								</c:when>
								<c:otherwise>
									<td align="center" class="name">${list.name}</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
							<c:when test="${list.payflag==0||list.payflag==1||list.payflag==2}">
								<td align="center">售前</td>
							</c:when>
							<c:otherwise>
								<td align="center">售后</td>
							</c:otherwise>
							</c:choose>	
							<td align="center" >
								<p>${fn:substring(list.message, 0, 12)}...</p>
								<a href="javascript:;" class="look_more" style="color:#999;" onclick="lookMore(this);">查看更多</a>
								<div class="more_content none">
									<div class="more_content_close">×</div>
									<h4>反馈内容</h4>
									<P>${list.message}</P>
								</div>
							</td>
							<td align="center" class="mobile">${list.mobile}</td>
							<td align="center">
								<p style="width:78px; position:relative;">
								<input type="button" class="op_btn btn" value="订单详情">
								<c:if test="${list.state<2}">
									<img src="${rc.contextPath}/resources/images/icon_new@2x.png" style=" width:23px; height:auto; position:absolute; top:-5px; right:-8px;" />
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
							linkBaseUrl="allFeedbackOrder?search=${params.search}&${params.url}&url=${params.url}">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.size+1}"
							totalPages="${list.data.result.totalpage}" perPageRows="${list.data.result.limit}"
							totalRows="${list.data.result.total}"
							linkBaseUrl="allFeedbackOrder?1=1">
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
		//var str = '<span>订单反馈列表</span>';
		var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/compation/getcompationList\')">订单列表</a><b>&gt;</b><span>反馈列表</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	/* $(".op_btn").click(function(){
		var method = $(this).parents(".cus_td").prev().find(".method").val();
		var id=$(this).parents("tr").find(".id").val();
		var state=$(this).parents("tr").find(".state").val();
		$.ajax({
			type:'post',
			url:'${rc.contextPath}/feedbackOrder/changeState',
			data:{id:id,method:method,state:state},
			dataType:"json",
	        async:false,
	        success:function(data){
	        	if(data.status==200){
	          		 location.reload();
	          	}else{
	          		alert(data.msg);
	          	}
	        }
		});
	}); */
	function searchMeeting(){
		var search_key=$.trim($("#search_key").val());
		var optype=$("#optype").val();
		if(optype==0){
			var url="orderId="+search_key;
			window.location.href="${rc.contextPath}/feedbackOrder/allFeedbackOrder?orderId="+search_key+"&search="+search_key+"&url="+url;
		}
		/* if(optype==1){
			var url="meeting="+search_key;
			window.location.href="${rc.contextPath}/feedbackOrder/allFeedbackOrder?meeting="+search_key+"&search="+search_key+"&url="+url;
		} */
		if(optype==2){
			var url="name="+search_key;
			window.location.href="${rc.contextPath}/feedbackOrder/allFeedbackOrder?name="+search_key+"&search="+search_key+"&url="+url;
		}
	}
	//查看更多弹窗
	function lookMore(e){
		$(".jump_mask").show();
		$(e).next(".more_content").show();
	}
	//关闭查看更多弹窗
	$(".more_content_close").click(function(){
		$(".jump_mask").hide();
		$(this).parents(".more_content").hide();
	});
	$(".op_btn").click(function(){
		var serviceid=$(this).parents(".feedback").find(".orderId").text();
		$.ajax({
			type:'post',
			url:'${rc.contextPath}/compation/getServiceFlag',
			data:{serviceid:serviceid},
			dataType:"json",
	        async:false,
	        success:function(data){
	        	if(data.status==200){
	          		if(data.data.result.isshow==1){
	          			window.location.href="${rc.contextPath}/compation/getcompationInfo?id="+serviceid+"&type=1"+"&isscan="+data.data.result.isscan;
	          		}
	          		else if(data.data.result.deleteflag==1){
	          			window.location.href="${rc.contextPath}/compation/getcompationInfo?id="+serviceid+"&type=1"+"&isscan="+data.data.result.isscan;
	          		}
	          		else if(data.data.result.payflag==0){
	          			window.location.href="${rc.contextPath}/compation/getcompationInfo?id="+serviceid+"&type=0"+"&isscan="+data.data.result.isscan;
	          		}else{
	          			window.location.href="${rc.contextPath}/compation/getcompationInfo?id="+serviceid+"&type=1"+"&isscan="+data.data.result.isscan;
	          		}
	          	}else{
	          		zdalert('<img src="${rc.contextPath}/resources/images/tishi@2x.png"',data.msg,function(r) {
	          			if(r){
	          				return true;
	          			}
	          		})
	          	}
	        }
		});
	});
</script>
</body>
</html>