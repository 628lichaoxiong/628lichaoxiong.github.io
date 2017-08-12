package com.transn.houtai.table;

import java.util.Date;

/**
 * Created by xuxiaohe on 2016/10/24.
 */
public class transnworkcompanion {
    private int id;
    private int userid;
    //    项目详细地址
    private String meetingaddress = "";
    //    服务名称
    private String servicename = "";
    private String servcetimebegin = "";
    private String servcetimeend = "";
    private String meetingcity = "";
    //    会议联系人
    private String meetinguser = "";
    private String meetinguserphone = "";
    //    人数
    private String peoplenumber = "";
    private Object meetinginfo;
    //    订单状态 0已提交1待确认2未付款3已完成5已发布
    private String payflag = "";
    private String time;
    //    服务费用
    private int servicemoney;
    private String fapiao ;

    //    是否住宿
    private String isLiveandfeed = "";
    //    是否保险
    private String isInsurance = "";
    //    是否签证
    private String isSign = "";
    //    是否通勤车
    private String isTraffic = "";
    //工作餐
    private String isSafe = "";
    //    备注
    private String nodebook = "";
    //    预算平台
    private String budget = "";
    //项目服务类型
    private String serviceType = "";
    //    预估客户价格
    private String estimate = "";
    //    订单结算明细
    private String orderlist = "";
    //删除标签
    private String deleteflag="0";
    //译员用户列表
    private Object userResumelist="";
    //行业标签
    private String industryTag;
    //订单备注
    private String orderComment;
    //企业简称
    private String companyName;
    //订单语种
    private Object language;
    //总金额
    private Integer totalmoney=0;
    //是否显示
    private String isshow="0";
    //分类图片
    private String categoryimage;
    
    private String youjiaddress;
    //支付完成后的订单信息
    private Object orderInfo;
    //陪同类型
    private String categoryType;
    //翻译费用说明
    private String servicemoneyinfo;
    //译员单价
    private String unitCost;
    private int isscan;
    //译员要求
    private String askinfo;
    //  0 国外  1国内
    private Integer isDomestic;
    private String payMoney;//第三方支付金额

    private String cardMoney;//N卡支付金额

    private Integer payType;//1支付宝2N卡3 S卡4 N卡和支付宝

    private Integer cardLockStatus;//N卡支付锁定状态(0未锁定1锁定2已支付)
    private String cardNumber;//N卡卡号
    private String orderid;//预约订单编号
    private Date updateTime;//OSS或客户确认时间-计算倒计时
    private Date payTime;//支付时间
    private Long sysTime=System.currentTimeMillis();//系统时间-给前台倒计时
    private String redpackMoney="0";//红包支付金额
    private Integer redpackId;//红包编号
    private Integer orderType;//订单类型1发布2预约
    private Integer businessType;//订单业务类型1译员陪同
    private String bakFirst;//1需要继续推荐译员
    
