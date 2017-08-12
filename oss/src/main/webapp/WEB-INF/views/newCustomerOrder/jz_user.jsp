<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pageNation" uri="/WEB-INF/tld/pagenation.tld" %>
<%@ taglib prefix="Date" uri="/WEB-INF/tld/datetag.tld" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="ZH-cn">
<head>
    <meta charset="UTF-8">
    <title>运营支撑系统OSS-用户信息</title>
    <link href="${sourcePath}/resources/css/reset.css" rel="stylesheet" type="text/css"/>
    <link href="${sourcePath}/resources/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${sourcePath}/resources/css/table_form.css" rel="stylesheet" type="text/css"/>
    <link href="${sourcePath}/resources/css/sele.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/jquery-1.8.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidator.js"
            charset="UTF-8"></script>
    <script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/formvalidatorregex.js"
            charset="UTF-8"></script>
    <script language="javascript" type="text/javascript" src="${sourcePath}/resources/js/sele.js"
            charset="UTF-8"></script>
</head>
<body>
<div id="loading">
    <div class="msg"></div>
</div>
<div class="mainBody">
    <div class="tiaojian_wrap tr">
        <form method="post" action="${sourcePath}/workorder/userList">
            <div class="uboxstyle ubox_sele">
                <select id="optype" name="optype">
                    <option value="username" selected>姓名</option>
                    <option value="userphonenumber">手机号</option>
                    <option value="sex">性别</option>
                    <option value="language">语种</option>
                    <!--  <option value="hange">行业标签</option> -->
                    <!--  <option value="">参与任务</option> -->
                </select>
            </div>
            <input type="text" class="search_key" id="keyword" name="keyword" value="">
            <input type="submit" class="sub_btn" value="查找">
        </form>
    </div>

    <div class="table-list">
        <table width="100%" cellspacing="0" id="mytable">
            <thead>
            <tr>
                <th width="6%">姓名</th>
                <th width="6%">性别</th>
                <th width="6%">手机号</th>
                <th width="6%">年龄</th>
                <th width="6%">城市</th>
                <th width="8%">报价</th>
                <th width="6%">审核状态</th>
                <th width="6%">操作</th>
            </tr>
            </thead>
            <tbody id="meetingList">
            <c:forEach items="${resuserList.data.result.datas}" varStatus="key" var="Recourse">
                <tr>
                    <form action="${sourcePath}workorder/submituserin?transnworkid=${transnworkid}&workorderid=${workorderid}&userid=${Recourse.id}" method="post" class="sub_user_form">
                        <td align="center">${Recourse.username}</td>
                        <td align="center">${Recourse.sex}</td>
                        <td align="center">${Recourse.userphonenumber}</td>
                        <td align="center">${Recourse.age}</td>
                        <td align="center">${Recourse.country}</td>
                        <td align="center"><input type="text" name="money" class="sub_user_input in-on"
                                                  placeholder="请确认报价"/></td>
                        <td align="center">待确定</td>
                        <td align="center"><input type="submit" value="添加到会议" name="sub_user_submit"
                                                  class="sub_user_submit btn-cl" onClick="setAddUser(this);"/></td>
                    </form>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>
<script type="text/javascript" src="${sourcePath}/resources/js/common.js"></script>
<script type="text/javascript">
    //以下函数请根据数据接口完善
    function setAddUser(dom) {
        if (confirm('确定要添加这个译员吗？')) {//确认

            return true;
        }
        return false;
    }
    //判断报价是否输入和格式是否正确
    function empty(e)//判断是否为空函数
    {
        var val = $(e).val();
        var pre = /^\s*$/;
        if (pre.test(val)) {
            return true;
        }
    }

    for (var i = 0; i < $('.btn-cl').length; i++) {
        (function (index) {
            $('.btn-cl').eq(index).click(function () {
                if (empty('.in-on:eq(' + index + ')')) {
                    alert('报价不能为空');
                    return false;
                }
                var put = $('.in-on:eq(' + index + ')').val();
                var rput = /^[0-9]{1,}$/;
                if (!rput.test(put)) {
                    alert("请输入正确的格式'0-9'之间");
                    return false;
                }
                alert("添加成功");
            });
        })(i);

    }


</script>
</body>
</html>



























