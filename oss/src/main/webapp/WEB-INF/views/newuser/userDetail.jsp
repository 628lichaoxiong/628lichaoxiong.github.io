<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld"%>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<html lang="ZH-cn">
<head>
<meta charset="UTF-8">
<title>运营支撑系统OSS-用户信息</title>
<link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/main.css?id=1" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/sele.css" rel="stylesheet" type="text/css" />
<link href="${sourcePath}/resources/css/cropbox.css" rel="stylesheet" type="text/css" />

<style type="text/css">
.file {
    position: relative;
    display: inline-block;
    background: #4D637B;
	border-radius: 4px;
    padding: 6px 8px;
    overflow: hidden;
    color: #fff;
    text-decoration: none;
    text-indent: 0;
    line-height: 20px;
    top:58px;
    left:20px;
    font-size:12px;
}
.edit_head_user{
	position: relative;
	top:0px;
    left:20px;
	font-size: 20px;
	color: #333333;
}
.file input {
    position: absolute;
    font-size: 100px;
    right: 0;
    top: 0;
    opacity: 0;
}
.file:hover {
    background: #4D637B;
    color: #fff;
    text-decoration: none;
}
.container{
	width:550px;
	height:400px;
	position:fixed;
	left:50%;
	top:10%;
	margin-left:-225px;
	z-index:9999;
	background: #FFFFFF;
	box-shadow: 0px 2px 4px 0px rgba(70,82,96,0.30);
	border-radius: 4px;
}
.close_container{
	position:absolute;
	right:20px; 
	top:20px; 
	width:21px;
	height:21px;
	color:#999;
	z-index:100000;
	text-align:center;
	line-height:21px;
	font-size:24px;
	cursor:pointer;
}
.header_title{
	font-size: 18px;
	color: #666666;
	font-weight:400;
	margin:20px;
}
.header_uploads_btn{
	width:100px;
	height:32px;
	line-height:32px;
	text-centen:center;
	background: #1DA1F2;
	border-radius: 4px;
	font-size:15px;
	color:#fff;
	border:none;
}
.jump_mask {
    width: 100%;
    height: 100%;
    position: fixed;
    left: 0;
    top: 0;
    z-index: 555;
    background: #000;
    opacity: 0.6;
    display: none;
}

.transer-detail .upload-btn {
    display: inline-block;
    width: 85px;
    height: 26px;
    margin-top: -26px;
    color: rgb(255, 255, 255);
    line-height: 26px;
    text-align: center;
    margin-left: 60px;
    background: rgb(29, 161, 242);
    border-radius: 4px;
}

