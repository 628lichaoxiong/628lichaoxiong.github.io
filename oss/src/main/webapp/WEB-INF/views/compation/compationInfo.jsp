<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
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
<body >
	<div id="jump_mask" class="jump_mask" style="display:none;"></div>
	<div id="loading"><div class="msg"></div></div>
    <form id="formID">
	<div class="details_content">
    	<!-- 订单状态开始 -->
    	<div class="order_status">
    		<c:choose>
				<c:when test="${objj.data.result.isshow==1}">
					<img src="${rc.contextPath}/resources/images/delete@2x.png" width="120" height="120" />
                    <p>客户已删除</p> 
				</c:when>
				<c:when test="${objj.data.result.deleteflag==1}">
					<img src="${rc.contextPath}/resources/images/cancel@2x.png" width="120" height="120" />
                    <p>客户已取消</p>
				</c:when>
				<c:when test="${objj.data.result.payflag==0}">
				    <img src="${rc.contextPath}/resources/images/clipboard@2x.png" width="120" height="120" />
                    <p>客户已提交</p>
				</c:when>
				<c:when test="${objj.data.result.payflag==1}">
					<img src="${rc.contextPath}/resources/images/confirm@2x.png" class="daiqueren" width="342" height="120" />
                    <p>客服已发送详细需求，待客户确认</p>
				</c:when>
				<c:when test="${objj.data.result.payflag==2}">
					<img src="${rc.contextPath}/resources/images/nopay@3x.png" class="daiqueren" width="342" height="120" />
                    <p>客服已确认，待付款</p>
				</c:when>
				<c:when test="${objj.data.result.payflag==3}">
					<img src="${rc.contextPath}/resources/images/get-money@2x.png" width="120" height="120" />
                    <p>客户已付款</p>
				</c:when>
				<c:when test="${objj.data.result.payflag==5}">
                    <img src="${rc.contextPath}/resources/images/customer-send@2x.png" width="120" height="120" />
                    <p>客户已发布</p>
                </c:when>
			</c:choose>	  
        </div>
        <!-- 订单状态结束 -->
        <!-- 订单信息开始 -->
		<div class="order_information clearfix">
			<input id="type" type="hidden" value="${type}">
			<input id="unitCost" name="unitCost" type="hidden">
			<input id="payflag" type="hidden" value="${objj.data.result.payflag}">
			<input id="orderType" name="orderType"  type="hidden" value="${objj.data.result.orderType}">
			<input id="userid" type="hidden" name="userid" value="${objj.data.result.userid}">
			<input id="servicemoney" type="hidden" name="servicemoney" >
            <div class="order_information_left fl">
            	<div class="order_information_left_t clearfix">
                	<h4 class="fl">订单信息</h4>
                </div>
                <div class="order_information_left_c">
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>订单编号</p>
                            <input type="text" name="id" id="id" value="${objj.data.result.id}" readonly />
                        </div>
                        <div class="order_information_left_list fr">
                            <p>服务类型</p>
                            <div class="edit_input service_xz">
                                <input type="text" name="serviceType" value="${objj.data.result.serviceType}" class="service_input" readonly />
                                <img src="${rc.contextPath}/resources/images/icon_drop@2x.png" />
                            </div>
                            <div class="service_edit">
                            	<ol>
                                	<li>
                                    	<p>生活陪同</p>
                                        <div class="service_list">
                                        	<span alt="购物">购物</span>
                                            <span alt="旅游">旅游</span>
                                            <span alt="聚会">聚会</span>
                                            <span alt="展会">展会</span>
                                            <span alt="就医">就医</span>
                                            <span alt="生活陪同-其他">其他</span>
                                        </div>
                                    </li>
                                    <li>
                                        <p>技术陪同</p>
                                        <div class="service_list">
                                            <span alt="技术交流">技术交流</span>
                                            <span alt="设备安装">设备安装</span>
                                            <span alt="工作考察">技术考察</span>
                                            <span alt="参观">参观</span>
                                            <span alt="工作会谈">工作会谈</span>
                                            <span alt="商务陪同-其他">其他</span>
                                        </div>
                                    </li>
                                    <li>
                                    	<p>商务陪同</p>
                                        <div class="service_list">
                                        	<span alt="商务谈判">商务谈判</span>
                                            <span alt="培训授课">培训授课</span>
                                            <span alt="会晤谈判">会晤谈判</span>
                                            <span alt="商务活动">商务活动</span>
                                            <span alt="商务陪同-其他">其他</span>
                                        </div>
                                    </li>
                                    <li>
                                    	<p>项目现场服务</p>
                                        <div class="service_list">
                                        	<span alt="技术支持">技术支持</span>
                                            <span alt="行政辅助">行政辅助</span>
                                            <span alt="私人助理">私人助理</span>
                                            <span alt="运维协同">运维协同</span>
                                        </div>
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>创建时间</p>
                            <input type="text" name="time" value="<Date:date value="${objj.data.result.time}"></Date:date>" readonly />
                        </div>
                        <div class="order_information_left_list fr">
                            <%-- <p>企业简称</p>
                            <c:choose>
                            	<c:when test="${empty objj.data.result.companyName|| objj.data.result.companyName=='null'}">
                            		 <input type="text"  name="companyName" value="" readonly />
                            	</c:when>
                            	<c:otherwise>
                            		<input type="text"  name="companyName" value="${objj.data.result.companyName}" readonly />
                            	</c:otherwise>
                            </c:choose> --%>
                            <p>业务类型</p>
                            <c:choose>
                                <c:when test="${objj.data.result.businessType ==1}">
                                     <input type="text"   value="陪同" readonly />
                                </c:when>
                                <c:otherwise>
                                    <input type="text"   value="" readonly />
                                </c:otherwise>
                            </c:choose>
                           
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>服务地点</p>
                            <div class="edit_input">
                            <input type="text" name="meetingcity" value="${objj.data.result.meetingcity}" />
                            <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
                            </div>
                        </div>
                        <div class="order_information_left_list fr">
                            <p>订单状态</p>
                            <c:choose>
								<c:when test="${objj.data.result.isshow==1}">
									<input type="hidden" name="isshow"  value="1"/>
									<input type="text"  value="已删除" readonly />
								</c:when>
								<c:when test="${objj.data.result.deleteflag==1}">
									<input type="hidden" name="deleteflag"  value="1"/>
									<input type="text"  value="已取消" readonly />
								</c:when>
								<c:when test="${objj.data.result.payflag==0}">
									<input type="hidden" name="payflag"  value="0"/>
									<input type="text"  value="已提交" readonly />
								</c:when>
								<c:when test="${objj.data.result.payflag==1}">
									<input type="hidden" name="payflag"  value="1"/>
									<input type="text"  value="待确认" readonly />
								</c:when>
								<c:when test="${objj.data.result.payflag==2}">
									<input type="hidden" name="payflag"  value="2"/>
									<input type="text"  value="待付款" readonly />
								</c:when>
								<c:when test="${objj.data.result.payflag==3}">
									<input type="hidden" name="payflag"  value="3"/>
									<input type="text"  value="已完成" readonly />
								</c:when>
								<c:when test="${objj.data.result.payflag==5}">
                                    <input type="hidden" name="payflag"  value="5"/>
                                    <input type="text"  value="已发布" readonly />
                                </c:when>
						</c:choose>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>发票状态</p>
                            <c:choose>
								<c:when test="${not empty objj.data.result.youjiaddress&&objj.data.result.youjiaddress!='null'}">
									<input type="text"  value="已邮寄" readonly />
								</c:when>
								<c:otherwise>
								    <input type="text"  value="待邮寄" readonly />
								</c:otherwise>
						   </c:choose>
                        </div>
                        <div class="order_information_left_list fr">
                            <p>译员人数</p>
                            <input type="text" id="peoplenumber" name="peoplenumber" readonly />
                        </div>
                    </div>
                    <div class="calendar_lst clearfix">
                    	<div class="order_information_left_list fl">
                            <p>项目开始时间</p>
                           	<%-- <input type="text" name="servcetimebegin" id="servcetimebegin" value="${fn:substring(objj.data.result.servcetimebegin, 0, 10)}" class="Wdate"  onClick="WdatePicker()" readonly /> --%>
                           	<input type="text" name="servcetimebegin" id="servcetimebegin" value="${fn:substring(objj.data.result.servcetimebegin, 0, 16)}" class="Wdate" readonly onClick="WdatePicker()" />
                    	</div>
                    	<div class="order_information_left_list fr">
                            <p>项目结束时间</p>
                           <%-- 	<input type="text" name="servcetimeend" id="servcetimeend" value="${fn:substring(objj.data.result.servcetimeend, 0, 10)}" class="Wdate" onClick="WdatePicker()" readonly  /> --%>
                           	<input type="text" name="servcetimeend" id="servcetimeend" value="${fn:substring(objj.data.result.servcetimeend, 0, 16)}" class="Wdate"  readonly onClick="WdatePicker()" />
                    	</div>
                    </div>
                </div>
            </div>
            <div class="order_information_right fr">
            	<div class="order_information_left_t clearfix">
                	<h4 class="fl">订单信息</h4>
                </div>
                <div class="order_information_left_c">
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>联系人</p>
                            <div class="edit_input">
                                <input type="text" name="meetinguser" value="${objj.data.result.meetinguser}" />
                                <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
                            </div>
                        </div>
                        <div class="order_information_left_list fr">
                            <p>联系人电话</p>
                            <div class="edit_input">
                                <input type="text" name="meetinguserphone" value="${objj.data.result.meetinguserphone}" id="meetinguserphone"/>
                                <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>详细地址</p>
                            <div class="edit_input">
                                <input type="text" name="meetingaddress" value="${objj.data.result.meetingaddress}" />
                                <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
                            </div>
                        </div>
                        <div class="order_information_left_list fr">
                            <p>需要签证</p>
                            <div class="styled-select-1">
                                <select name="isSign">
                                    <c:choose>
										<c:when test="${objj.data.result.isSign=='是'}">
											<option value="是" selected="selected">是</option>
											<option value="否" >否</option>
										</c:when>
										<c:otherwise>
											<option value="是" >是</option>
											<option value="否" selected="selected">否</option>
										</c:otherwise>
									</c:choose>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>提供住宿</p>
                            <div class="styled-select-1">
                                <select name="isLiveandfeed">
                                    <c:choose>
										<c:when test="${objj.data.result.isLiveandfeed=='是'}">
											<option value="是" selected="selected">是</option>
											<option value="否" >否</option>
										</c:when>
										<c:otherwise>
											<option value="是" >是</option>
											<option value="否" selected="selected">否</option>
										</c:otherwise>
									</c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="order_information_left_list fr">
                            <p>提供保险</p>
                            <div class="styled-select-1">
                                <select name="isInsurance">
                                    <c:choose>
										<c:when test="${objj.data.result.isInsurance=='是'}">
											<option value="是" selected="selected">是</option>
											<option value="否" >否</option>
										</c:when>
										<c:otherwise>
											<option value="是" >是</option>
											<option value="否" selected="selected">否</option>
										</c:otherwise>
									</c:choose>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>提供通勤车</p>
                            <div class="styled-select-1">
                                <select name="isTraffic">
                                    <c:choose>
										<c:when test="${objj.data.result.isTraffic=='是'}">
											<option value="是" selected="selected">是</option>
											<option value="否" >否</option>
										</c:when>
										<c:otherwise>
											<option value="是" >是</option>
											<option value="否" selected="selected">否</option>
										</c:otherwise>
									</c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="order_information_left_list fr">
                            <p>提供工作餐</p>
                            <div class="styled-select-1">
                                <select name="isSafe">
                                    <c:choose>
										<c:when test="${objj.data.result.isSafe=='是'}">
											<option value="是" selected="selected">是</option>
											<option value="否" >否</option>
										</c:when>
										<c:otherwise>
											<option value="是" >是</option>
											<option value="否" selected="selected">否</option>
										</c:otherwise>
									</c:choose>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                        <p>备注说明</p>
                        <div class="edit_input" style="width:92%;">
                            <input type="text" name="nodebook" value="${objj.data.result.nodebook}" style=" width:100%;" maxlength="50"/>
                            <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
                        </div> 
                    </div>
                </div>
            </div>
        </div>  
        <div class="list_div clear" style="margin-bottom: 25px; border: 1px solid #D2D4D7; padding: 15px 0;">
            <p style="text-align: center; font-size: 14px; color: #333; margin-bottom: 10px;">如果修改了以上信息，请先保存然后再添加译员</p>
            <input type="button" value="保存信息" id="save_send_sub" class="sum_sub" name="save_send_sub" style="cursor: pointer;"/>
        </div>
        <!--订单信息结束-->
           <!--译员需求开始-->
        <c:if test="${not empty askinfoList}">
            <input type="hidden" value="true" id="havaAskinfo"/>
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
            	<span>已推送的译员</span>	
            </p>
            <!-- ajax返回已预约的译员页面片段 -->
            <div class="table-list" id="userResumeList">
                	
            </div>
            
            <p class="square clearfix">
                <span><img src="${rc.contextPath}/resources/images/square_green.png"></span>
                <span>已报名的译员</span> 
            </p>
            <!-- ajax返回译员端已报名的译员页面片段 -->
            <div class="table-list" id="userResumeAcceptedList">
                    
            </div>
            
            <p class="square clearfix">
            	<span><img src="${rc.contextPath}/resources/images/square_green.png"></span>
            	<span>添加译员</span>	
            </p>
            <div class="clearfix">
                <div class="tiaojian_wrap tl fl">
                    <div class="uboxstyle ubox_sele">
                        <select id="optype" name="optype">
                           <option value="1" selected="selected">译员编号</option>
				 		   <option value="2">手机号</option>
				 		   <option value="3">姓名</option>
				 		   <option value="4">语种</option>
                        </select>
                    </div>
                    <input type="text" class="search_key" id="search_key" value="">
                    <input type="button" class="sub_btn" value="查找" id="searchMeeting">
                </div>
                <div class="tr fr">
                	<a href="javascript:;" class="clickchange"><img src="${rc.contextPath}/resources/images/change_none.png" style="width:70px; height:auto;" /></a>
                </div>
            </div>  
            <!--查找译员列表-->  
            <div class="table-list none" id="allResumeList" >
                	
            </div>
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
            <!--
            <div class="order_price_details">
            	<div class="table-list">  
                    <table cellspacing="0" id="mytable">
                        <thead>
                            <tr>
                                <th width="6%">内容</th>
                                <th width="6%">金额</th>
                                <th width="6%">操作</th>
                            </tr>
                        </thead>
                        <tbody id="meetingLists">
                            <c:choose>
                            	<c:when test="${empty list||list=='null'}">
                            		<tr>
		                                <td align="center">
		                                	<div class="price_input">
		                                        <input type="text" class="op_btn order_input" name="orderlist" value="交通" placeholder="交通" >
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                	<div class="price_num_input">
		                                        <input type="text" class="op_btn order_input list_price" name="orderlist" value="0" placeholder="">
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                    <input type="button" class="op_btn order_input last_order_input" value="删除" size="10" >
		                                </td>
                                   </tr>
		                            <tr>
		                                <td align="center">
		                                	<div class="price_input">
		                                        <input type="text" class="op_btn order_input" name="orderlist" value="住宿" placeholder="住宿" >
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                	<div class="price_num_input">
		                                        <input type="text" class="op_btn order_input list_price" name="orderlist" value="0" placeholder="">
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                    <input type="button" class="op_btn order_input last_order_input" value="删除" size="10" >
		                                </td>
		                            </tr>
		                            <tr>
		                                <td align="center">
		                                	<div class="price_input">
		                                        <input type="text" class="op_btn order_input" name="orderlist" value="餐费" placeholder="餐费" >
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                	<div class="price_num_input">
		                                        <input type="text" class="op_btn order_input list_price" name="orderlist" value="0" placeholder="">
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                    <input type="button" class="op_btn order_input last_order_input" value="删除" size="10">
		                                </td>
		                            </tr>
		                            <tr>
		                                <td align="center">
		                                	<div class="price_input">
		                                        <input type="text" class="op_btn order_input" name="orderlist" value="保险" placeholder="保险" >
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                	<div class="price_num_input">
		                                        <input type="text" class="op_btn order_input list_price" name="orderlist" value="0" placeholder="">
		                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
		                                    </div>	    
		                                </td>
		                                <td align="center">
		                                    <input type="button" class="op_btn order_input last_order_input" value="删除" size="10" >
		                                </td>
		                            </tr>
                            	</c:when>
                            	<c:otherwise>
                            		<c:forEach items="${list}" varStatus="key" var="map">
										<tr>
											<td align="center">
			                                	<div class="price_input">
			                                        <input type="text" class="op_btn order_input" name="orderlist" value="${map.content }" placeholder="${map.content }" >
			                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
			                                    </div>	    
			                                </td>
			                                <td align="center">
			                                	<div class="price_num_input">
			                                        <input type="text" class="op_btn order_input list_price" name="orderlist" value="${map.monery }" placeholder="">
			                                        <img src="${rc.contextPath}/resources/images/icon_edit@2x.png" />
			                                    </div>	    
			                                </td>
			                                <td align="center">
			                                    <input type="button" class="op_btn order_input last_order_input" value="删除" size="10" >
			                                </td>
									   </tr>
						  			</c:forEach>
                            	</c:otherwise>
                            </c:choose>
                            <tr class="last_tr" num="0">
                                <td colspan="8" style="background: #5B6F81; border: 1px solid #E3EAF4; border-radius: 0px 0px 4px 4px; color:#fff; font-size:12px; text-align:center;"><img src="${rc.contextPath}/resources/images/icon_add@2x.png" />新增一行</td>
                            </tr>				
                        </tbody>
                    </table>  	
                </div> 
                -->
                <div class="sb_price clearfix">
                    <input type="hidden" value="" name="sb_p">
                     <input type="hidden" name="startTotalmoney" id="startTotalmoney" value="${objj.data.result.totalmoney}">
                     <input type="hidden" name="totalmoney" id="totalmoney" value="${objj.data.result.totalmoney}">
                     <input type="hidden" name="redpackMoney" id="redpackMoney" value="${objj.data.result.redpackMoney}">
                    <p>
                    <span class="fr">
                      <c:if test="${objj.data.result.redpackMoney > 0 }">
                                                 红包支付: ${objj.data.result.redpackMoney}
                      </c:if>
                     </span>
                        <span class="fr" style="color: #F23030;" id="sum_price">${objj.data.result.totalmoney}</span>
                        <span class="fr" style="margin-right: 16px;">合计（元）:</span>
                    </p> 
                </div> 
                <div class="sb_price">
                    <p>
                        <span class="fr" style="color: #F23030;" id="sum_price_end">${objj.data.result.totalmoney-objj.data.result.redpackMoney}</span>
                        <span class="fr" style="margin-right: 16px;">最终结算:</span>
                    </p>
                </div> 
                <!-- 添加备注 -->
              <%--   <p style="font-size:15px; color:#333;">翻译费用说明</p>
                <div class="trans_info_notice">
                	<c:choose>
                		<c:when test="${not empty objj.data.result.servicemoneyinfo&&objj.data.result.servicemoneyinfo!='null'}">
                			<textarea class="trans_text_notice" placeholder="请输入翻译费用说明（选填）" name="servicemoneyinfo"  maxlength="50">${objj.data.result.servicemoneyinfo}</textarea>
                		</c:when>
                		<c:otherwise>
                			<textarea class="trans_text_notice" placeholder="请输入翻译费用说明（选填）" name="servicemoneyinfo"  maxlength="50"></textarea>
                		</c:otherwise>
                	</c:choose>
                	
                </div>  --%>
            </div> 
        </div>
        <!--订单明细结束-->
        <div class="sum">
            <p>
                <input type="button" value="发给客户确认" id="send_sub" class="sum_sub" name="sum_sub" />
            </p>
        </div>
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
					<tbody id="meetingList" class="add_fankui">
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
</form>
<input type="text" name="startDate" id="startDate" value="" size="100" placeholder="请选择日期" style="display:none;" />
<script type="text/javascript">
	var ctx="${rc.contextPath}";
</script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/compationInfo.js"></script> 
<script type="text/javascript">
$(function(){
	setMenu();
	//服务弹窗展示和选择处理
	function setMenu() {
		var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/compation/getcompationList\')">订单列表</a><b>&gt;</b><span>订单详情</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
});
</script>
<script>
var test;
$(function(){
	 $("#userResumeList,#userResumeAcceptedList").on('click','.scan',function(){
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
	         	myCalendar("startDate");
	         	$("#myCalendar").show();
	         	that.parents(".cus_td").css({"position":"relative"});
	         	that.after($("#myCalendar")); 
	         }
	 	});
	 }) ;
	 getserviceLog();
});
window.onbeforeunload = function(){return "是否要离开";}

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
                        $(".add_journal").val('');
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
</script>

</body>
</html>