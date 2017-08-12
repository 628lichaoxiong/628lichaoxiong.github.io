<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%
String cpath = request.getContextPath();
String cbasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
String cbasePath2 = "http://oss.nashaapp.com";
%>

<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS</title>
<link href="<%=cbasePath%>/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="<%=cbasePath%>/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="<%=cbasePath%>/resources/css/dialog.css" rel="stylesheet" type="text/css" />
<link href="<%=cbasePath%>/resources/css/home.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=cbasePath%>/resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="<%=cbasePath%>/resources/js/dialog.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js" charset="UTF-8"></script>
</head>
<body>
<body scroll="no" class="objbody">
<div class="header">
    <div id="jump_mask" class="jump_mask" style="display: none;"></div>
	<div class="header_box">
		<div class="logo"><img src="<%=cbasePath%>/resources/images/logo.png" alt=""></div>
		<div class="rt-col">
			<div class="tab_style cut_line">
				<a href="#" id="update_passwd"><img src="<%=cbasePath%>/resources/images/btn_password@3x.png"></a>
				<a href="<%=cbasePath%>"><img src="<%=cbasePath%>/resources/images/icon/logout.png"></a>
				<span>你好，${username}</span>
			</div>
			<div id="current_pos" class="menu_bar" style="position:relative;"></div>
			<!-- 客服 -->
			<div class="chat clear">
				<img src="<%=cbasePath%>/resources/images/Group 5@2x.png" alt="">
			</div> 
		</div>
	</div>
</div>
<div id="content">
	<div class="left_menu">
    	<div id="Scroll">
			<div id="leftMain">
			</div>   
		</div>
    </div>
    <div class="right_content">
		<div class="content" style="position:relative; overflow:hidden">
			<iframe name="right" id="rightMain" src="" frameborder="false" scrolling="auto" style="border:none;" width="100%" height="auto" allowtransparency="true">
			</iframe>
		</div>
    </div>
    <!-- 修改密码 -->
    <div class="card_pay">
        <div class="title">
            <h2>修改密码</h2>
            <div class="close_container">×</div>
        </div>
        <div class="card_change">
          <form action="">
           <input type="hidden" value="${loginId}" id="loginId" name="loginId"/> 
              <div class="card_message">
                  <div class="card-form">
                      <p>当前密码</p>
                      <input name="oldPasswd" id="oldPasswd" value="" type="password"/>
                  </div>
                  <div class="card-form">
                      <p>新密码</p>
                      <input  name="newPasswd" maxlength="20" id="newPasswd" value=""   type="password"/>
                  </div>
                  <div class="card-form">
                      <p>确认密码</p>
                      <input name="newPasswdCon" maxlength="20" id="newPasswdCon" type="password" value="" />
                  </div>
              </div>
              <div class="card-change">
                  <input class=" cancel" type="button" value="取消"/>
                  &nbsp;&nbsp;<input type="button" class="confirm" id="updatePassword" value="确认修改"/>
              </div>
          </form>
        </div>
        </div>
</div>
<script type="text/javascript" src="<%=cbasePath%>/resources/js/common.js"></script>
<script type="text/javascript">
var open;
if(!Array.prototype.map)
Array.prototype.map = function(fn,scope) {
  var result = [],ri = 0;
  for (var i = 0,n = this.length; i < n; i++){
	if(i in this){
	  result[ri++]  = fn.call(scope ,this[i],i,this);
	}
  }
return result;
};
 
var getWindowSize = function(){
	return ["Height","Width"].map(function(name){
		return window["inner"+name] ||
		document.compatMode === "CSS1Compat" && document.documentElement[ "client" + name ] || document.body[ "client" + name ]
	});
}
window.onload = function (){
	//去加载左侧菜单 leftMain
	$.ajax({
        type:'POST',  
        url:'<%=cbasePath%>index/leftFrame',  
        data:{},
        dataType:"html",  
        async:false, 
        success:function(result){
            $("#leftMain").html(result);
        },
        error:function(result){
            alert("服务器出现异常");
        }
    });
	if(!+"\v1" && !document.querySelector) { // for IE6 IE7
	  document.body.onresize = resize;
	} else {
	  window.onresize = resize;
	}
	function resize() {
		wSize();
		return false;
	}
}
function wSize(){
	//这是一字符串
	var str=getWindowSize();
	var strs= new Array(); //定义一数组
	strs=str.toString().split(","); //字符分割
	var heights = strs[0]-66,Body = $('body');$('#rightMain').height(heights);
	//iframe.height = strs[0]-46;
	if(strs[1]<1200){
		$('.header').css('width',1200+'px');
		$('#content').css('width',1200+'px');
		Body.attr('scroll','');
		Body.removeClass('objbody');
	}else{
		$('.header').css('width','auto');
		$('#content').css('width','auto');
		Body.attr('scroll','no');
		Body.addClass('objbody');
	}

	var openClose = $("#rightMain").height();
	//$("#Scroll").height(openClose-10);
	$("#Scroll").height(openClose);
}
wSize();
function _MP_FIRST(url, index) {
    $('#leftMain li.on, #leftMain h3.on').removeClass('on');
    $('#menu'+index).addClass("on");
}
function _MP(url, index) {
	$('#leftMain li.on, #leftMain h3.on').removeClass('on');
	$('#menu'+index).addClass("on");
	var uu="<%=cbasePath%>"+url;
	$("#rightMain").attr('src', uu);

	/*/获取面包屑，此处逻辑还需要完善
	$.get("bar.php", function(data){
		$("#current_pos").html(data);
	});*/
}

