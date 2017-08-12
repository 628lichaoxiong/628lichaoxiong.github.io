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
    <title>运营支撑系统OSS-新增译员</title>
    <link rel="stylesheet" href="${rc.contextPath}/resources/js/datepicker/jquery-ui.min.css" />
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
    <link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
    <link href="${rc.contextPath}/resources/css/cropbox.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
	.file {
	    position: relative;
	    display: inline-block;
	    background: #4D637B;
		border-radius: 4px;
	    padding: 6px 8px;
	    overflow: hidden;
	    color: #fff;
	    text-decoration: none;
	    text-indent: 0;
	    line-height: 20px;
	    top:4px;
	    left:20px;
	    font-size:12px;
	}
	.edit_head_user{
		position: relative;
		top:0px;
	    left:20px;
		font-size: 20px;
		color: #333333;
	}
	.file input {
	    position: absolute;
	    font-size: 100px;
	    right: 0;
	    top: 0;
	    opacity: 0;
	}
	.file:hover {
	    background: #4D637B;
	    color: #fff;
	    text-decoration: none;
	}
	.container{
		width:550px;
		height:400px;
		position:fixed;
		left:50%;
		top:10%;
		margin-left:-225px;
		z-index:9999;
		background: #FFFFFF;
		box-shadow: 0px 2px 4px 0px rgba(70,82,96,0.30);
		border-radius: 4px;
	}
	.close_container{
		position:absolute;
		right:20px; 
		top:20px; 
		width:21px;
		height:21px;
		color:#999;
		z-index:100000;
		text-align:center;
		line-height:21px;
		font-size:24px;
		cursor:pointer;
	}
	.header_title{
		font-size: 18px;
		color: #666666;
		font-weight:400;
		margin:20px;
	}
	.header_uploads_btn{
		width:100px;
		height:32px;
		line-height:32px;
		text-centen:center;
		background: #1DA1F2;
		border-radius: 4px;
		font-size:15px;
		color:#fff;
		border:none;
	}
	.jump_mask {
	    width: 100%;
	    height: 100%;
	    position: fixed;
	    left: 0;
	    top: 0;
	    z-index: 555;
	    background: #000;
	    opacity: 0.6;
	    display: none;
	}
	.company_judge{
		border: 1px solid #D2D4D7;
		width: 300px;
		height: 28px;
	}
	</style>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/ajaxfileupload.js" charset="UTF-8"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/transer.js"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/cropbox.js" charset="UTF-8"></script>
    <script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
</head>
<body>
<div id="jump_mask" class="jump_mask" style="display: none;"></div>
<div id="loading"><div class="msg"></div></div>
<input type="hidden" value="0" id="userid"/>
<input type="hidden" value="" id="photoSecond"/><!-- 第二次点击时 -->
<input type="hidden" value="0" id="isshow">
<div class="details_content">
    <form action="" class="transer_form" id="transerForm" >
        <div class="basic_info">
            <div class="row-inp row-inp-img">
                <div class="row-inp-left row-inp-require avatar"><img src="${rc.contextPath}/resources/images/photo.svg" alt="photo" class="photo"/></div>
                <div class="row-inp-right">
                    <!-- <input type="file" class="inp-file" id="imgFile" name="imgFile"/> -->
                    <a href="javascript:;" class="edit_head btn">上传头像</a>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">译员姓名</div>
                <div class="row-inp-right">
                    <input type="text" class="inp name" placeholder="张三" />
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">手机号</div>
                <div class="row-inp-right">
                    <input type="text"  class="inp phone-num" placeholder="13800000000" />
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">译员编号</div>
                <div class="row-inp-right">
                    <input type="text" class="inp transer-number" placeholder="PE000" />
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">性别</div>
                <div class="row-inp-right">
                    <div class="spinner-warp">
                        <p class="box"><input type="text" class="state sex" placeholder="男" value="男" readonly/><a href="javascript:;">下拉箭头</a></p>
                        <div class="spinner-box">
                            <ul>
                                <li>男</li>
                                <li>女</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">出生年份</div>
                <div class="row-inp-right">
                    <div class="spinner-warp spinner-mg">
                        <p class="box"><input type="text" class="state age" placeholder="1953" value="1990" readonly/><a href="javascript:;">下拉箭头</a></p>
                        <div class="spinner-box spinner-box-max">
                            <ul>
                             <c:forEach begin="1950" end="2000" var="v" >
                               	<li>${v}</li>
                              </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
           
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">擅长语种</div>
                <div class="row-inp-right">
                    <div class="spinner-warp spinner-mg">
                        <p class="box"><input type="text" class="state good-lang-first" placeholder="第一外语" value="英语" readonly/><a href="javascript:;">下拉箭头</a></p>
                        <div class="spinner-box">
                            <ul id="firstPrice">
                               <c:forEach var="language" items="${objj.data.result}" >
	                               	<li id="${language.value}">${language.name}</li>
                               </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div style="display: inline-block;margin-right: 15px;">
                    	<p style="float: left;height: 28px;line-height: 28px;">报价：</p>
                    	<input  class="first_price" type="text" value="800" style="border: 1px solid #D2D4D7;height: 28px;text-indent: 6px;" onkeyup="value=value.replace(/\D/g,'')"
