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
<c:if test="${result == 1}">
<script>

	alert("수정되었습니다!!");

</script>
</c:if>
<script type="text/javascript">
	function c_s_board_update(){
		
		document.c_s_board_form.action = 'c_s_board_update.do';
		document.c_s_board_form.submit();		
		
	}
</script>

<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	<div style="width:980px; margin:0 auto; border:double 4px #29A9C8; margin-top:2em; padding:1em; border-radius:5px; font-family:'GodoM'; font-size:14px; color:#666;">
	<form id="c_s_board_form" name="c_s_board_form" method="get">
	
		<c:forEach items="${list}" var="list">
		
			<input type="hidden" name="c_s_no" id="c_s_no" value="${list.c_s_no}">
		
			<table style="width:100%;">	
				<tr>
					<td style="width:20%;">제목</td>
					<td><input type="text" name="c_s_title" id="c_s_title" value="${list.c_s_title}" style="font-family:'GodoM'; font-size:14px; color:#666;" size="50" /></td>
				</tr>
				<tr>
					<td style="width:20%;">분류</td>
					<td>
						<c:if test="${list.c_s_code == '01'}">
							<select id="c_s_code" name="c_s_code">
								<option value="01" selected="selected">현장스토리</option>
								<option value="02">한줄게시판</option>
							</select>
						</c:if>
						<c:if test="${list.c_s_code == '02'}">
							<select id="c_s_code" name="c_s_code">
								<option value="01">현장스토리</option>
								<option value="02" selected="selected">한줄게시판</option>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>작성날짜</td>
					<td>${list.c_s_insert_date}</td>
				</tr>
				<tr>
					<td>사용유무</td>
					<td>	
						<c:if test="${list.c_s_use_yn == 'y'}">
							<select id="c_s_use_yn" name="c_s_use_yn">
								<option value="y" selected="selected">yes</option>
								<option value="n">no</option>
							</select>
						</c:if>
						<c:if test="${list.c_s_use_yn == 'n'}">
							<select id="c_s_use_yn" name="c_s_use_yn">
								<option value="y">yes</option>
								<option value="n" selected="selected">no</option>
							</select>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>작성자</td>
					<td><input type="text" name="admin_name" id="admin_name" value="${list.admin_name}" style="font-family:'GodoM'; font-size:14px; color:#666;" /></td>
				</tr>
				<tr>
					<td style="width:20%;">내용</td>
					<td><textarea cols="50" rows="5" id="c_s_content" name="c_s_content" style="font-family:'GodoM'; font-size:14px; color:#666; width:100%; height:500px; resize:none;">${list.c_s_content}</textarea></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center; padding:3em 0 1em 0;">
						<input type="button" value="수정"  onclick="javascript:c_s_board_update();" style="font-family:'GodoM'; font-size:14px; color:#fff; border:solid #29A9C8 1px; background-color:#29A9C8; border-radius:5px; padding:.5em 2em; margin-right:1em;"/>
						<input type="button" value="취소"  onclick="location.href='admin_c_m_board.do?pageNum=1&c_s_code=01'" style="font-family:'GodoM'; font-size:14px; color:#29A9C8; border:solid #29A9C8 1px; background-color:#fff; border-radius:5px; padding:.5em 2em;"/>
					</td>
				</tr>
			</table>
		</c:forEach>
	</form>
	</div>
</body>
</html>