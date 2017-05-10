package com.product.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * copyright    : Sysware Technology Co., Ltd
 *
 * @author : yangn
 * @version : 1.0
 * @created : 13-11-28上午11:09
 * @team     :
 */
public class UiframeConvertDate {
    /**
     * 日期转换成字符串
     * @param date
     * @return str
     */
    public static String DateToStr(Date date) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-M-d");
        String str = format.format(date);
        return str;
    }

    /**
     * 字符串转换成日期
     * @param str
     * @return date
     */
    public static Date StrToDate(String str) {

    	if(str==null||"".equals(str)){
    		return null;
    	}
        SimpleDateFormat format = new SimpleDateFormat("yyyy-M-d");
        Date date = null;
        try {
            date = format.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 时间转换成字符串
     * @param date
     * @return str
     */
    public static String TimeToStr(Date date) {

        SimpleDateFormat format = new SimpleDateFormat("HH:mm");
        String str = format.format(date);
        return str;
    }

    /**
     * 字符串转换成时间
     * @param str
     * @return date
     */
    public static Date StrToTime(String str) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Date date = null;
        try {
            date = format.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 日期转换成字符串(空位补0)
     * @param date
     * @return str
     */
    public static String DateToStrs(Date date) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String str = format.format(date);
        return str;
    }

    /**
     * 字符串转换成时间 带秒
     * @param str
     * @return date
     */
    public static Date StrToTimes(String str) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = null;
        try {
            date = format.parse(str);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     * 时间转换成字符串 带秒
     * @param date
     * @return str
     */
    public static String TimesToStr(Date date) {
    	if(date==null){
    		return null;
    	}
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String str = format.format(date);
        return str;
    }


    /**
     * 时间转换成字符串 带秒 (省略时间‘:’)
     * @param date
     * @return str
     */
    public static String TimessToStr(Date date) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HHmmss");
        String str = format.format(date);
        return str;
    }

}
