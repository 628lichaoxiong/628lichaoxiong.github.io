<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%
String cpath = request.getContextPath();
String cbasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
String cbasePath2 = "http://oss.nashaapp.com";
%>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>运营支持系统</title>
    <script src="<%=cbasePath%>/resources/assets/js/jquery.min.js"></script>
    <script src="<%=cbasePath%>/resources/assets/js/bootstrap.min.js"></script>
    <link href="<%=cbasePath%>/resources/assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=cbasePath%>/resources/assets/css/font.css" rel="stylesheet">
    <style>
        #mainMenu li span {
            padding: 5px;
            margin-left: 10px;
            margin-right: 10px;
        }
    </style>
</head>
<!--主菜单加载和框架页调用-->
<body>
<div class="container">
    <div class="row">
        <div class="col-md-2">
            <div class="text-center" style="text-align: center;padding-top: 20px;">
                <img src="<%=cbasePath%>/resources/assets/image/logo.png" class="col-xs-12" alt=""/>
            </div>
            <div class="text-center" style="text-align: center;padding: 20px;">
                <h4>运营支持系统OSS</h4>
            </div>
            <div class="menu">
                <ul id="mainMenu" class="nav nav-pills nav-stacked" role="tablist">
                    <c:if test="${group=='1'||group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>user/userList" target="mainFrame"><span class="glyphicon glyphicon-cloud"></span>用户管理</a>
                    </li>
                     </c:if>
                    <c:if test="${group=='1'||group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>transnwork/transnworklist" target="mainFrame"><span class="glyphicon glyphicon-star"></span>传神任务</a>
                    </li>
                    </c:if>
                     <c:if test="${group=='1'||group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>usertransnwork/transnworklist" target="mainFrame"><span class="glyphicon glyphicon-star"></span>任务报名</a>
                    </li>
                    </c:if>
                     <c:if test="${group=='1'||group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>system/getsystemmessagelist" target="mainFrame"><span class="glyphicon glyphicon-star"></span>推送消息</a>
                    </li>
                    </c:if>
                    
                     <c:if test="${group=='1'||group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>fadeback/getfadebacklist" target="mainFrame"><span class="glyphicon glyphicon-star"></span>用户反馈</a>
                    </li>
                    </c:if>
                     <%-- <c:if test="${group=='1'||group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>transnwork/test" target="mainFrame"><span class="glyphicon glyphicon-star"></span>test</a>
                    </li>
                    </c:if> --%>
                    <c:if test="${group=='0'}">
                    <li role="presentation">
                        <a href="<%=cbasePath%>transnwork/test" target="mainFrame"><span class="glyphicon glyphicon-star"></span>OSS管理</a>
                    </li>
                    </c:if>
                </ul>
            </div>
        </div>
        <c:if test="${group=='1'||group=='0'}">
        <div class="col-md-10">
            <iframe style="min-height:1600px;" id="mainFrame" name="mainFrame" class="col-md-12" src="<%=cbasePath%>user/userList" frameborder="0"></iframe>
        </div>
         </c:if>
         
    </div>

</div>
<script>
    $(function () {
        $("#mainMenu li").click(function () {
            $(this).siblings().removeClass("active");
            $(this).addClass("active");
        });
        $("#mainFrame").load(function () {
            var mainheight = $(this).contents().find("body").height() + 130;
            $(this).height(mainheight);
        });
    });
</script>
</body>
</html>
