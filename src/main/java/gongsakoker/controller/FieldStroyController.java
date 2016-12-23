package gongsakoker.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.helper.util.FileUtil;
import gongsakoker.service.FieldStroyService;
import gongsakoker.vo.FieldStoryVO;

@Controller
@RequestMapping(value="/fieldStory")
public class FieldStroyController {

	@Resource(name="gongsakoker.FieldStroyService")
	private FieldStroyService fieldStoryService;
	
	//메인 페이지 이동
	@RequestMapping(value="/mainList.do")
	public ModelAndView mainList(){
		List<Object> fieldStoryNotice_list = null;
		fieldStoryNotice_list = fieldStoryService.get_fieldStory_notice_list();
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_main");
		mav.addObject("fieldStoryNotice_list", fieldStoryNotice_list);
		return mav;
	}
	
	//검색 결과
	@RequestMapping(value="/search_fieldStory.do")
	public ModelAndView search_fieldStory(FieldStoryVO fieldStoryVo){
		List<Object> fieldStory_list = null;
		fieldStory_list = fieldStoryService.getFieldStory(fieldStoryVo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("fieldStory", fieldStory_list);
		return mav;
	}
	
	//글쓰기 페이지 이동
	@RequestMapping(value="/move_write.do")
	public ModelAndView move_write(){
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_write");
		return mav;
	}
	
	//fieldStory DB등록
	@RequestMapping(value="/fieldStory_write.do")
	public ModelAndView fieldStory_write(HttpServletRequest req, HttpServletResponse res, @RequestParam Map<String, Object> pMap, FieldStoryVO fieldStoryVo){
		
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
		
		//안드로이드 버전을 가져온다.
		String verCheck = (String) pMap.get("android_version_chk");
		//ㅇ
		
		for(int i=1; i<4; i++){
			//박종현 -- 안드로이드 버전을 체크해서 n이면 그대로 일반처리
			if(verCheck.equals("n")){
				MultipartFile file = multipartRequest.getFile("area_img_"+i);
				String check = file.getOriginalFilename();
				if(!check.isEmpty()){
					//안드로이드에서 온 파일제목에 ? 없애기
					
					System.out.println("check = " + check);
					String[] strs = check.split("\\?");
					String tempname = "";
					if(strs.length > 1) {
						tempname = strs[0] + strs[1];
					}else {
						tempname = strs[0];
					}
					String est_img = "img"+i+tempname;
					//여기까지
					
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
					String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
					int num = 0;
					String last = null;
					
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
			}else {
				//박종현 -- 안드로이드 버전을 체크해서 y이면 그대로 일반처리
				//4.4.2 안드로이드 처리
				String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
				int num = 0;
				String last = null;
				
				if(i==1){
					String oldfileDestPath = (String) pMap.get("destination1");
					String est_img = (String) pMap.get("fileNewName1");
					if(est_img.equals("")) {
						
					}else {
						num = est_img.lastIndexOf(".");
						last = est_img.substring(num);	
						File reName = new File(now+"img01"+last);
						//추가부분
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, reName.toString());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						
						File oldFile = new File(fileDestPath+est_img);
						fieldStoryVo.setImg01realName(est_img);
						fieldStoryVo.setImg01(now+"img01"+last);
					}
				}else if(i==2){
					String oldfileDestPath = (String) pMap.get("destination2");
					String est_img = (String) pMap.get("fileNewName2");
					if(est_img.equals("")) {
						
					}else {
						num = est_img.lastIndexOf(".");
						last = est_img.substring(num);
						File reName = new File(now+"img02"+last);	
						//추가부분
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, reName.toString());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						
						File oldFile = new File(fileDestPath+est_img);
						fieldStoryVo.setImg02realName(est_img);
						fieldStoryVo.setImg02(now+"img02"+last);
					}
				} else if(i==3){
					//추가부분
					String oldfileDestPath = (String) pMap.get("destination3");
					String est_img = (String) pMap.get("fileNewName3");
					//추가부분
					if(est_img.equals("")) {
						
					}else {
						num = est_img.lastIndexOf(".");
						last = est_img.substring(num);	
						File reName = new File(now+"img03"+last);
						
						//추가부분
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, reName.toString());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						
						File oldFile = new File(fileDestPath+est_img);
//						oldFile.renameTo(reName);
						fieldStoryVo.setImg03realName(est_img);
						fieldStoryVo.setImg03(now+"img03"+last);
					}
				}
				//여기까지 처리완료
			}
		}
		
