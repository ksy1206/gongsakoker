package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.gcm.GcmSender;
import gongsakoker.service.KokKok20Service;
import gongsakoker.vo.MemberVO;
import gongsakoker.vo.QaVO;
import gongsakoker.vo.ReviewVO;

@Controller
@RequestMapping("/kokkok20")
public class KokKok20Controller {
	
	@Resource(name="gongsakoker.KokKok20Service")
	private KokKok20Service kokerService;
	
	private static final GcmSender sender = new GcmSender();
	
	//콕콕20 랭킹 리스트 불러오기 및 메인 페이지 이동
	@RequestMapping(value="kokkok20list.do")
	ModelAndView openKokkok20list(){
		Map<String, String> map = new HashMap<String, String>();
		map.put("class_code", "02");
		List<Object> lists = kokerService.getRanking(map);
		ModelAndView mav = new ModelAndView("kokkok20/kokkokMain");
		mav.addObject("ranking20", lists);
		mav.addObject("class_code", map.get("class_code"));
		return mav;
	}         
	
	//콕콕20 클래스 코드로 매뉴 선택시 리스트 불러오기
	@RequestMapping(value="kokkok20_class_code.do")
	ModelAndView koko20_class_code(@RequestParam(value="class_code") String class_code, @RequestParam(value="member_no") String member_no){
		Map<String, String> map = new HashMap<String, String>();
		map.put("class_code", class_code);
		map.put("member_no", member_no);
		List<Object> lists = kokerService.getRanking(map);
		ModelAndView mav = new ModelAndView("kokkok20/kokkok20List");
		mav.addObject("ranking20", lists);
		mav.addObject("class_code", class_code);
		return mav;
	}
	
	//업체 상세 페이지 이동
	@RequestMapping(value="kokkok20_details.do")
	ModelAndView kokkok20_details(@RequestParam(value="koker_no") int koker_no, @RequestParam(value="backCount") String backCount){
		List<Object> lists = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("koker_no", koker_no);
		MemberVO memberVo, memberVo_category;
		memberVo = (MemberVO) kokerService.getDetails(map);
		lists = kokerService.getList_BookMaker(map);
		memberVo_category = (MemberVO) kokerService.getKoker_category(map);
		ModelAndView mav = new ModelAndView("kokkok20/business_details");
		mav.addObject("memberVo", memberVo);
		mav.addObject("category", memberVo_category);
		mav.addObject("bookMark", lists);
		mav.addObject("backCount", backCount);
		return mav;
	}
	
