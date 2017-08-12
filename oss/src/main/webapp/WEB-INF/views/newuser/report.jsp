<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>  
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%
String path = request.getContextPath();
String sourcePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">



<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-批量导入工作经历</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/main.css?id=1" rel="stylesheet" type="text/css" />
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
		<div class="userdetail">
			<div class="avatar"><img src="${userlogo}" /></div>
			<div class="userinfo">
				<h1>${username}</h1>
				<!-- <div class="userstat"><span>参与会议数：5</span><span>通过会议数：2</span><span>未通过会议数：2</span>主动取消报名数：1</div> -->
				<!-- <a href="" class="btn" style="margin-top:27px;">批量导入工作经历</a> -->
			</div>
		</div>

		<div class="gray_box" style="margin-top:20px;">
			<div class="exa_img"><img src="${sourcePath}/resources/images/example.jpg"></div>
			<p>提示：<br/>填写格式为：会议名称、会议简介、会议时间、会议类型、行业、语种、地址。<br/>请参考上面的表格样式整理译员简历。总共8列，最后一列是1。没有内容的可以不填。</p>
		</div>
		<p class="navtit">工作经历导入</p>
		 <c:url var="readUrl" value="/user/importUser?userid=${userid}&username=${username}&userlogo=${userlogo}"  />
		<div class="gray_box">
			 <form  id="readReportForm" action="${readUrl}" method="post" enctype="multipart/form-data"  target="iframe_import" onsubmit="return checkForm()">
			<p>第一步：工作经历文件选择 &nbsp;&nbsp; <input id="file" type="file" name="file" value="选择文件"/>  </p>
			<p>第二步：工作经历导入 &nbsp;&nbsp;<input type="submit" class="btn" value="导入" /></p>
			</form>
			<iframe id="iframe_import" name="iframe_import" width="0" height="0" style="display:none" frameborder="0"></iframe>
		</div>

		<c:url var="readUrl2" value="/user/importUser2?userid=${userid}&username=${username}&userlogo=${userlogo}"  />
		<div class="gray_box">
			<form  id="readReportForm2" action="${readUrl2}" method="post" enctype="multipart/form-data"  target="iframe_import" onsubmit="return checkForm()">
				<p><font color="red">第一步：用户信息修改</font> &nbsp;&nbsp; <input id="file" type="file" name="file" value="选择文件"/>  </p>
				<p><font color="red">第二步：工作经历导入</font> &nbsp;&nbsp;<input type="submit" class="btn" value="导入" /></p>
			</form>
			<iframe id="iframe_import2" name="iframe_import" width="0" height="0" style="display:none" frameborder="0"></iframe>
		</div>



	</div>
<script type="text/javascript">
<!--
	function setMenu(){//或者自己设定导航逻辑
		var str = '<a href="javascript:;" onclick="url_jump(\'${sourcePath}/user/userList\')">用户列表</a><b>&gt;</b><a href="javascript:;" onclick="url_jump(\'${sourcePath}user/getuserinfo?userid=${userid}\')">用户信息</a><b>&gt;</b><span>批量导入工作经历</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	setMenu();
//-->
	
	function checkForm(){
//		var FileListType="xls,xlsx";
//		var filepath = document.getElementById("file").value;
//		if(filepath==null||filepath==''){
//			alert("请上传excel文件");
//			return false;
//		}
//		var destStr = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
//		if(FileListType.indexOf(destStr) == -1){
//			  alert("只允许上传xls,xlsx文件");
//			  return false;
//		}
		return true;
	}

</script>
</body>
</html>
