
//表单验证
$('#formID #submitCard').click(function(){
	var roleName = $('#formID #roleName').val();
    if(roleName.length == 0){
            alert('请输入角色名称');
            return false;
    }
	var roleId =$("#roleId").val();
    var url =ctx+"/ossRole/addRole";
    if(roleId !=null){
    	url =ctx+"/ossRole/updateRole";
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
                window.location.href = ctx+"/ossRole/getRoleList";
            }else{
                alert(resonpe.msg);
            }
        },
        error : function(data) {
                alert("网络异常！请稍后重试");
        }
    });
});
