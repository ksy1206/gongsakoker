<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="../css/koker_admin.css">
<c:if test="${sessionScope.admin_name == null || sessionScope.admin_name=='' || sessionScope.admin_id==null || sessionScope.admin_id=='' }">
	<script>

		location.href = "admin_login.do";

	</script>
</c:if>
<script type="text/javascript">
	function Logout(){
		
		form_logout.action = 'admin_logout.do';
		document.getElementById("logout").value = 1;
		form_logout.submit();
		
	}
	
	function submitMember(){
		
		form_member.action = 'admin_member.do';
		form_member.submit();
		
	}
</script>
</head>
<body>
	
	<form method="post" accept-charset="utf-8" name="form_logout" >
		<input type="hidden" id="logout" name="logout">
	</form>
		
		<div style="width:100%; margin:0 auto; text-align:right; position:relative;">
			<img src="../img/admin/logo.png" style="position:absolute; top:0; left:0; width:8em;" />
			<p style="font-family:'GodoM';">
				<span style="color:#666;">관리자 ID ㅣ</span>
				<span style="color:#29A9C8; margin-right:1em;">${sessionScope.admin_id}</span>
				<span class="admin_header_id" onclick="Logout();">로그아웃</span>
			</p>
		</div>
		
		<div style="width:100%; margin:0 auto; text-align:center; border-top:solid 1px #666; border-bottom:solid 1px #666;">
			<p style="color:#666; font-family:'GodoM'; font-size:14px; line-height: 24px;">
				<span class="admin_header_menu" onclick = "location.href='admin_main.do';">메인</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_notice.do?pageNum=1'">공지사항 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_member.do?pageNum=1'">회원 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_advertise.do?pageNum=1'">광고문의 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_question.do?pageNum=1'">1:1 질문 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_qna.do?pageNum=1'">자주묻는 질문 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_event.do?pageNum=1'">이벤트 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_addCompany.do?pageNum=1'">업체등록요청 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_kokkok20.do?class_code=02'">콕콕20 관리</span>
			</p>
		</div>
		<div style="width:100%; margin:0 auto; text-align:center; border-bottom:solid 1px #666;">
			<p style="color:#666; font-family:'GodoM'; font-size:14px; line-height: 24px;">
				
				<span class="admin_header_menu" onclick = "location.href='admin_pushAlram.do'">푸쉬알림 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_bizLink0504.do'">0504번호 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_estimate.do?pageNum=1'">견적 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_category.do?class_code=02'">카테고리 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_c_m_board.do?pageNum=1&c_s_code=01'">현장/커뮤니티 공지 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_community.do?pageNum=1'">커뮤니티 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_fieldStory.do?pageNum=1'">현장게시판 관리</span>ll
				<span class="admin_header_menu" onclick = "location.href='admin_report.do?pageNum=1'">신고 관리</span>
				<!-- <span class="admin_header_menu" onclick = "location.href='admin_charge.do?pageNum=1&charge_day=6'">유료회원 관리</span> -->
			</p>
		</div>
</body>
</html>