/* if("${group}"== 1){
	_MP('user/userList', 0);//显示第一个菜单
}
if("${group}"==2){
	_MP('resume/getUserResumeList', 0);//显示第一个菜单
} */
//左侧下拉菜单
(function($){
	$("#leftMain").on('click','h3',function(){
		$(this).addClass('on');
		$(this).parents('#leftMain').find('h3,a').css('backgroundColor','#4D637B');
		$(this).find('a').css('backgroundColor','#345071');
	})
	/* $("#leftMain h3 .switchs").click(function(){
		var submenu = $(this).parent().next();
		if(submenu.children('li').length==0) return false;
		if(submenu.is(':visible')) {
			submenu.hide();
			$(this).removeClass('on');
		}
		else {
			submenu.show();
			$(this).addClass('on');
		}
	}); */
})(jQuery);

//二级菜单
(function($){
	$('#leftMain').on('click','h3 a',function(){
		console.log($(this));
		/* $(this).parents().find('h3 a').css('backgroundColor','#4D637B');
		$(this).css('backgroundColor','#1DA1F2'); */
		if($(this).parents('h3').find("ul").is(":hidden")){
			console.log('111');
		/* if(open == true){ */
			/* console.log('222'); */
            $(this).parents('h3').find("ul").show();
            $(this).parents('h3').on('click','ul li',function(){
                $('ul li').css('backgroundColor','#4D637B');//暗色
                $(this).css('backgroundColor','#1DA1F2');//蓝色
            })
            //直接打开第一个二级菜单
            $('#leftMain li.on, #leftMain h3.on').removeClass('on');
            $('ul li').css('backgroundColor','#4D637B');
            $(this).parents('h3').find("ul li:first").css('backgroundColor','#1DA1F2');
        }else{    
        	$(this).parents('h3').find("ul").hide();
            open = false;   
            $(this).css('backgroundColor','#4D637B');
        }   
	})
	/* $("#menu4 a").click(function(){		
		alert(2222);
		if(open == true){
			alert(444);
			$("#menu4").find("ul").hide();
			open = false;	
			$('#menu4 li').css('backgroundColor','#4D637B');
		}else{			
			alert(333);
			$("#menu4").find("ul").show();
			open = true;
		}	
	}); */
})(jQuery);	




(function(){
    var addEvent = (function(){
             if (window.addEventListener) {
                return function(el, sType, fn, capture) {
                    el.addEventListener(sType, fn, (capture));
                };
            } else if (window.attachEvent) {
                return function(el, sType, fn, capture) {
                    el.attachEvent("on" + sType, fn);
                };
            } else {
                return function(){};
            }
        })(),
    Scroll = document.getElementById('Scroll');
    // IE6/IE7/IE8/Opera 10+/Safari5+
    addEvent(Scroll, 'mousewheel', function(event){
        event = window.event || event ;
		if(event.wheelDelta <= 0 || event.detail > 0) {
				Scroll.scrollTop = Scroll.scrollTop + 44;
			} else {
				Scroll.scrollTop = Scroll.scrollTop - 44;
		}
    }, false);

    // Firefox 3.5+
    addEvent(Scroll, 'DOMMouseScroll',  function(event){
        event = window.event || event ;
		if(event.wheelDelta <= 0 || event.detail > 0) {
				Scroll.scrollTop = Scroll.scrollTop + 44;
			} else {
				Scroll.scrollTop = Scroll.scrollTop - 44;
		}
    }, false);

})();
$("#update_passwd").click(function(){
    $(".card_pay").show();
})
$(".close_container").click(function(){
    $(".card_pay").hide();
})
var ctx='${rc.contextPath}';
// 修改密码
$("#updatePassword").click(function(){
    var oldPasswd=$.trim($("#oldPasswd").val());
    var newPasswd=$.trim($("#newPasswd").val());
    var newPasswdCon=$.trim($("#newPasswdCon").val());
    if(oldPasswd == '' ){ 
               zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"当前密码必须填写",function(r) {})
               $(".card_pay").show();
               return false;
     }
    if(newPasswd == ''){
            zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"新密码必须填写",function(r) {})
            $(".card_pay").show();
            return false;
   }
    if(newPasswdCon == ''){
       zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"确认新密码必须填写",function(r) {})
       $(".card_pay").show();
       return false;
     }
    if(newPasswd != newPasswdCon){
        zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"两次密码必须不一致",function(r) {})
        $(".card_pay").show();
        return false;
      }
    $.ajax({
        type:'post',
        url:'${rc.contextPath}/updatePasswd',
        data:{loginId:$("#loginId").val(),oldPasswd:oldPasswd
            ,newPasswd:newPasswd},
        dataType:"json",
        async:false,
        success:function(result){
            if(result.status==200){
            	zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',"修改成功",function(r) {
            		 window.location.href="${rc.contextPath}/";
            	})
            }else{
                 zdalert('<img src="'+ctx+'/resources/images/tishi@2x.png"',result.msg,function(r) {})
                 $(".card_pay").show();
                 return false; 
            }
        }
    });
});
//客服聊天
$('.chat').click(function(){
	window.open("http://qiyukf.com/register/signup?tag=login");
})
</script>
</body>
</html>
