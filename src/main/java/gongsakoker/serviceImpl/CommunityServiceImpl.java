package gongsakoker.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import gongsakoker.helper.util.dao.CommonDAO;
import gongsakoker.service.CommunityService;
import gongsakoker.vo.CommunityVO;

/**
* 설명 : 광고문의 관련 서비스 구현 클래스
*
*************************
* DATE          AUTHOR 
* -----------------------
* 2016.02.24    조현민    
*************************
*
*/

@Service("gongsakoker.CommunityService")
public class CommunityServiceImpl implements CommunityService {

	@Resource(name="commonDao")
	private CommonDAO commonDao;
	
	//커뮤니티 공지사항
	@Override
	public List<Object> c_s_board_list() {
		List<Object> list = null;
		
		try {
		
			list = commonDao.getListData("community.c_s_board_list");
			
		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return list;
	}
	
	//커뮤니티 리스트
	@Override
	public List<Object> community_list(String start , String end , String search_text) {
		List<Object> list = null;
		Map<String, Object> pMap = new HashMap<String, Object>();
		
		pMap.put("start",start);
        pMap.put("end", end);
        pMap.put("search_text", search_text);
        
		try {
		
			list = commonDao.getListData("community.communityList",pMap);
			
		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return list;
	}

	//한줄게시판 총갯수
	@Override
	public int community_count(String search_text) {
		int count = 0;
		Map<String, Object> pMap = new HashMap<String, Object>();
		
		pMap.put("search_text", search_text);
		
		try {
			count = (Integer) commonDao.getReadData("community.communityCount",pMap);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return count;
	}

	//한줄게시판 입력
	@Override
	public void community_insert(CommunityVO vo) {
		try {
			commonDao.insertData("community.communityInsert",vo);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
	}

	//한줄게시판 상세페이지
	@Override
	public List<Object> community_detail(Map<String, Object> pMap) {
		List<Object> list = null;
        
		try {
		
			list = commonDao.getListData("community.communityDetail",pMap);
			
		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return list;
	}
	
	//상세페이지 댓글 리스트
	@Override
	public List<Object> community_replyList(Map<String, Object> pMap) {
		List<Object> list = null;
        
		try {
		
			list = commonDao.getListData("community.communityReplyList",pMap);
			
		} catch (Exception e) {

			e.printStackTrace();
			
		}
		
		return list;
	}
	
	//댓글 총 갯수
	@Override
	public int community_reply_count(String cm_no) {
		int count = 0;
		try {
			count = commonDao.getIntValue("community.communityReplyCount",cm_no);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return count;
	}
	
	//댓글 입력 메소드
	@Override
	public void community_reply_insert(CommunityVO vo) {
		try {
			commonDao.insertData("community.communityReplyInsert",vo);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
	}
	
	//글 수정 또는 사용 유무
	@Override
	public void community_update(CommunityVO vo, String gubun) {
		try {
			System.out.println(vo.toString());
			if(gubun.equals("1")){
				commonDao.updateData("community.communityUpdate1",vo);
			}else if(gubun.equals("2")){
				commonDao.updateData("community.communityUpdate2",vo);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}		
	}
	
	//댓글수정 또는 사용 유무
	@Override
	public void reply_update(CommunityVO vo, String gubunCode) {
		try {
			System.out.println(vo.toString());
			if(gubunCode.equals("3")){
				commonDao.updateData("community.replyUpdate1",vo);
			}else if(gubunCode.equals("4")){
				commonDao.updateData("community.replyUpdate2",vo);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}		
	}
	
	//마이페이지
	@Override
	public List<Object> community_myPage(CommunityVO vo) {
		List<Object> list = null;
        
		try {
		
			list = commonDao.getListData("community.communityMyPage",vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//추천 카운트
	@Override
	public int community_recommend_count(CommunityVO vo) {
		int recommend_count = 0;
		
		try {
			
			recommend_count = commonDao.getIntValue("community.community_recommend_count", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return recommend_count;
	}

	@Override
	public int community_recommend_confirm(CommunityVO vo) {
		int recommend_confirm = 0;
		try {
			recommend_confirm = commonDao.getIntValue("community.community_recommend_confirm", vo);
			
			if(recommend_confirm==1){
				commonDao.deleteData("community.community_recommend_delete", vo);
			}else if (recommend_confirm ==0){
				commonDao.insertData("community.community_recommend_insert", vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return recommend_confirm;
	}

	@Override
	public void community_report(CommunityVO vo) {
		try {
			commonDao.insertData("community.community_report", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//멤버 추천 카운트
	@Override
	public int community_recommend_member_count(Map<String, Object> pMap) {
		int member_recommend_count = 0;
		
		try {
			member_recommend_count = commonDao.getIntValue("community.community_recommend_member_count", pMap);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return member_recommend_count;
	}

	@Override
	public List<Object> get_community_notice_list() {
		
		List<Object> get_community_notice_list = null;
		
		try {
			get_community_notice_list = this.commonDao.getListData("community.get_community_notice_list");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return get_community_notice_list;
	}

	

}
