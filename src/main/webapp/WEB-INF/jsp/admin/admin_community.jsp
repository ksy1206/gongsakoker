<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<%
	String cp = request.getContextPath();
%>
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
		
		var cm_use_yn = '${cm_use_yn}';
		var text = '${text}';
		var str = '';
		
		if(cm_use_yn != ''){
			str += ('&cm_use_yn='+cm_use_yn);
		}
		if(text != ''){
			str += ('&search='+text);
		}
		
		location.href = 'admin_community.do?pageNum='+obj+str;
			
	}	
	
	function community_detail(data){
		
		location.href = 'admin_communityDetail.do?cm_no='+data;
		
	}
	
	function cm_confirm(data){
		location.href = 'admin_community.do?pageNum=1&cm_use_yn='+data;
	}
	
	function writeSearch(){
		var searchText= $('#searchId').val();
		location.href = 'admin_community.do?pageNum=1&search='+searchText;
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
			<span class="yn_btn" onclick="javascript:cm_confirm('y');">사용중</span>
			<span class="yn_btn" onclick="javascript:cm_confirm('n')">비사용중</span>
		</c:if>
		<c:if test="${cm_use_yn == 'y' }">
			<span class="yn_btn y_btn" onclick="javascript:cm_confirm('y');">사용중</span>
			<span class="yn_btn" onclick="javascript:cm_confirm('n')">비사용중</span>
		</c:if>
		<c:if test="${cm_use_yn == 'n' }">
			<span class="yn_btn" onclick="javascript:cm_confirm('y');">사용중</span>
			<span class="yn_btn y_btn" onclick="javascript:cm_confirm('n')">비사용중</span>
		</c:if>
	</div>
	
	<table class="member_table">
		<tr>
			<td style="color:#29A9C8;">내용</td>
			<td style="color:#29A9C8;">회사이름</td>
			<td style="color:#29A9C8;">작성날짜</td>
			<td style="color:#29A9C8;">추천횟수</td>
			<td style="color:#29A9C8;">댓글갯수</td>
			<td style="color:#29A9C8;"></td>
		</tr>
		<c:forEach var="list" items="${list}" begin="${startRow}" end="${endRow}">
			<tr>
				<td>${list.cm_content}</td>
				<td>${list.name}</td>
				<td>${list.cm_insert_date}</td>
				<td>${list.recommend_count}</td>
				<td>${list.reply_count}</td>
				<td><span onclick="javascript:community_detail('${list.cm_no}');">수정</span></td>
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