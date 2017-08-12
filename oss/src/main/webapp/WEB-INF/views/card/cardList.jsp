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
<title>运营支撑系统OSS-N卡管理</title>
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
				<a href="#" onclick="countCards()" class="op_btn btn">卡片数据</a>
				<a href="#" onclick="cardManager()" class="op_btn btn">生成卡片</a>
				<a href="#" onclick="getNewCardInfoParams()" class="op_btn btn">新卡管理</a>
			</span>
			<%-- <span style="display:inline-block; position:relative;">
				<a href="javascript:;" class="op_btn btn">对账记录</a>
				<img src="${rc.contextPath}/resources/images/icon_new@2x.png" style=" width:23px; height:auto; position:absolute; top:-6px; right:-12px;" />
			</span> --%>
        <form id="searchFrom">
             <!-- 隐藏分页数据和下拉查询的参数 -->
	         <input type ="hidden" value="1" name="n" id ="n"/>
	         <input type ="hidden" value="20" name="s" id ="s"/>
	         <input type ="hidden" value="${params.cardNumber}" name="cardNumber" id ="cardNumber"/>
	         <input type ="hidden" value="${params.customerName}" name="customerName" id ="customerName"/>
	         <input type ="hidden" value="${params.phonenumber}" name="phonenumber" id ="phonenumber"/>
           <%--  <div class="tiaojian_wrap tr tiaojian_search clear">
			   <div class="search clear">
                 <div class="uboxstyle ubox_sele">
			      <select id="optype" name="optype">
    				  <option value="1" <c:if test="${params.cardNumber!=null}">selected</c:if>>卡号</option>
    				  <option value="2" <c:if test="${params.customerName!=null}">selected</c:if>>客户名称</option>
    				  <option value="3" <c:if test="${params.phonenumber!=null}">selected</c:if>>协议手机号</option>
    				  <option value="4" <c:if test="${params.salesName!=null}">selected</c:if>>责任销售</option>
    				  <option value="5" <c:if test="${params.cardStatus!=null}">selected</c:if>>卡状态</option>
    				</select>
    			  </div>
    		      <input type="text" class="search" id=search value="${params.search}" style="float: left; width: 140px;">
			    </div>
			     <input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,20)">
    		</div> --%>
    		<div class="tiaojian_wrap tr tiaojian_search clear">
				<div class="search clear">
					<div class="uboxstyle ubox_sele" style="width: 95px;">
						<select id="optype" name="optype">
						  <option value="0" <c:if test="${not empty params.cardNumber}">selected</c:if>>N卡卡号</option>
						  <option value="1" <c:if test="${not empty params.customerName}">selected</c:if>>客户名称</option>
						  <option value="2" <c:if test="${not empty params.phonenumber}">selected</c:if>>协议手机号</option>
						</select>
					</div>
			    	<input type="text" class="search_key" style="width: 125px;"  name="search" value="${params.search}" id="search">
				</div>		
				<div class="search search1 clear">
					<p>卡片状态</p>
			    	<select id="cardStatus" name="cardStatus">
			    		  <option value="" <c:if test="${empty params.cardStatus}">selected</c:if>>全部</option>
						  <option value="1" <c:if test="${params.cardStatus==1}">selected</c:if>>待领取</option>
						  <option value="2" <c:if test="${params.cardStatus==2}">selected</c:if>>待绑定</option>
						  <option value="3" <c:if test="${params.cardStatus==3}">selected</c:if>>待激活</option>
						  <option value="4" <c:if test="${params.cardStatus==4}">selected</c:if>>已激活</option>
						  <option value="5" <c:if test="${params.cardStatus==5}">selected</c:if>>已启用</option>
					</select>
				</div>
				<div class="search search1 clear">
					<p>卡片类型</p>
					<select id="cardType" name="cardType">
						  <option value="" <c:if test="${empty params.cardType}">selected</c:if>>全部</option>
						  <option value="1" <c:if test="${params.cardType==1}">selected</c:if>>N卡</option>
						  <option value="2" <c:if test="${params.cardType==2}">selected</c:if>>S卡</option>
					</select>
				</div>
				<div class="search search1 clear">
					<p>责任销售</p>
			    	<input type="text" name="salesName" value="${params.salesName}"/>
				</div>
				<div class="search search1 clear">
					<p>禁用状态</p>
			    	<select id="yn" name="yn">
						  <option value="" <c:if test="${empty params.yn}">selected</c:if>>全部</option>
						  <option value="0" <c:if test="${params.yn=='0'}">selected</c:if>>已禁用</option>
						  <option value="1" <c:if test="${params.yn=='1'}">selected</c:if>>未禁用</option>
					</select>
				</div>				
				<input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,20)" id="search-btn">
			</div>
			<div class="sort clear">
				<div class="search search1 clear">
					<p>排序方式</p>
					<select id="order" name="order"  onchange="searchMeeting(1,20)">
		                <option value="card_number.desc" <c:if test="${empty params.order||params.order=='card_number.desc'}">selected</c:if>>按卡号倒序</option>
		                <option value="card_number.asc" <c:if test="${params.order=='card_number.asc'}">selected</c:if>>按卡号正序</option>
		                <option value="activate_time.desc" <c:if test="${params.order=='activate_time.desc'}">selected</c:if>>按激活时间倒序</option>
		                <option value="activate_time.asc" <c:if test="${params.order=='activate_time.asc'}">selected</c:if>>按激活时间正序</option>
		                <option value="consume_money+0.desc" <c:if test="${params.order=='consume_money+0.desc'}">selected</c:if>>按已消费金额倒序</option>
		                <option value="consume_money+0.asc" <c:if test="${params.order=='consume_money+0.asc'}">selected</c:if>>按已消费金额正序</option>
		                <option value="card_type.asc,balance_money+0.desc" <c:if test="${params.order=='card_type.asc,balance_money+0.desc'}">selected</c:if>>按N卡余额倒序</option>
		                <option value="card_type.asc,balance_money+0.asc" <c:if test="${params.order=='card_type.asc,balance_money+0.asc'}">selected</c:if>>按N卡余额正序</option>
		                <option value="card_type.desc,balance_money+0.desc" <c:if test="${params.order=='card_type.desc,balance_money+0.desc'}">selected</c:if>>按S卡账单额倒序</option>
		                <option value="card_type.desc,balance_money+0.asc" <c:if test="${params.order=='card_type.desc,balance_money+0.asc'}">selected</c:if>>按S卡账单额正序</option>
		                <option value="service_times.desc" <c:if test="${params.order=='service_times.desc'}">selected</c:if>>按预约次数倒序</option>
		                <option value="service_times.asc" <c:if test="${params.order=='service_times.asc'}">selected</c:if>>按预约次数正序</option>
		            </select>
				</div>
			</div>
    	 </form>
		</div>

		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="8%">N卡卡号</th>
						<th width="8%">客户名称</th>
						<th width="8%">N卡类型</th>
						<th width="8%">激活时间</th>
						<th width="8%">协议手机号</th>
						<th width="8%">已消费金额</th>
						<th width="8%">责任销售</th>
						<th width="8%">余额</th>
						<th width="8%">账单额</th>
						<th width="8%">卡片状态</th>
						<th width="8%">预约次数</th>
						<th width="8%">是否禁用</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.datas}"
						varStatus="key" var="list">
						<tr>
							<td align="center">${list.cardNumber}</td>
							<td align="center">${list.customerName}</td>
							<td align="center">
							  <c:if test="${list.cardType ==1}">
                                        N卡
                              </c:if>
                              <c:if test="${list.cardType ==2}">
                                        S卡
                              </c:if>
							 </td>
							<td align="center">
							    <Date:date value="${list.activateTime}"></Date:date>
							    <%--  <fmt:formatDate value="${list.activateTime}" pattern="yyyy-MM-dd HH:mm:ss" />  --%>
							</td>
							<td align="center">${list.phonenumber}</td>
							<td align="center">${list.consumeMoney}</td>
							<td align="center">${list.salesName}</td>
							<td align="center">
							<c:if test="${list.cardType ==1}">
                                       ${list.balanceMoney}
                             </c:if>
                            </td>
							<td align="center">
							<c:if test="${list.cardType ==2}">
                                       ${list.balanceMoney}
                             </c:if>
							</td>
							<td align="center"><transn:cardStatus value="${list.cardStatus}"></transn:cardStatus></td>
							<td align="center">${list.serviceTimes}</td>
							<td align="center">
							<c:if test="${list.yn ==0}">
                                                                                已禁用
                             </c:if>
                             <c:if test="${list.yn ==1}">
                                                                                   未禁用                                     
                             </c:if>
							</td>
							<td align="center" class="cus_td">
						           <p style="width:78px; position:relative;">
						          		<input type="button" class="op_btn btn" value="卡片详情" onclick="info(${list.cardInfoId});" style="margin-left:0px;">
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
    var str = '<span>N卡管理列表</span>';
    $('#current_pos', parent.document).html(str);
    return true;
}

