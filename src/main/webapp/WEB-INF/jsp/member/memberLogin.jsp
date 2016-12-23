<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<% 
	request.setCharacterEncoding("UTF-8");
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
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
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
					
					 $("#dialog_txt").text("아이디를 입력하세요.");
						$("#popupDialog").popup("open");
			 
			            return false;   
			        }
			        
			        // 비밀번호 
			        
			        if (password == '' || password == null || password == 'undefined' || password == '비밀번호') {
			        	$("#dialog_txt").text("비밀번호를 입력하세요.");
						$("#popupDialog").popup("open");
						return false;         
			        }   
				
			        doLogin();
			});		
			

	    
	});//end document ready

	
	function doLogin(){
		var member_id = $("#member_id").val();
		var password = $("#password").val();

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
	  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
			$("#popupDialog").popup("open");      
	      }
	      , success     : function(data) {
				
	    	   if(data.resultCode == 0) {
                    //alert("ID 또는 비밀번호가 틀렸습니다.");
                  	$("#dialog_txt").text(data.resultMsg);
					$("#popupDialog").popup("open");
					//$("#member_id").focus();

                    return;
                }else if(data.resultCode == 2){
                	$("#dialog_txt").text(data.resultMsg);
					$("#popupDialog").popup("open");
					

                    return;
                }else {
            		var idSave_yn = "N";
            		if($("#checkbox-mini-0").is(":checked")){
            			idSave_yn = "Y";
            		}
//                      localStorage.clear();
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
             		 		window.android.send_login(idSave_yn + ";;;" + member_id + ";;;" + password);
             		 	}else {
             		 		window.android.send_login(idSave_yn + "#" + member_id + "#" + password);
             		 	}
             		 	
             		 	//로그인 종료
                	 }
           	    	 else if(useragent.indexOf("Connect By iPhone OS") > -1) {
           				var s2 = "iosjavascript://send_login" + ";;;" + idSave_yn + ";;;" + member_id + ";;;" + password;  
           	    		document.location = s2;
           		     } 	    
             	     else {
                   	 	location.href="<%=cp%>/appMain/appMain.do";
                	 }
                   	
                }   
	      }
    	});
	}
</script>


<body>

<div data-role="page" class="koker_page login_page">
	<div data-role="header" data-position="fixed" class="join_header">
		<div class="back_btn">
			<a href="<%=cp%>/appMain/appMain.do" data-ajax="false"  class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>로그인 및 회원가입</h1>
	</div>
	<div data-role="content" class="join_content join_box"> 
		<div class="login_btn">
			<a href="#two_page" style="text-decoration:none;"><input type="button" value="로그인"></a>
		</div> 
	</div>
	<div data-role="content" class="join_content join_bg">
		<div class="ui-grid-a join_grid">
			<div class="ui-block-a">
				<img src="../img/joinLogin/login_cha.gif" width="100%"/>
			</div>
			<div class="ui-block-b">
				<h2>회원가입</h2>
				<p style="font-size: 1em;">회원가입을 통해 더 많은 혜택을 누리세요!</p>
			</div>
		</div>
		<div class="join_go" onclick="location.href='memberJoin.do'">
			<a href="#" data-ajax="false">일반 회원</a>
		</div>
		<div class="join_go" onclick="location.href='companyJoin.do'">
			<a href="#" data-ajax="false">업체 및 기술자</a>
		</div>
	</div>
	<div class="copyright_text">
		<p>(주)공간<span>공사콕커</span><a href="http://www.ftc.go.kr/info/bizinfo/communicationView.jsp?apv_perm_no=2015401023930200173&area1=&area2=&currpage=1&searchKey=04&searchVal=1408192864&stdate=&enddate=">사업자정보 확인</a></p>
		<p>대표이사 : 김철민 ㅣ 사업자등록번호 : 140-81-92864 </p>
		<p>통신판매업신고번호 : 제2015-경기시흥 0173호</p>
		<p>경기도 시흥시 봉우재로 51, 5층</p>
		<p>개인정보관리책임자 : 서승균 s.w@gonggan2014.com</p>
		<div class="copyright_box">
			<p>공사콕커는 통신판매중개자이며, 통신판매의</p>
			<p>당사자가 아닙니다. 따라서 공사콕커는 상품거래 정보</p>
			<p>및 거래에 대한 책임은 지지 않습니다.</p>
		</div>
	</div>
</div>

<div data-role="page" class="koker_page" id="two_page" style="background-color:#fff !important;">
	<div data-role="header" data-position="fixed" class="join_header">
	<a href="<%=cp%>/member/memberLogin.do" data-ajax="false"  class="relback_btn"><img src="../img/relback.gif"/></a>
		<h1>로그인</h1>
	</div>
	<div data-role="content" class="join_content join_box"> 
		<div class="login_input">
			<input type="email" id="member_id" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
					onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="이메일 주소"/>
			<input type="password" id="password" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
					onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="비밀번호"/>
		</div>
		<div class="auto_login">
			<input type="checkbox" name="checkbox-0" id="checkbox-mini-0" class="custom" data-mini="true" />
			<label for="checkbox-mini-0" style="padding: .7em 0 .7em 3em;">자동 로그인</label>
		</div>
		<div class="login_btn">
			<input type="button" value="로그인" id="memberLogin_btn" >
			<a href="findPw.do" data-ajax="false">비밀번호를 잊어버리셨나요?</a>
		</div> 
	</div>
	<div class="copyright_text">
		<p>(주)공간<span>공사콕커</span><a href="http://www.ftc.go.kr/info/bizinfo/communicationView.jsp?apv_perm_no=2015401023930200173&area1=&area2=&currpage=1&searchKey=04&searchVal=1408192864&stdate=&enddate=">사업자정보 확인</a></p>
		<p>대표이사 : 김철민 ㅣ 사업자등록번호 : 140-81-92864 </p>
		<p>통신판매업신고번호 : 제2015-경기시흥 0173호</p>
		<p>경기도 시흥시 봉우재로 51, 5층</p>
		<p>개인정보관리책임자 : 서승균 s.w@gonggan2014.com</p>
		<div class="copyright_box">
			<p>공사콕커는 통신판매중개자이며, 통신판매의</p>
			<p>당사자가 아닙니다. 따라서 공사콕커는 상품거래 정보</p>
			<p>및 거래에 대한 책임은 지지 않습니다.</p>
		</div>
	</div>
	
	<div id="popupDialog" class="com_popup" style="max-width:400px;" data-role="popup" data-theme="b" data-overlay-theme="b" data-dismissible="false">
	    <div class="com_popup_text" role="main">
	        <p id="dialog_txt"></p>
	        <a href="#" data-rel="back" data-ajax="false">확인</a>
	    </div>
	</div>
	
</div>



</body>
</html>

