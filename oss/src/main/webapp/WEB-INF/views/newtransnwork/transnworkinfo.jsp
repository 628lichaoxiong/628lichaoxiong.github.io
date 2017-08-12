<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%
	String contextPath = request.getContextPath();
%>


<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-会议详情</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/sele.js" charset="UTF-8"></script>
</head>
<body>
	<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<div class="table-row">
			<table width="100%" cellspacing="0">
				<tr>
					<th width="18%">会议名称</th>
					<td>${transnworkinfo.data.result.meetingname}</td>
				</tr>
				<tr>
					<th>行业标签</th>
					<td>${transnworkinfo.data.result.category}</td>
				</tr>
				<tr>
					<th>会议语言</th>
					<td>${transnworkinfo.data.result.language}</td>
				</tr>
				<tr>
					<th>会议时间</th>
					<td>${transnworkinfo.data.result.meetingtime}</td>
				</tr>
				<tr>
					<th>会议周期</th>
					<td>${fn:replace(transnworkinfo.data.result.longtime, '天', '')}天</td>
				</tr>
				<tr>
					<th>会议城市</th>
					<td>${transnworkinfo.data.result.city}</td>
				</tr>
				<tr>
					<th>会议类型</th>
					<td>${transnworkinfo.data.result.type}</td>
				</tr>
				<tr>
					<th>会议联系人</th>
					<td>${transnworkinfo.data.result.meetinguser}</td>
				</tr>
				<tr>
					<th>会议联系人手机号</th>
					<td>${transnworkinfo.data.result.userphonenumber}</td>
				</tr>
				<tr>
					<th>会议地址</th>
					<td>${transnworkinfo.data.result.address}</td>
				</tr>
				<tr>
					<th>是否安排住宿</th>
					<td>${transnworkinfo.data.result.isusergetin}</td>
				</tr>
				<tr>
					<th>会议报名截止时间</th>
					<td>${transnworkinfo.data.result.timeout}</td>
				</tr>
				<tr>
					<th>会议内容</th>
					<td>${transnworkinfo.data.result.info}</td>
				</tr>
			</table>
		</div>

		<%-- <div class="gray_box" style="margin-top:20px;">
			<p class="down_attach"><span>点击链接下载资料附件</span><a  href="">XXXXX.world</a></p>
		</div> --%>

		<div class="btn_wrap"><a href="${sourcePath}transnwork/updatetransnworkinfo?transnworkid=${transnworkinfo.data.result.id}" class="btn">变更</a></div>
	</div>
<script type="text/javascript">
<!--
	function setMenu(){//或者自己设定导航逻辑
		var str = '<a href="javascript:;" onclick="url_jump(\'${sourcePath}transnwork/transnworklist\')">会议列表</a><b>&gt;</b><span>会议详情</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	setMenu();
//-->
</script>
</body>
</html>
