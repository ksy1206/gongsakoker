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
	function questionUP(){
		var name= $('#answer_write').val();
		var sessionName = '${sessionScope.admin_name}';
		if(name==sessionName){
			document.questionUpdate.submit();	
		}else if(name!=sessionName){
			$('#answer_write').val('${sessionScope.admin_name}');
			document.questionUpdate.submit();
		}
		
	}
</script>

<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<div style="width:980px; margin:0 auto; border:double 4px #29A9C8; margin-top:2em; padding:1em; border-radius:5px; font-family:'GodoM'; font-size:14px; color:#666;">
	<c:forEach items="${list}" var="list">
		<table style="width:100%;">	
			<tr>
				<td style="width:20%;">내용</td>
				<td>${list.board_content}</td>
			</tr>
			<tr>
				<td>작성자</td>
				<td>${list.board_write}</td>
			</tr>
			<tr>
				<td>작성날짜</td>
				<td>${list.board_date}</td>
			</tr>
			<tr>
				<td>작성자 연락처</td>
				<td>${list.board_phone}</td>
			</tr>
		</table>
		
		<c:if test="${list.board_complete == 'y' }">
			<form action="question_update.do" method="post" id="questionUpdate" name="questionUpdate">
			
				<input type="hidden" name="board_no" id="board_no" value="${list.board_no}"/>
				<input type="hidden" name="board_complete" id="board_complete" value="y"/>
				<input type="hidden" name="pageNum" id="pageNum" value="1"/>
				<input type="hidden" name="answer_no" id="answer_no" value="${list.answer_no}"/>
				
				<table style="width:100%;">
					<tr>
						<td style="width:20%;">관리자 답변</td>
						<td><textarea cols="50" rows="5" id="answer_content" name="answer_content" style="font-family:'GodoM'; font-size:14px; color:#666; width:100%; height:500px; resize:none;">${list.answer_content}</textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="answer_write" id="answer_write" value="${list.answer_write}"  style="font-family:'GodoM'; font-size:14px; color:#666;"/></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center; padding:3em 0 1em 0;">
							<input type="button" value="수정" onclick="javascript:questionUP();" style="font-family:'GodoM'; font-size:14px; color:#fff; border:solid #29A9C8 1px; background-color:#29A9C8; border-radius:5px; padding:.5em 2em; margin-right:1em;"/>
							<input type="button" value="취소"  onclick="location.href='admin_question.do?pageNum=1'" style="font-family:'GodoM'; font-size:14px; color:#29A9C8; border:solid #29A9C8 1px; background-color:#fff; border-radius:5px; padding:.5em 2em;"/>
						</td>
					</tr>
				</table>
			</form>
		</c:if>
		
		<c:if test="${list.board_complete == 'n' }">
			<form action="question_insert.do" method="post" id="questionInsert" name="questionInsert">
			
				<input type="hidden" name="board_no" id="board_no" value="${list.board_no}"/>
				<input type="hidden" name="board_complete" id="board_complete" value="y"/>
				<input type="hidden" name="pageNum" id="pageNum" value="1"/>
				
				<table style="width:100%;">
					<tr>
						<td style="width:20%;">관리자 답변</td>
						<td><textarea cols="50" rows="5" id="answer_content" name="answer_content" style="font-family:'GodoM'; font-size:14px; color:#666; width:100%; height:500px; resize:none;">${list.answer_content}</textarea></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td><input type="text" name="answer_write" id="answer_write" value="${sessionScope.admin_name}" readonly="readonly" style="font-family:'GodoM'; font-size:14px; color:#666;" /></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center; padding:3em 0 1em 0;">
							<input type="submit" value="답변등록" style="font-family:'GodoM'; font-size:14px; color:#fff; border:solid #29A9C8 1px; background-color:#29A9C8; border-radius:5px; padding:.5em 2em; margin-right:1em;"/>
							<input type="button" value="취소" onclick="location.href='admin_question.do?pageNum=1'" style="font-family:'GodoM'; font-size:14px; color:#29A9C8; border:solid #29A9C8 1px; background-color:#fff; border-radius:5px; padding:.5em 2em;"/>
						</td>
					</tr>
				</table>
			</form>
		</c:if>
		
	</c:forEach>
	</div>
</body>
</html>