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

	alert("수정되었습니다!!");
	location.href = "notice_updateMain.do?notice_no="+${notice_no};
	

</script>
</c:if>
<c:if test="${result == 2}">
<script>

	alert("등록되었습니다!!");
	location.href = "admin_notice.do?pageNum=1";

</script>
</c:if>
<script type="text/javascript">
	function noticeUpdate(obj){
		
		document.getElementById('notice_no').value = obj;
		noticeUp.action = 'notice_updateMain.do';
		noticeUp.submit();
		
	}
	function register(){
		
		location.href = "notice_insertMain.do";
		
	}
	
	function pageMove(obj){
		
		var use_yn = '${use_yn}';
		if(use_yn != ''){
			document.getElementById('use_yn').value = '${use_yn}';	
		}
		document.getElementById('pageNum').value = obj;
		document.noticeUp.action = 'admin_notice.do';
		document.noticeUp.submit();
			
	}
	function use_yn(obj){
		
		document.getElementById('pageNum').value = 1;
		document.getElementById('use_yn').value = obj;
		document.noticeUp.action = 'admin_notice.do';
		document.noticeUp.submit();
		
	}
	
</script>
<title>Insert title here</title>
</head>
<body>

	<form accept-charset="UTF-8" method="post" id="noticeUp" name="noticeUp">
		<input type="hidden" id="notice_no" name="notice_no">
		<input type="hidden" id="use_yn" name="use_yn">
		<input type="hidden" id="pageNum" name="pageNum">
	</form>
				
	<jsp:include page="admin_header.jsp"/>
<div style=" width:980px; margin:0 auto; font-family:'GodoM'; font-size:14px;">
	<div style="width:100%:">
		<p style="font-size:18px;">공지사항 관리
			<c:if test="${use_yn == '' || use_yn == null}">
				<span class="yn_btn" onclick="javascript:use_yn('y');">사용중</span>
				<span class="yn_btn" onclick ="javascript:use_yn('n');">비사용중</span>
			</c:if>
			<c:if test="${use_yn == 'y' }">
				<span class="yn_btn y_btn" onclick="javascript:use_yn('y');">사용중</span>
				<span class="yn_btn" onclick ="javascript:use_yn('n');">비사용중</span>
			</c:if>
			<c:if test="${use_yn == 'n' }">
				<span class="yn_btn" onclick="javascript:use_yn('y');">사용중</span>
				<span class="yn_btn y_btn" onclick ="javascript:use_yn('n');">비사용중</span>
			</c:if>
		</p>
	</div>
	
	<div style="width:100%; border:double 4px #29A9C8; padding:.5em 1em; border-radius:5px;">
		<c:forEach var="data" items="${list}" begin="${startRow }" end="${endRow }">
			<p class="inline_hover" style="color:#666; border-bottom: dotted 1px #d7d7d7; padding-bottom: .7em;">
				<span onclick="noticeUpdate(${data.notice_no});">${data.title}</span>
				<span style="float:right;">${data.insert_date}</span>
			</p>
		</c:forEach>
	</div>
	<div style="width:100%; margin:0 auto; text-align:center; margin-top:2em;">
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
								<a href="#">${pageList}</a>
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
	
	<p onclick="register();" style="float:right; margin:0; padding:.5em 3em; background-color:#29A9C8; color:#fff; border-radius:5px; font-size:14px; cursor:pointer;">등록</p>
	
 </div>
</body>
</html>