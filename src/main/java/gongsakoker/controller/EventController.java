package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.service.EventService;

@Controller
@RequestMapping("/event")
public class EventController {

	@Resource(name="gongsakoker.EventService")
	private EventService eventService;
	
	//이벤트 메인 페이지 이동
	@RequestMapping(value="eventlist.do")
	ModelAndView eventlist(){
		List<Object> lists = null;
		lists = eventService.getListEvent();
		ModelAndView mav = new ModelAndView("event/event_list");
		mav.addObject("event_list", lists);
		return mav;
	}
	
	//이벤트 상세 페이지 이동
	@RequestMapping(value="event_movePage.do")
	ModelAndView event_movePage(@RequestParam(value="event_no") int event_no){
		List<Object> lists = null;
		Map<String, java.lang.Integer> map = new HashMap<String, java.lang.Integer>();
		map.put("event_no", event_no);
		lists = eventService.getListEvent_page(map);
		ModelAndView mav = new ModelAndView("event/event_page");
		mav.addObject("event_page", lists);
		return mav;
	}
	
	//이벤트 상세 페이지2 이동
	@RequestMapping(value="event_movePage2.do")
	ModelAndView event_movePage2(){		
		ModelAndView mav = new ModelAndView("event/event_page2");
		return mav;
	}
	
}
