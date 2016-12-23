package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.service.KokKok20Service;
import gongsakoker.service.MemberService;
import gongsakoker.service.SearchService;
import gongsakoker.vo.MemberVO;

@Controller
@RequestMapping(value = "/search")
public class SearchController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "gongsakoker.searchService")
	private SearchService searchService;
	@Resource(name = "gongsakoker.memberService")
	private MemberService memberService;
	@Resource(name="gongsakoker.KokKok20Service")
	private KokKok20Service kokerService;
	
    @RequestMapping(value= "/search.do")
    public ModelAndView search() {
     ModelAndView mv = new ModelAndView( "/appMain/search");
     
     
     return mv;
     
    }
    
    @RequestMapping(value= "/searchList.do")
    public ModelAndView searchList() {
     ModelAndView mv = new ModelAndView( "/appMain/searchList");
     
     return mv;
     
    }
    
    //검색리스트조회
    @RequestMapping(value= "/getSearchList.do")
    public ModelAndView getSearchList(HttpServletRequest req,HttpServletResponse res) {
     ModelAndView mv = new ModelAndView( "/appMain/searchList");
     HttpSession session = req.getSession(true);
     Map<String, Object> sessionData = null;
     Map<String, Object> pMap = new HashMap<String, Object>();
     MemberVO memberVO = null;
     
     if (session.getAttribute("sessionData") != null) {
         sessionData = (Map)session.getAttribute("sessionData");
         memberVO = (MemberVO)sessionData.get("memberInfo");
         pMap.put("member_no",memberVO.getMember_no());
        
     }else{
    	 pMap.put("member_no","0");
     }
     
    
     String flag = req.getParameter("flag").toString();
     pMap.put("flag",req.getParameter("flag").toString());
     	
     if(flag.equals("searchList")){
    	 pMap.put("search",req.getParameter("search").toString());
     }else{
    	 pMap.put("class_code",req.getParameter("class_code").toString());
    	 pMap.put("category",req.getParameter("category").toString());
    	 pMap.put("gugun",req.getParameter("gugun").toString());
    	 pMap.put("sido",req.getParameter("sido").toString());
     }
     
     List<Object> searchList = searchService.getSearchList(pMap);
     
    
      mv.addObject("searchList", searchList);
      mv.addObject("dataCnt", searchList.size());
     
     return mv;
     
    }
    //카테고리종류조회
    @RequestMapping(value= "/getCategory.do")
    public ModelAndView getCategory(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) {
     ModelAndView mv = new ModelAndView( "/appMain/search");
     pMap.put("class_code",req.getParameter("class_code").toString());
     
     List<Object> categoryList = memberService.getBusinessKind(pMap);
     List<Object> areaList = memberService.getZip_area();
     List<Object> cityList = memberService.getZip_city();
     mv.addObject("categoryList", categoryList);
     mv.addObject("areaList", areaList);
     mv.addObject("cityList", cityList);
     mv.addObject("dataCnt", categoryList.size());
     
     return mv;
     
    }


  //카테고리 정보 불러오기
  	@RequestMapping(value="/getCategoryList.do")
  	ModelAndView getCategoryList(@RequestParam Map<String, Object> pMap){
  		List<Object> caList = null;
  		caList = kokerService.getCategory_code(pMap);
  		List<Object> codeList = null;
  		codeList = kokerService.getListClass_code(pMap);
		
		
  		ModelAndView mav = new ModelAndView();
  		mav.setViewName("jsonView");
  		mav.addObject("caList", caList);
  		mav.addObject("codeList", codeList);
  		return mav;
  	}


    //검색화면 로딩(WEB)
    @RequestMapping(value= "/web_search.do")
    public ModelAndView web_search() {
     ModelAndView mv = new ModelAndView( "/web/search/web_search");
     
     
     return mv;
     
    }
    
    
    //검색리스트조회(WEB)
    @RequestMapping(value= "/getSearchList_web.do")
    public ModelAndView getSearchList_web(HttpServletRequest req,HttpServletResponse res) {
     ModelAndView mv = new ModelAndView( "/web/search/web_search");
     HttpSession session = req.getSession(true);
     Map<String, Object> sessionData = null;
     Map<String, Object> pMap = new HashMap<String, Object>();
     MemberVO memberVO = null;
     
     if (session.getAttribute("sessionData") != null) {
         sessionData = (Map)session.getAttribute("sessionData");
         memberVO = (MemberVO)sessionData.get("memberInfo");
         pMap.put("member_no",memberVO.getMember_no());
        
     }else{
    	 pMap.put("member_no","0");
     }
     	
     	 pMap.put("flag",req.getParameter("flag").toString());
    	 pMap.put("search",req.getParameter("search").toString());
    	 pMap.put("class_code",req.getParameter("class_code").toString());
    	 
    	 String flag = req.getParameter("flag").toString();
    	 //카테고리 가공
    	 String str = "1=1";
    	
    	 if(flag.equals("web_detail")||flag.equals("web_order")){
    		 
    		 String category = req.getParameter("category").toString();
        	 String gugun = req.getParameter("gugun").toString();
        	 String sido = req.getParameter("sido").toString();
        	 String order = req.getParameter("order").toString();
        	 
    		 if(!category.equals("")){
//    	 			category  = category.replace(","," ");
    	 			String[] ca = category.split(",");
    	 			for(int i = 0 ;i<ca.length;i++){
    	 				if(i==0){
    	 					str = "c." + ca[i] + " = 'y'";
    	 				}else{
    	 					str = str + " or c." + ca[i] + " = 'y'";
    	 				}
    	 			}	
    	 		}
    	 		pMap.put("category",str);
    	 		pMap.put("gugun",gugun);
    	 		pMap.put("sido",sido);
    	 		pMap.put("order",order);

	 			mv.addObject("category", req.getParameter("category").toString());
	 			mv.addObject("gugun", req.getParameter("gugun").toString());
	 			mv.addObject("sido", req.getParameter("sido").toString());
    	 }
    	 		
    	 List<Object> searchList = searchService.getSearchList(pMap);
     
      
	      mv.addObject("searchList", searchList);
	      mv.addObject("dataCnt", searchList.size());
	      mv.addObject("class_code", req.getParameter("class_code").toString());
	      mv.addObject("search", req.getParameter("search").toString());
     
      
	      return mv;
     
    }

}
