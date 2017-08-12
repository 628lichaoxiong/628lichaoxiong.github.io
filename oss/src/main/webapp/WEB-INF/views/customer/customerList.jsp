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
<title>运营支撑系统OSS-客户列表</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/blur.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<div id="loading"><div class="msg"></div></div>
<%-- <form method="post" action="${rc.contextPath}/exception/redExcel" enctype="multipart/form-data">
    选择一个文件:
    <input type="file" name="uploadFile" />
    <br/><br/>
    <input type="submit" value="上传" />
</form>  --%>
	<div class="mainBody">
		<form id="searchFrom" class="searchFrom">
		 <!-- 隐藏分页数据和下拉查询的参数 -->
		 <input type ="hidden" value="1" name="n" id ="n"/>
		 <input type ="hidden" value="20" name="s" id ="s"/>
		 <input type ="hidden" value="${params.id}" name="id" id ="id"/>
		 <input type ="hidden" value="${params.mobile}" name="mobile" id ="mobile"/>
		 <input type ="hidden" value="${params.customerName}" name="customerName" id ="customerName"/>
		<div class="tiaojian_wrap tr tiaojian_search clear">
			<div class="search clear">
	             <div class="uboxstyle ubox_sele">
					<select id="optype" name="optype">
					  <option value="1" <c:if test="${not empty params.id}">selected</c:if>>用户编号</option>
					  <option value="2" <c:if test="${not empty  params.mobile}">selected</c:if>>手机号</option>
					  <option value="0" <c:if test="${not empty  params.customerName}">selected</c:if>>客户名称</option>
					</select>
				</div>
		      <input type="text" class="search_key" id="search" name="search" value="${params.search}">
			</div>
			 <div class="search search1 clear">
                    <p>责任销售</p>
                    <input type="text" id="salesName" name="salesName" value="${params.salesName}"/>
            </div>  
            <div class="search search1 clear">
                    <p>卡片类型</p>
                    <select id="cardType" name="cardType">
                          <option value="">全部</option>
                          <option <c:if test="${params.cardType == 1}">selected</c:if> value="1">N卡</option>
                          <option <c:if test="${params.cardType == 2}">selected</c:if> value="2">S卡</option>
                          <option <c:if test="${params.cardType == '0'}">selected</c:if> value="0">无</option>
                    </select>
            </div>
			<div class="search search1 clear">
                    <p>是否禁用</p>
                    <select id="cardStatus" name="cardStatus">
                          <option value="">全部</option>
                          <option <c:if test="${params.cardStatus == '0'}">selected</c:if> value="0">是</option>
                          <option <c:if test="${params.cardStatus == 1}">selected</c:if>  value="1">否</option>
                    </select>
            </div>
			<input type="button" class="sub_btn" value="查找" onclick="searchMeeting(1,20)">
		</div>
		<div class="sort clear">
                <div class="search search1 clear">
                    <p>排序方式</p>
                    <select id="sortValue" name="sortValue" onchange="searchMeeting(1,20)">
                        <option <c:if test="${params.sortValue == 'time.desc'}">selected</c:if> value="time.desc">注册时间倒序</option>
                        <option <c:if test="${params.sortValue == 'time.asc'}">selected</c:if> value="time.asc">注册时间正序</option>
                    </select>
                </div>
            </div>
		</form>
		<div class="table-list">
			 <table width="100%" cellspacing="0" id="mytable">
				<thead>
					<tr>
						<th width="10%">注册时间</th>
						<th width="6%">用户编号</th>
						<th width="8%">卡片类型</th>
						<th width="8%">手机号</th>
						<th width="10%">客户名称</th>
						<th width="8%">责任销售</th>
						<th width="6%">订单数</th>
						<th width="6%">成单数</th>
						<!-- <th width="6%">评价</th>
						<th width="6%">联系人</th>
						<th width="9%">现有积分</th>
						<th width="9%">累积消费积分</th>
						<th width="6%">服务费率</th>
						<th width="8%">认证状态</th> -->
						<th width="6%">是否禁用</th>
						<!-- <th>操作</th> -->
					</tr>
				</thead>
				<tbody>
					 <c:forEach items="${list.data.result.list}"
						varStatus="key" var="Customer">
						<tr>
							<td align="center">
                                <Date:date value="${Customer.time}"></Date:date>
                            </td>
							<td align="center"><a href="${rc.contextPath}/customer/getCustomerInfo?id=${Customer.id}">${Customer.id}</a></td>
							<td align="center">
							 <c:if test="${Customer.cardType == 0}">无</c:if>
							 <c:if test="${Customer.cardType == 1}">N卡</c:if>
							 <c:if test="${Customer.cardType == 2}">S卡</c:if>
							</td>
							<td align="center">${Customer.phonenumber}</td>
							<td align="center">${Customer.customerName}</td>
							<td align="center">${Customer.salesName}</td>
							<td align="center">${Customer.sumbill}</td>
							<td align="center">${Customer.sumoverbill}</td>
							<%-- <td align="center">${Customer.totalEvaluate}</td>
							<td align="center">${Customer.username}</td>
							<td align="center">${Customer.totalpoints}</td>
							<td align="center">${Customer.totalDE}</td>
							<td align="center"><fmt:parseNumber  integerOnly="true" value="${Customer.servicepercent*100}"/>%</td>
							<c:choose>
								<c:when test="${Customer.flag==1}">
									<td align="center">认证通过</td>
									<td align="center" class="cus_td">
										<a href="${rc.contextPath}/customer/getCustomerInfo?id=${Customer.id}" class="op_btn btn" style="position:relative; top:2px; right:5px;">客户详情</a>
										<input type="button" class="op_btn btn disable" value="认证通过" >
										<input type="button" class="op_btn btn disable" value="不通过" >
						           </td>
								</c:when>
								<c:when test="${Customer.flag==2}">
									<td align="center">认证未通过</td>
									<td align="center" class="cus_td">
										<a href="${rc.contextPath}/customer/getCustomerInfo?id=${Customer.id}" class="op_btn btn" style="position:relative; top:2px; right:5px;">客户详情</a>
										<input type="button" class="op_btn btn disable" value="认证通过" >
										<input type="button" class="op_btn btn disable" value="不通过" >
						           </td>
								</c:when>
								<c:when test="${Customer.flag==3}">
									<td align="center">认证待审核</td>
									<td align="center" class="cus_td">
										<a href="${rc.contextPath}/customer/getCustomerInfo?id=${Customer.id}" class="op_btn btn" style="position:relative; top:2px; right:5px;">客户详情</a>
										<input type="button" class="op_btn btn rz_yes" value="认证通过" onclick="makeDown1(this,${Customer.companyid},${Customer.id })">
										<input type="button" class="op_btn btn rz_no" value="不通过" onclick="makeDown2(this,${Customer.companyid},${Customer.id })">
						           </td>
								</c:when>
								<c:otherwise>
									<td align="center">未提交认证</td>
									<td align="center" class="cus_td">
										<a href="${rc.contextPath}/customer/getCustomerInfo?id=${Customer.id}" class="op_btn btn" style="position:relative; top:2px; right:5px;">客户详情</a>
										<input type="button" class="op_btn btn disable" value="认证通过" >
										<input type="button" class="op_btn btn disable" value="不通过" >
						           </td>
								</c:otherwise>
							</c:choose>   --%>
							<td align="center">
							 <c:if test="${Customer.cardStatus ==1}">
                                                                                          否                                             
                              </c:if>
                              <c:if test="${Customer.cardStatus ==0}">
                                                                                 是
                              </c:if>
							</td>
						</tr>
					</c:forEach> 
					
				</tbody>
			</table>
			<nav> <!-- 分页开始 -->
					<ul class="pagination">
					<c:choose>
					<c:when test="${not empty params.url}">
					<pageNation:PageNation currPage="${list.data.result.pageNum+1}"
							totalPages="${list.data.result.pages}" perPageRows="${list.data.result.pageSize}"
							totalRows="${list.data.result.total}"
							clickMethodName="searchMeeting">
					</pageNation:PageNation>
					</c:when>
					<c:otherwise>
					<pageNation:PageNation currPage="${list.data.result.pageNum+1}"
							totalPages="${list.data.result.pages}" perPageRows="${list.data.result.pageSize}"
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
function searchMeeting(n,s){
	$("#n").val(n);
	$("#s").val(s);
	var search_key=$.trim($("#search").val());
    var optype=$("#optype").val();
  //下拉查询时，需要把其他的查询条件置为空
    if(optype==0){
    	$("#customerName").val(search_key);
    	$("#id").val('');
    	$("#mobile").val('');
    }
    if(optype==1){
    	$("#id").val(search_key);
    	$("#customerName").val('');
        $("#mobile").val('');
    }
    if(optype==2){
    	$("#mobile").val(search_key);
    	$("#customerName").val('');
        $("#id").val('');
    }
	$("#searchFrom").attr("action", "${rc.contextPath}/customer/getCustomerList");
    $("#searchFrom").attr("method", "GET");
    $("#searchFrom").submit(); 
}
function setMenu() {//或者自己设定导航逻辑
	var str = '<span>客户列表</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}
/* function searchMeeting(){
	var companyname; var name; var mobile; var state; var servicepercent;
	var search_key=$.trim($("#search_key").val());
	var optype=$("#optype").val();
	if(optype==0){
		var url="companyname="+search_key;
		window.location.href="${rc.contextPath}/customer/getCustomerList?companyname="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==1){
		var url="name="+search_key;
		window.location.href="${rc.contextPath}/customer/getCustomerList?name="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==2){
		var url="mobile="+search_key;
		window.location.href="${rc.contextPath}/customer/getCustomerList?mobile="+search_key+"&search="+search_key+"&url="+url;
	}
	if(optype==3){
		var reg= /^(100|[1-9]\d|\d)$/;
		if(!reg.test(search_key)){
			alert("请输入0-100之间的正整数");
			$("#search_key").val("");
			return false;
		}
		var search_key1=search_key/100;
		var url="servicepercent="+search_key1;
		window.location.href="${rc.contextPath}/customer/getCustomerList?servicepercent="+search_key1+"&search="+search_key+"&url="+url;
	}
	if(optype==4){
		var url="state=0"
		window.location.href="${rc.contextPath}/customer/getCustomerList?state=0&url="+url;
	}
	if(optype==5){
		var url="state=1"
		window.location.href="${rc.contextPath}/customer/getCustomerList?state=1&url="+url;
	}
	if(optype==6){
		var url="state=2"
		window.location.href="${rc.contextPath}/customer/getCustomerList?state=2&url="+url;
	}
	if(optype==7){
		var url="state=3"
		window.location.href="${rc.contextPath}/customer/getCustomerList?state=3&url="+url;
	}
}
 */


	


function makeDown1(dom,companyId,customerId){
	if(!$(dom).hasClass('disable') && confirm('你确定要修改审核状态为认证通过么？')) {
		  $.ajax({
			type:'post',
			url:'${rc.contextPath}/customer/setAuth',
			data:{companyId:companyId,flag:1,customerId:customerId},
			dataType: "json",
	        async:false,
	        success:function(data){
	        	if(data.status==200){
	        		$(dom).addClass('disable').parent().prev().text('认证通过');
	        		$(dom).siblings(".rz_no").addClass('disable');
	        	}else{
	        		alert(data.msg);
	        	}
	        }
		}); 
		
	}
}
function makeDown2(dom,companyId,customerId){
	if(!$(dom).hasClass('disable') && confirm('你确定要修改审核状态为认证未通过么？')) {
		$.ajax({
			type:'post',
			url:'${rc.contextPath}/customer/setAuth',
			data:{companyId:companyId,flag:2,customerId:customerId},
			dataType: "json",
	        async:false,
	        success:function(data){
	        	if(data.status==200){
	        		$(dom).addClass('disable').parent().prev().text('认证未通过');
	        		$(dom).siblings(".rz_yes").addClass('disable');
	        	}else{
	        		alert(data.msg);
	        	}
	        }
		}); 
		
	}
}
</script>
</body>
</html>