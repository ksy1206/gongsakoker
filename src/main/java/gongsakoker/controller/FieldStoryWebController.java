package gongsakoker.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.helper.util.FileUtil;
import gongsakoker.service.FieldStroyService;
import gongsakoker.service.FieldStroyServiceWeb;
import gongsakoker.vo.FieldStoryVO;

@Controller
@RequestMapping(value="/fieldStory_web")
public class FieldStoryWebController {
	
	@Resource(name="gongsakoker.FieldStroyService")
	private FieldStroyService fieldStoryService;
	@Resource(name="gongsakoker.FieldStoryServiceWeb")
	private FieldStroyServiceWeb fieldStoryServiceWeb;
	
	//메인 페이지 이동
	@RequestMapping(value="/mainList.do")
	public ModelAndView mainList(){		
		List<Object> fieldStoryNotice_list = null;
		fieldStoryNotice_list = fieldStoryService.get_fieldStory_notice_list();		
		ModelAndView mav = new ModelAndView("web/fieldStory/fieldStory_main");
		mav.addObject("fieldStoryNotice_list", fieldStoryNotice_list);
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
		fieldStory_list = fieldStoryServiceWeb.getFieldStoryWeb(pMap);
//		fieldStory_list = fieldStoryService.getFieldStory(fieldStoryVo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("fieldStory", fieldStory_list);
		System.out.println("seyun"+fieldStory_list);
		return mav;
	}
	
	//상세 페이지 이동
	@RequestMapping(value="/details.do")
	public ModelAndView details(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("web/fieldStory/fieldStory_details");
		FieldStoryVO fieldStoryVo = null;
		List<Object> fieldStoryAnswer = null;
		//메인 글 가져오기
		fieldStoryVo = (FieldStoryVO) fieldStoryService.getFieldStory_fs_no(map);		
		mav.addObject("fieldStoryVo", fieldStoryVo);
		
		//댓글 가져오기
		map.put("startNum", 0);
		map.put("endNum", 5);
		fieldStoryAnswer = fieldStoryService.getFieldStory_answer(map);
		mav.addObject("fieldStoryAnswer", fieldStoryAnswer);
		
		//추천 check
		Map<String, Object> recommend_check = null;
		recommend_check = (Map<String, Object>) fieldStoryService.check_recommendFieldStory(map);	
		mav.addObject("recommend_check", recommend_check.get("recommend_check"));			
		return mav;
	}

	//글쓰기 페이지 이동
	@RequestMapping(value="/posting.do")
	public ModelAndView posting(){
		ModelAndView mav = new ModelAndView("web/fieldStory/fieldStory_posting");
		return mav;
	}
	
