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
<title>运营支撑系统OSS-待客户确定</title>
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
        <h4>生成新卡</h4>
        <div class="new_card clearfix">
            <input id="type" type="hidden" value="${type}">
            <input id="unitCost" name="unitCost" type="hidden">
            <input id="payflag" type="hidden" value="${objj.data.result.payflag}">
            <input id="userid" type="hidden" name="userid" value="${objj.data.result.userid}">
            <input id="servicemoney" type="hidden" name="servicemoney" >
            <div class="add_card fl">
                <div class="order_information_left_c card_form">
                  <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>卡片类型</p>
                            <div class="styled-select-1">
                                <select name="cardType">
                                     <option value="1" selected="selected">N卡</option>
                                      <option value="2" >S卡</option>
                                </select>
                            </div>
                          </div>
                    </div>
                    <div class="list_div clearfix">
                            <p>卡号</p>
                            <input type="text" maxlength="18"  name="cardNumberNo" id="cardNumberNo" value="" placeholder="选填"/>
                    </div>
                    <div class="list_div clearfix">
                        <div class="order_information_left_list fl">
                            <p>卡片数量</p>
                            <input type="text" maxlength="10" name="cardNumber" id="number" value="" onkeyup="value=value.replace(/[^\d]/g,'')" placeholder="请输入数字"/>
                        </div>
                    </div>
                    <div class="list_div clearfix">
                            <p>关联销售</p>
                            <input type="text" name="salesName" id="salesName" value="" placeholder="选填"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>销售工号</p>
                            <input type="text" name="salesNumber" id="salesNumber"  value="" placeholder="如填写关联销售，必须填写工号"/>
                    </div>
                </div>
                <div class="btn-group clear">
                    <input type="button" name="" value="取消" class="cancel">
                    <input type="button" id="submitCard" value="确定生成" class="save-btn">
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
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/card/getCardInfoParams\')">N卡管理列表</a><b>&gt;</b><span>添加卡片</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
});

//表单验证

$('#formID #submitCard').click(function(){
	var cardNumberNo = $('#formID #cardNumberNo').val();
    if(cardNumberNo.length > 0){
        if(cardNumberNo.length !=16){
            alert('卡号错误');
            return false;
        } 
        $('#formID #number').val(1);
    }
	var name = $('#formID #number').val();
    if(name.length == 0){
        alert('请输入卡片数量');
        return false;
    }
	var salesName = $('#formID #salesName').val();
    if(salesName.length > 0){
    	var phone = $('#formID #salesNumber').val();
        if(phone.length == 0){
            alert('请输入关联销售工号');
            return false;
        }
    }
    
	$.ajax({
        url : '${rc.contextPath}/card/addCards',
        type : "post",
        dataType : "json",
        data : $("#formID").serialize(),
        success : function(resonpe) {
            if (resonpe.status == 200) {
                //修改成功
                alert("操作成功！");
                window.location.href = "${rc.contextPath}/card/getCardInfoParams";
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
