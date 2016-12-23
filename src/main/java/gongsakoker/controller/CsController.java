package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.service.CsService;

@Controller
@RequestMapping("/cs")
public class CsController {
	
	@Resource(name="gongsakoker.CsService")
	private CsService csService;
	
	//고객지원실 메인 이동
	@RequestMapping(value="cs_main.do")
	ModelAndView cs_main(){
		ModelAndView mav = new ModelAndView("cs/cs_main");

		return mav;
	}
	
	//고객지원실 자주묻는질문 이동	
	@RequestMapping(value="cs_FAQ_list.do")
	ModelAndView question_list(){
		List<Object> lists = null;
		lists = csService.getListCs();
		ModelAndView mav = new ModelAndView("cs/question_list");
		mav.addObject("cs_list", lists);
		return mav;
	}

	//고객지원실 1:1문의 리스트 이동
	@RequestMapping(value="inquiry_main.do")
	ModelAndView inquiry_main(@RequestParam(value="member_no") int member_no){
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("member_no", member_no);
		List<Object> lists = null;
		lists = csService.getListInquiry(map);
		ModelAndView mav = new ModelAndView("cs/inquiry_main");
		System.out.println(lists);
		mav.addObject("cs_inquiry", lists);
		return mav;		
	}
	
	//고객지원실 1:1문의 추가 페이지 이동
	@RequestMapping(value="addInquiry.do")
	ModelAndView addInquiry(){
		ModelAndView mav = new ModelAndView("cs/addInquiry");
		return mav;
	}
	
	//고객지원실 1:1 문의 DB등록
	@RequestMapping(value="inquiry_addDb.do")
	ModelAndView inquiry_addDb(gongsakoker.vo.BoardVO board){
		csService.insertInquiry(board);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
}
