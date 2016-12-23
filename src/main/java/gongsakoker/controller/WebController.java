package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.service.AreaBoardService;
import gongsakoker.service.KokKok20Service;
import gongsakoker.vo.MemberVO;


@Controller
@RequestMapping(value="/web")
public class WebController {
	
	@Resource(name="gongsakoker.AreaBoardService")
	private AreaBoardService areaBoardService;
	@Resource(name="gongsakoker.KokKok20Service")
	private KokKok20Service kokerService;
	
	@RequestMapping(value="webMain.do")
	ModelAndView webMain(){
		ModelAndView mav = new ModelAndView("web/download");
		return mav;
	}
	@RequestMapping(value="web_details.do")
	ModelAndView web_details(@RequestParam Map<String, Object> pMap){
		MemberVO memberVo = null;
		//업체 정보 가져오기
		memberVo = (MemberVO) kokerService.getDetails(pMap);
		pMap.put("class_code", memberVo.getClass_code());
		//카테고리 정보 가져오기
		List<Object> listCategory = null;
		listCategory = kokerService.getCategory_code(pMap);
		List<Object> listClass_code = null;
		listClass_code = kokerService.getListClass_code(pMap);		
		
		ModelAndView mav = new ModelAndView("web/detail/web_details");
		mav.addObject("memberVo", memberVo);
		mav.addObject("category", listCategory);
		mav.addObject("listClass_code", listClass_code);
		return mav;
	}
	@RequestMapping(value="gongsakoker.do")
	ModelAndView gongsakoker(){
		ModelAndView mav = new ModelAndView("web/index");
		return mav;
	}
	
	@RequestMapping(value="koker_news.do")
	ModelAndView koker_news(){
		ModelAndView mav = new ModelAndView("web/koker_news");
		return mav;
	}
//	
//	//웹 지역 게시판 이동
//	@RequestMapping(value="local_board.do")
//	ModelAndView local_board(@RequestParam Map<String, Object> pMap){
//		ModelAndView mav = new ModelAndView("web/local_board");
//		mav.addObject("pageNum", pMap.get("pageNum"));
//		System.out.println(pMap);
//		mav.addObject("sido2", pMap.get("sido"));
//		mav.addObject("gugun2", pMap.get("gugun"));
//		mav.addObject("category2", pMap.get("category"));
//		return mav;
//	}
//	
//	@RequestMapping(value="search_areaBoard.do")
//	ModelAndView search_areaBoard(@RequestParam Map<String, Object> pMap){
//		Map<String, Object> resultMap = new HashMap<String, Object>();
//		String pageNum = pMap.get("pageNum").toString();
//		
//		pMap.put("page", pageNum);
//		pMap.put("rows", "5"); // 페이지당 몇개의 행을 보여줄 것인지
//		pMap.put("pageCnt", "5"); // 페이지를 몇 페이지로 나눌 것인지
//		resultMap = areaBoardService.getLocalBoard_Paging(pMap);
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("jsonView");
//		mav.addObject("list", resultMap);
//		mav.addObject("sido2", pMap.get("sido"));
//		mav.addObject("gugun2", pMap.get("gugun"));
//		mav.addObject("category2", pMap.get("category"));
//		return mav;
//	}
	
	//웹 지역 게시판 상세 페이지 이동
//	@RequestMapping(value="local_board_details.do")
//	public ModelAndView local_board_details(@RequestParam(value="board_no") int board_no){
//		LocalBoardVO localBoardVo = null;
//		localBoardVo = (LocalBoardVO) areaBoardService.getLocalBoard_no(board_no);
//		ModelAndView mav = new ModelAndView("web/local_board_details");
//		mav.addObject("localBoardVo", localBoardVo);
//		return mav;
//	}
		
	
}
