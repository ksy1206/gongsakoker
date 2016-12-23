<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="stylesheet" href="../css/koker_admin.css">
<c:if test="${result == 0}">
<script>

	alert("비밀번호를 확인해주세요!!");

</script>
</c:if>
<c:if test="${result == 1}">
<script>

	location.href = "admin_main.do";

</script>
</c:if>
<c:if test="${result == 2}">
<script>

	alert("존재하지 않는 아이디 입니다.!!");

</script>
</c:if>
<c:if test="${result == 3}">
<script>

	alert("로그아웃 되었습니다.!!");

</script>
</c:if>




<script type="text/javascript">
	function checkId(){
		
		var id = document.getElementById("admin_id").value;
		var pw = document.getElementById("admin_pw").value;
		
		if(id==null||id=="" || id=="아이디를 입력하세요."){
			
			document.getElementById("alert_style").innerHTML = "아이디를 입력해주세요.";
			 return false;
		}
		 
		if(pw==null||pw=="" || id==""){

			document.getElementById("alert_style").innerHTML = "비밀번호를 입력해주세요.";
			 return false;
			 
		}
		
	}
</script>

</head>
<body>
	<form action="admin_checkId.do" method="post" accept-charset="utf-8">
		<div style="width:980px; margin:0 auto; padding-top:10%; text-align:center;">
			<div style="padding:5%;">
				<img src="../img/admin/logo.png" style="width:30%"/>
			</div>
			<div style="width:40%; border:solid 2px #d7d7d7; border-radius: 5px; margin:0 auto; padding: .4em 0 .5em 0;">
				<p style="margin:0;">
					<img src="../img/admin/login_icon.png" style="width:1em; vertical-align:middle; padding: 0 1em; border-right:double 7px #d7d7d7;"/>
					<input type="text" name="admin_id" id="admin_id" style="border:none; width:75%; height: 2em; margin: 0 .5em; font-family:'GodoM'; font-size:14px; padding:0 .5em; color:#DBDBDB;"
					onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
					onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="아이디를 입력하세요."/>
				</p>
			</div>
			<p></p>
			<div style="width:40%; border:solid 2px #d7d7d7; border-radius: 5px; margin:0 auto; padding: .4em 0 .5em 0;">
				<p style="margin:0;">
					<img src="../img/admin/login_pw_icon.png" style="width:1em; vertical-align:middle; padding: 0 1em; border-right:double 7px #d7d7d7;"/>
					<input type="password" name="admin_pw" id="admin_pw" style="border:none; width:75%; height: 2em; margin: 0 .5em; font-family:'GodoM'; font-size:14px; padding:0 .5em; color:#DBDBDB;"/>
				</p>
			</div>
			<div>
				<p id="alert_style" style="font-family:'GodoM'; font-size:14px; color:red;"></p>
			</div>
			<input type="submit" value="로그인" onclick="return checkId();" style="width:40%; border:solid 2px #29A9C8; border-radius: 5px; margin:0 auto; padding: .7em 0 .8em 0; background-color:#29A9C8; margin:0; color:#fff; font-family:'GodoM'; font-size:16px;" />
			<div style="margin-top:15%; cursor:pointer;" onclick="location.href='http://homekok.com/admin/admin.php'">
				<img src="../img/admin/admin_banner.png" style="width:100%;"/>
			</div>
			<div style="margin-top:5%; cursor:pointer;" onclick="location.href='http://gonggan2014.co.kr'">
				<p style="font-size:8px;">copyrightⓒ GONGGAN CO.,LTD All Reserved</p>
			</div>
		</div>
	</form>	
</body>
</html>