.transer-detail .download-btn {
    display: inline-block;
    width: 85px;
    height: 26px;
    margin-top: -26px;
    color: rgb(255, 255, 255);
    line-height: 26px;
    text-align: center;
    margin-left: 3px;
    background: rgb(29, 161, 242);
    border-radius: 4px;
}
.row_top{
	height: 30px;
}
.row_top .para-info{
	float: left;
}
.row_bottom{
	margin-top: 25px;
}
/* 按钮 */
.transer-detail  .recomend{
	width: 80px;
	background: #fc9803;
	margin-top: 0;
}
.transer-detail  .cancel_recomend{
	background: #999999;
	margin-top: 0;
}
/* 全部订单 */
#evaluate>p{
	height: 41px;
    line-height: 41px;
    border-bottom: 1px solid #E3EAF4;
    margin-left: 20px;
}
#evaluate>.user_evaluate{
	height: 41px;
    line-height: 41px;
    border-bottom: 1px solid #E3EAF4;
}
#evaluate>.user_evaluate p{
	float: left;
	margin-left: 20px;
}
#evaluate>.user_evaluate p:first-of-type{
	margin-left: 20px;
}
#evaluate>.user_evaluate p span:first-of-type{
	margin-right: 10px;
}
/* 照片 */
#userShow, #videoShow{
	padding-left: 20px;
}
#userShow>p{
	height: 40px;
    line-height: 40px;
    font-size: 14px;
    color: #333;
}
#userShow img{
	margin-right: 30px;
    margin-bottom: 15px;
    float: left;
}
#videoShow{
	padding-bottom: 15px;
	margin-bottom: 15px;
}
#videoShow>p{
	height: 40px;
    line-height: 40px;
    font-size: 14px;
    color: #333;
}
/* 报价 */
#prices>span{
	float: left;
	margin-right: 8px; 
	margin-top: 10px;
}
#prices>div{
	float: left;
}
#prices>div p{
	float: left;
	font-size: 13px;
    color: #333;
    margin-right: 10px;
    height: 33px;
    line-height: 37px;
}
.add_judge{
	display: block;
    width: 90px;
    height: 26px;
    color: #fff!important;
    line-height: 26px;
    text-align: center;
    margin-top: 6px;
    margin-left: 50px;
    background: rgb(29, 161, 242);
    border-radius: 4px;
    float: left;
}
.add_judge:hover{
	text-decoration: none;
}
</style>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/jquery-1.11.3.min.js"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/sele.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/ajaxfileupload.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/cropbox.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/comfirm.js" charset="UTF-8"></script>
</head>
<body style="padding:0px 30px 30px 30px;">
	<div id="jump_mask" class="jump_mask" style="display: none;"></div>
	<div id="loading"><div class="msg"></div></div>
	<input type="hidden" id="userid" value="${resuserList.data.result.userResume.userid}">
	<div class="mainBody">
		<div class="transer-detail">
			<div class="avatar"><img  class="transer-img" src="${resuserList.data.result.userResume.logoimage}" /></div>
			<div  class="transer">
			<div class="row_top">
			<c:choose>
		    	<c:when test="${resuserList.data.result.userResume.appflag!=1}">
		    		<p  class="para-info"><span class="span-name">${resuserList.data.result.userResume.realusername}</span></p>
		    		<a href="javascript:;"class="edit_head edit-btn" >编辑头像</a>
		    		<p  class="para-info"><span class="span-name">${resuserList.data.result.userResume.username}</span></p>
		    	</c:when>
		    	<c:otherwise>
		    				<p class="para-info">
								<span class="span-name">
								   <c:choose>
								   		<c:when test="${not empty resuserList.data.result.userResume.realusername&&resuserList.data.result.userResume.realusername!='null'}">
								   			${resuserList.data.result.userResume.realusername}
								   		</c:when>
								   		<c:otherwise>
								   			未填写
								   		</c:otherwise>
								   </c:choose>
								</span>
								<c:choose>
									<c:when test="${resuserList.data.result.userResume.isshow==0}">
										<img src="${sourcePath}/resources/images/nouse@2x.png" alt="译员状态" id="imgUrl"/>
									</c:when>
									<c:otherwise>
										<img src="${sourcePath}/resources/images/use@2x.png" alt="译员状态" id="imgUrl"/>
									</c:otherwise>
								</c:choose>
								
							</p>
							<p style="float: left;margin-top: 6px;margin-left: 20px;">
								<span>用户昵称：</span>
								<c:if test="${not empty resuserList.data.result.userResume.username&&resuserList.data.result.userResume.username!='null'}">
									<span class="span-name">
										   ${resuserList.data.result.userResume.username}
									</span>
								</c:if>
							</p>
			</div>
			<div class="row_bottom" style="margin-top: 60px;">
				<span>综合评分：</span>
				<span class="span-name">
						   ${resuserList.data.result.userResume.evaluateScore}
			    </span>	
				<!-- <a href="javascript:;"class="edit_head edit-btn">编辑头像</a> -->
   	            <a href="javascript:;" class="edit-btn" id="editUser" style="margin-top:0;">编辑</a>
   	            <c:if test="${resuserList.data.result.userResume.isshow==0}">
   	            	<a href="javascript:;" class="state-btn" id="openUser" style="margin-top:0;">启用</a>
   	            	<a href="javascript:;" class="unstate-btn" id="colseUser" style="display: none;margin-top:0;">禁用</a>
   	            </c:if>
				<c:if test="${resuserList.data.result.userResume.isshow==1}">
				    <a href="javascript:;" class="state-btn" id="openUser" style="display: none;margin-top:0;">启用</a>
   	            	<a href="javascript:;" class="unstate-btn" id="colseUser" style="margin-top:0;">禁用</a>
   	            </c:if>
   	            <c:if test="${resuserList.data.result.indexRecommend==0}">
   	            	 <a href="javascript:;" class="edit-btn recomend" id="recomend" style="width: 80px;">推荐至首页</a>
   	                 <a href="javascript:;" class="edit-btn cancel_recomend" id="colseRecomend" style="width: 90px;display: none;">取消推荐首页</a>
   	            </c:if>
   	            <c:if test="${resuserList.data.result.indexRecommend==1}">
   	            	 <a href="javascript:;" class="edit-btn recomend" id="recomend" style="width: 80px;display: none;">推荐至首页</a>
   	                 <a href="javascript:;" class="edit-btn cancel_recomend" id="colseRecomend" style="width: 90px;">取消推荐首页</a>
   	            </c:if>
   	            <input type="file" name="fileToUpload" id="fileToUpload" onchange="uploadResumeFile();" style="display:none"/>
  	            	<input type="hidden" name="userId" id="userId" value="${resuserList.data.result.userResume.userid}"/>
  	            	<a href="javascript:void(0)" class="upload-btn" onclick="fileSelected();">上传原始简历</a>
   	            <c:if test="${not empty resuserList.data.result.userResume.resumeFilePath}">
   	            	<a href="javascript:void(0)" class="download-btn" onclick="previewResume('${resuserList.data.result.userResume.resumePdfPath }');">预览原始简历</a>
   	            </c:if>
   	            <c:if test="${not empty resuserList.data.result.userResume.resumeFilePath}">
   	            	<a href="javascript:void(0)" class="download-btn" onclick="downloadResume('${resuserList.data.result.userResume.resumeFilePath }', '${resuserList.data.result.userResume.resumeFileName }');">下载原始简历</a>
   	            </c:if>
		    	</c:otherwise>
		    </c:choose>
		    	</div>
			</div>
			 
			<form name="form1" id="form1">  </form> 
		</div>
		
		<!-- uploads head start -->
		<div class="container" style="display:none;">
		  <!-- 关闭设置头像弹窗 -->
		  <h4 class="header_title">修改头像</h4>
		  <div class="close_container">×</div>	
		  <div class="imageBox">
		    <div class="thumbBox"></div>
		    <div class="spinner" style="display: none; ">
		    	<div class="new-contentarea tc"> 
			    	<a href="javascript:void(0)" class="upload-img">
			        	<label for="upload-file">选择图片</label>
			        </a>
			      	<input type="file" class="" name="upload-file" id="upload-file" />
			    </div>
			    支持jpg、png格式
		    </div>
		  </div>
		  <div class="action clearfix"> 
		    <!-- <input type="file" id="file" style=" width: 200px">-->
		    <input type="button" id="btnZoomIn" class="Btnsty_peyton fl" value="+"  >
		    <input type="button" id="btnZoomOut" class="Btnsty_peyton fl" value="-" >
		    <input type="button" id="btnCrop"  class="header_uploads_btn fr" value="上传">
		  </div>
		</div>
		<!-- uploads head end -->
		<!-- 以前的代码，无效 -->
		<%-- <div class="userdetail">
			<div class="avatar"><img src="${resuserList.data.result.userResume.logoimage}" style="width:120px; height:auto;" /></div>

			<c:if test="${resuserList.data.result.userResume.appflag==1}">
				 <a href="javascript:;" class="file"  >选择图片
			    	<input type="file" name="file" id="file" >
			    </a>
			    <a href="javascript:;" class="file" id="upload" >上传头像</a>

			</c:if>--%>
			<div class="userinfo">
				<%-- <c:if test="${resuserList.data.result.userResume.username!='null'}">
					<h1>${resuserList.data.result.userResume.username}</h1>
				</c:if> --%>
				<c:if test="${resuserList.data.result.userResume.appflag!=1}">
					<a href="${sourcePath}user/importUserView?userid=${resuserList.data.result.userResume.userid}&username=${resuserList.data.result.userResume.username}&userlogo=${resuserList.data.result.userResume.logoimage}" class="btn" style="margin-top:27px;">批量导入工作经历</a>
				</c:if>
				<%-- <div class="userstat"><span>参与会议数：5</span><span>通过会议数：2</span><span>未通过会议数：2</span>主动取消报名数：1</div><!--
				<input type="button" class="btn" value="批量导入工作经历" style="margin-top:27px;"> --> --%>

			</div>
		</div>

		<div id="nav_menu" class="nav_menu">
			<ul>
				<li class="on">基本信息</li>
				<c:choose>
					<c:when test="${resuserList.data.result.userResume.appflag==1}">
						<li>用户工作经历</li>
						<li>译员档期</li>
						<li>译员评价</li>
						<li>全部订单</li>
						<li class="user_show">个性展示</li>
					</c:when>
					<c:otherwise>
						<li>用户工作经历</li>
						<li>导入的简历</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
		<div id="nav_wrap" class="nav_wrap">
			<div class="nav_content" style="background:none;">
				<div class="table-user">
					<table width="100%" cellspacing="0">
						<tr>
						  	<td>
								<span>译员编号</span>
								<c:choose>
									<c:when test="${not empty resuserList.data.result.userResume.usernumber&&resuserList.data.result.userResume.usernumber!='null'}">
										<span>${resuserList.data.result.userResume.usernumber}</span>
									</c:when>
									<c:otherwise>
										<span>无</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<span>手机号</span>
								<span>${resuserList.data.result.userResume.userphonenumber}</span>
							</td>
							<td>
								<span>性别</span>
								<span>${resuserList.data.result.userResume.sex}</span>
							</td>
							<td>
								<span>年龄</span>
								<span>${resuserList.data.result.userResume.age}</span>
							</td>
						</tr>
						<tr>
							<td>
								<span>擅长语种</span>
								<span>${resuserList.data.result.userResume.language}</span>
							</td>
							<td>
								<span>翻译经验</span>
								<c:choose>
									<c:when test="${empty resuserList.data.result.userResume.workyears||
								  	resuserList.data.result.userResume.workyears=='无'}">
										<span>无</span>
									</c:when>
									<c:otherwise>
										<span>${resuserList.data.result.userResume.workyears}年</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<span>常驻地</span>
								<span>${resuserList.data.result.userResume.country}</span>
							</td>
							<td>
								<span>学历</span>
								<span>${resuserList.data.result.userResume.education1}</span>
							</td>
						</tr>
						<tr>
							<td>
								<span>服务次数</span>
								<c:choose>
									<c:when test="${not empty resuserList.data.result.userResume.servicetime}">
										<span>${resuserList.data.result.userResume.servicetime+resuserList.data.result.userResume.addtimes}次</span>
									</c:when>
									<c:otherwise>
										<span>0次</span>
									</c:otherwise>
								</c:choose>
								
							</td>
							<td>
								<span>海外经历</span>
								<span>${resuserList.data.result.userResume.othercountry}</span>
							</td>
							<td>
								<span>个性标签</span>
								<c:choose>
									<c:when test="${not empty resuserList.data.result.userResume.perlabel&&resuserList.data.result.userResume.perlabel!='null'}">
										<c:choose>
											<c:when test="${fn:indexOf(resuserList.data.result.userResume.perlabel, '#')>0}">
												<span>${fn:replace(resuserList.data.result.userResume.perlabel, '#', '/')}</span>
											</c:when>
											<c:otherwise>
												<span>${resuserList.data.result.userResume.perlabel}</span>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<span>无</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td id="prices">
								<span>报价</span>
								<div>
									<c:forEach items="${resuserList.data.result.price}" var="userPrice">
										<p>${userPrice.language}${userPrice.quotePrice}元/天</p>
								    </c:forEach>
							    </div>
							</td>
						</tr>
						<tr>
							<td>
								<span>擅长领域</span>
								<%-- <span>
									<c:forEach items="${resuserList.data.result.userResume.labelSystem}" varStatus="key" var="Recourse">
							${Recourse.hangye}&nbsp;
									</c:forEach>
								</span> --%>
								<span>${resuserList.data.result.userResume.labelSystem},${resuserList.data.result.userResume.labelUser}</span>
							</td>
							<td>
								<span>官方评语</span>
								<span>${resuserList.data.result.userResume.evaluate}</span>
							</td>
						</tr>
					</table>
				</div>
				<p class="navtit">教育经历</p>
				<div class="table-user">
					<table width="100%" cellspacing="0">
						
						<c:choose>
							<c:when test="${resuserList.data.result.userResume.appflag==1}">
								<c:if test="${not empty resuserList.data.result.userResume.school1&&resuserList.data.result.userResume.school1 !='null'}">
									<tr>
										<td>
											<span >${fn:substring(resuserList.data.result.userResume.school1, 0, fn:indexOf(resuserList.data.result.userResume.school1, "#"))}</span>
											<span>${fn:substring(resuserList.data.result.userResume.school1, fn:indexOf(resuserList.data.result.userResume.school1, "#")+1,fn:length(resuserList.data.result.userResume.school1))}</span>
										</td>
									</tr>
								</c:if>
								<c:if test="${not empty resuserList.data.result.userResume.school2&&resuserList.data.result.userResume.school2 !='null'}">
									<tr>
										<td>
											<span>${fn:substring(resuserList.data.result.userResume.school2, 0, fn:indexOf(resuserList.data.result.userResume.school2, "#"))}</span>
											<span>${fn:substring(resuserList.data.result.userResume.school2, fn:indexOf(resuserList.data.result.userResume.school2, "#")+1,fn:length(resuserList.data.result.userResume.school2))}</span>
										</td>
									</tr>
								</c:if>
							</c:when>
							<c:otherwise>
								<c:if test="${resuserList.data.result.userResume.intime1!=''&&resuserList.data.result.userResume.intime1!='null'}">
											<tr>
											   <td>
											   		<span style="width:128px;">${resuserList.data.result.userResume.intime1}-${resuserList.data.result.userResume.outtime1}</span>
											   		<span>${resuserList.data.result.userResume.school1}  ${resuserList.data.result.userResume.major1}/${resuserList.data.result.userResume.education1}</span>
											   	</td>
										    </tr>
										</c:if>
										<c:if test="${resuserList.data.result.userResume.intime2!='null'&&resuserList.data.result.userResume.intime1!=''}">
											<tr>
												<td>
											   		<span style="width:128px;">${resuserList.data.result.userResume.intime2}-${resuserList.data.result.userResume.outtime2}</span>
											   		<span>${resuserList.data.result.userResume.school2}  ${resuserList.data.result.userResume.major2}/${resuserList.data.result.userResume.education2}</span>
											   	</td>
										    </tr>
								</c:if> 
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<p class="navtit">证书</p>
				<div class="table-user">
					<c:choose>
						<c:when test="${empty resuserList.data.result.userResume.usertechnical||resuserList.data.result.userResume.usertechnical=='null'}">
							<p>无</p>
						</c:when>
						<c:otherwise>
							<c:set value="${ fn:split(resuserList.data.result.userResume.usertechnical, '#') }" var="usertechnicalList" />
							<c:forEach items="${usertechnicalList}" var="usertechnical">
								<p>${usertechnical }</p>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
				<p class="navtit">个人描述</p>
				<div class="table-user">
					<p>${resuserList.data.result.userResume.userInfo }</p>
				</div>
			</div>	
			<c:choose>
				<c:when test="${resuserList.data.result.userResume.appflag==1}">
					<div class="nav_content">
							<div class="table-list" id="userJingliList">
								
							</div>
					</div>
					<div class="nav_content">
						<div class="date_edit_content clearfix">
							<input type="hidden" name="startDate" id="startDate" value="" size="100" placeholder="请选择日期" />
							<div class="myCalendar fl" id="myCalendar"></div>
							<div class="myCalendar_fenlei fl">
								<div class="myCalendar_fenlei_1">
									<span></span>
									<span>线下已约</span>
								</div>	
								<div class="myCalendar_fenlei_2">
									<span></span>
									<span>空闲</span>
								</div>
								<div class="myCalendar_fenlei_3">
									<span></span>
									<span>那啥已约</span>
								</div>	
								<div class="clearfix"></div>
								<div class="date_notice">
									<h6>
										<img src="${sourcePath}/resources/images/date_notice.png" />
										操作说明：
									</h6>
									<p>
									通过在日历上点击白色或红色标注的日期，切换译员当天的档期状态（空闲或线下已约），最后点击“完成”设置成功。灰色标注表示那啥已约，不可修改。
									</p>
								</div>
							</div>
						</div>
						<div class="finish_box">
							<div id="finish" class="finish">完成</div>
						</div>
					</div>
					<div class="nav_content">
							<div class="table-list" id="evaluate">
								<p>综合评分</p>
								<div class="user_evaluate">
									<p><span>语言能力</span><span>${resuserList.data.result.userResume.evaluateLanguage}</span></p>
									<p><span>专业能力</span><span>${resuserList.data.result.userResume.evaluateMajor}</span></p>
									<p><span>服务态度</span><span>${resuserList.data.result.userResume.evaluateService}</span></p>
									<p><span>社交礼仪</span><span>${resuserList.data.result.userResume.evaluateSocial}</span></p>
									<a href="${rc.contextPath}/resume/toAddUserEvaluate?resumeId=${resuserList.data.result.userResume.userid}" class="add_judge">添加手动评价</a>
								</div>
								<div id="userEvaluate">
								
								</div>
							</div>
					</div>
					<div class="nav_content">
							<div class="table-list" id="userOrder">
								
							</div>
					</div>
					<div class="nav_content">
							<div class="table-list" id="videoShow">
								<p>视频</p>
								<c:if test="${not empty resuserList.data.result.userResume.video}">
									<video width="320" height="210" controls poster="${resuserList.data.result.userResume.videoimage}">
  										<source src="${resuserList.data.result.userResume.video}" type="video/mp4">
  										您的浏览器不支持 HTML5 video 标签。
								    </video>
								</c:if>
							</div>
							<div class="table-list clear" id="userShow">
								<p>照片（<span id="num">0</span>）</p>
							</div>
					</div>
				</c:when>
				<c:otherwise>
						<div class="nav_content">
							<div class="table-list">
								<table width="100%" cellspacing="0">
									<thead>
										<tr>
											<th width="1%"></th>
											<th>ID</th>
											<th>会议名称</th>
											<th width="8%">会议语言</th>
											<th width="15%">行业标签</th>
											<th width="15%">会议来源</th>
											<th width="10%">会议类型</th>
											<th width="15%">会议时间</th>
										</tr>
									</thead>
									<tbody id="workList">
									<c:set var="index" value="0"/>
									<c:forEach
											items="${resuserList.data.result.userexperience}"
											var="Resource" varStatus="key1">
											<c:if test="${Resource.userid!=null}">
										<c:forEach
											items="${Resource.userjingli}"
											var="Resource2" varStatus="key">
											<c:set var="index" value="${index+1}"/>	
											<tr>
											<td></td>
											<td align="center">${index}</td>
											<td align="center">${Resource2.meetingname}</td>
											<td align="center">${Resource2.language}</td>
											<td align="center">${Resource2.type}</td>
											<td align="center">${Resource2.meetingfrom}</td>
											<td align="center">${Resource2.type}</td>
											<td align="center">${Resource.jingliyear}年${Resource.jinglimonth}月</td>
										</tr>
										</c:forEach>
											
										</c:if>
										</c:forEach>
									</tbody>
								</table>
								<%-- <div id="work_page" class="page">
									<input type="hidden" name="currentPage" value="1">
									<input type="hidden" name="totalPage" value="1">
									<input type="hidden" name="size" value="20">
									<div class="pagego">前往 <input type="text" name="" value="" onchange="getPageList(this, this.value, 'loadWorkList')"> 页</div>
									<div class="pageurl">
									</div>
									<div class="pageset">共<span class="totalpage">0</span>页共<span class="totalmsg">0</span>条数据，设置每页显示条数 <input type="text" value="20" onchange="setPageSize(this, this.value, 'loadWorkList')"></div>
								</div> --%>
							</div>
						</div>
						<div class="nav_content">
							<div class="table-list">
								<table width="100%" cellspacing="0">
									<thead>
										<tr>
										<th width="1%"></th>
											<th width="1%">ID</th>
											<th>会议名称</th>
											<th width="8%">会议语言</th>
											<th width="15%">行业标签</th>
											<th width="15%">会议来源</th>
											<th width="10%">会议类型</th>
											<th width="15%">会议时间</th>
											<th width="6%">操作</th>
										</tr>
									</thead>
									<tbody id="resumeList">
									<c:set var="index" value="0"/>
									<c:forEach
											items="${resuserList.data.result.userexperience}"
											var="Resource" varStatus="key1">
											<c:if test="${Resource.userid==null}">
										<c:forEach
											items="${Resource.otherjianli}"
											var="Resource2" varStatus="key">
											<c:set var="index" value="${index+1}"/>	
											<tr>
											<td></td>
											<td align="center">${index}</td>
											<td align="center">${Resource2.meetingname}</td>
											<td align="center">${Resource2.language}</td>
											<td align="center">${Resource2.category}</td>
											<td align="center">${Resource2.meetingfrom}</td>
											<td align="center">${Resource2.type}</td>
											<td align="center">${Resource2.jianlitime}</td>
											<%-- <td align="center"><a
										href="${cbasePath}user/deleteuserjianli?jianliid=${Resource2.id}&userid=${resuserList.data.result.userResume.userid}">
												删除</a></td> --%>
										    <td align="center"><a href="javascript:void(0);" onclick="del(${Resource2.id},${resuserList.data.result.userResume.userid});">删除</a></td>
										</tr>
										</c:forEach>
											
										</c:if>
										</c:forEach>
									</tbody>
								</table>
								<%-- <div id="resume_page" class="page">
									<input type="hidden" name="currentPage" value="1">
									<input type="hidden" name="totalPage" value="1">
									<input type="hidden" name="size" value="20">
									<div class="pagego">前往 <input type="text" name="" value="" onchange="getPageList(this, this.value, 'loadResumeList')"> 页</div>
									<div class="pageurl">
									</div>
									<div class="pageset">共<span class="totalpage">0</span>页共<span class="totalmsg">0</span>条数据，设置每页显示条数 <input type="text" value="20" onchange="setPageSize(this, this.value, 'loadResumeList')"></div>
								</div> --%>
							</div>
					</div>
				</c:otherwise>
			</c:choose>
			
	</div>
