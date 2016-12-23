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

import gongsakoker.helper.util.FileUtil;
import gongsakoker.service.EstimateService;
import gongsakoker.vo.EstimateVO;
import gongsakoker.vo.FieldStoryVO;
import gongsakoker.vo.MemberVO;

@Controller
@RequestMapping(value="/estimate")
public class EstimateController {

	@Resource(name="gongsakoker.EstimateService")
	private EstimateService estimateService;
	
	@RequestMapping(value="/test.do")
	public ModelAndView test(){
		ModelAndView mav = new ModelAndView("estimate/test");
		return mav;
	}	
	
	//맞춤견적 메인 페이지 이동
	@RequestMapping(value="/mainList.do")
	public ModelAndView mainList(@RequestParam Map<String, Object> pMap){		
		List<Object> list = null;
		list = estimateService.getList(pMap);
		ModelAndView mav = new ModelAndView("estimate/mainList");
		mav.addObject("list", list);
		mav.addObject("estType01_code", pMap.get("estType01_code"));
		mav.addObject("type01", pMap.get("type01"));
		mav.addObject("type02", pMap.get("type02"));
		return mav;
	}
	
	private Object parseString() {
		// TODO Auto-generated method stub
		return null;
	}

	//맞춤견적 페이지 이동
	@RequestMapping(value="/estimateCustom.do")
	public ModelAndView estimateCustom(){
		ModelAndView mav = new ModelAndView("estimate/estimateCustom");
		return mav;
	}
	
	//시공분야 설정 페이지 이동	
	@RequestMapping(value="/estimateField.do")
	public ModelAndView estimateField(@RequestParam(value="estType01_code") int estType01_code){
		List<Object> fieldList = null;
		fieldList = estimateService.select_allField();
		ModelAndView mav = new ModelAndView("estimate/estimateField");
		mav.addObject("estType01_code", estType01_code);
		mav.addObject("fieldList", fieldList);
		return mav;
	}
	
	//견적의뢰 페이지 이동
	@RequestMapping(value="/estimateWrite.do")
	public ModelAndView estimateWrite(EstimateVO estimateVo){
		ModelAndView mav = new ModelAndView("estimate/estimateWrite");
		mav.addObject("estimateVo", estimateVo);
		return mav;
	}
	
