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
	
	<form accept-charset="UTF-8" method="POST" id="noticeInsert" action="notice_insert.do">
		
		<input type="hidden" value="${sessionScope.admin_name}" name="writer"/>
		
		<p style="font-family:'GodoM'; font-size:18px; width:980px; margin:0 auto; padding-top:1em;">공지사항 등록</p>
		
		<table class="member_table" style="text-align:left;">
			<tr>
				<td>
					작성자 : 
				</td>	
				<td>
					${sessionScope.admin_name}
				</td>
			</tr>
			<tr>
				<td>
					제목 : 
				</td>
				<td>
					<input type="text" value="" size="60" name="title" id="title">
				</td>
			</tr>
			<tr>
				<td>
					내용 : 
				</td>
				<td>
					<textarea rows="5" cols="60" id="content" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					사용유무 : 
				</td>
				<td>
					<select id="use_yn" name="use_yn">
						
							<option selected="selected" value="y">Yes</option>
							<option value="n">No</option>
					</select>
				</td>
			</tr>
		</table>
		<div style="width:980px; margin:0 auto; text-align:center; padding:2em 0 5em 0;">
			<input type="submit" value="등록" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#29A9C8; color:#fff; font-family:'GodoM'; border-radius:5px; margin-right:1em;"/>
			<input type="button" value="취소" onclick="reloaded();" style="padding:.5em 2em; border:solid 2px #29A9C8; background-color:#fff; color:#29A9C8; font-family:'GodoM'; border-radius:5px;" />
		</div>
	</form>
</body>
</html>