<script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/editCalendar.js" charset="UTF-8"></script>
<script type="text/javascript" src="${sourcePath}/resources/js/common.js"></script>
<script type="text/javascript">
<!--
	$('#nav_wrap').find('.nav_content').eq(0).show();
	$('#nav_menu').find('li').each(function(i){
		$(this).click(function(){
			$(this).addClass('on').siblings().removeClass('on');
			$('#nav_wrap').find('.nav_content').eq(i).show().siblings().hide();

			if(i==1 && $('#workList').children().length<1) loadWorkList();
			else if(i==2 && $('#resumeList').children().length<1) loadResumeList();
		})
	});
	
	//以下函数请根据数据接口完善
	var loading=false;
	pageInfoInit('#work_page');
	pageInfoInit('#resume_page');
	function loadWorkList(){
		if(loading == true) return;
		var pageArr = getPageInfo('#work_page').split('|');
		var currentPage =pageArr[0];
		var totalPage =pageArr[1];
		var size =pageArr[2];

		if(currentPage>totalPage) return;
		$("#loading").show(); // 显示加载器
		loading = true;//标记开始加载
		
		//获取列表并显示
		//$.post('', { size: size, page: currentPage},
			//function(msg){
				$("#loading").hide(); //隐藏加载器

				totalPage=5;
				totalmsg = 10;//信息总条数
				
				// 生成HTML
				var str = '';
				$('#workList').empty().html(str);
				if(totalPage>1) {
					if(currentPage==1) {
						$('#work_page').find('.totalmsg').html(totalmsg);
						$('#work_page').find('.totalpage').html(totalPage);
					}
					var pagestr =showPage('#work_page', totalPage, currentPage, 'loadWorkList');//显示分页跳转
					$('#work_page').find('input[name="totalPage"]').val(totalPage);
					$('#work_page').find('.pageurl').empty().html(pagestr);
				}
				else if(totalPage==1) {$('#work_page').hide();}
				currentPage++;
				$('#work_page').find('input[name="currentPage"]').val(currentPage);
				loading=false;//ajax加载完毕重置
			//});
	}
	

		
	function setMenu(){//或者自己设定导航逻辑
		var str = '<a href="javascript:;" onclick="url_jump(\'${sourcePath}/user/userList\')">用户列表</a><b>&gt;</b><span>用户信息</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	function setMenu2(){//或者自己设定导航逻辑
		var str = '<a href="javascript:;" onclick="url_jump(\'${sourcePath}/resume/getUserResumeList\')">用户列表</a><b>&gt;</b><span>用户信息</span>';
		$('#current_pos', parent.document).html(str);
		return true;
	}
	var falg=${resuserList.data.result.userResume.appflag==1};
	if(falg==1){
		setMenu2()
	}else{
		setMenu();
	}
	
