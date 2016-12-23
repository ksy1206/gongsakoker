      package gongsakoker.helper.util.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import gongsakoker.helper.util.FormatHelper;
import gongsakoker.helper.util.PageNavigator;

@Repository("commonDao")
public class MyBatisDaoImpl implements CommonDAO {
     @Autowired
     private SqlSession sqlSession;
    
     private final static Log logger = LogFactory.getLog(MyBatisDaoImpl.class);
    
     public void setSqlSessionTemplate(SqlSession sqlSession) {
          this.sqlSession = sqlSession;
     }

     // ******************************************************************
     // 데이터 추가
     @Override
    public int insertData(String id, Object value) throws Exception {
         int result = 0;
        
          try {
               result = sqlSession.insert(id, value);
          } catch (Exception e) {
               logger.debug(e.toString());
          } finally {
          }
          return result;
    }
   
     // ******************************************************************
     //데이터 수정
    @Override
     public int updateData(String id) throws Exception {
         int result = 0;
         
          try {
                 result = sqlSession.update(id);
          } catch (Exception e) {
               logger.debug(e.toString());
          }
         
          return result;
     }
   
    @Override
    public int updateData(String id, Object value) throws Exception {
          int result = 0;
         
          try {
                 result = sqlSession.update(id, value);
          } catch (Exception e) {
               logger.debug(e.toString());
          }
         
          return result;
    }
   
    @Override
    public int updateData(String id, Map<String, Object> map) throws Exception {
          int result = 0;         
          try {
                 result = sqlSession.update(id, map);
          } catch (Exception e) {
               logger.debug(e.toString());
          }         
          return result;
    }
   
     // ******************************************************************
     // 데이터 삭제
    @Override
     public int deleteData(String id, Map<String, Object> map) throws Exception {
          int result = 0;

          try {
               result = sqlSession.delete(id, map);
          } catch (Exception e) {
               logger.debug(e.toString());
          }

          return result;
    }
   
    @Override
     public int deleteData(String id, Object value) throws Exception {
          int result = 0;
         
          try {
               result = sqlSession.delete(id, value);
          } catch (Exception e) {
               logger.debug(e.toString());
          }

          return result;
    }
   
    @Override
     public int deleteAll(String id) throws Exception {
          int result = 0;
         
          try {
              result = sqlSession.delete(id);
          } catch (Exception e) {
               logger.debug(e.toString());
          }

          return result;
    }

     // ******************************************************************
     // 레코드 수 / 최대값 구하기
    @Override
     public int getIntValue(String id, Map<String, Object> map) throws Exception {
          int num = 0;
          num = ((Integer)sqlSession.selectOne(id, map)).intValue();
          return num;
    }
   
    @Override
     public int getIntValue(String id, Object value) throws Exception {
          int num = 0;
          num = ((Integer)sqlSession.selectOne(id, value)).intValue();
          return num;
    }
   
    @Override
     public int getIntValue(String id) throws Exception {
          int num = 0;
          num = ((Integer)sqlSession.selectOne(id)).intValue();
          return num;
    }
    
     // ******************************************************************
     // 테이블의 레코드를 리스트에 저장
     @SuppressWarnings("unchecked")
     @Override
     public List<Object> getListData(String id, Map<String, Object> map) throws Exception {
          List<Object> lists = (List<Object>)sqlSession.selectList(id, map);    
          return lists;
     }
     @SuppressWarnings("unchecked")
     @Override
     public List<Object> getListData(String id, Object value) throws Exception {
          List<Object> lists = (List<Object>)sqlSession.selectList(id, value);    
          return lists;
     }
     @SuppressWarnings("unchecked")
     @Override
     public List<Object> getListData(String id) throws Exception {
          List<Object> lists = (List<Object>)sqlSession.selectList(id);    
          return lists;
     }
    
     @SuppressWarnings("unchecked")
     @Override
     public List<Object> getListData(String id, Map<String, Object> map, RowBounds rowBounds) throws Exception {
          List<Object> lists = (List<Object>)sqlSession.selectList(id, map, rowBounds);    
          return lists;
     }
    
     // ******************************************************************
     // 해당 레코드 가져오기
     @Override
     public Object getReadData(String id) throws Exception {
          return  sqlSession.selectOne(id);
     }
    
     @Override
     public Object getReadData(String id, Object value) throws Exception {
          return  sqlSession.selectOne(id, value);
     }
    
