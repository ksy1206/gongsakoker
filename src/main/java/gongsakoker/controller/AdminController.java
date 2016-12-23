package gongsakoker.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.log4j.Logger;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.gcm.GcmSender;
import gongsakoker.helper.util.FileUtil;
import gongsakoker.service.AdminService;
import gongsakoker.service.CommunityService;
import gongsakoker.service.EstimateService;
import gongsakoker.service.FieldStroyService;
import gongsakoker.vo.AdminVO;
import gongsakoker.vo.BoardVO;
import gongsakoker.vo.CommunityVO;
import gongsakoker.vo.EstimateVO;
import gongsakoker.vo.EventVO;
import gongsakoker.vo.FieldStoryVO;
import gongsakoker.vo.LocalBoardVO;
import gongsakoker.vo.MapVO;
import gongsakoker.vo.MemberVO;
import gongsakoker.vo.NoticeVO;
import gongsakoker.vo.ReportVO;


@Controller
@RequestMapping("/admin")
public class AdminController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name="gongsakoker.AdminService")
	private AdminService adminService;
	@Resource(name="gongsakoker.EstimateService")
	private EstimateService estimateService;
	@Resource(name="gongsakoker.CommunityService")
	private CommunityService communityService;
	@Resource(name="gongsakoker.FieldStroyService")
	private FieldStroyService fieldStoryService;
	
	//알림 보내기 sender
	private static final GcmSender sender = new GcmSender();
	
		//관리자 로그인 메 인
		@RequestMapping(value="admin_login.do")
		ModelAndView admin_login(){
			ModelAndView mv = new ModelAndView("admin/admin_login");
			return mv;
		}
		
		//관리자 아이디비번 체크
		@RequestMapping(value="admin_checkId.do")
		ModelAndView admin_check(HttpSession session,@RequestParam(value="admin_id") String admin_id,@RequestParam(value="admin_pw") String admin_pw){
			
			List<Object> lists = null;
			Map<String, String> map = new HashMap<String, String>();
			map.put("admin_id", admin_id);
			map.put("admin_pw", admin_pw);
			lists = adminService.checkId(map);
			
			ModelAndView mv = new ModelAndView("admin/admin_login");
			
			for(int i = 0 ; i<lists.size();i++){
				
				if(!((AdminVO) lists.get(i)).getAdmin_pw().equals(map.get("admin_pw"))){
					
					mv.addObject("result",0);
					
				}
				else if(((AdminVO) lists.get(i)).getAdmin_pw().equals(map.get("admin_pw"))){
					
					mv.addObject("result",1);
					session.setAttribute("admin_id", ((AdminVO) lists.get(i)).getAdmin_id());
					session.setAttribute("admin_name",((AdminVO) lists.get(i)).getAdmin_name() );
					
				}
				else if(lists.size()==0){
					
					mv.addObject("result",2);
					
				}
				
			}
			
			return mv;
			
		}
		
		//관리자 로그아웃
		@RequestMapping(value="admin_logout.do")
		ModelAndView admin_logout(HttpSession session,@RequestParam("logout") int logout){
			
			ModelAndView mv = new ModelAndView("admin/admin_login");
			
			if(logout==1){
				
				session.removeAttribute("admin_id");
				session.removeAttribute("admin_name");
				mv.addObject("result", 3);
				
			}
			
			return mv;
			
		}
		
		//관리자 메인
		@RequestMapping(value="admin_main.do")
		ModelAndView admin_main(){
			
			ModelAndView mv = new ModelAndView("admin/admin_main");
			return mv;
			
		}
	
		//관리자 공지사항
		@RequestMapping(value="admin_notice.do")
		ModelAndView admin_notice(NoticeVO vo,HttpServletRequest req,HttpServletResponse res){
			
			List<Object> lists = adminService.getNoticeList(vo);
			System.out.println(vo);
			ModelAndView mav = new ModelAndView("admin/admin_notice");
			mav.addObject("list", lists);
			mav.addObject("pageNum",req.getParameter("pageNum"));
			mav.addObject("use_yn",vo.getUse_yn());
			return mav;
			
		}
		
		//관리자 공지사항 수정메인
		@RequestMapping(value="notice_updateMain.do")
		ModelAndView admin_notice1(@RequestParam("notice_no") int notice_no){
			
			List<Object> lists = adminService.getNoticeOne(notice_no);
			ModelAndView mv = new ModelAndView("admin/notice_updateMain");
			mv.addObject("noticeOne", lists);
			return mv;
			
		}
		
		//관리자 공지사항 업데이트 수정 메소드
		@RequestMapping(value="notice_update.do")
		ModelAndView admin_notice1(NoticeVO vo,HttpServletRequest req,HttpServletResponse res){
			
			adminService.updateNoticeOne(vo);
			System.out.println(vo);
			ModelAndView mv = new ModelAndView("admin/admin_notice");
			mv.addObject("result",1);
			mv.addObject("pageNum",1);
			mv.addObject("notice_no",vo.getNotice_no());
			return mv;
			
		}
			
		//관리자 공지사항 입력 메인
		@RequestMapping(value="notice_insertMain.do")
		ModelAndView notice_insertMain(){
			
			ModelAndView mv = new ModelAndView("admin/notice_insertMain");
			
			return mv;
			
		}
		
		//관리자 공지사항 입력 메소드
		@RequestMapping(value="notice_insert.do")
		ModelAndView notice_insert(NoticeVO vo){
			
			adminService.insertNoticeOne(vo);
			ModelAndView mv = new ModelAndView("admin/admin_notice");
			mv.addObject("result",2);
			mv.addObject("pageNum",1);

			String title = "공사콕커입니다.";
			String message = "새로운 공지사항이 등록되었습니다. 공지사항을 확인해주세요.";
			
			//박종현 모든 안드로이드 hp_reg_id 가져와서알림보내기
			ArrayList<String> regList = new ArrayList<String>();
			regList = (ArrayList<String>) adminService.get_all_hpregid();
			if(regList.size() > 0){
				sender.postMultiGCM( regList, title, "notice", message );
			}
			
			//박종현 모든 ios hp_reg_id 가져와서알림보내기
			ArrayList<String> iosRegList = new ArrayList<String>();
			iosRegList = (ArrayList<String>) adminService.get_all_ioshpregid();
			if(iosRegList.size() > 0){
				sender.postMultiIosGCM(iosRegList, title, "notice", message );
			}
			//알림보내기끝

			return mv;
			
		}
		
		//관리자 회원메인
		@RequestMapping(value="admin_member.do")
		ModelAndView member_list(MemberVO vo ,HttpServletRequest req,HttpServletResponse res){
			
			if(vo.getPageNum()==null){
				vo.setPageNum("1");
			}
			
			List<Object> list = adminService.memberList(vo);
			List<Object> cnt = adminService.getCodeCount();
			List<Object> category = adminService.categoryList();
			
			System.out.println(vo.getKeyword_01());
			ModelAndView mv = new ModelAndView("admin/admin_member");
			mv.addObject("list",list);
			mv.addObject("categoryList", category);
			mv.addObject("codeCount", cnt);
			mv.addObject("pageNum",vo.getPageNum());
			mv.addObject("use_yn",vo.getUse_yn());
			mv.addObject("class_code",vo.getClass_code());
			mv.addObject("category",req.getParameter("category"));
			mv.addObject("member_code",vo.getMember_code());
			mv.addObject("keyword_01",vo.getKeyword_01());
			return mv;
			
		}
		
		//관리자 회원 수정 메인
		@RequestMapping(value="admin_memberUpdate.do")
		ModelAndView member_update(HttpServletRequest req,HttpServletResponse res, @RequestParam("member_no")String member_no
				, @RequestParam("koker_no")String koker_no , MemberVO vo){

			List<Object> list = adminService.memberUpdate(member_no);
			List<Object> chargeMember = adminService.chargeMember(koker_no);
			int count = adminService.recommendCount(vo);
			
			ModelAndView mv = new ModelAndView("admin/member_updateMain");
			mv.addObject("chargeSize", chargeMember.size());
			mv.addObject("chargeMember", chargeMember);
			mv.addObject("count",count);
			mv.addObject("info",list);
			return mv;
			
		}

		//관리자 회원 수정 메인
		@RequestMapping(value="memberCodeList.do")
		ModelAndView code_list(HttpServletRequest req,HttpServletResponse res,MemberVO vo){

			List<Object> codeList = adminService.classCodeView(vo);
			ModelAndView mv = new ModelAndView();
			mv.addObject("kokerCodeList", codeList);
			mv.setViewName("jsonView");
			return mv;
			
		}
		
		
		//관리자 회원 수정 메소드
		@RequestMapping(value="member_Update.do")
		ModelAndView member_update(MemberVO vo,HttpServletRequest req,HttpServletResponse res){
			
			String member_no = vo.getMember_no();
			ModelAndView mv = new ModelAndView("admin/admin_member");
			int result=1;
			
			try {
				
				String fileGbn1 = "company_paper1";
				String fileGbn2 = "company_paper2";
				
				HttpSession session = req.getSession();
				String doc_root = session.getServletContext().getRealPath("/upload");
				
				String fileDestPath1 = "";
				fileDestPath1 = doc_root + File.separator + "img" + File.separator + "temp";
				String fileDestPath2 = "";
				
				File destinationDir = new File(fileDestPath1);
				
				if (!destinationDir.exists()) {
					destinationDir.mkdirs();
				}
				
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
				MultipartFile file1 = multipartRequest.getFile("file1");
				MultipartFile file2 = multipartRequest.getFile("file2");
				String fileName1=null;
				String fileName2=null;
				File destination1 = null; 
				File destination2 = null; 
				String newName1=null;
				String newName2=null;
				String totalPath1=null;
				String totalPath2=null;
				if(file1!=null){
					fileName1 = file1.getOriginalFilename();
				}
				if(file2!=null){
					fileName2 = file2.getOriginalFilename();
				}
				if(fileName1!=null  && fileName1!=""){
				
					//temp파일 생성
					String fileType1 = fileName1.substring(fileName1.indexOf("."));
					destination1 = File.createTempFile(fileGbn1.toUpperCase(),fileType1, destinationDir);
					FileCopyUtils.copy(file1.getInputStream(),new FileOutputStream(destination1));
					
					//DB 데이터 업데이트 후 파일 이동 경로 설정					
					fileDestPath2 = doc_root + File.separator + "img" + File.separator + vo.getMember_id();
					newName1 = vo.getMember_id() + "member1";
					totalPath1 = destination1.toString();
					destinationDir = new File(fileDestPath2);
					
					if (!destinationDir.exists()) {
						destinationDir.mkdirs();
					}
					vo.setBusiness_file01_path(fileDestPath2);
					vo.setBusiness_file01_name(newName1);		
				}
				if(fileName2!=null  && fileName2!=""){
				
					//temp파일 생성
					String fileType2 = fileName2.substring(fileName2.indexOf("."));
					destination2 = File.createTempFile(fileGbn2.toUpperCase(),fileType2, destinationDir);
					FileCopyUtils.copy(file2.getInputStream(),new FileOutputStream(destination2));
					
					//DB 데이터 업데이트 후 파일 이동 경로 설정
					fileDestPath2 = doc_root + File.separator + "img" + File.separator + vo.getMember_id();
					newName2 = vo.getMember_id() + "member2";
					totalPath2 = destination2.toString();
					destinationDir = new File(fileDestPath2);
					
					if (!destinationDir.exists()) {
						destinationDir.mkdirs();
					}
					vo.setBusiness_file02_path(fileDestPath2);
					vo.setBusiness_file02_name(newName2);
				
				}
				
				try {
					String charge_check = req.getParameter("charge_check");
					if(charge_check.equals("1")){
						if(vo.getCharge_yn().equals("y")){
							adminService.chargeUpdate(vo);
						}else{
							adminService.chargeDelete(vo);
						}
					}else if(charge_check.equals("2")){
						if(!vo.getStart_date().equals("")){
							adminService.chargeInsert(vo);
						}
					}
					adminService.member_Update(vo,req.getParameter("bizLinkConfirm"));
					adminService.recommend(req.getParameter("recommend"),vo);
					mv.addObject("result", result);
					mv.addObject("pageNum", 1);
					mv.addObject("member_no",member_no);
					mv.addObject("koker_no", vo.getKoker_no());
					
				} catch (Exception e) {
					e.printStackTrace();
					FileUtil.deleteFile(fileDestPath1);
				}

				//파일이동
				if(fileName1!=null  && fileName1!=""){
					FileUtil.moveFile(totalPath1, fileDestPath2, newName1);
				}
				if(fileName2!=null  && fileName2!=""){
					FileUtil.moveFile(totalPath2, fileDestPath2, newName2);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return mv;			
		}
		
		//관리자 이벤트페이지 메인
		@RequestMapping(value="admin_event.do")
		ModelAndView eventMain(EventVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_event");
			
			mv.addObject("event_use_yn", vo.getEvent_use_yn());
			mv.addObject("pageNum",vo.getPageNum());
			
			List<Object> lists = adminService.event_List(vo);
			mv.addObject("list", lists);
			
			return mv;
			
		}
		
		//관리자 이벤트 등록 페이지
		@RequestMapping(value="event_insertMain.do")
		ModelAndView eventInsert(){
			
			ModelAndView mv = new ModelAndView("admin/event_insertMain");
			return mv;
			
		}
		
		//관리자 이벤트 등록 메소드
		@RequestMapping(value="event_insert.do")
		ModelAndView eventInsertMethod(EventVO vo,HttpServletRequest req,HttpServletResponse res){
			
			try {
				
				String fileGbn1 = "event_file1";
				String fileGbn2 = "event_file2";
				
				HttpSession session = req.getSession();
				String doc_root = session.getServletContext().getRealPath("/upload");
				
				String fileDestPath1 = "";
				fileDestPath1 = doc_root + File.separator+ "event" + File.separator + "temp";
				String fileDestPath2 = "";
				String fileDestPath3 = "";
				Date dt = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss"); 
				File destinationDir = new File(fileDestPath1);
				
				if (!destinationDir.exists()) {
					destinationDir.mkdirs();
				}
				
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
				MultipartFile file1 = multipartRequest.getFile("fileUpload1");
				MultipartFile file2 = multipartRequest.getFile("fileUpload2");
				String fileName1 = file1.getOriginalFilename();
				String fileName2 = file2.getOriginalFilename();
				File destination1 = null; 
				File destination2 = null; 
				String newName1=null;
				String newName2=null;
				String totalPath1=null;
				String totalPath2=null;
				
				if(fileName1!=null  && fileName1!=""){
					
					//temp파일 생성
					String fileType1 = fileName1.substring(fileName1.indexOf("."));
					destination1 = File.createTempFile(fileGbn1.toUpperCase(),fileType1, destinationDir);
					FileCopyUtils.copy(file1.getInputStream(),new FileOutputStream(destination1));
					
					//DB 데이터 업데이트 후 파일 이동 경로 설정					
					fileDestPath2 = doc_root + File.separator+ "event" + File.separator + "banner";
					newName1 = sdf.format(dt).toString() + "event1";
					totalPath1 = destination1.toString();
					destinationDir = new File(fileDestPath2);
					
					if (!destinationDir.exists()) {
						destinationDir.mkdirs();
					}

					vo.setEvent_title_img_path(fileDestPath2);
					vo.setEvent_title_img(newName1);
					
				}
				if(fileName2!=null  && fileName2!=""){
					
					//temp파일 생성
					String fileType2 = fileName2.substring(fileName2.indexOf("."));
					destination2 = File.createTempFile(fileGbn2.toUpperCase(),fileType2, destinationDir);
					FileCopyUtils.copy(file2.getInputStream(),new FileOutputStream(destination2));
					
					//DB 데이터 업데이트 후 파일 이동 경로 설정
					fileDestPath3 = doc_root + File.separator+ "event" + File.separator + "sub";
					newName2 = sdf.format(dt).toString() + "event2";
					totalPath2 = destination2.toString();
					destinationDir = new File(fileDestPath2);
					
					if (!destinationDir.exists()) {
						destinationDir.mkdirs();
					}
					System.out.println(destinationDir);
					
					vo.setEvent_content_img_path(fileDestPath3);
					vo.setEvent_content_img(newName2);
					
				}
				
				try {
					
					adminService.event_Insert(vo);
					
				} catch (Exception e) {
					
					FileUtil.deleteFile(fileDestPath1);
					
				}

				//파일이동
				if(fileName1!=null  && fileName1!=""){
					FileUtil.moveFile(totalPath1, fileDestPath2, newName1);
				}
				if(fileName2!=null  && fileName2!=""){
					FileUtil.moveFile(totalPath2, fileDestPath3, newName2);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			ModelAndView mv = new ModelAndView("admin/admin_event");
			mv.addObject("pageNum",1);
			mv.addObject("result",1);
			
			String title = "공사콕커입니다.";
			String message = "새로운 이벤트가 등록되었습니다.";
			//박종현 모든 안드로이드 hp_reg_id 가져와서알림보내기
			ArrayList<String> regList = new ArrayList<String>();
			regList = (ArrayList<String>) adminService.get_all_hpregid();
			if(regList.size() > 0){
				sender.postMultiGCM( regList, title, "event", message );
			}
			
			//박종현 모든 ios hp_reg_id 가져와서알림보내기
			ArrayList<String> iosRegList = new ArrayList<String>();
			iosRegList = (ArrayList<String>) adminService.get_all_ioshpregid();
			if(iosRegList.size() > 0){
				sender.postMultiIosGCM(iosRegList, title, "event", message );
			}
			//알림보내기끝
			
			return mv;
			
		}
		
		//관리자 이벤트 수정 메인 페이지
		@RequestMapping(value="event_updateMain.do")
		ModelAndView event_updateMain(EventVO vo){
			
			List<Object> lists = adminService.eventOne(vo);
			ModelAndView mv = new ModelAndView("admin/event_updateMain");
			mv.addObject("list",lists);
			return mv;
			
		}
		
		//관리자 이벤트 수정 메소드
		@RequestMapping(value="event_update.do")
		ModelAndView event_update(HttpServletRequest req,HttpServletResponse res, EventVO vo){
			
			try {
				
				String fileGbn1 = "event_file1";
				String fileGbn2 = "event_file2";
				
				HttpSession session = req.getSession();
				String doc_root = session.getServletContext().getRealPath("/upload");
				
				String fileDestPath1 = "";
				fileDestPath1 = doc_root + File.separator+ "event" + File.separator + "temp";
				String fileDestPath2 = "";
				String fileDestPath3 = "";
				
				Date dt = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss"); 
				File destinationDir = new File(fileDestPath1);
								
				MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
				MultipartFile file1 = multipartRequest.getFile("fileUpload1");
				MultipartFile file2 = multipartRequest.getFile("fileUpload2");
				String fileName1 = file1.getOriginalFilename();
				String fileName2 = file2.getOriginalFilename();
				File destination1 = null; 
				File destination2 = null; 
				String newName1=null;
				String newName2=null;
				String totalPath1=null;
				String totalPath2=null;
				
				if(fileName1!=null && fileName1!=""){
					
					//temp파일 생성
					String fileType1 = fileName1.substring(fileName1.indexOf("."));
					System.out.println(fileGbn1+"===="+fileType1+"===="+destinationDir);
					destination1 = File.createTempFile(fileGbn1.toUpperCase(),fileType1, destinationDir);
					FileCopyUtils.copy(file1.getInputStream(),new FileOutputStream(destination1));
					
					//DB 데이터 업데이트 후 파일 이동 경로 설정					
					fileDestPath2 = doc_root + File.separator+ "event" + File.separator + "banner";
					newName1 = sdf.format(dt).toString() + "event1";
					totalPath1 = destination1.toString();
					destinationDir = new File(fileDestPath2);
					
					if (!destinationDir.exists()) {
						destinationDir.mkdirs();
					}
					
					vo.setEvent_title_img_path(fileDestPath2);
					vo.setEvent_title_img(newName1);
										
				}
				
				if(fileName2!=null && fileName2!=""){
					System.out.println("2222");
					//temp파일 생성
					String fileType2 = fileName2.substring(fileName2.indexOf("."));
					destination2 = File.createTempFile(fileGbn2.toUpperCase(),fileType2, destinationDir);
					FileCopyUtils.copy(file2.getInputStream(),new FileOutputStream(destination2));
					
					//DB 데이터 업데이트 후 파일 이동 경로 설정
					fileDestPath3 = doc_root + File.separator+ "event" + File.separator + "sub";
					newName2 = sdf.format(dt).toString() + "event2";
					totalPath2 = destination2.toString();
					destinationDir = new File(fileDestPath2);
					
					if (!destinationDir.exists()) {
						destinationDir.mkdirs();
					}
					
					vo.setEvent_content_img_path(fileDestPath3);
					vo.setEvent_content_img(newName2);
					
				}
				
				try {
					
					adminService.event_Update(vo);
					
				} catch (Exception e) {
					
					FileUtil.deleteFile(fileDestPath1);
					
				}

				//파일이동
				File sourceFile = null;
				
				if(fileName1!=null  && fileName1!=""){

					FileUtil.moveFile(totalPath1, fileDestPath2, newName1);
					sourceFile = new File(fileDestPath2+"\\"+req.getParameter("file_delete1"));
				    if(sourceFile.exists()){
				    	sourceFile.delete();
				    }
					
				}
				if
				(fileName2!=null  && fileName2!=""){
					FileUtil.moveFile(totalPath2, fileDestPath3, newName2);
					sourceFile = new File(fileDestPath3+"\\"+req.getParameter("file_delete2"));
			    	
				    if(sourceFile.exists()){
				    	sourceFile.delete();
				    }
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			ModelAndView mv = new ModelAndView("admin/admin_event");
			mv.addObject("event_no",vo.getEvent_no());
			mv.addObject("pageNum",1);
			mv.addObject("result",2);
			return mv;
			
		}
		
		//관리자 광고 메인 페이지
		@RequestMapping(value="admin_advertise.do")
		ModelAndView admin_advertise(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			List<Object> list =null;
			list = adminService.admin_advertise(vo);
			ModelAndView mv = new ModelAndView("admin/admin_advertise");
			mv.addObject("board_write",vo.getBoard_write());
			mv.addObject("board_complete",vo.getBoard_complete());
			mv.addObject("list",list);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			return mv;
			
		}
		
		//관리자 광고 수정 메인 페이지
		@RequestMapping(value="advertise_updateMain.do")
		ModelAndView advertise_updateMain(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			List<Object> list =null;
			
			ModelAndView mv = new ModelAndView("admin/advertise_updateMain");
			
			mv.addObject("board_complete", vo.getBoard_complete());
			
			list = adminService.admin_advertise(vo);
			
			mv.addObject("list",list);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			return mv;
			
		}

		//관리자 광고 수정 메소드
		@RequestMapping(value="advertise_update.do")
		ModelAndView advertise_update(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_advertise");
			
			adminService.advertise_update(vo);
			
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("result", 1);
			mv.addObject("board_no", vo.getBoard_no());
			
			return mv;
			
		}
			
		//관리자 광고 입력 메소드
		@RequestMapping(value="advertise_insert.do")
		ModelAndView advertise_insert(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_advertise");
			mv.addObject("board_no", vo.getBoard_no());
			mv.addObject("pageNum", req.getParameter("pageNum"));
			
			int count = adminService.advertise_confirm(vo);
			if(count != 0){
				mv.addObject("result", 3);
			}else{
				adminService.advertise_insert(vo);
				mv.addObject("result", 2);
			}
			
			return mv;
		}
		
		//관리자 1:1질문 메인 페이지
		@RequestMapping(value="admin_question.do")
		ModelAndView admin_question(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			List<Object> list =null;
			list = adminService.admin_question(vo);
			ModelAndView mv = new ModelAndView("admin/admin_question");
			mv.addObject("board_write",vo.getBoard_write());
			mv.addObject("board_complete",vo.getBoard_complete());
			mv.addObject("list",list);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			return mv;
			
		}
		
		//관리자 1:1질문 수정 메인 페이지
		@RequestMapping(value="question_updateMain.do")
		ModelAndView question_updateMain(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			List<Object> list =null;
			
			ModelAndView mv = new ModelAndView("admin/question_updateMain");
			mv.addObject("board_complete", vo.getBoard_complete());
			
			list = adminService.admin_question(vo);
			
			mv.addObject("list",list);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			return mv;
			
		}
		
		//관리자 1:1질문 수정 메소드
		@RequestMapping(value="question_update.do")
		ModelAndView question_update(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_question");
			
			adminService.question_update(vo);
			
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("result", 1);
			mv.addObject("board_no", vo.getBoard_no());
			
			return mv;
			
		}
			
		//관리자 1:1질문 입력 메소드
		@RequestMapping(value="question_insert.do")
		ModelAndView question_insert(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_question");
			mv.addObject("board_no", vo.getBoard_no());
			mv.addObject("pageNum", req.getParameter("pageNum"));
			
			int count = adminService.question_confirm(vo);
			if(count != 0){
				mv.addObject("result", 3);
			}else{
				adminService.question_insert(vo);
				mv.addObject("result", 2);
			}

			//박종현 핸드폰 id가져와서 알림 보내기
			String regId = ( String ) adminService.get_hpregid( vo.getBoard_no() );
			String title = "공사콕커입니다.";
			String message = "1:1 질문에 대한 답글이 등록되었습니다.";
			
			String hp_kind = ( String ) adminService.get_hp_kind( vo.getBoard_no() );
			System.out.println("핸드폰 종류 : "+ hp_kind);
			if(hp_kind.equals("I")) {
				sender.postSingleIosGCM(regId, title, "11question", message );
			}else {
				sender.postSingleGCM( regId, title, "11question", message );
			}
			//끝
			
			return mv;
		}

		//관리자 자주묻는 질문 메인 페이지
		@RequestMapping(value="admin_qna.do")
		ModelAndView admin_qna(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			List<Object> list =null;
			list = adminService.admin_qna(vo);
			ModelAndView mv = new ModelAndView("admin/admin_qna");
			mv.addObject("list",list);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			return mv;
			
		} 
		
		//관리자 자주묻는 질문 수정 메인 페이지
		@RequestMapping(value="qna_updateMain.do")
		ModelAndView qna_updateMain(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			List<Object> list =null;
			
			ModelAndView mv = new ModelAndView("admin/qna_updateMain");
			
			list = adminService.admin_qna(vo);
			
			mv.addObject("list",list);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			return mv;
			
		}
		
		//관리자 자주묻는질문 수정 메소드
		@RequestMapping(value="qna_update.do")
		ModelAndView qna_update(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_qna");
			vo.setAnswer_write(vo.getBoard_write());
			
			adminService.qna_update(vo);
			
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("result", 1);
			mv.addObject("board_no", vo.getBoard_no());
			
			return mv;
			
		}
		
		//관리자 자주묻는질문 입력 메인
		@RequestMapping(value="qna_insertMain.do")
		ModelAndView qna_insertMain(){
			
			ModelAndView mv = new ModelAndView("admin/qna_insertMain");
			return mv;
			
		}
		
		//관리자 자주묻는 질문 입력 메소드
		@RequestMapping(value="qna_insert.do")
		ModelAndView qna_insert(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_qna");
			mv.addObject("pageNum", req.getParameter("pageNum"));
			
			int count = adminService.qna_confirm(vo);
			if(count != 0){
				mv.addObject("result", 3);
			}else{
				vo.setAnswer_write(vo.getBoard_write());
				adminService.qna_insert(vo);
				mv.addObject("result", 2);
				mv.addObject("pageNum",1);
			}
			return mv;
		}
		
		//관리자 자주묻는 질문 삭제 메소드
		@RequestMapping(value="qna_delete.do")
		ModelAndView qna_delete(HttpServletRequest req,HttpServletResponse res, BoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_qna");
			mv.addObject("pageNum", req.getParameter("pageNum"));
			
			adminService.qna_delete(vo);
			mv.addObject("result", 4);
			mv.addObject("pageNum",1);

			return mv;
		}
		
		//업체등록요청 전체 리스트 불러오기
		@RequestMapping(value="admin_addCompany.do")
		ModelAndView admin_addCompany(@RequestParam(value="pageNum") String pageNum){
			Map<String, String> pMap = new HashMap<String, String>();
			pMap.put("page", pageNum);
			pMap.put("rows", "4"); // 페이지당 몇개의 행을 보여줄 것인지
			pMap.put("pageCnt", "3"); // 페이지를 몇 페이지로 나눌 것인지
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.getListAddCompany(pMap);
			resultMap.put("controller", "admin_addCompany.do");
			ModelAndView mav = new ModelAndView("admin/admin_addCompany");
			mav.addObject("result_list", resultMap);
			return mav;
		}
		
		//업체등록요청 확인*미확인 리스트 불러오기
		@RequestMapping(value="admin_addCompany_check_y.do")
		ModelAndView admin_addCompany_check_y(@RequestParam(value="pageNum") String pageNum){
			Map<String, String> pMap = new HashMap<String, String>();
			pMap.put("page", pageNum);
			pMap.put("rows", "4"); // 페이지당 몇개의 행을 보여줄 것인지
			pMap.put("pageCnt", "3"); // 페이지를 몇 페이지로 나눌 것인지
			pMap.put("company_call_ok", "y");
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.getListAddCompanyCheck(pMap);
			resultMap.put("controller", "admin_addCompany_check_y.do");
			ModelAndView mav = new ModelAndView("admin/admin_addCompany");
			mav.addObject("result_list", resultMap);
			return mav;
		}
		
		//업체등록요청 확인*미확인 리스트 불러오기
		@RequestMapping(value="admin_addCompany_check_n.do")
		ModelAndView admin_addCompany_check_n(@RequestParam(value="pageNum") String pageNum){
			Map<String, String> pMap = new HashMap<String, String>();
			pMap.put("page", pageNum);
			pMap.put("rows", "4"); // 페이지당 몇개의 행을 보여줄 것인지
			pMap.put("pageCnt", "3"); // 페이지를 몇 페이지로 나눌 것인지
			pMap.put("company_call_ok", "n");
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.getListAddCompanyCheck(pMap);
			resultMap.put("controller", "admin_addCompany_check_n.do");
			ModelAndView mav = new ModelAndView("admin/admin_addCompany");
			mav.addObject("result_list", resultMap);
			return mav;
		}
		
		
		//업체등록요청 검색 리스트 불러오기
		@RequestMapping(value="admin_addCompany_check_search.do")
		ModelAndView admin_addCompany_check_search(@RequestParam(value="pageNum") String pageNum, 
				@RequestParam(value="company_recommender")String company_recommender){
			Map<String, String> pMap = new HashMap<String, String>();
			pMap.put("page", pageNum);
			pMap.put("rows", "4"); // 페이지당 몇개의 행을 보여줄 것인지
			pMap.put("pageCnt", "3"); // 페이지를 몇 페이지로 나눌 것인지
			pMap.put("company_recommender", company_recommender);
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap = adminService.getListAddCompany(pMap);
			resultMap.put("controller", "admin_addCompany_check_search.do");
			ModelAndView mav = new ModelAndView("admin/admin_addCompany");
			mav.addObject("result_list", resultMap);
			mav.addObject("company_recommender", company_recommender);
			return mav;
		}
		
		@RequestMapping(value="update_company_call.do")
		ModelAndView update_company_call(@RequestParam Map<String, Object> map){
			adminService.company_call_update(map);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("jsonView");
			return mav;
		}
		
		//관리자 랭킹 20 메인
		@RequestMapping(value="admin_kokkok20.do")
		ModelAndView admin_kokkok20(MemberVO vo,HttpServletRequest req,HttpServletResponse res){
			
			ModelAndView mv = new ModelAndView("admin/admin_kokkok20");
			mv.addObject("class_code", vo.getClass_code());
			
			return mv;
			
		}
		
		//관리자 랭킹 리스트 가져오기
		@RequestMapping(value="admin_getKokkok20.do")
		ModelAndView admin_getKokkok20(MemberVO vo,HttpServletRequest req,HttpServletResponse res){
			
			ModelAndView mv = new ModelAndView("admin/admin_kokkok20");
			List<Object> infoAverage = adminService.infoAverage(vo);
			List<Object> rankNumber = adminService.rankNumber(vo);
			List<Object> deleteRank = adminService.deleteRank(vo);
			Map<String, Object> rMap = new HashMap<String, Object>();
			
			rMap.put("infoAverage", infoAverage);
			rMap.put("rankNumber", rankNumber);
			rMap.put("deleteRank", deleteRank);
			mv.addAllObjects(rMap);
			mv.setViewName("jsonView");
			
			return mv;
			
		}
		
		
		@RequestMapping(value="rankManager.do")
		ModelAndView test(@RequestParam Map<String, Object> map,HttpServletRequest req,HttpServletResponse res){

			ModelAndView mv = new ModelAndView("admin/admin_kokkok20");
			
			String class_code = req.getParameter("class_code");
			
			String koker_no_arr[] = map.get("koker_no_arr").toString().split(",");
			String koker_name_arr[] = map.get("koker_name_arr").toString().split(",");
			String average_arr[] = map.get("average_arr").toString().split(",");
			String change_average = "";
			String change_koker_no="";
			String change_koker_name="";
			System.out.println(map.get("koker_no_arr").toString().split(","));
			if(!req.getParameter("koker_no_arr").equals("1")){
				for(int j = 0; j < koker_no_arr.length; j++){
					for(int e = 0;e<koker_no_arr.length;e++){
						if(Float.parseFloat(average_arr[j]) >Float.parseFloat(average_arr[e])){
							change_average = average_arr[j];
							average_arr[j]=average_arr[e];
							average_arr[e]=change_average;
							change_koker_no = koker_no_arr[j];
							koker_no_arr[j]=koker_no_arr[e];
							koker_no_arr[e]=change_koker_no;
							change_koker_name = koker_name_arr[j];
							koker_name_arr[j]=koker_name_arr[e];
							koker_name_arr[e]=change_koker_name;
							
						}else if(Float.parseFloat(average_arr[j]) == Float.parseFloat(average_arr[e])){
							int a = koker_name_arr[j].compareTo(koker_name_arr[e]);
							if(a <= 0){
								change_average = average_arr[j];
								average_arr[j]=average_arr[e];
								average_arr[e]=change_average;
								change_koker_no = koker_no_arr[j];
								koker_no_arr[j]=koker_no_arr[e];
								koker_no_arr[e]=change_koker_no;
								change_koker_name = koker_name_arr[j];
								koker_name_arr[j]=koker_name_arr[e];
								koker_name_arr[e]=change_koker_name;
								koker_name_arr[j].compareTo(koker_name_arr[e]);
							}
						}
					}
				}
				
				adminService.deleteRanking(class_code);
				
				for (int i = 0; i < koker_no_arr.length; i++) {
					
					map.put("class_code", req.getParameter("class_code"));
					map.put("koker_no", koker_no_arr[i]);
					map.put("koker_name", koker_name_arr[i]);
					map.put("average", average_arr[i]);
					map.put("ranking", i+1);
					
					adminService.rankInsert(map);
					
				}
				
			}else{
				adminService.deleteRanking(class_code);
			}
			
			String koker_no_arr1[] = map.get("koker_no_arr1").toString().split(",");
			if(!req.getParameter("koker_no_arr1").equals("1")){
				
				adminService.rankingReset(class_code);
				
				for (int i = 0; i < koker_no_arr1.length; i++) {
					
					map.put("koker_no", koker_no_arr1[i]);
					adminService.rankDelete(map);
					
				}
			}else{
				adminService.rankingReset(class_code);
			}
			

			mv.setViewName("jsonView");
			return mv;
			
		}
		
		//관리자 지역게시판 리스트 가져오기
		@RequestMapping(value="admin_areaBoard.do")
		ModelAndView admin_areaBoard(HttpServletRequest req,HttpServletResponse res,LocalBoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_areaBoard");
			
			List<Object> localList = adminService.localBoardList(vo);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("category", req.getParameter("category"));
			mv.addObject("sido", req.getParameter("sido"));
			mv.addObject("gugun", req.getParameter("gugun"));
			mv.addObject("localList", localList);
			
			return mv;
			
		}
		
		//관리자 지역게시판 수정 메인
		@RequestMapping(value="areaBoard_updateMain.do")
		ModelAndView areaBoard_udateMain(HttpServletRequest req,HttpServletResponse res,LocalBoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/localBoard_updateMain");
			
			List<Object> localOne = adminService.localBoardUpdateMain(vo);
			
			Iterator<Object> it = localOne.iterator();
			while (it.hasNext()) {
				vo = (LocalBoardVO) it.next();
			}
			mv.addObject("category", vo.getCategory());
			mv.addObject("sido", vo.getSido());
			mv.addObject("gugun", vo.getGugun());
			mv.addObject("localOne", localOne);
			
			return mv;
			
		}
		
		//관리자 지역게시판 수정 메소드
		@RequestMapping(value="areaBoard_update.do")
		ModelAndView areaBoard_udate(HttpServletRequest req,HttpServletResponse res,LocalBoardVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_areaBoard");
			
			adminService.localBoardUpdate(vo);
			vo.setSido(null);
			vo.setGugun(null);
			vo.setCategory(null);
			List<Object> localList = adminService.localBoardList(vo);
			
			mv.addObject("localList", localList);
			mv.addObject("board_no",vo.getBoard_no());
			mv.addObject("result", 1);
			mv.addObject("pageNum", 1);
			
			return mv;
			
		}

		//관리자 푸쉬알람 가져오기
		@RequestMapping(value="admin_pushAlram.do")
		ModelAndView admin_pushAlram(HttpServletRequest req,HttpServletResponse res){
			
			ModelAndView mv = new ModelAndView("admin/admin_pushAlram");
			
			return mv;
			
		}
		
		//관리자 푸쉬알림 메소드
		@RequestMapping(value="admin_pushAlramMethod.do")
		ModelAndView pushAlramMethod(HttpServletRequest req,HttpServletResponse res,HttpSession session){
			
			
			ModelAndView mv = new ModelAndView("admin/admin_pushAlram");
			
			String title = req.getParameter("push_title");
			String message = req.getParameter("push_content");
			
			//박종현 모든 안드로이드 hp_reg_id 가져와서알림보내기
			ArrayList<String> regList = new ArrayList<String>();
			regList = (ArrayList<String>) adminService.get_all_hpregid();
			if(regList.size() > 0){
				sender.postMultiGCM( regList, title, "plzcheck", message );
			}
			
			//박종현 모든 안드로이드 hp_reg_id 가져와서알림보내기
			ArrayList<String> iosRegList = new ArrayList<String>();
			iosRegList = (ArrayList<String>) adminService.get_all_ioshpregid();
			if(iosRegList.size() > 0){
				System.out.println("알림 보냈습니다." + iosRegList.size());
				sender.postMultiIosGCM(iosRegList, title, "plzcheck", message );
			}
			
			//알림보내기끝

			return mv;
			
		}

		//관리자 비즈링크 0504번호 메인
		@RequestMapping(value="admin_bizLink0504.do")
		ModelAndView admin_bizLink0504(HttpServletRequest req,HttpServletResponse res,HttpSession session){
			
			ModelAndView mv = new ModelAndView("admin/admin_bizLink0504");

			return mv;
			
		}
		
		//관리자 견적 메인
		@RequestMapping(value="admin_estimate.do")
		ModelAndView admin_estimate(HttpServletRequest req,HttpServletResponse res,HttpSession session){
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("est_sido", req.getParameter("est_sido"));
			map.put("est_gugun", req.getParameter("est_gugun"));
			map.put("estType01_code", req.getParameter("estType01_code"));
			map.put("estType02_code", req.getParameter("estType02_code"));
			map.put("member_id", req.getParameter("member_id"));
			map.put("est_content", req.getParameter("est_content"));
			
			ModelAndView mv = new ModelAndView("admin/admin_estimate");
			
			List<Object> estimate = adminService.estimateList(map);
			
			mv.addObject("list", estimate);
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("est_sido_hidden", req.getParameter("est_sido"));
			mv.addObject("est_gugun_hidden", req.getParameter("est_gugun"));
			mv.addObject("estType01_code_hidden", req.getParameter("estType01_code"));
			mv.addObject("estType02_code_hidden", req.getParameter("estType02_code"));
			mv.addObject("member_id_hidden", req.getParameter("member_id"));
			mv.addObject("est_content_hidden", req.getParameter("est_content"));
			return mv;
			
		}
			
		//관리자 카테고리 클래스코드별 소환
		@RequestMapping(value="admin_categoryUpdate.do")
		ModelAndView admin_categoryUpdate(HttpServletRequest req,HttpServletResponse res,HttpSession session){
			
			ModelAndView mv = new ModelAndView();
			
			List<Object> categoryList = adminService.categoryUpdateList(req.getParameter("class_code"));
			mv.addObject("categoryList", categoryList);
			mv.setViewName("jsonView");
			return mv;
			
		}
			
		//관리자 카테고리 수정 메인
		@RequestMapping(value="admin_category.do")
		ModelAndView admin_category(HttpServletRequest req,HttpServletResponse res,HttpSession session){
			
			ModelAndView mv = new ModelAndView("admin/admin_category");
			
			List<Object> categoryList = adminService.categoryUpdateList(req.getParameter("class_code"));
			mv.addObject("class_code", req.getParameter("class_code"));
			mv.addObject("categoryList", categoryList);
			
			return mv;
		}
		
		
		//관리자 카테고리 업데이트 메소드
		@RequestMapping(value="categoryUpdate.do")
		ModelAndView categoryUpdate(HttpServletRequest req,HttpServletResponse res,HttpSession session , MemberVO vo){
			
			ModelAndView mv = new ModelAndView();
			
			String gubunCode = req.getParameter("gubunCode");
			adminService.categoryUpdate(vo,gubunCode);
			
			System.out.println(req.getParameter("category"));
			System.out.println(req.getParameter("code_sort"));
			System.out.println(req.getParameter("code_name"));
			System.out.println(req.getParameter("gubunCode"));
			System.out.println(req.getParameter("code_no"));
			
			mv.setViewName("jsonView");
			return mv;
			
		}
		
		//관리자 견적
		@RequestMapping(value="admin_estimateDetails.do")
		ModelAndView admin_estimateDetails(@RequestParam Map<String, Object> map){
			EstimateVO estimateVo = null;
	    	estimateVo = (EstimateVO) adminService.estimateDetails(map);
			ModelAndView mav = new ModelAndView("admin/admin_estimateDetails");
			mav.addObject("estimateVo", estimateVo);
			double est_area2 = Double.parseDouble(estimateVo.getEst_area());
			mav.addObject("est_area2", Math.ceil(est_area2*0.3025));
			List<Object> fieldList = null;
			List<Object> fieldList2 = null;
			fieldList = estimateService.select_allField();
			fieldList2 = estimateService.select_YandNField(map);
			mav.addObject("fieldList", fieldList);
			mav.addObject("fieldList2", fieldList2);
			
			List<Object> setEstimateList = null;
	    	setEstimateList = estimateService.getSetEstimateList(map);
	    	mav.addObject("list", setEstimateList);
	    	mav.addObject("est_no", map.get("est_no"));
	    	System.out.println(setEstimateList);		
			
			return mav;
		}
		
		//관리자 견적 삭제
		@RequestMapping(value="admin_estimateDelete.do")
		ModelAndView admin_estimateDelete(@RequestParam Map<String, Object> map){
			estimateService.delete_estimate(map);
			ModelAndView mav = new ModelAndView("redirect:/admin/admin_estimate.do?pageNum=1");
			return mav;
		}
		
		//관리자 현장 게시판, 한줄게시판 공지사항
		@RequestMapping(value="admin_c_m_board.do")
		ModelAndView admin_c_m_board(HttpServletRequest req,HttpServletResponse res,HttpSession session,CommunityVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_c_s_board");
			
			List<Object> c_s_board_list = adminService.admin_c_s_board_list(vo);
			
			mv.addObject("c_s_code",req.getParameter("c_s_code"));
			mv.addObject("list", c_s_board_list);
			mv.addObject("pageNum",req.getParameter("pageNum"));
			return mv;
			
		}
		
		//관리자 현장 게시판, 한줄게시판 상세내용
		@RequestMapping(value="c_s_board_detail.do")
		ModelAndView c_s_board_detail(HttpServletRequest req,HttpServletResponse res,HttpSession session,CommunityVO vo){
			
			ModelAndView mv = new ModelAndView("admin/c_s_board_updateMain");
			
			List<Object> c_s_board_updateMain = adminService.admin_c_s_board_updateMain(vo);
			
			mv.addObject("list", c_s_board_updateMain);
			
			return mv;
			
		}
		
		//관리자 현장 게시판, 한줄게시판 상세내용
		@RequestMapping(value="c_s_board_update.do")
		ModelAndView c_s_board_update(HttpServletRequest req,HttpServletResponse res,HttpSession session,CommunityVO vo){
			
			ModelAndView mv = new ModelAndView("admin/c_s_board_updateMain");
			
			System.out.println(vo.toString());
			adminService.admin_c_s_board_update(vo);
			
			List<Object> c_s_board_updateMain = adminService.admin_c_s_board_updateMain(vo);
			
			mv.addObject("result", "1");
			mv.addObject("list", c_s_board_updateMain);
			
			return mv;
			
		}
		
		//관리자 자주묻는질문 입력 메인
		@RequestMapping(value="c_s_board_insertMain.do")
		ModelAndView c_s_board_insertMain(){
			
			ModelAndView mv = new ModelAndView("admin/c_s_board_insertMain");
			return mv;
			
		}
		//관리자 자주묻는질문 입력 메인
		@RequestMapping(value="c_s_board_insert.do")
		ModelAndView c_s_board_insert(HttpServletRequest req,HttpServletResponse res,HttpSession session,CommunityVO vo){
			
			ModelAndView mv = new ModelAndView("admin/admin_c_s_board");
			
			adminService.admin_c_s_board_insert(vo);			
			List<Object> c_s_board_list = adminService.admin_c_s_board_list(vo);
			
			mv.addObject("result","1");
			mv.addObject("c_s_code",req.getParameter("c_s_code"));
			mv.addObject("list", c_s_board_list);
			mv.addObject("pageNum","1");
			
			return mv;	
		}
		
		//한줄 게시판 메인
		@RequestMapping(value="admin_community.do")
		ModelAndView community_main(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cm_use_yn",req.getParameter("cm_use_yn") );
			map.put("search", req.getParameter("search"));
			
			List<Object> list = adminService.community_list(map);
			
			ModelAndView mv = new ModelAndView("admin/admin_community");
			
			mv.addObject("text", req.getParameter("search"));
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("list", list);
			mv.addObject("cm_use_yn", vo.getCm_use_yn());
			
			return mv;
		}
		
		//한줄 게시판 메인
		@RequestMapping(value="admin_communityDetail.do")
		ModelAndView admin_communityDetail(HttpServletRequest req,HttpServletResponse res,CommunityVO vo){

			List<Object> detail = adminService.community_detail(vo);
			List<Object> reply_list = adminService.community_detail_reply(vo);
			
			ModelAndView mv = new ModelAndView("admin/community_updateMain");
			
			mv.addObject("cm_no", req.getParameter("cm_no"));
			mv.addObject("reply_no", req.getParameter("reply_no"));
			mv.addObject("gubun", req.getParameter("gubun"));
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("list", detail);
			mv.addObject("reply_list", reply_list);
			
			return mv;
		}
		
			
		//관리자 카테고리 업데이트 메소드
		@RequestMapping(value="community_update.do")
		ModelAndView community_update(HttpServletRequest req,HttpServletResponse res,HttpSession session , CommunityVO vo){
			
			ModelAndView mv = new ModelAndView();
			
			adminService.community_update(vo);
			
			mv.setViewName("jsonView");
			return mv;
		}
		
		//관리자 카테고리 업데이트 메소드
		@RequestMapping(value="reply_update.do")
		ModelAndView reply_update(HttpServletRequest req,HttpServletResponse res,HttpSession session , CommunityVO vo){
			
			ModelAndView mv = new ModelAndView();
			
			adminService.reply_update(vo);
			
			mv.setViewName("jsonView");
			return mv;
			
		}
			
		//한줄 게시판 메인
		@RequestMapping(value="admin_report.do")
		ModelAndView admin_report(HttpServletRequest req,HttpServletResponse res,ReportVO vo){
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("gubun_code", req.getParameter("gubun_code"));
			map.put("search", req.getParameter("search"));
			
			List<Object> list = adminService.report_list(map);
			
			ModelAndView mv = new ModelAndView("admin/admin_report");
			
			mv.addObject("gubun_code", req.getParameter("gubun_code"));
			mv.addObject("search", req.getParameter("search"));
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("list", list);
			
			return mv;
		}
		
		//한줄 게시판 메인
		@RequestMapping(value="admin_charge.do")
		ModelAndView admin_charge(HttpServletRequest req,HttpServletResponse res,MemberVO vo){
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("charge_day", req.getParameter("charge_day"));
			
			List<Object> list = adminService.admin_charge(map);
			
			ModelAndView mv = new ModelAndView("admin/admin_charge");
			
			mv.addObject("charge_day", req.getParameter("charge_day"));
			mv.addObject("pageNum", req.getParameter("pageNum"));
			mv.addObject("list", list);
			
			return mv;
		}
		
		@RequestMapping(value="admin_charge_pushAlram.do")
		ModelAndView admin_charge_pushAlram(HttpServletRequest req,HttpServletResponse res,MemberVO vo){
			
			
			ModelAndView mv = new ModelAndView("");
			
			String android = req.getParameter("android");
			String ios = req.getParameter("ios");
			String title = "공사콕커입니다.";
			String message = req.getParameter("message");
			ArrayList<String> regList = new ArrayList<String>();
			ArrayList<String> iosRegList = new ArrayList<String>();
			
			//조현민 모든 안드로이드 hp_reg_id 가져와서알림보내기
			if(!android.equals("")){
				String[] copy1 = android.split(",");
				for(int i = 0 ; i<copy1.length;i++){
					regList.add(copy1[i]);
				}
				if(regList.size() > 0){
					sender.postMultiGCM( regList, title, "notice", message );
				}
			}
			
			//조현민 모든 ios hp_reg_id 가져와서알림보내기
			if(!ios.equals("")){
				String[] copy2 = ios.split(",");
				for(int i = 0 ; i<copy2.length;i++){
					iosRegList.add(copy2[i]);
				}
				if(iosRegList.size() > 0){
					sender.postMultiIosGCM(iosRegList, title, "notice", message );
				}
			}
			//알림보내기끝
			
			mv.setViewName("jsonView");
			
			return mv;
		}
		
		//현장스토리 관리자 메인 페이지 이동
		@RequestMapping(value="admin_fieldStory.do")
		public ModelAndView fieldStory(@RequestParam Map<String, Object> pMap){
			ModelAndView mav = new ModelAndView("admin/admin_fieldStory");
			return mav;
		}
		
		//검색 결과
		@RequestMapping(value="/search_fieldStory.do")
		public ModelAndView search_fieldStory(@RequestParam Map<String, Object> pMap){		
			//페이징 처리
			String pageNum = pMap.get("pageNum").toString();		
			pMap.put("page", pageNum);
			pMap.put("rows", "5"); // 페이지당 몇개의 행을 보여줄 것인지
			pMap.put("pageCnt", "5"); // 페이지를 몇 페이지로 나눌 것인지	
			
			Map<String, Object> fieldStory_list = null;
			fieldStory_list = adminService.admin_getFieldStoryWeb(pMap);
//			fieldStory_list = fieldStoryService.getFieldStory(fieldStoryVo);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("jsonView");
			mav.addObject("fieldStory", fieldStory_list);
			System.out.println("seyun"+fieldStory_list);
			return mav;
		}
		
		// 현장스토리 상세 페이지 이동
		@RequestMapping(value="admin_fieldStoryDetails.do")
		public ModelAndView fieldStoryDetails(HttpServletRequest req,HttpServletResponse res,@RequestParam Map<String, Object> map){
			ModelAndView mav = new ModelAndView("admin/admin_fieldStoryDetails");
			FieldStoryVO fieldStoryVo = null;
			List<Object> fieldStoryAnswer = null;
			
			//메인 글 가져오기
			fieldStoryVo = (FieldStoryVO) adminService.admin_getFieldStory_fs_no(map);		
			mav.addObject("fieldStoryVo", fieldStoryVo);
			
			//댓글 가져오기
			map.put("startNum", 0);
			map.put("endNum", 9999);
			fieldStoryAnswer = fieldStoryService.getFieldStory_answer(map);
			mav.addObject("fieldStoryAnswer", fieldStoryAnswer);
			mav.addObject("gubun", req.getParameter("gubun"));
			mav.addObject("fs_no", req.getParameter("fs_no"));
			mav.addObject("ans_no", req.getParameter("ans_no"));
			return mav;
		}
		
		//fieldStory 사용유무 변경
		@RequestMapping(value="modify_fieldStory.do")
		public ModelAndView modify_fieldStory(@RequestParam Map<String, Object> pMap){
			adminService.modify_fieldStory_use_yn(pMap);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("jsonView");
			return mav;
		}
		
		//fieldStory 댓글 삭제
		@RequestMapping(value="fieldStory_deleteAnswer.do")
		public ModelAndView fieldStory_deleteAnswer(@RequestParam Map<String, Object> pMap){
			adminService.delete_fieldStory_ans_no(pMap);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("jsonView");
			return mav;
		}
		
		
}

