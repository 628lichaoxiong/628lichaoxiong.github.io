<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%
String cbasePath = request.getScheme() + "://"
		+ request.getServerName() + ":" + request.getServerPort()
		+ request.getContextPath()+ "/"; 
%>

<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>那啥运营管理平台OSS</title>
<link href="<%=cbasePath%>/resources/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=cbasePath%>/resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="<%=cbasePath%>/resources/js/jquery.JPlaceholder.js" charset="UTF-8"></script>
<script language="JavaScript">
<!--
	if(top!=self)
	if(self!=top) top.location=self.location;
//-->
</script>
</head>
<body onload="checkMes()">
<div class="login_wrap" >
	<div class="log_logo"><img src="<%=cbasePath%>/resources/images/log_logo.jpg" /></div>
	<div class="login_box">
	<form role="form" id="loginForm" action="<%=cbasePath%>login" method="post">
		<div class="textline"><input name="name"  id="name" type="text" value="" placeholder="账号" /></div>
		<div class="textline"><input name="password" id="password" type="password" value="" placeholder="密码" /><!-- <a href="forget_password.html">忘记密码?</a> --></div>
		<div class="textline">
		    <input type="text"  class="text1" id="randomCode" placeholder="验证码"  name="randomCode" value="" maxlength="4">
            <img id="randomCodeImg" src="<%=cbasePath%>randomCodeCheck" alt="看不清？点击更换" style="cursor:hand;" onClick="refreshRandomCode()"/>                          
        </div>
		<p id="error_msg"></p>
		<!-- <p class="autologin"><i id="autoflag" class="checkbox" onclick="setAuto(this)"></i> 下次自动登录</p> -->
		<input type="button" value="立即登录" class="login_btn" id="login_btn" onclick="login()"/>
		<!-- <input  type="submit" value="立即登录" class="login_btn" /> -->
		</form>
	</div>
</div>
<script language="JavaScript">
function checkMes(){
	if("${msg}"){
		$('#error_msg').html("${msg}");
	}
}
function refreshRandomCode(){
    $("#randomCodeImg").attr("src","randomCodeCheck?time="+new Date());
}
function login(){
	var name = $('#username').val();
	var pwd = $('#password').val();
	var randomCodeImg = $('#randomCode').val();
	if(name==''){
		$('#error_msg').html('请输入用户名');
		return false;
	}

	if(pwd==''){
		$('#error_msg').html('请输入密码');
		return false;
	}
	if(randomCodeImg==''){
		$('#error_msg').html('请输入验证码');
		return false;
	}
	$('#error_msg').html(''); 
	$("#loginForm").submit();
	//autologin(name, pwd);

	return true;
}

	var loging = false;
	function setAuto(dom){
		var o = $(dom);
		if(o.hasClass('select')) o.removeClass('select');
		else o.addClass('select');
	}

	function autologin(user, pwd){
		if(loging==true) return false;

		loging = true;
		//ajax登录
		//$.post('', { name: name, pwd: pwd},
			//function(msg){
				loging = false;

				//登录成功则执行
				if($('#autoflag').hasClass('select')) var auto = 1;
				else auto=0;
				setCookie('sha_auto_login', auto, 10);
				setCookie('sha_login_user', user, 10);
				setCookie('sha_login_pwd', pwd, 10);
				//跳转
				//window.location.href="";
			//});
	}
	function getCookie(name)
	{
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
		if(arr=document.cookie.match(reg))
			return unescape(arr[2]);
		else
			return null;
	}
	function setCookie(c_name, value, expiredays){
		var exdate=new Date();
		exdate.setDate(exdate.getDate() + expiredays);
		document.cookie=c_name+ "=" + escape(value) + ((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
	}

	//自动登录
	var auto = getCookie('sha_auto_login');
	if(auto == 1) {
		var u = getCookie('sha_login_user');
		var p = getCookie('sha_login_pwd');
		autologin(u,p);
	}
$("#name,#password,#randomCode").bind('keyup', function (event) {
	    if (event.keyCode == 13) {
	    	login(); 
	    }
	});
</script>
</body>
</html>