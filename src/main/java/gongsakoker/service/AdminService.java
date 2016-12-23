package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.BoardVO;
import gongsakoker.vo.CommunityVO;
import gongsakoker.vo.EstimateVO;
import gongsakoker.vo.EventVO;
import gongsakoker.vo.LocalBoardVO;
import gongsakoker.vo.MemberVO;
import gongsakoker.vo.NoticeVO;

public interface AdminService {

	//관리자 아이디 확인
	List<Object> checkId(Map<String, String> map);

	//관리자 공지사항 리스트
	List<Object> getNoticeList(NoticeVO vo);
	
	//관리자 공지사항 정보한개
	List<Object> getNoticeOne(int notice_no);
	
	//관리자 공지사항 수정
	void updateNoticeOne(NoticeVO vo);
	
	//관리자 공지사항 등록
	void insertNoticeOne(NoticeVO vo);
	
	//관리자 회원 리스트
	List<Object> memberList(MemberVO vo);
	
	//카테고리 리스트
	List<Object> categoryList();
	
	//관리자 회원 정보한개
	List<Object> memberUpdate(String member_no);
	
	//관리자 회원 유료회원 등록
	List<Object> chargeMember(String koker_no);
	
	//추천업체 확인
	int recommendCount(MemberVO vo);

	//관리자 회원 클래스 코드 읽어오기 시작
	List<Object> classCodeView(MemberVO vo);
	
	//클래스 코드 읽어오기 끝
	
	//관리자 회원 업데이트 메소드
	void member_Update(MemberVO vo, String bizLinkConfirm);

	//관리자 코드 숫자 별 전체 및 부분 개수
	List<Object> getCodeCount();

	//관리자 이벤트 등록
	void event_Insert(EventVO vo);

	//관리자 이벤트 리스트
	List<Object> event_List(EventVO vo);

	//관리자 이벤트 정보 한개 
	List<Object> eventOne(EventVO vo);

	//관리자 이벤트 수정
	void event_Update(EventVO vo);

	//관리자 광고문의 리스트
	List<Object> admin_advertise(BoardVO vo);
	
	//멤버핸드폰전체로딩 안드로이드 - 박종현
	List<String> get_all_hpregid();

	//멤버핸드폰로딩 안드로이드 - 박종현
	String get_hpregid(String board_id);
	
	//멤버핸드폰전체로딩 ios - 박종현
	List<String> get_all_ioshpregid();

	//멤버핸드폰종류 - 박종현
	String get_hp_kind(String board_id);

	//관리자 광고문의 수정
	void advertise_update(BoardVO vo);

	//관리자 광고문의 입력
	void advertise_insert(BoardVO vo);

	//관리자 광고문의 입력 확인
	int advertise_confirm(BoardVO vo);

	//관리자 1:1 질문 리스트
	List<Object> admin_question(BoardVO vo);

	//관리자 1:1 질문 수정
	void question_update(BoardVO vo);

	//관리자 1:1 질문 입력 확인
	int question_confirm(BoardVO vo);

	//관리자 1:1 질문 입력
	void question_insert(BoardVO vo);

	//관리자 자주묻는 질문 리스트
	List<Object> admin_qna(BoardVO vo);

	//관리자 자주묻는 질문 수정
	void qna_update(BoardVO vo);

	//관리자 자주묻는 질문 등록 확인
	int qna_confirm(BoardVO vo);

	//관리자 자주묻는 질문 등록
	void qna_insert(BoardVO vo);
	
	//관리자 자주묻는 질문 삭제
	void qna_delete(BoardVO vo);

	//관리자 유료회원 수정
	void chargeUpdate(MemberVO vo);
	
	//관리자 유료회원 삭제
	void chargeDelete(MemberVO vo);

	//관리자 유료회원 등록
	void chargeInsert(MemberVO vo);
	
	//업체등록요청 전체 리스트 불러오기
	public Map<String, Object> getListAddCompany(Map pMap);
	
	//업체 등록요청 확인&미확인 리스트 따로 불러오기
	public Map<String, Object> getListAddCompanyCheck(Map pMap);
	
	//업체 등록 company_call 수정
	public String company_call_update(Map map);
	
	//관리자 랭킹 50위
	List<Object> infoAverage(MemberVO vo);

	//랭크 테이블 20위
	List<Object> rankNumber(MemberVO vo);

	//관리자 랭크 불가 데이터
	List<Object> deleteRank(MemberVO vo);

	//랭킹 등록
	void rankInsert(Map<String, Object> map);
	
	//코드별 랭킹 삭제
	void deleteRanking(String class_code);

	//랭킹목록에서 삭제
	void rankDelete(Map<String, Object> map);
	
	//클래스코드별 랭킹목록 초기화
	void rankingReset(String class_code);

	//추천업체 업데이트
	void recommend(String recommend,MemberVO vo);

	//지역게시판 리스트
	List<Object> localBoardList(LocalBoardVO vo);

	//지역게시판 한개
	List<Object> localBoardUpdateMain(LocalBoardVO vo);
	
	//지역게시판 수정 메소드
	void localBoardUpdate(LocalBoardVO vo);
	
	//견적게시판 리스트
	List<Object> estimateList(Map<String, Object> map);
	
	//견적게시판 상세페이지98
	public Object estimateDetails(Map<String, Object> map);
	
	//카테고리 업데이트 리스트
	List<Object> categoryUpdateList(String class_code);

	//카테고리 업데이트 메소드
	List<Object> categoryUpdate(MemberVO vo, String gubunCode);

	//c_s_board 리스트
	List<Object> admin_c_s_board_list(CommunityVO vo);
	
	//c_s_board 한개 
	List<Object> admin_c_s_board_updateMain(CommunityVO vo);
	
	//c_s_board 업데이트
	void admin_c_s_board_update(CommunityVO vo);
	
	//c_s_board 등록
	void admin_c_s_board_insert(CommunityVO vo);
	
	//커뮤니티 리스트
	List<Object> community_list(Map<String, Object> map);

	//커뮤니티 상세
	List<Object> community_detail(CommunityVO vo);

	//커뮤니티 상세 댓글
	List<Object> community_detail_reply(CommunityVO vo);
	
	//커뮤니티 사용유무 업데이트
	void community_update(CommunityVO vo);
	
	//커뮤니티 댓글 사용 유무 업데이트
	void reply_update(CommunityVO vo);
	
	//신고 리스트
	List<Object> report_list(Map<String, Object> map);
	
	//유료회원 리스트
	List<Object> admin_charge(Map<String, Object> map);
	
	//현장스토리 페이징 리스트 불러오기
	public Map<String, Object> admin_getFieldStoryWeb(Map<String, Object> map);
	
	//현장스토리 상세페이지 fs_no
	public Object admin_getFieldStory_fs_no(Map<String, Object> map);

	//현장스토리 use_yn변경
	public void modify_fieldStory_use_yn(Map<String, Object> map);
	
	//현장스토리 댓글 삭제
	public void delete_fieldStory_ans_no(Map<String, Object> map);
}
