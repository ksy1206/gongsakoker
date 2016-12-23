<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {

		
		$("#sendEmailPw_btn").click(function(){
			
			var member_id = $("#member_id").val();
			
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
			    	    $("#dialog_txt2").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
						$("#popupDialog2").popup("open");
						
			      }
			      , success     : function(data) {
						
						if(data.result=="1"){
							$("#dialog_txt").text("메일전송완료");
							$("#popupDialog").popup("open");
						}else{
							$("#dialog_txt2").text("이메일주소가 틀렸습니다.");
							$("#popupDialog2").popup("open");
						}
						
						
			      }
		    	});
			
		});	
	
		
		

	});//end document ready

</script>

<body>
 
<div data-role="page" class="koker_page" style="background-color:#fff !important;">
	<div data-role="header" data-position="fixed" class="join_header" >
	<a href="#" data-ajax="false" data-rel="back" class="relback_btn"><img src="../img/relback.gif"/></a>
		<h1>비밀번호 찾기</h1>
	</div>
	<div data-role="content" class="join_content join_box"> 
		<div class="find_text">
			<p> 회원가입시 등록한 이메일을 이용하여</p>
			<p>비밀번호를 초기화하여 재설정하실 수 있습니다.</p>
		</div>
		<div class="login_input">
			<input type="email" id="member_id" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
					onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="이메일 주소를 입력해주세요."/>
		</div>
		<div class="find_btn">
			<input type="button" value="비밀번호 초기화 메일 발송" id="sendEmailPw_btn">
		</div> 
		
		<div id="popupDialog" class="com_popup" style="max-width:400px;" data-role="popup" data-theme="b" data-overlay-theme="b" data-dismissible="false">
		    <div class="com_popup_text" role="main">
		        <p>
		        	* 메일 발송 시간 약5~10분 소요예정
		        	<br />메일이 도착 지연시
		        	<br />고객지원실로 연락바랍니다.
		        </p>
		        <p>
		        	<span>고객지원실 : 1566-5831</span>
		        	<br />(오전9시 ~ 오후6시/주말, 공휴일 휴무)
		        </p>
		        <a href="#" data-rel="back" data-ajax="false" id="dialog_txt"></a>
		    </div>
		</div>
		
		<div id="popupDialog2" class="com_popup" style="max-width:400px;" data-role="popup" data-theme="b" data-overlay-theme="b" data-dismissible="false">
		    <div class="com_popup_text" role="main">
		        <p id="dialog_txt2">
		        	
		        </p>
		       
		        <a href="#" data-rel="back" data-ajax="false" >확인</a>
		    </div>
		</div>
	</div>
</div>
<div>



</div> 

</body>
</html>