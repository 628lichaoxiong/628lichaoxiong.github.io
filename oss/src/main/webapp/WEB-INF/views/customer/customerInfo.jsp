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
<title>运营支撑系统OSS-客户详情</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/customer.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
        <%-- <div class="card clearfix">
        	<input type="hidden" id="companyId" value="${info.data.result.companyid}"/>
        	<c:choose>
        		<c:when test="${info.data.result.flag==1}">
        			<div class="card_left fl">
            			<img src="${info.data.result.logo}" />
            		</div>
            		<div class="card_right">
            			<p>
                			<span>${info.data.result.companyname}</span>
                    		<span><img src="${rc.contextPath}/resources/images/yes_authentication.png" /></span>
                		</p>
                		<div>
                			<span>认证通过</span>
                		</div>
            	  </div>
        		</c:when>
        		<c:when test="${info.data.result.flag==2}">
        			<div class="card_left fl">
            			<img src="${info.data.result.logo}" />
            		</div>
            		<div class="card_right">
            			<p>
                			<span>${info.data.result.companyname}</span>
                    		<span><img src="${rc.contextPath}/resources/images/no_authentication.png" /></span>
                		</p>
                		<div>
                			<span>认证未通过</span>
                		</div>
            	  </div>
        		</c:when>
        		<c:when test="${info.data.result.flag==3}">
        			<div class="card_left fl">
            			<img src="${info.data.result.logo}" />
            		</div>
            		<div class="card_right">
            			<p>
                			<span>${info.data.result.companyname}</span>
                    		<span><img src="${rc.contextPath}/resources/images/no_authentication.png" /></span>
                		</p>
                		<div>
                			<span>未认证</span><span id="authOk">认证通过</span><span id="authNo">不通过</span>
                		</div>
            	  </div>
        		</c:when>        
        	</c:choose>
        	<c:if test="${info.data.result.cardNumber !=''}">
                <p style="margin-top: 20px;font-size: 20px;">${info.data.result.cardNumber}
                    <c:if test="${info.data.result.cardStatus ==1}">(协议号)</c:if>
                    <c:if test="${info.data.result.cardStatus ==2}">(授权号)</c:if>
                </p>
            </c:if>
        </div> --%>	
        <div id="jump_mask" class="jump_mask" style="display: none;"></div>
        <!-- 禁用此卡 -->
		<div class="disable_card" id="disable_card">
		  <div class="disable_content" id="disable_content">
		  			<input type="hidden" value="" id="userState"/>
	           		<h2>禁用此用户</h2>
	           		<p>
		               <img src="${rc.contextPath}/resources/images/danger@2x.png" alt="">
		                <span>此操作将禁用此用户 , 是否继续 ?</span>
	               </p>
	                <p class="operation">
		                <input class=" cancel" type="button" value="取 消">
		                <input class="confirm confirm2" id="disableCard" type="submit" value="确 定">
	               </p>
	       </div>
		</div>
		<!-- 重置密码-->
		<div class="disable_card" id="passwd_reset">
          <div class="disable_content" id="passwd_reset_content">
                    <input type="hidden" value="" id="userState"/>
                    <h2>重置密码</h2>
                    <p>
                       <img src="${rc.contextPath}/resources/images/danger@2x.png" alt="">
                        <span>将设置用户密码为123456,是否继续?</span>
                   </p>
                    <p class="operation">
                        <input class=" cancel" type="button" value="取 消">
                        <input class="confirm confirm2" id="resetPasswd" type="submit" value="确 定">
                   </p>
           </div>
        </div>
        <div class="card-detail">
        	<input type="hidden" value="${card.data.result.info.id}" id="customerId">
			<em class="card-number">ID号：&nbsp; ${card.data.result.info.id}</em>
			<c:if test="${card.data.result.info.card_status==0}">
				<img src="${rc.contextPath}/resources/images/Group4@2x.png" alt="" class="card-state" >
				<div class="card_state">
			     <a href="javascript:;"class="edit_head edit-btn able"> 启用此用户  </a>
			     <a href="javascript:;"class="edit_passwd edit-btn able"> 重置密码  </a>
			    </div>
			</c:if>
			<c:if test="${card.data.result.info.card_status==1}">
				<img src="${rc.contextPath}/resources/images/group_nodisable@2x.png" alt="" class="card-state">
				<div class="card_state">
			     <a href="javascript:;"class="edit_head1 edit-btn rble">禁用此用户 </a>
				 <a href="javascript:;"class="edit_passwd edit-btn able"> 重置密码  </a>
			    </div>
			</c:if>
			
		</div>
		<div class="message-basic basic">
			<h3>信息概况</h3>
			<div class="table-user table_card" style="border-radius: 2px;">
				<table width="100%" cellspacing="0" class="N_detail">
					<tr>
					  	<td>
							<span>手机号：</span>
							<span>${card.data.result.info.phonenumber}</span>
						</td>
						<td>
							<span>注册时间：</span>
							<span><Date:date value="${card.data.result.info.time}"></Date:date></span>
						</td>
					</tr>
					<tr>
						<td>
							<span>总订单数：</span>
							<span>${card.data.result.info.sumbill}</span>
						</td>
						<td>
							<span>总成单数：</span>
							<span>${card.data.result.info.sumoverbill}</span>
						</td>
					</tr>
					<tr>
						<td>
							<span>总成单金额：</span>
							<span>${card.data.result.info.summonery==null?0:card.data.result.info.summonery}</span>
						</td>
						<td>
							
						</td>
					</tr>
				</table>
			</div>
		</div>
		<c:if test="${not empty card.data.result.cardInfo}">
			<div class="message-basic basic">
			<h3>卡片概况</h3>
			<div class="table-user table_card" style="border-radius: 2px;">
				<table width="100%" cellspacing="0" class="N_detail">
					<tr>
					  	<td>
							<span>卡片类型：</span>
							<c:if test="${card.data.result.cardInfo.cardType==1}">
								<span>N卡</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardType==2}">
								<span>S卡</span>
							</c:if>
						</td>
						<td>
							<c:if test="${card.data.result.cardInfo.cardType==1}">
								<span>总充值金额：</span>
								<span>${card.data.result.rechargeMonery==null?0:card.data.result.rechargeMonery}</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardType==2}">
								<span>还款金额：</span>
								<span>${card.data.result.rechargeMonery==null?0:card.data.result.rechargeMonery}</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							<span>客户名称：</span>
							<span>${card.data.result.cardInfo.customerName}</span>
						</td>
						<td>
							<span>总消费金额：</span>
							<span>${card.data.result.consumeMonery==null?0:card.data.result.consumeMonery}</span>
						</td>
					</tr>
					<tr>
						<td>
							<span>责任销售：</span>
							<span>${card.data.result.cardInfo.salesName}</span>
						</td>
						<td>
							<c:if test="${card.data.result.cardInfo.cardType==1}">
								<span>余额：</span>
								<span>${card.data.result.cardInfo.balanceMoney}</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardType==2}">
								<span>未还款金额：</span>
								<span>${card.data.result.consumeMonery-card.data.result.rechargeMonery}</span>
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							<span>激活时间：</span>
							<span><Date:date value="${card.data.result.cardInfo.activateTime}"></Date:date></span>
						</td>
						<td>
							<span>卡片支付订单数：</span>
							<span>${card.data.result.sumConsume}</span>
						</td>
					</tr>
					<tr>
						<td>
							<span>卡片状态：</span>
							<c:if test="${card.data.result.cardInfo.cardStatus==1}">
								<span>待领取</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardStatus==2}">
								<span>待绑定</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardStatus==3}">
								<span>待激活</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardStatus==4}">
								<span>已激活</span>
							</c:if>
							<c:if test="${card.data.result.cardInfo.cardStatus==5}">
								<span>已启用</span>
							</c:if>
						</td>
						<td>
							<span>已授权数量：</span>
							<span>${card.data.result.sumImpower}</span>
						</td>
					</tr>
				</table>
			</div>
		</div>
		</c:if>
		
		<div class="message-basic basic">
			<h3>邀请概况</h3>
			<div class="table-user table_card" style="border-radius: 2px;">
				<table width="100%" cellspacing="0" class="N_detail">
					<tr>
					  	<td>
							<span>邀请码：</span>
							<span>${card.data.result.info.invitation_code}</span>
						</td>
						<td>
							<span>邀请注册数：</span>
							<span>${card.data.result.countCode==null?0:card.data.result.countCode}</span>
						</td>
					</tr>
				</table>
			</div>
		</div>	
	</div>