	//견적의뢰 DB등록
	@RequestMapping(value="/estimateInsert_.do")
	public ModelAndView estimateInsert_(EstimateVO estimateVo, HttpServletRequest req, HttpServletResponse res, @RequestParam Map<String, Object> pMap){
		
		HttpSession session = req.getSession();
		String doc_root = session.getServletContext().getRealPath("/upload");
		String os = System.getProperty("os.name");

		String fileDestPath = "";

		fileDestPath = doc_root + File.separator + "img_estimate"
				+ File.separator + estimateVo.getMember_no()+"/";
		
		File destinationDir = new File(fileDestPath);
		if (!destinationDir.exists()) {
			destinationDir.mkdirs();
		}
		estimateVo.setEst_imgPath(fileDestPath);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
		
		//안드로이드 버전을 가져온다.
		String verCheck = (String) pMap.get("android_version_chk");
		System.out.println("pMap = " + pMap);
		
		for(int i=1; i<4; i++){
			//박종현 -- 안드로이드 버전을 체크해서 n이면 그대로 일반처리
			if(verCheck.equals("n")){
				MultipartFile file = multipartRequest.getFile("est_img_"+i);
				String check = file.getOriginalFilename();
	
				if(!check.isEmpty()){
					String est_img = "img"+i+file.getOriginalFilename();
					
					if(i==1){
						estimateVo.setEst_img01(est_img);
					}else if(i==2){
						estimateVo.setEst_img02(est_img);
					} else if(i==3){
						estimateVo.setEst_img03(est_img);
					}
					
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
				}
			}else {
				//박종현 -- 안드로이드 버전을 체크해서 y이면 그대로 일반처리
				//4.4.2 안드로이드 처리
				
				
				if(i==1){
					String oldfileDestPath = (String) pMap.get("destination1");
					String est_img = (String) pMap.get("fileNewName1");
					if(est_img.equals("")) {
						
					}else {
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, est_img);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						File oldFile = new File(fileDestPath+est_img);
						File reName = new File(fileDestPath+"img"+i+est_img);
						oldFile.renameTo(reName);
						
						est_img = "img"+i+est_img;
						estimateVo.setEst_img01(est_img);
					}
				}else if(i==2){
					String oldfileDestPath = (String) pMap.get("destination2");
					String est_img = (String) pMap.get("fileNewName2");
					if(est_img.equals("")) {
						
					}else {
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, est_img);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						File oldFile = new File(fileDestPath+est_img);
						File reName = new File(fileDestPath+"img"+i+est_img);
						oldFile.renameTo(reName);
						
						est_img = "img"+i+est_img;
						estimateVo.setEst_img02(est_img);
					}
				} else if(i==3){
					String oldfileDestPath = (String) pMap.get("destination3");
					String est_img = (String) pMap.get("fileNewName3");
					if(est_img.equals("")) {
							
					}else {
						System.out.println(" * 임시 파일 경로 : " + oldfileDestPath);
						try {
							FileUtil.moveFile(oldfileDestPath, fileDestPath, est_img);
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
						System.out.println(" * 새로 저장된 파일 경로 : " + fileDestPath);
						System.out.println(" * 새로 저장된 파일 이름 : " + est_img);
						//추가부분
						File oldFile = new File(fileDestPath+est_img);
						File reName = new File(fileDestPath+"img"+i+est_img);
						oldFile.renameTo(reName);
						
						est_img = "img"+i+est_img;
						estimateVo.setEst_img03(est_img);
					}
				}
			}
			//여기까지 처리완료
		}
		
