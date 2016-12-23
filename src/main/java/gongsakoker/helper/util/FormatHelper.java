package gongsakoker.helper.util;


import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.SimpleTimeZone;





/**
* 설명 : format 
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.11.18.   박정후     Initial Release
************************************************
*
* @author      박정후
* @version     1.0
* @since       2015.11.18.
*/
public class FormatHelper {
  
   /**
    * GMT를 기준으로 9시간 후를 off set으로 설정
    */
   final static int rawOffset = 9 * 60 * 60 * 1000;
   final static Locale currentLocale = Locale.KOREA;
   final static NumberFormat numberFormatter = NumberFormat
           .getNumberInstance(currentLocale);
   /**
    * 1일의 밀리세컨드.
    */
   final static long DAY_SECOND = 1000 * 60 * 60 * 24;
  
   /**
    * 날짜 딜리미터 삽입 변환
    * 20000702 -- 2000/07/02
    *
    * @param date
    *            String 날짜YYYYMMDD
    * @param division
    *            String 딜리미터
    * @return String 변환날짜
    */
   public static String convertDate(String date, String division) {

       if (date == null) {
           return "";
       }

       date = date.trim();

       if (date.length() != 8) {
           return date;
       }

       return date.substring(0, 4) + division + date.substring(4, 6)
               + division + date.substring(6);
   }
   /**
    * 월  삽입 변환
    * 200007 -- 2000-07
    *
    * @param date
    *            String 날짜YYYYMM
    * @param division
    *            String 딜리미터
    * @return String 변환날짜
    */
   public static String convertMonth(String date, String division) {

       if (date == null) {
           return "";
       }

       date = date.trim();

       if (date.length() != 6) {
           return date;
       }

       return date.substring(0, 4) + division + date.substring(4, 6);
   }
  

   /**
    * 시간 딜리미터 삽입 변환
    * 090000 -- 09:00:00
    *
    * @param date
    *            String 시간hhmmss
    * @param division
    *            String 딜리미터
    * @return String 변환시간
    */
   public static String convertTime(String time, String division) {

       if (time == null) {
           return "";
       }

       time = time.trim();

       if (time.length() != 6) {
           return time;
       }

       return time.substring(0, 2) + division + time.substring(2, 4)
               + division + time.substring(4);
   }
  
   /**
    * 우편번호 딜리미터 삽입 변환
    * 607040 -- 607-040
    *
    * @param date
    *            String 우편번호6자리
    * @param division
    *            String 딜리미터
    * @return String 변환우편번호
    */
   public static String convertZip(String date, String division) {

       if (date == null) {
           return "";
       }

       date = date.trim();

       if (date.length() != 6) {
           return date;
       }

       return date.substring(0, 3) + division + date.substring(3, 6);
   }  
  
   /**
    * Y N 값을 인자값으로 반환
    * 607040 -- 607-040
    *
    * @param sval
    *            String 데이터 값(Y or N)
    * @param Ystr
    *            String Y일때 출력해줄 문자
    * @param Nstr
    *            String N일때 출력해줄 문자                
    * @return String 변환값
    */
   public static String convertYN(String sval,String Ystr, String Nstr) {

       if (sval.equals("Y")) {
           return Ystr;
       }else{
            return Nstr;
       }
   }      
  
   public static String convertNum1_2(String sval,String str1, String str2) {

       if (sval.equals("1")) {
           return str1;
       }else if(sval.equals("2")){
            return str2;
       }else{
            return "";
       }
   }      
  
  
   /**
    * 현재일에서 offset 만큼 더하거나 뺀 년월일을 yyyyMMdd 포맷으로 리턴한다
    *
    * @param offset
    *            
    * @return String yyyyMMdd 포맷의 년월일
    */
   public static String getDate2(int offset) {
       return getFormatDate("yyyyMMdd", Calendar.DATE, offset);
   }

   /**
    * 날짜 가산 후 포멧변환
    * @param format 포멧
    * @param field 대상날짜
    * @param offset 가산일
    * @return String 변환 날짜
    */
   public static String getFormatDate(String format, int field, int offset) {
       SimpleTimeZone stz = new SimpleTimeZone(rawOffset, "KST");
       Calendar rightNow = Calendar.getInstance(stz);

       if (offset != 0) {
           rightNow.add(field, offset);
       }

       Date rightDate = rightNow.getTime();
       SimpleDateFormat sdf = new SimpleDateFormat(format);
       sdf.setTimeZone(stz);

       return sdf.format(rightDate);
   }
   /**
    * 현재 년월일을 yyyyMMdd 포맷으로 리턴한다
    *
    * @return String yyyyMMdd 포맷의 년월일
    */
   public static String getDate() {
       return getFormatDate("yyyyMMdd", 0, 0);
   }
   /**
    * 널 여부 체크
    * @param s 문자열
    * @return boolean true:null, false:not null
    */
   public static boolean isNull(String s) {
       if (s == null)
           return true;
       String rVal = s.trim();
       return ("".equals(rVal)) ? true : false;
   }
   /**
    * Null Blank치환
    * @param str 대상 문자열
    * @return 치환문자열
    */
   public static String nvl(String str) {
       if (str == null) {
           return "";
       }
       return str;
   }
  