//-->
function del(jianliid,userid){
	 $.ajax({
	     type: "post",
	           url:"${cbasePath}user/deleteuserjianli",
	           data:{jianliid:jianliid,userid:userid},
	           //dataType: "json",
	           async:false,
	           success:function(data){
	        	   $("#resumeList").html(data);
	           }
	    });
}
function checkForm(){
	var FileListType="jpg";
	var filepath = document.getElementById("file").value;
	if(filepath==null||filepath==''){
		alert("请上传图片");
		return false;
	}
	var destStr = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
	if(FileListType.indexOf(destStr) == -1){
		  alert("只允许上传jpg文件");
		  return false;
	}
	return true;
}
$("#upload").click(function(){
	var userid=$("#userid").val();
	if(true){
		$.ajaxFileUpload({
	        url: '${sourcePath}resume/uploadImage', 
	        type: 'post',
	        data: { userid: userid},
	        secureuri: false, //一般设置为false
	        fileElementId: 'file', // 上传文件的id、name属性名
	        dataType: 'text', //返回值类型，一般设置为json、
	        success: function(data){  
	        	data=jQuery.parseJSON(jQuery(data).text());
	               if(data.status==200){
	            	   location.reload();
	               }else{
	            	   alert(data.msg);
	               }
	        },
	        error: function(data, status, e){ 
	            alert(e);
	        }
	    });
	}
});
</script>
<script type="text/javascript">
//uploads head
$(".edit_head").click(function(){
	$(".container").show();
	$("#jump_mask").show();
})
$(".close_container").click(function(){
	$(".container").hide();
	$("#jump_mask").hide();
})
$(window).load(function() {
	var options =
	{
		thumbBox: '.thumbBox',
		spinner: '.spinner',
		imgSrc: ''
	}
	var cropper = $('.imageBox').cropbox(options);
	$('#upload-file').on('change', function(){
		var reader = new FileReader();
		reader.onload = function(e) {
			options.imgSrc = e.target.result;
			cropper = $('.imageBox').cropbox(options);
		}
		reader.readAsDataURL(this.files[0]);
		//this.files = [];
	})
	$('#btnCrop').on('click', function(){
		if($(".spinner").css("display")!="none"){
	      alert("请先选择图片！");
	      return false;
	    }
	    $("#jump_mask").hide();
		var img = cropper.getDataURL();
		var bol=cropper.getBlob();
		var form = new FormData($('#form1')[0]);  
		 
		form.append("file", bol);
		$('.avatar').html('');
		 $('.avatar').append('<img src="'+img+'" class="transer-img">'); 
		$(".container").hide();
		var req = new XMLHttpRequest();
        req.open("POST", '${sourcePath}resume/uploadImage?userid=${resuserList.data.result.userResume.userid}&imgName=${resuserList.data.result.userResume.logoimage}');    
        req.send(form);
        $(".imageBox").attr("style","");
        $(".spinner").css("display","block");
	})
	$('#btnZoomIn').on('click', function(){
		cropper.zoomIn();
	})
	$('#btnZoomOut').on('click', function(){
		cropper.zoomOut();
	})
});

 

