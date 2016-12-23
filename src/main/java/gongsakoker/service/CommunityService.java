package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.CommunityVO;

public interface CommunityService {

	//c&s 공지사항 게시판 리스트
	List<Object> c_s_board_list();
	
	//한줄 리스트
	List<Object> community_list(String start, String end, String search_text);
	
	//한줄게시판 카운트
	int community_count(String search_text);

	//한줄 게시판 입력
	void community_insert(CommunityVO vo);
	
	//한줄 게시판 상세페이지
	List<Object> community_detail(Map<String, Object> pMap);
	
	//한줄게시판 상세내용 댓글
	List<Object> community_replyList(Map<String, Object> pMap);

	//댓글 총갯수
	int community_reply_count(String cm_no);

	//댓들 입력
	void community_reply_insert(CommunityVO vo);
	
	//글 수정 또는 사용 여부
	void community_update(CommunityVO vo, String gubun);

	//커뮤니티 마이페이지
	List<Object> community_myPage(CommunityVO vo);
	
	//추천 카운트
	int community_recommend_count(CommunityVO vo);
	
	//추천 확인
	int community_recommend_confirm(CommunityVO vo);
	
	//글 or 댓글 신고
	void community_report(CommunityVO vo);

	//멤버 추천 카운트
	int community_recommend_member_count(Map<String, Object> pMap);

	void reply_update(CommunityVO vo, String gubunCode);

	List<Object> get_community_notice_list();

}
