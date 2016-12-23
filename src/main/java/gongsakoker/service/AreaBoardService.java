package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.LocalBoardVO;

public interface AreaBoardService {
	
	public List<Object> getLocalBoard(LocalBoardVO localBoardVo);
	
	public String addLocalBoard(LocalBoardVO localBoardVo);
	
	public List<Object> getMemberLocalBoard(int member_no);
	
	public String modifyLocalBoard(LocalBoardVO localBoardVo);
	
	public String deleteLocalBoard(int board_no);
	
	public Object getLocalBoard_no(int board_no);
	
	public Map<String, Object> getLocalBoard_Paging(Map<String, Object> pMap);
	
	public Object getCategoryData();

}