     @Override
     public Object getReadData(String id, Map<String, Object> map) throws Exception {
          return  sqlSession.selectOne(id, map);
     }

     // ******************************************************************
     // 페이징 처리된 리스트 레코드 가져오기
//     @Override
//     public Map<String, Object> getPagingListData(String countQueryId,
//               String listQueryId, Map<String, Object> pMap) throws Exception {
//
//          Map<String, Object> rMap = new HashMap<String, Object>();
//         
//          int totalCount = 0;
//         
//          //1. 총건수 조회
//          totalCount = this.getIntValue(countQueryId, pMap);
//         
//          //2. 페이징
//        String page = (String)pMap.get("page"); // 몇번째의 페이지를 요청했는지
//        String rowCnt = (String)pMap.get("rows"); // 페이지 당 몇개의 행이 보여질건지
//    
//        Integer pageNo = 0;
//        Integer rowPerPage = 0;            
//      
//        if (FormatHelper.isNotEmpty(page)) pageNo = Integer.parseInt(page);       
//   
//        if (FormatHelper.isNotEmpty(rowCnt)) rowPerPage = Integer.parseInt(rowCnt);
//       
//        //3.페이징 처리
//        PageNavigator pageNavi = new PageNavigator(pageNo, rowPerPage);
//   
//        pageNavi.setPagePerGroup(rowPerPage);
//      
//        pageNavi.setTotalSize(totalCount);  
//       
//      
//        pMap.put("startRowNum", pageNavi.getStartRow());
//        pMap.put("endRowNum", pageNavi.getEndRow());
//      
//          //4.리스트 조회
//          rMap.put("rows", this.getListData(listQueryId, pMap));
//         
//          //5. 그리드 페이징 정보 결과리턴
//          rMap.put("totalPage", pageNavi.getPageTotal());
//        rMap.put("totalRecord", totalCount);
//        rMap.put("currentPage", pageNavi.getCurrentPage());
//        rMap.put("records", pageNavi.getRowsPerPage());
//       
//        return rMap;                   
//     }
     
     @Override
     public Map<String, Object> getPagingListData(String countQueryId,
               String listQueryId, Map<String, Object> pMap) throws Exception {

          Map<String, Object> rMap = new HashMap<String, Object>();
         
          int totalCount = 0;
         
          //1. 총건수 조회
          totalCount = (int)this.getIntValue(countQueryId, pMap);
         
          //2. 페이징
        String page = (String)pMap.get("page"); // 몇번째의 페이지를 요청했는지
        String rowCnt = (String)pMap.get("rows"); // 페이지 당 몇개의 행이 보여질건지
        
        Integer pageNo = 0;
        Integer rowPerPage = 0;            
      
        if (FormatHelper.isNotEmpty(page)) pageNo = Integer.parseInt(page);
   
        if (FormatHelper.isNotEmpty(rowCnt)) rowPerPage = Integer.parseInt(rowCnt);
       
        //3.페이징 처리
        PageNavigator pageNavi = new PageNavigator(pageNo, rowPerPage);
   
        pageNavi.setPagePerGroup(rowPerPage);
      
        pageNavi.setTotalSize(totalCount);  
       
      
        pMap.put("startRowNum", pageNavi.getStartRow());
        pMap.put("endRowNum", pageNavi.getEndRow());
        
        float num = 0;
        int pageCnt = Integer.parseInt(pMap.get("pageCnt").toString()); // 페이지를 몇 페이지로 나눌 것인지
        int pageNum = Integer.parseInt(pMap.get("page").toString()); // 몇번째의 페이지를 요청했는지
        
        num = (float) pageNum / pageCnt;        
        int start = (int) Math.ceil(num);

        int page_start = (start-1)*pageCnt+1;
        int page_count = start*pageCnt;//마지막 PAGE 계산
      
          //4.리스트 조회
          rMap.put("rows", this.getListData(listQueryId, pMap));
         
          //5. 그리드 페이징 정보 결과리턴
          rMap.put("pageCnt", pageCnt); // 페이지를 몇 페이지로 나눌 것인지
          rMap.put("page_start", page_start);
          rMap.put("page_count", page_count);
          rMap.put("totalPage", pageNavi.getPageTotal());
          rMap.put("totalRecord", totalCount);
          rMap.put("currentPage", pageNavi.getCurrentPage());
          rMap.put("records", pageNavi.getRowsPerPage());
       
        return rMap;                   
     }
    
}
