package gongsakoker.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller

public class MainController {
	

	//업체등록 메인 페이지 이동
	@RequestMapping(value="/main.do")
    ModelAndView add_company(){
    	ModelAndView mav = new ModelAndView("ver/ver_1");
    	return mav;
    }
   
}
