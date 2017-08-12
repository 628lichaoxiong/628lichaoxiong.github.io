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
<html>
<head lang="en">
<meta charset="UTF-8">
<title>传神任务创建</title>
<script src="<%=contextPath%>/resources/assets/js/jquery.min.js"></script>
<script src="<%=contextPath%>/resources/assets/js/bootstrap.min.js"></script>
<link href="<%=contextPath%>/resources/assets/css/bootstrap.min.css"
	rel="stylesheet">
<link href="<%=contextPath%>/resources/assets/css/font.css"
	rel="stylesheet">
<style>
#userInfoDiv div {
	padding: 10px;
}
</style>
</head>
<body>
	<div class="container-fluid">

		<ol class="breadcrumb">
			<li><a href="${cbasePath}transnworklist">传神任务</a></li>
			<li><a href="${cbasePath}transnworklist">传神任务列表</a></li>

			<li class="active">传神任务创建</li>
		</ol>

		<div class="row">
			<div class="col-xs-9">
				<form role="form" method="post"
					action="${cbasePath}transnwork/addtransnwork?meetingtime=${transnworkinfo.data.result.meetingtime}">
					<input type="hidden" name="type"
						value="${transnworkinfo.data.result.type}">
						
						<input type="hidden" name="id"
						value="${transnworkinfo.data.result.id}">
					<div class="form-group">
						<label for="exampleInputEmail1">会议名称</label> <input type="text"
							name="meetingname" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.meetingname}">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议简介</label>
						<!-- <input type="text"
							name="content" class="form-control" id="exampleInputEmail1"
							placeholder="" style="width:652px;height:150px"> -->
						<textarea name="workinfo" class="form-control" rows="3" cols="20">${transnworkinfo.data.result.info}</textarea>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议行业(只能在以下行业中选择：能源、医药 医疗、金融 经济、汽车、环保、教育、IT 互联网、通讯 电子、建筑、化工、法律、艺术、文化、农业、传媒 媒体、物流 运输、投资、航空 航天、旅游、交通、食品、机械、房地产、时尚 奢侈品、钢铁 矿业、技术、设计、市场调研、石油、政府会议、体育、制造业、商务、人力资源、影视 摄影、工程、水利 电力、公共管理、海运 船舶、商贸、广告、零售、人文 社科)</label> <input type="text"
							name="category" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.category}">例如：能源/法律/汽车(最多选5个)
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议语言对</label> <input type="text"
							name="language" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.language}">例如：中文-法语
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议时间 <c:if test="${transnworkinfo.data.result.meetingtime!=null}">(修改之前为：${transnworkinfo.data.result.meetingtime})</c:if></label> 
						</br>
						<select name="startyear">
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
						</select> 
						年
						<select name="startmonth">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select> 
						月
						<select name="startday">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
						日
						<select name="starthous">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="00">00</option>
						</select>
						时
						<select name="startminute">
						<option value="00">00</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
						</select>
						分
						-
						<select name="endyear">
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
						</select> 
						年
						<select name="endmonth">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select> 
						月
						<select name="endday">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
						日
						<select name="endhous">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="00">00</option>
						</select>
						时
						<select name="endminute">
						<option value="00">00</option>
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
							<option value="32">32</option>
							<option value="33">33</option>
							<option value="34">34</option>
							<option value="35">35</option>
							<option value="36">36</option>
							<option value="37">37</option>
							<option value="38">38</option>
							<option value="39">39</option>
							<option value="40">40</option>
							<option value="41">41</option>
							<option value="42">42</option>
							<option value="43">43</option>
							<option value="44">44</option>
							<option value="45">45</option>
							<option value="46">46</option>
							<option value="47">47</option>
							<option value="48">48</option>
							<option value="49">49</option>
							<option value="50">50</option>
							<option value="51">51</option>
							<option value="52">52</option>
							<option value="53">53</option>
							<option value="54">54</option>
							<option value="55">55</option>
							<option value="56">56</option>
							<option value="57">57</option>
							<option value="58">58</option>
							<option value="59">59</option>
						</select>
						分
						
						<%-- <input type="text" name="meetingtime" class="form-control"
							id="exampleInputEmail1" placeholder=""
							value="${transnworkinfo.data.result.meetingtime}">例如：2016-03-04
						10:30~2016-03-06 12:00 --%>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议周期</label> <input type="text"
							name="longtime"  id="exampleInputEmail1"
							placeholder="" value="${fn:replace(transnworkinfo.data.result.longtime, '天', '')} ">天
							 
							
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 例如：2天 ，0.5天，2.5天
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议城市</label> <input type="text"
							name="city" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.city}">例如：北京
					</div>
					<%-- <div class="form-group">
						<label for="exampleInputEmail1">会议来源</label> <input type="text"
							name="meetingfrom" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.meetingfrom}">例如：传神
					</div> --%>
					<div class="form-group">
						<label for="exampleInputEmail1">会议类型 <c:if test="${transnworkinfo.data.result.type!=null}">(修改之前为：${transnworkinfo.data.result.type})</c:if></label> <%-- <input type="text"
							name="type" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.type}"> --%>
							<select name="selecttype">
						<option value="同传">同传</option>
							<option value="交传">交传</option>
							</select>
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议联系人手机号</label> <input
							type="text" name="userphonenumber" class="form-control"
							id="exampleInputEmail1" placeholder=""
							value="${transnworkinfo.data.result.userphonenumber}">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议联系人</label> <input type="text"
							name="meetinguser" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.meetinguser}">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议地址</label> <input type="text"
							name="address" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.address}">
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">是否安排住宿</label> <input type="text"
							name="isusergetin" class="form-control" id="exampleInputEmail1"
							placeholder="" value="${transnworkinfo.data.result.isusergetin}">例如：是，否
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议报名截止时间(默认会议开始前48小时(2天)) <c:if test="${transnworkinfo.data.result.timeout!=null}">(修改之前为：${transnworkinfo.data.result.timeout})</c:if></label> 
						</br>
						<select name="timeoutyear">
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
							<option value="2020">2020</option>
						</select> 
						年
						<select name="timeoutmonth">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select> 
						月
						<select name="timeoutday">
							<option value="01">01</option>
							<option value="02">02</option>
							<option value="03">03</option>
							<option value="04">04</option>
							<option value="05">05</option>
							<option value="06">06</option>
							<option value="07">07</option>
							<option value="08">08</option>
							<option value="09">09</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
							<option value="24">24</option>
							<option value="25">25</option>
							<option value="26">26</option>
							<option value="27">27</option>
							<option value="28">28</option>
							<option value="29">29</option>
							<option value="30">30</option>
							<option value="31">31</option>
						</select>
						日
					</div>
					<div class="form-group">
						<label for="exampleInputEmail1">会议议程</label>
						<!-- <input type="text"
							name="content" class="form-control" id="exampleInputEmail1"
							placeholder="" style="width:652px;height:150px"> -->
						<textarea name="liuchenglist" class="form-control" rows="3"
							cols="20">${transnworkinfo.data.result.transnworklist}</textarea>
						例如：议程1，议程2，议程3
					</div>


					<button type="submit" class="btn btn-default">提交</button>
				</form>
			</div>
		</div>

	</div>
</body>
</html>

