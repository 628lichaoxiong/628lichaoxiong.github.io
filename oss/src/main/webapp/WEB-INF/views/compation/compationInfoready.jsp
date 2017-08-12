<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="StatusName" uri="/WEB-INF/tld/transn.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-待客户确定</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/scanCalendar.css" rel="stylesheet" type="text/css" />
<style>
.table-list{ margin-bottom:20px;}
.small_title_p{ margin-bottom:10px; }
</style>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/scanCalendar.js"></script>
</head>
<body>
	<div id="jump_mask" class="jump_mask" style="display:none;"></div>
	<div id="loading"><div class="msg"></div></div>
	<div class="details_content">
    	<!-- 订单状态开始 -->
        <!-- 订单状态结束 -->
        <!-- 订单信息开始 -->
		<div class="order_information clearfix">
			<input id="payflag" type="hidden" value="${objj.data.result.payflag}">
			<input id="userid" type="hidden" name="userid" value="${objj.data.result.userid}">
            <div class="order_information_left fl">
            	<div class="order_information_left_t clearfix">
                	<h4 class="fl">订单信息</h4>
                </div>
                <div class="order_information_left_c">
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>订单编号</p>
                            <input type="text"  id="id" value="${objj.data.result.id}" readonly />
                        </div>
                        <div class="order_information_left_list fl">
                            <p>订单类型</p>
                             <c:choose>
                                <c:when test="${objj.data.result.orderType==1}">
                                    <input type="text"  value="发布" readonly />
                                </c:when>
                                <c:otherwise>
                                   <input type="text"  value="预约" readonly />
                                </c:otherwise>
                             </c:choose>
                        </div>
                        <div class="order_information_left_list fl">
                            <p>创建时间</p>
                            <input type="text"  value="<Date:date value="${objj.data.result.time}"></Date:date>" readonly />
                        </div>
                    </div>
                    <div class="list_div clearfix">
	                    <div class="order_information_left_list fl">
	                            <p>订单状态</p>
	                            <c:choose>
	                                <c:when test="${objj.data.result.isshow==1}">
	                                    <input type="text"  value="已删除" readonly />
	                                </c:when>
	                                <c:when test="${objj.data.result.deleteflag==1}">
	                                    <input type="text"  value="已取消" readonly />
	                                </c:when>
	                                <c:otherwise>
	                                    <input type="text"  value="<StatusName:StatusName value='nasha_03${objj.data.result.payflag}'></StatusName:StatusName>" readonly />
	                                </c:otherwise> 
	                        </c:choose>
	                        </div>
                        
                        <div class="order_information_left_list fl">
                            <p>服务地点</p>
                            <input type="text"  value="${objj.data.result.meetingcity}" readonly />
                        </div>
                        <div class="order_information_left_list fr">
                            <p>支付时间</p>
                            <input type="text"  value="<Date:date value="${objj.data.result.payTime}"></Date:date>" readonly />
                        </div>
                    </div>
                    
                    <div class="list_div clearfix">
                    	<div class="order_information_left_list fl">
                            <p>项目开始时间</p>
                           	<input type="text"  id="servcetimebegin" value="${fn:substring(objj.data.result.servcetimebegin, 0, 16)}"  readonly />
                    	</div>
                    	<div class="order_information_left_list fl">
                            <p>项目结束时间</p>
                           	<input type="text" id="servcetimeend" value="${fn:substring(objj.data.result.servcetimeend, 0, 16)}"  readonly  />
                    	</div>
                    	<div class="order_information_left_list fr">
                            <p>服务类型</p>
                            <div class="edit_input service_xz">
                                <input type="text" value="${objj.data.result.categoryType}" class="service_input"style="width: 290px;"  readonly />
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>联系人</p>
                            <div class="edit_input">
                                <input type="text"  value="${objj.data.result.meetinguser}" readonly />
                            </div>
                        </div>
                        <div class="order_information_left_list fl">
                            <p>联系人电话</p>
                            <div class="edit_input">
                                <input type="text"  value="${objj.data.result.meetinguserphone}" id="meetinguserphone" readonly />
                            </div>
                        </div>
                        <div class="order_information_left_list fl">
                            <p>详细地址</p>
                            <div class="edit_input">
                                <input type="text"  value="${objj.data.result.meetingaddress}" readonly />
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
	                    <div class="order_information_left_list fl" style="width: 73%;">
	                            <p>备注说明</p>
	                                <input type="text"  value="${objj.data.result.nodebook}" style="width: 890px;" readonly />
	                        </div>
                    </div>
                    </div>
            </div>
        </div>  
        <!--订单信息结束-->
          <!--译员需求开始-->
        <c:if test="${not empty askinfoList}">
            <div class="big_t">
                <h4>译员需求</h4>
            </div>
            <div class="appointment" style="padding-top: 20px;padding-left: 30px;">
                <c:forEach items="${askinfoList}" var="askinfo" varStatus="key">
                   <em>${askinfo}</em>
                   <em style="width:120px;display:inline-block;"></em>
                   <c:if test="${key.count==8}">
                    <br>   <br> 
                   </c:if>
                </c:forEach>
             </div>
         </c:if>
        <!--预约译员开始-->
        <div class="big_t">
            <h4>预约译员</h4>
        </div>
       	<div class="appointment">
        	<p class="square clearfix">
            	<span><img src="${rc.contextPath}/resources/images/square_green.png"></span>
            	<span>报名的译员</span>	
            </p>
            <!-- ajax返回已预约的译员页面片段 -->
            <div class="table-list" id="userResumeList">
            </div>
            
           <!--   <p class="square clearfix">
                <span><img src="${rc.contextPath}/resources/images/square_green.png"></span>
                <span>已报名的译员</span> 
            </p>
            ajax返回译员端已报名的译员页面片段
            <div class="table-list" id="userResumeAcceptedList">
                    
            </div>
             -->
         </div>
        <!--订单明细开始-->
        <div class="big_t">
                <h4>订单结算明细</h4>
        </div>
        <div class="order_price">
        	<div class="transn-fee">
            	<h2>翻译费用</h2>
            	<table>
            	<thead>
            		<tr>
            			<td>译员编号</td>
            			<td>姓名</td>
            			<td>语言方向</td>
            			<td>价格（元/天）</td>
            			<td>时间（天）</td>
            			<td>费用计算系数（天）</td>
            			<td>费用小计（元）</td>
            			<td>翻译费用合计（元）</td>
            		</tr>
            	</thead>
            	<tbody id="transnFee">
            		
            	</tbody>
            	</table>
            </div>
           <%--  <div class="order_price_details">
            	<div class="table-list">  
                    <table cellspacing="0" id="mytable">
                        <thead>
                            <tr>
                                <th width="6%">内容</th>
                                <th width="6%">金额</th>
                            </tr>
                        </thead>
                        <tbody id="meetingLists">
                       		<c:forEach items="${list}" varStatus="key" var="map">
								<tr>
									<td align="center">
	                                        ${map.content }
	                                </td>
	                                <td align="center">
	                                       ${map.monery }
	                                </td>
							   </tr>
			  			    </c:forEach>
                        </tbody>
                    </table>  	
                </div> --%>
                <div class="sb_price clearfix">
                    <input type="hidden" value="" name="sb_p">
                    <p>
                    <span class="fr">
                      <c:if test="${objj.data.result.redpackMoney > 0 }">
                                                 红包支付: ${objj.data.result.redpackMoney}
                      </c:if>
                     </span>
                        <span class="fr" style="color: #F23030;">${objj.data.result.totalmoney}</span>
                        <span class="fr" style="margin-right: 16px;">合计（元）:</span>
                    </p> 
                </div> 
                 <div class="sb_price">
                    <input type="hidden" value="" name="sb_p">
                    <p>
                    <span class="fr">
                      <c:if test="${objj.data.result.payMoney > 0 }">
                                                 支付宝支付: ${objj.data.result.payMoney}
                      </c:if>
                     </span>
                      <span class="fr">
	                       <c:if test="${objj.data.result.cardMoney > 0}">
	                          <c:if test="${fn:contains(objj.data.result.cardNumber,'N')}">N卡支付: ${objj.data.result.cardMoney}</c:if>
	                          <c:if test="${fn:contains(objj.data.result.cardNumber,'S')}">S卡支付: ${objj.data.result.cardMoney}</c:if>
	                      </c:if>
                       </span>
                    </p>
                </div> 
                <!-- 添加备注 -->
                <c:if test="${not empty objj.data.result.servicemoneyinfo&&objj.data.result.servicemoneyinfo!='null'}">
                	<p style="font-size:15px; color:#333;">翻译费用说明</p>
                	<div class="trans_info_notice">
                		<textarea class="trans_text_notice" readonly>${objj.data.result.servicemoneyinfo}</textarea>
                	</div> 
                </c:if>
            </div> 
        </div>
        <!--订单明细结束
        <c:choose>
        	<c:when test="${objj.data.result.payflag==1||objj.data.result.payflag==2}">
        		<c:if test="${objj.data.result.isshow!=1&&objj.data.result.deleteflag!=1}">
        			<div class="sum">
	            		<p>
	                		<input type="button" value="重新修改" id="chang_sub" class="sum_sub"   />
	            		</p>
       			   </div>
        		</c:if>
        	</c:when>
        </c:choose>
        -->
        <div class="journal">
        		<h2>订单日志</h2>
        	<!-- ajax返回日志分页列表 -->
            <div id="serviceLogList">
            
            </div>
            <!--添加日志开始-->
            <div class="big_bg_while_t">
                <h4>添加日志</h4>
            </div>
            <textarea class="add_journal" placeholder="例如：译员A临时有事不能参加本项目，换成译员B。"></textarea>
            <!--添加日志结束-->
            <div class="add_rz">
                <p>
                    <input type="button" value="添加" id="add_j" class="sum_sub" name="add_j" style="margin-top:20px;" />
                </p>
            </div>
         </div>   
         <div class="big_t">
		    <h4 class="fl">客户反馈记录</h4>
		    <a class="fl" href="javascript:;" id="addFeedBack">添加反馈</a>
		</div>
		<div class="feedback" id="feedBackResumeList">
			 
	    </div>
	     <!-- 添加反馈弹窗开始 -->
		<div class="add_feedback none">
			<div class="add_feedback_close">×</div>
			<h4>添加反馈</h4>
			<div class="table-list" id="feedBackResumeList">
		    	<table width="100%" cellspacing="0" id="mytable">
					 <thead>
			              <tr>
			                  <th width="6%">反馈人</th>
			                  <th width="6%">反馈阶段</th>
			                  <th width="12%">反馈内容</th>
			                  <th width="8%">反馈人联系方式</th>
			                  <th width="12%">处理方法</th>
			              </tr>
				     </thead>
					<tbody id="meetingList" class="add_appointment_list">
						<tr>
							<td align="center" id="userResumeName">${objj.data.result.meetinguser}</td>
							<c:choose>
								<c:when test="${objj.data.result.payflag>=3}">
									<td align="center">售后</td>
							    </c:when>
							    <c:otherwise>
							    	<td align="center">售前</td>
							    </c:otherwise>
							</c:choose>
							<td align="center">
								<div class="feedBack_edit_content_input">
		                            <input type="text" id="message" value="" placeholder="请输入反馈内容" />
		                            <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
	                            </div>
							</td>
							<td align="center">${objj.data.result.meetinguserphone}</td>
							<td align="center">
								<div class="feedBack_edit_content_input">
		                            <input type="text" id="method" value="" placeholder="请输入处理方法"  />
		                            <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
	                            </div> 
							</td>
						</tr>
					</tbody>
				</table> 
				<div class="preservation_add">
		            <p>
		                <input type="button" value="保存" id="preservation_add_submit" class="preservation_add_submit" name="preservation_add_submit" />
		            </p>
		        </div>             	
			</div>
		</div>
		<!-- 添加反馈弹窗结束-->   
	</div> 
    <input type="hidden" name="startDate" id="startDate" value="" size="100" placeholder="请选择日期" />
