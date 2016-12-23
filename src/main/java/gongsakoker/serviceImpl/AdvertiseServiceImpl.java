package gongsakoker.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.AdvertiseService;
import gongsakoker.vo.BoardVO;

/**
* 설명 : 광고문의 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.11.18    권세윤    
*************************
*
*/

@Service("gongsakoker.AdvertiseService")
public class AdvertiseServiceImpl implements AdvertiseService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public String insertAdvertise(BoardVO board) {
		// TODO Auto-generated method stub
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		board.setBoard_date(currentDate);
		board.setBoard_code("01");
		String add_advertise_check=null;
		int check=0;
		
			try {
				check = this.commonDao.insertData("advertise.insertAdvertise", board);
				
				if(check==0){
					add_advertise_check="N";
				} else {
					add_advertise_check="Y";
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		
		return add_advertise_check;
	}

	@Override
	public List<Object> getListAdvertise(Map map) {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("advertise.selectAdvertise", map);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lists;
	}
}
