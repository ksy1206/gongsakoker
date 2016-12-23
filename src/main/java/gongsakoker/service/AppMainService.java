
package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.vo.MemberVO;

/**
* 설명 : 메인 서비스 인터페이스
*
************************************************
* DATE AUTHOR DESCRIPTION
* ----------------------------------------------
* 2015. 12. 02. 박정후 Initial Release
************************************************
*
*/
public interface AppMainService
{
   
    
     /**
     * 알림on/off
     * @return
     */
     public int updatePush_yn(Map<String, Object> pMap);
     public String getPush_yn(Map<String, Object> pMap);
     /**
      * 남은시간로딩
      * @return
      */
     public String getChargeCountDown(Map<String, Object> pMap);
     /**
      * 핸드폰 알림 정보 업데이트 안드로이드 / ios
      * */
     public void updatehp_reg_id(Map<String, Object> rMap);
     public void updateios_reg_id(Map<String, Object> rMap);
     /**
      * 업체리스트가져오기
      * @return
      */
     public List<Object> selectKokerList(Map map);
     public List<Object> selectKokerList03(Map map);
     /**
      * Map 마킹 정보 가져오기
      * @return
      */
     public List<Object> selectMapList(Map map);
     
     //카테고리 리스트
	 public List<Object> categoryList(String class_code);
     
 
}