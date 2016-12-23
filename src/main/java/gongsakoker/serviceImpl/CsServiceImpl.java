package gongsakoker.serviceImpl;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.CsService;
import gongsakoker.vo.BoardVO;


/**
* 설명 : 고객지원실 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.11.18    권세윤    
*************************
*
*/

@Service("gongsakoker.CsService")
public class CsServiceImpl implements CsService {
	
	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public List<Object> getListCs() {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("cs.selectCs");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lists;
	}

	@Override
	public List<Object> getListInquiry(Map map) {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("cs.selectInquiry", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lists;
	}

	@Override
	public String insertInquiry(BoardVO board) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		board.setBoard_date(currentDate);
		board.setBoard_code("02");
		
		String inquiry_addDb_check=null;
		int check=0;
		
		
		try {
			
			check = this.commonDao.insertData("cs.insertInquiry", board);
			
			if(check==0){
				inquiry_addDb_check = "N";
			} else {
				inquiry_addDb_check = "Y";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return inquiry_addDb_check;
	}

}
