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
	location.href = 'advertise_updateMain.do?board_no='+${board_no};

</script>
</c:if>
<c:if test="${result == 2}">
<script>

	alert("답변이 등록 되었습니다!!");
	location.href = 'advertise_updateMain.do?board_no='+${board_no};

</script>
</c:if>
<c:if test="${result == 3}">
<script>

	alert("이미 답변이 등록 되었습니다!!");
	location.href = 'advertise_updateMain.do?board_no='+${board_no};

</script>
</c:if>

<script type="text/javascript">

	function pageMove(obj){
		var board_complete = '${board_complete}';
		var board_write = '${board_write}';
		if(board_complete != ''){
			document.getElementById('board_complete').value = board_complete;
		}
		if(board_write != ''){
			document.getElementById('board_write').value = '${board_write}';	
		}
		document.getElementById('pageNum').value = obj;
		document.advertise_List.action = 'admin_advertise.do';
		document.advertise_List.submit();
		
	}
	function reply(obj){
		
		document.getElementById('pageNum').value = 1;
		document.getElementById('board_complete').value = '${board_complete}';
		document.getElementById('board_no').value = obj;
		document.advertise_List.action = 'advertise_updateMain.do';
		document.advertise_List.submit();
		
	}
	function complete_yn(obj){
		
		document.getElementById('board_complete').value = obj;
		document.getElementById('pageNum').value = 1;
		document.advertise_List.action = 'admin_advertise.do';
		document.advertise_List.submit();
		
	}
	function writeSearch(){
		
		document.getElementById('board_write').value =  document.getElementById('searchId').value;
		document.getElementById('pageNum').value = 1;
		document.advertise_List.action = 'admin_advertise.do';
		document.advertise_List.submit();
		
	}
</script>
</head>
<body>

	<jsp:include page="admin_header.jsp"/>
	
	<form id="advertise_List" name="advertise_List" method="post">
		<input type="hidden" name="pageNum" id="pageNum">
		<input type="hidden" name="board_complete" id="board_complete">
		<input type="hidden" name="board_no" id="board_no">
		<input type="hidden" name="board_write" id="board_write"/>
	</form>
	
	
	<div class="select_div" style="width:980px; text-align:left; margin:0 auto; padding-top:1em; font-family:'GodoM';">
		<span>광고문의 관리</span>
		<input type="text" name="searchId" id="searchId" placeholder="작성자로만 검색이 가능" />
		<input type="button" value="검색" onclick="javascript:writeSearch();">
		<c:if test="${board_complete == '' || board_complete == null}">
			<span class="yn_btn" onclick="javascript:complete_yn('y');">답변완료</span>
			<span class="yn_btn" onclick="javascript:complete_yn('n')">답변미완료</span>
		</c:if>
		<c:if test="${board_complete == 'y' }">
			<span class="yn_btn y_btn" onclick="javascript:complete_yn('y');">답변완료</span>
			<span class="yn_btn" onclick="javascript:complete_yn('n')">답변미완료</span>
		</c:if>
		<c:if test="${board_complete == 'n' }">
			<span class="yn_btn" onclick="javascript:complete_yn('y');">답변완료</span>
			<span class="yn_btn y_btn" onclick="javascript:complete_yn('n')">답변미완료</span>
		</c:if>
	</div>
	<table class="member_table">
		<tr>
			<td style="color:#29A9C8;">작성자</td>
			<td style="color:#29A9C8;">작성날짜</td>
		</tr>
		<c:forEach var="list" items="${list}" begin="${startRow}" end="${endRow}">
			<c:if test="${list.board_complete =='n' || list.board_complete == '' || list.board_complete == null }">
				<tr>
					<td>${list.board_write}</td>
					<td>${list.board_date}</td>
					<td><span onclick="javascript:reply(${list.board_no});">답변 등록</span></td>
				</tr>
			</c:if>
			<c:if test="${list.board_complete =='y'}">
				<tr>
					<td>${list.board_write}</td>
					<td>${list.board_date}</td>
					<td><span onclick="javascript:reply(${list.board_no});" style="background-color:#29A9C8; color:#fff;">답변 수정</span></td>
				</tr>
			</c:if>
		</c:forEach>
	</table>
	
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