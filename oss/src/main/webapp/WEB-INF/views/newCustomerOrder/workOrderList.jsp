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
    <title>运营支撑系统OSS-订单列表</title>
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
    <script src="${sourcePath}/resources/assets/js/bootstrap.min.js"></script>
    <link href="${sourcePath}/resources/assets/css/bootstrap.min.css"
          rel="stylesheet">
</head>
<body>
<div id="loading">
    <div class="msg"></div>
</div>
<div class="mainBody">
    <%--<div class="tiaojian_wrap tr">--%>
    <%--<div class="uboxstyle ubox_sele">--%>
    <%--<select id="optype" name="optype">--%>
    <%--<option value="" selected>会议名称</option>--%>
    <%--&lt;%&ndash;<option value="">时间</option>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<option value="">语种</option>&ndash;%&gt;--%>
    <%--&lt;%&ndash;<option value="">参与用户</option>&ndash;%&gt;--%>
    <%--</select>--%>
    <%--</div>--%>
    <%--<input type="text" class="search_key" id="search_key" value="">--%>
    <%--<input type="button" class="sub_btn" value="查找" onclick="searchMeeting()">--%>

    <%--<div class="nav_btn">--%>
    <%--<a href="meeting_add.html" class="btn">客户管理</a>--%>
    <%--</div>--%>
    <%--</div>--%>
    <div class="tiaojian_wrap tr">
        <form class="form-inline" action="${sourcePath}workorder/getworkorderlist"
              method="get" role="form">
            <div class="form-group">
                <label class="sr-only" for="keyword">Search:</label> <input
                    class="form-control" id="keyword" name="keyword"
                    placeholder="输入会议名称" value="${keyword}">
            </div>

            <button id="searchIt" type="submit" class="btn btn-default">搜索</button>
        </form>
    </div>

    <div class="table-list">
        <table width="100%" align="center" cellspacing="0" id="mytable">
            <thead>
            <tr>
                <th align="center" width="10%">序号</th>
                <th align="center">会议名称</th>
                <th align="center" width="10%">订单编号</th>
                <th align="center" width="10%">企业名称</th>
                <th align="center" width="10%">行业标签</th>
                <th align="center" width="10%">城市</th>
                <th align="center" width="10%">订单状态</th>
                <th align="center" width="10%">同传设备</th>
                <th align="center" width="10%">现场管理</th>
                <th align="center" width="10%">金额</th>
            </tr>
            </thead>
            <tbody id="meetingList">
            <c:forEach items="${orderlist.data.result.datas}"
                       varStatus="key" var="Recourse">
                <tr>
                    <td align="center"><a
                            href="${sourcePath}workorder/gettransnworkinfo?workorderid=${Recourse.id}">${key.count}</a></td>
                    <td align="center"><a
                            href="${sourcePath}workorder/gettransnworkinfo?workorderid=${Recourse.id}">${Recourse.ordermeetingname}</a>
                    </td>
                    <td align="center">${Recourse.id}</td>
                     <c:if test="${Recourse.company == 'null'}">
                    	<td align="center"></td>
                    </c:if>
                    <c:if test="${Recourse.company != 'null'}">
                    	<td align="center">${Recourse.company.companyname}</td>
                    </c:if>
                    <td align="center">互联网</td>

                    <c:if test="${Recourse.meetingcity== 'null'}">
                        <td align="center">无</td>
                    </c:if>
                    <c:if test="${Recourse.meetingcity!= 'null'}">
                        <td align="center">${Recourse.meetingcity}</td>
                    </c:if>


                    <td align="center"><c:if test="${Recourse.payflag== '0'}">已发布</c:if>
                        <c:if test="${Recourse.payflag== '1'}">已确认</c:if>
                        <c:if test="${Recourse.payflag== '2'}">已付款</c:if>
                        <c:if test="${Recourse.payflag== '3'}">已评价</c:if>
                    </td>


                    <td align="center"><c:if test="${Recourse.ismachine== '1'}">申请中</c:if>
                        <c:if test="${Recourse.ismachine== '0'}">无</c:if>
                    </td>


                    <td align="center"><c:if test="${Recourse.ismanager== '0'}">无</c:if>
                        <c:if test="${Recourse.ismanager== '1'}">有</c:if>
                    </td>

                    <td align="center">${Recourse.summoney}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>


        <nav> <!-- 分页开始 -->
            <ul class="pagination">
                <pageNation:PageNation
                        currPage="${orderlist.data.result.size+1}"
                        totalPages="${orderlist.data.result.totalpage}"
                        perPageRows="20" totalRows="${orderlist.data.result.total}"
                        linkBaseUrl="${sourcePath}workorder/getworkorderlist?id=">
                </pageNation:PageNation>
            </ul>

            <!-- 分页结束 --> </nav>

        <%--<div id="meeting_page" class="page">--%>
        <%--<input type="hidden" name="currentPage" value="1"><!-- 当前显示页，默认1。总页数，默认1。每页显示条数，默认20 -->--%>
        <%--<input type="hidden" name="totalPage" value="1">--%>
        <%--<input type="hidden" name="size" value="20">--%>
        <%--<div class="pagego">前往 <input type="text" name="" value="" onchange="getPageList(this, this.value, 'loadMeetingList')"> 页</div>--%>
        <%--<div class="pageurl">--%>
        <%--<span class="page_prev"></span>--%>
        <%--<span>1</span>--%>
        <%--<a href="#">2</a>--%>
        <%--<a href="#">3</a>--%>
        <%--<a href="#">...</a>--%>
        <%--<a href="#">6</a>--%>
        <%--<a href="#" class="page_next"></a>--%>
        <%--</div>--%>
        <%--<div class="pageset">共<span class="totalpage">0</span>页共<span class="totalmsg">0</span>条数据，设置每页显示条数 <input type="text" value="20" onchange="setPageSize(this, this.value, 'loadMeetingList')"></div>--%>
        <%--</div>--%>
    </div>
