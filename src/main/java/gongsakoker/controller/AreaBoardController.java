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


import gongsakoker.service.AreaBoardService;
import gongsakoker.vo.LocalBoardVO;

@Controller
@RequestMapping(value="areaBoard")
public class AreaBoardController {
	
	@Resource(name="gongsakoker.AreaBoardService")
	private AreaBoardService areaBoardService;

	@RequestMapping(value="areaBoardMain.do")
	ModelAndView areaBoardMain(){
		Map<String, Object> rMap = new HashMap<String, Object>();
		rMap = (Map<String, Object>) areaBoardService.getCategoryData();
		ModelAndView mav = new ModelAndView("board/fieldStory_main");
		mav.addObject("categoryData", rMap);
		System.out.println(rMap);
		return mav;
	}
	
	@RequestMapping(value="search_areaBoard.do")
	ModelAndView search_areaBoard(LocalBoardVO localBoardVo){
		List<Object> getLocalBoard = null;
		getLocalBoard = areaBoardService.getLocalBoard(localBoardVo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		mav.addObject("areaBoard", getLocalBoard);
		return mav;
	}
	
	@RequestMapping(value="moveWrite.do")
	ModelAndView moveWrite(){
		ModelAndView mav = new ModelAndView("board/boardWrite");
		return mav;		
	}
	
	@RequestMapping(value="add_areaBoard.do")
	ModelAndView add_areaBoard(LocalBoardVO localBoardVo, HttpServletRequest req, HttpServletResponse res){
		
		HttpSession session = req.getSession();
		String doc_root = session.getServletContext().getRealPath("/upload");
		String os = System.getProperty("os.name");

		String fileDestPath = "";

		fileDestPath = doc_root + File.separator + "img_area_board"
				+ File.separator + localBoardVo.getMember_no()+"\\";
		
		File destinationDir = new File(fileDestPath);
		if (!destinationDir.exists()) {
			destinationDir.mkdirs();
		}
		localBoardVo.setImg_path(fileDestPath);
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
					File reName = new File(fileDestPath+now+"img01"+last);
					oldFile.renameTo(reName);
					localBoardVo.setImg01(now+"img01"+last);
					
				}else if(i==2){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);
					
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(fileDestPath+now+"img02"+last);
					oldFile.renameTo(reName);
					localBoardVo.setImg02(now+"img02"+last);
				} else if(i==3){
					num = est_img.lastIndexOf(".");
					last = est_img.substring(num);
					
					File oldFile = new File(fileDestPath+est_img);
					File reName = new File(fileDestPath+now+"img03"+last);
					oldFile.renameTo(reName);
					localBoardVo.setImg03(now+"img03"+last);
				}
			}
		}
		areaBoardService.addLocalBoard(localBoardVo);
		System.out.println(localBoardVo);
		ModelAndView mav = new ModelAndView("redirect:/areaBoard/areaBoardMain.do");
		return mav;		
	}
	
	@RequestMapping(value="list_areaBoardMain.do")
	ModelAndView list_areaBoardMain(@RequestParam(value="member_no") int member_no){
		List<Object> getMemberLocalBoard = null;
		getMemberLocalBoard = areaBoardService.getMemberLocalBoard(member_no);
		ModelAndView mav = new ModelAndView("board/myList");
		mav.addObject("dataList", getMemberLocalBoard);
		System.out.println(getMemberLocalBoard);
		return mav;
	}
	
	@RequestMapping(value="areaBoard_modify.do")
	ModelAndView areaBoard_modify(LocalBoardVO localBoardVo){
		areaBoardService.modifyLocalBoard(localBoardVo);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;	
	}
	
	@RequestMapping(value="areaBoard_delete.do")
	ModelAndView areaBoard_delete(@RequestParam(value="board_no") int board_no){
		areaBoardService.deleteLocalBoard(board_no);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		return mav;	
	}
	
	@RequestMapping(value="areaboard_details.do")
	ModelAndView areaboard_details(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("");
		return mav;
	}
	
}
