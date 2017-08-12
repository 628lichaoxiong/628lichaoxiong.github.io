package com.transn.houtai.util;

/**
 * 系统常量参数值
 * @author james.li
 * @time  2017年3月8日 下午12:23:31
 */
public class Constants{
    /**
     * 原始简历存放路径
     */
    public static final String RESUME_FILE_PATH = "RESUME_FILE_PATH";
   
	/**
	 * 是否有效
	 * 1有效
	 */
	public static final Integer YES =1;
	/**
	 * 是否有效
	 * 0无效
	 */
	public static final Integer NO =0;

	/**
	    卡状态（1待领取2待绑定3待激活4已激活未消费5已启用6已禁用）
	*/
	public static class CardStatus{
		public static final Integer DLQ =1;
		public static final Integer DBD =2;
		public static final Integer DJH =3;
		public static final Integer YJH =4;
		public static final Integer YQY =5;
		public static final Integer YJY =6;
	}
	/**
	 * 系统参数 值
	 */
	public static class SystemConstantTypeValue{
		public static final String redis_address ="redis_address";
		public static final String redis_password ="redis_password";
		public static final String upload_img_url ="upload_img_url";
	}
	/**
	 * 权限操作功能 
	 */
	public static class FuncCode{
		public static final String SELECT ="SELECT";
		public static final String ADD ="ADD";
		public static final String DELETE ="DELETE";
		public static final String UPDATE ="UPDATE";
		public static final String EXPORT ="EXPORT";
		public static final String IMPORT ="IMPORT";
		public static final String UPLOAD ="UPLOAD";
		public static final String DOWNLOAD ="DOWNLOAD";
		public static final String DETAIL ="DETAIL";//详情
		public static final String VIEW ="VIEW";
		public static final String AUDIT="AUDIT";//审核
		public static final String CONFIRM="CONFIRM";//确认
		public static final String FINISH="FINISH";//完成
		public static final String REFUND="REFUND";//退款
		public static final String ONLINE="ONLINE";//上线
		public static final String OFFLINE="OFFLINE";//下线
		public static final String SEND="SEND";//发送
		public static final String DISABLE="DISABLE";//禁用启用
	}
	
	/**
	  订单状态0已提交1待确认2未付款3已完成5已发布
	  3预约成功6项目进行中7待评价（项目已完成）8已完成（已评价）
	 */
	public static String SysOrderPayflagType="nasha_03";
	public static class OrderPayflag{
		public static final String YJT="0";
		public static final String DQR="1";
		public static final String DFK="2";
		public static final String YWC="3";
		public static final String YFB="5";
		public static final String JXZ="6";
		public static final String DPJ="7";
		public static final String YPJ="8";
		public static final String YQX_OSS="88";//OSS查询使用
	}
}
