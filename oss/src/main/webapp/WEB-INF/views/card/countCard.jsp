<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="transn" uri="/WEB-INF/tld/transn.tld"%>


<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-卡信息</title>

<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css?id=1" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />

<style type="text/css">

</style>
</head>
<body style="padding:10px 61.7px 0 30px;">
	<div id="jump_mask" class="jump_mask" style="display: none;"></div>
	<div id="loading"><div class="msg"></div></div>
	<div class="card_date">
        <ul>
            <li>
                <h2>N卡数据</h2>
				<div class="tips">
                    <ul>
                        <li>N卡状态包括六种：</li>
                        <li>待领取-已生成，未关联任何销售</li>
                        <li>待绑定-已关联销售，没有协议客户</li>
                        <li>待激活-已绑定客户，未激活</li>
                        <li>已激活-客户已激活，但未开始使用</li>
                        <li>已禁用-已用N卡支付过，因坏账或其他原因禁用。</li>
                        <li>已启用-已激活并用N卡支付过</li>
                    </ul>
                </div>
                <img src="${rc.contextPath}/resources/images/date_notice.png" alt="">
        		<div class="table_date">
					 <p class="first">
                            <span>N卡总数(张)：</span>
                            <span id="n_total">0</span>

                    </p>
                    <div class="second">
                        <p>
                            <span>总储值：</span>
                            <span>￥</span><span id="N_cmonery">0</span>
                        </p>
                        <p>
                            <span>总消费：</span>
                            <span>￥</span><span id="N_xmonery">0</span>
                        </p>
                        <p>
                            <span>总余额：</span>
                            <span>￥</span><span id="banalce_monery">0</span>
                        </p>
                    </div>
                    <div class="third">
                        <p>
                            <span>已激活：</span>
                            <span id="n_use">0</span>
                        </p>
                        <p>
                            <span>已启用：</span>
                            <span id="n_open">0</span>
                        </p>
                        <p>
                            <span>已禁用：</span>
                            <span id="n_colse">0</span>
                        </p>
                        <p>
                            <span>待激活：</span>
                            <span id="n_nouse">0</span>
                        </p>
                        <p>
                            <span>待绑定：</span>
                            <span id="n_nobind">0</span>
                        </p>
                        <p>
                            <span>待领取：</span>
                            <span id="n_noIssue">0</span>
                        </p>
                    </div>
        		</div>
            </li>
            <li>
                <h2>S卡数据</h2>
				<div class="tips">
                    <ul>
                        <li>N卡状态包括六种：</li>
                        <li>待领取-已生成，未关联任何销售</li>
                        <li>待绑定-已关联销售，没有协议客户</li>
                        <li>待激活-已绑定客户，未激活</li>
                        <li>已激活-客户已激活，但未开始使用</li>
                        <li>已禁用-已用N卡支付过，因坏账或其他原因禁用。</li>
                        <li>已启用-已激活并用N卡支付过</li>
                    </ul>
                </div>
                <img src="${rc.contextPath}/resources/images/date_notice.png" alt="">
        		<div class="table_date">
					 <p class="first">
                            <span>S卡总数(张)：</span>
                            <span id="s_total">0</span>

                    </p>
                    <div class="second">
                        <p>
                            <span>总消费：</span>
                            <span>￥</span><span id="S_xmonery">0</span>
                        </p>
                        <p>
                            <span>总还款：</span>
                            <span>￥</span><span id="S_cmonery">0</span>
                        </p>
                        <p>
                            <span>未还款：</span>
                            <span>￥</span><span id="bill_monery">0</span>
                        </p>
                    </div>
                    <div class="third">
                        <p>
                            <span>已激活：</span>
                            <span id="s_use">0</span>
                        </p>
                        <p>
                            <span>已启用：</span>
                            <span id="s_open">0</span>
                        </p>
                        <p>
                            <span>已禁用：</span>
                            <span id="s_colse">0</span>
                        </p>
                        <p>
                            <span>待激活：</span>
                            <span id="s_nouse">0</span>
                        </p>
                        <p>
                            <span>待绑定：</span>
                            <span id="s_nobind">0</span>
                        </p>
                        <p>
                            <span>待领取：</span>
                            <span id="s_noIssue">0</span>
                        </p>
                    </div>
        		</div>
            </li>
        </ul>

	</div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="${rc.contextPath}/resources/js/common.js"></script>

<script type="text/javascript">
$(function(){
    setMenu();
    //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/card/getCardInfoParams\')">N卡管理列表</a><b>&gt;</b><span>卡片数据</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
});



</script>
<script>
$(function(){
	$.ajax({
		type:'post',
		url:'${rc.contextPath}/card/countCards',
		dataType: "json",
        success:function(data){
        	  if(data.status==200){
        		  var n_total=0;
        		  var s_total=0;
        		 $.each(data.data.result.N_card, function(idx, obj) {
        			    n_total=parseInt(n_total)+obj.count;
        		    	if(obj.cardStatus==1){
        		    		$("#n_noIssue").html(obj.count);
        		    	}
        		    	if(obj.cardStatus==2){
        		    		$("#n_nobind").html(obj.count);
        		    	}
        		    	if(obj.cardStatus==3){
        		    		$("#n_nouse").html(obj.count);
        		    	}
        		    	if(obj.cardStatus==4){
        		    		$("#n_use").html(obj.count);
        		    	}
        		    	if(obj.cardStatus==5){
        		    		$("#n_open").html(obj.count);
        		    	}

        		});
        		 $.each(data.data.result.S_card, function(idx, obj) {
        			 s_total=parseInt(s_total)+obj.count;
     		    	if(obj.cardStatus==1){
     		    		$("#s_noIssue").html(obj.count);
     		    	}
     		    	if(obj.cardStatus==2){
     		    		$("#s_nobind").html(obj.count);
     		    	}
     		    	if(obj.cardStatus==3){
     		    		$("#s_nouse").html(obj.count);
     		    	}
     		    	if(obj.cardStatus==4){
     		    		$("#s_use").html(obj.count);
     		    	}
     		    	if(obj.cardStatus==5){
     		    		$("#s_open").html(obj.count);
     		    	}

     		   });
        		 $("#n_total").html(n_total);
        		 $("#s_total").html(s_total);
        		 $.each(data.data.result.N_ncard, function(idx, obj) {
      		    	$("#n_colse").html(obj.count);
      		    });
        		$.each(data.data.result.S_ncard, function(idx, obj) {
       		    	$("#s_colse").html(obj.count);
       		    });
        		$("#N_cmonery").html(data.data.result.N_cmonery);
        		$("#N_xmonery").html(data.data.result.N_xmonery);
        		$("#S_cmonery").html(data.data.result.S_cmonery);
        		$("#S_xmonery").html(data.data.result.S_xmonery);
        		$("#banalce_monery").html(data.data.result.banalce_monery);
        		$("#bill_monery").html(data.data.result.bill_monery);
        	}
        }
	});

	// 数据提示
    $('.card_date img').mouseenter(function(){
        $(this).parent().find('.tips').fadeIn();
    }).mouseleave(function(){
        $(this).parent().find('.tips').fadeOut();
    })

});

</script>
</body>
</html>
