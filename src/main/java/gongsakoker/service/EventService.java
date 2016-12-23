package gongsakoker.service;

import java.util.List;
import java.util.Map;

public interface EventService {
	
	public List<Object> getListEvent();
	
	public List<Object> getListEvent_page(Map<String, java.lang.Integer> map);

}