</div>
<script type="text/javascript">
$(function(){
	/* var str = '<span>客户详情</span>';
	$('#current_pos', parent.document).html(str);
	return true; */
	setMenu();
});
function setMenu() {//或者自己设定导航逻辑
	var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/customer/getCustomerList\')">客户列表</a><b>&gt;</b><span>客户详情</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}

$(".card_state").on("click",".edit_head",function(){
	$("#disable_card").show();
	$('#disable_content h2').html('启用此用户');
	$('#disable_content span').html('此操作将启用此用户 ,是否继续 ?');
	$('#userState').val('1');
	$("#jump_mask").show();
	
});
$(".card_state").on("click",".edit_head1",function(){
	$("#disable_card").show();
	$('#disable_content h2').html('禁用此用户');
	$('#disable_content span').html('此操作将禁用此用户 ,是否继续 ?');
	$('#userState').val('0');
	$("#jump_mask").show();
});
$(".card_state").on("click",".edit_passwd",function(){
	$("#passwd_reset").show();
	$('#passwd_reset_content h2').html('重置密码');
	$('#passwd_reset_content span').html('将设置用户密码为123456,是否继续?');
	$("#jump_mask").show();
});
$(".cancel").click(function(){
	$("#jump_mask").hide();
	$("#disable_card").hide();
	$("#passwd_reset").hide();
	$('#userState').val('');
})
// 确认隐藏
$(".confirm").click(function(){
	$("#disable_card").hide();
	$("#passwd_reset").hide();
	$(".container").hide();
	$("#jump_mask").hide();
	$(".card_pay").hide();
})
$("#disableCard").click(function(){
	var state=$('#userState').val();
	var customerId = $("#customerId").val();
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/customer/setCardStatus',
		data:{customerId:customerId,state:state},
		dataType: "json",
        async:false,
        success:function(data){
        	console.log(data);
        	if(data.status==200){
        		
        		if(state==0){
        			$(".card-state").attr("src","${rc.contextPath}/resources/images/Group4@2x.png")
        			$(".card_state").html("<a href='javascript:;' class='edit_head edit-btn able'> 启用此用户   </a>"
                            +"<a href=\"javascript:;\"class=\"edit_passwd edit-btn able\"> 重置密码  </a>");
        		}
        		if(state==1){
        			$(".card-state").attr("src","${rc.contextPath}/resources/images/group_nodisable@2x.png")
        			$(".card_state").html("<a href='javascript:;'class='edit_head1 edit-btn rble'>禁用此用户 </a>"
        					 +"<a href=\"javascript:;\"class=\"edit_passwd edit-btn able\"> 重置密码  </a>");
        		}
        		$("#disable_card").hide();
        		$(".container").hide();
        		$("#jump_mask").hide();
        		$(".card_pay").hide();
        	}else{
        		alert(data.msg);
        	}
        }
	}); 
})
//重置密码
$("#resetPasswd").click(function(){
    var state=$('#userState').val();
    var customerId = $("#customerId").val();
    $.ajax({
        type:'post',
        url:'${rc.contextPath}/customer/resetPasswd',
        data:{customerId:customerId},
        dataType: "json",
        async:false,
        success:function(data){
        	$("#passwd_reset").hide();
            $(".container").hide();
            $("#jump_mask").hide();
            $(".card_pay").hide();
            if(data.status==200){
            	alert("操作成功");
            }else{
                alert(data.msg);
            }
        }
    }); 
    
})
/* //显示服务费弹窗
$(".set_service").click(function(){
	var rate=$(".service_num").html();
	var newrate=rate.substring(0,rate.length-1);
	$(".set_service_input").val(newrate);
	$(".add_user_con").show();	
})
//关闭服务费弹窗
$(".close").click(function(){
	$(this).parents(".add_user_con").hide();
})
$(".set_service_sub").click(function(){
	var customerId=$("#customerId").val();
	var rate=$(".set_service_input").val();
	var reg= /^(100|[1-9]\d|\d)$/;
	if(!reg.test(rate)){
		alert("请输入0-100之间的正整数");
		return false;
	}
	var rate1=rate/100;
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/customer/setRate',
		data:{customerId:customerId,rate:rate1},
		dataType: "json",
        async:false,
        success:function(data){
        	if(data.status==200){
        		$(".service_num").html(rate+'%');
        		$(".add_user_con").hide();
        	}else{
        		alert(data.msg);
        	}
        }
	}); 
	
})
$("#authOk").click(function(){
	var companyId=$("#companyId").val();
	var customerId=$("#customerId").val();
    if(!$(this).hasClass('disable') && confirm('确认要执行此操作吗？')) {
    	$.ajax({
    		type:'post',
    		url:'${rc.contextPath}/customer/setAuth',
    		data:{companyId:companyId,flag:1,customerId:customerId},
    		dataType: "json",
            async:false,
            success:function(data){
            	if(data.status==200){
            		alert("修改成功");           
            		window.location.reload();
            	
            	}else{
            		alert(data.msg);
            	}
            }
    	});  
    }
	
	
	
});

$("#authNo").click(function(){
	var companyId=$("#companyId").val();
	var customerId=$("#customerId").val();
	 if(!$(this).hasClass('disable') && confirm('确认要执行此操作吗？')) {
		 $.ajax({
				type:'post',
				url:'${rc.contextPath}/customer/setAuth',
				data:{companyId:companyId,flag:2,customerId:customerId},
				dataType: "json",
		        async:false,
		        success:function(data){
		        	if(data.status==200){
		        		alert("修改成功");
		        		window.location.reload();
		        	}else{
		        		alert(data.msg);
		        	}
		        }
			});  
	 }
	
});

//执照图片放大
var w = $(".zhizhao_img").width();
var oDiv = $(".zhizhao").width();
var num = 1;
$(".zhizhao").click(function(){ 
	num++;
	$(this).attr("num",num);
	if(num==2){
		w=w*2;
		$(this).find(".zhizhao_img").css({'width':w+'px','height':'auto'});	
		$(this).css({'width':w+'px','height':'auto','position':'relative'});
		$(this).find(".zhizhao_fd").css({'bottom':'10px','right':'10px'});	
		$(this).find(".zhizhao_fd").show();
	}else if(num==3){
		w=w*2;
		$(this).find(".zhizhao_img").css({'width':w+'px','height':'auto'});	
		$(this).css({'width':w+'px','height':'auto','position':'relative'});
		$(this).find(".zhizhao_fd").css({'bottom':'10px','right':'10px'});	
		$(this).find(".zhizhao_fd").hide();
	}else if(num>3){
		num=1;
		w=oDiv;
		$(this).find(".zhizhao_img").css({'width':w+'px','height':'auto'});	
		$(this).css({'width':w+'px','height':'auto','position':'relative'});
		$(this).find(".zhizhao_fd").css({'bottom':'10px','right':'10px'});	
		$(this).find(".zhizhao_fd").show();	
	}	
}) */
</script>
</body>
</html>