onafterpaste="value=value.replace(/\D/g,'')">
                    </div>
                    <div class="spinner-warp">
                        <p class="box"><input type="text" class="state good-lang-second" placeholder="第二外语" value="选填" readonly/><a href="javascript:;">下拉箭头</a></p>
                        <div class="spinner-box">
                            <ul id="secondPrice">
                            	<li>选填</li>
                                <c:forEach var="language" items="${objj.data.result}" >
                               	 <li id="${language.value}">${language.name}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div  style="display: inline-block;margin-left:10px;">
                    	<p style="float: left;height: 28px;line-height: 28px;">报价：</p>
                    	<input class="second_price" type="text" value="800" style="border: 1px solid #D2D4D7;height: 28px;text-indent: 6px;" onkeyup="value=value.replace(/\D/g,'')"
onafterpaste="value=value.replace(/\D/g,'')">
                    </div>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">翻译经验（年）</div>
                <div class="row-inp-right">
                    <input type="text" class="inp trans-exp" placeholder="1" />
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">常驻地</div>
                <div class="row-inp-right">
                    <input type="text" class="inp resident" placeholder="北京"/>
                    <span class="note">（注：常驻地在国内录入城市名，例如：北京；常驻地在国外录入国家名，例如：西班牙）</span>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">学历</div>
                <div class="row-inp-right">
                    <input type="text" class="inp education" placeholder="本科"/>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">服务次数（次）</div>
                <div class="row-inp-right">
                    <input type="text" class="short-inp srv-times" placeholder="1"/> <span class="add">+</span> <input type="text" class="short-inp estimate-times" placeholder="10"/>
                    <span class="note">（注：两个输入框录入的数字分别为译员的真实服务次数和平台估计次数）</span>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left row-inp-require">海外经历</div>
                <div class="row-inp-right">
                    <div class="spinner-warp">
                        <p class="box"><input type="text" class="state overseas-exp" placeholder="有" value="有" readonly/><a href="javascript:;">下拉箭头</a></p>
                        <div class="spinner-box">
                            <ul>
                                <li>有</li>
                                <li>无</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row-inp good-field">
                <div class="row-inp-left row-inp-require">擅长领域</div>
                <div class="row-inp-right">
                    <!-- <span class="filed">国际工程</span>
                    <span class="filed">IT/电子/通信</span>
                    <span class="filed">互联网/智能科技</span>
                    <span class="filed">机械/制造</span>
                    <span class="filed">能源/信息情报</span>
                    <span class="filed">金融/法律/培训</span>
                    <span class="filed">体育/传媒/文化</span>
                    <span class="filed">医疗/卫生</span>
                    <span class="filed">政府/会议会展</span>
                    <span class="filed">其他</span> -->
                     <c:forEach var="label" items="${labelObj.data.result}" >
                               	<span class="filed">${label.labelName}</span>
                     </c:forEach>
                </div>
            </div>
            <div class="row-inp character-tags">
                <div class="row-inp-left row-inp-require">官方评价</div>
                <div class="row-inp-right tag-warp clear">
                	<input type="text" class="company_judge">
                </div>
            </div>
            <div class="row-inp character-tags">
                <div class="row-inp-left">个性标签</div>
                <div class="row-inp-right tag-warp clear">
                	<div class="tag-list clear">
                		<div class="tag-inp" ><input type="text" class="inp-tag-cont" placeholder="请输入标签内容"/><a href="javascript:;" class="delete">删除</a></div>
                	</div>
                   	<a href="javascript:;" class="btn">+ 更多</a>
                </div>
            </div>
        </div>

        <div class="basic_info other-info">
	        <h2	class="title">教育经历</h2>
	         <div class="row-inp">
                <div class="row-inp-left">教育经历1</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="eduBeginTime1" placeholder="入学时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class="" id="eduEndTime1" placeholder="毕业时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="eduSchool1" placeholder="学校名称"/>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left">教育经历2</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="eduBeginTime2" placeholder="入学时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class=""  id="eduEndTime2"  placeholder="毕业时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="eduSchool2" placeholder="学校名称"/>
                </div>
            </div>
	    </div>

	    <div class="basic_info other-info">
	        <h2	class="title">最近工作经历</h2>
	         <div class="row-inp">
                <div class="row-inp-left">工作经历1</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="wrokBeginTime1" placeholder="开始时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class="" id="wrokEndTime1" placeholder="结束时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="company1" placeholder="企业名称" />
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left">工作经历2</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="wrokBeginTime2" placeholder="开始时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class="" id="wrokEndTime2" placeholder="结束时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="company2" placeholder="企业名称"/>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left">工作经历3</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="wrokBeginTime3" placeholder="开始时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class="" id="wrokEndTime3" placeholder="结束时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="company3" placeholder="企业名称"/>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left">工作经历4</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="wrokBeginTime4" placeholder="开始时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class="" id="wrokEndTime4" placeholder="结束时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="company4" placeholder="企业名称"/>
                </div>
            </div>
            <div class="row-inp">
                <div class="row-inp-left">工作经历5</div>
                <div class="row-inp-right">
                    <input type="text" class="" id="wrokBeginTime5" placeholder="开始时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/><span class="add">—</span>
                    <input type="text" class="" id="wrokEndTime5" placeholder="结束时间" readonly onClick="WdatePicker({skin:'whyGreen',maxDate:'%y-%M-%d',dateFmt:'yyyy.MM.dd'})"/>
                    <input type="text" class="inp2" id="company5" placeholder="企业名称"/>
                </div>
            </div>
	    </div>

	    <div class="basic_info other-info">
	        <h2	class="title">证书<span>（注：最多添加3个证书）</span></h2>
	         <div class="row-inp certificate">
                <div class="tag-warp clear">
                	<div class="tag-list clear">
                		<div class="tag-inp"><input type="text" class="inp-tag-cont" placeholder="填写证书名称"/><a href="javascript:;" class="delete">删除</a></div>
                	</div>
                   	<a href="javascript:;" class="btn">+ 更多</a>
                </div>
            </div>
	    </div>

	    <div class="basic_info other-info">
	        <h2	class="title">个人描述</h2>
	         <div class="row-inp">
               <textarea placeholder="请填写内容" id="userInfo"></textarea>
            </div>
	    </div>

	    <div class="btn-group clear">
	    	<input type="button" value="取消" class="cancel-btn">
	    	<input type="button" value="保存" class="save-btn">
	    	<input type="hidden" value="" id="haveHeadUrl">
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

	<!-- uploads head start -->
		<div class="container" style="display:none;">
		  <!-- 关闭设置头像弹窗 -->
		  <h4 class="header_title">修改头像</h4>
		  <div class="close_container">×</div>	
		  <div class="imageBox">
		    <div class="thumbBox"></div>
		    <div class="spinner" style="display: none; ">
		    	<div class="new-contentarea tc"> 
			    	<a href="javascript:;" class="upload-img">
			        	<label for="upload-file">选择图片</label>
			        </a>
			      	<input type="file" class="inp-file" name="uploadfile" id="uploadfile" />
			    </div>
			    支持jpg、png格式
		    </div>
		  </div>
		  <div class="action clearfix"> 
		    <!-- <input type="file" id="file" style=" width: 200px">-->
		    <input type="button" id="btnZoomIn" class="Btnsty_peyton fl" value="+"  >
		    <input type="button" id="btnZoomOut" class="Btnsty_peyton fl" value="-" >
		    <input type="button" id="btnCrop"  class="header_uploads_btn fr" value="上传">
		  </div>
		</div>
		<!-- uploads head end -->
    <script src="${rc.contextPath}/resources/js/datepicker/jquery-ui.min.js"></script>
	<script src="${rc.contextPath}/resources/js/datepicker/datepicker-zh-TW.js"></script>
	<script type="text/javascript">
	//uploads head
	$(".edit_head").click(function(){
		$(".container").show();
		$("#jump_mask").show();
	})
	$(".close_container").click(function(){
		$(".container").hide();
		$("#jump_mask").hide();
	})
	/* 报价 */
	$('#firstPrice').on('click','li',function(){
		var price = $(this).attr('id');
		$('.first_price').val(price);
	})
	$('#secondPrice').on('click','li',function(){
		var price = $(this).attr('id');
		$('.second_price').val(price);
	})
	$(window).load(function() {
		var options =
		{
			thumbBox: '.thumbBox',
			spinner: '.spinner',
			imgSrc: ''
		}
		var cropper = $('.imageBox').cropbox(options);
		$('#uploadfile').on('change', function(){
			var reader = new FileReader(); 
			reader.onload = function(e) {
				options.imgSrc = e.target.result;
				cropper = $('.imageBox').cropbox(options);
			}
			reader.readAsDataURL(this.files[0]);
 			//this.files = []; 
		})
		$('#btnCrop').on('click', function(){
			if($(".spinner").css("display")!="none"){
		      alert("请先选择图片！");
		      return false;
		    }
		    $("#jump_mask").hide();
			var img = cropper.getDataURL();
			var bol=cropper.getBlob();
			$('.avatar').html('');
			 $('.avatar').append('<img src="'+img+'" align="absmiddle" style="width:80px;height: 80px; box-shadow:0px 0px 12px #7E7E7E; float:left; margin-right:20px;">'); 
			$(".container").hide();
	        $(".imageBox").attr("style","");
	        $(".spinner").css("display","block");
	        $("#haveHeadUrl").val("true");
		})
		$('#btnZoomIn').on('click', function(){
			cropper.zoomIn();
		})
		$('#btnZoomOut').on('click', function(){
			cropper.zoomOut();
		})
	});
	
	 
	
	</script>
	<script type="text/javascript">
		var ctx="${rc.contextPath}";
		var goodFieldNum=0;
	    var goodField=[];//擅长领域
		var tagStr=[];
		var certificateStr=[];
	</script>
	<script>
		$( function() {
	    	$( ".inp1" ).datepicker();
	  	} );	
		
		$(".first_price").blur(function(){
			var price=$(".first_price").val();
			if(price%10!=0){
				alert("金额必须是10的整数倍");
			}
		});
		
		$(".second_price").blur(function(){
			var price=$(".second_price").val();
			if(price%10!=0){
				alert("金额必须是10的整数倍");
			}
		});
	</script>
</body>
</html>