</script>
<script>
var ctx="${sourcePath}";
var  orderBeforeDate = ${dates};
var originalArray=${dates};//申明一个原始数组
var userid=$("#userid").val();
$(function(){
	myCalendar('startDate');
	getUserJingli();
	$("#userJingliList").on('click','.pager',function(){
		var n=$(this).attr("index");
		$.ajax({
			type:'post',
			url:ctx+'compation/getUserjingli',
			data:{userid:userid,n:n},
			dataType:"html",
	        async:false,
	        success:function(result){
	        	$("#userJingliList").html(result);
	        }
		});
	});
	getUserEvaluate();
	$("#userEvaluate").on('click','.pager',function(){
		var n=$(this).attr("index");
		$.ajax({
			type:'post',
			url:ctx+'user/getUserEvaluate',
			data:{userid:userid,n:n},
			dataType:"html",
	        async:false,
	        success:function(result){
	        	$("#userEvaluate").html(result);
	        }
		});
	});
	getUserOrder();
	$("#userOrder").on('click','.pager',function(){
		var n=$(this).attr("index");
		$.ajax({
			type:'post',
			url:ctx+'user/getResumeOrder',
			data:{userid:userid,n:n},
			dataType:"html",
	        async:false,
	        success:function(result){
	        	$("#userOrder").html(result);
	        }
		});
	});
	$(".user_show").click(function(){
		var html="";
		$.ajax({
			type:'post',
			url:ctx+'user/getUserPhoto',
			data:{userid:userid},
			dataType:"json",
	        async:false,
	        success:function(result){
	        	var data=result.data.result;
	        	$.each(data,function(i){
	        		var oImg ="<img  src='"+this+"'>";
	        		$("#userShow").append(oImg);
	        		$('#num').html(i+1);
	        	});
	        }
		});
	});
});
function getUserJingli(){
	$.ajax({
		type:'post',
		url:ctx+'compation/getUserjingli',
		data:{userid:userid},
		dataType:"html",
        async:false,
        success:function(result){
        	$("#userJingliList").html(result);
        }
	});
}

