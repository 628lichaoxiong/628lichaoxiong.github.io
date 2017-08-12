
//表单验证
$('#formID #submitCard').click(function(){
	var phonenumber = $('#formID #phonenumber').val();
    if(phonenumber.length == 0){
        alert('请输入手机号');
        return false;
    }
	var username = $('#formID #name').val();
    if(username.length == 0){
            alert('请输入登录名称');
            return false;
    }
	var passwd = $('#formID #passwd').val();
	var userId =$("#userId").val();
    if(userId ==null  ){
    	if(passwd.length == 0){
            alert('请输入登录密码');
            return false;
    	}
	    if(passwd.length < 6){ 
	        alert('登录密码必须大于登录6位');
	        return false;
	    }
    }
	var name = $('#formID #username').val();
    if(name.length == 0){
            alert('请输入用户名称');
            return false;
    }
    var url =ctx+"/ossUser/addUser";
    if(userId !=null){
    	url =ctx+"/ossUser/updateUser";
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
                window.location.href = ctx+"/ossUser/getUserList";
            }else{
                alert(resonpe.msg);
            }
        },
        error : function(data) {
                alert("网络异常！请稍后重试");
        }
    });
});
