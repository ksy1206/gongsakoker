package gongsakoker.serviceImpl;


import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.LikeService;



/**
* 설명: 나의콕
*
************************************************
* DATE          AUTHOR           DESCRIPTION
* ----------------------------------------------
* 2015.12.02    박정후     Initial Release
************************************************
*
*/

@Service("gongsakoker.likeService")
public class LikeServiceImpl implements LikeService
{
	private final static Log logger = LogFactory.getLog(LikeServiceImpl.class);
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	

	@Override
	public List<Object> getLikeList(Map<String, Object> pMap) {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("like.getLikeList", pMap);
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}



	@Override
	public int deleteBookMark(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.deleteData("like.deleteBookMark",pMap);
		} catch (Exception e){ 
			logger.debug(e.toString());
		}
		return result;
	}
	
	@Override
	public int insertBookMark(Map<String, Object> pMap) {
		int result = 0;
		
		try {
			result = this.commonDao.insertData("like.insertBookMark",pMap);
		} catch (Exception e){ 
			logger.debug(e.toString());
		}
		return result;
	}
}

