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
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/ajaxfileupload.js" charset="UTF-8"></script>
<style type="text/css">
.file {
    position: relative;
    display: inline-block;
    background: #E3EAF4;
	font-size: 12px;
    border-radius: 4px;
    width:80px;
	height:32px;
	text-align:center;
	line-height:32px;
    overflow: hidden;
    color: #1DA1F2;
    text-decoration: none;
    text-indent: 0;
    top:10px;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #E3EAF4;
    color: #1DA1F2;
    text-decoration: none;
}
.uploads_input_btn{
    border: 0;
    background: #1DA1F2;
    height: 32px;
    line-height:32px;
    width:80px;
    text-align;center;
    color: #fff;
    border-radius: 5px;
    -moz-border-radius: 5px;
    -webkit-border-radius: 4px;
    behavior: url('PIE.htc');
    cursor: pointer;
}
.list_notice{
	font-size: 14px;
	color: #333333;
}
</style>
</head>
<body>
	<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<div class="gray_box" style="margin-top:20px;">
			<p class="list_notice">译员简历模版内容包括：</p>
		<%-- 	<div class="exa_img"><img src="${sourcePath}/resources/images/example.jpg"></div> --%>
			<div class="exa_img"><img src="${sourcePath}/resources/images/img_example@2x.png"></div>
			<!-- <p>提示：<br/>填写格式为：会议名称、会议简介、会议时间、会议类型、行业、语种、地址。<br/>请参考上面的表格样式整理译员简历。总共8列，最后一列是1。没有内容的可以不填。</p> -->
		</div>
		<p class="navtit">导入译员简历</p>
		 <c:url var="readUrl" value="/resume/importResume" />  
		<div class="gray_box">
			 <%-- <form  id="readReportForm" action="${readUrl}" method="post" enctype="multipart/form-data"  target="iframe_import" onsubmit="return checkForm()">   --%>
			<!-- <p>第一步：工作经历文件选择 &nbsp;&nbsp; <input id="file" type="file" name="multfile" value="选择文件"/>  </p> -->
			<p>第一步：译员简历文件选择 &nbsp;&nbsp; 
				<a href="javascript:;" class="file">选择文件
					   <input id="file" type="file" name="multfile" />
				</a>		
				<span class="showFileName1"></span>	
			</p>
			<p>第二步：译员简历导入 &nbsp;&nbsp;<input type="button" class="uploads_input_btn" value="导入" id="uploadFile" /></p>
			<%-- </form> --%>
			<iframe id="iframe_import" name="iframe_import" width="0" height="0" style="display:none" frameborder="0"></iframe> 
		</div>
	<br><br><br>
		<c:url var="readUrl2" value="/user/importUser2"  />
		<div class="gray_box">
			<form   action="${sourcePath}user/importUser2" method="post"   enctype="multipart/form-data">
				<p><font color="red">第一步：用户信息修改</font> &nbsp;&nbsp; <input  name="file" type="file"  value="选择文件"/>  </p>
				<p><font color="red">第二步：工作经历导入</font> &nbsp;&nbsp;<input  type="submit" class="btn" value="导入" /></p>
			</form>
			<iframe id="iframe_import2" name="iframe_import" width="0" height="0" style="display:none" frameborder="0"></iframe>
		</div>
	</div>
<script type="text/javascript">
//显示input file 上传文件美化之后的文件名称
$(".file").on("change","input[type='file']",function(){
    var filePath=$(this).val();
    if(filePath.indexOf("xls")!=-1 || filePath.indexOf("xlsx")!=-1){
        $(".fileerrorTip1").html("").hide();
        var arr=filePath.split('\\');
        var fileName=arr[arr.length-1];
        $(".showFileName1").html(fileName);
    }else{
        $(".showFileName1").html("");
        alert("只允许上传xls,xlsx文件");
        return false
    }
})



<!--
	function setMenu(){//或者自己设定导航逻辑
		var str = '<span>批量导入工作经历</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	  setMenu();  
//-->
	
	/* function checkForm(){
		var FileListType="xls,xlsx";
		var filepath = document.getElementById("file").value;
		if(filepath==null||filepath==''){
			alert("请上传excel文件");
			return false;
		}
		var destStr = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
		if(FileListType.indexOf(destStr) == -1){
			  alert("只允许上传xls,xlsx文件");
			  return false;
		}
		return true;
	} */
	$("#uploadFile").click(function(){
		var FileListType="xls,xlsx";
		var filepath = document.getElementById("file").value;
		if(filepath==null||filepath==''){
			alert("请上传excel文件");
			return false;
		}
		var destStr = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
		if(FileListType.indexOf(destStr) == -1){
			  alert("只允许上传xls,xlsx文件");
			  return false;
		}
		 $.ajaxFileUpload({
	            url: '${sourcePath}resume/importResume', 
	            type: 'post',
	            secureuri: false, //一般设置为false
	            fileElementId: 'file', // 上传文件的id、name属性名
	            dataType: 'text', //返回值类型，一般设置为json、
	            success: function(data){  
	               data=jQuery.parseJSON(jQuery(data).text());
	               if(data.status==200){
	            	   alert("导入成功");
	               }else{
	            	   alert(data.msg);
	               }
	            },
	            error: function(data, status, e){ 
	                alert(e);
	                console.log(e);
	            }
	        });
	});
	
</script>
</body>
</html>
