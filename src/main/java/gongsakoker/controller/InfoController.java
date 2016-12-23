package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.service.MemberService;

@Controller
@RequestMapping(value="/info" )
public class InfoController {
     
     Logger log = Logger.getLogger(this.getClass());

    @Resource(name="gongsakoker.memberService")
    private MemberService memberService;
     
    @RequestMapping(value= "/infoMng.do")
    public ModelAndView infoMng() {
     ModelAndView mv = new ModelAndView( "/info/infoMng");
     return mv;
     
    }
    
    
   
   
}
