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
    <title>运营支撑系统OSS-会议详情</title>
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
    <div class="square clearfix">
        <span><img src="${sourcePath}/resources/images/square_green.png"></span>
        <span>基本信息</span>
    </div>
    <div class="article_information">
        <div class="article">
            <ul>
                <li>
                    <span>会议名称：</span>
                    <span>${workorderinfo.data.result.ordermeetingname}</span>
                </li>
                <li>
                    <span>金额：</span>
                    <span>${workorderinfo.data.result.summoney}</span>
                </li>
                <li>
                    <span>订单编号：</span>
                    <span>${workorderinfo.data.result.id}</span>
                </li>
                <li>
                    <span>发票状态：</span>
                    <span><c:if
                            test="${workorderinfo.data.result.backcontent!=null&&workorderinfo.data.result.backcontent!=''}">
                        <span>有</span>
                    </c:if></span>
                </li>
                <li>
                    <span>创建时间：</span>
                    <span><Date:date
                            value="${workorderinfo.data.result.time}"></Date:date></span>
                </li>
                <li>
                    <span>会议时间：</span>
                    <span>${workorderinfo.data.result.ordermeetingtime}</span>
                </li>
                <li>
                    <span>企业名称：</span>
                    <span>${workorderinfo.data.result.company.companyname}</span>
                </li>
                <li>
                    <span>语言方向：</span>
                    <span>
                     <c:forEach items="${workorderinfo.data.result.transnworklist}"
                                varStatus="key" var="Recourse">
                    ${Recourse.language}
                     </c:forEach>
                    </span>

                </li>
                <li>
                    <span>行业标签：</span>
                    <span>${workorderinfo.data.result.meetinginfo.category}</span>
                </li>
                <li>
                    <span>报名状态：</span>

                    <span><c:if test="${workorderinfo.data.result.payflag== '0'}">已发布</c:if>
							  <c:if test="${workorderinfo.data.result.payflag== '1'}">已确认</c:if>
							  <c:if test="${workorderinfo.data.result.payflag== '2'}">已付款</c:if>
							  <c:if test="${workorderinfo.data.result.payflag== '3'}">已评价</c:if>
                        .
						</span>
                </li>
                <li>
                    <span>城市：</span>
                    <span>${workorderinfo.data.result.meetingcity}</span>
                </li>
                <li>
                    <span>服务费率：</span>
                    <span>
                        ${fn:split(workorderinfo.data.result.servicepercent*100,".")[0]}%

                    </span>
                </li>
                <li>
                    <span>订单状态：</span>

                    <span><c:if test="${workorderinfo.data.result.payflag== '0'}">已发布</c:if>
								  <c:if test="${workorderinfo.data.result.payflag== '1'}">已确认</c:if>
								  <c:if test="${workorderinfo.data.result.payflag== '2'}">已付款</c:if>
								  <c:if test="${workorderinfo.data.result.payflag== '3'}">已评价</c:if>
                        .
							</span>


                </li>
                <%--<li>--%>
                <%--<span>联系人：</span>--%>
                <%--<span>${workorderinfo.data.result.company.username}</span>--%>
                <%--</li>--%>
                <li>
                    <span>同传设备：</span>

                    <span><c:if test="${workorderinfo.data.result.ismachine== '0'}">无</c:if>
							<c:if test="${workorderinfo.data.result.ismachine== '1'}">有</c:if>
							</span>

                </li>
                <li>
                <span>联系人手机号：</span>
                <span>${workorderinfo.data.result.meetinginfo.userphonenumber}</span>
                </li>
                <li>
                    <span>现场管理：</span>

                    <span><c:if test="${workorderinfo.data.result.ismanager== '0'}">无</c:if>
						<c:if test="${workorderinfo.data.result.ismanager== '1'}">有</c:if></span>
                </li>
            </ul>
        </div>
    </div>
    <div class="square clearfix">
        <span><img src="${sourcePath}/resources/images/square_green.png"></span>
        <span>语言方向</span>
    </div>
    <c:forEach items="${workorderinfo.data.result.transnworklist}"
               varStatus="key" var="Recourse">
        <div class="table-list">
            <table width="100%" cellspacing="0" id="mytable">
                <thead>
                <tr>
                    <th width="6%">语言方向</th>
                    <th width="6%">会议类型</th>
                    <th width="15%">会议时间</th>
                    <th width="10%">会议周期</th>
                    <th width="6%">需要人数</th>
                    <th width="6%">报名人数</th>
                    <th width="6%">已选人数</th>
                    <%--<th width="6%">手机号</th>--%>
                    <%--<th width="6%">金额</th>--%>

                    <!--<th width="10%">操作</th>-->
                </tr>
                </thead>

                <tbody id="meetingList">

                <tr>
                    <td align="center">${Recourse.language}</td>
                    <td align="center">${Recourse.type}</td>
                    <td align="center">${Recourse.meetingtime}</td>
                    <td align="center">${Recourse.longtime}</td>
                    <td align="center">${Recourse.peoplenumber}</td>
                    <td align="center">${Recourse.baomingnumber}</td>
                    <td align="center">${Recourse.selectbaomingnumber}</td>
                    <%--<td align="center"></td>--%>
                    <%--<td align="center"></td>--%>
                    <!--<td align="center">
                        <input type="button" class="op_btn btn add_user" value="添加译员">
                    </td>-->
                </tr>

                </tbody>
            </table>
        </div>
        </br>
        <form name="form${key.count}" method="post" class="add_form"
              action="${sourcePath}/workorder/submituserin?transnworkid=${Recourse.id}&workorderid=${workorderinfo.data.result.id}">
            手机号:<input type="text" class="search_key mobile" id="mobile" name="phonenumber" value="">
            金额:<input type="text" class="search_key money" id="money" name="money" value="">
            <input type="submit" class="sub_btn op_btn btn" value="添加译员" />
        </form>

        <c:if test="${Recourse.baominguserlist!='null'}">
            <div class="table-list table-list_mr">
                <table width="100%" cellspacing="0" id="mytable">
                    <thead>
                    <tr>
                        <th width="5%">序号</th>
                        <th width="5%">姓名</th>
                        <th width="5%">性别</th>
                        <th width="5%">手机号</th>
                        <th width="5%">年龄</th>
                        <th width="5%">城市</th>
                        <th width="5%">报价</th>
                        <th width="5%">审核状态</th>
                    </tr>
                    </thead>
                    <tbody id="meetingList">

                    <c:forEach items="${Recourse.baominguserlist}"
                               varStatus="key" var="Recourse2">
                        <tr>
                            <td align="center">${key.count}</td>
                            <td align="center">${Recourse2.user.username}</td>
                            <td align="center">${Recourse2.user.sex}</td>
                            <td align="center">${Recourse2.user.userphonenumber}</td>
                            <td align="center">${Recourse2.user.age}</td>
                            <td align="center">${Recourse2.user.country}</td>
                            <td align="center">${Recourse2.money}</td>
                            <c:if test="${Recourse2.berforeflag== '0'}">
                                <td align="center">未审核</td>
                            </c:if>
                            <c:if test="${Recourse2.berforeflag== '1'}">
                                <td align="center">审核通过</td>
                            </c:if>
                        </tr>


                    </c:forEach>


                    </tbody>
                </table>

            </div>


        </c:if>
        </br>
    </c:forEach>

    <c:if test="${workorderinfo.data.result.ismachine== '1'}">
        <div class="square clearfix">
            <span><img src="${sourcePath}/resources/images/square_green.png"></span>
            <span>同传设备报价&nbsp;&nbsp;<a href="javascript:;">申请中</a></span>
        </div>
        <p class="sb_xq">设备需求</p>
        <div class="article">
            <ul>
                <li>
                    <span>会议所在地：</span>
                    <span>${workorderinfo.data.result.meetingcity}</span>
                </li>
                <li>
                    <span>使用时间：</span>
                    <span>${workorderinfo.data.result.usetime}</span>
                </li>
                <li>
                    <span>场地地址：</span>
                    <span>${workorderinfo.data.result.meetingaddress}</span>
                </li>
                <li>
                    <span>搭建时间：</span>
                    <span>${workorderinfo.data.result.buildtime}</span>
                </li>
                <li>
                    <span>场地大小：</span>
                    <span>${workorderinfo.data.result.size}㎡</span>
                </li>
                <li>
                    <span>接收机发放方式：</span>
                    <span>${workorderinfo.data.result.type}</span>
                </li>
                <li>
                    <span>参会人数：</span>
                    <span>${workorderinfo.data.result.peoplenumber}</span>
                </li>
                <li>
                    <span>现场联系人：</span>
                    <span></span>
                </li>
                <li>
                    <span>翻译间：</span>
                    <span>${workorderinfo.data.result.rooms}</span>
                </li>
                <li>
                    <span>手机号：</span>
                    <span></span>
                </li>
            </ul>
        </div>
        <p class="sb_xq">设备报价</p>
        <form action="${sourcePath}workorder/submitmachineinfo?workorderid=${workorderinfo.data.result.id}"
              method="post" id="myform_tr">
            <div class="table-list">
                <table width="100%" cellspacing="0" id="mytable">
                    <thead>
                    <tr>
                        <th width="10%">设备</th>
                        <th width="6%">单价（元）</th>
                        <th width="6%">单位</th>
                        <th width="6%">数量</th>
                        <th width="6%">使用天数</th>
                        <th width="6%">小计（元）</th>
                        <th width="12%">注意事项</th>
                        <th width="6%">操作</th>
                    </tr>
                    </thead>


                    <tbody id="meetingList">
                    <c:forEach items="${ll}"
                               varStatus="key" var="Recourse">

                        <tr>
                            <td align="center">
                                <input type="text" name="name" class="op_btn order_input" value="${Recourse.name}">
                            </td>
                            <td align="center">
                                <input type="number" name="price" class="op_btn order_input price"
                                       value="${Recourse.price}" size="10">
                            </td>
                            <td align="center">
                                <input type="text" name="per" class="op_btn order_input" value="${Recourse.per}"
                                       size="6">
                            </td>
                            <td align="center">
                                <input type="number" name="number" class="op_btn order_input num"
                                       value="${Recourse.number}" size="10">
                            </td>
                            <td align="center">
                                <input type="number" name="days" class="op_btn order_input day" value="${Recourse.days}"
                                       size="10">
                            </td>
                            <td align="center">
                                <input type="text" name="summoney" class="op_btn order_input sum_xj"
                                       value="${Recourse.summoney}" size="10">
                            </td>
                            <td align="center">
                                <input type="text" name="note" class="op_btn order_input" value="${Recourse.note}">
                            </td>
                            <td align="center">
                                <input type="button" class="op_btn order_input last_order_input" value="删除" size="10"
                                       onclick="removeClear(this);">
                            </td>
                        </tr>

                    </c:forEach>
                    <tr class="last_tr">
                        <td colspan="8"><img src="${sourcePath}/resources/images/icon_add@2x.png"/>新增一行</td>
                    </tr>

                    </tbody>


                </table>
            </div>
            <div class="sb_price clearfix">

                <input type="hidden" value="" name="machinemoney">
                <p><span>费用总计:</span>¥<span>${totalmachinemoney}</span></p>
                <input type="submit" value="提交报价" name="sub_sb_price" class="sub_sb_price" id="sub_sb_price"/>

            </div>
        </form>
    </c:if>

    <div class="square clearfix">
        <span><img src="${sourcePath}/resources/images/square_green.png"></span>
        <span>发票信息</span>
    </div>
    <div class="table-list">
        <table width="100%" cellspacing="0" id="mytable">
            <thead>
            <tr>
                <th width="12%">公司名称</th>
                <th width="6%">纳税人识别号</th>
                <th width="12%">地址（非邮寄）</th>
                <th width="6%">联系电话</th>
                <th width="8%">开户行</th>
                <th width="8%">开户行帐号</th>
                <th width="6%">发票状态</th>
            </tr>
            </thead>
            <tbody id="meetingList">
            <tr>
              <c:if test="${fapiao!= ''}">
                  <td align="center">${fapiao.company}</td>
                <td align="center">${fapiao.identifier}</td>
                <td align="center">${fapiao.address}</td>
                <td align="center">${fapiao.mobile}</td>
                <td align="center">${fapiao.bank}</td>
                <td align="center">${fapiao.account}</td>
                <td align="center">
                 <c:if test="${fapiao.isdefault== '0'}">
                               未邮寄 
                            </c:if>
                            
                             <c:if test="${fapiao.isdefault== '1'}">
                               已邮寄 
                            </c:if>
                
               </td>
              </c:if>
              
            </tr>
            </tbody>
        </table>
    </div>
    </br>
    <%-- <div class="yj clearfix">
        <form action="" method="post" name="my_yj" class="my_yj">
            <p><span>邮寄地址:</span><span>${fapiao.address}</span></p>
            <p><span>收件人:</span><span>${address.data.result.name}</span></p>
            <p><span>联系方式:</span><span>${address.data.result.mobile}</span></p>
            <input type="button" value="确认邮寄" name="sub_yj" class="sub_yj" id="sub_yj"/>
        </form>
    </div> --%>


    <div class="square clearfix">
        <span><img src="${sourcePath}/resources/images/square_green.png"></span>
        <span>订单结算详情</span>
    </div>
    <div class="yy_t clearfix">
        <p>参会译员</p>
        <p>
            <span>小计：</span>¥
            <span>${workorderinfo.data.result.totalmeetingmoney}</span>
        </p>
    </div>
    <div class="yy_con clearfix">
        <ul>
            <c:forEach items="${workorderinfo.data.result.transnworklist}"
                       varStatus="key" var="Recourse">
                <li class="clearfix">
                    <span>${Recourse.language}</span>
                    <span>${Recourse.peoplenumber}人</span>
                    <span>¥${Recourse.totalmoney}</span>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="yy_t clearfix">
        <p>同传设备</p>
        <p>
            <span>小计：</span>¥
            <span>${workorderinfo.data.result.machinemoney}</span>
        </p>
    </div>

    <div class="yy_con clearfix">
        <ul>
            <c:forEach items="${ll}"
                       varStatus="key" var="Recourse">
                <li class="clearfix">
                    <span>${Recourse.name}</span>
                    <span>¥${Recourse.price}/${Recourse.per}</span>
                    <span>¥${Recourse.summoney}</span>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="yy_t clearfix">
        <p>现场管理</p>
        <p>
            <span>小计：</span>¥
            <span>${workorderinfo.data.result.mangermoney}</span>
        </p>
    </div>
    <div class="yy_con clearfix">
        <ul>
            <li class="clearfix">
                <span>${workorderinfo.data.result.mangerpeople}人×${workorderinfo.data.result.days}天</span>
                <span></span>
                <span>¥${workorderinfo.data.result.mangermoney}</span>
            </li>
        </ul>
    </div>
    <div class="yy_t clearfix">
        <p>服务费</p>
        <p>
            <span>小计：</span>¥
            <span>${workorderinfo.data.result.servicemoney}</span>
        </p>
    </div>
    <div class="yy_con clearfix">
        <ul>
            <li class="clearfix">
                <span>${workorderinfo.data.result.servicepercent*100}%</span>
                <span></span>
                <span>¥${workorderinfo.data.result.servicemoney}</span>
            </li>
        </ul>
    </div>
    <div class="sum">
        <p>
            <span>合计：</span>
            <span>¥ ${workorderinfo.data.result.summoney}</span>
            <c:if test="${workorderinfo.data.result.payflag== '0'||workorderinfo.data.result.payflag== '1'}">
        <form action="${sourcePath}workorder/comfirmorder" method="post">
            <input type="hidden" name="workorderid" value="${workorderinfo.data.result.id}"/>
            <input type="submit" value="确认订单" id="sum_sub" class="sum_sub" name="sum_sub"/>
        </form>

        </c:if>
        </p>
    </div>