<script type="text/javascript">
	var ctx="${rc.contextPath}";
</script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/compationInfo.js"></script>       
<script type="text/javascript">
$(function(){
	setMenu();
	getserviceLog();
	//服务弹窗展示和选择处理
	function setMenu() {
		var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/compation/getcompationList\')">订单列表</a><b>&gt;</b><span>订单详情</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	
});
var epre  = /\S+/;
$(".add_rz").on("click","#add_j",function(){
	var info=$.trim($(".add_journal").val());
	var id=$("#id").val();
  if(!epre.test(info)){
    zdalert('<img src="${rc.contextPath}/resources/images/tishi@2x.png"','日志内容不能为空',function(r){
      return false;
    })  
  }else{
    zdconfirm('<img src="${rc.contextPath}/resources/images/tishi@2x.png"','你确认添加该日志吗',function(r){  
      if(r) {
    	  
          $.ajax({
    			type:'post',
    			url:'${rc.contextPath}/userServiceLog/addUserServiceLog',
    			data:{name:"${name}",info:info,userid:"${loginId}",serviceid:id},
    			dataType:"json",
    	        async:false,
    	        success:function(result){
    	        	if(result.status==200){
    	        		getserviceLog();
    	        	}
    	        	if(result.status==201){
    	        		zdalert('<img src="${rc.contextPath}/resources/images/tishi@2x.png"',result.msg,function(r) {
		          			if(r){
		          				return true;
		          			}
		          		})
    	        	}
    	        }
    		});
       
      }  
    });  
  }
})
function getserviceLog(){
	var id=$("#id").val();
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/userServiceLog/getUserServiceLog',
		data:{serviceid:id,n:1,s:4},
		dataType:"html",
        async:false,
        success:function(result){
        	$("#serviceLogList").html(result);
        }
	});
}
//ajax订单日志分页逻辑
$("#serviceLogList").on('click','.pager',function(){
	var id=$("#id").val();
	var n=$(this).attr("index");
	//alert(n);
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/userServiceLog/getUserServiceLog',
		data:{serviceid:id,n:n,s:4},
		dataType:"html",
        async:false,
        success:function(result){
        	$("#serviceLogList").html(result);
        }
	});
});
//重新修改方法
$("#chang_sub").click(function(){
	var id=$("#id").val();
	window.location.href="${rc.contextPath}/compation/getcompationInfo?id="+id+"&type=0"+"&isscan=1";
});
</script>
<script type="text/javascript">
var test;
$(function(){
	 $("#userResumeList").on('click','.scan',function(){
		 $("#myCalendar").remove(); 
	 	var userid=$(this).parent().find(".reusme").val();
	 	var that=$(this);
	 	$.ajax({
	 		type:'post',
	 		url:'${rc.contextPath}/resume/getCalendar',
	 		data:{userid:userid},
	 		dataType:"json",
	         success:function(result){
	         	test=result.result;
	         	console.log(test.length);
	         	console.log(test);
	         	myCalendar("startDate");
	         	$("#myCalendar").show();
	         	that.parents(".cus_td").css({"position":"relative"});
	         	that.after($("#myCalendar")); 
	         }
	 	});
	 }) 
});
</script>
</body>
</html>