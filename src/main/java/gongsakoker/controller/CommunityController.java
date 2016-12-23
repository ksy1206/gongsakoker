package gongsakoker.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.service.CommunityService;
import gongsakoker.vo.CommunityVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

	@Resource(name="gongsakoker.CommunityService")
	private CommunityService communityService;
	
	//한줄 게시판 메인
	@RequestMapping(value="community_main.do")
	ModelAndView community_main(HttpServletRequest req,HttpServletResponse res){

		String start = req.getParameter("start");
		String end = req.getParameter("end");
		String search_text = req.getParameter("search_text");
		List<Object> list = communityService.c_s_board_list();
		List<Object> communityList = communityService.community_list(start,end,search_text);
		int count = communityService.community_count(search_text);
		
		ModelAndView mv = new ModelAndView("community/community_main");
		
		mv.addObject("search_text", search_text);
		mv.addObject("count", count);
		mv.addObject("list", list);
		mv.addObject("communityList", communityList);
		
		return mv;
	}
	
	
	//한줄 게시판 더보기 메소드
	@RequestMapping(value="communityList.do")
	ModelAndView communityList(HttpServletRequest req,HttpServletResponse res){

		String start = req.getParameter("start");
		String end = req.getParameter("end");
		String search_text = req.getParameter("search_text");
		List<Object> communityList = communityService.community_list(start,end,search_text);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("communityList", communityList);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	//한줄 게시판 글 입력 메소드
	@RequestMapping(value="communityInsert.do")
	ModelAndView communityInsert(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		ModelAndView mv = new ModelAndView("community/community_main");
		
		communityService.community_insert(vo);
		
		String start = "0";
		String end = "5";
		String search_text = "";
		List<Object> list = communityService.c_s_board_list();
		List<Object> communityList = communityService.community_list(start,end,search_text);
		int count = communityService.community_count(search_text);
		
		mv.addObject("count", count);
		mv.addObject("list", list);
		mv.addObject("communityList", communityList);
		
		return mv;
	}
	
	//한줄 게시판 글 세부내용
	@RequestMapping(value="communityDetail.do")
	ModelAndView communityDetail(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		Map<String, Object> pMap = new HashMap<String, Object>();
		String begin = req.getParameter("begin");
		String end = req.getParameter("end");
		String member_no = req.getParameter("member_no");
		int member_recommend_count=0;
		pMap.put("cm_no", vo.getCm_no());
		pMap.put("begin", begin);
		pMap.put("end", end);
		pMap.put("member_no", member_no);
		
		if(!member_no.equals("")){
			member_recommend_count = communityService.community_recommend_member_count(pMap);
			
		}else{
			member_recommend_count=2;
		}
		
		ModelAndView mv = new ModelAndView("community/community_detail");
		
		List<Object> communityList = communityService.community_detail(pMap);
		List<Object> replyList = communityService.community_replyList(pMap);
		int count = communityService.community_reply_count(vo.getCm_no());
		
		mv.addObject("member_recommend_count",member_recommend_count);
		mv.addObject("gubun_page", req.getParameter("gubun_page"));
		mv.addObject("cm_no",vo.getCm_no());
		mv.addObject("count", count);
		mv.addObject("communityList", communityList);
		mv.addObject("replyList", replyList);
		
		return mv;
	}
	
	
	//한줄 게시판 글 세부내용
	@RequestMapping(value="communityRecommend.do")
	ModelAndView communityRecommend(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		ModelAndView mv = new ModelAndView();

		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("cm_no",vo.getCm_no());
		pMap.put("member_no",vo.getMember_no());
		
		int recommend_confirm = communityService.community_recommend_confirm(vo);
		int recommend_count = communityService.community_recommend_count(vo);
		int member_recommend_count=0;
		
		member_recommend_count = communityService.community_recommend_member_count(pMap);
		
		mv.addObject("member_recommend_count", member_recommend_count);
		mv.addObject("recommend_count", recommend_count);
		mv.addObject("recommend_confirm", recommend_confirm);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	//한줄 게시판 상세 댓글 더보기 메소드
	@RequestMapping(value="communityReplyList.do")
	ModelAndView communityReplyList(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		Map<String, Object> pMap = new HashMap<String, Object>();
		String begin = req.getParameter("start");
		String end = req.getParameter("end");
		pMap.put("cm_no", vo.getCm_no());
		pMap.put("begin", begin);
		pMap.put("end", end);
		
		List<Object> communityReplyList = communityService.community_replyList(pMap);
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("communityReplyList", communityReplyList);
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	//한줄 게시판 글 세부내용
	@RequestMapping(value="communityMypage.do")
	ModelAndView communityMypage(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		ModelAndView mv = new ModelAndView("community/community_myPage");
		
		List<Object> myPageList = communityService.community_myPage(vo);
		
		mv.addObject("myPageList", myPageList);
		
		return mv;
	}
	
	//한줄 게시판 글 입력 메소드
	@RequestMapping(value="communityReplyInsert.do")
	ModelAndView communityReplyInsert(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		ModelAndView mv = new ModelAndView("community/community_detail");
		
		communityService.community_reply_insert(vo);
		
		String member_no = req.getParameter("member_no");
		int member_recommend_count=0;
		
		Map<String, Object> pMap = new HashMap<String, Object>();
		String begin = "0";
		String end = "5";
		pMap.put("cm_no", vo.getCm_no());
		pMap.put("begin", begin);
		pMap.put("end", end);
		pMap.put("member_no", member_no);
		
		if(!member_no.equals("")){
			member_recommend_count = communityService.community_recommend_member_count(pMap);
			
		}else{
			member_recommend_count=2;
		}
		
		List<Object> communityList = communityService.community_detail(pMap);
		List<Object> replyList = communityService.community_replyList(pMap);
		int count = communityService.community_reply_count(vo.getCm_no());
		
		mv.addObject("gubun_page", req.getParameter("gubun_page"));
		mv.addObject("member_recommend_count",member_recommend_count);
		mv.addObject("cm_no",vo.getCm_no());
		mv.addObject("count", count);
		mv.addObject("communityList", communityList);
		mv.addObject("replyList", replyList);
		
		return mv;
	}
	
	//한줄 게시판 글 수정 삭제 메소드
	@RequestMapping(value="communityUpdate.do")
	ModelAndView communityUpdate(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		ModelAndView mv = new ModelAndView();
		String member_no = req.getParameter("member_no");
		int member_recommend_count=0;
		String gubunCode = req.getParameter("gubun_code");
		String gubunPage = req.getParameter("gubun_page");
		
		System.out.println(vo.toString());
		if(!gubunPage.equals("1")){
			if(gubunCode.equals("1")){
				communityService.community_update(vo,gubunCode);
				Map<String, Object> pMap = new HashMap<String, Object>();
				String begin = "0";
				String end = "5";
				pMap.put("cm_no", vo.getCm_no());
				pMap.put("begin", begin);
				pMap.put("end", end);
				pMap.put("member_no", member_no);
				
				if(!member_no.equals("")){
					member_recommend_count = communityService.community_recommend_member_count(pMap);
					
				}else{
					member_recommend_count=2;
				}
				
				List<Object> communityList = communityService.community_detail(pMap);
				List<Object> replyList = communityService.community_replyList(pMap);
				int count = communityService.community_reply_count(vo.getCm_no());
				
				mv.addObject("member_recommend_count",member_recommend_count);
				mv.addObject("cm_no",vo.getCm_no());
				mv.addObject("count", count);
				mv.addObject("communityList", communityList);
				mv.addObject("replyList", replyList);
				mv.setViewName("community/community_detail");
			}else if(gubunCode.equals("2")){
				communityService.community_update(vo,gubunCode);
				String start = "0";
				String end = "5";
				String search_text = "";
				List<Object> list = communityService.c_s_board_list();
				List<Object> communityList = communityService.community_list(start,end,search_text);
				int count = communityService.community_count(search_text);
				
				mv.addObject("count", count);
				mv.addObject("list", list);
				mv.addObject("communityList", communityList);
				mv.setViewName("community/community_main");
			}else if(gubunCode.equals("3")){
				communityService.reply_update(vo,gubunCode);
				Map<String, Object> pMap = new HashMap<String, Object>();
				String begin = "0";
				String end = "5";
				pMap.put("cm_no", vo.getCm_no());
				pMap.put("begin", begin);
				pMap.put("end", end);
				pMap.put("member_no", member_no);
				
				if(!member_no.equals("")){
					member_recommend_count = communityService.community_recommend_member_count(pMap);
					
				}else{
					member_recommend_count=2;
				}
				
				List<Object> communityList = communityService.community_detail(pMap);
				List<Object> replyList = communityService.community_replyList(pMap);
				int count = communityService.community_reply_count(vo.getCm_no());
				
				mv.addObject("member_recommend_count",member_recommend_count);
				mv.addObject("cm_no",vo.getCm_no());
				mv.addObject("count", count);
				mv.addObject("communityList", communityList);
				mv.addObject("replyList", replyList);
				mv.setViewName("community/community_detail");
			}else if(gubunCode.equals("4")){
				communityService.reply_update(vo,gubunCode);
				Map<String, Object> pMap = new HashMap<String, Object>();
				String begin = "0";
				String end = "5";
				pMap.put("cm_no", vo.getCm_no());
				pMap.put("begin", begin);
				pMap.put("end", end);
				pMap.put("member_no", member_no);
				
				if(!member_no.equals("")){
					member_recommend_count = communityService.community_recommend_member_count(pMap);
					
				}else{
					member_recommend_count=2;
				}
				
				List<Object> communityList = communityService.community_detail(pMap);
				List<Object> replyList = communityService.community_replyList(pMap);
				int count = communityService.community_reply_count(vo.getCm_no());
				
				mv.addObject("member_recommend_count",member_recommend_count);
				mv.addObject("cm_no",vo.getCm_no());
				mv.addObject("count", count);
				mv.addObject("communityList", communityList);
				mv.addObject("replyList", replyList);
				mv.setViewName("community/community_detail");
			}
			
		}else {
				List<Object> myPageList = communityService.community_myPage(vo);
				
				mv.addObject("myPageList", myPageList);
				mv.setViewName("community/community_myPage");
		}		
		return mv;
	}
	
	//커뮤니티 신고
	@RequestMapping(value="community_report.do")
	ModelAndView community_report(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

		ModelAndView mv = new ModelAndView();
		System.out.println(vo.toString());
		
		communityService.community_report(vo);
		
		mv.setViewName("jsonView");
		
		return mv;
	}
	
	//move_notice 공지사항 이동
	@RequestMapping(value="/community_notice.do")
	public ModelAndView move_notice(){
		List<Object> communityNotice_list = null;
		communityNotice_list = communityService.get_community_notice_list();
		ModelAndView mav = new ModelAndView("community/community_notice");
		mav.addObject("communityNotice_list", communityNotice_list);
		return mav;
	}
	
}

