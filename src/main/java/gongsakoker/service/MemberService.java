    
package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.vo.MemberVO;

/**
* 설명 : 회원가입 서비스 인터페이스
*
************************************************
* DATE AUTHOR DESCRIPTION
* ----------------------------------------------
* 2015. 11. 18. 박정후 Initial Release
************************************************
*
*/
public interface MemberService
{
   
     /**
     * 아이디 중복체크
     * @return
     */
     public String getMemberIDCheck(Map<String, Object> pMap);
    
     /**
     * 회원가입
     * @return
     */
     public String insertMember_join(Map<String, Object> pMap) throws Exception;
     /**
     * 사용자 정보 조회
     * @return
     */
     public MemberVO getMemberInfo( Map<String, Object> pMap );
     /**
     * 비밀번호 찾기
     * @return
     */
     public int sendEmailPw(Map<String, Object> pMap);
     /**
     * 업체종류 로딩
     * @return
     */
     public List<Object> getBusinessKind(Map<String, Object> pMap);
     /**
     * 지역 로딩
     * @return
     */
     public List<Object> getZip_area();
     /**
     * 도시 로딩
     * @return
     */
     public List<Object> getZip_city();
     public List<Object> getZip_city(Map<String, Object> pMap);
    
     /**
      * 기술자 상태로딩
      * @return
      */
      public String getWork_state(Map<String, Object> pMap) throws BusinessException;
      /**
       * 업체정보로딩
       * @return
       */
      public List<Object> getCompanyInfo(Map<String, Object> pMap);
    
      /**
       * 회원탈퇴
       * @return
       */
       public int doMemberLeave(Map<String, Object> pMap);
       
       /**
        * 정보수정
        * @return
        */
        public int updateCompanyInfo(Map<String, Object> pMap);
        
        public int delCompanyFile(Map<String, Object> pMap);


 
}