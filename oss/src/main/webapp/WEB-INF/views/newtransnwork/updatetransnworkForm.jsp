<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%
	String contextPath = request.getContextPath();
%>



<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-变更会议</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/Jfunction.js" charset="UTF-8"></script>

<link rel="stylesheet" type="text/css" href="${sourcePath}/resources/js/calendar/jscal2.css" />
<link rel="stylesheet" type="text/css" href="${sourcePath}/resources/js/calendar/border-radius.css" />
<link rel="stylesheet" type="text/css" href="${sourcePath}/resources/js/calendar/win2k.css" />
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/calendar/calendar.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/calendar/lang/en.js" charset="UTF-8"></script>
</head>
<body>
	<div id="loading"><div class="msg"></div></div>
	<div class="mainBody">
		<form name="myform" action="${sourcePath}transnwork/updatetransnwork" method="post" id="myform">
		<input type="hidden" name="id" value="${transnworkinfo.data.result.id}">
		<input type="hidden" name="days" value="${transnworkinfo.data.result.days}">
		<input type="hidden" name="halfdays" value="${transnworkinfo.data.result.halfdays}">

		<div class="table_form">
			<table width="88%" cellspacing="0">
				<tr>
					<th width="18%">会议名称</th>
					<td><input type="text" class="input_txt required" name="meetingname" id="meet_name" value="${transnworkinfo.data.result.meetingname}"></td>
				</tr>
				<tr>
					<th>行业标签</th>
					<td><input type="text" class="input_txt required" name="category" id="trade_label_txt" value="${transnworkinfo.data.result.category}"></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="hidden" name="" id="trade_label_val" value=""><!-- 多个行业标签用|连接，如1|2|3 -->
					<div id="trade_label" class="gray_box trade_label">
						<span data-val="1">能源</span>
						<span data-val="2">医药 医疗</span>
						<span data-val="3">金融 经济</span>
						<span data-val="4">汽车</span>
						<span data-val="5">环保</span>
						<span data-val="6">教育</span>
						<span data-val="7">IT 互联网</span>
						<span data-val="8">建筑</span>
						<span data-val="9">化工</span>
						<span data-val="10">法律</span>
						<span data-val="11">艺术</span>
						<span data-val="12">文化</span>
						<span data-val="13">农业</span>
						<span data-val="14">传媒 媒体</span>
						<span data-val="15">物流 运输</span>
						<span data-val="16">投资</span>
						<span data-val="17">航空 航天</span>
						<span data-val="18">旅游</span>
						<span data-val="19">交通</span>
						<span data-val="20">食品</span>
						<span data-val="21">机械</span>
						<span data-val="22">房地产</span>
						<span data-val="23">时尚 奢侈品</span>
						<span data-val="24">钢铁 矿业</span>
						<span data-val="25">技术</span>
						<span data-val="26">设计</span>
						<span data-val="27">市场调研</span>
						<span data-val="28">石油</span>
						<span data-val="29">政府会议</span>
						<span data-val="30">体育</span>
						<span data-val="31">制造业</span>
						<span data-val="32">商务</span>
						<span data-val="33">人力资源</span>
						<span data-val="34">影视 摄影</span>
						<span data-val="35">工程</span>
						<span data-val="36">水利 电力</span>
						<span data-val="37">公共管理</span>
						<span data-val="38">海运 船舶</span>
						<span data-val="39">商贸</span>
						<span data-val="40">广告</span>
						<span data-val="41">零售</span>
						<span data-val="42">人文 社科</span>
					</div></td>
				</tr>
				<tr>
					<th>会议语言</th>
					<td>
						<%-- <span class="select_new">
							<i>中文</i><input id="lang1" name="language1" value="" type="hidden" onchange="">
							<span class="seleopt" style="display: none;">
								<a href="javascript:void(0);" value="中文" class="selected">中文</a>
								<a href="javascript:void(0);" value="英语">英语</a>
								<a href="javascript:void(0);" value="日语">日语</a>
								<a href="javascript:void(0);" value="德语">德语</a>
								<a href="javascript:void(0);" value="法语">法语</a>
								<a href="javascript:void(0);" value="俄语">俄语</a>
								<a href="javascript:void(0);" value="意大利语">意大利语</a>
								<a href="javascript:void(0);" value="西班牙语">西班牙语</a>
								<a href="javascript:void(0);" value="韩语">韩语</a>
								<a href="javascript:void(0);" value="阿拉伯语">阿拉伯语</a>
								<a href="javascript:void(0);" value="泰语">泰语</a>
								<a href="javascript:void(0);" value="蒙古语">蒙古语</a>
								<a href="javascript:void(0);" value="柬埔寨语">柬埔寨语</a>
								<a href="javascript:void(0);" value="老挝语">老挝语</a>
								<a href="javascript:void(0);" value="土耳其语">土耳其语</a>
								<a href="javascript:void(0);" value="捷克语">捷克语</a>
								<a href="javascript:void(0);" value="缅甸语">缅甸语</a>
								<a href="javascript:void(0);" value="乌尔都语">乌尔都语</a>
								<a href="javascript:void(0);" value="孟加拉语">孟加拉语</a>
								<a href="javascript:void(0);" value="印尼语">印尼语</a>
								<a href="javascript:void(0);" value="波斯语">波斯语</a>
								<a href="javascript:void(0);" value="越南语">越南语</a>
								<a href="javascript:void(0);" value="塞尔维亚语">塞尔维亚语</a>
								<a href="javascript:void(0);" value="波兰语">波兰语</a>
								<a href="javascript:void(0);" value="乌克兰语">乌克兰语</a>
								<a href="javascript:void(0);" value="哈萨克语">哈萨克语</a>
								<a href="javascript:void(0);" value="芬兰语">芬兰语</a>
								<a href="javascript:void(0);" value="马来语">马来语</a>
								<a href="javascript:void(0);" value="匈牙利语">匈牙利语</a>
								<a href="javascript:void(0);" value="罗马尼亚语">罗马尼亚语</a>
								<a href="javascript:void(0);" value="保加利亚语">保加利亚语</a>
							</span>
						</span><a href="javascript:;" class="lang_switch txt_dot" onclick="changeLang('lang1', 'lang2')"></a><span class="select_new">
							<i>英文</i><input id="lang2" name="language2" value="英文" type="hidden" onchange="">
							<span class="seleopt" style="display: none;">
								<a href="javascript:void(0);" value="英文" class="selected">英文</a>
									<a href="javascript:void(0);" value="中文">中文</a>
								<a href="javascript:void(0);" value="日语">日语</a>
								<a href="javascript:void(0);" value="德语">德语</a>
								<a href="javascript:void(0);" value="法语">法语</a>
								<a href="javascript:void(0);" value="俄语">俄语</a>
								<a href="javascript:void(0);" value="意大利语">意大利语</a>
								<a href="javascript:void(0);" value="西班牙语">西班牙语</a>
								<a href="javascript:void(0);" value="韩语">韩语</a>
								<a href="javascript:void(0);" value="阿拉伯语">阿拉伯语</a>
								<a href="javascript:void(0);" value="泰语">泰语</a>
								<a href="javascript:void(0);" value="蒙古语">蒙古语</a>
								<a href="javascript:void(0);" value="柬埔寨语">柬埔寨语</a>
								<a href="javascript:void(0);" value="老挝语">老挝语</a>
								<a href="javascript:void(0);" value="土耳其语">土耳其语</a>
								<a href="javascript:void(0);" value="捷克语">捷克语</a>
								<a href="javascript:void(0);" value="缅甸语">缅甸语</a>
								<a href="javascript:void(0);" value="乌尔都语">乌尔都语</a>
								<a href="javascript:void(0);" value="孟加拉语">孟加拉语</a>
								<a href="javascript:void(0);" value="印尼语">印尼语</a>
								<a href="javascript:void(0);" value="波斯语">波斯语</a>
								<a href="javascript:void(0);" value="越南语">越南语</a>
								<a href="javascript:void(0);" value="塞尔维亚语">塞尔维亚语</a>
								<a href="javascript:void(0);" value="波兰语">波兰语</a>
								<a href="javascript:void(0);" value="乌克兰语">乌克兰语</a>
								<a href="javascript:void(0);" value="哈萨克语">哈萨克语</a>
								<a href="javascript:void(0);" value="芬兰语">芬兰语</a>
								<a href="javascript:void(0);" value="马来语">马来语</a>
								<a href="javascript:void(0);" value="匈牙利语">匈牙利语</a>
								<a href="javascript:void(0);" value="罗马尼亚语">罗马尼亚语</a>
								<a href="javascript:void(0);" value="保加利亚语">保加利亚语</a>
							</span>
						</span> --%>
						<input type="text" class="input_txt" name="language" id="language" value="${transnworkinfo.data.result.language}">
					</td>
				</tr>
				<tr>
					<th>会议时间</th>
					<td><input type="text" class="input_txt" name="meetingtime" id="meetingtime" value="${transnworkinfo.data.result.meetingtime}" readonly="true"></td>
				</tr>
				<tr>
					<th>会议周期</th>
					<td><input type="text" class="input_txt" name="longtime" id="longtime" value="${fn:replace(transnworkinfo.data.result.longtime, '天', '')}" readonly="true">天</td>
				</tr>
				<tr>
					<th>会议城市</th>
					<td><%-- <span class="select_new" style="width:121px;">
							<i>北京</i><input id="meet_city" name="city" value="${transnworkinfo.data.result.city}" type="hidden" onchange="">
							<span class="seleopt" style="display: none;">
								<a href="javascript:void(0);" value="北京" class="selected">北京</a>
								<a href="javascript:void(0);" value="上海">上海</a>
								<a href="javascript:void(0);" value="天津">天津</a>
								<a href="javascript:void(0);" value="重庆">重庆</a>
								<a href="javascript:void(0);" value="河北">河北</a>
								<a href="javascript:void(0);" value="河南">河南</a>
								<a href="javascript:void(0);" value="云南">云南</a>
								<a href="javascript:void(0);" value="辽宁">辽宁</a>
								<a href="javascript:void(0);" value="黑龙江">黑龙江</a>
								<a href="javascript:void(0);" value="湖南">湖南</a>
								<a href="javascript:void(0);" value="安徽">安徽</a>
								<a href="javascript:void(0);" value="山东">山东</a>
								<a href="javascript:void(0);" value="新疆维吾尔">新疆维吾尔</a>
								<a href="javascript:void(0);" value="江苏">江苏</a>
								<a href="javascript:void(0);" value="浙江">浙江</a>
								<a href="javascript:void(0);" value="江西">江西</a>
								<a href="javascript:void(0);" value="湖北">湖北</a>
								<a href="javascript:void(0);" value="广西壮族">广西壮族</a>
								<a href="javascript:void(0);" value="甘肃">甘肃</a>
								<a href="javascript:void(0);" value="山西">山西</a>
								<a href="javascript:void(0);" value="内蒙古">内蒙古</a>
								<a href="javascript:void(0);" value="陕西">陕西</a>
								<a href="javascript:void(0);" value="吉林">吉林</a>
								<a href="javascript:void(0);" value="福建">福建</a>
								<a href="javascript:void(0);" value="贵州">贵州</a>
								<a href="javascript:void(0);" value="广东">广东</a>
								<a href="javascript:void(0);" value="青海">青海</a>
								<a href="javascript:void(0);" value="西藏">西藏</a>
								<a href="javascript:void(0);" value="四川">四川</a>
								<a href="javascript:void(0);" value="宁夏回族">宁夏回族</a>
								<a href="javascript:void(0);" value="海南">海南</a>
								<a href="javascript:void(0);" value="台湾">台湾</a>
								<a href="javascript:void(0);" value="香港特别行政区">香港特别行政区</a>
								<a href="javascript:void(0);" value="澳门特别行政区">澳门特别行政区</a>
							</span>
						</span> --%>
						<input type="text" class="input_txt" name="city" id="city" value="${transnworkinfo.data.result.city}">
					</td>
				</tr>
				<tr>
					<th>会议类型</th>
					<td><%-- <span class="select_new" style="width:121px;">
							<i>同传</i><input id="meet_type" name="type" value="${transnworkinfo.data.result.type}" type="hidden" onchange="">
							<span class="seleopt" style="display: none;">
								<a href="javascript:void(0);" value="同传" class="selected">同传</a>
								<a href="javascript:void(0);" value="交传">交传</a>
								<!-- <a href="javascript:void(0);" value="陪同">陪同</a>
								<a href="javascript:void(0);" value="耳语同传">耳语同传</a> -->
							</span>
						</span> --%>
						<input type="text" class="input_txt" name="type" id="type" value="${transnworkinfo.data.result.type}">
					</td>
				</tr>
				<tr>
					<th>会议联系人</th>
					<td><input type="text" class="input_txt required" name="meetinguser" id="meetinguser" value="${transnworkinfo.data.result.meetinguser}" style="width:120px;"></td>
				</tr>
				<tr>
					<th>会议联系人手机号</th>
					<td><input type="text" class="input_txt required" name="userphonenumber" id="contact_phone" value="${transnworkinfo.data.result.userphonenumber}"  style="width:120px;"></td>
				</tr>
				<tr>
					<th>会议地址</th>
					<td><input type="text" class="input_txt optional" name="address" id="" value="${transnworkinfo.data.result.address}"><div class="onShow">选填</div></td>
				</tr>
				<tr>
					<th>是否安排住宿</th>
					<td><%-- <span class="select_new" style="width:121px;">
							<i>是</i><input id="meet_stay" name="isusergetin" value="是" type="hidden" onchange="">
							<span class="seleopt" style="display: none;">
								<a href="javascript:void(0);" value="是" class="selected">是</a>
								<a href="javascript:void(0);" value="否">否</a>
							</span>
						</span> --%>
						<input type="text" class="input_txt" name="isusergetin" id="meetingname" value="${transnworkinfo.data.result.isusergetin}">
					</td>
				</tr>
				<tr>
					<th>会议报名截止时间</th>
					<td><input type="text" class="input_txt" name="timeout" id="timeout" value="${transnworkinfo.data.result.timeout}" readonly="true"></td>
				</tr>
				<tr>
					<th>会议内容</th>
					<td><textarea class="input_area optional" name="info" id="info" maxlength="150">${transnworkinfo.data.result.info}</textarea><div class="onShow">选填</div></td>
				</tr><!-- 
				<tr>
					<th></th>
					<td><div class="file_btn"><span>资料上传</span><input type="file" name="" id=""></div></td>
				</tr> -->
				<!-- <tr>
					<th>资料上传</th>
					<td><input type="file" name="" id=""></td>
				</tr> -->
			</table>
			<script type="text/javascript">
				Calendar.setup({
					weekNumbers: true,
					inputField : "start_time",
					trigger    : "start_time",
					dateFormat: "%Y-%m-%d %H:%M",
					showTime: true,
					minuteStep: 1,
					onSelect   : function() {this.hide();}
				});
				Calendar.setup({
					weekNumbers: true,
					inputField : "end_time",
					trigger    : "end_time",
					dateFormat: "%Y-%m-%d %H:%M",
					showTime: true,
					minuteStep: 1,
					onSelect   : function() {this.hide();}
				});
				Calendar.setup({
					weekNumbers: true,
					inputField : "stop_time",
					trigger    : "stop_time",
					dateFormat: "%Y-%m-%d %H:%M",
					showTime: true,
					minuteStep: 1,
					onSelect   : function() {this.hide();}
				});
			</script>
		</div>

		<div class="btn_wrap"><input type="submit" class="btn" value="提交"></div>
		</form>
	</div>
