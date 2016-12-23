<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script src="//code.jquery.com/jquery-1.11.3.min.js" ></script >
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>   
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>

<script type="text/javascript">
	function deleteForm(board_no){
		if(confirm("정말 삭제하시겠습니까?")==true){
			location.href='qna_delete.do?board_no='+board_no+"&pageNum=1";
		}else{
			return;
		}
	}
</script>

<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<c:forEach items="${list}" var="list">
		<form action="qna_update.do" method="post" id="qnaUpdate" name="qnaUpdate">
			
			<input type="hidden" name="pageNum" id="pageNum" value="1"/>
			<input type="hidden" name="board_no" id="board_no" value="${list.board_no}"/>
			
			<table class="member_table" style="text-align:left;">	
				<tr>
					<td style="width:20%;">제목</td>
					<td style="width:80%;"><input type="text" name="board_title" id="board_title" value="${list.board_title}"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea cols="50" rows="5" name="board_content" id="board_content">${list.board_content}</textarea></td>
				</tr>
				<tr>
					<td>관리자 답변</td>
					<td><textarea cols="50" rows="5" id="answer_content" name="answer_content">${list.answer_content}</textarea></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="board_write" id="board_write" value="${list.board_write}" /></td>
				</tr>
				<tr>
					<td>작성날짜</td>
					<td>${list.board_date}</td>
				</tr>
			</table>
			
			<div style="width:100%; margin:0 auto; text-align:center; padding:3em 0 5em 0;">
				<input type="submit" value="수정" style="background-color:#29A9C8; border-radius:5px; color:#fff; border:solid 2px #29A9C8; font-family:'GodoM'; padding:.5em 2em; margin-right:1em;"/>
				<input type="button" value="삭제" onclick ="javascript:deleteForm(${list.board_no});" style="background-color:#fff; border-radius:5px; color:#29A9C8; border:solid 2px #29A9C8; font-family:'GodoM'; padding:.5em 2em; margin-right:1em;"/>
				<input type="button" value="취소"  onclick="location.href='admin_qna.do?pageNum=1'" style="background-color:#fff; border-radius:5px; color:#666; border:solid 2px #666; font-family:'GodoM'; padding:.5em 2em;"/>
			</div>

		</form>
	</c:forEach>
	
</body>
</html>