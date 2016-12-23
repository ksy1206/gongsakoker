    
package gongsakoker.service;

import java.util.Map;

import gongsakoker.helper.util.bizlink.BizlinkResponseVO;


/**
* 설명 : bizlink 서비스 인터페이스
*
************************************************
* DATE AUTHOR DESCRIPTION
* ----------------------------------------------
* 2016. 01. 13. 박정후 Initial Release
************************************************
*
*/
public interface BizlinkService
{
       /**
        * 업체 웹서버 URL 요청
        * @return
        */
        public BizlinkResponseVO postReg_svr_url();
        
        /**
         * 가상번호 리스트 요청
         * @return
         */
         public BizlinkResponseVO postGet_vns();
         
         /**
          * 가상번호 리스트 설정
          * @return
          */
          public BizlinkResponseVO postSet_vn(BizlinkResponseVO resVO);
          
          /**
           * CDR 로그 기록
           * @return
           */
          public int insertCDR(Map<String, Object> pMap) throws Exception;

		  public BizlinkResponseVO postSet_vn_temp(BizlinkResponseVO resVO);
		  public BizlinkResponseVO postSet_vn_empty(BizlinkResponseVO resVO);
		  public int insertCDR_temp(Map<String, Object> pMap) throws Exception;
		
		 /**
         * 가상번호 초기화 요청
         * @return
         */
         public BizlinkResponseVO postGetInit_vns();
         
         /**
          * 가상번호 초기화 설정
          * @return
          */
          public BizlinkResponseVO postSetInit_vn(BizlinkResponseVO resVO);
 
}