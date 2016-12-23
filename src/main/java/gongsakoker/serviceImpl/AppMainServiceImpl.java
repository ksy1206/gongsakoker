package gongsakoker.serviceImpl;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import gongsakoker.helper.util.FormatHelper;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.AppMainService;
import gongsakoker.vo.MemberVO;
import net.sf.json.util.NewBeanInstanceStrategy;

/**
 * 설명: 메인화면
 *
 ************************************************
 * DATE AUTHOR DESCRIPTION ----------------------------------------------
 * 2015.12.02 박정후 Initial Release
 ************************************************
 *
 */

@Service("gongsakoker.appMainService")
public class AppMainServiceImpl implements AppMainService {
	private final static Log logger = LogFactory.getLog(AppMainServiceImpl.class);

	@Resource(name = "commonDao")
	private CommonDAO commonDao;

	@Override
	public int updatePush_yn(Map<String, Object> pMap) {
		int result = 0;

		try {
			result = this.commonDao.updateData("appMain.updatePush_yn", pMap);
		} catch (Exception e) {
			logger.debug(e.toString());
		}

		return result;
	}

	@Override
	public String getPush_yn(Map<String, Object> pMap) {
		String push_yn = "";

		try {
			push_yn = (String) this.commonDao.getReadData("appMain.getPush_yn", pMap);
		} catch (Exception e) {
			logger.debug(e.toString());
		}
		return push_yn;
	}

	@Override
	public String getChargeCountDown(Map<String, Object> pMap) {
		String spare_time = "";
		try {
			pMap.put("koker_no", this.commonDao.getReadData("member.getKoker_no", pMap).toString());
			spare_time = (String) this.commonDao.getReadData("appMain.getChargeCountDown", pMap);

			spare_time = FormatHelper.chgSecToDHM(spare_time);

		} catch (Exception e) {
			logger.debug(e.toString());
		}

		return spare_time;
	}

	public void updatehp_reg_id(Map<String, Object> rMap) {

		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("member.update_hpregid", rMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	@Override
	public void updateios_reg_id(Map<String, Object> rMap) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.updateData("member.update_ioshpregid", rMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Object> selectKokerList(Map map) {
		
		List<Object> kokerList = null;

		// TODO Auto-generated method stub
		try {
			kokerList = this.commonDao.getListData("appMain.selectKokerList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return kokerList;
	}

	@Override
	public List<Object> selectKokerList03(Map map) {
		
		List<Object> kokerList = null;

		// TODO Auto-generated method stub
		try {
			kokerList = this.commonDao.getListData("appMain.selectKokerList03", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return kokerList;
		
	}

	@Override
	public List<Object> selectMapList(Map map) {
		
		List<Object> mapList = null;

		// TODO Auto-generated method stub
		try {
			mapList = this.commonDao.getListData("appMain.selectMapList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapList;
	}

	//카테고리 리스트
	@Override
	public List<Object> categoryList(String class_code) {
		List<Object> categoryList = null;

		// TODO Auto-generated method stub
		try {
			categoryList = this.commonDao.getListData("appMain.categoryList", class_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return categoryList;
	}
	
	

}
