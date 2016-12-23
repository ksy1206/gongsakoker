package gongsakoker.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.helper.util.bizlink.BizlinkResponseVO;
import gongsakoker.service.BizlinkService;




@Controller
@RequestMapping("/bizlink")
public class BizlinkController {
   
    Logger log = Logger.getLogger(this.getClass());
    @Resource(name = "gongsakoker.bizlinkService")
	private BizlinkService bizlinkService;
    
     //업체 웹 서버 URL 등록
     @RequestMapping(value="/reg_svr_url.do")
     public ModelAndView reg_svr_url() {
    	 ModelAndView mv = new ModelAndView();
    	 BizlinkResponseVO resVO = new BizlinkResponseVO();
    	 try {
			resVO = bizlinkService.postReg_svr_url();
			
		} catch (Exception e) {
			e.toString();
		}

    	 mv.setViewName("jsonView");
    	 mv.addObject("result", resVO.getRs());
		 return mv;
         
     }
     
   //가상번호 리스트 요청
     @RequestMapping(value="/get_vns.do")
     public ModelAndView get_vns() {
    	 ModelAndView mv = new ModelAndView();
			
    	 BizlinkResponseVO resVO = new BizlinkResponseVO();
    	 try {
			resVO = bizlinkService.postGet_vns();
			
		} catch (Exception e) {
			e.toString();
		}
    	
    	 mv.setViewName("jsonView");
    	 mv.addObject("result", resVO.getRs());
		 return mv;
    	 
     }
     
	 //가상번호 설정 요청
     @RequestMapping(value="/set_vn.do")
     public ModelAndView set_vn() {
    	 ModelAndView mv = new ModelAndView();
    	 BizlinkResponseVO resVO = new BizlinkResponseVO();
    	 try {
			resVO = bizlinkService.postSet_vn(resVO);
		} catch (Exception e) {
			e.toString();
		}
    	 mv.setViewName("jsonView");
    	 mv.addObject("result", resVO.getRs());
		 return mv;
     
     }
     
	 //전화걸기 시도시 임시가상번호 설정 요청
     @RequestMapping(value="/set_vn_temp.do")
     public ModelAndView set_vn_temp(HttpServletRequest req,HttpServletResponse res,@RequestParam Map<String, Object> pMap) {
    	 ModelAndView mv = new ModelAndView();
    	 BizlinkResponseVO resVO = new BizlinkResponseVO();
    	 
    	 String rn = req.getParameter("call_tel").toString();
    	 String koker_no = req.getParameter("koker_no").toString();
    	 resVO.setKoker_no(koker_no);
    	 
    	 resVO.setRn(rn);
    	 try {
			resVO = bizlinkService.postSet_vn_temp(resVO);
		} catch (Exception e) {
			e.toString();
		}
    	 mv.setViewName("jsonView");
    	 mv.addObject("vn", resVO.getVn());
		 return mv;
     
     }
   
   //실시간 cdr 전송 
     @RequestMapping(value="/cdr_recv.do")
     public ModelAndView cdr_recv(HttpServletRequest req,HttpServletResponse res) throws Exception {
    	
 		ModelAndView mv = new ModelAndView("bizlink/cdr_recv");
 			
    	 
    	 int rt = 0;
    	 Map<String,Object> pMap = new HashMap<String, Object>() ;
         String seq = req.getParameter("seq");
         String sdt = req.getParameter("sdt");
         String edt = req.getParameter("edt");
         String swidt = req.getParameter("swidt");
         String fromn = req.getParameter("fromn");
         String vn = req.getParameter("vn");
         String ton = req.getParameter("ton");
         String crid = req.getParameter("crid");
         String irid = req.getParameter("irid");
         String memo = URLDecoder.decode(req.getParameter("memo"), "utf-8");
         String memo2 = req.getParameter("memo2");
         String cause = req.getParameter("cause");
         String closed_from = req.getParameter("closed_from");
        
         
         
         pMap.put("seq", seq);
         pMap.put("sdt", sdt);
         pMap.put("edt", edt);
         pMap.put("swidt", swidt);
         pMap.put("fromn", fromn);
         pMap.put("vn", vn);
         pMap.put("ton", ton);
         pMap.put("crid", crid);
         pMap.put("irid", irid);
         pMap.put("memo", memo);
         pMap.put("memo2", memo2);
         pMap.put("cause", cause);
         pMap.put("closed_from", closed_from);
         
         
    
    	 try {
    		 rt = bizlinkService.insertCDR(pMap); //0504매핑방법 변경으로 인해 주석처리
//    		 rt = bizlinkService.insertCDR_temp(pMap); //문자는 콜로그가 안들어와서 사용불가

    	 } catch (Exception e) {
			e.toString();
		}
    	
    	 return mv;
     }
     
     
     
     //가상번호 초기화 요청
     @RequestMapping(value="/init_vns.do")
     public ModelAndView init_vns() {
    	 ModelAndView mv = new ModelAndView();
			
    	 BizlinkResponseVO resVO = new BizlinkResponseVO();
    	 try {
			resVO = bizlinkService.postGetInit_vns();
			
		} catch (Exception e) {
			e.toString();
		}
    	
    	 mv.setViewName("jsonView");
    	 mv.addObject("result", resVO.getRs());
		 return mv;
    	 
     }
  
}