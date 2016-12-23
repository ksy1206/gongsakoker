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
<link rel="stylesheet" href="../css/login.css" />
<link rel="stylesheet" href="../css/alertify.core.css" />
<link rel="stylesheet" href="../css/alertify.default.css" id="toggleCSS" />
<script src="../js/web/alertify.min.js"></script>
<title>공사 KOKER</title>

<script type="text/javascript">
$(document).ready(function() {

	
	$("#sendEmailPw_btn").click(function(){
		
		var member_id = $("#member_id").val();
		if(member_id==""||member_id=="null"||member_id==null||member_id==undefined||member_id=="이메일 주소를 입력하세요."){
			alertify.alert("이메일 주소를 입력해주세요");
			
		}
		    $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/member/sendEmailPw.do"
		      , data        : "member_id=" + member_id
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		    	   alertify.alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
					
					
		      }
		      , success     : function(data) {
					
					if(data.result=="1"){
						alertify.alert("메일전송완료");
						
					}else{
						alertify.alert("이메일주소가 틀렸습니다.");
						
					}
					
					
		      }
	    	});
		
	});	

	
	

});//end document ready
</script>

</head>
<body style="background-color:#fff;">

	<div>
		<div>
			<div class="board_header">
				<jsp:include page="../../web/include/header.jsp"/>
				</div>
		</div>
	</div>
	
	<div class="board_content">
		<div class="main">
			<div class="title" style="vertical-align: bottom;">
				<i><h1>LOGIN</h1>
					<p style="color: #636363; vertical-align: middle; font-size: 15pt; font-weight: bold;">공사콕커</p></i>
			</div>
			<div class="login_box">
				<div class="login_idpw">
					<h3 style="color:#636363;font-family:'GodoM';text-align:center;margin-bottom:20px;">비밀번호 찾기</h3>
					<input type="id" id="member_id" placeholder="이메일 주소를 입력하세요.">
					<button type="button" id="sendEmailPw_btn" >비밀번호 초기화 메일 발송</button>
				</div>
			</div>
			<div class="login_sub" style="width:100px;margin:0 auto;">
				<span style="text-align:center;"><a href="<%=cp%>/member/joinMain.do">회원가입</a></span>
			</div>
		</div>
	</div>
	
	<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp"/>
	</div>
	
	
</body>
</html>