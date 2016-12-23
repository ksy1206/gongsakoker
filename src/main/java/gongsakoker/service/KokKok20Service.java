package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.QaVO;
import gongsakoker.vo.ReviewVO;


public interface KokKok20Service {
	
	public List<Object> getRanking(Map<String, String> map);
	
	public Object getDetails(Map<String, Object> map);
	
	public String insert_QaQuesetion(QaVO qavo);
	
	public String insert_QaAnswer(QaVO qavo);
	
	public String update_QaQuestion(QaVO qavo);
	
	public String delete_QaQuestion(QaVO qavo);
	
	public List<Object> getList_Qa_quesetion(Map map);
	
	public List<Object> getList_QaReview(Map map);
	
	public List<Object> getList_QaReview_all_koker_no(Map map);
	
	public Object getQaReview(Map map);
	
	public String insert_Review(ReviewVO reviewVo);
	
	public String update_Review(Map map);
	
	public String delete_Review(Map map);
	
	public 	List<Object> getList_BookMaker(Map map);
	
	public String delete_BookMaker(Map map);
	
	public String insert_BookMaker(Map map);
	
	public Object getKoker_category(Map<String, Object> map);
	
	public List<Object> getCategory_code(Map map);
	
	public List<Object> getListClass_code(Map map);

	//박종현 핸드폰 id 가져오기 질문
	public String get_hpqregid(String koker_no);
	//박종현 핸드폰 종류 가져오기 질문
	public String get_hp_qkind(String koker_no);
	
	//박종현 핸드폰 id 가져오기 답변
	public String get_hparegid(String qa_no);
	//박종현 핸드폰 종류 가져오기 답변
	public String get_hp_akind(String qa_no);
}