	//fieldStory_web DB등록
	@RequestMapping(value="/fieldStory_web_write.do")
	public ModelAndView fieldStory_write(HttpServletRequest req, HttpServletResponse res, FieldStoryVO fieldStoryVo){
		
		HttpSession session = req.getSession();
		String doc_root = session.getServletContext().getRealPath("/upload");
		String os = System.getProperty("os.name");

		String fileDestPath = "";

		fileDestPath = doc_root + File.separator + "img_fieldStory"
				+ File.separator + fieldStoryVo.getMember_no()+"/";
		
		File destinationDir = new File(fileDestPath);
		if (!destinationDir.exists()) {
			destinationDir.mkdirs();
		}
		fieldStoryVo.setImg_path(fileDestPath);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
		
		
		for(int i=1; i<4; i++){
			MultipartFile file = multipartRequest.getFile("area_img_"+i);
			String check = file.getOriginalFilename();
			
			if(!check.isEmpty()){
				String est_img = "img"+i+file.getOriginalFilename();
				String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
				int num = 0;
				String last = null;
				
				File f = new File(fileDestPath+est_img);
				
				try {
					file.transferTo(f);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				if(i==1){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);				
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(now+"img01"+last);
					try {
						FileUtil.moveFile(oldFile.toString(), fileDestPath.toString(), reName.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					fieldStoryVo.setImg01realName(est_img);
					fieldStoryVo.setImg01(now+"img01"+last);					
				}else if(i==2){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);					
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(now+"img02"+last);
					try {
						FileUtil.moveFile(oldFile.toString(), fileDestPath.toString(), reName.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					fieldStoryVo.setImg02realName(est_img);
					fieldStoryVo.setImg02(now+"img02"+last);
				} else if(i==3){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(now+"img03"+last);
					try {
						FileUtil.moveFile(oldFile.toString(), fileDestPath.toString(), reName.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					fieldStoryVo.setImg03realName(est_img);
					fieldStoryVo.setImg03(now+"img03"+last);
				}
			}
		}
		
		fieldStoryService.addFieldStory(fieldStoryVo);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory_web/mainList.do");
		return mav;
	}
	
	//내가 쓴글 페이지 이동
	@RequestMapping(value="/fieldStory_myList.do")
	public ModelAndView fieldStory_myList(@RequestParam Map<String, Object> pMap){		
		List<Object> fieldStoryNotice_list = null;
		fieldStoryNotice_list = fieldStoryService.get_fieldStory_notice_list();		
		ModelAndView mav = new ModelAndView("web/fieldStory/fieldStory_myList");
		mav.addObject("fieldStoryNotice_list", fieldStoryNotice_list);
		mav.addObject("member_no", pMap.get("member_no"));
		return mav;
	}
	
	// 댓글 추가
	@RequestMapping(value="/fieldStory_addAnswer.do")
	public ModelAndView fieldStory_addAnswer(@RequestParam Map<String, Object> map){
		fieldStoryService.addFieldStory_answer(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory_web/details.do?fs_no="+map.get("fs_no"));
		return mav;
	}
	
	//댓글 수정
	@RequestMapping(value="/fieldStory_modifyAnswer.do")
	public ModelAndView fieldStory_modifyAnswer(@RequestParam Map<String, Object> map){
		fieldStoryService.updateFieldStory_answer(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory_web/details.do?fs_no="+map.get("fs_no"));
		return mav;
	}
	
	//댓글 삭제
	@RequestMapping(value="/fieldStory_deleteAnswer.do")
	public ModelAndView fieldStory_deleteAnswer(@RequestParam Map<String, Object> map){
		fieldStoryService.deleteFieldStory_answer(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory_web/details.do?fs_no="+map.get("fs_no"));
		return mav;
	}
	
	//글 수정
	@RequestMapping(value="/modify_fieldStory.do")
	public ModelAndView modify_fieldStory(@RequestParam Map<String, Object> map){
		FieldStoryVO fieldStoryVo = null;
		//메인 글 가져오기
		fieldStoryVo = (FieldStoryVO) fieldStoryService.getFieldStory_fs_no(map);		
		ModelAndView mav = new ModelAndView("web/fieldStory/fieldStory_modify");
		mav.addObject("fieldStoryVo", fieldStoryVo);
		return mav;
	}
	
	//fieldStory_수정
	@RequestMapping(value="/fieldStory_dbModify.do")
	public ModelAndView fieldStory_dbModify(HttpServletRequest req, HttpServletResponse res, FieldStoryVO fieldStoryVo){
		HttpSession session = req.getSession();
		String doc_root = session.getServletContext().getRealPath("/upload");
		String os = System.getProperty("os.name");

		String fileDestPath = "";

		fileDestPath = doc_root + File.separator + "img_fieldStory"
				+ File.separator + fieldStoryVo.getMember_no()+"/";
		
		File destinationDir = new File(fileDestPath);
		if (!destinationDir.exists()) {
			destinationDir.mkdirs();
		}
		fieldStoryVo.setImg_path(fileDestPath);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
		
		
		for(int i=1; i<4; i++){
			MultipartFile file = multipartRequest.getFile("area_img_"+i);
			String check = file.getOriginalFilename();
			
			if(!check.isEmpty()){
				String est_img = "img"+i+file.getOriginalFilename();
				String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
				int num = 0;
				String last = null;
				
				File f = new File(fileDestPath+est_img);
				
				try {
					file.transferTo(f);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				if(i==1){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);				
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(now+"img01"+last);
					try {
						FileUtil.moveFile(oldFile.toString(), fileDestPath.toString(), reName.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					fieldStoryVo.setImg01realName(est_img);
					fieldStoryVo.setImg01(now+"img01"+last);					
				}else if(i==2){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);					
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(now+"img02"+last);
					try {
						FileUtil.moveFile(oldFile.toString(), fileDestPath.toString(), reName.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					fieldStoryVo.setImg02realName(est_img);
					fieldStoryVo.setImg02(now+"img02"+last);
				} else if(i==3){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(now+"img03"+last);
					try {
						FileUtil.moveFile(oldFile.toString(), fileDestPath.toString(), reName.toString());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					fieldStoryVo.setImg03realName(est_img);
					fieldStoryVo.setImg03(now+"img03"+last);
				}
			}
		}
		fieldStoryService.updateFieldStory(fieldStoryVo);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory_web/details.do?fs_no="+fieldStoryVo.getFs_no()+"&member_no="+fieldStoryVo.getMember_no());
		return mav;
	}
	
	//fieldStory 삭제
	@RequestMapping(value="/delete_fieldStory.do")
	public ModelAndView delete_fieldStory(@RequestParam Map<String, Object> map){		
		fieldStoryService.deleteFieldStory(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory_web/fieldStory_myList.do?member_no="+map.get("member_no"));
		return mav;
	}

}
