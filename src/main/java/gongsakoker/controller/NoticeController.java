package gongsakoker.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="gongsakoker.noticeService")
	private NoticeService noticeService;
	
	//공지사항 메인 이동
	@RequestMapping(value="noticelist.do")
	ModelAndView noticelist(){
		List<Object> lists = noticeService.getNoticeList();
		ModelAndView mav = new ModelAndView("notice/noticeList");
		mav.addObject("notice_list", lists);
		return mav;
	}

}
