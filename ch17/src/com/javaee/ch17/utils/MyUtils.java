package com.javaee.ch17.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class MyUtils {
	public static final String dateFormat="yyyy-MM-dd";
	public static final String longDateTimeFormat="yyyy-MM-dd HH:mm:ss"; 
	public static final String longDateTimeWithMillisFormat="yyyy-MM-dd HH:mm:ss.SSS";// yyyy-MM-dd HH:mm:ss.SSS 精确到毫秒
	
	public static String getDateFormat(int theType) {
		String temp=longDateTimeWithMillisFormat;
		switch (theType) {
		case 0:
			temp=dateFormat;
			break;		
		case 1:
			temp=longDateTimeFormat;
			break;	
		default:
			temp=longDateTimeWithMillisFormat;
		}	
		return temp;
	}
	public static String getDateTimeString(Date theDate, int theType) {
		if(theDate==null) {
			return "无";
		}
		SimpleDateFormat sdf = new SimpleDateFormat(getDateFormat(theType));
		return sdf.format(theDate);
	}	
	public static String getDateTimeString(int theType) {		
		Date theDate = new Date();
		return getDateTimeString(theDate, theType);
	}	
	public static String getDateTimeString(Date theDate) {
		SimpleDateFormat sdf = new SimpleDateFormat(getDateFormat(2));
		return sdf.format(theDate);
	}
	public static String getDateTimeString() {		
		Date theDate = new Date();
		return getDateTimeString(theDate);
	}	
	
	/**
	 * 获取ip地址
	 * 参考：https://bbs.csdn.net/topics/392376661
	 * @param request
	 * @return
	 */
	public static String getIPAddress(HttpServletRequest request) {
		// 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_CLIENT_IP");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
		} else if (ip.length() > 15) {
			String[] ips = ip.split(",");
			for (int index = 0; index < ips.length; index++) {
				String strIp = (String) ips[index];
				if (!("unknown".equalsIgnoreCase(strIp))) {
					ip = strIp;
					break;
				}
			}
		}
		return ip;
	}
	
	public static void main(String[] args) {
		System.out.println(getDateTimeString());
		System.out.println(getDateTimeString(1));
		long currentTimeMillseconds = System.currentTimeMillis();// 当前时间距离1970年1月1日0点0分0秒所经历的毫秒数
		long nanosecondsStart = System.nanoTime();// 纳秒 二个这样的长整数之差 视为执行时间(纳秒)。 起点
		Date dt= new Date();
		long time= dt.getTime();//距离1970年1月1日0点0分0秒的毫秒数
		System.out.println(System.currentTimeMillis()+" "+ time);//二者相同
		long nanosecondsEnd = System.nanoTime();  // 终点
		System.out.println("执行时间是：" + (nanosecondsEnd-nanosecondsStart) + " ns");// 秒 毫秒 微妙 纳秒  都是1000倍的关系。
		//System.out.println("IP地址："+ getIpAddress(request)); 后台没办法实现。

	}
	public static void pause(long millis) {
		try {
			Thread.sleep(millis);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
}
/*
显示客户端主机IP地址：https://blog.csdn.net/yin_jw/article/details/24470131
在Servlet里，获取客户端的IP地址的方法是：request.getRemoteAddr()，这种方法在大部分情况下都是有效的。
但是在通过Apache，Squid，Nginx等反向代理软件后就不能获取到客户端的真实IP地址了。
 * */
