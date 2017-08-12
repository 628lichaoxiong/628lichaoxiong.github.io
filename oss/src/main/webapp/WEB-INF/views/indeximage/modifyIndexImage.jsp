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
<title>运营支撑系统OSS-新增轮播</title>
<link href="${rc.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/main.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/table_form.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/scanCalendar.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/card.css" rel="stylesheet" type="text/css" />
<link href="${rc.contextPath}/resources/css/cropbox.css" rel="stylesheet" type="text/css" />
<style>
.table-list{ margin-bottom:20px;}
.small_title_p{ margin-bottom:10px; }
</style>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/jquery-1.8.2.min.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/formvalidatorregex.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/comfirm.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/scanCalendar.js"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/cropbox.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/ajaxfileupload.js" charset="UTF-8"></script>
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
        top:4px;
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
    </style>
</head>
<body style="padding: 10px 30px 0 30px">
    <div id="jump_mask" class="jump_mask" style="display:none;"></div>
    <input type="hidden" value="${indexImage.imageUrl}" name="photoSecond" id="photoSecond"/><!-- 第二次点击时 -->
    <input type="hidden" value="${indexImage.imageSubjectUrl}" name="photoSecond1" id="photoSecond1"/><!-- 第二次点击时 -->
    <input type="hidden" value="${indexImage.id}" name ="id" id="id"/><!-- 跳转链接-->
    <div id="loading"><div class="msg"></div></div>
    <form id="formID">
    <div class="new_back">
        <h4>${operaName}轮播</h4>
        <div class="new_card clearfix">
            <div class="add_card fl">
                <div class="order_information_left_c card_form">
                    <div class="list_div clearfix">
                            <p>轮播名称</p>
                            <input type="text" name="imageName" maxlength="20" id="imageName" value="${indexImage.imageName}" placeholder="请输入轮播名称"/>
                    </div>
                    <div class="list_div clearfix">
                            <p>轮播类型</p>
                            <select name="type" id="type" class="select_modify" style="width: 130px">
                                <option <c:if test="${indexImage.type ==1}"> selected="selected" </c:if> value="1">红包</option>
                                <option <c:if test="${indexImage.type ==2}"> selected="selected" </c:if> value="2">客户端首页</option>
                                <option <c:if test="${indexImage.type ==3}"> selected="selected" </c:if> value="3">译员端首页</option>
                            </select>
                    </div>
                    <div class="list_div clearfix">
                            <p>轮播图片</p>
                            <div class="row-inp row-inp-img">
                                <div class="row-inp-left row-inp-require avatar" id="avatar" style="float: left;">
                                <c:choose>
                                 <c:when test="${not empty indexImage}">
                                     <img src="${indexImage.imageUrl}" alt="无图片" class="photo-index"/>
                                 </c:when>
                                 <c:otherwise>
                                    <img src="${rc.contextPath}/resources/images/index_image.png" alt="photo" class="photo-index"/>
                                 </c:otherwise>
                                </c:choose>
                                </div>
                                <div class="row-inp-right" style="float: left;margin: 20px 0 0 25px;">
                                    <a href="javascript:;" class="edit_head btn">上传图片</a>
                                    <input type="hidden"  id="uploadfileImage" value="${indexImage.imageUrl}"/>
                                    <!-- <input type="file" class="inp-file" id="imgFile" name="imgFile"/> -->
                                </div>
                            </div>
                    </div>
                    <div class="list_div clearfix">
                            <p>跳转类型</p>
                            <select name="urlType" id="urlType" onchange="subjectSwith(this.value)" class="select_modify" style="width: 130px">
                                <c:choose>
                                 <c:when test="${ not empty indexImage}">
                                    <option <c:if test="${indexImage.urlType == '0'}"> selected="selected" </c:if> value="0">链接</option>
                                    <option <c:if test="${indexImage.urlType == '1'}"> selected="selected" </c:if> value="1">专题</option>
                                 </c:when>
                                 <c:otherwise>
                                    <option  value="0" selected="selected">链接</option>
                                    <option  value="1">专题</option>
                                 </c:otherwise>
                                </c:choose>
                            </select>
                    </div>
                    <div class="list_div clearfix subjectHide">
                            <p>跳转地址</p>
                            <input type="text" name="skipUrl" maxlength="100" id="skipUrl" value="${indexImage.skipUrl}" placeholder="请输入跳转地址"/>
                    </div>
                    <div class="list_div clearfix subjectShow">
                            <p>搜索编号</p>
                            <input type="text" name="serarchId" maxlength="12" id="serarchId" onkeyup="value=value.replace(/[^\d]/g,'')" value="${indexImage.serarchId}" placeholder="请输入推荐搜索编号"/>
                    </div>
                     <div class="list_div clearfix subjectShow">
                            <p>专题图片</p>
                            <div class="row-inp row-inp-img">
                                <div class="row-inp-left row-inp-require avatar" id="avatar1" style="float: left;">
                                <c:choose>
                                 <c:when test="${not empty indexImage}">
                                     <img src="${indexImage.imageSubjectUrl}" alt="无图片" class="photo-index"/>
                                 </c:when>
                                 <c:otherwise>
                                    <img src="${rc.contextPath}/resources/images/index_image.png" alt="photo" class="photo-index"/>
                                 </c:otherwise>
                                </c:choose>
                                </div>
                                <div class="row-inp-right" style="float: left;margin: 20px 0 0 25px;">
                                    <a href="javascript:;" class="edit_head1 btn">上传图片</a>
                                    <input type="hidden"  id="uploadfileImage1" value="${indexImage.imageSubjectUrl}"/>
                                    <!-- <input type="file" class="inp-file" id="imgFile" name="imgFile"/> -->
                                </div>
                            </div>
                    </div>
                    
                </div>
                <div class="btn-group clear">
                    <input type="button" id="submitCard" value="确定" class="save-btn">
                </div>
             </div>
         </div>
