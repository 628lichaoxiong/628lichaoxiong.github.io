<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-新增修改搜索推荐</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/scanCalendar.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
<style>
.table-list{ margin-bottom:20px;}
.small_title_p{ margin-bottom:10px; }
</style>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/scanCalendar.js"></script>
</head>
<body style="padding: 10px 30px 0 30px">
    <div id="jump_mask" class="jump_mask" style="display:none;"></div>
    <div id="loading"><div class="msg"></div></div>
    <form id="formID">
    <div class="new_back">
        <h4>搜索推荐操作</h4>
        <div class="new_card clearfix">
            <input id="id" type="hidden" name="id" value="${objj.data.result.id}">
            <div class="add_card fl">
                <div class="order_information_left_c card_form">
                    <div class="list_div clearfix">
                            <p>搜索标题</p>
                            <input type="text" maxlength="70"  name="showName" id="showName" value="${objj.data.result.showName}"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>开始时间</p>
                            <input name="startTime" id="startTime" type="text" value="${objj.data.result.startTime}" class="Wdate" readonly onClick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>结束时间</p>
                            <input name="endTime" id="endTime" type="text" value="${objj.data.result.endTime}" class="Wdate" readonly onClick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>语种</p>
                            <input type="text" name="language" id="language"  value="${objj.data.result.language}" placeholder="多个使用英文逗号分隔"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>城市</p>
                            <input type="text" name="city" id="city"  value="${objj.data.result.city}" placeholder="多个使用英文逗号分隔"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>标签</p>
                            <input type="text" name="label" id="label"  value="${objj.data.result.label}" placeholder="多个使用英文逗号分隔"/>
                    </div>
                </div>
                <div class="btn-group clear">
                    <input type="button" id="submitCard" value="确定" class="save-btn">
                </div>
             </div>
         </div>
</div>
</form>
<!--错误提示弹窗-->
    <div id="showEorr"></div>
<script type="text/javascript">
var ctx="${rc.contextPath}";
$(function(){
    setMenu();
    //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/searchRecommend/getSearchRecommendList\')">搜索推荐列表</a><b>&gt;</b><span>新增修改</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
});

//表单验证

$('#formID #submitCard').click(function(){
	var showName = $('#formID #showName').val();
    if(showName.length == 0){
            alert('请填写搜索标题');
            return false;
    }
    var url =null;
    var id = $('#formID #id').val();
    if(id.length > 0){
    	url='${rc.contextPath}/searchRecommend/updateSearchRecommend';
    }else{
    	url ='${rc.contextPath}/searchRecommend/addSearchRecommend';
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
                window.location.href = "${rc.contextPath}/searchRecommend/getSearchRecommendList";
            }else{
                alert(resonpe.msg);
            }
        },
        error : function(data) {
                alert("网络异常！请稍后重试");
        }
    });
});
</script>

</body>
</html>
