package gongsakoker.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.AreaBoardService;
import gongsakoker.vo.LocalBoardVO;
/**
* 설명 : 지역계시판
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.12.01    권세윤    
*************************
*
*/

@Service("gongsakoker.AreaBoardService")
public class AreaBoardServiceImpl implements AreaBoardService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public List<Object> getLocalBoard(LocalBoardVO localBoardVo) {
		// TODO Auto-generated method stub
		List<Object> LocalBoardVo = null;
		
		try {
			LocalBoardVo = this.commonDao.getListData("areaBoard.getAreaBoard", localBoardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return LocalBoardVo;
	}

	@Override
	public String addLocalBoard(LocalBoardVO localBoardVo) {
		// TODO Auto-generated method stub
		String addLocalBoard_check = null;
		int check = 0;
		
		try {
			check = this.commonDao.insertData("areaBoard.insertLocalBoard", localBoardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}				
		return addLocalBoard_check;
	}

	@Override
	public List<Object> getMemberLocalBoard(int member_no) {
		// TODO Auto-generated method stub
		List<Object> LocalBoardVo = null;
		
		try {
			LocalBoardVo = this.commonDao.getListData("areaBoard.selectMemberLocalBoard", member_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return LocalBoardVo;
	}

	@Override
	public String modifyLocalBoard(LocalBoardVO localBoardVo) {
		// TODO Auto-generated method stub
		String modify = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("areaBoard.modifyAreaBoard", localBoardVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return modify;
	}

	@Override
	public String deleteLocalBoard(int board_no) {
		// TODO Auto-generated method stub
		String delete = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("areaBoard.deleteAreaBoard", board_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return delete;
	}

	@Override
	public Object getLocalBoard_no(int board_no) {
		// TODO Auto-generated method stub
		LocalBoardVO localBoardVo = null;
		
		try {
			localBoardVo = (LocalBoardVO) this.commonDao.getReadData("areaBoard.select_board_no", board_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return localBoardVo;
	}

	@Override
	public Map<String, Object> getLocalBoard_Paging(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map = this.commonDao.getPagingListData("areaBoard.getAreaBoard_web_count", "areaBoard.getAreaBoard_web", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return map;
	}

	@Override
	public Object getCategoryData() {
		// TODO Auto-generated method stub
		List<Object> result = null;
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> pMap = new HashMap<String, Object>();
		
		try {
			pMap.put("category", "1");
			result = this.commonDao.getListData("areaBoard.get_categoryData", pMap);
			rMap.put("category1", result);
			pMap.put("category", "2");
			result = this.commonDao.getListData("areaBoard.get_categoryData", pMap);
			rMap.put("category2", result);
			pMap.put("category", "3");
			result = this.commonDao.getListData("areaBoard.get_categoryData", pMap);
			rMap.put("category3", result);
			pMap.put("category", "4");
			result = this.commonDao.getListData("areaBoard.get_categoryData", pMap);
			rMap.put("category4", result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rMap;
	}



}
