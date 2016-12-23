<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<link rel="stylesheet" href="../css/layout.css" />
<link rel="stylesheet" href="../css/main.css" />
<link rel="stylesheet" href="../css/swiper.min.css">
<link rel="stylesheet" href="../css/join.css" />
<title>공사 KOKER</title>


</head>
<body>

	<div>
		<div>
			<div class="board_header">
 				<jsp:include page="../../web/include/header.jsp"/>
			</div>
		</div>
	</div>
	
	<div class="board_content">
		<div class="main">
			<div class="board_header">
			<div class="title" style="vertical-align: bottom; padding:3em 0 2em 0; text-align:center; border-bottom:solid 1px #ddd;margin-bottom:15%;">
				<i><h1 style="color:#21b4d6; font-size:32px;">JOIN<span style="font-size:14px; color:#636363;">회원가입</span></h1>
					<p style="color: #888; vertical-align: middle; font-size:11px;">회원 유형을 선택해주세요.</p></i>
			</div>
		</div>
			<div class="login_box" style="border-bottom:none;margin-bottom:25%;">
				<div class="join_main">
					<button type="button" onclick="location.href='#'" style="border:2px #29a9c8 solid;background-color:#fff;color:#29a9c8;">
					<a href="<%=cp%>/member/webJoin.do"  style="color:#29a9c8;">일반회원 가입</a></button>
					<button type="button" onclick="location.href='#'" style="border:2px #29a9c8 solid;background-color:#29a9c8;color:#fff;">
					<a href="<%=cp%>/member/webCompanyJoin.do"  style="color:#fff;">업체회원 가입</a></button>

				</div>
			</div>
		</div>
	</div>
	
	<div class="footer_wrap">

 			<jsp:include page="../../web/include/footer.jsp"/> 
 
	</div>
	
	
</body>
</html>