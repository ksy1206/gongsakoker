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
<title>공사 KOKER</title>

<script type="text/javascript">

	$(document).ready(function() {
		
		$('#password').keyup(function(e) {
		    if (e.keyCode == 13){
		    	$("#memberLogin_btn").click();
			
		    }      
		});
		
		$.ajaxSetup({cache : false});
		
		
		//로그인 버튼 클릭
		$("#memberLogin_btn").click(function(){
			  event.preventDefault();//기본 동작취소
				var member_id = $("#member_id").val();
				var password = $("#password").val();
				
				// 아이디
				 if (member_id == '' || member_id == null || member_id == 'undefined' || member_id == '이메일 주소') {
					
						alert("아이디를 입력하세요.");
			            return false;   
			        }
			        
			        // 비밀번호 
			        
			        if (password == '' || password == null || password == 'undefined' || password == '비밀번호') {
			        	alert("비밀번호를 입력하세요.");
						return false;         
			        }   
				
			        doLogin();
			});		
			

	    
	});//end document ready

	
	function doLogin(){
		var member_id = $("#member_id").val();
		var password  = $("#password").val();

		var params = "member_id="+member_id+"&password="+password;
		
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "<%=cp%>/member/doMember_login.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	  	    	alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");   
	      }
	      , success     : function(data) {
				
	    	   if(data.resultCode == 0) {
                    //alert("ID 또는 비밀번호가 틀렸습니다.");
                  	alert(data.resultMsg);
                    return;
                }else if(data.resultCode == 2){
                	alert(data.resultMsg);
                    return;
                }else {
            		var idSave_yn = "N";
            		if($("#auto").is(":checked")){
            			idSave_yn = "Y";
            		}
            	
//                      localStorage.clear();
                   	 	
                   	 	location.href="<%=cp%>/web/gongsakoker.do";

                }   
	      }
    	});
	}
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
				<i>
				<h1>LOGIN</h1>
					<p style="color: #636363; vertical-align: middle; font-size: 15pt; font-weight: bold;">공사콕커</p>
				</i>
			</div>
			<div class="login_box">
				<div class="login_idpw">
					<input type="id" id="member_id" placeholder="이메일 주소">
					<input type="password" id="password" placeholder="비밀번호">
					<div><input type="checkbox" id="auto"><label for="auto">자동 로그인</label></div>
					<button type="button" id="memberLogin_btn">로그인</button>
				</div>
			</div>
			<div class="login_sub">
				<span><a href="<%=cp%>/member/findPw_web.do">비밀번호 찾기</a></span>
				<span>|</span>
				<span><a href="<%=cp%>/member/joinMain.do">회원가입</a></span>
			</div>
		</div>
	</div>
	
	<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp"/>
	</div>
	
	
</body>
</html>