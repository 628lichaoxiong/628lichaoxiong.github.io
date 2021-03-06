<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<html>
<head lang="en">
<meta charset="UTF-8">
<title>用户管理</title>
<script src="${sourcePath}/resources/assets/js/jquery.min.js"></script>
<script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
<link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${sourcePath}/resources/assets/css/font.css" rel="stylesheet">
<style>
#userInfoDiv div {
	padding: 10px;
}
</style>
</head>
<body>
	<div class="container-fluid">

		<ol class="breadcrumb">
			<li><a href="#">干货仓库</a></li>
			<li><a href="${cbasePath}dry/dryList">干货列表</a></li>
			<li><a
				href="${cbasePath}dry/dryDetail?dryid=${resuserTopic.data.result.id}">干货详情:
					<small> ${resuserTopic.data.result.message  }</small>
			</a></li>
			<li class="active">大咖用户背景图片修改</li>
		</ol>

		<div class="row">
			<div class="col-xs-3">
				<img class="thumbnail col-xs-12" name="picUrl" id="picUrl"
					src="${resuserDetail.data.result.bgUrl}" alt="" />

			</div>

			<div class="col-xs-9">
				<form role="form" method="post"
					action="${cbasePath}user/submitvuserbgurl?id=${resuserDetail.data.result.id}" enctype="multipart/form-data">

					<input type="hidden" value="${resuserDetail.data.result.bgUrl}" name="oldLogoUrl"/>
					<input type="hidden" value="" id="logoUrl" name="logoUrl"/>
					
					<input type="hidden" value="" id="height" name="height"/>
					<input type="hidden" value="" id="width" name="width"/>
					<!-- <div class="form-group">
						<label for="exampleInputEmail1">如果要修改请上传干货的图片</label>  
						<input id="file" type="file" name="file" /> 
					</div> -->
					<div class="form-group">
						<!-- <label for="exampleInputEmail1">文件地址（图片/语音）</label> <input type="text"
							name="fileUrl" class="form-control" id="exampleInputEmail1"
							placeholder="">  -->
						<div class="media" id="picFrame">
							<div class="media-body">
								<div id="container">
									<div class="row">
										<div class="col-xs-9">
											<label for="exampleInputEmail1">修改课程图片</label>
											<button id="pic" type="button" class="btn btn-default">上传图片</button>
										</div>
									</div>

								</div>
							</div>

						</div>
					</div>

					<button type="submit" class="btn btn-default">Submit</button>
				</form>
			</div>
		</div>


	</div>
	<script src="${cbasePath}/resources/assets/js/html5shiv.js"></script>
	<script src="${cbasePath}/resources/assets/js/plupload.full.min.js"></script>
	<script src="${cbasePath}/resources/assets/js/qiniu.js"></script>
	<script src="${cbasePath}/resources/assets/js/moxie.min.js"></script>
	<script>
		$(function() {
			/* $("#searchIt").click(function(){
				window.location.href = "${cbasePath}user/userList?keyword="+encodeURI($("#keyword").val());
			}); */
			$(".btnDelete").click(function() {
				if (window.confirm('你确定要删除吗？')) {
					window.location.href = $(this).attr("data");
				} else {

				}
			});
				
				//二级分类联动
				$("#categorySelect").change(function(){
					//
					var categoryId = $("#categorySelect").val();
					if(categoryId != ''){
						$.ajax({
							url : '${cbasePath}category/getChildCategory',
							data : {'categoryId' : categoryId},
							type : 'post',
							dataType : 'json',
							success : function(result){
								var categorys = result.data.result.childCategory;
								var $childCategorySelect = $("#childCategorySelect");
								$childCategorySelect.empty();
								$.each(categorys, function(index, content){
									if(content.id != ''){
										$childCategorySelect.append("<option value='" + content.id + "'>" + content.categoryName + "</option>");
									}
								});
							}
						});
					}
				});	
				upload("10007");
		});
		
		function upload(s){
		    var uploader = Qiniu.uploader({
		        runtimes: 'html5,flash,html4',
		        browse_button: 'pic',
		        container: 'container',
		        drop_element: 'container',
		        max_file_size: '100mb',
		        flash_swf_url: '${cbasePath}/js/Moxie.swf',
		        dragdrop: true,
		        chunk_size: '4mb',
		        uptoken_url: '${cbasePath}/knowledge/getToken?ckey='+s,
		        domain: 'tpublic.qiniudn.com',
		       	filters:"{mime_types : [{ title : \"Image files\", extensions : \"jpg,gif,png\" }  ],  max_file_size : '2mb', \r\n  prevent_duplicates : true}",
		        auto_start: true,
		        multi_selection:false,
		        
		        init: {
		             'UploadComplete': function() {
		             	
		            }, 
		            'FileUploaded': function(up, file, info) {//完成一张图片之后
		            	
		            	var res=$.parseJSON(info);
		            	var imgUrl = 'http://cdn.video.ztiao.cn/' + res.key;
		            	jQuery.getJSON(imgUrl + '?imageInfo',
		            			function(result){
	            			var height = result.height; //图片高度
	            			var width = result.width; //图片宽度
	            			//通过dom动态添加image
	            			var $imgContainer = jQuery("#picUrl");
	            			$imgContainer.attr("src", imgUrl);
	            			jQuery("#logoUrl").val(imgUrl);
	            			jQuery("#height").val(height);
	            			jQuery("#width").val(width);
	            			alert("上传成功");
		            	});
		            	
		            },
		            'Error': function(up, err, errTip) {
		                alert(errTip);
		            }
		            ,
		            'Key': function(up, file) {
		            	var key="";
		            	 $.ajax({
								url :"${cbasePath}topic/getFileName",
								type : "POST",
								async : false,
								data :{
									"name" : file.name,
									"pathrule" : "dry/imgs/{yyyymm}/"
								},
								success : function(result) {
									key=result;
								}
						 });
		                 return key;
		             }
		        }
		    });
			
		}
	</script>
</body>
</html>

