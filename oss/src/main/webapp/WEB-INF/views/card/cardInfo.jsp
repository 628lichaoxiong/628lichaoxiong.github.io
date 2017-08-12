<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>


<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-卡信息</title>

<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css?id=1" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/cropbox.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />

<style type="text/css">

</style>
</head>
<body style="padding:10px 65px 81px 30px;">
	<div id="jump_mask" class="jump_mask" style="display: none;"></div>
	<input  type="hidden" value="${card.data.result.yn}" id ="cardYn" name="cardYn">
	 <input  type="hidden" id ="cardInfoId" name ="cardInfoId" value="${card.data.result.cardInfoId}" />
	 <input  type="hidden" id ="cardNumber" name ="cardNumber" value="${card.data.result.cardNumber}" />
	 <input  type="hidden" id ="cardStatus" name ="cardStatus" value="${card.data.result.cardStatus}" />
	 <input  type="hidden" id ="cardType" name ="cardType" value="${card.data.result.cardType}" />
	<div class="container" >
        <div class="title">
            <h2>信息变更</h2>
            <div class="close_container">×</div>
        </div>

	    <div class="card_change">
          <form>
              <div class="card_message">
                  <div class="card-form">
                      <p>客户名称</p>
                      <input name="customerName" id="customerNameUp" value="${card.data.result.customerName}" type="text"/>
                  </div>
                  <div class="card-form">
                      <p>协议手机号</p>
                      <input  name="phonenumber" id="phonenumberUp"   value="${card.data.result.phonenumber}"  type="text"/>
                  </div>
                  <div class="card-form">
                      <p>责任销售</p>
                      <input name="salesName" id="salesNameUp" value="${card.data.result.salesName}"  type="text"/>
                  </div>
				  <div class="card-form last-form">
                      <p>关联销售工号</p>
                      <input  name="salesNumber" id="salesNumberUp" value="${card.data.result.salesNumber}"  type="text"/>
                  </div>
              </div>
              <div class="card-change">
                  <input class=" cancel" type="button" value="取消"/>
                  &nbsp;&nbsp;<input type="button" class="confirm" id="updateCardInfo" value="确认修改"/>
              </div>

          </form>
	    </div>
	</div>
	<!-- 禁用此卡 -->
	<div class="disable_card">
	<c:if test="${card.data.result.yn == 0}">
	  <div class="disable_content">
            <h2>启用此卡</h2>
            <p>
                <img src="${rc.contextPath}/resources/images/danger@2x.png" alt="">
                <span>此操作将启用此卡 , 是否继续 ?</span>
            </p>
            <p class="operation">
                <input class=" cancel" type="button" value="取 消">
                <input class="confirm confirm2" id="disableCard" type="submit" value="确 定">
            </p>
        </div>
	</c:if>
	<c:if test="${card.data.result.yn == 1}">
	  <div class="disable_content">
            <h2>禁用此卡</h2>
            <p>
                <img src="${rc.contextPath}/resources/images/danger@2x.png" alt="">
                <span>此操作将禁用此卡 , 是否继续 ?</span>
            </p>
            <p class="operation">
                <input class=" cancel" type="button" value="取 消">
                <input class="confirm confirm2" id="disableCard" type="button" value="确 定">
            </p>
        </div>
	</c:if>
	</div>
	<!-- 卡片充值 -->
	<div class="card_pay">
	   <c:if test="${card.data.result.cardType == 1}">
	      <div class="title">
            <h2>卡片充值</h2>
            <div class="close_container">×</div>
        </div>
        <div class="card_change">
          <form action="">
              <div class="card_message">
                  <div class="card-form">
                      <p>当前余额</p>
                      <input name="customerNameReag" id="customerNameReag" readonly="readonly" value="${card.data.result.balanceMoney}" type="text"/>
                  </div>
                  <div class="card-form">
                      <p>充值金额</p>
                      <input  name="addMoneyReag" id="addMoneyReag" value=""  onkeyup="value=value.replace(/[^\d]/g,'')" type="text"/>
                  </div>
                  <div class="card-form">
                      <p>收款时间</p>
                      <input name="rechargeTimeReag" id="rechargeTimeReag" type="text" value="" class="Wdate" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})"/>
                  </div>
                  <div class="card-form last-form">
                      <p>收款销售</p>
                      <input name="impowerNameReag" id="impowerNameReag" value=""  type="text"/>
                  </div>
                  <p>充值后余额：<span id="rechargeMoneyReag">0</span></p>
              </div>
              <div class="card-change">
                  <input class=" cancel" type="button" value="取消"/>
                  &nbsp;&nbsp;<input type="button" class="confirm" id="rechargeMonery" value="确认修改"/>
              </div>

          </form>
        </div>
	   </c:if>
	   <c:if test="${card.data.result.cardType == 2}">
        <div class="title">
            <h2>卡片还款</h2>
            <div class="close_container">×</div>
        </div>
        <div class="card_change">
          <form action="">
              <div class="card_message">
                  <div class="card-form">
                      <p>未还金额</p>
                      <input name="customerNameReag" id="customerNameReag" readonly="readonly" value="${card.data.result.balanceMoney}" type="text"/>
                  </div>
                  <div class="card-form">
                      <p>还款金额</p>
                      <input  name="addMoneyReag" id="addMoneyReag" value=""  onkeyup="value=value.replace(/[^\d]/g,'')" type="text"/>
                  </div>
                  <div class="card-form">
                      <p>收款时间</p>
                      <input name="rechargeTimeReag" id="rechargeTimeReag" type="text" value="" class="Wdate" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd'})"/>
                  </div>
                  <div class="card-form last-form">
                      <p>收款销售</p>
                      <input name="impowerNameReag" id="impowerNameReag" value=""  type="text"/>
                  </div>
                  <p>还款后的账单额：<span id="rechargeMoneyReag">0</span></p>
              </div>
              <div class="card-change">
                  <input class=" cancel" type="button" value="取消"/>
                  &nbsp;&nbsp;<input type="button" class="confirm" id="rechargeMonery" value="确认修改"/>
              </div>

          </form>
        </div>
       </c:if>
		
	</div>
	<div id="loading"><div class="msg"></div></div>

	<div class="card-detail">
		<em class="card-number">NO.&nbsp; ${card.data.result.cardNumber}</em>
		<c:if test="${card.data.result.yn == 0}">
		    <img src="${rc.contextPath}/resources/images/Group4@2x.png" alt="" class="card-state">
        </c:if>
		<c:if test="${card.data.result.yn == 1}">
		    <img src="${rc.contextPath}/resources/images/group_nodisable@2x.png" alt="" class="card-state">
        </c:if>
		<div class="card_state">
		     <c:if test="${card.data.result.yn == 0}">
		          <a href="javascript:;"class="edit_head edit-btn able"> 启用此卡  </a>
	            <a  id="infoUpdate" class=" edit-btn">
	                <c:choose>
	                 <c:when test="${card.data.result.cardStatus == 1}">
	                       关联销售
	                 </c:when>
	                 <c:when test="${card.data.result.cardStatus == 2}">
	                           绑定账号
	                 </c:when>
	                 <c:otherwise>
	                                    信息变更
	                 </c:otherwise>
	             </c:choose>
	            </a>
		     </c:if>
		     <c:if test="${card.data.result.yn == 1}">
		          <a href="javascript:;"class="edit_head edit-btn disable"> 禁用此卡</a>
	         <a href="javascript:;" id="infoUpdate" class="edit_head1 edit-btn">
                    <c:choose>
                     <c:when test="${card.data.result.cardStatus == 1}">
		                           关联销售
		                     </c:when>
		                     <c:when test="${card.data.result.cardStatus == 2}">
		                               绑定账号
		                     </c:when>
		                     <c:otherwise>
		                                        信息变更
		                     </c:otherwise>
		                 </c:choose>
		            </a>
	         </c:if>
		   	<c:choose>
	             <c:when test="${card.data.result.cardStatus >= 3 &&  card.data.result.yn==1}">
	                 <a href="javascript:;"id="cardReager" class="edit_head2 edit-btn" style="background:#13CE66 ">
				             <c:if test="${card.data.result.cardType == 1}">
				                                  卡片充值
				             </c:if>
				             <c:if test="${card.data.result.cardType == 2}">
				                                   卡片还款
				             </c:if>
				     </a>
	             </c:when>
	             <c:otherwise>
	                <em class="edit-btn" id="cardReager" style="background:#C2C2C2">
	                         <c:if test="${card.data.result.cardType == 1}">
	                                              卡片充值
	                         </c:if>
	                         <c:if test="${card.data.result.cardType == 2}">
	                                               卡片还款
	                         </c:if>
	                 </em>
	             </c:otherwise>
	         </c:choose>
		</div>
	</div>
	<input type="hidden" id="" value="">
	<div class="table-user table_card" style="border-radius: 2px;">
		<table width="100%" cellspacing="0" class="N_detail">
			<tr>
			  	<td>
					<span>N卡类型：</span>
					<c:choose>
						<c:when test="${card.data.result.cardType ==1}">
							<span>N卡</span>
						</c:when>
						<c:otherwise>
							<span>S卡</span>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<span>累计消费金额：</span>
					<span>${card.data.result.consumeMoney}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>客户名称：</span>
					<span>${card.data.result.customerName}</span>
				</td>
				<td>
					<span>
					   <c:if test="${card.data.result.cardType ==1}">余额：</c:if>
					   <c:if test="${card.data.result.cardType ==2}">未还款金额：</c:if>
					</span>
					<span>${card.data.result.balanceMoney}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>协议手机号：</span>
					<span>${card.data.result.phonenumber}</span>
				</td>
				<td>
					<span>已授权数量：</span>
					<span>${card.data.result.impowerCount}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>责任销售：</span>
					<span>${card.data.result.salesName}</span>
				</td>
				<td>
					<span>已完成订单数：</span>
					<span>${card.data.result.serviceTimes}</span>
				</td>
			</tr>
			<tr>
				<td>
					<span>卡片状态：</span>
					<span><transn:cardStatus value="${card.data.result.cardStatus}"></transn:cardStatus></span>
				</td>
				<td>
					<span>激活时间：</span>
					<span>  <Date:date value="${card.data.result.activateTime}"></Date:date>
					</span>
				</td>
			</tr>
			<tr>
                <td>
                    <span>开卡日期：</span>
                    <span><Date:date value="${card.data.result.time}"></Date:date></span>
                </td>
                <c:if test="${card.data.result.cardType ==2}">
	                <td>
	                    <span>上次还款日期：</span>
	                    <span><Date:date value="${card.data.result.rechargeTime}"></Date:date>
	                    </span>
	                </td>
                </c:if>
            </tr>
		</table>
	</div>
	<c:choose>
	<c:when test="${card.data.result.cardType==2}">
		<ul class="selectUL">
	            <li class="cur">S卡消费记录</li>
	            <li>S卡还款记录</li>
	            <li>S卡授权列表</li>
	     </ul> 
	</c:when>
	<c:otherwise>
		<ul class="selectUL">
	        <li class="cur">N卡消费记录</li>
	        <li>N卡充值记录</li>
	        <li>N卡授权列表</li>
	    </ul>
	</c:otherwise>
	</c:choose>
	
	<div class="tables">
		<div class="table-list" id="cardConsumeList">
       	</div>
       <div class="table-list" id="cardRechargeList" style="width: 70%; display: none;">
      </div>
      <div class="table-list" id="cardImpowerList" style="width: 70%; display: none;">
		</div>
	</div>

