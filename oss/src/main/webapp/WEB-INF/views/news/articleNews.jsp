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
<title>运营支撑系统OSS-新闻动态</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/news.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${rc.contextPath}/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${rc.contextPath}/ueditor/ueditor.all.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/blur.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>
</head>
<body>
<!-- onsubmit="return checkSubmit()" -->
<form id="sform" name="sform" action="addnewinfo" method="post" enctype="multipart/form-data" >
<input type="hidden" value="" id="tagArrVal"/>
<input type="hidden" value="" id="userListstr" name="userListstr">
<input type="hidden" value="" id="labelListstr" name="labelListstr">
<input type="hidden" value="" id="userType" name="userType">
<input type="hidden" value="" id="labelArrstr" name="labelArrstr">
<input type="hidden" value="" id="type" name="type">
<input type="hidden" value="" id="ismessage" name="ismessage">
<input type="hidden" value="" id="groupArrstr" name="groupArrstr">
<input type="hidden" value="" id="userArrstr" name="userArrstr">
<input type="hidden" value="" id="modifyName" name="modifyName">
<input type="hidden" value="" id="customtagstr" name="customtagstr">
    <div class="warp add-warp" id="addWarp">
        <div class="add-info">
        	<!--  -->
			   	<input type="hidden" value="${news.imgurl}" name="oldimage"/>
				<input type="hidden" value="${news.id}" name="id"/>
				<input type="hidden" value="${ossUser.name}" name="modifyName">
		    <div class="warp" id="formWarp">
		        <div class="inp-row inp-row1 clear">
		            <div class="left"><span>*</span>标题</div>
		            <div class="right clear">
		                <input type="text" class="inp-title" id="inpTitle" name="title" />
		                <!-- <p class="title-hint" id="limits">还可以输入80个字</p> -->
		            </div>
		        </div>
		        <div class="inp-row inp-row1 clear">
		            <div class="left"><span>*</span>摘要</div>
		            <div class="right clear">
		                <textarea type="text" class="inp-title" id="number" name="number"></textarea>
		            </div>
		        </div>
		        <div class="inp-row" id="assortUserTag">
		            <div class="left">关键字</div>
		            <div class="right clear" id="allTag">
		                <p class="custom-user custom-user-inp">
	                        <input type="text" class="inp-user" placeholder="输入关键字"/>
	                        <a href="javascript:;" class="delete delete-grey">×</a>
	                    </p>
	                    <a href="javascript:;" class="add-btn add-yq-btn more">更多</a>
		            </div>
		        </div>	
		        <div class="inp-row" id="assortUserTag">
		            <div class="left">操作</div>
		            <div class="right clear" id="allTag" style="line-height: 28px">
		                <label><input name="isActivity" type="checkbox" class="select_button"/>列表置顶 </label>
		                <label><input name="isActivity" type="checkbox" class="select_button"/>加至推荐位 </label> 
		            </div>
		        </div>
		        <div class="inp-row inp-row1 clear">
		            <div class="left">封面图</div>
		            <div class="right clear">
		            	<div class="img-warp">
		                    <img src="${rc.contextPath}/resources/images/img.png" alt="" id="pic"/>
		                </div>
		                <div class="file-inp">
		                    <input type="file" accept="image/jpg,png" id="upload" name="image"/>
		                    <a href="javascript:;">点击上传</a>
		                    <span>只能上传 jpg/png 文件</span>
		                </div>
		            </div>
		        </div>
		        <div class="inp-row inp-row1 clear">
		            <div class="left"><span>*</span>正文</div>
		            <div class="right">
		                <div class="input">
		                <script id="editor" name="detail" type="text/plain" style="width:100%;height:300px;"></script></div>
		            </div>
		        </div>        
		    </div>
        </div>        
    </div>
    
    <div class="add-footer">
        <div class="footer" id="foot">
            <div class="btn-group clear">
            	<a href="javascript:;" class="myCancel">取消</a>
            	<input type="button" id="bc" name="address" value="预览">  
            	<input type="button" id="bsend" name="address1" value="保存并发布">
            </div>
        </div>
    </div>
    <!--错误提示弹窗-->
    <div id="showEorr"></div>
</form>	
</body>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script type="text/javascript">
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var ue = UE.getEditor('editor');
/* $(function(){ */
    //图片上传 预览
    $("#upload").on("change",function(){
        var objUrl = getObjectURL(this.files[0]) ; //获取图片的路径，该路径不是图片在本地的路径
        if (objUrl) {
            $("#pic").attr("src", objUrl);
        }//将图片路径存入src中，显示出图片
    });
    function getObjectURL(file) {  //建立一個可存取到該file的url
        var url = null;
        if (window.createObjectURL != undefined) {// basic
            url = window.createObjectURL(file);
        } else if (window.URL!=undefined) { // mozilla(firefox)
            url = window.URL.createObjectURL(file) ;
        }else if (window.webkitURL!=undefined) { // webkit or chrome
            url = window.webkitURL.createObjectURL(file);
        }
        return url ;
    }
/* }); */
//关键字
//失去焦点
/* $('#assortUserTag').delegate('.inp-user','blur',function(){
	if ($(this).val().length == 0){
		  alert('标签名不能为空！');
	  }else{
		  var name = $(this).val();
		  var id = industryArr[$('.industryOn').index()];
		  $(this).parents('.custom-user-inp').find('.inp-user').attr('readonly',true).css('cursor','pointer');
 	      $(this).parents('.custom-user-inp').find('.delete').removeClass('delete-grey');
 	      $(this).parents('.custom-user-inp').removeClass('custom-user-inp').addClass('tag-user');  
	  }
}) */
$('#assortUserTag').delegate('.more','click',function(){
 	var inpVal = $(this).prev().find('.inp-user').val();
 	console.log(inpVal);
 	if(inpVal == ''){
 	    alert('请输入关键字');
    }else{
        $(this).siblings('.custom-user-inp').find('.inp-user').attr('readonly',true).css('cursor','pointer');
        $(this).siblings('.custom-user-inp').find('.delete').removeClass('delete-grey');
        $(this).siblings('.custom-user-inp').removeClass('custom-user-inp').addClass('tag-user');
        var oNode = $('<p class="custom-user custom-user-inp"><input type="text" class="inp-user" value="" placeholder="自定义标签"/><a href="javascript:;" class="delete delete-grey">×</a></p>');
        $(this).before(oNode);
    }
});
//删除自定义标签
 $('#assortUserTag').delegate('.custom-user .delete','click',function(){
     $(this).parents('.custom-user').remove();
     if($(".custom-user").length <= 0){
     	var oNode = $('<p class="custom-user custom-user-inp"><input type="text" class="inp-user" value="" placeholder="自定义标签"/><a href="javascript:;" class="delete delete-grey">×</a></p>');
        $('#allTag .more').before(oNode);
     }
 });
 //取消
 $('.myCancel').click(function(){
	 
 })
 //保存并发布
 var keys = '';
 $('#bsend').click(function(){
	 $('#assortUserTag').find('.custom-user').each(function(i){
		 console.log($(this).find('.inp-user').val());
   		if($(this).find('.inp-user').val() == ''){
   			
   		}else{
   			var str = $(this).find('.inp-user').val()+',';
   			console.log(str);
   			keys += str;
   		}
	 })
	 //拼接好的关键词
	 console.log(keys.substring(0,keys.length-1));
 })
</script>
</html>