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
<title>运营支撑系统OSS-新增系统标签</title>
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
        <h4>系统标签操作</h4>
        <div class="new_card clearfix">
            <div class="add_card fl">
                <div class="order_information_left_c card_form">
                    <div class="list_div clearfix">
                            <p>标签名称</p>
                            <input type="text" name="labelName" maxlength="20" id="labelName" value="${labelName}"  placeholder="请输入标签名称"/>
                    </div>
                </div>
                <div class="btn-group clear">
                    <input type="hidden" name ="id" id="id" value="${id}">
                    <input type="button" id="submitLabel" value="确定" class="save-btn">
                </div>
             </div>
         </div>
</div>
</form>
<!--错误提示弹窗-->
    <div id="showEorr"></div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/label.js"></script>
<script type="text/javascript">
var ctx="${rc.contextPath}";
$(function(){
    setMenu();
    //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/label/getLabelList\')">OSS系统标签管理列表</a><b>&gt;</b><span>系统标签操作</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
});
</script>

</body>
</html>
