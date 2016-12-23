
package gongsakoker.service;

import java.util.List;
import java.util.Map;


/**
* 설명 : 나의콕 서비스 인터페이스
*
************************************************
* DATE AUTHOR DESCRIPTION
* ----------------------------------------------
* 2015. 12. 03. 박정후 Initial Release
************************************************
*
*/
public interface LikeService
{

     /**
     * 나의콕 로딩
     * @return
     */
     public List<Object> getLikeList(Map<String, Object> pMap);

	public int deleteBookMark(Map<String, Object> pMap);

	public int insertBookMark(Map<String, Object> pMap);
    
    
    
    

 
}