</div>
<script type="text/javascript">

$(function(){
	/* var str = '<span>客户详情</span>';
	$('#current_pos', parent.document).html(str);
	return true; */
	setMenu();
});
function setMenu() {//或者自己设定导航逻辑
	var str = '<a href="javascript:;" onclick="url_jump(\'${rc.contextPath}/workorder/getworkorderlist\')">订单列表</a><b>&gt;</b><span>订单详情</span>';
	$('#current_pos', parent.document).html(str);
	return true;
}


    //显示译员弹窗
    $(".add_user").click(function () {
        $(".add_user_con").show();
    })
    //关闭译员弹窗
    $(".close").click(function () {
        $(this).parents(".add_user_con").hide();
    })
    //显示译员弹窗之后搜索显示的表格
    $(".add_user_find").click(function () {
        $(".add_user_tb").show();
    })

    //确认邮寄弹窗，只能确认一次
    var count = 0;
    $(".sub_yj").click(function () {
        count++;
        $(this).attr("count", count);
        console.log(count);
        if (count == 1) {
            count = 1;
            if (confirm("您确认发票信息吗？")) {
                $(this).addClass("sub_yj_hui").removeClass("sub_yj");
            } else {
                count = 0;
                $(this).addClass("sub_yj").removeClass("sub_yj_hui");
            }
        } else {
            return;
        }
    })

    //增加表行
    var result = 0;
    var len = $(".sum_xj").length;
    console.log(len);
    var num = 0;
    //同传设备价格小计
    function sumAnd() {
        $("#meetingList tr").each(function () {
            if ($(this).find(".price").val() == "underfind") {
                $(this).find(".price").val() = 0;
            }
            if ($(this).find(".num").val() == "underfind") {
                $(this).find(".num").val() = 0;
            }

            return $(this).find(".sum_xj").val($(this).find(".price").val() * $(this).find(".num").val() * $(this).find(".day").val());
        })
    }


    $(".last_tr").click(function () {
        num++;
        $(this).attr("num", num);
        var tr = '<tr>';
        tr += '<td align="center"><input type="text" name="name" class="op_btn order_input" value=""></td>';
        tr += '<td align="center"><input type="number" name="price" class="op_btn order_input price" value="" placeholder="" size="10"></td>';
        tr += '<td align="center"><input type="text" name="per" class="op_btn order_input" value="" size="6"></td>';
        tr += '<td align="center"><input type="number" name="number" class="op_btn order_input num" value="" size="10"></td>';
        tr += '<td align="center"><input type="number" name="days" class="op_btn order_input day" value="1" size="10"></td>';
        tr += '<td align="center"><input type="text" name="summoney" class="op_btn order_input sum_xj" value="0" size="10"></td>';
        tr += '<td align="center"><input type="text" name="note" class="op_btn order_input" value=""></td>';
        tr += '<td align="center"><input type="button" class="op_btn order_input last_order_input" value="删除" size="10" onclick="removeClear(this);"></td>';
        tr += '</tr>';
        $(this).before(tr);
        len = $(".sum_xj").length;
        console.log(len);
        //设备合计
        $(".order_input").keyup(function () {
            sumAnd();
        })

    })
    //删除方法
    function removeClear(e) {
        if (confirm('确定要删除吗？')) {//确认删除
            $(e).parents('tr').remove();
        }
    }
    //设备合计
    $(".order_input").keyup(function () {
        sumAnd();
    })
    //设备总价
    sumAnd();

    $(".sub_sb_price").one('click', function () {
        $(this).css({"color": "#fff", "background": "#666"});
        for (var p = 0; p < len; p++) {
            result += parseInt($(".sum_xj").eq(p).val());
        }
        $("#sum_price").html(result);
    });


    //以下函数请根据数据接口完善
    function setAddUser(dom) {
        if (confirm('确定要添加这个译员吗？')) {//确认
            $(window.parent.document).find("#add_user_tb").css("border", "1px solid #FF0000");
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
    //暂时验证
    function chkk() {
      if (empty('.mobile')) {
            alert('手机不能为空');
            return false;
        }
        var mphone = $('.mobile').val();
        var mppre  = /^1[3|4|5|7|8]\d{9}$/ ;
        if(!mppre.test(mphone))
        {
            alert("手机格式不正确");
            return false;
        }
        if (empty('.money')) {
            alert('金额不能为空');
            return false;
        }
        var money = $('.money').val();
        var moneypre  = /^[0-9]{,6}$/ ;
        if(!moneypre.test(money))
        {
            alert("价格不可以超出6位数");
            return false;
        }


    }

</script>
</body>
</html>