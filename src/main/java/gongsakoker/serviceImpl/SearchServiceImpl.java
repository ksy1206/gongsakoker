package gongsakoker.serviceImpl;


import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.SearchService;
import gongsakoker.vo.MemberVO;



/**
* 설명: 검색서비스
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.12.11    박정후     Initial Release
************************************************
*
*/

@Service("gongsakoker.searchService")
public class SearchServiceImpl implements SearchService
{
	private final static Log logger = LogFactory.getLog(SearchServiceImpl.class);
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	

	@Override
	public List<Object> getSearchList(Map<String, Object> pMap) {
		List<Object> rList = null;
		
    	try {
			
    		rList = this.commonDao.getListData("search.getSearchList", pMap);

		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}

	@Override
	public List<Object> getBusinessKindAll() {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("search.getBusinessKindAll");
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}

	
}

