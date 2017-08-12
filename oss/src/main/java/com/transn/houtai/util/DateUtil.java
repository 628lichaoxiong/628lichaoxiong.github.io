package com.transn.houtai.util;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class DateUtil {
	public static long  toLongtime(String time) throws ParseException{
		SimpleDateFormat dateformat = new SimpleDateFormat(
				"yyyy-MM-dd");
		Date date=dateformat.parse(time);
		return date.getTime();
	}
	public static long  toLongtimeHM(String time) throws ParseException{
		SimpleDateFormat dateformat = new SimpleDateFormat(
				"yyyy-MM-dd hh:mm");
		Date date=dateformat.parse(time);
		return date.getTime();
	}
	/**
	 * 
	 * @Title: 格式化日期格式  
	 * @Description: TODO  
	 * @param time
	 * @return
	 * @return String
	 */
	public static String convertFormat(String time){
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM");
		Date date = null;
		try {
			if(time.indexOf(".")<0){
				if(StringUtils.isNumeric(time)){
						date=dateformat.parse(time+".01");
				}else{
					return time;
				}
			}else{
				date=dateformat.parse(time);
			}
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dateformat.format(date);
	}
	/**
	 * 
	 * @Title: differentDaysByMillisecond  
	 * @Description: 计算时间差 
	 * @param
	 * @param
	 * @return
	 * @return int
	 */
	public static int differentDaysByMillisecond(String beginTime,String endTime,String format){
		SimpleDateFormat dateformat =new SimpleDateFormat(format);
		int days=0;
		try {
			Date date1 = dateformat.parse(beginTime);
			Date date2=dateformat.parse(endTime);
			days = (int) ((date2.getTime() - date1.getTime()) / (1000*3600*24));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	   return days+1;
	}
	/**
	   * 两日期的间隔天数
	   * @param strDate1 需要进行计较的日期1(yyyy-MM-dd)
	   * @param strDate2 需要进行计较的日期2(yyyy-MM-dd)
	   * @return 间隔秒数（int）
	   * @throws ParseException 
	   */
	  public static long diffSecond( String strDateBegin, String strDateEnd ) throws ParseException
	  {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date dateBegin = sdf.parse( strDateBegin );
	    Date dateEnd = sdf.parse( strDateEnd );

	    long  milliSencods = dateEnd.getTime() - dateBegin.getTime();
	    long intDiff = milliSencods / (1000*24*60*60);
	    return intDiff;
	  }
	
	/**
	 * @Title: calculateDay  
	 * @Description: 计算天数的系数 
	 * @param beginTime
	 * @param endTime
	 * @param format
	 * @return
	 * @throws ParseException
	 * @return double
	 */
	public static String calculateDay(String beginTime,String endTime, String format) throws ParseException{
		String dayP="0";
		//得到相差天数
		long days =diffSecond(beginTime, endTime);
		//小时
		int beginHour =Integer.valueOf(beginTime.substring(11,13));
		int endHour =Integer.valueOf(endTime.substring(11,13));
		//如果小于等于1天，时间差值≤4  则 0.6 如果 4＜差值≤9  则 1 如果差值＞9    则   1.6
		if(days==0){//2017-07-21 至 2017-07-21 实际1天
			int firstLessValue=Math.abs(beginHour-endHour);
			if(firstLessValue <=4){
				dayP="0.6";
			}else if(firstLessValue>4 && firstLessValue<=9){
				dayP="1";
			}else{
				dayP="1.6";
			}
		}else {
			//2017-07-21 至 2017-07-22 实际2天。但是days返回1
			//A ==18减去开始时间的小时。时间差值≤4  则 0.6 如果 4＜差值≤9  则 1 如果差值＞9    则   1.6
			float firstA =0;
			int firstLessValue=Math.abs(18-beginHour);
			if(firstLessValue <=4){
				firstA=0.6f;
			}else if(firstLessValue>4 && firstLessValue<=9){
				firstA=1;
			}else{
				firstA=1.6f;
			}
			//B 结束时间减去9小时。时间差值≤4  则 0.6 如果 4＜差值≤9  则 1 如果差值＞9    则   1.6
			float firstB =0;
			int firstLessValueB=Math.abs(endHour-9);
			if(firstLessValueB <=4){
				firstB=0.6f;
			}else if(firstLessValueB>4 && firstLessValueB<=9){
				firstB=1;
			}else{
				firstB=1.6f;
			}
			dayP=firstA+firstB+(days-1)+"";
		}
		return dayP;
	}

	/**
	 *
	 * @Title: getAge
	 * @Description: 通过出生日期计算时间
	 * @param brithTime
	 * @return
	 * @return String
	 */
	public static String getAge(String brithTime){
		Integer age=0;
		try {
			SimpleDateFormat format =new SimpleDateFormat("yyyy-MM-dd");
			Calendar born = Calendar.getInstance();
			Calendar now = Calendar.getInstance();
			if(brithTime !=null){
				born.setTime(format.parse(brithTime));
				now.setTime(new Date());
				if(born.after(now)){
					throw new IllegalArgumentException("Can't be born in the future");
				}
				age=now.get(Calendar.YEAR) - born.get(Calendar.YEAR);
				if(now.get(Calendar.DAY_OF_YEAR) < born.get(Calendar.DAY_OF_YEAR)){
					age-=1;
				}
			}

		} catch (ParseException e) {
			e.printStackTrace();
		}
		return age.toString();

	}
	//1000*4+1000*1.6*2
	public static void main(String[] args) throws ParseException {
		System.out.println(calculateDay("2017-03-05 14:00", "2017-03-10 18:00", "yyyy-MM-dd HH:mm"));
	}
}
