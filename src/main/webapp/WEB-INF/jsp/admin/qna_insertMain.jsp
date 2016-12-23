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
	
	<form  method="post" id="qnaInsert" name="qnaInsert" action="qna_insert.do">
		
		<input type="hidden" name="board_complete" value="y">
		<input type="hidden" name="board_code" value="03">
		
		<table class="member_table">
			<tr>
				<td>자주묻는 질문 제목</td>
				<td><input type="text" name="board_title"/></td>
			</tr>
			<tr>
				<td>자주묻는 질문 내용</td>
				<td><textarea cols="50" rows="5" name="board_content"></textarea></td>
			</tr>
			<tr>
				<td>자주묻는 질문 관리자 내용</td>
				<td><textarea cols="50" rows="5" name="answer_content"></textarea></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="board_write" value="${sessionScope.admin_name}"></td>
			</tr>
		</table>
		<div style="width:100%; margin:0 auto; text-align:center; padding:3em 0 5em 0;">
			<input type="submit" value="등록" style="background-color:#29A9C8; border-radius:5px; color:#fff; border:solid 2px #29A9C8; font-family:'GodoM'; padding:.5em 2em; margin-right:1em;">
			<input type="button" value="취소" onclick="location.href='admin_qna.do?pageNum=1'"  style="background-color:#fff; border-radius:5px; color:#29A9C8; border:solid 2px #29A9C8; font-family:'GodoM'; padding:.5em 2em; margin-right:1em;"/>
		</div>
	</form>

</body>
</html>