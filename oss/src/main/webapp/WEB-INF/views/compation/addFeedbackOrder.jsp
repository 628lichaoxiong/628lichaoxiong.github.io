<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-添加订单反馈</title>
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
	<div class="mainBody">
		<div class="table-list">
			 <form action="">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="5%">订单编号</th>
						<th width="5%">项目名称</th>
						<th width="8%">反馈人</th>
						<th width="5%">反馈阶段</th>
						<th width="8%">反馈内容</th>
						<th width="5%">反馈人联系方式</th>
					</tr>
				</thead>
				<tbody>
						<tr>
							<input type="hidden" id="userid" value="${feedbackOrder.userid }"/>
							<input type="hidden" id="payflag" value="${feedbackOrder.payflag}">
							<td align="center" id="orderId">${feedbackOrder.id}</td>
							<td align="center" id="meeting">${feedbackOrder.servicename}</td>
							<td align="center" id="name">${feedbackOrder.companynameslim}</td>
							<c:choose>
								<c:when test="${feedbackOrder.payflag=='0'||feedbackOrder.payflag=='1'||feedbackOrder.payflag=='2'}">
									<td align="center">售前</td>
								</c:when>
								<c:otherwise>
									<td align="center">售后</td>
								</c:otherwise>
							</c:choose>
							<td align="center"><input type="text" id="message"/></td>
							<td align="center" id="mobile">${feedbackOrder.phonenumber}</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td><input type="button" value="保存并返回" id="send_sub" name="sum_sub" onClick="sendOk();" style="padding:4px 8px; color:#fff; font-size:16px; border-radius:5px; background:#1DA1F2; border:none; cursor:pointer;" /></td>
							<td></td>
							<td></td>
						</tr>
				</tbody>
				
					
			</table>
			
			</form>
		</div>
	</div>
<script type="text/javascript">
	$(function(){
		setMenu();
	});
function setMenu() {//或者自己设定导航逻辑
	//var str = '<span>订单反馈列表</span>';
	var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/compation/getcompationList\')">订单列表</a><b>&gt;</b><span>添加订单反馈</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}
function sendOk(){
	var payflag=$("#payflag").val();
	var orderId=$("#orderId").html();
	var meeting=$("#meeting").html();
	var name=$("#name").html();
	var message=$("#message").val();
	var mobile=$("#mobile").html();
	var userid=$("#userid").val();
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/feedbackOrder/addFeedback',
		data:{payflag:payflag,orderId:orderId,meeting:meeting,name:name,message:message,mobile:mobile,userid:userid},
		dataType:"json",
        async:false,
        success:function(data){
        	if(data.status==200){
        		window.location.href="${rc.contextPath}/feedbackOrder/feedbackByOrder?id="+"${feedbackOrder.id}"+"&source=1"+"&servicename="+"${feedbackOrder.servicename}"+"&companynameslim="+"${feedbackOrder.companynameslim}"+"&payflag="+"${feedbackOrder.payflag}"+"&phonenumber="+"${feedbackOrder.phonenumber}"+"&userid="+"${feedbackOrder.userid}";
          	}else{
          		alert(data.msg);
          	}
        }
	});
}
</script>
</body>
</html>