
package gongsakoker.service;

import java.util.List;
import java.util.Map;


/**
* 설명 : 검색 서비스 인터페이스
*
************************************************
* DATE AUTHOR DESCRIPTION
* ----------------------------------------------
* 2015. 12. 11. 박정후 Initial Release
************************************************
*
*/
public interface SearchService
{

     /**
     * 나의콕 로딩
     * @return
     */
     public List<Object> getSearchList(Map<String, Object> pMap);

     /**
     * 업체종류로딩
     * @return
     */
     public List<Object> getBusinessKindAll();
	
    
     
 
}