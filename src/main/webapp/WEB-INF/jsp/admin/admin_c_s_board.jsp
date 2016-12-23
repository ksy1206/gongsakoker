<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<!-- 현재페이지 게시글 수 -->
<c:set var="maxRow" value="5" />
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
<c:if test="${result == 1}">
<script>

	alert("공지사항이 등록 되었습니다.");

</script>
</c:if>
<script type="text/javascript">

	function pageMove(obj){
		
		location.href = 'admin_c_m_board.do?pageNum='+obj+'&c_s_code=${c_s_code}';
			
	}
	
	function c_s_board_detail(data){
		location.href = 'c_s_board_detail.do?c_s_no='+data;
	}
	function c_s_board_list(data){
		location.href = 'admin_c_m_board.do?pageNum=1&c_s_code='+data;
	}
	
</script>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<div class="select_div" style="text-align:left; width:980px; margin:0 auto; padding-top:1em;">
		<span style="font-family:'GodoM';">현장/한줄 게시판 공지사항 관리</span>
		<c:if test="${c_s_code == '01' }">
			<span class="yn_btn y_btn" onclick="javascript:c_s_board_list('01');">현장스토리</span>
			<span class="yn_btn" onclick="javascript:c_s_board_list('02');">한줄게시판</span>
		</c:if>
		<c:if test="${c_s_code == '02' }">
			<span class="yn_btn" onclick="javascript:c_s_board_list('01');">현장스토리</span>
			<span class="yn_btn y_btn" onclick="javascript:c_s_board_list('02');">한줄게시판</span>
		</c:if>
	</div>
	
	
	<table class="member_table">
		<tr>
			<td style="color:#29A9C8;">제목</td>
			<td style="color:#29A9C8;">작성날짜</td>
			<td style="color:#29A9C8;">사용유무</td>
			<td style="color:#29A9C8;"></td>
		</tr>
		<c:forEach var="list" items="${list}" begin="${startRow}" end="${endRow}">
			<tr>
				<td>${list.c_s_title}</td>
				<td>${list.c_s_insert_date}</td>
				<td>${list.c_s_use_yn}</td>
				<td><span onclick="javascript:c_s_board_detail('${list.c_s_no}');">내용 수정</span>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징처리 -->
	<div style="width:100%; margin:0 auto; text-align:center; margin-top:2em; font-family:'GodoM'; font-size:14px;">
		<c:if test="${startPage > 1}">
			<span onclick="javascript:pageMove('${prevPage}');">
				<a href="#" style="color:#5EBED6;"><<</a>
			</span>
		</c:if>
		<c:forEach var="pageList" begin="${startPage}" end="${endPage}" varStatus="count">
			<c:choose>
				<c:when test="${pageList == pageNum}">
					<span style="color:#29A9C8;">${pageList}</span>
				</c:when>
				<c:otherwise>
					<span onclick="javascript:pageMove('${pageList}');">
							<a href="#" style="color:#666;">${pageList}</a>
					</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${endPage < totalPage}">
			<span  onclick="javascript:pageMove('${nextPage}');">
				<a href="#" style="color:#5EBED6;">>></a>
			</span>
		</c:if>
	</div>
	
	<div style="width:980px; text-align:right; font-size:14px; font-family:'GodoM'; margin:0 auto;">
		<span onclick="location.href = 'c_s_board_insertMain.do' " style="color:#fff; padding:.5em 2em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">공지사항 등록</span>
	</div>	
		
</body>
</html>