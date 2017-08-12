
//表单验证
$('#formID #submitLabel').click(function(){
	
	var username = $('#formID #labelName').val();
    if(username.length == 0){
            alert('请输入标签名称');
            return false;
    }
	var userId =$("#id").val();
   
    var url =ctx+"/label/addLabel";
    if(userId.length >0){  
    	url =ctx+"/label/updateLabel";
    } 
	$.ajax({
        url : url, 
        type : "post",
        dataType : "json",
        data : $("#formID").serialize(),
        success : function(resonpe) {
            if (resonpe.status == 200) {
                //修改成功
                alert("操作成功！");
                window.location.href = ctx+"/label/getLabelList";
            }else{
                alert(resonpe.msg);
            }
        },
        error : function(data) {
                alert("网络异常！请稍后重试");
        }
    });
});
