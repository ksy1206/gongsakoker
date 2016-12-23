package gongsakoker.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import gongsakoker.helper.exception.BusinessException;
import gongsakoker.service.AppMainService;
import gongsakoker.vo.AdminVO;
import gongsakoker.vo.MapVO;
import gongsakoker.vo.MemberVO;

@Controller
@RequestMapping(value = "/appMain")
public class AppMainController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "gongsakoker.appMainService")
	private AppMainService appMainService;

	@RequestMapping(value = "/appMain.do")
	public ModelAndView callAppMain(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) {
		
		
		ModelAndView mv = new ModelAndView("/appMain/appMain");
		log.debug("인터셉터테스트");
		
		/*
		 * 박종현 버전체크
		 */
		HttpSession session = req.getSession(true);
		
		if(pMap.get("app_version")!=null){
	         session.setAttribute("androidData",pMap.get("app_version").toString());
		}
		if(pMap.get("ios_app_version") != null) {		
			 session.setAttribute("iosData",pMap.get("ios_app_version").toString());
		 }
		return mv;
		
	}

	//앱 로그인
	@RequestMapping(value = "/appLogin.do")
	public ModelAndView callAppLogin(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) {
		String hp_reg_id = (String) pMap.get("hp_reg_id");
		String login_id = (String) pMap.get("login_id");
		System.out.println("loginId = " + login_id);
		System.out.println("hp_reg_Id = " + hp_reg_id);
	
	
		Map<String, Object> rMap = new HashMap<String, Object>();
		if(login_id!=null){
			
			rMap.put("hp_reg_id", hp_reg_id);
			rMap.put("member_id", login_id);

			 HttpSession session = req.getSession(true);
			 if(pMap.get("app_version") != null) {
				 session.setAttribute("androidData",pMap.get("app_version").toString());
				 appMainService.updatehp_reg_id(rMap);
			 } 
			 if(pMap.get("ios_app_version") != null) {		
				 session.setAttribute("iosData",pMap.get("ios_app_version").toString());
				 appMainService.updateios_reg_id(rMap);
			 }
			
			ModelAndView mv = new ModelAndView("/appMain/appMain");
			log.debug("인터셉터테스트");
			return mv;	
		}else{
			return callAppMain(req, res, pMap);
		}
		
	}

	@RequestMapping(value = "/areaBoard.do")
	public ModelAndView callAreaBoard() {
		ModelAndView mv = new ModelAndView("/board/areaboard");
		log.debug("인터셉터 테스트");
		return mv;

	}

	@RequestMapping(value = "/getKoker.do")
	public ModelAndView getKoker(HttpServletRequest req, HttpServletResponse res
			, @RequestParam Map<String, Object> pMap) throws Exception {
		
		String latitude = (String) pMap.get("latitude");
		String longitude = (String) pMap.get("longitude");
		double adius = Double.parseDouble((String) pMap.get("adius"));
		String member_no = (String) pMap.get("member_no");
		
		log.debug("latitude = " + latitude
					+ ", longitude = " +  longitude
					+ ", adius = " +  adius
					+ ", member_no = " +  member_no);
			
		Map map = new HashMap();
		map.put("member_no", member_no);
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		List<Object> lo= this.appMainService.selectMapList(map);
		
		Iterator<Object> it = lo.iterator();
		MapVO mvo = new MapVO();
		
		List<MapVO> kokerList = new ArrayList<MapVO>();
		List<MapVO> kokerListRank = new ArrayList<MapVO>();
		List<MapVO> kokerListBook = new ArrayList<MapVO>();
		
		while (it.hasNext()) {
			mvo = (MapVO) it.next();
			double resultDis = calDistance(latitude, longitude, mvo.getLatitude(), mvo.getLongitude());
			
			if (resultDis < adius) {

				String distance = Double.toString(Math.round((resultDis/1000)*100d) / 100d);
				mvo.setDistance(distance + " Km");
				
				kokerList.add(mvo);
				if (!mvo.getRanking().equals("0")) {
					kokerListRank.add(mvo);
				}
				if (!mvo.getBookmark_no().equals("0")) {
					kokerListBook.add(mvo);
				}
			}
		}
		
		rMap.put("kokerList", kokerList);
		rMap.put("kokerListRank", kokerListRank);
		rMap.put("kokerListBook", kokerListBook);

		ModelAndView mv = new ModelAndView();
		mv.addAllObjects(rMap);
		mv.setViewName( "jsonView");
		
		return mv;

	}
	
    @RequestMapping(value= "/search.do")
    public ModelAndView search() {
     ModelAndView mv = new ModelAndView( "/appMain/search");
     log.debug("인터셉터 테스트");
     return mv;
     
    }

    @RequestMapping(value= "/searchList.do")
    public ModelAndView searchList() {
     ModelAndView mv = new ModelAndView( "/appMain/searchList");
     log.debug("인터셉터 테스트");
     return mv;
     
    }

	@RequestMapping(value = "/guide.do")
	ModelAndView guide() {
		ModelAndView mav = new ModelAndView("guide/guide");
		return mav;
	}

	@RequestMapping(value = "/clause.do")
	ModelAndView clause() {
		ModelAndView mav = new ModelAndView("clause/clause_list");
		return mav;
	}

	// 비밀번호찾기
	@RequestMapping(value = "/updatePush_yn.do")
	public ModelAndView updatePush_yn(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		String push_yn = "";
		int result = 0;

		try {
			push_yn = this.appMainService.getPush_yn(pMap);
			if (push_yn.equals("y")) {
				push_yn = "n";
			} else {
				push_yn = "y";
			}
			
			
			 Map sessionData = null;
			 MemberVO memberVO = null;
			 
			 HttpSession session = req.getSession(true);

		    if (session.getAttribute("sessionData") != null) {
		        sessionData = (Map)session.getAttribute("sessionData");
		        memberVO = (MemberVO)sessionData.get("memberInfo");
		        memberVO.setPush_yn(push_yn);
		        rMap.put("memberInfo",memberVO);
		        session.setAttribute("sessionData",  rMap); 
		    } 

			pMap.put("push_yn", push_yn);
			result = this.appMainService.updatePush_yn(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("push_yn", push_yn);
		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 유료회원 남은시간 로딩
	@RequestMapping(value = "/getChargeCountDown.do")
	public ModelAndView getChargeCountDown(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		String spare_time = "";

		try {

			spare_time = this.appMainService.getChargeCountDown(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("spare_time", spare_time);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;
	}
	
	//내 위치 거리 구하기
	public double calDistance(String strLat1, String strLon1, String strLat2, String strLon2){  
		
		double lat1 = Double.parseDouble(strLat1);
		double lon1 = Double.parseDouble(strLon1);
		double lat2 = Double.parseDouble(strLat2);
		double lon2 = Double.parseDouble(strLon2);
	    
	    double theta, dist;  
	    theta = lon1 - lon2;  
	    dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1))   
	          * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));  
	    dist = Math.acos(dist);  
	    dist = rad2deg(dist);  
	      
	    dist = dist * 60 * 1.1515;   
	    dist = dist * 1.609344;    // 단위 mile 에서 km 변환.  
	    dist = dist * 1000.0;      // 단위  km 에서 m 로 변환  
	  
	    return dist;  
	    
	}  
	  
	    // 주어진 도(degree) 값을 라디언으로 변환  
	private double deg2rad(double deg){  
	    return (double)(deg * Math.PI / (double)180d);  
	}  
	  
	    // 주어진 라디언(radian) 값을 도(degree) 값으로 변환  
	private double rad2deg(double rad){  
	    return (double)(rad * (double)180d / Math.PI);  
	} 

	//앱메인 카테고리
	@RequestMapping(value = "/mainCategory.do")
	public ModelAndView getCategory(HttpSession session , HttpServletRequest req, HttpServletResponse res,MemberVO vo) throws BusinessException {

		ModelAndView mv = new ModelAndView("/appMain/category");
		
		mv.addObject("address", req.getParameter("address"));
		mv.addObject("class_code",req.getParameter("class_code"));
		mv.addObject("latitude", req.getParameter("latitude"));
		mv.addObject("longitude", req.getParameter("longitude"));
		mv.addObject("adius", req.getParameter("adius"));
		mv.addObject("chk_code", req.getParameter("chk_code"));
		mv.addObject("member_no", req.getParameter("member_no"));
		
		session.setAttribute("adius",vo.getAdius());
		session.setAttribute("chk_code",vo.getChk_code());
		
		return mv;
	}
	
	//앱메인 카테고리 리스트
	@RequestMapping(value = "/mainCategoryList.do")
	public ModelAndView getCategoryList(HttpSession session , HttpServletRequest req, HttpServletResponse res,MemberVO vo) throws BusinessException {

		ModelAndView mv = new ModelAndView();
		
		mv.addObject("class_code", vo.getClass_code());
		mv.addObject("latitude", vo.getLatitude());
		mv.addObject("longitude", vo.getLongitude());
		mv.addObject("adius",vo.getAdius());
		mv.addObject("chk_code", vo.getChk_code());
		mv.addObject("member_no",vo.getMember_no());
		mv.addObject("address",req.getParameter("address"));
		
		session.setAttribute("adius",vo.getAdius());
		session.setAttribute("chk_code",vo.getChk_code());
		
		List<Object> list= this.appMainService.categoryList(vo.getClass_code());
		mv.addObject("categoryList", list);
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	//앱메인 주변업체 리스트
	@RequestMapping(value = "/kokerListPage.do")
	public ModelAndView KokerList(HttpSession session,HttpServletRequest req, HttpServletResponse res,MemberVO vo) throws Exception {
        
		
		double getAdius = Double.parseDouble(vo.getAdius());
		
		ModelAndView mv = new ModelAndView("/appMain/kokerList");
		
		String category = req.getParameter("category");
		String chk_code = req.getParameter("chk_code");
		
		Map map = new HashMap();
		map.put("class_code", vo.getClass_code());
		map.put("member_no", vo.getMember_no());
		map.put("chk_code", chk_code);
		
		String str = "1=1";
			
		if(!category.equals("")){
			category  = category.replace(","," ");
			String[] ca = category.split(" ");
			
			for(int i = 0 ;i<ca.length;i++){
				if(i==0){
					str = "c." + ca[i] + " = 'y'";
				}else{
					str = str + " or c." + ca[i] + " = 'y'";
				}
			}	
		}
		map.put("category",str);

		String address = req.getParameter("address");
		try {
			
			//기술자일때
			if (vo.getClass_code().equals("03")) {
				
				address = address.replace(",", "");
				String[] result = address.split(" ");
				String editAddr = "";
				
				for(int i=0; i<2; i++){
					
					editAddr = editAddr + " " + result[i];
					
				}
				
				editAddr = editAddr.trim();
				map.put("address", editAddr);
				
				List<Object> kokerList = appMainService.selectKokerList03(map);
				
				Iterator<Object> it = kokerList.iterator();
				
				MemberVO mvo = new MemberVO();
				List<MemberVO> kokerSpecList = new ArrayList<MemberVO>();
				
				while (it.hasNext()) {
					mvo = (MemberVO) it.next();
					if (!mvo.getSpecial_no().equals("0")) {
						kokerSpecList.add(mvo);	
					}
				}
				
				mv.addObject("kokerList", kokerList);
				mv.addObject("kokerSpecList", kokerSpecList);
				
			} else {
				List<Object> lo= this.appMainService.selectKokerList(map);
				
				Iterator<Object> it = lo.iterator();
				MemberVO mvo = new MemberVO();
				
				List<MemberVO> kokerList = new ArrayList<MemberVO>();
				List<MemberVO> kokerSpecList = new ArrayList<MemberVO>();
				
				while (it.hasNext()) {
					mvo = (MemberVO) it.next();
					double resultDis = calDistance(vo.getLatitude(),vo.getLongitude(), mvo.getLatitude(), mvo.getLongitude());
					
					if (resultDis < getAdius) {
						String distance = Double.toString(Math.round((resultDis/1000)*100d) / 100d);
						mvo.setDistance(distance);
						// + " Km"
						kokerList.add(mvo);
						if (!mvo.getSpecial_no().equals("0")) {
							kokerSpecList.add(mvo);	
						}
					}
				}
				Collections.sort(kokerList, new Comparator<MemberVO>() {
					
			        @Override
			        public int compare(MemberVO  ojb1, MemberVO  ojb2) {

			            //return  ojb1.getDistance().compareTo(ojb2.getDistance().toString());
			            return  Double.compare(Float.parseFloat(ojb1.getDistance()),Float.parseFloat(ojb2.getDistance()));
			        }
			        
			    });

				Collections.sort(kokerSpecList, new Comparator<MemberVO>() {
					
			        @Override
			        public int compare(MemberVO  ojb1, MemberVO  ojb2) {

			            return  ojb1.getDistance().compareTo(ojb2.getDistance());
			        }
			        
			    });
				
				mv.addObject("kokerList", kokerList);
				mv.addObject("kokerSpecList", kokerSpecList);
			}
			
			session.setAttribute("adius",vo.getAdius());
			session.setAttribute("chk_code",vo.getChk_code());
			
			mv.addObject("latitude", vo.getLatitude());
			mv.addObject("longitude", vo.getLongitude());
			mv.addObject("adius", vo.getAdius());
			mv.addObject("class_code", vo.getClass_code());
			mv.addObject("category", category);
			mv.addObject("chk_code", vo.getChk_code());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mv;
	}

	@RequestMapping(value = "/mapList.do")
	public ModelAndView kokerMapList(HttpSession session , HttpServletRequest req, HttpServletResponse res,MemberVO vo) throws Exception {
	
		double getAdius = Double.parseDouble(vo.getAdius());
	
		String category = req.getParameter("category");
		String chk_code = req.getParameter("chk_code");
		
		ModelAndView mv = new ModelAndView("/appMain/kokerMapList");
		
		Map map = new HashMap();
		
		map.put("class_code", vo.getClass_code());
		map.put("member_no", vo.getMember_no());
		map.put("chk_code", chk_code);
		String str = "1=1";
		if(!category.equals("")){
			category  = category.replace(","," ");
			String[] ca = category.split(" ");
			for(int i = 0 ;i<ca.length;i++){
				if(i==0){
					str = "c." + ca[i] + " = 'y'";
				}else{
					str = str + " or c." + ca[i] + " = 'y'";
				}
			}	
		}
		map.put("category",str);
		
		try {
			
			List<Object> lo= this.appMainService.selectKokerList(map);
			
			Iterator<Object> it = lo.iterator();
			MemberVO mvo = new MemberVO();
			
			List<MemberVO> kokerList = new ArrayList<MemberVO>();
			
			while (it.hasNext()) {
				mvo = (MemberVO) it.next();
				double resultDis = calDistance(vo.getLatitude(), vo.getLongitude(), mvo.getLatitude(), mvo.getLongitude());
				
				if (resultDis < getAdius) {
					String distance = Double.toString(Math.round((resultDis/1000)*100d) / 100d);
					mvo.setDistance(distance + " Km");
					
					kokerList.add(mvo);
				}
			}
			Collections.sort(kokerList, new Comparator<MemberVO>() {
				
		        @Override
		        public int compare(MemberVO  ojb1, MemberVO  ojb2) {

		            return  ojb1.getDistance().compareTo(ojb2.getDistance());
		        }
		        
		    });
			
			session.setAttribute("adius",vo.getAdius());
			session.setAttribute("chk_code",vo.getChk_code());
			
			mv.addObject("kokerList", kokerList);
			mv.addObject("latitude", vo.getLatitude());
			mv.addObject("longitude", vo.getLongitude());
			mv.addObject("adius", vo.getAdius());
			mv.addObject("class_code", vo.getClass_code());
			mv.addObject("category", category);
			mv.addObject("chk_code", vo.getChk_code());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return mv;
	
	}
	
	@RequestMapping(value = "/MapMarker.do")
	public ModelAndView kokerMapMarker(HttpServletRequest req, HttpServletResponse res,MemberVO vo) throws Exception {
		
		double getAdius = Double.parseDouble(vo.getAdius());
		String category = req.getParameter("category");
		String chk_code = req.getParameter("chk_code");
		
		Map map = new HashMap();
		map.put("class_code", vo.getClass_code());
		map.put("member_no", vo.getMember_no());
		map.put("chk_code", chk_code);
		String str = "1=1";
		if(!category.equals("")){
			category  = category.replace(","," ");
			String[] ca = category.split(" ");
			
			for(int i = 0 ;i<ca.length;i++){
				if(i==0){
					str = "c." + ca[i] + " = 'y'";
				}else{
					str = str + " or c." + ca[i] + " = 'y'";
				}
			}	
		}
		map.put("category",str);
		
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		List<Object> lo= this.appMainService.selectKokerList(map);
		
		Iterator<Object> it = lo.iterator();
		MemberVO mvo = new MemberVO();
		
		List<MemberVO> kokerList = new ArrayList<MemberVO>();
		
		while (it.hasNext()) {
			mvo = (MemberVO) it.next();
			double resultDis = calDistance(vo.getLatitude(), vo.getLongitude(), mvo.getLatitude(), mvo.getLongitude());
			
			if (resultDis < getAdius) {
				String distance = Double.toString(Math.round((resultDis/1000)*100d) / 100d);
				mvo.setDistance(distance + " Km");
				
				kokerList.add(mvo);
			}
		}
		Collections.sort(kokerList, new Comparator<MemberVO>() {
			
	        @Override
	        public int compare(MemberVO  ojb1, MemberVO  ojb2) {

	            return  ojb1.getDistance().compareTo(ojb2.getDistance());
	        }
	        
	    });

		rMap.put("kokerList", kokerList);
		
		ModelAndView mv = new ModelAndView();
		mv.addAllObjects(rMap);
		mv.setViewName("jsonView");
	
		return mv;
	
	}
	
}
