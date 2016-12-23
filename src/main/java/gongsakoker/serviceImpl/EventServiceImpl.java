package gongsakoker.serviceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.EventService;

/**
* 설명 : 이벤트 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.11.18    권세윤    
*************************
*
*/

@Service("gongsakoker.EventService")
public class EventServiceImpl implements EventService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public List<Object> getListEvent() {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("event.event_list");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return lists;
	}

	@Override
	public List<Object> getListEvent_page(Map<String, Integer> map) {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("event.event_page", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lists;
	}
}
