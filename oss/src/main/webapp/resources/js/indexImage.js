
//表单验证
$('#formID #submitCard').click(function(){
	if($("#imageName").val().length == 0){
    	alert("请填写轮播名称！");
    	return false;   
    }
    if($("#uploadfileImage").val().length == 0){
	      alert("请上传轮播图片！");
	      return false;   
	}
    if($("#urlType").val() == 0){
    	var skipUrl = $('#formID #skipUrl').val();
        if(skipUrl.length == 0){
                alert('请输入跳转地址');
                return false;
        }
	}else{
		var serarchId = $('#formID #serarchId').val();
        if(serarchId.length == 0){
                alert('请输入搜索编号');
                return false;
        }
        if($("#uploadfileImage1").val().length == 0){
  	      alert("请上传专题图片！");
  	      return false;   
        }
	}
    
	var id =$("#id").val();
    var url =ctx+"/indexImage/addIndexImage";
    if(id !=null && id !=''){
    	url =ctx+"/indexImage/updateIndexImage";
    } 
    var photoSecond=$("#photoSecond").val();
    var photoSecond1=$("#photoSecond1").val();
	$.ajaxFileUpload({
    	        url: url,
    	        type: 'post',
    	        data: {id:id,imageName:$("#imageName").val(),skipUrl:$("#skipUrl").val(),photoSecond:photoSecond,
    	        	photoSecond1:photoSecond1,serarchId:$("#serarchId").val(),urlType:$("#urlType").val(),type:$("#type  option:selected").val()},
    	        secureuri: false, //一般设置为false
    	        fileElementId: ['uploadfile','uploadfile1'], // 上传文件的id、name属性名
    	        dataType: 'text', //返回值类型，一般设置为json、
    	        success: function(data){ 
    	        	var result=jQuery.parseJSON(jQuery(data).text());	
    	        	if(result.status==200){
    	        		 alert("操作成功！");
    	                 window.location.href = ctx+"/indexImage/getIndexImageList";
    	        	}else{
    	        		$("#photoSecond").val(result.data.result.imageUrl);
    	        		$("#photoSecond1").val(result.data.result.imageSubjectUrl);
    	        		alert(result.msg); 
    	        	}
    	        },
    	        error : function(data) {
    	                alert("系统异常！请稍后重试");
    	        }
    	    });
});


//uploads head
$(".edit_head").click(function(){
	$("#container").show();
	$("#jump_mask").show();
})
$("#close_container").click(function(){
	$("#container").hide();
	$("#jump_mask").hide();
})
$(".edit_head1").click(function(){
	$("#container1").show();
	$("#jump_mask").show();
})
$("#close_container1").click(function(){
	$("#container1").hide();
	$("#jump_mask").hide(); 
})

$(window).load(function() {
		var options =
		{
			thumbBox: '#thumbBox',
			spinner: '#spinner',
			imgSrc: ''
		}
		var cropper = $('#imageBox').cropbox(options);
		$('#uploadfile').on('change', function(){
			var reader = new FileReader(); 
			reader.onload = function(e) {
				options.imgSrc = e.target.result;
				cropper = $('#imageBox').cropbox(options);
			}
			reader.readAsDataURL(this.files[0]);
 			//this.files = []; 
		})
		$('#btnCrop').on('click', function(){
			if($("#spinner").css("display")!="none"){
		      alert("请先选择图片！");
		      return false;
		    }
		    $("#jump_mask").hide();
			var img = cropper.getDataURL();
			var bol=cropper.getBlob();
			$('#avatar').html('');
			 $('#avatar').append('<img src="'+img+'" align="absmiddle" style="width:80px;height: 80px; box-shadow:0px 0px 12px #7E7E7E; float:left; margin-right:20px;">'); 
			$("#container").hide();
	        $("#imageBox").attr("style","");
	        $("#spinner").css("display","block");
	        $("#uploadfileImage").val(img);
		})
		$('#btnZoomIn').on('click', function(){
			cropper.zoomIn();
		})
		$('#btnZoomOut').on('click', function(){
			cropper.zoomOut();
		})
		uploadImage1();
	});
function uploadImage1(){
	var options =
	{
		thumbBox: '#thumbBox1',
		spinner: '#spinner1',
		imgSrc: ''
	}
	var cropper = $('#imageBox1').cropbox(options);
	$('#uploadfile1').on('change', function(){
		var reader = new FileReader(); 
		reader.onload = function(e) {
			options.imgSrc = e.target.result;
			cropper = $('#imageBox1').cropbox(options);
		}
		reader.readAsDataURL(this.files[0]);
			//this.files = []; 
	})
	$('#btnCrop1').on('click', function(){
		if($("#spinner1").css("display")!="none"){
	      alert("请先选择图片！");
	      return false;
	    }
	    $("#jump_mask").hide();
		var img = cropper.getDataURL();
		var bol=cropper.getBlob();
		$('#avatar1').html('');
		 $('#avatar1').append('<img src="'+img+'" align="absmiddle" style="width:80px;height: 80px; box-shadow:0px 0px 12px #7E7E7E; float:left; margin-right:20px;">'); 
		$("#container1").hide();
        $("#imageBox1").attr("style","");
        $("#spinner1").css("display","block");
        $("#uploadfileImage1").val(img);
	})
	$('#btnZoomIn1').on('click', function(){
		cropper.zoomIn();
	})
	$('#btnZoomOut1').on('click', function(){
		cropper.zoomOut();
	})
}
function subjectSwith(value){
    if(value ==0){ 
        $(".subjectHide").css("display","block");
        $(".subjectShow").css("display","none");
    }
    if(value ==1){
    	$(".subjectHide").css("display","none");
        $(".subjectShow").css("display","block");
    } 
}
