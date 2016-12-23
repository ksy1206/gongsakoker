package gongsakoker.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.service.AddCompanyService;

@Controller
@RequestMapping(value="/addController")
public class AddCompanyController {
	
	@Resource(name="gongsakoker.AddCompanyService")
	private AddCompanyService addCompanyService;
	
	
	//업체등록 메인 페이지 이동
	@RequestMapping(value="/add_company.do")
    ModelAndView add_company(){
    	ModelAndView mav = new ModelAndView("add_company/main");
    	return mav;
    }
    
	//디비에 업체등록 메소드
    @RequestMapping(value="/addCompanyDb.do")
    ModelAndView add_companyDb(gongsakoker.vo.AddCompanyVO company){
    	
    	addCompanyService.insertAddCompany(company);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //업체등록 완료 페이지 이동
    @RequestMapping(value="/add_company_complete.do")
    ModelAndView complete(){
    	ModelAndView mav = new ModelAndView("add_company/complete");
    	return mav;
    }

}
