package gongsakoker.service;

import java.util.List;
import java.util.Map;

import gongsakoker.vo.FieldStoryVO;

public interface FieldStroyService {
	
	//현장스토리 리스트 불러오기
	public List<Object> getFieldStory(FieldStoryVO fieldStoryVo);

	//현장스토리 DB등록
	public String addFieldStory(FieldStoryVO fieldStoryVo);
	
	//현장스토리 상세페이지 fs_no
	public Object getFieldStory_fs_no(Map<String, Object> map);
	
	//현장스토리 상세페이지 댓글
	public List<Object> getFieldStory_answer(Map<String, Object> map);
	
	//현장스토리 댓글 등록
	public String addFieldStory_answer(Map<String, Object> map);
	
	//현장스토리 댓글 수정
	public String updateFieldStory_answer(Map<String, Object> map);
	
	//현장스토리 댓글 삭제
	public String deleteFieldStory_answer(Map<String, Object> map);
	
	//현장스토리 추천
	public Object add_recommendFieldStory(Map<String, Object> map);
	
	//현장스토리 추천
	public Object check_recommendFieldStory(Map<String, Object> map);
	
	//현장스토리 추천 count
	public int count_recommendFieldStory(Map<String, Object> map);
	
	//현장스토리 MY리스트 불러오기
	public List<Object> get_MyFieldStory(Map<String, Object> map);
	
	//현장스토리 글 수정
	public String updateFieldStory(FieldStoryVO fieldStoryVo);
	
	//현장스토리 글 삭제
	public String deleteFieldStory(Map<String, Object> map);
	
	//현장스토리 공지사항 리스트 불러오기
	public List<Object> get_fieldStory_notice_list();
	
	//현장스토리 신고
	public String add_fieldStory_singo(Map<String, Object> map);
	
	public int delImgFile(Map<String, Object> pMap);
}
