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
    <title>运营支撑系统OSS-添加手动评价</title>
    <link rel="stylesheet" href="${rc.contextPath}/resources/js/datepicker/jquery-ui.min.css" />
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
    <link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/cropbox.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	    html{
	    	height: 96%;
	    }
	    body{
	    	height: 100%;
	    }
	    .details_content{
	    	height: 95%;
	    }
    	.other-info .title{
    		text-align: center;
    		padding: 0;
    	}
    	.row-content{
    		width: 400px;
    		margin: 0 auto;
    	}
		.basic_info .row-inp textarea{
			width: 250px;
		}
		.basic_info .row-inp .row-inp-left{
			width: 120px;
		}
		.basic_info .row-inp .row-inp-right {
		    margin-left: 120px;
		}
	</style>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/ajaxfileupload.js" charset="UTF-8"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/transer.js"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/cropbox.js" charset="UTF-8"></script>
    <%-- <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script> --%>
</head>
<body>
	<div id="jump_mask" class="jump_mask" style="display: none;"></div>
<div id="loading"><div class="msg"></div></div>
<input type="hidden" value="0" id="userid"/>
<input type="hidden" value="" id="photoSecond"/><!-- 第二次点击时 -->
<div class="details_content">
    <form action="${rc.contextPath}/resume/addUserEvaluate" class="transer_form" id="judgeForm" >
    	<input type="hidden" value="${resumeId}" name="resumeId">
    	<input type="hidden" value="${mobile}" name="mobile">
	    <div class="basic_info other-info">
	        <h2	class="title">添加手动评价</h2>
	        <div class="row-content">
		         <div class="row-inp">
	                <div class="row-inp-left">语言能力</div>
	                <div class="row-inp-right">
	                    <input type="text" class="inp name" placeholder="请输入1-5的整数" maxlength="1" name="language" onkeyup="value=value.replace(/[^1-5]{1}/g, '')" />
	                </div>
	            </div>
	            <div class="row-inp">
	                <div class="row-inp-left">专业能力</div>
	                <div class="row-inp-right">
	                    <input type="text"  class="inp transer-number" placeholder="请输入1-5的整数" maxlength="1" name="major" onkeyup="value=value.replace(/[^1-5]{1}/g, '')" />
	                </div>
	            </div>
	            <div class="row-inp">
	                <div class="row-inp-left">服务态度</div>
	                <div class="row-inp-right">
	                    <input type="text" class="inp transer-number" placeholder="请输入1-5的整数" name="service" maxlength="1" onkeyup="value=value.replace(/[^1-5]{1}/g, '')"/>
	                </div>
	            </div>
	            <div class="row-inp">
	                <div class="row-inp-left">社交礼仪</div>
	                <div class="row-inp-right">
	                    <input type="text" class="inp transer-number" placeholder="请输入1-5的整数" name="social" maxlength="1" onkeyup="value=value.replace(/[^1-5]{1}/g, '')"/>
	                </div>
	            </div>
	            <div class="row-inp">
	                <div class="row-inp-left">评语</div>
	                <div class="row-inp-right">
	                    <textarea placeholder="输入评价内容" id="userInfo" name="other"></textarea>
	                </div>
	            </div>
            </div>
	    </div>

	    <div class="btn-group clear">
	    	<input type="button" value="取消" class="cancel-btn">
	    	<input type="button" value="保存" class="save-btn">
	    </div>
    </form>

    <!--错误提示弹窗-->
    <div id="showEorr"></div>

    <!-- 弹窗 -->
    <div id="maskBg"></div>
    <div id="maskMain">
    	<img src="${rc.contextPath}/resources/images/tishi@2x.png" />
    	<p></p>
    	<div class="btn-group clear">
    		<a href="javascript:;" class="no">否</a>
    		<a href="javascript:;" class="yes">是</a>
    	</div>
    </div>
</body>
<script type="text/javascript">
	//表单取消按钮操作
	$('#judgeForm').on('click','.cancel-btn',function(){
		$('#maskBg').show();
		$('#maskMain').fadeIn();
		$('#maskMain').find('p').html('确认要取消添加手动评价吗？');
	});
	//表单确认按钮操作
	$('#judgeForm').on('click','.save-btn',function(){
		$('#maskBg').show();
		$('#maskMain').fadeIn();
		$('#maskMain').find('p').html('确认保存评价吗？');
	});
	//取消
	$('#maskMain').on('click','.no',function(){
		$('#maskMain').fadeOut();
    	$('#maskBg').hide();   	
    });
	//确定
	$('#maskMain').on('click','.yes',function(){
		if($('#maskMain').find('p').html() == '确认要取消添加手动评价吗？'){
			//取消添加评价
			 window.history.go( -1 );
    	}
		if($('#maskMain').find('p').html() == '确认保存评价吗？'){
    		//保存添加评价
    		$("#judgeForm").submit();
    	} 	
    });
	
</script>
</html>