</div>
<!-- uploads head start -->
        <div class="container" id ="container" style="display:none;">
          <!-- 关闭设置图片弹窗 -->
          <h4 class="header_title">修改图片</h4>
          <div class="close_container" id ="close_container">×</div>  
          <div class="imageBox" id ="imageBox">
            <div class="thumbBox" id ="thumbBox"></div>
            <div class="spinner" id ="spinner" style="display: none; ">
                <div class="new-contentarea tc"> 
                    <a href="javascript:;" class="upload-img">
                        <label for="upload-file">选择图片</label>
                    </a>
                    <input type="file" class="inp-file" name="uploadfile" id="uploadfile" />
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
        
        <div class="container" id ="container1" style="display:none;">
          <!-- 关闭设置图片弹窗 -->
          <h4 class="header_title">修改图片</h4>
          <div class="close_container" id ="close_container1">×</div>  
          <div class="imageBox" id ="imageBox1">
            <div class="thumbBox" id ="thumbBox1"></div>
            <div class="spinner" id ="spinner1" style="display: none; ">
                <div class="new-contentarea tc"> 
                    <a href="javascript:;" class="upload-img">
                        <label for="upload-file">选择图片</label>
                    </a>
                    <input type="file" class="inp-file" name="uploadfile1" id="uploadfile1" />
                </div>
                支持jpg、png格式
            </div>
          </div>
          <div class="action clearfix"> 
            <!-- <input type="file" id="file" style=" width: 200px">-->
            <input type="button" id="btnZoomIn1" class="Btnsty_peyton fl" value="+"  >
            <input type="button" id="btnZoomOut1" class="Btnsty_peyton fl" value="-" >
            <input type="button" id="btnCrop1"  class="header_uploads_btn fr" value="上传">
          </div>
        </div>
</form>
<!--错误提示弹窗-->
    <div id="showEorr"></div>
<script language="javascript" type="text/javascript" src="${rc.contextPath}/resources/js/indexImage.js"></script>
<script type="text/javascript">
var ctx="${rc.contextPath}";
$(function(){
    setMenu();
    //服务弹窗展示和选择处理
    function setMenu() {
        var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/indexImage/getIndexImageList\')">OSS轮播管理列表</a><b>&gt;</b><span>'+'${operaName}'+'轮播</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
    var urlType ="${indexImage.urlType}";
    subjectSwith(urlType); 
});
</script>

</body>
</html>