function getUserEvaluate(){
	$.ajax({
		type:'post',
		url:ctx+'user/getUserEvaluate',
		data:{userid:userid},
		dataType:"html",
        async:false,
        success:function(result){
        	$("#userEvaluate").html(result);
        }
	});
}

function getUserOrder(){
	$.ajax({
		type:'post',
		url:ctx+'user/getResumeOrder',
		data:{userid:userid},
		dataType:"html",
        async:false,
        success:function(result){
        	$("#userOrder").html(result);
        }
	});
}

$("#editUser").click(function(){
	window.location.href="${sourcePath}/resume/toUpdateUserResume?userid="+userid;
});
$("#openUser").click(function(){
	zdconfirm('<img src="${sourcePath}/resources/images/tishi@2x.png"','你确定要启用该译员',function(r) {
		if(r){
			$.ajax({
				type:'post',
				url:ctx+'/resume/changeState',
				data:{userid:userid,state:1},
				dataType:"json",
		        success:function(result){
		        	if(result.status!=200){
		        		alert(result.msg);
		        	}else{
			        	$("#imgUrl").attr("src","${sourcePath}/resources/images/use@2x.png");
			        	$("#openUser").hide();
			        	$("#colseUser").show();
		        	}
		        }
			});
		}
	});
	
});
$("#colseUser").click(function(){
	zdconfirm('<img src="${sourcePath}/resources/images/tishi@2x.png"','你确定要禁用该译员',function(r) {
		if(r){
			$.ajax({
				type:'post',
				url:ctx+'/resume/changeState',
				data:{userid:userid,state:0},
				dataType:"json",
		        success:function(result){
		        	if(result.status!=200){
                        alert(result.msg);
                    }else{
			        	$("#imgUrl").attr("src","${sourcePath}/resources/images/nouse@2x.png");
			        	$("#colseUser").hide();
			        	$("#openUser").show();
                    }
		        }
			});
		}
	});
	
});
//推荐至首页
$("#recomend").click(function(){
	zdconfirm('<img src="${sourcePath}/resources/images/tishi@2x.png"','你确定要推荐该译员至首页',function(r) {
		if(r){
			$.ajax({
				type:'post',
				url:ctx+'/user/recomendResume',
				data:{userid:userid},
				dataType:"json",
		        success:function(result){
		        	if(result.status!=200){
                        alert(result.msg);
                    }else{
			        	$("#recomend").hide();
			        	$("#colseRecomend").show();
                    }
		        }
			});
		}
	});
	
});
//取消推荐
$("#colseRecomend").click(function(){
	zdconfirm('<img src="${sourcePath}/resources/images/tishi@2x.png"','你确定要取消推荐该译员至首页',function(r) {
		if(r){
			$.ajax({
				type:'post',
				url:ctx+'/user/cancelRecomendResume',
				data:{userid:userid},
				dataType:"json",
		        success:function(result){
		        	if(result.status!=200){
                        alert(result.msg);
                    }else{
			        	$("#colseRecomend").hide();
			        	$("#recomend").show();
                    }
		        }
			});
		}
	});
	
});

