package gongsakoker.serviceImpl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.KokKok20Service;
import gongsakoker.vo.MemberVO;
import gongsakoker.vo.QaVO;
import gongsakoker.vo.ReviewVO;

/**
* 설명 : 콕콕20(랭킹) 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.11.18    권세윤    
*************************
*
*/

@Service("gongsakoker.KokKok20Service")
public class KokKok20ServiceImpl implements KokKok20Service {

	@Resource(name="commonDao")
	private CommonDAO commonDao;

	@Override
	public List<Object> getRanking(Map<String, String> map) {
		// TODO Auto-generated method stub
		List<Object> ranking20 = null;				
		try {			

//			this.commonDao.insertData("kokkok20.rankingReset", null);			

			ranking20 = this.commonDao.getListData("kokkok20.getRanking20", map);
			Iterator<Object> it = ranking20.iterator();

//				while(it.hasNext()){
//					Map oMap = new HashMap();
//					oMap = (Map)it.next();				
//					String logo_path = (String) oMap.get("logo_path");
//					if(logo_path != null){
//					logo_path = logo_path.substring(logo_path.lastIndexOf("/")+1);
//					logo_path = logo_path.substring(logo_path.lastIndexOf("\\")+1);
//					oMap.put("logo_path", logo_path);
//					}
//				} 
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return ranking20;
	}

	@Override
	public Object getDetails(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO membervo = null;		
		try {
			membervo = (MemberVO) this.commonDao.getReadData("kokkok20.getBusiness_details", map);

//			if(membervo.getLogo_path() != null){
//				String file_path=membervo.getLogo_path();
//				file_path = file_path.substring(file_path.lastIndexOf("/")+1);
//				file_path = file_path.substring(file_path.lastIndexOf("\\")+1);
//				membervo.setLogo_path(file_path);
//				membervo.setFile01_path(file_path);
//				membervo.setFile02_path(file_path);
//				membervo.setFile03_path(file_path);
//			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return membervo;
	}

	@Override
	public String insert_QaQuesetion(QaVO qavo) {
		// TODO Auto-generated method stub
		String insert_QaQuestion_check = null;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		qavo.setQa_date(currentDate);
		int check = 0;
		
		try {
			check = this.commonDao.insertData("qa.insertQa", qavo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return insert_QaQuestion_check;
	}
	
	@Override
	public String insert_QaAnswer(QaVO qavo) {
		// TODO Auto-generated method stub
		String insert_QaAnswer_check = null;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		qavo.setQa_date(currentDate);
		int check = 0;
		
		try {
			check = this.commonDao.insertData("qa.insertQaAnswer", qavo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return insert_QaAnswer_check;
	}

	@Override
	public String delete_QaQuestion(QaVO qavo) {
		// TODO Auto-generated method stub
		String delete_QaQuestion_check = null;
		int check = 0;
		
		try {
			check = this.commonDao.deleteData("qa.deleteQa", qavo);
			check = this.commonDao.deleteData("qa.deleteQaAnswer", qavo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return delete_QaQuestion_check;
	}

	@Override
	public List<Object> getList_Qa_quesetion(Map map) {
		// TODO Auto-generated method stub
		List<Object> questionList = null;
		
		try {
			questionList = this.commonDao.getListData("qa.selectQuestionAll", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return questionList;
	}

	@Override
	public String update_QaQuestion(QaVO qavo) {
		// TODO Auto-generated method stub
		String update_QaQuestion = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("qa.update_QaQuestion", qavo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return update_QaQuestion;
	}

	@Override
	public List<Object> getList_QaReview(Map map) {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		try {
			lists = this.commonDao.getListData("kokkok20.selectReview", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public List<Object> getList_QaReview_all_koker_no(Map map) {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("kokkok20.selectReview_All", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lists;
	}

	@Override
	public Object getQaReview(Map map) {
		// TODO Auto-generated method stub
		ReviewVO reviewVo = null;
		
		try {
			reviewVo = (ReviewVO) this.commonDao.getReadData("kokkok20.selectReviewVo", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return reviewVo;
	}

	@Override
	public String insert_Review(ReviewVO reviewVo) {
		// TODO Auto-generated method stub
		String insert_Review_check = null;
		String currentDate = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date());
		reviewVo.setInsert_date(currentDate);
		int check = 0;
		
		try {
			check = this.commonDao.insertData("kokkok20.insertReview", reviewVo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return insert_Review_check;
	}

	@Override
	public String update_Review(Map map) {
		// TODO Auto-generated method stub
		String update_review = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("kokkok20.updateReview", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return update_review;
	}

	@Override
	public String delete_Review(Map map) {
		// TODO Auto-generated method stub
		String delete_review = null;		
		int check = 0;
		
		try {
			check = this.commonDao.deleteData("kokkok20.deleteReview", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return delete_review;
	}

	@Override
	public List<Object> getList_BookMaker(Map map) {
		// TODO Auto-generated method stub
		List<Object> lists = null;
		
		try {
			lists = this.commonDao.getListData("kokkok20.selectBookMaker", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return lists;
	}

	@Override
	public String delete_BookMaker(Map map) {
		// TODO Auto-generated method stub
		String delete_bookmaker_check = null;
		int check = 0;
		
		try {
			check = this.commonDao.deleteData("kokkok20.deleteBookMaker", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return delete_bookmaker_check;
	}

	@Override
	public String insert_BookMaker(Map map) {
		// TODO Auto-generated method stub
		String insert_bookmaker_check = null;
		int check = 0;
		
		try {
			check = this.commonDao.insertData("kokkok20.insertBookMaker", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return insert_bookmaker_check;
	}

	@Override
	public Object getKoker_category(Map<String, Object> map) {
		// TODO Auto-generated method stub
		MemberVO membervo = null;
		
		try {
			membervo = (MemberVO) this.commonDao.getReadData("kokkok20.selectCategory", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return membervo;
	}
	
	/*
	 * 박종현 핸드폰 id 가져오기
	 * */
	@Override
	public String get_hpqregid(String koker_no) {
		// TODO Auto-generated method stub
		String hp_reg_id = "";
		try {
			hp_reg_id = (String) this.commonDao.getReadData("kokkok20.get_qhq_reg_id", koker_no);
			System.out.println("hp_reg_id = " + hp_reg_id);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return hp_reg_id;
	}
	//박종현 핸드폰 종류 가져오기 질문
	public String get_hp_qkind(String koker_no){
		String result = null;
		try {
			result = (String) this.commonDao.getReadData("kokkok20.get_qhq_hp_kind", koker_no);
		} catch (Exception e) {

		}
		return result;
	}
	
	
	/*
	 * 박종현 핸드폰 id 가져오기
	 * */
	@Override
	public String get_hparegid(String qa_no) {
		// TODO Auto-generated method stub
		String hp_reg_id = "";
		try {
			hp_reg_id = (String) this.commonDao.getReadData("kokkok20.get_aha_reg_id", qa_no);
			System.out.println("hp_reg_id = " + hp_reg_id);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return hp_reg_id;
	}
	//박종현 핸드폰 종류 가져오기 답변
	public String get_hp_akind(String qa_no) {
		String result = null;
		try {
			result = (String) this.commonDao.getReadData("kokkok20.get_aha_hp_kind", qa_no);
		} catch (Exception e) {

		}
		return result;
	}
	

	@Override
	public List<Object> getCategory_code(Map map) {
		// TODO Auto-generated method stub
		List<Object> list = null;
		
		try {
			list = (List<Object>) this.commonDao.getListData("kokkok20.getClass_code", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Object> getListClass_code(Map map) {
		// TODO Auto-generated method stub
		List<Object> data = null;
		
		try {
			data = this.commonDao.getListData("kokkok20.getListClass_code", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return data;
	}


}
