<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">

	//시작시에 자동 로그인이 되어 있으면 자동로그인 하기
	function doLogin_auto(data){
		
		var array_data;// 아이디 비밀번호 문자열로 잘라 배열넣기
		
		var useragent = navigator.userAgent;
		
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			//버전비교 -- 로그인
			array_data = data.split(";;;");
		}else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			array_data = data.split(";;;");
		}else {
			array_data = data.split(";;;");
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
					alert("자동 로그인에 실패했습니다.");
					var useragent = navigator.userAgent;   
					if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
						goAppMain();
						cancelAuto();
					}
					else if(useragent.indexOf("Connect By iPhone OS") > -1) {
						cancelAuto();
					} 	    
	            } else {
	            	
	                 localStorage.clear();
	                 var useragent = navigator.userAgent;
	               	//안드로이드 함수 (자동로그인 함수)
	                 if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
 	                	 window.android.send_Autologin(member_id);
	         		}
	         		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
	         			var s2 = "iosjavascript://send_Autologin" + ";;;" + member_id; 
           	    		document.location = s2;
	         		} 	    
	         		else {
	         		    	 	
	         		}
	                
	            }   
	      }
		});
	}
	function goAppMain() {
		var useragent = navigator.userAgent;  
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.send_version();
		}else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			
		}
	}
	function cancelAuto() {
		var useragent = navigator.userAgent;  
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.cancelAuto();
		}else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s2 = "iosjavascript://cancelAuto()";
			document.location = s2;
		}else {
			
		}
	}
	
	</script>
</head>


<!--   -->

	
</html>

