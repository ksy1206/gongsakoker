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

	alert("답변이 수정되었습니다!!");
	location.href = 'qna_updateMain.do?board_no='+${board_no};

</script>
</c:if>
<c:if test="${result == 2}">
<script>

	alert("답변이 등록 되었습니다!!");
	location.href = 'admin_qna.do?pageNum='+${pageNum};

</script>
</c:if>
<c:if test="${result == 3}">
<script>

	alert("이미 답변이 등록 되었습니다!!");
	location.href = 'qna_updateMain.do?board_no='+${board_no};

</script>
</c:if>
<c:if test="${result == 4}">
<script>

	alert("글이 삭제 되었습니다!!");
	location.href = 'admin_qna.do?pageNum='+${pageNum};

</script>
</c:if>

<script type="text/javascript">

	function pageMove(obj){
		var board_complete = '${board_complete}';
		if(board_complete != ''){
			document.getElementById('board_complete').value = board_complete;
		}
		document.getElementById('pageNum').value = obj;
		document.advertise_List.action = 'admin_qna.do';
		document.advertise_List.submit();
		
	}
	function reply(obj){
		
		document.getElementById('pageNum').value = 1;
		document.getElementById('board_no').value = obj;
		document.advertise_List.action = 'qna_updateMain.do';
		document.advertise_List.submit();
		
	}
</script>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<form id="advertise_List" name="advertise_List" method="post">
		<input type="hidden" name="pageNum" id="pageNum"/>
		<input type="hidden" name="board_no" id="board_no"/>
	</form>
	<p style="width:980px; margin:0 auto; font-family:'GodoM'; padding-top:1em;">자주묻는 질문 관리</p>
	<table class="member_table">
		<tr>
			<td style="color:#29A9C8;">제목</td>
			<td style="color:#29A9C8;">작성자</td>
			<td style="color:#29A9C8;">작성날짜</td>
		</tr>
		<c:forEach var="list" items="${list}" begin="${startRow}" end="${endRow}">
			<tr>
				<td>${list.board_title}</td>
				<td>${list.board_write}</td>
				<td>${list.board_date}</td>
				<td><span onclick="javascript:reply(${list.board_no});">내용 수정</span>
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
	
	<div style="width:980px; text-align:right; font-size:14px; font-family:'GodoM'; margin:0 auto;">
		<span onclick="location.href = 'qna_insertMain.do' " style="color:#fff; padding:.5em 2em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">자주묻는 질문 등록</span>
	</div>	
		
</body>
</html>