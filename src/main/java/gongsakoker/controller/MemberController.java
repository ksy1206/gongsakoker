package gongsakoker.controller;

import java.io.File;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import gongsakoker.helper.exception.BusinessException;
import gongsakoker.helper.util.FileUtil;
import gongsakoker.service.BizlinkService;
import gongsakoker.service.MemberService;
import gongsakoker.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "gongsakoker.memberService")
	private MemberService memberService;
	@Resource(name = "gongsakoker.bizlinkService")
	private BizlinkService bizlinkService;

	// 인트로 페이지로딩
	@RequestMapping(value = "/intro.do")
	public ModelAndView intro() {

		ModelAndView mv = new ModelAndView("/member/intro");
		return mv;

	}

	// 회원가입 페이지로딩
	@RequestMapping(value = "/memberJoin.do")
	public ModelAndView memberJoin() {

		ModelAndView mv = new ModelAndView("/member/memberJoin");
		return mv;

	}

	// 정보관리 페이지로딩
	@RequestMapping(value = "/infoMng.do")
	public ModelAndView infoMng() {
		ModelAndView mv = new ModelAndView("/info/infoMng");
		return mv;

	}

	// 업체회원가입 페이지로딩
	@RequestMapping(value = "/companyJoin.do")
	public ModelAndView companyJoin() {

		ModelAndView mv = new ModelAndView("/member/companyJoin");
		return mv;

	}

	// 비밀번호찾기 페이지로딩
	@RequestMapping(value = "/findPw.do")
	public ModelAndView findPw() {

		ModelAndView mv = new ModelAndView("/member/findPw");
		return mv;

	}
	// 비밀번호찾기 페이지로딩 WEB
	@RequestMapping(value = "/findPw_web.do")
	public ModelAndView findPw_web()  {

		ModelAndView mv = new ModelAndView("/web/member/findPw_web");
		return mv;

	}
	// 로그인 페이지로딩
	@RequestMapping(value = "/memberLogin.do")
	public ModelAndView memberLogin(HttpServletRequest req, HttpServletResponse res,
			@CookieValue(value = "smart_key", defaultValue = "", required = false) String login_id)
					throws BusinessException {

		ModelAndView mv = new ModelAndView("/member/memberLogin");

		mv.addObject("save_login_id", "");
		// 쿠키값 여부에 따른 처리
		if (!login_id.equals("")) {
			mv.addObject("save_login_id", login_id);
		}

		return mv;

	}

	
	
	// web로그인 페이지로딩
	@RequestMapping(value = "/webLogin.do")
	public ModelAndView webLogin(HttpServletRequest req, HttpServletResponse res,
			@CookieValue(value = "smart_key", defaultValue = "", required = false) String login_id)
					throws BusinessException {
		ModelAndView mv = new ModelAndView("/web/member/webLogin");

		mv.addObject("save_login_id", "");
		// 쿠키값 여부에 따른 처리
		if (!login_id.equals("")) {
			mv.addObject("save_login_id", login_id);
		}

		return mv;

	}
	

	
	
	// 자동 로그인 페이지로딩
		@RequestMapping(value = "/auto_Login.do")
		public ModelAndView auto_Login(HttpServletRequest req, HttpServletResponse res)
						throws BusinessException {

			ModelAndView mv = new ModelAndView("/member/auto_Login");

			return mv;

		}


			


	// 아이디 중복확인
	@RequestMapping(value = "/checkMemberId.do")
	public ModelAndView checkMemberId(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		String member_id_chk = null;

		try {
			member_id_chk = this.memberService.getMemberIDCheck(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("member_id_chk", member_id_chk);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 회원가입
	@RequestMapping(value = "/insertMember_join.do")
	public ModelAndView insertMember_join(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		String member_join_chk = null;

		try {
			member_join_chk = this.memberService.insertMember_join(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("member_join_chk", member_join_chk);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 로그인
	@RequestMapping(value = "/doMember_login.do")
	public ModelAndView doMember_login(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		int resultCode = 0;
		String resultMsg = "";
		try {
			MemberVO member = this.memberService.getMemberInfo(pMap);

			if (member == null) {
				resultMsg = "ID 또는 비밀번호가 틀렸습니다.";
				resultCode = 0;
			} else {
				if (member.getMember_code().equals("02")) {
					resultMsg = "승인대기중입니다. 가입승인후 이용해주세요.";
					// resultCode = 2;
					resultCode = 1;
					HttpSession session = req.getSession(true);
					session.setAttribute("sessionData", rMap);
				} else if (member.getUse_yn().equals("n") && member.getMember_code().equals("03")) {
					resultMsg = "사용중지된 회원입니다. 업체에 문의해주세요.";
					resultCode = 2;

				} else {
					resultMsg = "로그인";
					resultCode = 1;
					HttpSession session = req.getSession(true);
					session.setAttribute("sessionData", rMap);
				}

			}

			rMap.put("memberInfo", member);
			rMap.put("resultCode", resultCode);
			rMap.put("resultMsg", resultMsg);

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	/**
	 * 로그아웃
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/doMember_logout.do")
	@SuppressWarnings("unchecked")
	public void doMember_logout(HttpServletRequest req, HttpServletResponse res) throws BusinessException {

		ModelAndView output = new ModelAndView();

		try {
			HttpSession session = req.getSession(true);
			Map<String, Object> sessionData = (Map<String, Object>) session.getAttribute("sessionData");

			if (sessionData != null) {
				String app_version = "";
				String ios_app_version = "";
				if (session.getAttribute("androidData") != null) {
					app_version = session.getAttribute("androidData").toString();
				}
				if (session.getAttribute("iosData") != null) {
					ios_app_version = session.getAttribute("iosData").toString();
				}
				session.removeAttribute("sessionData");
				session.invalidate();
				session = req.getSession(true);
			
				if(!app_version.equals("")){
					session.setAttribute("androidData", app_version);
				}
				if(!ios_app_version.equals("")){
					session.setAttribute("iosData", ios_app_version);
				}
					
			}

			String cp = req.getContextPath();
			res.sendRedirect(cp + "/appMain/appMain.do");
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		// return output;
	}
	/**
	 * 로그아웃_web
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/doMember_logout_web.do")
	@SuppressWarnings("unchecked")
	public void doMember_logout_web(HttpServletRequest req, HttpServletResponse res) throws BusinessException {

		ModelAndView output = new ModelAndView();

		try {
			HttpSession session = req.getSession(true);
			Map<String, Object> sessionData = (Map<String, Object>) session.getAttribute("sessionData");

			if (sessionData != null) {
				String app_version = "";
				if (session.getAttribute("androidData") != null) {
					app_version = session.getAttribute("androidData").toString();
				}
				session.removeAttribute("sessionData");
				session.invalidate();
				session = req.getSession(true);
				session.setAttribute("androidData", app_version);
			}

			String cp = req.getContextPath();
			res.sendRedirect(cp + "/web/gongsakoker.do");
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		// return output;
	}
	/**
	 * 세션체크
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/sessionCheck.do")
	@SuppressWarnings("unchecked")
	public ModelAndView sessionCheck(HttpServletRequest req, HttpServletResponse res) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {
			HttpSession session = req.getSession(true);
			Map<String, Object> sessionData = (Map<String, Object>) session.getAttribute("sessionData");

			if (sessionData != null)
				rMap.put("session", "Y");
			else
				rMap.put("session", "N");

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;
	}

	// 비밀번호찾기
	@RequestMapping(value = "/sendEmailPw.do")
	public ModelAndView sendEmailPw(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		int result = 0;

		try {
			result = this.memberService.sendEmailPw(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 업체종류 로딩
	@RequestMapping(value = "/getBusinessKind.do")
	public ModelAndView getBusinessKind(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {
			List<Object> kindList = this.memberService.getBusinessKind(pMap);
			rMap.put("kindList", kindList);

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 도 로딩
	@RequestMapping(value = "/getZip_area.do")
	public ModelAndView getZip_area(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {
			List<Object> areaList = this.memberService.getZip_area();
			rMap.put("areaList", areaList);

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 시군구 로딩
	@RequestMapping(value = "/getZip_city.do")
	public ModelAndView getZip_city(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {
			List<Object> cityList = this.memberService.getZip_city(pMap);
			rMap.put("cityList", cityList);

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	/**
	 * 업체파일업로드
	 * 
	 * @param req
	 * @param res
	 * @return ModelAndView
	 * @throws BusinessException
	 */
	@RequestMapping("/saveCompanyFile.do")
	public ModelAndView saveCompanyFile(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		int result = 0;

		try {

			HttpSession sesson = req.getSession();
			String doc_root = sesson.getServletContext().getRealPath("/upload");

			String fileDestPath = "";
			String member_id = pMap.get("member_id").toString();
			fileDestPath = doc_root + File.separator + "img" + File.separator + member_id;

			int file_cnt = Integer.parseInt(pMap.get("file_cnt").toString());

			String[] file_stat_arr = new String[1];

			if (file_cnt != 1) {
				file_stat_arr = null;
				file_stat_arr = pMap.get("file_stat").toString().split(",");
			} else {

				file_stat_arr[0] = pMap.get("file_stat").toString();
			}

			for (int i = 0; i < file_cnt; i++) {

				String fileUploadPath = (String) pMap.get("fileUploadPath" + file_stat_arr[i]);
				String orgName = (String) pMap.get("fileNewName" + file_stat_arr[i]);
				String destination = (String) pMap.get("destination" + file_stat_arr[i]);

				log.debug(" * 임시 파일 경로 : " + destination);
	
				if (!orgName.equals("") && !fileUploadPath.equals("")) {
					String temp_file_ext = orgName.substring(orgName.lastIndexOf(".") + 1);
					String temp_total_path = destination;
					Calendar calendar = Calendar.getInstance();
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddhhmmss");
					String today = dateFormat.format(calendar.getTime());
					String newName = member_id + today + "(" + i + ")." + temp_file_ext;
					// System.gc();
					FileUtil.moveFile(temp_total_path, fileDestPath, newName);

					log.debug(" * 새로 저장된 파일 경로 : " + fileDestPath);
					log.debug(" * 새로 저장된 파일 이름 : " + newName);

					rMap.put("fileUploadPath" + file_stat_arr[i], fileDestPath);
					rMap.put("fileNewName" + file_stat_arr[i], newName);
				}
			}

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("resultCode", result);

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;
	}

	// 기술자 상태로딩
	@RequestMapping(value = "/getWork_sate.do")
	public ModelAndView getWork_State(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		String work_state = null;

		try {
			work_state = this.memberService.getWork_state(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("work_state", work_state);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 업체정보로딩
	@RequestMapping(value = "/getCompanyInfo.do")
	public ModelAndView getCompanyInfo(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {

			List<Object> infoList = this.memberService.getCompanyInfo(pMap);
			rMap.put("infoList", infoList);

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 회원탈퇴
	@RequestMapping(value = "/doMemberLeave.do")
	public ModelAndView doMemberLeave(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		int result = 0;

		try {
			result = this.memberService.doMemberLeave(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 정보수정
	@RequestMapping(value = "/updateCompanyInfo.do")
	public ModelAndView updateCompanyInfo(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();

		Map<String, Object> rMap = new HashMap<String, Object>();

		int result = 0;

		try {
			result = this.memberService.updateCompanyInfo(pMap);
		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("result", result);
		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}

	// 업체정보로딩
	@RequestMapping(value = "/getMemberInfo.do")
	public ModelAndView getMemberInfo(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();

		try {

			MemberVO member = this.memberService.getMemberInfo(pMap);
			rMap.put("member", member);

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;

	}
	
	//회원가입할때 업체회원인지 일반회원인지 선택하는 페이지 이동
	@RequestMapping(value="/joinMain.do")
	public ModelAndView joinMain(){
		ModelAndView mav = new ModelAndView("web/member/joinMain");
		return mav;
	}
	
	// web회원가입 페이지로딩
	@RequestMapping(value = "/webJoin.do")
	public ModelAndView webJoin() {

		ModelAndView mv = new ModelAndView("/web/member/webJoin");
		return mv;

	}
	
	//web업체회원가입 페이지 이동
	@ RequestMapping(value="/webCompanyJoin.do")
	public ModelAndView webcompanyJoin(){
		ModelAndView mav = new ModelAndView("web/member/webCompanyJoin");
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
	public ModelAndView delCompanyFile(HttpServletRequest req, HttpServletResponse res,
			@RequestParam Map<String, Object> pMap) throws BusinessException {

		ModelAndView output = new ModelAndView();
		Map<String, Object> rMap = new HashMap<String, Object>();
		int result = 0;

		try {

			result = this.memberService.delCompanyFile(pMap);
			
			

		} catch (Exception e) {
			throw new BusinessException(e.toString());
		}

		rMap.put("resultCode", result);

		output.addAllObjects(rMap);
		output.setViewName("jsonView");

		return output;
	}
	

}