   /**
    * TimeStamp Date변환
    * @param _stamp 변환대상 timestamp
    * @return Date 변환한 Date
    */
   public static java.sql.Date getTimestampToDate(java.sql.Timestamp _stamp)
   {
       java.sql.Date date = null;
       if (_stamp != null) {
           date =new java.sql.Date(_stamp.getTime());
       }
       return date;
   }
  
   /**
    * Null or Empty Check
    *
    * @param s
    *            대상문자열
    * @return boolean true: 빈 값 아님, false : 빈값
    */
   public static boolean isNotEmpty( String s )
   {
      
       if ((s != null) && (!nvl(s).trim().equals("")))
       {
           return true;
       }
       else
       {
           return false;
       }
   }
  
  
   /**
    *
    * YYYY-MM-DD 날짜를 YYYYMMDD 형식으로 변환 합니다.
    *
    * @param pStr
    * @return String
    */
   public static String chgDate(String pStr) {
       String rStr = "";
       if(pStr != null && pStr.length() > 0) {
           for (int i = 1; i <= pStr.length(); i ++) {
               if(i > 0 && !pStr.substring(i-1,i).equals("-")) {
                   rStr = rStr + pStr.substring(i-1,i);
               }
           }                                                           
       }
       return rStr;
   }
  
   /**
    *
    * YYYY-MM-DD hh:mm:ss 날짜를 YYYYMMDDhhmmss 형식으로 변환 합니다.
    *
    * @param pStr
    * @return String
    */
   public static String chgDateTime(String pStr) {
       String rStr = "";
       if(pStr != null && pStr.length() > 0) {
           for (int i = 1; i <= pStr.length(); i ++) {
               if(i > 0 && !(pStr.substring(i-1,i).equals("-") || pStr.substring(i-1,i).equals(":"))) {
                   rStr = rStr + pStr.substring(i-1,i);
               }
           }
       }
       return rStr.replaceAll(" ", "");
   }
  
   /**
    * 금액표시
    * @param str
    * @return
    */
   public static String numberFormatter(String str){
       if(str == null || str.equals(""))
        str = "0";
       NumberFormat nf = NumberFormat.getInstance();
       return nf.format(Double.valueOf(str));
   }
  
   /**
    * 현재날짜 구하기
    */
   public static String getCurrentDate()
   {
       long time = System.currentTimeMillis();
       SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
       String str = dayTime.format(new Date(time));
      
       return str;
   }
  
   /**
    * 현재시간 구하기
    */
   public static String getCurrentTime()
   {
       long time = System.currentTimeMillis();
       SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
       String str = sdf.format(new Date(time));
      
       return str;
   }
  
   /**
    * 포멧변환
    * @param format 포멧
    * @param field 대상날짜
    * @param offset 가산일
    * @return String 변환 날짜
    */
   public static String getFormatDate2(String format) {
       SimpleTimeZone stz = new SimpleTimeZone(rawOffset, "KST");
       Calendar rightNow = Calendar.getInstance(stz);

       Date rightDate = rightNow.getTime();
       SimpleDateFormat sdf = new SimpleDateFormat(format);
       sdf.setTimeZone(stz);

       return sdf.format(rightDate);
   }   
  
   /**
    * 사업자 번호 표시형태 변환(1234567890 -> 123-45-67890)
    * @param bizNo
    * @return
    */
   public static String convertBizNo(String bizNo) {
        if (bizNo == null || bizNo.length() == 0) {
            return "";
        }

        bizNo = bizNo.trim();

        if (bizNo.length() != 10) {
            return bizNo;
        }

        return bizNo.substring(0, 3) + "-" + bizNo.substring(3, 5) + "-" + bizNo.substring(5);
   }
   
   /**
   *
   * 초를 DDHHMM 형식으로 변환 합니다.
   *
   * @param pStr
   * @return String
   */
  public static String chgSecToDHM(String sec) {
      int rSec = 0;
      int rMin = 0;
      int rHour = 0;
      int rDay =0;
      int days = 60*60*24;
      int hours = 60*60;
      int minutes = 60;
      
      if(sec != null && sec.length() > 0) {
         rDay = Integer.parseInt(sec)/days;
         rHour = (Integer.parseInt(sec)%days)/hours;
         rMin = (Integer.parseInt(sec)%hours)/minutes;
      }                                                           
      
      
      return rDay+"/"+rHour+"/"+rMin;
  }
 
}