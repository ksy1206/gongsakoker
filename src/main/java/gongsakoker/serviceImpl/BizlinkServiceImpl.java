package gongsakoker.serviceImpl;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.Resource;
import javax.swing.plaf.synth.SynthSpinnerUI;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import gongsakoker.helper.util.bizlink.Bizlink;
import gongsakoker.helper.util.bizlink.BizlinkConfig;
import gongsakoker.helper.util.bizlink.BizlinkHelper;
import gongsakoker.helper.util.bizlink.BizlinkResponseVO;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.BizlinkService;





/**
* 설명: bizlink 서비스
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2016.01.13    박정후     Initial Release
************************************************
*
*/

@Service("gongsakoker.bizlinkService")
public class BizlinkServiceImpl implements BizlinkService
{
	private final static Log logger = LogFactory.getLog(BizlinkServiceImpl.class);
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;
	@Autowired
	private BizlinkConfig bizlinkConfig;
	 
//	String vn_test = "";
	
	//최초 업체 웹서버 URL 등록
	@Override
	public BizlinkResponseVO postReg_svr_url() {
		Map<String, Object> pMap = new HashMap<String, Object>();
 		BizlinkResponseVO resVO = new BizlinkResponseVO();
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/reg_svr_url.do";
         String iid = bizlinkConfig.getIid();
    	 String svr_url = bizlinkConfig.getSvr_url();
    	 String auth = iid+svr_url;
    	 
    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);  
    	 String cdr_recv_url = "/bizlink/cdr_recv.do";

         pMap.put("iid",iid);
         pMap.put("svr_url", svr_url);
         pMap.put("auth",auth);
         pMap.put("cdr_recv_url", cdr_recv_url);

         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         resVO = Bizlink.post(url,paramList,"UTF-8");
         
         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
		