function searchMeeting(n,s){
    $("#n").val(n);
    $("#s").val(s);
    var search=$.trim($("#search").val());
    var optype=$("#optype").val();
    if(optype==0){
    	$("#cardNumber").val(search);
    	$("#customerName").val("");
    	$("#phonenumber").val("");
    }
    if(optype==1){
    	$("#cardNumber").val("");
    	$("#customerName").val(search);
    	$("#phonenumber").val("");
    }
    if(optype==2){
    	$("#cardNumber").val("");
    	$("#customerName").val("");
    	$("#phonenumber").val(search);
    }
    $("#searchFrom").attr("action", "${rc.contextPath}/card/getCardInfoParams");
    $("#searchFrom").attr("method", "GET");
    $("#searchFrom").submit(); 
}

function info(cardInfoId){
	window.location.href="${rc.contextPath}/card/getCardInfo?cardInfoId="+cardInfoId;
}
function cardManager(){
	window.location="${rc.contextPath}/card/addCard"
}
function countCards(){
	window.location="${rc.contextPath}/card/toCountCards"
}
function getNewCardInfoParams(){
	window.location="${rc.contextPath}/card/getNewCardInfoParams?isFirst=1"
} 
/* function searchMeeting(){
    var search_key=$.trim($("#search_key").val());
    var optype=$("#optype").val();
    if(optype==1){
        var url="cardInfo="+search_key;
        window.location.href="${rc.contextPath}/card/getCardInfoParams?cardNumber="+search_key+"&search="+search_key+"&url="+url;
    }
    if(optype==2){
        var url="customerName="+search_key;
        window.location.href="${rc.contextPath}/card/getCardInfoParams?customerName="+search_key+"&search="+search_key+"&url="+url;
    }
    if(optype==3){
        var url="phonenumber="+search_key;
        window.location.href="${rc.contextPath}/card/getCardInfoParams?phonenumber="+search_key+"&search="+search_key+"&url="+url;
    }
    if(optype==4){
        var url="salesName="+search_key;
        window.location.href="${rc.contextPath}/card/getCardInfoParams?salesName="+search_key+"&search="+search_key+"&url="+url;
    }
    if(optype==5){
        var url="cardStatus="+search_key;
        window.location.href="${rc.contextPath}/card/getCardInfoParams?cardStatus="+search_key+"&search="+search_key+"&url="+url;
    }
} */
</script>
</body>
</html>