    public Integer getBusinessType() {
		return businessType;
	}
	public void setBusinessType(Integer businessType) {
		this.businessType = businessType;
	}
	public String getBakFirst() {
		return bakFirst;
	}
	public void setBakFirst(String bakFirst) {
		this.bakFirst = bakFirst;
	}
	public void setOrderType(Integer orderType) {
		this.orderType = orderType;
	}
    public Integer getOrderType() {
		return orderType;
	}
    public String getRedpackMoney() {
		return redpackMoney;
	}
	public void setRedpackMoney(String redpackMoney) {
		this.redpackMoney = redpackMoney;
	}
	public Integer getRedpackId() {
		return redpackId;
	}
	public void setRedpackId(Integer redpackId) {
		this.redpackId = redpackId;
	}
	public void setSysTime(Long sysTime) {
		this.sysTime = sysTime;
	}
    public Long getSysTime() {
		return sysTime;
	}
    public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}
    public Date getPayTime() {
		return payTime;
	}
    public Date getUpdateTime() {
		return updateTime;
	}
    public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
    public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
    public String getOrderid() {
		return orderid;
	}
    public String getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(String payMoney) {
		this.payMoney = payMoney;
	}

	public String getCardMoney() {
		return cardMoney;
	}

	public void setCardMoney(String cardMoney) {
		this.cardMoney = cardMoney;
	}

	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
	}

	public Integer getCardLockStatus() {
		return cardLockStatus;
	}

	public void setCardLockStatus(Integer cardLockStatus) {
		this.cardLockStatus = cardLockStatus;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getMeetingaddress() {
        return meetingaddress;
    }

    public void setMeetingaddress(String meetingaddress) {
        this.meetingaddress = meetingaddress;
    }

    public String getServicename() {
        return servicename;
    }

    public void setServicename(String servicename) {
        this.servicename = servicename;
    }

    public String getServcetimebegin() {
        return servcetimebegin;
    }

    public void setServcetimebegin(String servcetimebegin) {
        this.servcetimebegin = servcetimebegin;
    }

    public String getServcetimeend() {
        return servcetimeend;
    }

    public void setServcetimeend(String servcetimeend) {
        this.servcetimeend = servcetimeend;
    }

    public String getMeetingcity() {
        return meetingcity;
    }

    public void setMeetingcity(String meetingcity) {
        this.meetingcity = meetingcity;
    }

    public String getMeetinguser() {
        return meetinguser;
    }

    public void setMeetinguser(String meetinguser) {
        this.meetinguser = meetinguser;
    }

    public String getMeetinguserphone() {
        return meetinguserphone;
    }

    public void setMeetinguserphone(String meetinguserphone) {
        this.meetinguserphone = meetinguserphone;
    }

    public String getPeoplenumber() {
        return peoplenumber;
    }

    public void setPeoplenumber(String peoplenumber) {
        this.peoplenumber = peoplenumber;
    }

    public Object getMeetinginfo() {
        return meetinginfo;
    }

    public void setMeetinginfo(Object meetinginfo) {
        this.meetinginfo = meetinginfo;
    }

    public String getPayflag() {
        return payflag;
    }

    public void setPayflag(String payflag) {
        this.payflag = payflag;
    }

    public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getServicemoney() {
        return servicemoney;
    }

    public void setServicemoney(int servicemoney) {
        this.servicemoney = servicemoney;
    }

    public String getFapiao() {
        return fapiao;
    }

    public void setFapiao(String fapiao) {
        this.fapiao = fapiao;
    }

    public String getIsLiveandfeed() {
        return isLiveandfeed;
    }

    public void setIsLiveandfeed(String isLiveandfeed) {
        this.isLiveandfeed = isLiveandfeed;
    }

    public String getIsInsurance() {
        return isInsurance;
    }

    public void setIsInsurance(String isInsurance) {
        this.isInsurance = isInsurance;
    }

    public String getIsSign() {
        return isSign;
    }

    public void setIsSign(String isSign) {
        this.isSign = isSign;
    }

    public String getIsTraffic() {
        return isTraffic;
    }

    public void setIsTraffic(String isTraffic) {
        this.isTraffic = isTraffic;
    }

    public String getIsSafe() {
        return isSafe;
    }

    public void setIsSafe(String isSafe) {
        this.isSafe = isSafe;
    }

    public String getNodebook() {
        return nodebook;
    }

    public void setNodebook(String nodebook) {
        this.nodebook = nodebook;
    }

    public String getBudget() {
        return budget;
    }

    public void setBudget(String budget) {
        this.budget = budget;
    }

    public String getServiceType() {
        return serviceType;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public String getEstimate() {
        return estimate;
    }

    public void setEstimate(String estimate) {
        this.estimate = estimate;
    }

    public String getOrderlist() {
        return orderlist;
    }

    public void setOrderlist(String orderlist) {
        this.orderlist = orderlist;
    }

    public String getDeleteflag() {
        return deleteflag;
    }

    public void setDeleteflag(String deleteflag) {
        this.deleteflag = deleteflag;
    }

	public String getIndustryTag() {
		return industryTag;
	}

	public void setIndustryTag(String industryTag) {
		this.industryTag = industryTag;
	}

	public String getOrderComment() {
		return orderComment;
	}

	public void setOrderComment(String orderComment) {
		this.orderComment = orderComment;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
    

    public Object getUserResumelist() {

        return userResumelist;
    }

    public void setUserResumelist(Object userResumelist) {
        this.userResumelist = userResumelist;
    }

	public String getYoujiaddress() {
		return youjiaddress;
	}

	public void setYoujiaddress(String youjiaddress) {
		this.youjiaddress = youjiaddress;
	}

    public Integer getTotalmoney() {
        return totalmoney;
    }

    public void setTotalmoney(Integer totalmoney) {
        this.totalmoney = totalmoney;
    }

    public Object getLanguage() {
        return language;
    }

    public void setLanguage(Object language) {
        this.language = language;
    }

    public String getIsshow() {
        return isshow;
    }

    public void setIsshow(String isshow) {
        this.isshow = isshow;
    }

    public String getCategoryimage() {
        return categoryimage;
    }

    public void setCategoryimage(String categoryimage) {
        this.categoryimage = categoryimage;
    }

    public Object getOrderInfo() {
        return orderInfo;
    }

    public void setOrderInfo(Object orderInfo) {
        this.orderInfo = orderInfo;
    }

    public String getCategoryType() {
        return categoryType;
    }

    public void setCategoryType(String categoryType) {
        this.categoryType = categoryType;
    }

    public String getServicemoneyinfo() {
        return servicemoneyinfo;
    }

    public void setServicemoneyinfo(String servicemoneyinfo) {
        this.servicemoneyinfo = servicemoneyinfo;
    }

	public int getIsscan() {
		return isscan;
	}

	public void setIsscan(int isscan) {
		this.isscan = isscan;
	}

	public String getUnitCost() {
		return unitCost;
	}

	public void setUnitCost(String unitCost) {
		this.unitCost = unitCost;
	}

    public String getAskinfo() {
        return askinfo;
    }

    public void setAskinfo(String askinfo) {
        this.askinfo = askinfo;
    }

	public Integer getIsDomestic() {
		return isDomestic;
	}

	public void setIsDomestic(Integer isDomestic) {
		this.isDomestic = isDomestic;
	}
    
}
