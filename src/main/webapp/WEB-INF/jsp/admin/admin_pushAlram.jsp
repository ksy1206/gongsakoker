<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<script type="text/javascript">
	function pushSubmit(){
		document.pushAlram.action = 'admin_pushAlramMethod.do';
		var push_title = document.getElementById('push_title').value;
		var push_content = document.getElementById('push_content').value;
		if(push_title == '' || push_title == null || push_title == undefined){
			alert('제목이 비어있습니다.');
			document.getElementById('push_title').focus();
			return;
		}else if (push_content == '' || push_content == null || push_content == undefined){
			alert('내용이 비어있습니다.');
			document.getElementById('push_content').focus();
			return;
		}
		document.pushAlram.submit();
		alert("푸쉬알람을 보내셨습니다.")
	}
</script>
</head>
<body>
	
	<jsp:include page="admin_header.jsp"/>
	
	<form id="pushAlram" name="pushAlram" method="post"> 
		<p style="font-family:'GodoM'; font-size:18px; padding-top:1em; width:980px; margin:0 auto;">푸쉬알람 관리</p>	
		<table class="member_table">
			<tr>
				<td style="width:10%;">
					<label for="push_title">제목</label>
				</td>
				<td style="width:80%;">
					<input type="text" id="push_title" name="push_title" style="width:90%;">
				</td>
			</tr>
			<tr>
				<td style="width:10%;">
					<label for="push_content">내용</label>
				</td>
				<td style="width:80%;">
					<textarea id="push_content" name="push_content" style="width:90%; height:400px;"></textarea>
				</td>
			</tr>
		</table>
			<div style="width:100%; text-align:center; padding:2em 0 5em 0; font-family:'GodoM'; font-size:14px;">
				<span onclick="javascript:pushSubmit();" style="background-color:#29A9C8; color:#fff; padding:.5em 2em; border-radius:5px;">보내기</span>
			</div>
	</form>
	
</body>
</html>