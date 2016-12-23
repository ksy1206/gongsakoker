package gongsakoker.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.EstimateService;
import gongsakoker.vo.EstimateVO;

@Service("gongsakoker.EstimateService")
public class EstimateServiceImpl implements EstimateService {
	
	private final static Log logger = LogFactory.getLog(EstimateServiceImpl.class);
	@Resource(name="commonDao")
	private CommonDAO commonDao;
	
	@Override
	public List<Object> getList(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> allList = null;
    	
    	try {
			System.out.println("1");
    		allList = this.commonDao.getListData("estimate.selectAllList",pMap);
    		System.out.println("2");
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return allList;
	}

	@Override
	public String addEstimate(EstimateVO estimateVo) {
		// TODO Auto-generated method stub
		String addEstimate_check = null;
		String maxEst_no = null;
		
		try {
			System.out.println(estimateVo);
			this.commonDao.insertData("estimate.insertEstimate", estimateVo);
			
			maxEst_no = (String) this.commonDao.getReadData("estimate.MaxEst_no");
			
			System.out.println(maxEst_no);
			if(maxEst_no != null && maxEst_no != ""){
				estimateVo.setEst_no(maxEst_no);
				this.commonDao.insertData("estimate.insertEstimate_field", estimateVo);
			}else{
				
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return addEstimate_check;
	}


	@Override
	public List<Object> getSearchList(Map<String, Object> pMap) {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("estimate.getSearchList", pMap);
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}

	@Override
	public List<Object> getEstType02List(Map<String, Object> pMap) {
		List<Object> rList = null;
    	
    	try {
			
    		rList = this.commonDao.getListData("estimate.getEstType02List",pMap);
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return rList;	
	}

	@Override
	public List<Object> getMyList(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> myList = null;
    	
    	try {
			
    		myList = this.commonDao.getListData("estimate.getMyList",pMap);
		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return myList;
	}

	@Override
	public Object getEstimateDetails(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		EstimateVO estimateVo = null;
		
		try {
			estimateVo = (EstimateVO) this.commonDao.getReadData("estimate.getEstimateDetails", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return estimateVo;
	}

	@Override
	public String addSetEstimate(EstimateVO estimateVo) {
		// TODO Auto-generated method stub
		String addSetEstimate_check = null;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		estimateVo.setSetEst_insertDate(currentDate);
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> rMap = new HashMap<String, Object>();		
		map.put("member_no", estimateVo.getMember_no());		
		
		try {
			
			rMap = (Map<String, Object>) this.commonDao.getReadData("estimate.getKokor_info", map);
			String koker_name = (String) rMap.get("koker_name");
			String koker_no = rMap.get("koker_no").toString();
			estimateVo.setKoker_name(koker_name);
			estimateVo.setKoker_no(koker_no);
			
			this.commonDao.insertData("estimate.insertSetEstimate", estimateVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return addSetEstimate_check;
	}

	@Override
	public List<Object> getSetEstimateList(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> setEstimateList = null;
    	
    	try {
    		
    		setEstimateList = this.commonDao.getListData("estimate.setEstimateList",pMap);
    		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return setEstimateList;
	}

	@Override
	public String addSetEstimate(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		String addSetEstimate_check = null;
		
		try {
			this.commonDao.insertData("estimate.insertSetEst_no", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return addSetEstimate_check;
	}

	@Override
	public Map<String, Object> checkSetEstimate(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		String checkSetEstimate = null;
		EstimateVO estimateVo = null;
		Map<String, Object> rMap = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> checkMap = new HashMap<String, Object>();
		
		try {
			rMap = (Map<String, Object>) this.commonDao.getReadData("estimate.getKokor_info", pMap);
			String koker_no = rMap.get("koker_no").toString();
			pMap.put("koker_no", koker_no);
			
			checkMap = (Map<String, Object>) this.commonDao.getReadData("estimate.checkSetEstimate", pMap);
			System.out.println("123123"+checkMap.get("count_setEst_no").toString());
			if(checkMap.get("count_setEst_no").toString().equals("0")){
				checkSetEstimate = "n";
			} else {
				checkSetEstimate = "y";
				estimateVo = (EstimateVO) this.commonDao.getReadData("estimate.select_setEstimate_koker_no", pMap);
				map.put("estimateVo", estimateVo);
			}
			map.put("check", checkSetEstimate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}

	@Override
	public List<Object> select_allField() {
		// TODO Auto-generated method stub
		List<Object> field_list = null;
    	
    	try {
    		
    		field_list = this.commonDao.getListData("estimate.select_allField");
    		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return field_list;
	}

	@Override
	public List<Object> select_YandNField(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> select_YandNField = null;
    	
    	try {
    		
    		select_YandNField = this.commonDao.getListData("estimate.select_YandNField", pMap);
    		
		} catch (Exception e) {
			logger.debug(e.toString());
		}
    	
    	return select_YandNField;
	}

	@Override
	public String delete_setEstimate(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		String delete_setEstimate_check = null;
		
		try {
			this.commonDao.deleteData("estimate.delete_setEstimate", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return delete_setEstimate_check;
	}

	@Override
	public String delete_estimate(Map<String, Object> pMap) {
		// TODO Auto-generated method stub		
		String delete_setEstimate_check = null;
		
		try {
			this.commonDao.deleteData("estimate.koker_estimate_delete", pMap);
			
			this.commonDao.deleteData("estimate.koker_estimate_field_delete", pMap);
			
			this.commonDao.deleteData("estimate.koker_set_estimate_delete", pMap);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return delete_setEstimate_check;
	}

	@Override
	public List<Object> getList_search(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> search_list = null;
		
		try {
			search_list = this.commonDao.getListData("estimate.select_search_list", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return search_list;
	}

	@Override
	public List<Object> getMy_setEstimate(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		List<Object> mySetEstimateList = null;
		Map<String, Object> rMap = new HashMap<String, Object>();
		try {
			rMap = (Map<String, Object>) this.commonDao.getReadData("estimate.getKokor_info", pMap);
			String koker_no = rMap.get("koker_no").toString();
			pMap.put("koker_no", koker_no);
			if(pMap.get("est_state").equals("n")){
				mySetEstimateList = this.commonDao.getListData("estimate.getMy_setEstimate_n", pMap);
			} else {
				mySetEstimateList = this.commonDao.getListData("estimate.getMy_setEstimate_y", pMap);
			}
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return mySetEstimateList;
	}

}
