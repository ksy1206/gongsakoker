<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<%
	String cp = request.getContextPath();
%>
<!-- 현재페이지 게시글 수 -->
<c:set var="maxRow" value="10" />
<!-- 현재페이지목록 수 -->
<c:set var="maxPageList" value="10" />

<c:set var="pageNum" value="${pageNum}"/>
<c:set var="totalRow" value="${fn:length(list)}" />
<c:set var="totalPage" value="${(totalRow / maxRow) + ((1 - ((totalRow / maxRow) % 1 )) % 1) }" />


<c:set var="startRow" value="${ (maxRow * pageNum) - maxRow }" />
<c:set var="endRow" value="${ (maxRow * pageNum) - 1 }" />
<c:set var="endPage" value="${ ((pageNum / maxPageList) + ((1 - ((pageNum / maxPageList) % 1)) % 1)) * maxPageList }" />
<c:set var="startPage" value="${ endPage - maxPageList + 1 }" />
<fmt:formatNumber var="nextPage" value="${ endPage + 1 }" />
<fmt:formatNumber var="prevPage" value="${ startPage - 1 }" />


<c:if test="${endPage > totalPage}">
	<c:set var="endPage" value="${totalPage}" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<script src="//code.jquery.com/jquery-1.11.3.min.js" ></script >
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>   
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>

<c:if test="${result == 1}">
<script>

	alert("공지사항이 등록 되었습니다.");

</script>
</c:if>

<script type="text/javascript">
	function pageMove(obj){
		
		var gubun_code = '${gubun_code}';
		var search = '${search}';
		var str = '';
		
		if(gubun_code != ''){
			str += ('&gubun_code='+gubun_code);
		}
		
		if(search != ''){
			str += ('&search='+search);
		}
		
		location.href = 'admin_report.do?pageNum='+obj+str;
			
	}	
	
	function community_detail(cm_no,reply_no){
		
		var gubun = '';
		
		if(reply_no == ''){
			gubun = 1;
		}else{
			gubun = 2;
		}
		
		location.href = 'admin_communityDetail.do?cm_no='+cm_no+'&reply_no='+reply_no+'&gubun='+gubun;
		
	}
	
	function fieldStory_detail(fs_no,ans_no){
		
		var gubun = '';
		
		if(ans_no == ''){
			gubun = 1;
		}else{
			gubun = 2;
		}
		
		location.href = 'admin_fieldStoryDetails.do?fs_no='+fs_no+'&ans_no='+ans_no+'&gubun='+gubun;
		
	}
	
	function writeSearch(){
		var searchText= $('#searchId').val();
		location.href = 'admin_report.do?pageNum=1&search='+searchText;
	}
	
	function gubun_code(data){
		location.href = 'admin_report.do?pageNum=1&gubun_code='+data;
	}
</script>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<div class="select_div" style="text-align:left; width:980px; margin:0 auto; padding-top:1em;">
		<span style="font-family:'GodoM';">한줄 게시판 관리</span>
		<input type="text" name="searchId" id="searchId" placeholder="작성자로만 검색이 가능" />
		<input type="button" value="검색" onclick="javascript:writeSearch();">
		<c:if test="${cm_use_yn == '' || cm_use_yn == null}">
			<span class="yn_btn" onclick="javascript:gubun_code('1');">현장스토리</span>
			<span class="yn_btn" onclick="javascript:gubun_code('2')">커뮤니티</span>
		</c:if>
		<c:if test="${cm_use_yn == 'y' }">
			<span class="yn_btn y_btn" onclick="javascript:gubun_code('1');">현장스토리</span>
			<span class="yn_btn" onclick="javascript:gubun_code('2')">커뮤니티</span>
		</c:if>
		<c:if test="${cm_use_yn == 'n' }">
			<span class="yn_btn" onclick="javascript:gubun_code('1');">현장스토리</span>
			<span class="yn_btn y_btn" onclick="javascript:gubun_code('2')">커뮤니티</span>
		</c:if>
	</div>
	
	<table class="member_table">
		<tr>
			<td style="color:#29A9C8;">신고내용</td>
			<td style="color:#29A9C8;">카테고리</td>
			<td style="color:#29A9C8;">작성날짜</td>
			<td style="color:#29A9C8;">신고한사람</td>
			<td style="color:#29A9C8;">사용유무</td>
			<td style="color:#29A9C8;">구분코드</td>
			<!-- <td style="color:#29A9C8;">cm번호</td>
			<td style="color:#29A9C8;">cm댓글번호</td>
			<td style="color:#29A9C8;">fs번호</td>
			<td style="color:#29A9C8;">fs댓글번호</td>
			<td style="color:#29A9C8;">신고번호</td> -->
			<td style="color:#29A9C8;">신고등급</td>
			<td style="color:#29A9C8;"></td>
		</tr>
		<c:forEach var="list" items="${list}" begin="${startRow}" end="${endRow}">
			<tr>
				<td>${list.report_content}</td>
				<td>${list.report_category}</td>
				<td>${list.report_insert_date}</td>
				<td>${list.name}</td>
				<td>${list.report_use_yn}</td>
				<td>
					<c:if test="${list.gubun_code=='1'}">
						현장스토리
					</c:if>
					<c:if test="${list.gubun_code=='2'}">
						커뮤니티
					</c:if>
				</td>
				<%-- <td>${list.cm_no}</td>
				<td>${list.reply_no}</td>
				<td>${list.fs_no}</td>
				<td>${list.ans_no}</td>
				<td>${list.report_no}</td> --%>
				<td>
					<c:if test="${list.report_grade=='01'}">
						글
					</c:if>
					<c:if test="${list.report_grade=='02'}">
						댓글
					</c:if>
				</td>
				<td>
					<c:if test="${list.gubun_code=='1'}">
						<!--  현장 스토리 javascript 짤것  -->
						<span onclick="javascript:fieldStory_detail('${list.fs_no}','${list.ans_no}')">수정</span>	
					</c:if>
					<c:if test="${list.gubun_code=='2'}">
						<span onclick="javascript:community_detail('${list.cm_no}','${list.reply_no}');">수정</span>	
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징처리 -->
	<div style="width:100%; margin:0 auto; text-align:center; margin-top:2em; font-family:'GodoM'; font-size:14px;">
		<c:if test="${startPage > 1}">
			<span onclick="javascript:pageMove(${prevPage});">
				<a href="#" style="color:#5EBED6;"><<</a>
			</span>
		</c:if>
		<c:forEach var="pageList" begin="${startPage}" end="${endPage}" varStatus="count">
			<c:choose>
				<c:when test="${pageList == pageNum}">
					<span style="color:#29A9C8;">${pageList}</span>
				</c:when>
				<c:otherwise>
					<span onclick="javascript:pageMove(${pageList});">
						<a href="#" style="color:#666;">${pageList}</a>
					</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${endPage < totalPage}">
			<span  onclick="javascript:pageMove(${nextPage});">
				<a href="#" style="color:#5EBED6;">>></a>
			</span>
		</c:if>
	</div>
	
		
</body>
</html>