</div>
<script type="text/javascript" src="${sourcePath}/resources/js/common.js"></script>
<script type="text/javascript">
    <!--
    function searchMeeting() {
        var type = $('#optype').val();
        var key = $('#search_key').val();

        //查找数据....
        $('#meeting_page').find('input[name="currentPage"]').val(1);
        $('#meeting_page').find('input[name="totalPage"]').val(1);
        $('#meeting_page').find('input[name="size"]').val(20);
    }
    function setMenu() {//或者自己设定导航逻辑
        var str = '<span>订单列表</span>';
        $('#current_pos', parent.document).html(str);
        return true;
    }
    function makeDown(dom) {//下架
        if (!$(dom).hasClass('disable') && confirm('如果执行操作，则此条会议在app发现中将不可见，确认要执行此操作吗？')) {
            //执行下架操作ajax....

            //下架成功执行
            $(dom).addClass('disable').parent().prev().text('已通过');
        }
    }
    setMenu();
    //-->
</script>
<script>
    var obj = {
        "msg": "正常处理，并data中有返回数据",
        "data": {
            "result": {
                "totalpage": 7,
                "datas": [{
                    "userid": 207,
                    "payflag": "1",
                    "machinemoney": 0,
                    "mangermoney": 1000,
                    "servicepercent": "0.2",
                    "servicemoney": 4200,
                    "peoplenumber": "64",
                    "mangerpeople": "1",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "0",
                    "ismachine": "1",
                    "summoney": 25200,
                    "ismanager": "1",
                    "meetingcity": "北京市",
                    "rooms": "0",
                    "usetime": "2016-08-20 14:19~2016-08-20 16:19",
                    "buildtime": "2016-08-20 11:19",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "几点能到男的女的呢",
                    "ordermeetingtime": "2016-08-20 14:19~2016-08-20 16:19",
                    "ordermeetingname": "就回家巴巴爸爸吧",
                    "meetinginfo": null,
                    "fapiao": "{\"id\":454,\"customerId\":207,\"company\":\"北京大学大家觉得你的\",\"identifier\":\"556668556\",\"address\":\"6852435833578\",\"mobile\":\"01059555555\",\"bank\":\"v胡i官方v好几块呢\",\"account\":\"86359624358685\",\"isdefault\":0}",
                    "showossflag": null,
                    "time": "1471328507028",
                    "days": "10",
                    "id": 122,
                    "type": "摆放",
                    "size": "49469"
                }, {
                    "userid": 207,
                    "payflag": "2",
                    "machinemoney": 0,
                    "mangermoney": 1000,
                    "servicepercent": "0.2",
                    "servicemoney": 500,
                    "peoplenumber": "5565",
                    "mangerpeople": "1",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "1",
                    "ismachine": "1",
                    "summoney": 3000,
                    "ismanager": "1",
                    "meetingcity": "台湾省",
                    "rooms": "12",
                    "usetime": "2016-08-31 14:05~2016-08-31 16:05",
                    "buildtime": "2016-08-31 11:05",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "发酒疯口干口苦封口费",
                    "ordermeetingtime": "2016-08-31 14:05~2016-08-31 16:05",
                    "ordermeetingname": "评价",
                    "meetinginfo": null,
                    "fapiao": "{\"id\":454,\"customerId\":207,\"company\":\"北京大学大家觉得你的\",\"identifier\":\"556668556\",\"address\":\"6852435833578\",\"mobile\":\"01059555555\",\"bank\":\"v胡i官方v好几块呢\",\"account\":\"86359624358685\",\"isdefault\":0}",
                    "showossflag": null,
                    "time": "1471327691523",
                    "days": "1",
                    "id": 121,
                    "type": "押证件",
                    "size": "55655"
                }, {
                    "userid": 100,
                    "payflag": "0",
                    "machinemoney": 0,
                    "mangermoney": 0,
                    "servicepercent": "0.2",
                    "servicemoney": 0,
                    "peoplenumber": null,
                    "mangerpeople": null,
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "0",
                    "ismachine": "0",
                    "summoney": 0,
                    "ismanager": "0",
                    "meetingcity": null,
                    "rooms": null,
                    "usetime": null,
                    "buildtime": null,
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": null,
                    "ordermeetingtime": "2016-09-11 13:35~2016-09-11 15:00",
                    "ordermeetingname": "八月十六日星期二下午十三点三十六分",
                    "meetinginfo": null,
                    "fapiao": null,
                    "showossflag": null,
                    "time": "1471325872374",
                    "days": null,
                    "id": 120,
                    "type": null,
                    "size": null
                }, {
                    "userid": 207,
                    "payflag": "1",
                    "machinemoney": 0,
                    "mangermoney": 1000,
                    "servicepercent": "0.2",
                    "servicemoney": 500,
                    "peoplenumber": "1",
                    "mangerpeople": "1",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "1",
                    "ismachine": "1",
                    "summoney": 3000,
                    "ismanager": "1",
                    "meetingcity": "北京市",
                    "rooms": "12",
                    "usetime": "2016-08-08 00:26~2016-08-10 02:26",
                    "buildtime": "2016-08-07 21:26",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "好的好的就觉得基督教的叫法就那放哪放哪飞机",
                    "ordermeetingtime": "2016-08-08 00:26~2016-08-10 02:26",
                    "ordermeetingname": "回到家都好好的回电话",
                    "meetinginfo": null,
                    "fapiao": "{\"id\":454,\"customerId\":207,\"company\":\"北京大学大家觉得你的\",\"identifier\":\"556668556\",\"address\":\"6852435833578\",\"mobile\":\"01059555555\",\"bank\":\"v胡i官方v好几块呢\",\"account\":\"86359624358685\",\"isdefault\":0}",
                    "showossflag": null,
                    "time": "1471325476961",
                    "days": "10",
                    "id": 119,
                    "type": "摆放",
                    "size": "6466464"
                }, {
                    "userid": 110,
                    "payflag": "0",
                    "machinemoney": 0,
                    "mangermoney": 0,
                    "servicepercent": "0.2",
                    "servicemoney": 0,
                    "peoplenumber": "5",
                    "mangerpeople": "",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "0",
                    "ismachine": "1",
                    "summoney": 0,
                    "ismanager": "0",
                    "meetingcity": "内蒙古包头市",
                    "rooms": "2",
                    "usetime": "2016-08-16 13:04~2016-08-19 15:04",
                    "buildtime": "2016-08-16 10:04",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "几个",
                    "ordermeetingtime": "2016-08-16 13:04~2016-08-19 15:04",
                    "ordermeetingname": "啊啊啊啊",
                    "meetinginfo": null,
                    "fapiao": null,
                    "showossflag": null,
                    "time": "1471324173540",
                    "days": "3",
                    "id": 118,
                    "type": "押证件",
                    "size": "1144"
                }, {
                    "userid": 207,
                    "payflag": "2",
                    "machinemoney": 0,
                    "mangermoney": 0,
                    "servicepercent": "0.2",
                    "servicemoney": 2000,
                    "peoplenumber": "12",
                    "mangerpeople": "0",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "1",
                    "ismachine": "1",
                    "summoney": 12000,
                    "ismanager": "0",
                    "meetingcity": "内蒙古包头市",
                    "rooms": "1",
                    "usetime": "2016-08-19 18:25~2016-08-22 20:25",
                    "buildtime": "2016-08-19 15:25",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "gxgj",
                    "ordermeetingtime": "2016-08-19 18:25~2016-08-22 20:25",
                    "ordermeetingname": "fugv",
                    "meetinginfo": null,
                    "fapiao": "{\"id\":454,\"customerId\":207,\"company\":\"北京大学大家觉得你的\",\"identifier\":\"556668556\",\"address\":\"6852435833578\",\"mobile\":\"01059555555\",\"bank\":\"v胡i官方v好几块呢\",\"account\":\"86359624358685\",\"isdefault\":0}",
                    "showossflag": null,
                    "time": "1471318008629",
                    "days": "",
                    "id": 117,
                    "type": "押证件",
                    "size": "12"
                }, {
                    "userid": 223,
                    "payflag": "1",
                    "machinemoney": 0,
                    "mangermoney": 1000,
                    "servicepercent": "0.2",
                    "servicemoney": 16200,
                    "peoplenumber": "100",
                    "mangerpeople": "1",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "1",
                    "ismachine": "1",
                    "summoney": 97200,
                    "ismanager": "1",
                    "meetingcity": "北京市",
                    "rooms": "500",
                    "usetime": "2016-08-23 10:48~2016-08-25 12:48",
                    "buildtime": "2016-08-23 07:48",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "都觉得就觉得就到家",
                    "ordermeetingtime": "2016-08-23 10:48~2016-08-25 12:48",
                    "ordermeetingname": "就到家都觉得好多好多话",
                    "meetinginfo": null,
                    "fapiao": "{\"id\":456,\"customerId\":223,\"company\":\"刚回家姐姐\",\"identifier\":\"75754868676558554656\",\"address\":\"发酒疯警察局飞机飞机飞机飞机国际法经济\",\"mobile\":\"88888877\",\"bank\":\"喜欢画画吃海鲜刺激刺激超级飞机\",\"account\":\"57675757546465775757\",\"isdefault\":0}",
                    "showossflag": null,
                    "time": "1471315858387",
                    "days": "1000",
                    "id": 116,
                    "type": "押证件",
                    "size": "4949646"
                }, {
                    "userid": 223,
                    "payflag": "0",
                    "machinemoney": 0,
                    "mangermoney": 0,
                    "servicepercent": "0.2",
                    "servicemoney": 0,
                    "peoplenumber": "6464",
                    "mangerpeople": "6464",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "0",
                    "ismachine": "1",
                    "summoney": 0,
                    "ismanager": "1",
                    "meetingcity": "香港香港特别行政区",
                    "rooms": "64646",
                    "usetime": "2016-08-20 10:24~2016-08-22 12:24",
                    "buildtime": "2016-08-20 07:24",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "好的好的好好的恒大华府办法",
                    "ordermeetingtime": "2016-08-20 10:24~2016-08-22 12:24",
                    "ordermeetingname": "就到家觉得就到家都觉得回答",
                    "meetinginfo": null,
                    "fapiao": null,
                    "showossflag": null,
                    "time": "1471314419241",
                    "days": "4664",
                    "id": 115,
                    "type": "押证件",
                    "size": "964646"
                }, {
                    "userid": 212,
                    "payflag": "0",
                    "machinemoney": 0,
                    "mangermoney": 0,
                    "servicepercent": "0.2",
                    "servicemoney": 0,
                    "peoplenumber": null,
                    "mangerpeople": null,
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "0",
                    "ismachine": "0",
                    "summoney": 0,
                    "ismanager": "0",
                    "meetingcity": null,
                    "rooms": null,
                    "usetime": null,
                    "buildtime": null,
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": null,
                    "ordermeetingtime": "2016-08-16 09:00~2016-08-16 11:00",
                    "ordermeetingname": "816会议",
                    "meetinginfo": null,
                    "fapiao": null,
                    "showossflag": null,
                    "time": "1471311682772",
                    "days": null,
                    "id": 114,
                    "type": null,
                    "size": null
                }, {
                    "userid": 110,
                    "payflag": "1",
                    "machinemoney": 0,
                    "mangermoney": 2000,
                    "servicepercent": "0.2",
                    "servicemoney": 1360,
                    "peoplenumber": "2",
                    "mangerpeople": "2",
                    "permangermoney": 1000,
                    "backcontent": null,
                    "totalmeetingmoney": 0,
                    "deleteflag": "1",
                    "ismachine": "1",
                    "summoney": 8160,
                    "ismanager": "1",
                    "meetingcity": "北京市",
                    "rooms": "5",
                    "usetime": "2016-08-16 09:38~2016-08-18 11:38",
                    "buildtime": "2016-08-16 06:38",
                    "transnworklist": null,
                    "transnworkorder": null,
                    "meetingaddress": "格林豪泰",
                    "ordermeetingtime": "2016-08-16 09:38~2016-08-18 11:38",
                    "ordermeetingname": "Android会议报名列表",
                    "meetinginfo": null,
                    "fapiao": "{\"id\":449,\"customerId\":110,\"company\":\"47711\",\"identifier\":\"55558\",\"address\":\"445\",\"mobile\":\"85214785\",\"bank\":\"hi噗噗噗\",\"account\":\"45878\",\"isdefault\":1}",
                    "showossflag": null,
                    "time": "1471311587243",
                    "days": "2",
                    "id": 113,
                    "type": "押证件",
                    "size": "99"
                }],
                "limit": 10,
                "size": 0,
                "total": 69
            }
        },
        "status": 200
    }
    var json = obj;
    console.log(json.data.result.datas);
    var html = "";
    $.each(json.data.result.datas, function (i, item) {
        html += "<tr><td>" + item.id + "</td><td><a href='customer_con.html'>" + item.ordermeetingname + "</a></td><td>" + item.userid + "</td><td>" + item.meetingaddress + "</td><td>" + item.mangerpeople + "</td><td>" + item.meetingcity + "</td>";
        if (item.payflag == null) {
            html += "<td>" + 0 + "</td>";
        } else {
            html += "<td>" + item.payflag + "</td>";
        }
        html += "<td>" + item.ismachine + "</td><td>" + item.ismanager + "</td>";
        html += "<td>" + item.mangermoney + "</td></tr>";
    });
    //$("#meetingList").html(html);
    /*<tr>
     <th width="6%">序号</th>
     <th>会议名称</th>
     <th width="10%">订单编号</th>
     <th width="10%">企业名称</th>
     <th width="10%">行业标签</th>
     <th width="10%">城市</th>
     <th width="10%">订单状态</th>
     <th width="10%">同传设备</th>
     <th width="10%">现场管理</th>
     <th width="10%">金额</th>
     </tr>*/
</script>
</body>
</html>