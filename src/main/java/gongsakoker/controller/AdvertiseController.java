package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.service.AdvertiseService;

@Controller
@RequestMapping("/advertise")
public class AdvertiseController {

	@Resource(name="gongsakoker.AdvertiseService")
	private AdvertiseService advertiseService;
	
	//광고 문의 메인 이동
	@RequestMapping(value="advertise_main.do")
	ModelAndView advertise_main(@RequestParam(value="member_no") int member_no){
		List<Object> lists = null;
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("member_no", member_no);		
		lists = advertiseService.getListAdvertise(map);
		ModelAndView mav = new ModelAndView("advertise/ad_main");
		mav.addObject("advertise_list", lists);
		return mav;
	}
	
	//광고 문의 등록 이동
	@RequestMapping(value="move_addQuestion.do")
	ModelAndView move(){
		ModelAndView mav = new ModelAndView("advertise/addAdvertise");
		return mav;
	}
	
	//광고 문의 DB 등록
	@RequestMapping(value="addQuestion.do")
	ModelAndView addAdvertise(gongsakoker.vo.BoardVO board) throws BusinessException{
		advertiseService.insertAdvertise(board);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
}