		estimateService.addEstimate(estimateVo);
		ModelAndView mav = new ModelAndView("redirect:/estimate/myList.do?est_state=n&member_no="+estimateVo.getMember_no());
		return mav;
	}
	
		//견적의뢰 DB등록
		@RequestMapping(value="/estimateInsert.do")
		public ModelAndView estimateInsert(EstimateVO estimateVo, HttpServletRequest req, HttpServletResponse res, @RequestParam Map<String, Object> pMap){
		
		HttpSession session = req.getSession();
		String doc_root = session.getServletContext().getRealPath("/upload");
		String os = System.getProperty("os.name");

		String fileDestPath = "";

		fileDestPath = doc_root + File.separator + "img_estimate"
				+ File.separator + estimateVo.getMember_no()+"/";
		
		File destinationDir = new File(fileDestPath);
		if (!destinationDir.exists()) {
			destinationDir.mkdirs();
		}
		estimateVo.setEst_imgPath(fileDestPath);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) req;
		
		//안드로이드 버전을 가져온다.
		String verCheck = (String) pMap.get("android_version_chk");
		//ㅇ
		
		for(int i=1; i<4; i++){
			//박종현 -- 안드로이드 버전을 체크해서 n이면 그대로 일반처리
			if(verCheck.equals("n")){
				MultipartFile file = multipartRequest.getFile("est_img_"+i);
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
						estimateVo.setEst_img01(now+"img01"+last);					
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
						estimateVo.setEst_img02(now+"img02"+last);
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
						estimateVo.setEst_img03(now+"img03"+last);
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
						estimateVo.setEst_img01(now+"img01"+last);
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
						estimateVo.setEst_img02(now+"img02"+last);
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
						estimateVo.setEst_img03(now+"img03"+last);
					}
				}
				//여기까지 처리완료
			}
		}
		
		estimateService.addEstimate(estimateVo);
		ModelAndView mav = new ModelAndView("redirect:/estimate/myList.do?est_state=n&member_no="+estimateVo.getMember_no());
		return mav;
	}
	
    @RequestMapping(value= "/search.do")
    public ModelAndView search() {
    	ModelAndView mv = new ModelAndView("/estimate/search");    
    	return mv;
    }   
    
    //검색리스트조회
    @RequestMapping(value= "/getSearchList.do")
    public ModelAndView getSearchList(@RequestParam Map<String, Object> pMap) {
    	System.out.println(pMap);
    	ModelAndView mav = new ModelAndView("/estimate/search_result");
    	List<Object> list = null;
		list = estimateService.getList_search(pMap);
		mav.addObject("list", list);
    	return mav;  
    }
    
    
    //소분류종류조회
    @RequestMapping(value= "/getEstType02List.do")
    public ModelAndView getEstType02List(HttpServletRequest req, HttpServletResponse res, @RequestParam Map<String, Object> pMap) {
    
     ModelAndView mv = new ModelAndView( "/estimate/search");
     List<Object> estType02List = null;
     Map<String, Object> rMap = new HashMap<String, Object>();
     
	     try {
	    	 estType02List = estimateService.getEstType02List(pMap);
		 } catch (Exception e) {
			System.out.println(e.toString());
		 }
    
	     rMap.put("estType02List", estType02List);
	     mv.addAllObjects(rMap);
	     mv.setViewName("jsonView");

     return mv;
     
    }
    
    //My List 페이지 이동
    @RequestMapping(value="/myList.do")
	public ModelAndView myList(@RequestParam Map<String, Object> pMap){
    	List<Object> myList = null;
    	myList = estimateService.getMyList(pMap);
		ModelAndView mav = new ModelAndView("estimate/myEstimate");
		mav.addObject("myList", myList);
		mav.addObject("myListCount", myList.size());
		mav.addObject("est_state", pMap.get("est_state"));
		return mav;
	}
    
    //상세페이지 이동
    @RequestMapping(value="/estimateDetails.do")
	public ModelAndView estimateDetails(@RequestParam Map<String, Object> pMap){
    	EstimateVO estimateVo = null;
    	estimateVo = (EstimateVO) estimateService.getEstimateDetails(pMap);
		
    	ModelAndView mav = new ModelAndView("estimate/estimateDetails");
		
		mav.addObject("estimateVo", estimateVo);
		double est_area2 = Double.parseDouble(estimateVo.getEst_area());
		mav.addObject("est_area2", Math.ceil(est_area2*0.3025));
		List<Object> fieldList = null;
		List<Object> fieldList2 = null;
		fieldList = estimateService.select_allField();
		fieldList2 = estimateService.select_YandNField(pMap);
		mav.addObject("fieldList", fieldList);
		mav.addObject("fieldList2", fieldList2);
		return mav;
	}
    
    //견적 삭제
    @RequestMapping(value="/estimateDelete.do")
    public ModelAndView estimateDelete(@RequestParam Map<String, Object> pMap){
    	estimateService.delete_estimate(pMap);
    	int member_no = Integer.parseInt(pMap.get("member_no").toString());
    	ModelAndView mav = new ModelAndView("redirect:/estimate/myList.do?member_no="+member_no+"&est_state=n");
    	return mav;
    }
    //맞춤견적 확인 페이지 이동
    @RequestMapping(value="/estimateConfirm.do")
    public ModelAndView estimateConfirm(@RequestParam Map<String, Object> pMap){
    	List<Object> setEstimateList = null;
    	setEstimateList = estimateService.getSetEstimateList(pMap);
    	ModelAndView mav = new ModelAndView("estimate/setEstimateResult");
    	mav.addObject("list", setEstimateList);
    	mav.addObject("est_no", pMap.get("est_no"));
    	mav.addObject("check_setEst_no", pMap.get("setEst_no"));
    	mav.addObject("est_state", pMap.get("est_state"));
    	return mav;
    }
    
    //맞춤견적 견적 작성 페이지 이동
    @RequestMapping(value="/estimateSubmit.do")
    public ModelAndView estimateSubmit(@RequestParam Map<String, Object> pMap){
    	Map<String, Object> rMap = estimateService.checkSetEstimate(pMap);
    	ModelAndView mav = new ModelAndView("estimate/estimateSubmit");
    	mav.addObject("est_no", pMap.get("est_no"));
    	mav.addObject("check", rMap.get("check"));
    	mav.addObject("estimateVo", rMap.get("estimateVo"));
    	mav.addObject("backCount", pMap.get("backCount"));
    	return mav;
    }
    
    //맞춤견적 DB등록
    @RequestMapping(value="/setEstimate.do")
    public ModelAndView setEstimate(EstimateVO estimateVo){
    	estimateService.addSetEstimate(estimateVo);
    	ModelAndView mav = new ModelAndView();
    	mav.setViewName("jsonView");
    	return mav;
    }
    
    //견적서 선택 DB등록
    @RequestMapping(value="/setEstimateChoice.do")
    public ModelAndView setEstimateChoice(@RequestParam Map<String, Object> pMap){
    	estimateService.addSetEstimate(pMap);
    	String est_no  = pMap.get("est_no").toString();
    	ModelAndView mav = new ModelAndView("redirect:/estimate/estimateDetails.do?est_no="+est_no);
    	return mav;
    }
    
    //견적서(답변 업체 견적) DB삭제
    @RequestMapping(value="/estimateSetDelete.do")
    public ModelAndView estimateSetDelete(@RequestParam Map<String, Object> pMap){
    	estimateService.delete_setEstimate(pMap);
    	String est_no  = pMap.get("est_no").toString();
    	String member_no  = pMap.get("member_no").toString();
    	ModelAndView mav = new ModelAndView("redirect:/estimate/estimateSubmit.do?est_no="+est_no+"&member_no="+member_no+"&backCount=3");
    	return mav;
    }
    
    //내가 쓴 견적서 리스트 
    @RequestMapping(value="/mySet_estimate.do")
    public ModelAndView mySet_estimate(@RequestParam Map<String, Object> pMap){
    	List<Object> myList = null;
    	myList = estimateService.getMy_setEstimate(pMap);
    	ModelAndView mav = new ModelAndView("estimate/mySetEstimate");
    	mav.addObject("myList", myList);
    	mav.addObject("est_state", pMap.get("est_state"));
    	return mav;
    }
    
  //내가 쓴 견적서 상세페이지
    @RequestMapping(value="/details_setEstimate.do")
    public ModelAndView details_setEstimate(@RequestParam Map<String, Object> pMap){
    	EstimateVO estimateVo = null;
    	estimateVo = (EstimateVO) estimateService.getEstimateDetails(pMap);
		
    	ModelAndView mav = new ModelAndView("estimate/estimateDetails_setEstimate");
		
		mav.addObject("estimateVo", estimateVo);
		double est_area2 = Double.parseDouble(estimateVo.getEst_area());
		mav.addObject("est_area2", Math.ceil(est_area2*0.3025));
		List<Object> fieldList = null;
		List<Object> fieldList2 = null;
		fieldList = estimateService.select_allField();
		fieldList2 = estimateService.select_YandNField(pMap);
		mav.addObject("fieldList", fieldList);
		mav.addObject("fieldList2", fieldList2);
		
		Map<String, Object> rMap = estimateService.checkSetEstimate(pMap);
    	mav.addObject("estimateVo2", rMap.get("estimateVo"));
		return mav;
    }
    
    //견적서(답변 업체 견적) DB삭제
    @RequestMapping(value="/mySetList_estimateSetDelete.do")
    public ModelAndView mySetList_estimateSetDelete(@RequestParam Map<String, Object> pMap){
    	estimateService.delete_setEstimate(pMap);
    	String est_no  = pMap.get("est_no").toString();
    	String member_no  = pMap.get("member_no").toString();
    	ModelAndView mav = new ModelAndView("redirect:/estimate/mySet_estimate.do?member_no="+member_no+"&est_state=n");
    	return mav;
    }
    
	//사진확대 
	@RequestMapping(value="/img_expand.do")
	public ModelAndView img_expand(@RequestParam Map<String, Object> map){
		ModelAndView mav = new ModelAndView("estimate/estimate_img_expand");
		mav.addAllObjects(map);		
		return mav;
	}
    
}
