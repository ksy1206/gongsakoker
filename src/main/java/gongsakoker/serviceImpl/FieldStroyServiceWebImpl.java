package gongsakoker.serviceImpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.FieldStroyServiceWeb;

@Service("gongsakoker.FieldStoryServiceWeb")
public class FieldStroyServiceWebImpl implements FieldStroyServiceWeb {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public Map<String, Object> getFieldStoryWeb(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		Map<String, Object> fieldStory_list_web = null;
		
		try {
			fieldStory_list_web = this.commonDao.getPagingListData("fieldStory.fieldStory_listCount", "fieldStory.fieldStory_webList_data", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldStory_list_web;
	}

}