		fieldStoryService.addFieldStory(fieldStoryVo);
		String member_no = fieldStoryVo.getMember_no();
		ModelAndView mav = new ModelAndView("redirect:/fieldStory/move_myList.do?member_no="+member_no+"&backCount=3");
		return mav;
	}
	
	//fieldStory details 페이지 이동
	@RequestMapping(value="/move_details.do")
	public ModelAndView move_details(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_details");
		FieldStoryVO fieldStoryVo = null;
		List<Object> fieldStoryAnswer = null;
		//메인 글 가져오기
		fieldStoryVo = (FieldStoryVO) fieldStoryService.getFieldStory_fs_no(map);		
		mav.addObject("fieldStoryVo", fieldStoryVo);
		
		//댓글 가져오기
		map.put("startNum", 0);
		map.put("endNum", 3);
		fieldStoryAnswer = fieldStoryService.getFieldStory_answer(map);
		mav.addObject("fieldStoryAnswer", fieldStoryAnswer);
		mav.addObject("endNum", 10);
		
		//추천 check
		Map<String, Object> recommend_check = null;
		recommend_check = (Map<String, Object>) fieldStoryService.check_recommendFieldStory(map);	
		mav.addObject("recommend_check", recommend_check.get("recommend_check"));
		
		//뒤로가기 설정
		mav.addObject("backCount", map.get("backCount"));
		
		return mav;
	}
	
	//댓글 더보기
	@RequestMapping(value="/more_answer.do")
	public ModelAndView more_answer(@RequestParam Map<String, Object> map){
		int startNum = Integer.parseInt((String) map.get("startNum"));
		int endNum = Integer.parseInt((String) map.get("endNum"));;
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		List<Object> fieldStoryAnswer_more = null;
		fieldStoryAnswer_more = fieldStoryService.getFieldStory_answer(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("fieldStoryAnswer_more", fieldStoryAnswer_more);
		endNum = endNum + 10;
		mav.addObject("endNum", endNum);
		return mav;
	}
	
	
	// 댓글 추가
	@RequestMapping(value="/fieldStory_addAnswer.do")
	public ModelAndView fieldStory_addAnswer(@RequestParam Map<String, Object> map){
		fieldStoryService.addFieldStory_answer(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory/move_details.do?fs_no="+map.get("fs_no")+"&backCount=2");
		return mav;
	}
	
	//댓글 수정
	@RequestMapping(value="/fieldStory_modifyAnswer.do")
	public ModelAndView fieldStory_modifyAnswer(@RequestParam Map<String, Object> map){
		fieldStoryService.updateFieldStory_answer(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory/move_details.do?fs_no="+map.get("fs_no")+"&backCount=2");
		return mav;
	}
	
	//댓글 삭제
	@RequestMapping(value="/fieldStory_deleteAnswer.do")
	public ModelAndView fieldStory_deleteAnswer(@RequestParam Map<String, Object> map){
		fieldStoryService.deleteFieldStory_answer(map);
		ModelAndView mav = new ModelAndView("redirect:/fieldStory/move_details.do?fs_no="+map.get("fs_no")+"&backCount=2");
		return mav;
	}
	
	//fieldStory 추천
	@RequestMapping(value="/add_recommend_fieldStory.do")
	public ModelAndView add_recommend_fieldStory(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView();
		Map<String, Object> recommend_check = null;
		recommend_check = (Map<String, Object>) fieldStoryService.add_recommendFieldStory(map);	
		mav.setViewName("jsonView");
		mav.addObject("recommend_check", recommend_check.get("recommend_check"));
		mav.addObject("recommend_count", recommend_check.get("count"));
		return mav;
	}
	
	//글 수정
	@RequestMapping(value="/modify_fieldStory.do")
	public ModelAndView modify_fieldStory(@RequestParam Map<String, Object> map){
		FieldStoryVO fieldStoryVo = null;
		//메인 글 가져오기
		fieldStoryVo = (FieldStoryVO) fieldStoryService.getFieldStory_fs_no(map);		
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_modify");
		mav.addObject("fieldStoryVo", fieldStoryVo);
		return mav;
	}
	
	//myList페이지 이동
	@RequestMapping(value="/move_myList.do")
	public ModelAndView move_myList(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_myList");
		System.out.println("|move_myList| " + map.toString());
		mav.addObject("member_no", map.get("member_no"));
		//뒤로가기 설정
		mav.addObject("backCount", map.get("backCount"));
		return mav;
	}
	
	//myList 데이터 가져오기
	@RequestMapping(value="/move_myList_search.do")
	public ModelAndView move_myList_search(@RequestParam Map<String, Object> map){
		List<Object> my_fieldStory_list = null;
		my_fieldStory_list = fieldStoryService.get_MyFieldStory(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("my_fieldStory_list", my_fieldStory_list);
		return mav;
	}
	
	//fieldStory_수정
	@RequestMapping(value="/fieldStory_dbModify.do")
	public ModelAndView fieldStory_dbModify(HttpServletRequest req, HttpServletResponse res, @RequestParam Map<String, Object> pMap, FieldStoryVO fieldStoryVo){
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
		
		
		//안드로이드 버전을 가져온다.
		String verCheck = (String) pMap.get("android_version_chk");
		
		
		for(int i=1; i<4; i++){
			//박종현 -- 안드로이드 버전을 체크해서 n이면 그대로 일반처리
			if(verCheck.equals("n")){
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
			}else {
				//박종현 -- 안드로이드 버전을 체크해서 y이면 그대로 일반처리
				//4.4.2 안드로이드 처리
				String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());
				int num = 0;
				String last = null;
				
				if(i==1){
					String oldfileDestPath = (String) pMap.get("destination1");
					String est_img = (String) pMap.get("fileNewName1");
					if(est_img.equals("")) {
						
					}else {
						num = est_img.lastIndexOf(".");
						last = est_img.substring(num);	
						File reName = new File(now+"img01"+last);
						//추가부분
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, reName.toString());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						
						File oldFile = new File(fileDestPath+est_img);
						
						oldFile.renameTo(reName);
						fieldStoryVo.setImg01realName(est_img);
						fieldStoryVo.setImg01(now+"img01"+last);
					}
				}else if(i==2){
					String oldfileDestPath = (String) pMap.get("destination2");
					String est_img = (String) pMap.get("fileNewName2");
					if(est_img.equals("")) {
						
					}else {
						num = est_img.lastIndexOf(".");
						last = est_img.substring(num);	
						File reName = new File(now+"img02"+last);
						//추가부분
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, reName.toString());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							System.out.println(" * 파일이 전송되지 않았습니다.");
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						
						File oldFile = new File(fileDestPath+est_img);
						
						fieldStoryVo.setImg02realName(est_img);
						fieldStoryVo.setImg02(now+"img02"+last);
					}
				} else if(i==3){
					//추가부분
					String oldfileDestPath = (String) pMap.get("destination3");
					String est_img = (String) pMap.get("fileNewName3");
					//추가부분
					if(est_img.equals("")) {
						
					}else {
						num = est_img.lastIndexOf(".");
						last = est_img.substring(num);	
						File reName = new File(now+"img03"+last);
						
						//추가부분
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, reName.toString());
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						
						File oldFile = new File(fileDestPath+est_img);
						
						fieldStoryVo.setImg03realName(est_img);
						fieldStoryVo.setImg03(now+"img03"+last);
					}
				}
				//여기까지 처리완료
			}
		}
		fieldStoryService.updateFieldStory(fieldStoryVo);
		String fs_no = fieldStoryVo.getFs_no();
		String member_no = fieldStoryVo.getMember_no();
		ModelAndView mav = new ModelAndView("redirect:/fieldStory/move_details.do?fs_no="+fs_no+"&member_no="+member_no+"&backCount=3");
		return mav;
	}
	
	//fieldStory 삭제
	@RequestMapping(value="/delete_fieldStory.do")
	public ModelAndView delete_fieldStory(@RequestParam Map<String, Object> map){
		
		fieldStoryService.deleteFieldStory(map);
		
		String returnPage = map.get("returnPage").toString();
		String returnMav = null;
		if(returnPage.equals("fieldStory_main")){
			returnMav = "redirect:/fieldStory/mainList.do";
		} else {
			returnMav = "redirect:/fieldStory/move_myList.do";
		}
		ModelAndView mav = new ModelAndView(returnMav);
		mav.addObject("member_no", map.get("member_no"));
		mav.addObject("backCount", "3");
		return mav;
	}
	
	//move_notice 공지사항 이동
	@RequestMapping(value="/move_notice.do")
	public ModelAndView move_notice(){
		List<Object> fieldStoryNotice_list = null;
		fieldStoryNotice_list = fieldStoryService.get_fieldStory_notice_list();
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_notice");
		mav.addObject("fieldStoryNotice_list", fieldStoryNotice_list);
		return mav;
	}
	
	//신고하기
	@RequestMapping(value="/add_fieldStorySingo.do")
	public ModelAndView add_fieldStorySingo(@RequestParam Map<String, Object> map){
		fieldStoryService.add_fieldStory_singo(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;
	}
	
	//사진확대 
	@RequestMapping(value="/img_expand.do")
	public ModelAndView img_expand(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("fieldStory/fieldStory_img_expand");
		mav.addAllObjects(map);		
		return mav;
	}
	
	/**
	 * 업체파일삭제
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/delCompanyFile.do")
	public ModelAndView delCompanyFile(HttpServletRequest req, HttpServletResponse res,	@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		int result = 0;
		
		try {
			result = this.fieldStoryService.delImgFile(pMap);
			
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;
	}
	
}