/**
 * 选择要上传的文件
 */
function fileSelected() {
	$("#fileToUpload").click();
}

/**
 * 上传到服务器
 */
function uploadResumeFile(){
	var userid=$("#userId").val();
	var FileListType="DOCX,DOC,XLSX,XLS,TXT,PPTX,PPT,PDF";
    var filepath = document.getElementById("fileToUpload").value;
    if(filepath==null||filepath==''){
        alert("请上传文件");
        return false;
    }
    var destStr = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
    if(FileListType.indexOf(destStr.toLocaleUpperCase()) == -1){
          alert("不支持该文件类型");
          return false;
    }
    $("#jump_mask").show();
	if(true){ 
		$.ajaxFileUpload({
	        url: '${sourcePath}resume/uploadResume', 
	        type: 'post',
	        data: { userId: userid},
	        secureuri: false, //一般设置为false
	        fileElementId: 'fileToUpload', // 上传文件的id、name属性名
	        dataType: 'text', //返回值类型，一般设置为json、
	        success: function(data){
	          $("#jump_mask").hide();
	          if(data !='' && data !=null && data.indexOf("权限") >-1){
                  alert(data); 
              }else{
            	  data=jQuery.parseJSON(jQuery(data).text());
                  if(data.status==200){
                      alert("上传成功！");
                      location.reload();
                  }else{
                      alert(data.msg);
                  } 
              }
	           
	        },
	        error: function(data, status, e){ 
	        	$("#jump_mask").hide();
	            alert(e);
	        }
	    });
	}
}

/**
 * 预览简历
 */
function previewResume(resumePdfPath){
	window.open(resumePdfPath);
	//window.open("${sourcePath}/resume/preview?resumePdfPath="+resumePdfPath);
	//window.location.href = "${sourcePath}/resume/preview?resumeFilePath="+resumeFilePath;
}

/**
 * 下载简历
 */
function downloadResume(resumeFilePath, resumeFileName){
	window.location.href = "${sourcePath}/resume/downloadResume?resumeFilePath="+resumeFilePath+"&resumeFileName="+resumeFileName;
	//window.location.href = resumeFilePath;
}
</script>
</body>
</html>