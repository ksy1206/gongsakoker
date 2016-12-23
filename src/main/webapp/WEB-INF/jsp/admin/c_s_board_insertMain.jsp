<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet"href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
	
</script>

<title>Insert title here</title>
</head>
<body>

	<jsp:include page="admin_header.jsp" />
	
	<form  method="get" id="c_s_board_insert" name="c_s_board_insert" action="c_s_board_insert.do">
		
		<input type="hidden" name="board_complete" value="y">
		<input type="hidden" name="board_code" value="03">
		
		<table class="member_table">
			<tr>
				<td>공지사항 구분</td>
				<td style="float: left;">
					<select id="c_s_code" name="c_s_code">
						<option value="01">현장스토리</option>
						<option value="02">한줄게시판</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="c_s_title"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea cols="50" rows="5" name="c_s_content"></textarea></td>
			</tr>
			<tr>
				<td>사용유무</td>
				<td style="float: left;">
					<select id="c_s_use_yn" name="c_s_use_yn">
						<option value="y">yes</option>
						<option value="n">no</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="admin_name" value="${sessionScope.admin_name}"></td>
			</tr>
		</table>
		<div style="width:100%; margin:0 auto; text-align:center; padding:3em 0 5em 0;">
			<input type="submit" value="등록" style="background-color:#29A9C8; border-radius:5px; color:#fff; border:solid 2px #29A9C8; font-family:'GodoM'; padding:.5em 2em; margin-right:1em;">
			<input type="button" value="취소" onclick="location.href='admin_qna.do?pageNum=1'"  style="background-color:#fff; border-radius:5px; color:#29A9C8; border:solid 2px #29A9C8; font-family:'GodoM'; padding:.5em 2em; margin-right:1em;"/>
		</div>
	</form>

</body>
</html>