         return resVO;
	}
	
	//가상번호 리스트요청
	@Override
	public BizlinkResponseVO postGet_vns() {
		Map<String, Object> pMap = new HashMap<String, Object>();
		Map<String, Object> rMap = new HashMap<String, Object>();
 		BizlinkResponseVO resVO = new BizlinkResponseVO();
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/get_vns.do";
         String iid = bizlinkConfig.getIid();
         SimpleDateFormat sdf  = new SimpleDateFormat("MMDD");
         Date d = new Date();
    	 String mmdd = sdf.format(d);
    	 String auth = iid+mmdd;
    	 
    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);
  
         pMap.put("iid",iid);
         pMap.put("mmdd", mmdd);
         pMap.put("auth",auth);
        
         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         														
         resVO = Bizlink.post(url,paramList,"UTF-8");

         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
         
         if(resVO.getRt().toString().equals("0")){
	 		try {
	 	       //res배열 파싱 
	          rMap = resVO.getRes();
	          String [] vn = (String[])rMap.get("vn");
	          
	          List<Object> rList = null;
	          rList = this.commonDao.getListData("bizlink.getListBizlink",pMap);

	          System.out.println("biz_arr.size-->"+rList.size());
	          System.out.println("vn.size-->"+vn.length);
	        	
	          //델피콤 서버에 가상번호리스트 초기화 시 i = 0
	          for (int i = rList.size(); i < vn.length; i++) { //초기화시 주석처리
//	          for (int i = 0; i < vn.length; i++) {
	        	pMap.put("vn",vn[i]); 
	        	
//	        	resVO.setVn(vn[i]);//델피콤 서버에 가상번호리스트 초기화 시 사용        	
//	        	postSet_vn(resVO);//델피콤 서버에 가상번호리스트 초기화 시 사용
	        	
	        	this.commonDao.insertData("bizlink.insertBizlink",pMap); //초기화시 주석처리
	 		}
				 
			   
			} catch (Exception e) {
				logger.debug(e.toString());
			}
        }
         return resVO;
	}

	
	
	@Override
	public BizlinkResponseVO postSet_vn(BizlinkResponseVO resVO) {
		Map<String, Object> pMap = new HashMap<String, Object>();
 		
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/set_vn.do";
         String iid = bizlinkConfig.getIid();
    	 String vn = resVO.getVn();
    	 String rn = resVO.getRn();
    	 
    	 
//    	 rn = " "; //델피콤 서버에 가상번호리스트 초기화 시 사용
//    	 vn = "05079749203";// 변경시사용
    	 String memo = resVO.getMemo(); //초기화시 주석처리
    	 String memo2 = resVO.getMemo2(); //초기화시 주석처리
    	 
    	 String auth = iid+vn;
    	 String koker_no = null;
    	 
    	 if(resVO.getKoker_no()!=null && !resVO.getKoker_no().toString().equals("")){
    		
    		 koker_no = resVO.getKoker_no();
    	 }
    	 
    	 
    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);
    	
         pMap.put("iid",iid);
         pMap.put("vn", vn);
         pMap.put("rn", rn);
         pMap.put("auth",auth);
         pMap.put("memo",memo);//초기화시 주석처리
         pMap.put("memo2",memo2);//초기화시 주석처리

         
         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         resVO = Bizlink.post(url,paramList,"UTF-8");
         
         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
         
         if(resVO.getRt().toString().equals("0")){
 	 		try {
 	        //가상번호등록
 	 		pMap.put("koker_no",koker_no);
 	 		
 	  		 this.commonDao.updateData("bizlink.updateBizlink", pMap);

 			} catch (Exception e) {
 				logger.debug(e.toString());
 			}
         }
        
		
         return resVO;
	}
	
	@Override
	public int insertCDR(Map<String, Object> pMap) throws Exception {
		int result = 0;
		try {
			result =  this.commonDao.updateData("bizlink.insertCDR", pMap);
			
		}catch(Exception e){
			e.toString();
		}
		return result;
	}
	
	
	@Override
	public int insertCDR_temp(Map<String, Object> pMap) throws Exception {
		int result = 0;
		/* 문자는 콜로그가 안들어와서 사용불가
		String vn = "";
		String rn = " ";
		String koker_no = "";
		BizlinkResponseVO resVO = new BizlinkResponseVO();
		
		try {
			
			result =  this.commonDao.updateData("bizlink.insertCDR", pMap);
			resVO.setVn(pMap.get("vn").toString()); 
			resVO.setRn(" ");
			resVO.setKoker_no("");
			postSet_vn_empty(resVO);
		}catch(Exception e){
			e.toString();
		}
			*/
		return result;
	}

	@Override
	public BizlinkResponseVO postSet_vn_temp(BizlinkResponseVO resVO) {
		Map<String, Object> pMap = new HashMap<String, Object>();
 		
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/set_vn.do";
         String iid = bizlinkConfig.getIid();
    	 String vn = "";
    	 String rn = resVO.getRn();
    	 String  koker_no = resVO.getKoker_no();
    	 String memo = "";
		try {
			vn = this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString();
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		 
		String auth = iid+vn;
		
    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);
    	
         pMap.put("iid",iid);
         pMap.put("vn", vn);
         pMap.put("rn", rn);
         pMap.put("auth",auth);
         pMap.put("memo",koker_no);
         pMap.put("memo2",koker_no);

         
         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         resVO = Bizlink.post(url,paramList,"UTF-8");
         
         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
         
         if(resVO.getRt().toString().equals("0")){
 	 		try {
 	        //가상번호등록
 	 		pMap.put("koker_no",koker_no);
 	 		
 	  		 this.commonDao.updateData("bizlink.updateBizlink", pMap);
 	  		
 	  		 
 	  		 
 	  		 ///////////////////////////////////////////////
 	  		 // 가상번호 등록후 5분후 삭제처리
 	  		 ///////////////////////////////////////////////
 	  		 Timer tm = new Timer();
 	  		 final String vn_timer = vn; 
 	  		 TimerTask tm_run = new TimerTask(){

				@Override
				public void run() {
					BizlinkResponseVO resVO2 = new BizlinkResponseVO();
					resVO2.setVn(vn_timer);
					postSet_vn_empty(resVO2);
					cancel();//자원반납
				}
 	  			 
 	  		 };
 	  		 tm.schedule(tm_run,300000);
 	  		 
 	  		
 			} catch (Exception e) {
 				logger.debug(e.toString());
 			}
         }
        
         resVO.setVn(vn);
         return resVO;
	}

	
	@Override
	public BizlinkResponseVO postSet_vn_empty(BizlinkResponseVO resVO) {
		
		Map<String, Object> pMap = new HashMap<String, Object>();
 		
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/set_vn.do";
         String iid = bizlinkConfig.getIid();
    	 String vn = resVO.getVn();
    	 String rn = " ";
    	 String  koker_no = "0";
    	 String memo = "";
	
		String auth = iid+vn;
		
    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);
    	
         pMap.put("iid",iid);
         pMap.put("vn", vn);
         pMap.put("rn", rn);
         pMap.put("auth",auth);
         pMap.put("memo",memo);
         pMap.put("memo2",koker_no);

         
         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         resVO = Bizlink.post(url,paramList,"UTF-8");
         
         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
         
         if(resVO.getRt().toString().equals("0")){
 	 		try {
 	        //가상번호등록
 	 		 pMap.put("koker_no",koker_no);
 	 		
 	  		 this.commonDao.updateData("bizlink.updateBizlink", pMap);

 			} catch (Exception e) {
 				logger.debug(e.toString());
 			}
         }

         return resVO;
	}


	
	
	
	
	
	//가상번호 초기화
	@Override
	public BizlinkResponseVO postGetInit_vns() {
		Map<String, Object> pMap = new HashMap<String, Object>();
		Map<String, Object> rMap = new HashMap<String, Object>();
 		BizlinkResponseVO resVO = new BizlinkResponseVO();
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/get_vns.do";
         String iid = bizlinkConfig.getIid();
         SimpleDateFormat sdf  = new SimpleDateFormat("MMDD");
         Date d = new Date();
    	 String mmdd = sdf.format(d);
    	 String auth = iid+mmdd;
    	 
    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);
  
         pMap.put("iid",iid);
         pMap.put("mmdd", mmdd);
         pMap.put("auth",auth);
        
         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         														
         resVO = Bizlink.post(url,paramList,"UTF-8");

         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
         
         if(resVO.getRt().toString().equals("0")){
	 		try {
	 	       //res배열 파싱 
	          rMap = resVO.getRes();
	          String [] vn = (String[])rMap.get("vn");
	          
	          List<Object> rList = null;
	          rList = this.commonDao.getListData("bizlink.getListBizlink",pMap);

	          System.out.println("biz_arr.size-->"+rList.size());
	          System.out.println("vn.size-->"+vn.length);
	        	
	          //델피콤 서버에 가상번호리스트 초기화 시 i = 0    
	          for (int i = 0; i < vn.length; i++) {
	        	pMap.put("vn",vn[i]); 
	        	
	        	resVO.setVn(vn[i]);//델피콤 서버에 가상번호리스트 초기화 시 사용        	
	        	postSetInit_vn(resVO);//델피콤 서버에 가상번호리스트 초기화 시 사용

	 		}
				 
			   
			} catch (Exception e) {
				logger.debug(e.toString());
			}
        }
         return resVO;
	}

	
	//가상번호 초기화
	@Override
	public BizlinkResponseVO postSetInit_vn(BizlinkResponseVO resVO) {
		Map<String, Object> pMap = new HashMap<String, Object>();
 		
 		
    	 //델피콤 URL
    	 String url = bizlinkConfig.getUrl();
    	 url = url+"/link/set_vn.do";
         String iid = bizlinkConfig.getIid();
    	 String vn = resVO.getVn();
    	 String rn = resVO.getRn();
    	 
    	 
    	 rn = " "; //델피콤 서버에 가상번호리스트 초기화 시 사용

    	 
    	 String auth = iid+vn;
    	 String koker_no = "0";

    	 //MD5 암호화 후 base64 인코딩
    	 auth = BizlinkHelper.md5(auth);
    	
         pMap.put("iid",iid);
         pMap.put("vn", vn);
         pMap.put("rn", rn);
         pMap.put("auth",auth);


         
         List<NameValuePair> paramList = BizlinkHelper.convertParam(pMap);
         resVO = Bizlink.post(url,paramList,"UTF-8");
         
         logger.debug(resVO.getRs());
         logger.debug(resVO.getRt());
         
         if(resVO.getRt().toString().equals("0")){
 	 		try {
 	        //가상번호등록
 	 		pMap.put("koker_no",koker_no);
 	 		
 	  		 this.commonDao.updateData("bizlink.updateBizlink", pMap);

 			} catch (Exception e) {
 				logger.debug(e.toString());
 			}
         }
        
		
         return resVO;
	}

}//end class

