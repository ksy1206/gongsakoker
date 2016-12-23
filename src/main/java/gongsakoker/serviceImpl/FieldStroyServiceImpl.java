package gongsakoker.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.FieldStroyService;
import gongsakoker.vo.FieldStoryVO;
/**
* 설명 : 현장스토리
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2016.02.15    권세윤    
*************************
*
*/
@Service("gongsakoker.FieldStroyService")
public class FieldStroyServiceImpl implements FieldStroyService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;

	//현장스토리 list불러오기
	@Override
	public List<Object> getFieldStory(FieldStoryVO fieldStoryVo) {
		// TODO Auto-generated method stub
		List<Object> fieldStory_list = null;
		
		try {
			fieldStory_list = this.commonDao.getListData("fieldStory.getFieldStory", fieldStoryVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldStory_list;
	}

	//현장스토리 DB등록
	@Override
	public String addFieldStory(FieldStoryVO fieldStoryVo) {
		// TODO Auto-generated method stub
		String addFieldStory = null;
		int check = 0;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		fieldStoryVo.setInsertDate(currentDate);
		
		try {
			check = this.commonDao.insertData("fieldStory.insertFieldStory", fieldStoryVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return addFieldStory;
	}

	//현장스토리 상세페이지 fs_no
	@Override
	public Object getFieldStory_fs_no(Map<String, Object> map) {
		// TODO Auto-generated method stub
		FieldStoryVO fieldStoryVo = null;
		
		try {
			fieldStoryVo = (FieldStoryVO) this.commonDao.getReadData("fieldStory.fieldStoryVo_select", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldStoryVo;
	}

	//현장스토리 댓글 불러오기
	@Override
	public List<Object> getFieldStory_answer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> fieldStoryAnswer_list = null;
		
		try {
			fieldStoryAnswer_list = this.commonDao.getListData("fieldStory.fieldStory_answer_list", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldStoryAnswer_list;
	}

	//현장스토리 댓글 등록하기
	@Override
	public String addFieldStory_answer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String fieldStory_answer = null;
		int check = 0;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		map.put("ans_insertDate", currentDate);
		
		try {
			check = this.commonDao.insertData("fieldStory.fieldStory_answer", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldStory_answer;
	}

	//현장스토리 댓글 수정하기
	@Override
	public String updateFieldStory_answer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String updateFieldStory_answer = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("fieldStory.updateFieldStory_answer", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return updateFieldStory_answer;
	}

	//현장스토리 댓글 삭제하기
	@Override
	public String deleteFieldStory_answer(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String deleteFieldStory_answer = null;
		int check = 0;
		
		try {
			check = this.commonDao.deleteData("fieldStory.deleteFieldStory_delete", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return deleteFieldStory_answer;
	}

	//현장스토리 추천 등록
	@Override
	public Object add_recommendFieldStory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> rMap = new HashMap<String, Object>();
		String recommend_check = null;
		int check = 0;
		int count = 0;
		
		try {
			check = (Integer) this.commonDao.getReadData("fieldStory.check_fieldStory_recommend", map);
			
			if(check == 0){
				recommend_check = "y";
				this.commonDao.insertData("fieldStory.insert_fieldStory_recommend", map);
			} else {
				recommend_check = "n";
				this.commonDao.deleteData("fieldStory.delete_fieldStory_recommend", map);
			}
			
			count = (Integer) this.commonDao.getReadData("fieldStory.count_fieldStory_recommend", map);
			
			rMap.put("recommend_check", recommend_check);
			rMap.put("count", count);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rMap;
	}
	
	@Override
	public Object check_recommendFieldStory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> rMap = new HashMap<String, Object>();
		String recommend_check = null;
		int check = 0;
		
		try {
			check = (Integer) this.commonDao.getReadData("fieldStory.check_fieldStory_recommend", map);
			
			if(check == 0){
				recommend_check = "y";
			} else {
				recommend_check = "n";
			}			
			rMap.put("recommend_check", recommend_check);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return rMap;
	}

	//현장스토리 추천 count
	@Override
	public int count_recommendFieldStory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int recommend_count = 0;
		
		try {
			recommend_count = (Integer) this.commonDao.getReadData("fieldStory.count_fieldStory_recommend", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return recommend_count;
	}

	@Override
	public List<Object> get_MyFieldStory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<Object> myFieldStory_list = null;
		
		try {
			myFieldStory_list = this.commonDao.getListData("fieldStory.get_myFieldStory", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return myFieldStory_list;
	}

	@Override
	public String updateFieldStory(FieldStoryVO fieldStoryVo) {
		// TODO Auto-generated method stub
		String updateFieldStory = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("fieldStory.updateFieldStory", fieldStoryVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return updateFieldStory;
	}

	@Override
	public String deleteFieldStory(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String deleteFieldStory = null;
		int check = 0;
		
		try {
			check = this.commonDao.deleteData("fieldStory.deleteFieldStory", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return deleteFieldStory;
	}

	@Override
	public List<Object> get_fieldStory_notice_list() {
		// TODO Auto-generated method stub
		List<Object> myFieldStory_list = null;
		
		try {
			myFieldStory_list = this.commonDao.getListData("fieldStory.get_fieldStory_notice_list");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return myFieldStory_list;
	}

	@Override
	public String add_fieldStory_singo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		String add_fieldStory_singo = null;
		int check = 0;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		map.put("report_insert_date", currentDate);
		try {
			check = this.commonDao.insertData("fieldStory.insert_fieldStory_singo", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return add_fieldStory_singo;
	}

	@Override
	public int delImgFile(Map<String, Object> pMap) {
		int result = 0;
		try {
			result = this.commonDao.updateData("fieldStory.delImgFile", pMap);
		} catch (Exception e) {
			e.toString();
		}
		return result;
	}

}