<script type="text/javascript">
<!--
	$('#trade_label').find('span').each(function(){
		$(this).click(function(){
			if($(this).hasClass('select')) {
				$(this).removeClass('select');
			}
			else{
				$(this).addClass('select');
			}
			setTrade();
		});
	});
	$('.required').each(function(){
		$(this).focus(function(){
			$(this).parent().addClass('red');
		}).blur(function(){
			$(this).parent().removeClass('red');
		});
	});
	$('.optional').each(function(){
		$(this).focus(function(){
			$(this).parent().addClass('blue');
		}).blur(function(){
			$(this).parent().removeClass('blue');
		});
	});
	function setTrade(){
		var dom = $('#trade_label').find('span.select');
		var str = '', txt='';
		var len = dom.length;
		for(var i=0; i<len; i++) {
			if(str!='') {
				str = str+'|';
				txt = txt+'/';
			}
			str = str + dom.eq(i).attr('data-val');
			txt = txt + dom.eq(i).text();
		}
		$('#trade_label_val').val(str);
		$('#trade_label_txt').focus().val(txt);
	}
	function setMenu(){//或者自己设定导航逻辑
		var str = '<a href="javascript:;" onclick="url_jump(\'${sourcePath}transnwork/transnworklist\')">会议列表</a><b>&gt;</b><span>变更会议</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	setMenu();

	$(document).ready(function() {
		$.formValidator.initConfig({autotip:true,formid:"myform",onerror:function(msg){}});
		$("#meet_name").formValidator({onshow:"请输入会议名称",onfocus:"必填"}).inputValidator({min:1,onerror:"必填"});
		$("#trade_label_txt").formValidator({onshow:"请输入行业标签",onfocus:"必填"}).inputValidator({min:1,onerror:"必填"});
		$("#cycle").formValidator({onshow:"至少填一项",onfocus:"至少填一项"}).functionValidator({fun:cycle});
		$("#cycle_half").formValidator({onshow:"",onfocus:"至少填一项"}).functionValidator({fun:cycle});
		$("#meet_contactor").formValidator({onshow:"请输入会议联系人",onfocus:"必填"}).inputValidator({min:1,onerror:"必填"});
		$("#contact_phone").formValidator({onshow:"请输入联系人手机号",onfocus:"必填"}).inputValidator({min:1,onerror:"必填"}).regexValidator({regexp:"mobile",datatype:"enum",onerror:"手机号码格式不正确"});
	});

	function cycle(){
		if($("#cycle").val()=="" && $("#cycle_half").val()=="") {
			return '至少填一项';
		}
		else {
			$('#cycleTip').html('输入正确').removeClass().addClass('onCorrect');
			return true;
		}
	}
	function changeLang(t1, t2){
		var str1 = $('#'+t1).parent().html();
		var str2 = $('#'+t2).parent().html();

		$('#'+t1).attr('id',t1+'tt');
		$('#'+t2).parent().html(str1);
		$('#'+t1+'tt').parent().html(str2);

		$('#'+t1).attr('id',t1+'tt');
		$('#'+t2).attr('id',t1);
		$('#'+t1+'tt').attr('id',t2);

	}
//-->
</script>
</body>
</html>
