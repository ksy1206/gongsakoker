package gongsakoker.service;


import gongsakoker.vo.EstimateVO;

import java.util.List;
import java.util.Map;

public interface EstimateService {

	
	//맞춤견적 메인 리스트 불러오기
	public List<Object> getList(Map<String, Object> pMap);
	
	//견적의뢰 DB등록
	public String addEstimate(EstimateVO estimateVo);
	
	//my견적 리스트 불러오기
	public List<Object> getMyList(Map<String, Object> pMap);
	
	//견적 상세페이지 이동
	public Object getEstimateDetails(Map<String, Object> pMap);
	
	//맞춤견적 DB등록
	public String addSetEstimate(EstimateVO estimateVo);
	
	//맞춤견적 setEstimate 리스트 불러오기
	public List<Object> getSetEstimateList(Map<String, Object> pMap);
	
	//업체 견적 확인
	public Map<String, Object> checkSetEstimate(Map<String, Object> pMap);
	
	//맞춤견적 setEstimate 선택
	public String addSetEstimate(Map<String, Object> pMap);
	
	//필드 불러오기
	public List<Object> select_allField();
	
	//필드 Y & N 불러오기
	public List<Object> select_YandNField(Map<String, Object> pMap);
	
	//견적서(답변 업체 견적) DB삭제
	public String delete_setEstimate(Map<String, Object> pMap);
	
	//견적서 delete
	public String delete_estimate(Map<String, Object> pMap);
	
	//검색 결과
	public List<Object> getList_search(Map<String, Object> pMap);
	
	//내가 쓴 견적 리스트 불러오기
	public List<Object> getMy_setEstimate(Map<String, Object> pMap);
	   /**
     * 검색 로딩
     * @return
     */
     public List<Object> getSearchList(Map<String, Object> pMap);
     /**
     * 소분류종류로딩
     * @return
     */
     public List<Object> getEstType02List(Map<String, Object> pMap);

}
