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
<title>运营支撑系统OSS-订单管理</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/blur.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
<!--时间日期选择插件-->
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<div class="tl">
			<span style="display:inline-block; margin-right:20px; position:relative;">
				<a href="${rc.contextPath}/feedbackOrder/allFeedbackOrder" class="op_btn btn">查看所有反馈</a>
				<img src="${rc.contextPath}/resources/images/icon_new@2x.png" style=" width:23px; height:auto; position:absolute; top:-6px; right:-12px; display:none;" id="img_new"/>
			</span>
			<%-- <span style="display:inline-block; position:relative;">
				<a href="javascript:;" class="op_btn btn">对账记录</a>
				<img src="${rc.contextPath}/resources/images/icon_new@2x.png" style=" width:23px; height:auto; position:absolute; top:-6px; right:-12px;" />
			</span> --%>
		</div>
		<form id="searchForm">
			<div class="tiaojian_wrap tr tiaojian_search clear">
				<div class="search clear">
					<div class="uboxstyle ubox_sele">
					<!-- 隐藏分页数据和下拉查询的参数 -->
				         <input type ="hidden" value="1" name="n" id ="n"/>
				         <input type ="hidden" value="20" name="s" id ="s"/>
						<input type="hidden" name="phonenumber" id="phonenumber" value="${params.phonenumber}">
						<input type="hidden" name="id" id="id" value="${params.id}">
						<input type="hidden" name="userid" id="userid" value="${params.userid}">
						<select id="optype" name="optype">
						  <option value="5" <c:if test="${not empty params.phonenumber}">selected</c:if>>手机号</option>
						  <option value="0" <c:if test="${not empty  params.id}">selected</c:if>>订单编号</option>
						  <option value="1" <c:if test="${not empty   params.userid}">selected</c:if>>用户编号</option>
						 <%--  <option value="2" <c:if test="${params.companyname!=null}">selected</c:if>>企业简称</option> --%>
						<%--   <option value="3" <c:if test="${params.industryTag!=null}">selected</c:if>>行业标签</option> --%>
						</select>
					</div>
			    	<input type="text" class="search_key"  name="search" id="search" value="${params.search}">
				</div>		
				<div class="search search1 clear">
					<p>订单类型</p>
			    	<select id="orderType" name=orderType>
			    		  <option value="">全部</option>
						  <option <c:if test="${params.orderType == 1}">selected</c:if> value="1">发布</option>
						  <option <c:if test="${params.orderType == 2}">selected</c:if> value="2">预约</option>
					</select>
				</div>
				<div class="search search1 clear">
					<p>订单状态</p>
					<select id="payflag" name="payflag">
						  <option value="">全部</option>
						  <option <c:if test="${params.payflag == 5}">selected</c:if> value="5">已发布</option>
						  <option <c:if test="${params.payflag == '0'}">selected</c:if> value="0">已提交</option>
						  <option <c:if test="${params.payflag == 1}">selected</c:if> value="1">待确认</option>
						  <option <c:if test="${params.payflag == 2}">selected</c:if> value="2">待支付</option>
						  <option <c:if test="${params.payflag == 3}">selected</c:if> value="3">预约成功</option>
						  <option <c:if test="${params.payflag == 6}">selected</c:if> value="6">进行中</option>
						  <option <c:if test="${params.payflag == 7}">selected</c:if> value="7">待评价</option>
						  <option <c:if test="${params.payflag == 8}">selected</c:if> value="8">已完成</option>
						  <option <c:if test="${params.payflag == 88}">selected</c:if> value="88">已取消</option>
					</select>
				</div>
				<div class="search search1 clear">
					<p>下单时间</p>
			    	<input type="text"id="startTime" name="startTime" placeholder="开始时间…" value="${params.startTime}" class="Wdate" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm'})"/>
			    	<span>至</span>
			    	<input type="text" id="endTime" name="endTime" placeholder="结束时间…" value="${params.endTime}" class="Wdate" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd HH:mm'})"/>
				</div> 
				<div class="search search1 clear">
					<p>服务城市</p>
			    	<input type="text" id="meetingcity" name="meetingcity" value="${params.meetingcity}"/>
				</div>
				<div class="search search1 clear">
					<p>卡片类型</p>
			    	<select id="cardType" name="cardType">
						  <option value="">全部</option>
						  <option <c:if test="${params.cardType == 'N'}">selected</c:if> value="N">N卡</option>
						  <option <c:if test="${params.cardType == 'S'}">selected</c:if> value="S">S卡</option>
						  <option <c:if test="${params.cardType == 'NS'}">selected</c:if> value="NS">无</option>
					</select>
				</div>
				<%-- <div class="search search1 clear">
					<p>责任销售</p>
			    	<input type="text"  id="meetingcity" name="meetingcity" value="${params.meetingcity}"/>
				</div> --%>
				<input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,20)" id="search-btn">
			</div>
			<div class="sort clear">
				<div class="search search1 clear">
					<p>排序方式</p>
					<select id="sortValue" name="sortValue" onchange="searchMeeting(1,20)">
		                <option <c:if test="${params.sortValue == 'time.desc'}">selected</c:if> value="time.desc">下单时间倒序</option>
		                <option <c:if test="${params.sortValue == 'id.desc'}">selected</c:if> value="id.desc">订单编号倒序</option>
		                <option <c:if test="${params.sortValue == 'pay_time.desc'}">selected</c:if> value="pay_time.desc">支付时间倒序</option>
		                <%-- <option <c:if test="${params.sortValue == 'bakFirst.desc'}">selected</c:if> value="bakFirst.desc">继续推荐正序</option>
		             --%></select>
				</div>
			</div>
		</form>	
			<div class="table-list">
				 <table width="100%" cellspacing="0" id="mytable">
					<thead>
						<tr>
							<th width="8%">订单编号</th>
							<th width="8%">创建时间</th>
							<th width="8%">订单类型</th>
							<th width="8%">客户手机号</th>
							<th width="8%">服务类型</th>
							<th width="8%">服务地点</th>
							<!-- <th width="8%">企业简称</th>
							<th width="5%">行业标签</th> -->
							<th width="8%">订单状态</th>
							<!-- <th width="8%">付款状态</th> -->
							<!-- <th width="8%">发票状态</th> -->
							<!-- <th width="8%">操作人</th> -->
							<th width="8%">金额</th>
							<th width="8%">卡片金额</th>
							<th width="8%">卡片类型</th>
							<th width="8%">反馈</th>
							<!-- <th width="8%">继续推荐</th>
							<th width="10%">订单备注</th> -->
							<th width="10%">操作</th>
						</tr>
					</thead>
					<tbody>
						 <c:forEach items="${list.data.result.datas}"
							varStatus="key" var="list">
							<tr>
								<td align="center">${list.id}</td>
								<td align="center"><Date:date value="${list.time}"></Date:date></td>
								<td align="center">
								 <c:choose>
								   <c:when test="${list.orderType ==1}">
								               发布
								   </c:when>
								   <c:when test="${list.orderType ==2}">
	                                                                                             预约
	                               </c:when>
								 </c:choose>
								
								</td>
								<td align="center">${list.phonenumber }</td>
								<td align="center">${list.serviceType}</td>
								<td align="center">${list.meetingcity}</td>
								<%-- <td align="center">${list.companynameslim}</td>
								<td align="center">${list.industryTag }</td> --%>
								<c:choose>
									<c:when test="${list.isshow==1}">
										<td align="center">已删除</td>
										<%-- <c:if test="${list.payflag!=3}">
											<td align="center">未付款</td>
										</c:if>
										<c:if test="${list.payflag==3}">
											<td align="center">已付款</td>
										</c:if> --%>
									</c:when>
									<c:when test="${list.deleteflag==1}">
										<td align="center">已取消</td>
										<%-- <c:if test="${list.payflag!=3}">
											<td align="center">未付款</td>
										</c:if>
										<c:if test="${list.payflag==3}">
											<td align="center">已付款</td>
										</c:if> --%>
									</c:when>
									<c:when test="${list.payflag==0}">
										<td align="center">已提交</td>
										<!-- <td align="center">未付款</td> -->
									</c:when>
									<c:when test="${list.payflag==1}">
										<td align="center">待确认</td>
										<!-- <td align="center">未付款</td> -->
									</c:when>
									<c:when test="${list.payflag==2}">
										<td align="center">待付款</td>
										<!-- <td align="center">未付款</td> -->
									</c:when>
									<c:when test="${list.payflag==3}">
										<td align="center">预约成功</td>
										<!-- <td align="center">已付款</td> -->
									</c:when>
									<c:when test="${list.payflag==5}"><td align="center">已发布</td></c:when>
									<c:when test="${list.payflag==6}"><td align="center">进行中</td></c:when>
									<c:when test="${list.payflag==7}"><td align="center">待评价</td></c:when>
									<c:when test="${list.payflag==8}"><td align="center">已完成</td></c:when>
									<c:otherwise>
	                                    <td align="center"></td>
	                                   <!--  <td align="center"></td> -->
	                                </c:otherwise>
								</c:choose>
								<%-- <c:choose>
									<c:when test="${not empty list.youjiaddress&&list.youjiaddress!='null'}">
										<td align="center">已邮寄</td>
									</c:when>
									<c:otherwise>
										<td align="center">待邮寄</td>
									</c:otherwise>
								</c:choose> --%>
								
							<%-- 	<td align="center">${name}</td> --%>
								<td align="center">${list.totalmoney}</td>
								<td align="center">${list.cardMoney}</td>
								<td align="center">
								 <c:choose>
	                               <c:when test="${fn:containsIgnoreCase(list.cardNumber,'N')}">
	                                   N卡
	                               </c:when>
	                               <c:when test="${fn:containsIgnoreCase(list.cardNumber,'S')}">
	                                  S卡
	                               </c:when>
	                               <c:otherwise>
	                                                                                                 无
	                               </c:otherwise>
	                             </c:choose>
								</td>
								<td align="center">${list.feedback}</td>
								<%--  <td align="center">
                                   <c:choose>
                                   <c:when test="${list.bakFirst ==1}">
                                                                                            是
                                   </c:when>
                                   <c:otherwise>否</c:otherwise>
                                  </c:choose>                   								 
								 </td> --%>
								<td align="center" class="cus_td">
									<%-- <input type="button" class="op_btn btn btn-beizhu" value="添加备注" data-id="${list.id}"/> --%>
									<c:choose>
										<c:when test="${list.isshow==1||list.deleteflag==1}">
										<p style="width:78px; position:relative;">
											<input  type="button" class="op_btn btn"  value="订单详情"  onclick="info(${list.id},1,${list.isscan});" style="margin-left:0px;">
											<c:if test="${list.isscan==0}">
							           			<img src="${rc.contextPath}/resources/images/icon_new@2x.png" style=" width:23px; height:auto; position:absolute; top:-5px; right:-8px;" />
											</c:if>
										</p>	
										</c:when>
										<c:when test="${list.payflag==0||list.payflag==5}">
										<p style="width:78px; position:relative;">
	                                        <input type="button" class="op_btn btn" value="订单详情" onclick="info(${list.id},0,${list.isscan});" style="margin-left:0px;"/>
	                                        <c:if test="${list.isscan==0}">
	                                            <img src="${rc.contextPath}/resources/images/icon_new@2x.png"  style=" width:23px; height:auto; position:absolute; top:-5px; right:-8px;" />
	                                        </c:if>
	                                    </p>	
										</c:when>
							           <c:otherwise>
							           <p style="width:78px; position:relative;">
	                                        <input type="button" class="op_btn btn" value="订单详情" onclick="info(${list.id},1,${list.isscan});" style="margin-left:0px;">
	                                        <c:if test="${list.isscan==0}">
	                                            <img src="${rc.contextPath}/resources/images/icon_new@2x.png" style=" width:23px; height:auto; position:absolute; top:-5px; right:-8px;" />
	                                        </c:if>
	                                   </p>
							           </c:otherwise>
									</c:choose>
									<%-- <input type="button" class="op_btn btn" value="查看反馈" onclick="scanFadeback(${list.id},'${list.servicename}','${list.companynameslim}',${list.payflag },'${list.phonenumber}',${list.userid });">
									<input type="button" class="op_btn btn" value="添加反馈" onclick="addFadeback(${list.id},'${list.servicename}','${list.companynameslim}',${list.payflag },'${list.phonenumber}',${list.userid });"> --%>
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
	<!-- 添加备注div弹窗 -->
	<div class="beizhu">
		<h3>订单备注</h3>
		<p><textarea placeholder="请输入备注信息" style="resize:none; width:96%; height:60px;" id="comment"></textarea></p>
		<a href="javascript:;" class="fl" onclick="beizhu_close(this);">取消</a>
		<a href="javascript:;" class="fr" onclick="save()">保存并返回</a>
	</div>
	<style>
	.beizhu{ display:none; padding:20px; width:300px; height:auto; position:fixed; top:29%; left:50%; margin-left:-150px; margin-top:-100px; border:#333 solid 1px; border-radius:8px; background:#fff;}
	.beizhu h3{ font-size:24px; color:#333; text-align:center; margin:10px auto;}
	.beizhu h3 p{ font-size:14px; color:#666; line-height:28px;}
	.beizhu a{ text-decoration:none; margin-top:30px; padding:4px 8px; background:#1DA1F2; color:#fff; font-size:16px; border-radius:5px;}
	
	</style>
	
<script type="text/javascript">

$(function(){
	setMenu();
	newFadeback();
	
});
function setMenu() {//或者自己设定导航逻辑
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/compation/getnoreadServices',
		dataType: "json",
        success:function(data){
        	if(data.status==200){
        		var str = "<span>订单列表</span><em class='num'>"+data.data.result+"</em>";
        		$('#current_pos', parent.document).html(str);
        	}
        }
	}); 
	
	return true;
}
function searchMeeting(n,s){
	$("#n").val(n);
	$("#s").val(s);
	$("#searchForm").attr("action", "${rc.contextPath}/compation/getcompationList");
    $("#searchForm").attr("method", "get");
    var optype=$("#optype").val();
    var search_key=$.trim($("#search").val());
	if(optype==0){
		$("#phonenumber").val('');
		$("#userid").val('');
	    $("#id").val(search_key);
	}
	if(optype==5){
		$("#id").val('');
	    $("#userid").val('');
	    $("#phonenumber").val(search_key);
	}
	if(optype==1){
		$("#id").val('');
		$("#phonenumber").val('');
	    $("#userid").val(search_key);
	}
    $("#searchForm").submit();
	/* var companyname; var name; var mobile; var state; var servicepercent;
	var search_key=$.trim($("#search_key").val());
	var optype=$("#optype").val();
	if(optype==0){
		var url="id="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?id="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==1){
		var url="companyname="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?companyname="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==2){
		var url="companyname="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?companyname="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==3){
		var url="companyname="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?companyname="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==4){
		var url="city="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?city="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==5){
		var url="phonenumber="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?phonenumber="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==6){
		var url="serviceType="+search_key;
		window.location.href="${rc.contextPath}/compation/getcompationList?serviceType="+search_key+"&search="+search_key+"&url="+url;
	} */
}
function info(id,type,isscan){
	window.location.href="${rc.contextPath}/compation/getcompationInfo?id="+id+"&type="+type+"&isscan="+isscan;
}
function save(){
	var context=$("#comment").val();
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/compation/updateComment',
		data:{id:beizhuId,comment:context},
		dataType: "json",
        async:false,
        success:function(data){
        	if(data.status==200){
        		 location.reload();
        	}else{
        		alert(data.msg);
        	}
        }
	}); 
}
function scanFadeback(id,servicename,companynameslim,payflag,phonenumber,userid){
	window.location.href="${rc.contextPath}/feedbackOrder/feedbackByOrder?id="+id+"&source=1"+"&payflag="+payflag+"&phonenumber="+phonenumber+"&userid="+userid;
}
function addFadeback(id,servicename,companynameslim,payflag,phonenumber,userid){
	window.location.href="${rc.contextPath}/feedbackOrder/addFeedbackOrder?id="+id+"&payflag="+payflag+"&phonenumber="+phonenumber+"&userid="+userid;
}
function newFadeback(){
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/feedbackOrder/isNewFeedback',
		dataType: "json",
        success:function(data){
        	if(data.status==200){
        		if(data.data.result){
        			$("#img_new").show();
        		} 
        	}
        }
	}); 
}
</script>
</body>
</html>