	//카테고리 정보 불러오기
	@RequestMapping(value="/getBusinessKind_select.do")
	ModelAndView getBusinessKind_select(@RequestParam Map<String, Object> map){
		List<Object> listCategory = null;
		listCategory = kokerService.getCategory_code(map);
		List<Object> listClass_code = null;
		listClass_code = kokerService.getListClass_code(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("category", listCategory);
		mav.addObject("listClass_code", listClass_code);

		return mav;
	}
	
	//질문 페이지 이동
	@RequestMapping(value="question.do")
	ModelAndView question(@RequestParam(value="koker_no") int koker_no, @RequestParam(value="backCount") String backCount){
		Map<String, Integer> map = new HashMap<String, java.lang.Integer>();
		map.put("koker_no", koker_no);
		List<Object> lists = null;
		lists = kokerService.getList_Qa_quesetion(map); 
		
		ModelAndView mav = new ModelAndView("kokkok20/question");
		mav.addObject("qa_question_list", lists);
		mav.addObject("koker_no", koker_no);
		mav.addObject("backCount", backCount);
		return mav;
	}
	
	//답변 페이지 이동
	@RequestMapping(value="answer.do")
	ModelAndView answer(@RequestParam(value="koker_no") int koker_no, @RequestParam(value="backCount") String backCount){
		Map<String, Integer> map = new HashMap<String, java.lang.Integer>();
		map.put("koker_no", koker_no);
		List<Object> lists = null;
		lists = kokerService.getList_Qa_quesetion(map); 

		ModelAndView mav = new ModelAndView("kokkok20/answer");
		mav.addObject("qa_question_list", lists);
		mav.addObject("koker_no", koker_no);
		mav.addObject("backCount", backCount);
		return mav;
	}
	
	//질문 추가 메소드
	@RequestMapping(value="add_qaQuestion.do")
	ModelAndView addQuestion(QaVO qavo){
		kokerService.insert_QaQuesetion(qavo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		/* 질문 달릴 때 알림 보냄 */
		String koker_no = "" + qavo.getKoker_no();
		String regId = ( String ) kokerService.get_hpqregid( koker_no );
		String title = "공사콕커입니다.";
		String message = "질문이 등록되었습니다.";
		
		String hp_kind = ( String ) kokerService.get_hp_qkind( koker_no );
		System.out.println("핸드폰 종류 : "+ hp_kind);
		if(hp_kind.equals("I")) {
			sender.postSingleIosGCM( regId, title, "question", message );
		}else {
			sender.postSingleGCM( regId, title, "question", message );
		}
		
		//끝
		
		return mav;
	}
	
	//질문 수정 메소드
	@RequestMapping(value="modify_qaQuestion.do")
	ModelAndView modify_qaQuestion(QaVO qavo){
		kokerService.update_QaQuestion(qavo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
	//질문 삭제 메소드
	@RequestMapping(value="delete_qaQuestion.do")
	ModelAndView delete_qaQuestion(QaVO qavo){
		kokerService.delete_QaQuestion(qavo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
	//답변 등록 메소드
	@RequestMapping(value="add_answer.do")
	ModelAndView add_answer(QaVO qavo){
		kokerService.insert_QaAnswer(qavo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		/* 답변 달릴 때 알림 보냄 */
		String qa_question_no = "" + qavo.getQa_question_no();
		String regId = ( String ) kokerService.get_hparegid( qa_question_no );
		String title = "공사콕커입니다";
		String message = "문의 하신 내용에 답변이 등록되었습니다.";
		
		String hp_kind = ( String ) kokerService.get_hp_akind( qa_question_no );
		System.out.println("핸드폰 종류 : "+ hp_kind);
		if(hp_kind.equals("I")) {
			sender.postSingleIosGCM( regId, title, "answer", message );
		}else {
			sender.postSingleGCM( regId, title, "answer", message );
		}
		//끝
		
		return mav;
	}
	
	//리뷰 리스트
	@RequestMapping(value="select_review.do")
	ModelAndView select_review(@RequestParam Map<String, Object> map){
		List<Object> lists = null;
		ReviewVO reviewVo = null;
		if(map.get("member_no").equals("")){
			reviewVo = null;
		} else {
			reviewVo = (ReviewVO) this.kokerService.getQaReview(map);
		}
		Map<String, Object> rMap = new HashMap<String, Object>();
		lists = this.kokerService.getList_QaReview(map);
		rMap.put("reviewList", lists);
		rMap.put("reviewVo", reviewVo);
		System.out.println(reviewVo);
		rMap.put("koker_no", (map.get("koker_no")));
		rMap.put("member_no", (map.get("member_no")));
		ModelAndView mav = new ModelAndView();
		mav.addAllObjects(rMap);
		mav.setViewName("jsonView");
		return mav;
	}
	
	//전체 리뷰 리스트(koker_no로 검색)
	@RequestMapping(value="reviewMore.do")
	ModelAndView reviewMore(@RequestParam(value="koker_no") int koker_no){
		List<Object> lists = null;
		Map<String, java.lang.Integer> map = new HashMap<String, Integer>();
		map.put("koker_no", koker_no);
		lists = kokerService.getList_QaReview_all_koker_no(map);
		ModelAndView mav = new ModelAndView("kokkok20/review");
		mav.addObject("reviewLists", lists);
		mav.addObject("koker_no", koker_no);
		return mav;
	}
	
	//리뷰 등록
	@RequestMapping(value="review_Write.do")
	ModelAndView review_Write(ReviewVO reviewVo){
		kokerService.insert_Review(reviewVo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}

	//리뷰 수정
	@RequestMapping(value="review_Modify.do")
	ModelAndView review_Modify(@RequestParam Map<String, Object> map){
		kokerService.update_Review(map);
 		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
	//리뷰삭제
	@RequestMapping(value="review_Delete.do")
	ModelAndView review_Delete(@RequestParam Map<String, Object> map){
		kokerService.delete_Review(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;		
	}
	
	//@북마크 삭제
	@RequestMapping(value="deleteBookmark.do")
	ModelAndView deleteBookmark(@RequestParam Map<String, Object> map){
		kokerService.delete_BookMaker(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
	//@북마크 추가
	@RequestMapping(value="addBookmark.do")
	ModelAndView addBookmark(@RequestParam Map<String, Object> map){
		kokerService.insert_BookMaker(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
	//@북마크 추가
	@RequestMapping(value="detailMap.do")
	ModelAndView detailMap(@RequestParam(value="koker_no") int koker_no){
		List<Object> lists = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("koker_no", koker_no);
		
		MemberVO memberVo = (MemberVO) kokerService.getDetails(map);
		lists = kokerService.getList_BookMaker(map);
		
		ModelAndView mav = new ModelAndView("kokkok20/detail_map");
		mav.addObject("koker", memberVo);
		mav.addObject("bookMark", lists);
		
		return mav;
	}
}
