package gongsakoker.helper.util.bizlink;

import java.security.GeneralSecurityException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import sun.misc.BASE64Encoder;



/**
 * bizlink makMsg[전문생성]
 * @author 박정후
 *
 */
public class BizlinkHelper {

	private final static Log logger = LogFactory.getLog(BizlinkHelper.class);


	//md5 암호화 후 base64인코딩
	@SuppressWarnings("restriction")
	public static String md5(String str)
	  {
	   
	    String retStr = "";
	   
		BASE64Encoder base64Enc = new BASE64Encoder();
	    String md5 = "";
	    try
	    {
	    	MessageDigest md = MessageDigest.getInstance("MD5");
	        md.update(str.getBytes());
	        byte byteData[] = md.digest();
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	            sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        md5 = sb.toString();
	       
	        retStr = base64Enc.encode(md5.getBytes());
	   
	    } catch (GeneralSecurityException e) {
	      throw new RuntimeException(e);
	    }
	    return retStr;
	  }
	
	//MAP - > LIST 로 CONVERTING
    public static List<NameValuePair> convertParam(Map<String, Object> pMap){
        List<NameValuePair> paramList = new ArrayList<NameValuePair>();
        Iterator <String> keys = pMap.keySet().iterator();
        while(keys.hasNext()){
            String key = keys.next();
            paramList.add(new BasicNameValuePair(key, pMap.get(key).toString()));
        }
         
        return paramList;
    }


}