<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/ajaxfileupload.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/cropbox.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/editCalendar.js" charset="UTF-8"></script>
<script type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>

<script type="text/javascript">
var ctx='${rc.contextPath}';
$(function(){
    setMenu();
    //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/card/getCardInfoParams\')">N卡管理列表</a><b>&gt;</b><span>卡片详情</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
    //不是可用
    if($("#cardYn").val() ==0){
    	$("#infoUpdate").addClass('disable_update');
    }
    cardListSelect(0);
});
$(".edit_head").click(function(){
	$(".disable_card").show();
	$("#jump_mask").show();
})
$(".edit_head1").click(function(){
	$(".container").show();
	$("#jump_mask").show();
})
$(".edit_head2").click(function(){
	$(".card_pay").show();
	$("#jump_mask").show();
})
$(".close_container").click(function(){
	$(".container").hide();
	$("#jump_mask").hide();
	$(".card_pay").hide();
})
$(".cancel").click(function(){
	$(".disable_card").hide();
	$(".container").hide();
	$("#jump_mask").hide();
	$(".card_pay").hide();
})

var cardType = $('#cardType').html;
console.log(cardType);
// 确认隐藏
$(".confirm").click(function(){
	$(".disable_card").hide();
	$(".container").hide();
	$("#jump_mask").hide();
	$(".card_pay").hide();
})

 // 禁用启用卡片
