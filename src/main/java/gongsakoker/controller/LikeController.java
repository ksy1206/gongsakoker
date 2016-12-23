package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam ;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.service.LikeService;
import gongsakoker.vo.MemberVO;




@Controller
@RequestMapping("/like" )
public class LikeController {
     
     Logger log = Logger.getLogger(this.getClass());
     
     @Resource(name="gongsakoker.likeService")
    private LikeService likeService;

     //나의콕 페이지로딩
    @RequestMapping(value= "/likeList.do")
    public ModelAndView likeList(HttpServletRequest req,
            HttpServletResponse res,HttpSession session) {
    	
    	  
       
    Map<String, Object> sessionData = null;
    Map<String, Object> pMap = new HashMap<String, Object>();	
    
    MemberVO memberVO = null;
    String member_no="";
   
    if (session.getAttribute("sessionData") != null) {
        sessionData = (Map)session.getAttribute("sessionData");
        memberVO = (MemberVO)sessionData.get("memberInfo");
        member_no = memberVO.getMember_no();
        pMap.put("member_no",member_no);
    } else {
    	 member_no ="";
         pMap.put("member_no",member_no);
        session.removeAttribute("sessionData");
    }
    
    List<Object> likeList = likeService.getLikeList(pMap);
     ModelAndView mv = new ModelAndView("/like/likeList");
     mv.addObject("likeList", likeList);
     mv.addObject("dataCnt", likeList.size());
  
     return mv;
    }
   
   
     

     //나의콕 페이지로딩
    @RequestMapping(value= "/getLikeList.do")
    public ModelAndView getLikeList(HttpServletRequest req,HttpServletResponse res, @RequestParam Map<String, Object> pMap) throws BusinessException {
           
      ModelAndView output = new ModelAndView();
      Map<String, Object> rMap = new HashMap<String, Object>();
        
      try{  
         List<Object> likeList  = this. likeService.getLikeList(pMap);
          rMap.put("likeList", likeList);
         
          } catch (Exception e){
                 throw new BusinessException( e.toString());
         }

         output.addAllObjects( rMap);
         output.setViewName( "jsonView");
     
         return output;
     
    }
    
    //나의콕 등록
    @RequestMapping(value= "/insertBookMark.do")
    public ModelAndView insertBookMark(HttpServletRequest req,HttpServletResponse res, @RequestParam Map<String, Object> pMap) throws BusinessException {
           
      ModelAndView output = new ModelAndView();
      Map<String, Object> rMap = new HashMap<String, Object>();
      int result = 0;
      try{  
         result  = this.likeService.insertBookMark(pMap);
         rMap.put("result_code", result);
         
          } catch (Exception e){
        	  throw new BusinessException( e.toString());
         }

         output.addAllObjects( rMap);
         output.setViewName( "jsonView");
     
         return output;
     
    }
    
    
    //나의콕 제거
    @RequestMapping(value= "/deleteBookMark.do")
    public ModelAndView deleteBookMark(HttpServletRequest req,HttpServletResponse res, @RequestParam Map<String, Object> pMap) throws BusinessException {
           
      ModelAndView output = new ModelAndView();
      Map<String, Object> rMap = new HashMap<String, Object>();
      int result = 0;
      try{  
         result  = this.likeService.deleteBookMark(pMap);
         rMap.put("result_code", result);
         
          } catch (Exception e){
        	  throw new BusinessException( e.toString());
         }

         output.addAllObjects( rMap);
         output.setViewName( "jsonView");
     
         return output;
     
    }
   
}
