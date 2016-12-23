package gongsakoker.serviceImpl;

import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gongsakoker.controller.BizlinkController;
import gongsakoker.helper.exception.BusinessException;
import gongsakoker.helper.util.MyMailSender;
import gongsakoker.helper.util.bizlink.BizlinkConfig;
import gongsakoker.helper.util.bizlink.BizlinkResponseVO;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.BizlinkService;
import gongsakoker.service.MemberService;
import gongsakoker.vo.MailInfoVO;
import gongsakoker.vo.MemberVO;
import net.sf.json.JSONObject;



/**
* 설명: 회원가입서비스
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.11.18    박정후     Initial Release
************************************************
*
*/

@Service("gongsakoker.memberService")
public class MemberServiceImpl implements MemberService
{
	private final static Log logger = LogFactory.getLog(MemberServiceImpl.class);
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;
	
	@Autowired
	private DataSourceTransactionManager transactionManager;
	@Resource(name = "gongsakoker.bizlinkService")
	private BizlinkService bizlinkService;
	@Autowired
	private BizlinkConfig bizlinkConfig;

	@Override
	public String getMemberIDCheck(Map<String, Object> pMap) {
		String member_id_chk = null;
	     
		try {

			member_id_chk = (String) this.commonDao.getReadData("member.getMemberIDCheck",pMap);
		   
		    if(member_id_chk==null){
		    	member_id_chk="N";
		    }else{
		    	member_id_chk="Y";
		    }
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		return member_id_chk;
	}




	@Override
	public String insertMember_join(Map<String, Object> pMap) throws Exception {
		
		//트랜잭션 처리를 위한 객체생성
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("example-transaction");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		
		TransactionStatus status = transactionManager.getTransaction(def);
		
		
	
		String member_join_chk = null;
		String member_id_chk = null;
	    int chk = 0; 
	    
		try {
			member_id_chk = (String) this.commonDao.getReadData("member.getMemberIDCheck",pMap);
			 if(member_id_chk==null || member_id_chk.equals("")){
				//회원등록
					chk =  this.commonDao.insertData("member.insertMember_join", pMap);

				    if(chk==0){
				    	member_join_chk="N";
				    	Exception e = new Exception("회원가입실패..");
				    	throw e;
				    }else{
				    	
//				    	if(!pMap.get("class_code").toString().equals("01")){
				    	
				    		pMap.put("member_no",this.commonDao.getReadData("member.getMember_no",pMap).toString());
				    		//인포등록
				    		int chk_info =  this.commonDao.insertData("member.insertKoker_info", pMap);
				    		int chk_category = 1;
				    		
				    		if(chk_info == 1){
				    			pMap.put("koker_no",this.commonDao.getReadData("member.getKoker_no",pMap).toString());
				    			
				    			if(!pMap.get("class_code").toString().equals("01")){
				    				pMap.put("koker_name",this.commonDao.getReadData("member.getKoker_name",pMap).toString());  
				    				String[] category_arr = pMap.get("category").toString().split(",");
					    			 
					    			  for (int i = 0; i < category_arr.length; i++) {
										
//					    				  System.out.println(category_arr[i]);
					    				  pMap.put("ca"+category_arr[i],"y");
//					    				 System.out.println(pMap.get("ca"+category_arr[i]).toString());	
									}
					    			  
					    			//카테고리등록  
					    			 chk_category =  this.commonDao.insertData("member.insertKoker_category", pMap);
					    			
					    			 /* 0504 매핑방법 변경으로 주석처리
					    			 //가상번호 처리과정 
					    			 String state = bizlinkConfig.getState();
					    			 if(state.equals("real")){
					    				 BizlinkResponseVO resVO = new BizlinkResponseVO(); 
						    			 String rn = pMap.get("call_tel01").toString()+pMap.get("call_tel02").toString()+pMap.get("call_tel03").toString();
						    			 resVO.setRn(rn);
						    			 resVO.setKoker_no(pMap.get("koker_no").toString());
						    			 resVO.setMemo(URLEncoder.encode(pMap.get("koker_name").toString(), "utf-8"));
						    			 resVO.setMemo2(pMap.get("koker_no").toString());
						    			 pMap.put("koker_no","");
						    			 resVO.setVn(this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString());
						    			 pMap.put("koker_no",resVO.getKoker_no());
						    			
						    			 resVO = bizlinkService.postSet_vn(resVO); 
					    			 }
					    			 */
					    			 
				    			}
				    		}else{
				    			Exception e = new Exception("업체등록실패..");
						    	throw e;
				    		}
				    		if(chk_category == 1){
				    			int chk_state = 0;
				    			//상태등록
				    			 chk_state =  this.commonDao.insertData("member.insertKoker_state", pMap);
				    			 if(chk_state == 1){
				    				 member_join_chk="Y";
				    			 }
				    		}else{
				    			Exception e = new Exception("카테고리등록실패..");
						    	throw e;
				    		}

				    	
				    }
			    }else{
			    	member_join_chk ="R";
			    }
			
		} catch (Exception e) {
			
			logger.debug(e.toString());
			
			transactionManager.rollback(status);
			throw e;
		}
		
		transactionManager.commit(status);
		return member_join_chk;
	
	}
	
	
	@Override
    public MemberVO getMemberInfo( Map<String, Object> pMap ) {
		MemberVO vo = null;
    	
        try {
			vo = (MemberVO)this.commonDao.getReadData("member.getMemberInfo", pMap);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
        
        return vo;
    }


	@Override
	public int sendEmailPw(Map<String, Object> pMap) {
		int result = 0;
		String pw="";
		try{
			pw = (String) this.commonDao.getReadData("member.getFindPw",pMap);

			
			if(pw!=null){
				int[] pwdNum = new int[6];
				
				for(int i = 0; i < pwdNum.length; i++){
					int num=(int)(Math.random()*9)+1;
					pwdNum[i]=num;
				}
				String inNum = pwdNum[0]+""+pwdNum[1]+""+pwdNum[2]+""+pwdNum[3]+""+pwdNum[4]+""+pwdNum[5];
				
				
				pMap.put("password",inNum);
				
				result = this.commonDao.updateData("member.updatePw",pMap);
				
			
				
				MailInfoVO mailInfo = new MailInfoVO();
				String content = "<div style='width:700px; margin:0 auto; text-align:center; padding:.3em; border:solid #d7d7d7 1px; background-color:#fff; font-size:12px; line-height:20px;'>"
						+ "<img src='http://gonggan2014.co.kr/images/koker_mail/inner_banner.png'/>"
						+ "<div style='text-align:left; padding:0 1.5em;'><p style='margin:2em 0 0 0;'>안녕하세요. (주)공간 입니다.</p><p style='margin:0 0 2em 0;'>저희'공사콕커' 어플을 이용해 주셔서 감사드립니다.</p>"
						+ "<p style='margin:0 0 3em 0;'><span style='color:#21b4d6; font-size:14px; font-weight:bold;'>"
						+  pMap.get("member_id").toString()
						+ "</span> 고객님의 임시 비밀번호는 다음과 같습니다.</p>"
						+ "</div><div style='text-align:left; padding:0 1.5em;'><p style='font-size:14px; font-weight:bold; line-height:24px;'>"
						+ "<img src='http://gonggan2014.co.kr/images/koker_mail/inner_check.png' style='vertical-align:middle; font-size:14px;'/> "
						+ "아이디 / 임시 비밀번호</p>"
			            + "<p style='margin-top:1em;'><span style='border:solid #21b4d6 1px; background-color:#21b4d6; color:#fff; font-weight:bold; padding:.5em 1.5em;'>아이디</span><!--"
			            +  "--><span style='border:solid #d7d7d7 1px; padding:.5em 1.5em;'>"
			            +  pMap.get("member_id").toString()
			            + "</span><!--"
						+  "--><span style='border:solid #21b4d6 1px; background-color:#21b4d6; color:#fff; font-weight:bold; padding:.5em 1.5em;'>임시 비밀번호</span><!--"
				        +  "--><span style='border:solid #d7d7d7 1px; padding:.5em 1.5em;'>"
				        +  pMap.get("password").toString()
				        + "</span></p></div>"
				        +  "<div style='text-align:left; padding:1em 1.5em 3em 1.5em;'>"
				        +  "<p style='margin:1em 0 2em 0;'>임시 비밀번호로 로그인 하신 후 <a href='#' style='color:#21b4d6; font-weight:bold;'>[마이메뉴 → 정보관리]</a>에서 변경하실 수 있습니다.</p>"
				        +  "<p style='margin:0;'>본 메일은 회원님께서 수신 가능 메일주소로 설정한 e-mail 주소로 발송된 것으로 발신전용이며,</p><p style='margin:0;'>궁금하신 사항이나 기타 관련 문의는 <a href='#' style='color:#21b4d6; font-weight:bold;'>고객지원실</a>을 이용해주시기 바랍니다.</p></div>"
				        +  "<div style='background-color:#e5e5e5; text-align:left; padding:.5em 1.5em; background-clip:paddingbox;'><p style='margin:0;'>tel : <span style='font-weight:bold;'>1566-5831</span> ㅣ fax : 031 - 317 - 4632</p><p style='margin:0;'>경기도 시흥시 봉우재로 51번길 지성프라자 5층</p><p style='margin:0;'>대표이사 : 김철민 ㅣ 개인정보책임관리자 : 김기윤 ㅣ 사업자 등록번호 : 140-81-92864</p><p style='margin:0;'>통신판매업 신고 : 제2015-경기시흥 013호 ㅣ 직업정보제공 신고 : 안산지청 제2015-009</p><p style='margin:1.5em 0 0 0; font-size:11px;'>Copyright(c) GONGGAN CO., LTD. all right reserved. gongsakoker.com</p></div></div>";
				//mailInfo.setReceiverEmail(pMap.get("member_id").toString());
	
				
				mailInfo.setReceiverEmail(pMap.get("member_id").toString());
				mailInfo.setSenderEmail("gonggan1411@gmail.com");
				mailInfo.setSenderName("공사콕커");
				mailInfo.setSubject("공사콕커 임시비밀번호입니다.");
				mailInfo.setContent(content);
				
				MyMailSender mail = new MyMailSender();
				mail.mailSend(mailInfo);
			}
		}catch(Exception e){
			logger.debug(e.toString());
		}
		
		
		
		return result;
	}


	@Override
	public List<Object> getBusinessKind(Map<String, Object> pMap) {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("member.getBusinessKind", pMap);
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}
	
	@Override
	public List<Object> getZip_area() {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("member.getZip_area");
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}
	
	@Override
	public List<Object> getZip_city() {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("member.getZip_cityAll");
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}

	@Override
	public List<Object> getZip_city(Map<String, Object> pMap) {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("member.getZip_city", pMap);
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}

	@Override
	public String getWork_state(Map<String, Object> pMap) {
		String work_state = "";
	     
		try {
			if(pMap.get("update_yn").toString().equals("y")){
				
				String chk  = (String) this.commonDao.getReadData("member.getKoker_state",pMap);
				
				if(chk != null){
					this.commonDao.updateData("member.updateKoker_state", pMap);
				}else{
					this.commonDao.insertData("member.insertKoker_state_null", pMap);
				}
				
				
			}
			work_state = (String) this.commonDao.getReadData("member.getKoker_state",pMap);
		   
		   
		} catch (Exception e) {
			
			logger.debug(e.toString());
		}
		return work_state;
	}




	@Override
	public List<Object> getCompanyInfo(Map<String, Object> pMap) {
		List<Object> rList = null;
		try {
			rList = this.commonDao.getListData("member.getCompanyInfo", pMap);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		return rList;
	}
	
	//회원 탈퇴
	@Override
	public int doMemberLeave(Map<String, Object> pMap) {
		int result = 0;
		try {
			result = this.commonDao.updateData("member.doMemberLeave", pMap);
			String koker_no = this.commonDao.getReadData("member.getKoker_no",pMap).toString();
			pMap.put("koker_no", koker_no);
			 //가상번호 처리과정 
			 String state = bizlinkConfig.getState();
			 if(state.equals("real")){
				String vn = this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString();
				
				if(!vn.equals("") && !vn.equals("null") && vn!=null){
					BizlinkResponseVO resVO = new BizlinkResponseVO(); 
					resVO.setVn(vn);
					resVO.setRn(" ");
					resVO.setMemo("");
					resVO.setMemo2("");
				
					resVO = bizlinkService.postSet_vn(resVO);
				}
			 }
			
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		return result;
	}
	
	@Override
	public int updateCompanyInfo(Map<String, Object> pMap) {
		int result = 0;
		try {
//			if(!pMap.get("password").toString().equals("")){
//				String pwd = (String)this.commonDao.getReadData("member.getPassword", pMap);
//				if(pwd.equals(pMap.get("password").toString())){
//					result = this.commonDao.updateData("member.updateCompanyMember", pMap);
//					if(result==1){
//						result = this.commonDao.updateData("member.updateCompanyInfo", pMap);
//					}
//				}else{
//					result = 3;
//				}
//			}else{
				result = this.commonDao.updateData("member.updateCompanyMember", pMap);
				if(result==1){
					if(!pMap.get("class_code").toString().equals("01")){
						
						pMap.put("koker_no", this.commonDao.getReadData("member.getKoker_no",pMap).toString());
						
						
						/* 가상번호처리방법 변경으로 주석처리
						String state = bizlinkConfig.getState();
		    			 if(state.equals("real")){
							//가상번호 처리과정 
			    			
			    			pMap.put("memo", this.commonDao.getReadData("member.getKoker_name",pMap).toString());
			    		
							String rn = (String)this.commonDao.getReadData("bizlink.getBizlinkRN",pMap);
						
							if(rn!=null){
								if(!rn.equals(pMap.get("call_tel01").toString()+pMap.get("call_tel02").toString()+pMap.get("call_tel03").toString())){
									System.out.println("bizlink 수정요청..");
									BizlinkResponseVO resVO = new BizlinkResponseVO(); 
									 rn = pMap.get("call_tel01").toString()+pMap.get("call_tel02").toString()+pMap.get("call_tel03").toString();
					    			 resVO.setRn(rn);
					    			 resVO.setKoker_no(pMap.get("koker_no").toString());
					    			 resVO.setMemo(URLEncoder.encode(pMap.get("memo").toString(), "utf-8"));
					    			 resVO.setMemo2(pMap.get("koker_no").toString());
					    			 resVO.setVn(this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString());
					    			 resVO = bizlinkService.postSet_vn(resVO);
								}
							}else{
								System.out.println("bizlink 등록요청..");
								BizlinkResponseVO resVO = new BizlinkResponseVO(); 
								 rn = pMap.get("call_tel01").toString()+pMap.get("call_tel02").toString()+pMap.get("call_tel03").toString();
				    			 resVO.setRn(rn);
				    			 resVO.setKoker_no(pMap.get("koker_no").toString());
				    			 resVO.setMemo(URLEncoder.encode(pMap.get("memo").toString(), "utf-8"));
				    			 resVO.setMemo2(pMap.get("koker_no").toString());
				    			 pMap.put("koker_no","");
				    			 resVO.setVn(this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString());
				    			 pMap.put("koker_no",resVO.getKoker_no());
				    			 resVO = bizlinkService.postSet_vn(resVO);
							}
	
						}
		    			 */
					}
					result = this.commonDao.updateData("member.updateCompanyInfo", pMap);
				}
//			}
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		return result;
	}




	@Override
	public int delCompanyFile(Map<String, Object> pMap) {
		int result = 0;
		try {
			result = this.commonDao.updateData("member.delCompanyFile", pMap);
		} catch (Exception e) {
			e.toString();
		}
		return result;
	}

}//end class

