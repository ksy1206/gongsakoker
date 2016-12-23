<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
<script type="text/javascript">
	function reloaded(){
		
		location.href="admin_notice.do"
		
	}
</script>

<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<form accept-charset="UTF-8" method="POST" id="noticeUpdate" action="notice_update.do">
		
		<p style="font-family:'GodoM'; font-size:18px; width:980px; margin:0 auto; padding-top:1em;">공지사항 수정</p>
		
		<table class="member_table" style="text-align:left;">
			<c:forEach items="${noticeOne}" var="no">
				<tr>
					<td colspan="2">
						<input type="hidden" value="${no.notice_no}" name="notice_no" id="notice_no"/>
					</td>
				</tr>
				<tr>
					<td>
						작성자 : 
					</td>	
					<td>
						${no.writer}
					</td>
				</tr>
				<tr>
					<td>
						제목 : 
					</td>
					<td>
						<input type="text" value="${no.title}" size="60" name="title" id="title">
					</td>
				</tr>
				<tr>
					<td>
						내용 : 
					</td>
					<td>
						<textarea rows="5" cols="60" id="content" name="content">${no.content}</textarea>
					</td>
				</tr>
				<tr>
					<td>
						사용유무 : 
					</td>
					<td>
						<select id="use_yn" name="use_yn">
							<c:if test="${no.use_yn == 'y'}">
								<option selected="selected" value="y" >Yes</option>
								<option value="n">No</option>
							</c:if>
							<c:if test="${no.use_yn == 'n'}">
								<option value="y">Yes</option>
								<option selected="selected" value="n">No</option>
							</c:if>
						</select>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<div style="width:980px; margin:0 auto; text-align:center; padding:2em 0 5em 0;">
			<input type="submit" value="수정" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'GodoM'; border-radius:5px; margin-right:1em;"/>
			<input type="button" value="취소" onclick="reloaded();" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#fff; color:#29A9C8; font-family:'GodoM'; border-radius:5px;" />
		</div>
		
	</form>
</body>
</html>