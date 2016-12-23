package gongsakoker.serviceImpl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.NoticeService;


/**
* 설명 : 공지 알림 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.11.18    권세윤    
*************************
*
*/

@Service("gongsakoker.noticeService")
public class NoticeServiceImpl implements NoticeService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	
	//�������� ����Ʈ ��������
	@Override
	public List<Object> getNoticeList() {
		// TODO Auto-generated method stub
		List<Object> noticeList = null;
		try {
			noticeList = (List<Object>) this.commonDao.getListData("notice.getNoticeList");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return noticeList;
	}
	
	
	
}
