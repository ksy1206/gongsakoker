package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.BoardVO;

public interface AdvertiseService {
	
	public String insertAdvertise(BoardVO board);
	
	public List<Object> getListAdvertise(Map map);

}