$("#disableCard").click(function(){
    $.ajax({
        type:'post',
        url:'${rc.contextPath}/card/disableCard',
        data:{cardYn:$("#cardYn").val(),cardInfoId:$("#cardInfoId").val()},
        dataType:"json",
        async:false,
        success:function(result){
            if(result.status==200){
            	window.location.href="${rc.contextPath}/card/getCardInfo?cardInfoId="+$("#cardInfoId").val();
            }else{
            	zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',result.msg,function(r) {})
                return false;
            }
        },
        error:function(result){
        	alert("服务器出现异常");
        }
    });
});
 // 信息变更
$("#updateCardInfo").click(function(){
	var cardStatus =$("#cardStatus").val();
	var customerName=$.trim($("#customerNameUp").val());
	var phonenumber=$.trim($("#phonenumberUp").val());
	var salesName=$.trim($("#salesNameUp").val());
	var salesNumber=$.trim($("#salesNumberUp").val());
	if(cardStatus>1){//1待领取2待绑定3待激活4已激活未消费
        if(customerName == '' ){
               zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"客户名称必须填写",function(r) {})
               $(".container").show();
               return false;
           }
        if(phonenumber == '' ){ 
               zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"协议手机号必须填写",function(r) {})
               $(".container").show();
               return false;
           }
   }
	if(salesName == ''){
        zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"责任销售必须填写",function(r) {})
        $(".container").show();
        return false;
    }
    if(salesNumber == ''){
        zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"关联销售工号必须填写",function(r) {})
        $(".container").show();
        return false;
    }
    $.ajax({
        type:'post',
        url:'${rc.contextPath}/card/updatecardInfo',
        data:{customerName:customerName,cardInfoId:$("#cardInfoId").val()
        	,salesNumber:salesNumber,salesName:salesName,phonenumber:phonenumber},
        dataType:"json",
        async:false,
        success:function(result){
            if(result.status==200){
            	window.location.href="${rc.contextPath}/card/getCardInfo?cardInfoId="+$("#cardInfoId").val();
            }else{
            	 zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',result.msg,function(r) {})
                 $(".container").show(); 
            }
        },
        error:function(result){
        	alert("服务器异常"); 
        }
    });
});
//金额输入框失去焦点事件
$("#addMoneyReag").blur(function(){
	var cardType =$("#cardType").val();
	var currenMoney=$("#customerNameReag").val();
	var addMoney =$("#addMoneyReag").val();
	var money=null;
	if(cardType ==1){//N 卡充值
		currenMoney =parseInt(currenMoney)+parseInt(addMoney);
	}else{//s卡还款
		currenMoney =parseInt(currenMoney)-parseInt(addMoney);
	}
   $("#rechargeMoneyReag").html(currenMoney);
});  
// 充值返款
$("#rechargeMonery").click(function(){
	var cardType =$("#cardType").val();
	var customerNameReag=$.trim($("#customerNameReag").val());
	var addMoneyReag=$.trim($("#addMoneyReag").val());
	var rechargeTimeReag=$.trim($("#rechargeTimeReag").val());
	var impowerNameReag=$.trim($("#impowerNameReag").val());
	var rechargeMoneyReag=$.trim($("#rechargeMoneyReag").val());
      if(addMoneyReag == '' || addMoneyReag =='0'){
        	var message="充值金额必须大于0";
    	    if(cardType==2){//卡类型（1 N卡2 S卡）
    	    	message="返款金额必须大于0";
            }
        	 zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',message,function(r) {})
             $(".card_pay").show();
             return false;
       }
        if(rechargeTimeReag == '' ){ 
               zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"收款时间必须填写",function(r) {})
               $(".card_pay").show();
               return false;
           }
		if(impowerNameReag == ''){
	        zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"收款销售必须填写",function(r) {})
	        $(".card_pay").show();
	        return false;
	    }

    $.ajax({
        type:'post',
        url:'${rc.contextPath}/card/rechargeMonery',
        data:{monery:addMoneyReag,cardInfoId:$("#cardInfoId").val()
        	,rechargeTime:rechargeTimeReag,rechargeName:impowerNameReag},
        dataType:"json",
        async:false,
        success:function(result){
            if(result.status==200){
            	window.location.href="${rc.contextPath}/card/getCardInfo?cardInfoId="+$("#cardInfoId").val();
            }else{
            	 zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',result.msg,function(r) {})
                 $(".card_pay").show();
                 return false; 
            }
        }
    });
});


