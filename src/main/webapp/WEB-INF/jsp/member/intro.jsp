<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
	String cp = request.getContextPath();
	String androidData = "";
	if(session.getAttribute("androidData") != null) {
		androidData = session.getAttribute("androidData").toString();	
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="../css/koker_mobile.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<script type="text/javascript">
//시작시에 자동 로그인이 되어 있으면 자동로그인 하기
function doLogin(data){
	
	var array_data;// 아이디 비밀번호 문자열로 잘라 배열넣기
	
	var useragent = navigator.userAgent;
	if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
	//버전비교 -- 로그인
	var appVer = "<%=androidData%>";
	  	var appStr = appVer.split(".");
		var appInt = new Array();
		for(var i=0;i<3;i++) {
			appInt[i] = parseInt(appStr[i]);
		}
		var verint = (appInt[0]*100) + (appInt[1]*10) + (appInt[2]);
		if(verint > 211) {
			array_data = data.split(";;;");
		}else {
			array_data = data.split("#");
		}
	}
	  
	
	var member_id = array_data[0]
	var password = array_data[1]

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
              	$("#dialog_txt").text("ID 또는 비밀번호가 틀렸습니다.");
				$("#popupDialog").popup("open");
				//$("#member_id").focus();

                return;
            } else {
                 localStorage.clear();
                 var useragent = navigator.userAgent;
               	//안드로이드 함수 (자동로그인 함수)
                 if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
                	 window.android.send_Autologin(member_id);
         		}
         		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
         		
         		} 	    
         		else {
         		    	 	
         		}
                
            }   
      }
	});
}
</script>
</head>
<body>
 
<div data-role="page" class="intro">
	<div class="intro_logo">
		<img src="../img/intro/intro_logo.png" style="width:100%;"/>
		<p>어서와, 공사콕커는 처음이지?</p>
	</div>
	<div class="intro_cha">
		<img src="../img/intro/intro_cha.png" style="width:100%;"/>
	</div>
	<div class="intro_btn01">
		<a href="../member/memberLogin.do" data-role="button" data-ajax="false">회원가입 및 로그인</a>
	</div>
	<div class="intro_btn02">
		<a href="../appMain/guide.do" data-role="button" data-ajax="false">둘러보기</a>
	</div>
	<div data-role="footer" class="intro_footer">
		<h6>copyright ⓒ (주) 공간 All Rights Reserved.</h6>
	</div>
</div> 
</body>
</html>