

package gongsakoker.helper.util.bizlink;
/**
 * bizlink 통신
 * @author 박정후
 *
 */


import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;


public class Bizlink {
	
	private final static Log logger = LogFactory.getLog(Bizlink.class);
    
    /**
     * POST 요청
     * @param url       요청할 url
     * @param params    파라메터
     * @param encoding  파라메터 Encoding
     * @return 서버 응답결과 문자열
     */
    public static BizlinkResponseVO post(String url, List<NameValuePair> paramList, String encoding){
        HttpClient client = new DefaultHttpClient();
        BizlinkResponseVO resVO = new BizlinkResponseVO();
        try{
       
            HttpPost post = new HttpPost(url);
//            System.out.println("POST : " + post.getURI());
           
            post.setEntity(new UrlEncodedFormEntity(paramList, encoding));
          
            HttpResponse response = client.execute(post);
            String json = EntityUtils.toString(response.getEntity(), "UTF-8");
            
            try {
                JSONParser parser = new JSONParser();
                Object resultObject = parser.parse(json);

                if (resultObject instanceof JSONArray) {
                    JSONArray array=(JSONArray)resultObject;
                    	System.out.println("array");
                    for (Object object : array) {
                    	
                        JSONObject obj =(JSONObject)object;
                        resVO.setRt(obj.get("rt").toString());
                        resVO.setRs(obj.get("rs").toString());
                        resVO.setRid(obj.get("rid").toString());
                        resVO.setVn(obj.get("vn").toString());
                        resVO.setRn(obj.get("rn").toString());
                        resVO.setCr_id(obj.get("cr_id").toString());
                        resVO.setCb_sms(obj.get("cb_sms").toString());
                        resVO.setCb_sms_txt(obj.get("cb_sms_txt").toString());
                        resVO.setDesc(obj.get("desc").toString());
                        resVO.setReg_dt(obj.get("reg_dt").toString());
                    }

                }else if (resultObject instanceof JSONObject) {
                	System.out.println("object");
                    JSONObject obj =(JSONObject)resultObject;

                    if(obj.get("rt")!=null){
                    	resVO.setRt(obj.get("rt").toString());
                    }else{
                    
                    }
                    if(obj.get("rs")!=null){
                    	resVO.setRs(obj.get("rs").toString());
                    }else{
                    	
                    }
                    if(obj.get("rid")!=null){
                    	resVO.setRid(obj.get("rid").toString());
                    }else{
                    	
                    }
                    if(obj.get("vn")!=null){
                    	 resVO.setVn(obj.get("vn").toString());
                    }else{
                    	
                    }
                    if(obj.get("rn")!=null){
                    	 resVO.setRn(obj.get("rn").toString());
                    }else{
                    	
                    }
                    if(obj.get("cr_id")!=null){
                    	 resVO.setCr_id(obj.get("cr_id").toString());
                    }else{
                    	
                    }
                    if(obj.get("cb_sms")!=null){
                    	 resVO.setCb_sms(obj.get("cb_sms").toString());
                    }else{
                    	
                    }
                    if(obj.get("cb_sms_txt")!=null){
                    	 resVO.setCb_sms_txt(obj.get("cb_sms_txt").toString());
                    }else{
                    	
                    }
                    if(obj.get("desc")!=null){
                    	resVO.setDesc(obj.get("desc").toString());
                    }else{
                    	
                    }
                    if(obj.get("reg_dt")!=null){
                    	 resVO.setReg_dt(obj.get("reg_dt").toString());
                    }else{
                    	
                    }
                    if(obj.get("rec")!=null){
                    	
                    	JSONArray rec = (JSONArray)obj.get("rec");
                    	
                    	String [] vn = new String[rec.size()];
                    	String [] rn = new String[rec.size()];
                    	String [] cr_id = new String[rec.size()];
                    	String [] if_id = new String[rec.size()];
                    	String [] cb_sms = new String[rec.size()];
                    	String [] cb_sms_txt = new String[rec.size()];
                    	String [] rid = new String[rec.size()];
                    	String [] type = new String[rec.size()];
                    	String [] desc = new String[rec.size()];
                    	String [] reg_dt = new String[rec.size()];
                    	
                    	Map<String,Object> rMap = new HashMap<String, Object>();
                    	
                    	for (int i = 0; i < rec.size(); i++) {
                         	JSONObject ob = (JSONObject)rec.get(i);
                         	
                         	if(ob.get("vn")!=null){
                         		vn[i] = ob.get("vn").toString();
//                         		System.out.println("vn->"+vn[i]);
                         	}else{
                         		vn[i] = "";
                         	}

                         	if(ob.get("rn")!=null){
                         		rn[i] = ob.get("rn").toString();
//                             	System.out.println("rn->"+rn[i]);
                         	}else{
                         		rn[i] = "";
                         	}
                         	
                         	if(ob.get("cr_id")!=null){
                         		cr_id[i] = ob.get("cr_id").toString();
//                             	System.out.println("cr_id->"+cr_id[i]);
                         	}else{
                         		cr_id[i] = "";
                         	}
                         	
                         	if(ob.get("if_id")!=null){
                         		if_id[i] = ob.get("if_id").toString();
//                             	System.out.println("if_id->"+if_id[i]);
                         	}else{
                         		if_id[i] = "";
                         	}
                         	
                         	if(ob.get("cb_sms")!=null){
                         		cb_sms[i] = ob.get("cb_sms").toString();
//                             	System.out.println("cb_sms->"+cb_sms[i]);
                         	}else{
                         		cb_sms[i] = "";
                         	}
                         	
                        	if(ob.get("cb_sms_txt")!=null){
                        		cb_sms_txt[i] = ob.get("cb_sms_txt").toString();
//                             	System.out.println("cb_sms_txt->"+cb_sms_txt[i]);
                         	}else{
                         		cb_sms_txt[i] = "";
                         	}
                        	
                        	if(ob.get("rid")!=null){
                        		rid[i] = ob.get("rid").toString();
//                             	System.out.println("rid->"+rid[i]);
                         	}else{
                         		rid[i] = "";
                         	}
                         	
                        	if(ob.get("type")!=null){
                        		type[i] = ob.get("type").toString();
//                             	System.out.println("type->"+type[i]);
                         	}else{
                         		type[i] = "";
                         	}
                        	
                        	if(ob.get("desc")!=null){
                        		desc[i] = ob.get("desc").toString();
//                             	System.out.println("desc->"+desc[i]);
                         	}else{
                         		desc[i] = "";
                         	}
                         	
                        	if(ob.get("reg_dt")!=null){
                        		reg_dt[i] = ob.get("reg_dt").toString();
//                             	System.out.println("reg_dt->"+reg_dt[i]);
                         	}else{
                         		reg_dt[i] = "";
                         	}
                         
                         	
         				}
                
                        rMap.put("vn",vn);
                        rMap.put("rn",rn);
                        rMap.put("cr_id",cr_id);
                        rMap.put("if_id",if_id);
                        rMap.put("cb_sms",cb_sms);
                        rMap.put("cb_sms_txt",cb_sms_txt);
                        rMap.put("rid",rid);
                        rMap.put("type",type);
                        rMap.put("desc",desc);
                        rMap.put("reg_dt",reg_dt);
                        
                        resVO.setRes(rMap);
                        
                    }else{
						
					}
                    
                }//end if       	

            } catch (Exception e) {
                // TODO: handle exception
            	e.toString();
            }
            
       
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            client.getConnectionManager().shutdown();
        }
         
        return resVO;
    }
     
 




}
