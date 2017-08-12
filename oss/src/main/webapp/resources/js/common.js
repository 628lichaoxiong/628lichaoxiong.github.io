;(function($){

$.extend({
	ajaxUploadFile:function(ajaxUploadExt){
		/*
		配制上传的扩展DEMO
		ajaxUploadExt={
			url:'',//配制POST地址
			fileElementId:'',//文件ID
			data:{},//配制要POST过去的数据
			beforeSend:function(){
				//回调表单提交上传前事件
			},
			success:function(data, status){
				//回调表单提交上传成功事件
			},
			error:function(data, status, e){
				//回调表单提交上传失败事件
			}
		};
		*/

		var data=null;
		var url='';
		var fileElementId='fileToUpload';
		//配制表单提交数据，类似于是ajax的data
		if(typeof(ajaxUploadExt.data)=='object' || typeof(ajaxUploadExt.data)=='string'){
			data=ajaxUploadExt.data;
		}
		//配制表单提交地址
		if(typeof(ajaxUploadExt.url)=='string'){
			url=ajaxUploadExt.url;
		}
		//配制表单提交地址
		if(typeof(ajaxUploadExt.fileElementId)=='string'){
			fileElementId=ajaxUploadExt.fileElementId;
		}

		//检测是否选择上文件和文件格式是否正确
		fileValue=$("#"+fileElementId).val();
		suffix=fileValue.substring(fileValue.lastIndexOf(".")+1).toLowerCase();
		errorMsg='';
		if(fileValue==''){
			errorMsg='请选择文件';
		}else if($.inArray(suffix, ['jpg','jpeg','gif','png'])<0){
			errorMsg='只能上传格式为:jpg,jpeg,gig,png，格式的图片！';
		}

		//如果有错误就弹出层，并返回不再往下执行。
		if(errorMsg!=''){
			alert(errorMsg);
			return false;
		}else{
			//回调表单提上传前回事件
			if(typeof(ajaxUploadExt.beforeSend)=='function'){
				ajaxUploadExt.beforeSend();
			}
		}
		$.ajaxFileUpload
		({
			url:url,
			secureuri:false,
			fileElementId:fileElementId,
			dataType: 'json',
			data:data,
			success: function (data, status){
				//回调表单提上传成功事件
				if(typeof(ajaxUploadExt.success)=='function'){
					ajaxUploadExt.success(data, status);
				}
			},
			error: function (data, status, e){
				//回调表单上传失败事件
				if(typeof(ajaxUploadExt.error)=='function'){
					ajaxUploadExt.error(data, status, e);
				}
			}
		});
		return false;
	}
});

})(jQuery);

function showPage(dom, pagenum, page, func){
	var str= '';
	if(1 == page)
		str =str+ '<span class="page_prev"></span>';//上一页
	if(1 < page)   
		str =str+ '<a class="page_prev" href="javascript:;" onclick="getPageList(\''+dom+'\', '+(page-1)+', \''+func+'\')"></a>';
	/////////////////
	if(pagenum - 10 < 0){
		for(i = 1; i  <= pagenum; i++)
		{
			if(i != page) str =str+ '<a href="javascript:;" class="pagenum" onclick="getPageList(\''+dom+'\', '+i+', \''+func+'\')">'+i+'</a>';
			if(i == page) str =str+ '<span>'+i+'</span>';
		}
	}else{	/////页数大于10 当前页小于5
		if(page - 5 < 1){
			for(i = 1; i <= 10 ; i++)
			{
				if(i != page) str =str+ '<a href="javascript:;" class="pagenum" onclick="getPageList(\''+dom+'\', '+i+', \''+func+'\')">'+i+'</a>';
				if(i == page) str =str+ '<span>'+i+'</span>';
			}
		}
		else if(pagenum - page < 6){
			for(i = pagenum -9 ; i <= pagenum; i++)
			{
				if(i != page) str =str+ '<a href="javascript:;" class="pagenum" onclick="getPageList(\''+dom+'\', '+i+', \''+func+'\')">'+i+'</a>';
				if(i == page) str =str+ '<span>'+i+'</span>';
			}
		}
		else{
			for(i = page-4; i <= page+5; i++)
			{
				if(i != page) str =str+ '<a href="javascript:;" class="pagenum" onclick="getPageList(\''+dom+'\', '+i+', \''+func+'\')">'+i+'</a>';
				if(i == page) str =str+ '<span>'+i+'</span>';
			}
		}
	}
	////////////////
	if(pagenum == page) 
		str =str+ '<span class="page_next"></span>';
	if(pagenum > page)   
		str =str+  '<a class="page_next"href="javascript:;" onclick="getPageList(\''+dom+'\', '+(page+1)+', \''+func+'\')"></a>';

	return str;
}

//前往第几页,func为获取列表的函数名
function getPageList(dom, newpage, func){
	var patrn=/^([0-9])+/;
	if (!patrn.exec(newpage)) return false;

	$(dom).parent().parent().find('input[name="currentPage"]').val(newpage);
	eval(func+"()");
}
//设置每页显示条数,func为获取列表的函数名
function setPageSize(dom, newsize, func){
	var patrn=/^([0-9])+/;
	if (!patrn.exec(newsize)) return false;

	$(dom).parent().parent().find('input[name="currentPage"]').val(1);
	$(dom).parent().parent().find('input[name="size"]').val(newsize);
	eval(func+"()");
}
function getPageInfo(dom){
	var currentPage =$(dom).find('input[name="currentPage"]').val();
	var totalPage =$(dom).find('input[name="totalPage"]').val();
	var size =$(dom).find('input[name="size"]').val();

	return currentPage+'|'+totalPage+'|'+size;
}
function pageInfoInit(dom){
	$(dom).find('input[name="currentPage"]').val(1);
	$(dom).find('input[name="totalPage"]').val(1);
	$(dom).find('input[name="size"]').val(20);
}
function url_jump(url, index) {
	if(typeof(index)!='undefined'){
		$('#leftMain li.on, #leftMain h3.on').removeClass('on');
		$('#menu'+index).addClass("on");
	}
	$("#rightMain").attr('src', url);
}