//表格切换
$(".selectUL>li").on("click",function(){
    $(this).addClass("cur").siblings().removeClass("cur");
    $(".tables>div").eq($(this).index()).show().siblings("div").hide();
    cardListSelect($(this).index());
});
var cardNumber=$("#cardNumber").val();
var type=0;//0是消费1是充值2是授权
//数据变换
function cardListSelect(n){
    var url=ctx+'/card/getCardInfoConsumeList';
    var cardList =$("#cardConsumeList");
    if(n==2){
    	url=ctx+'/card/getCardInfoImpowerList';
    	cardList =$("#cardImpowerList");
    }else if(n==1){
    	cardList =$("#cardRechargeList");
    }
    var cardType =$("#cardType").val();
    if(cardType ==2 && n==1){//如果是S卡的且n=1,则说明查询S卡的还款记录。
    	n=2;
    }
    type=n;
    //0消费1充值2还款
    $.ajax({
        type:'post',
        url:url,
        data:{cardNumber:cardNumber,type:type,cardType:$("#cardType").val()},
        dataType:"html",
        async:false,
        success:function(result){
        	cardList.html(result);
        }
    });
}
//ajax分页逻辑 
 $("#cardConsumeList").on('click','.pager',function(){
	    var n=$(this).attr("index");
	    var pageCardMethod =$("#pageCardMethod").val();
	    $.ajax({
	        type:'post',
	        url:ctx+'/card/getCardInfoConsumeList',
	        data:{cardNumber:cardNumber,n:n,type:type,cardType:$("#cardType").val()},
	        dataType:"html",
	        async:false,
	        success:function(result){
	            $("#cardConsumeList").html(result);
	        }
	    });
	});
$("#cardRechargeList").on('click','.pager',function(){
    var n=$(this).attr("index");
    $.ajax({
        type:'post',
        url:ctx+'/card/getCardInfoConsumeList',
        data:{cardNumber:cardNumber,n:n,type:type,cardType:$("#cardType").val()},
        dataType:"html",
        async:false,
        success:function(result){
            $("#cardRechargeList").html(result);
        }
    });
});
$("#cardImpowerList").on('click','.pager',function(){
    var n=$(this).attr("index");
    $.ajax({
        type:'post',
        url:ctx+'/card/getCardInfoImpowerList',
        data:{cardNumber:cardNumber,n:n,type:type,cardType:$("#cardType").val()},
        dataType:"html",
        async:false,
        success:function(result){
            $("#cardImpowerList").html(result);
        }
    });
});
</script>
</body>
</html>
