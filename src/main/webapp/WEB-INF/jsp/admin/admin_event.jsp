<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page session="true" %>

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

	alert("등록되었습니다.!!");
	location.href='admin_event.do?pageNum=1';

</script>
</c:if>
<c:if test="${result == 2}">
<script>

	alert("수정되었습니다.!!");
	location.href='event_updateMain.do?event_no=${event_no}';

</script>
</c:if>
<script type="text/javascript">
	function event_insert(){
		
		location.href = 'event_insertMain.do';
		
	}
	
	function pageMove(obj){
			
		var event_use_yn = '${event_use_yn}';
		if(event_use_yn != ''){
			document.getElementById('event_use_yn').value='${event_use_yn}';	
		}
		document.getElementById('pageNum').value = obj;
		document.eventAction.action = 'admin_event.do';
		document.eventAction.submit();
			
	}
	function use(obj){
		
		document.getElementById('pageNum').value = 1;
		document.getElementById('event_use_yn').value=obj;
		document.eventAction.action = 'admin_event.do';
		document.eventAction.submit();
		
	}
	function event_update(obj){
		
		document.getElementById('event_no').value = obj;
		document.eventUpdate.action = 'event_updateMain.do';
		document.eventUpdate.submit();
		
	}
</script>

</head>
<body>

	<form method="post" id="eventUpdate" name="eventUpdate">
		<input type="hidden" name="event_no" id="event_no">
	</form>
	
	<form method="post" id="eventAction" name="eventAction">
		<input type="hidden" name="pageNum" id="pageNum">
		<input type="hidden" name="event_use_yn" id="event_use_yn">			
	</form>
	
	<jsp:include page="admin_header.jsp"/>
	
	<div style="width:980px; text-align:left; margin:0 auto;">
		<p style="font-size:18px; font-family:'GodoM';">이벤트 관리
			<c:if test="${event_use_yn == '' || event_use_yn == null}">
				<span class="yn_btn" onclick="javascript:use('y');">사용중</span>
				<span class="yn_btn" onclick ="javascript:use('n');">비사용중</span>
			</c:if>
			<c:if test="${event_use_yn == 'y' }">
				<span class="yn_btn y_btn" onclick="javascript:use('y');">사용중</span>
				<span class="yn_btn" onclick ="javascript:use('n');">비사용중</span>
			</c:if>
			<c:if test="${event_use_yn == 'n' }">
				<span class="yn_btn" onclick="javascript:use('y');">사용중</span>
				<span class="yn_btn y_btn" onclick ="javascript:use('n');">비사용중</span>
			</c:if>
		</p>
	</div>
	<table class="member_table">
			<tr>
				<td>제목</td>
				<td>기간</td>
				<td>내용</td>
				<td>이미지</td>
			</tr>
		<c:forEach items="${list}" var="list" begin="${startRow }" end="${endRow }">
			<c:if test="${list.event_use_yn=='y'}">
				<tr>
					<td>${list.event_title}</td>
					<td>${list.event_date1} ~ ${list.event_date2}</td>
					<td>${list.event_content}</td>
					<td>
						<img src="/upload/event/banner/${list.event_title_img}" style="height:100px;width:100px">
					</td>
					<td><input type="button" value="수정" onclick="javascript:event_update(${list.event_no});"/></td>
				</tr>
			</c:if>
			<c:if test="${list.event_use_yn=='n'}">
				<tr>
					<td>${list.event_title}</td>
					<td>${list.event_date1} ~ ${list.event_date2}</td>
					<td>${list.event_content}</td>
					<td><img src="/upload/event/banner/${list.event_title_img}" style="height:100px;width:100px"></td>
					<td><input type="button" value="수정" onclick="javascript:event_update(${list.event_no});"/></td>
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
					<span style="color:#29A9C8; padding:0 .3em;">
						${pageList}
					</span>
				</c:when>
				<c:otherwise>
					<span onclick="javascript:pageMove(${pageList});" style="padding:0 .3em;">
							<a href="#" style="color:#666;">${pageList}</a>
					</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<c:if test="${endPage < totalPage}">
			<span  onclick="javascript:pageMove(${nextPage});" style="padding:0 1em;">
					<a href="#" style="color:#5EBED6;">>></a>
			</span>
		</c:if>
	</div>
	
	<div style="width:980px; text-align:right; font-size:14px; font-family:'GodoM'; margin:0 auto;">
		<span onclick="javascript:event_insert();" style="color:#fff; padding:.5em 2em; background-color:#29A9C8; border-radius:20px; cursor:pointer;">이벤트 등록</span>
	</div>	
	
</body>
</html>