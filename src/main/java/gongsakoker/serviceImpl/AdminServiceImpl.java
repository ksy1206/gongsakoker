package gongsakoker.serviceImpl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gongsakoker.helper.util.bizlink.BizlinkConfig;
import gongsakoker.helper.util.bizlink.BizlinkResponseVO;
import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.AdminService;
import gongsakoker.service.BizlinkService;
import gongsakoker.vo.BoardVO;
import gongsakoker.vo.CommunityVO;
import gongsakoker.vo.EstimateVO;
import gongsakoker.vo.EventVO;
import gongsakoker.vo.FieldStoryVO;
import gongsakoker.vo.LocalBoardVO;
import gongsakoker.vo.MemberVO;
import gongsakoker.vo.NoticeVO;

/**
* 설명 : 관리자 페이지 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2015.12.     조현민   
*************************
*
*/

@Service("gongsakoker.AdminService")
public class AdminServiceImpl implements AdminService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;
	@Resource(name = "gongsakoker.bizlinkService")
	private BizlinkService bizlinkService;
	
	@Autowired
	private BizlinkConfig bizlinkConfig;

	//관리자 아이디 체크
	@Override
	public List<Object> checkId(Map<String, String> map) {
		
		List<Object> list = null;
		
		try {
		
			list = commonDao.getListData("admin.selectAdmin", map);
			
		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return list;
		
	}
	
	//공지사항 리스트 가져오기
	@Override
	public List<Object> getNoticeList(NoticeVO vo) {
		List<Object> noticeList = null;
		try {
			noticeList = (List<Object>) this.commonDao.getListData("admin.getNoticeList",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return noticeList;
	}

	//공지사항 한개 가져오기
	@Override
	public List<Object> getNoticeOne(int notice_no) {
		
		List<Object> noticeOne = null;
		try {
			noticeOne = (List<Object>) this.commonDao.getListData("admin.getNoticeOne",notice_no);
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return noticeOne;
	}

	//공지사항 업데이트
	@Override
	public void updateNoticeOne(NoticeVO vo) {
	
		try {
			commonDao.getReadData("admin.noticeUpdate",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}

	//공지사항 입력
	@Override
	public void insertNoticeOne(NoticeVO vo) {
		
		try {
			commonDao.getReadData("admin.noticeInsert",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
		
	}

	//회원 리스트
	@Override
	public List<Object> memberList(MemberVO vo) {
		
		List<Object> memberList = null;
		try {
			memberList = (List<Object>) this.commonDao.getListData("admin.getMemberList",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return memberList;
	}
	

	//카테고리 리스트
	@Override
	public List<Object> categoryList() {
		List<Object> categoryList = null;
		try {
			categoryList = (List<Object>) this.commonDao.getListData("admin.categoryList");
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return categoryList;
	}

	//회원 한명 정보 가져오기
	@Override
	public List<Object> memberUpdate(String member_no) {
		
		List<Object> memberList = null;
		try {
			memberList = (List<Object>) this.commonDao.getListData("admin.getMemberInfo",member_no);
		}catch (Exception e){
			e.printStackTrace();
		}
		return memberList;
		
	}

	//추천업체
	@Override
	public int recommendCount(MemberVO vo) {
		int count = 0;
		try {
			count = commonDao.getIntValue("admin.admin_special_count",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	//유료회원 업데이트
	@Override
	public void chargeUpdate(MemberVO vo) {
		try {
			commonDao.updateData("admin.chargeUpdate",vo);
		}catch (Exception e){
			e.printStackTrace();
		}	
	}

	//유료회원 입력
	@Override
	public void chargeInsert(MemberVO vo) {
		try {
			commonDao.insertData("admin.chargeInsert",vo);
		}catch (Exception e){
			e.printStackTrace();
		}	
	}

	//유료회원 삭제
	@Override
	public void chargeDelete(MemberVO vo) {
		try {
			commonDao.deleteData("admin.chargeDelete",vo);
		}catch (Exception e){
			e.printStackTrace();
		}	
	}

	//유료회원 가져오기
	@Override
	public List<Object> chargeMember(String koker_no) {
		List<Object> chargeMember = null;
		try {
			chargeMember = (List<Object>) this.commonDao.getListData("admin.getChargeMember",koker_no);
		}catch (Exception e){
			e.printStackTrace();
		}
		return chargeMember;
	}

	//class_code별 카테고리 가져오기
	@Override
	public List<Object> classCodeView(MemberVO vo) {
		
		List<Object> memberList = null;
		try {
			memberList = (List<Object>) this.commonDao.getListData("admin.classCodeView",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
		return memberList;
		
	}

	//회원 업데이트 메소드
	@Override
	public void member_Update(MemberVO vo,String bizLinkConfirm) {
		try {
			commonDao.updateData("admin.member_update",vo);
			int approve_confirm = (Integer) commonDao.getReadData("admin.approve_confirm",vo);
			if(approve_confirm ==1){
				commonDao.updateData("admin.approve_update",vo);
			}else{
				commonDao.insertData("admin.approve_insert",vo);
			}
			/*if(!vo.getClass_code().equals("01")){
				//가상번호 처리과정 
   			 String state = bizlinkConfig.getState();
   			 if(state.equals("real")){
				if(bizLinkConfirm.equals("1")){
					//가상번호 처리과정 
					String rn = (String)this.commonDao.getReadData("bizlink.getBizlink_RN",vo);
					
					if(!vo.getMember_code().equals("03")){
						if(rn!=null){
							if(!rn.equals(vo.getCall_tel01()+vo.getCall_tel02()+vo.getCall_tel03())){
								System.out.println("bizlink 수정요청..");
								BizlinkResponseVO resVO = new BizlinkResponseVO(); 
								 rn = vo.getCall_tel01()+vo.getCall_tel02()+vo.getCall_tel03();
				    			 resVO.setRn(rn);
				    			 resVO.setKoker_no(vo.getKoker_no());
				    			 resVO.setMemo(vo.getKoker_name());
				    			 resVO.setMemo2(vo.getKoker_no());
				    			 resVO.setVn(this.commonDao.getReadData("bizlink.getBizlink_VN",vo).toString());
				    			 resVO = bizlinkService.postSet_vn(resVO);
							}
						}else{
							System.out.println("bizlink 등록요청..");
							BizlinkResponseVO resVO = new BizlinkResponseVO(); 
							 rn = vo.getCall_tel01()+vo.getCall_tel02()+vo.getCall_tel03();
			    			 resVO.setRn(rn);
			    			 resVO.setKoker_no(vo.getKoker_no());
			    			 resVO.setMemo(vo.getKoker_name());
			    			 resVO.setMemo2(vo.getKoker_no());
			    			 vo.setKoker_no("");
			    			 resVO.setVn(this.commonDao.getReadData("bizlink.getBizlink_VN",vo).toString());
			    			 vo.setKoker_no(resVO.getKoker_no());
			    			 resVO = bizlinkService.postSet_vn(resVO);
						}
					} else if(vo.getMember_code().equals("03")){
						
						Map<String, Object> pMap = new HashMap<String, Object>();
						pMap.put("member_no", vo.getMember_no());
						commonDao.updateData("member.doMemberLeave", pMap);
						pMap.put("koker_no", vo.getKoker_no());
						String vn = this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString();
						
						if(!vn.equals("") && !vn.equals("null") && vn!=null){
							
							BizlinkResponseVO resVO = new BizlinkResponseVO(); 
							resVO.setVn(vn);
							resVO.setRn(" ");
							resVO.setMemo("");
							resVO.setMemo2("");
						
							resVO = bizlinkService.postSet_vn(resVO);
						}
						
						
					}
					
				}else if(bizLinkConfirm.equals("2")){
					if(vo.getMember_code().equals("03")){
						Map<String, Object> pMap = new HashMap<String, Object>();
						pMap.put("member_no", vo.getMember_no());
						commonDao.updateData("member.doMemberLeave", pMap);
						pMap.put("koker_no", vo.getKoker_no());
						String vn = this.commonDao.getReadData("bizlink.getBizlinkVN",pMap).toString();
						
						if(!vn.equals("") && !vn.equals("null") && vn!=null){
							
							BizlinkResponseVO resVO = new BizlinkResponseVO(); 
							resVO.setVn(vn);
							resVO.setRn(" ");
							resVO.setMemo("");
							resVO.setMemo2("");
						
							resVO = bizlinkService.postSet_vn(resVO);
						}
					}
				}
   			 }
			}*/
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//추천업체 등록
	@Override
	public void recommend(String recommend,MemberVO vo) {
		try {
			if(recommend.equals("y")){
				int count = commonDao.getIntValue("admin.admin_special_count",vo);
				if(count==1){}
				else if(count==0){
					commonDao.insertData("admin.admin_special_insert",vo);
				}
			}else if(recommend.equals("n")){
				int count = commonDao.getIntValue("admin.admin_special_count",vo);
				if(count==1){
					commonDao.deleteData("admin.admin_special_delete",vo);
				}
				else if(count==0){}
			}
			
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//code별 갯수
	@Override
	public List<Object> getCodeCount() {
		List<Object> cnt = null;
		try {
			cnt = (List<Object>) this.commonDao.getListData("admin.getCodeCount");
		}catch (Exception e){
			e.printStackTrace();
		}
		return cnt;
	}

	//이벤트 등록
	@Override
	public void event_Insert(EventVO vo) {
		try {
			commonDao.getReadData("admin.event_insert",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//이벤트 목록
	@Override
	public List<Object> event_List(EventVO vo) {
		List<Object> eventList = null;
		try {
			eventList = (List<Object>) this.commonDao.getListData("admin.event_list",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return eventList;
	}

	//이벤트 한개 정보
	@Override
	public List<Object> eventOne(EventVO vo) {
		List<Object> eventOne = null;
		try {
			eventOne = (List<Object>) this.commonDao.getListData("admin.event_one",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return eventOne;
	}

	//이벤트 수정
	@Override
	public void event_Update(EventVO vo) {
		try {
			commonDao.getReadData("admin.event_update",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//광고 리스트
	@Override
	public List<Object> admin_advertise(BoardVO vo) {
		List<Object> advertiseList = null;
		try {
			advertiseList = (List<Object>) this.commonDao.getListData("admin.advertise_list",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return advertiseList;
	}
	
	//핸드폰 등록정보
	@Override
	public List<String> get_all_hpregid() {

		List<Object> cnt = null;
		List<String> result = new ArrayList<String>();
		try {
			cnt = (List<Object>) this.commonDao.getListData("getAll_hp_reg_id");
			for(int i=0;i<cnt.size();i++) {
				String str = cnt.get(i).toString();
				result.add(str);
	
			}
		} catch (Exception e) {

		}

		return result;
	}

	@Override
	public String get_hpregid(String board_id) {
		String result = null;
		try {
			result = (String) this.commonDao.getReadData("get_hp_reg_id", board_id);
		} catch (Exception e) {

		}
		return result;
	}
	
	//핸드폰 종류
	@Override
	public String get_hp_kind(String board_id){
		String result = null;
		try {
			result = (String) this.commonDao.getReadData("get_hp_kind", board_id);
		} catch (Exception e) {

		}
		return result;
	}
	
	//ios 등록정보
	@Override
	public List<String> get_all_ioshpregid() {
		// TODO Auto-generated method stub
		List<Object> cnt = null;
		List<String> result = new ArrayList<String>();
		try {
			cnt = (List<Object>) this.commonDao.getListData("getAll_ios_reg_id");
			for(int i=0;i<cnt.size();i++) {
				String str = cnt.get(i).toString();
				result.add(str);
	
			}
		} catch (Exception e) {

		}

		return result;
	}

	//광고 업데이트
	@Override
	public void advertise_update(BoardVO vo) {
		try {
			int advertiseCount = commonDao.getIntValue("admin.advertise_confirm", vo);
			if(advertiseCount == 1){
				commonDao.updateData("admin.advertise_update",vo);
			}else if(advertiseCount == 0){
				commonDao.insertData("admin.advertise_insert1",vo);
				commonDao.updateData("admin.advertise_insert2",vo);
			}
			
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//광고 등록
	@Override
	public void advertise_insert(BoardVO vo) {
		try {
			commonDao.insertData("admin.advertise_insert1",vo);
			commonDao.updateData("admin.advertise_insert2",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//광고 확인
	@Override
	public int advertise_confirm(BoardVO vo) {
		int advertiseList = 0;
		try {
			advertiseList = commonDao.getIntValue("admin.advertise_confirm", vo);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return advertiseList;
	}

	//1:1 질문 리스트
	@Override
	public List<Object> admin_question(BoardVO vo) {
		List<Object> admin_question = null;
		try {
			admin_question = (List<Object>) this.commonDao.getListData("admin.question_list",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return admin_question;
	}

	//1:1 질문 수정
	@Override
	public void question_update(BoardVO vo) {
		try {
			int questionCount = commonDao.getIntValue("admin.question_confirm", vo);
			if(questionCount==1){
				commonDao.updateData("admin.question_update",vo);
			}else if(questionCount==0){
				commonDao.insertData("admin.question_insert1",vo);
				commonDao.updateData("admin.question_insert2",vo);
			}
			
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//1:1 질문 등록
	@Override
	public void question_insert(BoardVO vo) {
		try {
			commonDao.insertData("admin.question_insert1",vo);
			commonDao.updateData("admin.question_insert2",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//1:1 질문 확인
	@Override
	public int question_confirm(BoardVO vo) {
		int questionList = 0;
		try {
			questionList = commonDao.getIntValue("admin.question_confirm", vo);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return questionList;
	}

	//자주묻는 질문 리스트
	@Override
	public List<Object> admin_qna(BoardVO vo) {
		List<Object> admin_qna = null;
		try {
			admin_qna = (List<Object>) this.commonDao.getListData("admin.qna_list",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return admin_qna;
	}

	//자주묻는 질문 수정
	@Override
	public void qna_update(BoardVO vo) {
		try {
			commonDao.updateData("admin.qna_update1",vo);
			commonDao.updateData("admin.qna_update2",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//자주묻는 질문 등록 확인 여부
	@Override
	public int qna_confirm(BoardVO vo) {
		int qnaList = 0;
		try {
			qnaList = commonDao.getIntValue("admin.qna_confirm", vo);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return qnaList;
	}

	//자주묻는 질문 등록
	@Override
	public void qna_insert(BoardVO vo) {
		try {
			commonDao.insertData("admin.qna_insert1",vo);
			String board_no =  (String) commonDao.getReadData("admin.qna_board_no",vo);
			vo.setBoard_no(board_no);
			commonDao.insertData("admin.qna_insert2",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	//자주묻는 질문 삭제
	@Override
	public void qna_delete(BoardVO vo) {
		try {
			commonDao.deleteData("admin.qna_delete1",vo);
			commonDao.deleteData("admin.qna_delete2",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public Map<String, Object> getListAddCompany(Map pMap) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
			try {
				map = this.commonDao.getPagingListData("admin.countKoker_addCompany", "admin.getListAddCompany", pMap);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return map;
	}

	@Override
	public Map<String, Object> getListAddCompanyCheck(Map pMap) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(pMap);
		try {
			map = this.commonDao.getPagingListData("admin.countKoker_addCompany_check", "admin.getListAddCompany_check", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	return map;
	}

	@Override
	public String company_call_update(Map map) {
		// TODO Auto-generated method stub
		String update_company_call_check = null;
		int check = 0;
		
		try {
			check = this.commonDao.updateData("admin.company_call_upadte", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return update_company_call_check;
	}
	
	//랭킹 순위 50개 가져오기
	@Override
	public List<Object> infoAverage(MemberVO vo) {
		List<Object> infoAverage = null;
		try {
			infoAverage = (List<Object>) this.commonDao.getListData("admin.infoAverage",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return infoAverage;
	}

	//랭킹 코드별 20위 가져오기
	@Override
	public List<Object> rankNumber(MemberVO vo) {
		List<Object> rankNumber = null;
		try {
			rankNumber = (List<Object>) this.commonDao.getListData("admin.rankNumber",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rankNumber;
	}

	//랭크에서 삭제된 회사 코드별 가져오기
	@Override
	public List<Object> deleteRank(MemberVO vo) {
		List<Object> deleteRank = null;
		try {
			deleteRank = (List<Object>) this.commonDao.getListData("admin.deleteRank",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return deleteRank;
	}

	//코드별 랭킹목록 삭제
	@Override
	public void deleteRanking(String class_code) {
		try {
			commonDao.getListData("admin.deleteRanking",class_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	//랭크 등록
	@Override
	public void rankInsert(Map<String, Object> map) {
		try {
			commonDao.getListData("admin.rankInsert",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//랭킹순위에서 안보이게 처리
	@Override
	public void rankDelete(Map<String, Object> map) {
		try {
			commonDao.getListData("admin.rankDelete",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//코드별 랭킹 리셋
	@Override
	public void rankingReset(String class_code) {
		try {
			commonDao.getListData("admin.rankReset",class_code);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//지역게시판 리스트
	@Override
	public List<Object> localBoardList(LocalBoardVO vo) {
		List<Object> localBoardList = null;
		try {
			localBoardList = (List<Object>) this.commonDao.getListData("admin.localList",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return localBoardList;
	}
	
	//지역게시판 한개
	@Override
	public List<Object> localBoardUpdateMain(LocalBoardVO vo) {
		List<Object> localBoardUpdateMain = null;
		try {
			localBoardUpdateMain = (List<Object>) this.commonDao.getListData("admin.localUpdateMain",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return localBoardUpdateMain;
	}
	
	//지역게시판 수정 메소드
	@Override
	public void localBoardUpdate(LocalBoardVO vo) {
		try {
			commonDao.getListData("admin.localUpdate",vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Object> estimateList(Map<String, Object> map) {
		List<Object> estimateList = null;
		try {
			estimateList = (List<Object>) this.commonDao.getListData("admin.estimateList",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return estimateList;
	}

	//견적 상세
	@Override
	public Object estimateDetails(Map<String, Object> map) {
		EstimateVO estimateVo = null;
		// TODO Auto-generated method stub
		
		try {
			estimateVo = (EstimateVO) this.commonDao.getReadData("estimate.getEstimateDetails", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return estimateVo;
	}

	//카테고리 리스트
	@Override
	public List<Object> categoryUpdateList(String class_code) {
		List<Object> categoryUpdateList = null;
		try {
			categoryUpdateList = (List<Object>) this.commonDao.getListData("admin.categoryUpdateList",class_code);
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return categoryUpdateList;
	}

	//카테고리 업데이트 혹은 입력 혹은 삭제
	@Override
	public List<Object> categoryUpdate(MemberVO vo, String gubunCode) {
		List<Object> categoryUpdate = null;
		try {
			if(gubunCode.equals("1")){
				commonDao.updateData("admin.categoryUpdate",vo);
			}else if(gubunCode.equals("2")){
				commonDao.insertData("admin.categoryInsert",vo);
			}else if(gubunCode.equals("3")){
				commonDao.deleteData("admin.categoryDelete",vo);
			}
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return categoryUpdate;
	}

	//c_s_board 리스트 가져오기
	@Override
	public List<Object> admin_c_s_board_list(CommunityVO vo) {
		List<Object> admin_c_s_board_list = null;
		try {
			
			admin_c_s_board_list = commonDao.getListData("admin.admin_c_s_board_list",vo);
			
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return admin_c_s_board_list;
	}

	//c_s_board 한개 가져오기
	@Override
	public List<Object> admin_c_s_board_updateMain(CommunityVO vo) {
		List<Object> admin_c_s_board_updateMain = null;
		try {
			
			admin_c_s_board_updateMain = commonDao.getListData("admin.admin_c_s_board_updateMain",vo);
			
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return admin_c_s_board_updateMain;
	}

	//c_s_board 업데이트 메소드
	@Override
	public void admin_c_s_board_update(CommunityVO vo) {
		try {
			commonDao.updateData("admin.c_s_board_update",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//c_s_board 입력 메소드
	@Override
	public void admin_c_s_board_insert(CommunityVO vo) {
		try {
			commonDao.insertData("admin.c_s_board_insert",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}
	
	//커뮤니티 리스트
	@Override
	public List<Object> community_list(Map<String, Object> map) {
		List<Object> community_list = null;
		try {
			
			community_list = commonDao.getListData("admin.admin_community",map);
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return community_list;
	}
	
	//커뮤니티 상세
	@Override
	public List<Object> community_detail(CommunityVO vo) {
		List<Object> community_detail = null;
		try {
			
			community_detail = commonDao.getListData("admin.admin_community_detail",vo);
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return community_detail;
	}
	
	//커뮤니티 상세 댓글 리스트
	@Override
	public List<Object> community_detail_reply(CommunityVO vo) {
		List<Object> community_detail_reply = null;
		try {
			
			community_detail_reply = commonDao.getListData("admin.admin_community_detail_reply",vo);
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return community_detail_reply;
	}
	
	//커뮤니티 업데이트
	@Override
	public void community_update(CommunityVO vo) {
		try {
			commonDao.updateData("admin.community_update",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public void reply_update(CommunityVO vo) {
		try {
			commonDao.updateData("admin.reply_update",vo);
		}catch (Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public List<Object> report_list(Map<String, Object> map) {
		List<Object> report_list = null;
		try {
			
			report_list = commonDao.getListData("admin.admin_reportList",map);
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return report_list;
	}

	@Override
	public List<Object> admin_charge(Map<String, Object> map) {
		List<Object> charge_list = null;
		try {
			
			charge_list = commonDao.getListData("admin.admin_chargeList",map);
			
		}catch (Exception e){
			e.printStackTrace();
		}
		
		return charge_list;
	}

	@Override
	public Map<String, Object> admin_getFieldStoryWeb(Map<String, Object> pMap) {
		// TODO Auto-generated method stub
		Map<String, Object> fieldStory_list_web = null;
		
		try {
			fieldStory_list_web = this.commonDao.getPagingListData("admin.fieldStory_listCount", "admin.fieldStory_webList_data", pMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fieldStory_list_web;
	}

	//현장스토리 상세페이지 fs_no
	@Override
	public Object admin_getFieldStory_fs_no(Map<String, Object> map) {
		// TODO Auto-generated method stub
		FieldStoryVO fieldStoryVo = null;
		
		try {
			fieldStoryVo = (FieldStoryVO) this.commonDao.getReadData("admin.fieldStoryVo_select", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fieldStoryVo;
	}

	@Override
	public void modify_fieldStory_use_yn(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.insertData("admin.modify_fieldStory_use_yn", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delete_fieldStory_ans_no(Map<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			this.commonDao.insertData("admin.delete_fieldStory_answer", map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
