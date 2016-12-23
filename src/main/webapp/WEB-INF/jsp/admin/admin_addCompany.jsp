<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//전체 리스트 불러오기
	$("#check_all").click(function(){
		location.href="admin_addCompany.do?pageNum=1";
	});
	
	//확인된 리스트 불러오기
	$("#check_complete").click(function(){
		location.href="admin_addCompany_check_y.do?pageNum=1";
	});
	
	//확인되지 않은 리스트 불러오기
	$("#check_need").click(function(){
		location.href="admin_addCompany_check_n.do?pageNum=1";
	});
	
	//검색
	$("#search").click(function(){
		var company_recommender = $("#company_recommender").val();
		location.href="admin_addCompany_check_search.do?pageNum=1&company_recommender="+company_recommender;
	});
});

//Company_call 수정 매소드
function update_company_call(company_no,num){
	var company_call_ok = $("#company_call_ok_"+num).val(); 	
	params = "company_no="+company_no+"&company_call_ok="+company_call_ok;
	$.ajax({
        type        : "POST"  
      , async       : false 
      , url         : "/admin/update_company_call.do" //AdminController
      , data        : params
      , dataType    : "json" 
      , timeout     : 30000   
      , cache       : false     
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
			alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 개발팀에 문의하십시오.");       
      }
      , success     : function(data) {
    	  alert("수정이 완료 되었습니다.");
    	  location.reload(true);
      }
	});
}

</script>   
</head>
<body>
	<jsp:include page="admin_header.jsp"/>
	
	<div class="select_div" style="width:980px; margin:0 auto; text-align:left; font-family:'GodoM'; padding-top:1em;">
		<input type="text" id="company_recommender">
		<input type="button" value="검색" id="search">
		<div style="float:right;">
			<input type="button" value="전체 보기" id="check_all">
			<input type="button" value="확인 완료" id="check_complete">
			<input type="button" value="확인 필요" id="check_need">
		</div>
	</div>
	
	<table class="member_table">
		<tr>
			<td style="width:15%;">추천 회사이름 </td>
			<td style="width:45%;">추천 이유</td>
			<td style="width:20%;">작성자</td>
			<td style="width:10%;">전화번호</td>
			<td style="width:10%;">처리 상황</td>
		</tr>
		<c:forEach var="data" items="${result_list.rows}" varStatus="num" >
			<tr>
				<td>${data.company_name }</td>
				<td>${data.company_reason }</td>
				<td>${data.company_recommender }</td>
				<td>${data.company_tel }</td>
				<td>					
					<select id="company_call_ok_${num.count}">
						<c:if test="${data.company_call_ok == 'n' }">
							<option value="n" selected>확인필요</option>
							<option value="y">처리완료</option>
						</c:if>
						<c:if test="${data.company_call_ok == 'y' }">
							<option value="n">확인필요</option>
							<option value="y" selected>처리완료</option>
						</c:if>										
					</select>
					<span onclick="update_company_call('${data.company_no}','${num.count}')">저장</span>								
				</td>
			</tr>
		</c:forEach>	
	</table>	
	
	
	<c:set var="pageNum" value="1"/><!--시작페이지  -->
	<c:set var="doneLoop" value="false"/>
	<c:set var="totalPage" value="${result_list.totalPage }"/>
	<c:set var="totalRecord" value="${result_list.totalRecord }"/>
	<c:set var="currentPage" value="${result_list.currentPage }"/>
	<c:set var="records" value="${result_list.records }"/>
	<c:set var="pageCnt" value="${result_list.pageCnt }"/>
	<c:set var="page_start" value="${result_list.page_start }"/>
	<c:set var="page_count" value="${result_list.page_count }"/>
	<c:set var="controller" value="${result_list.controller }"/>
	<input type="hidden" value="${company_recommender }" id="company_recommender_return">
	<c:set var="company_recommender_return" value="&company_recommender=${company_recommender }"/>

	<div style="width:980px; margin:0 auto; padding-top:1em; text-align:center;">
		<c:if test="${page_start > 1 }">
			<a href="${controller }?pageNum=${currentPage-1}${company_recommender_return}" style=" font-family:'GodoM'; font-size:14px; color:#5EBED6;"><<</a>
		</c:if>
		<c:forEach var="pageNum" begin="${page_start }" end="${totalPage }" step="1">
			<c:if test="${not doneLoop }">
				<a href="${controller }?pageNum=${pageNum }${company_recommender_return}" style=" font-family:'GodoM'; font-size:14px; color:#666;">${pageNum}</a>
					<c:if test="${page_count < totalPage}">
						<c:if test="${pageNum == page_count}">
							<c:set var="doneLoop" value="true" />
							<a href="${controller }?pageNum=${currentPage+1}${company_recommender_return}" style=" font-family:'GodoM'; font-size:14px; color:#5EBED6;">>></a>
						</c:if>
					</c:if>
			</c:if>		
		</c:forEach>
	</div>
</body>
</html>