package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.BoardVO;

public interface CsService {

	public List<Object> getListCs();
	
	public List<Object> getListInquiry(Map map);
	
	public String insertInquiry(BoardVO board);
}
