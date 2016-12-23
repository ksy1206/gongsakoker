<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="gongsakoker.vo.MemberVO"%>

<%
	String cp = request.getContextPath();	

    Map sessionData = null;
  
    boolean isSession = true;
    MemberVO memberVO = null;
    String member_no=null;
    String push_yn="";
    String class_code="";
    String member_id = "";
    String member_code="";
    String name = "";
    String hp01="";
    String hp02="";
    String hp03="";
    
	String app_version = "";//현재앱버전
	String ios_app_version = "";//ios 앱버전
	String current_version = "2.2.3";//현재서버버전
	String ios_current_version = "1.0.3";//현재서버버전
	
	String update_size = "big_size";//업데이트 사이즈
	String str_ver_number = "";
	String str_version = "";//출력될버전정보

	String userAgent = request.getHeader("user-agent");
	System.out.println(userAgent);
	if(userAgent.contains("CONNECT_BY_KOKER_APP")) {
		
		if(request.getParameter("app_version") != null) {
			app_version = request.getParameter("app_version");
			session.setAttribute("androidData", app_version);
		}
	 	app_version = session.getAttribute("androidData").toString();
	 	
	 	String[] appStr = app_version.split("\\.");
	 	String[] serverStr = current_version.split("\\.");
	 	
	 	int[] appInt = new int[3];
	 	int[] serverInt = new int[3];
	 	for(int i=0;i<3;i++) {
	 		appInt[i] = Integer.parseInt(appStr[i]);
	 		serverInt[i] = Integer.parseInt(serverStr[i]);
	 	}
	 	int appverInt = (appInt[0] * 100) + (appInt[1] * 10) + (appInt[2]);
	 	int serververInt = (serverInt[0] * 100) + (serverInt[1] * 10) + (serverInt[2]);
	 	System.out.println("app_version : " + appverInt);
	 	System.out.println("current_version : " + serververInt);
	 	if(appverInt < serververInt) {
	 		str_version = "최신버전이아닙니다.";
	 	}else {
	 		str_version = "최신버전입니다.";
	 		
	 	}
	 	str_ver_number = app_version;
	 	
	}else if(userAgent.contains("Connect By iPhone OS")) {
		if(request.getParameter("ios_app_version") != null) {
			ios_app_version = request.getParameter("ios_app_version");
			session.setAttribute("iosData", ios_app_version);
		}
	 	ios_app_version = session.getAttribute("iosData").toString();
	 	
	 	String[] appStr = ios_app_version.split("\\.");
	 	String[] serverStr = ios_current_version.split("\\.");
	 	
	 	int[] appInt = new int[3];
	 	int[] serverInt = new int[3];
	 	for(int i=0;i<3;i++) {
	 		appInt[i] = Integer.parseInt(appStr[i]);
	 		serverInt[i] = Integer.parseInt(serverStr[i]);
	 	}
	 	int appverInt = (appInt[0] * 100) + (appInt[1] * 10) + (appInt[2]);
	 	int serververInt = (serverInt[0] * 100) + (serverInt[1] * 10) + (serverInt[2]);
	 	
	 	System.out.println("ios_app_version : " + appverInt);
	 	System.out.println("ios_current_version : " + serververInt);
	 	if(appverInt < serververInt) {
	 		str_version = "최신버전이아닙니다.";
		} else {	
			str_version = "최신버전입니다.";
		}
		str_ver_number = ios_app_version;
	}else {
		str_version = "최신버전입니다.";
		str_ver_number = "Web";
	}
	
	
    if (session.getAttribute("sessionData") != null) {
        sessionData = (Map)session.getAttribute("sessionData");
        memberVO = (MemberVO)sessionData.get("memberInfo");
        member_no = memberVO.getMember_no();
        push_yn = memberVO.getPush_yn();
    	class_code = memberVO.getClass_code();
    	member_id =  memberVO.getMember_id();
   	  	member_code= memberVO.getMember_code();
    	name = memberVO.getName();
   	 	hp01= memberVO.getHp01();
   	  	hp02= memberVO.getHp02();
    	hp03= memberVO.getHp03();
    } else {
        isSession = false;
        session.removeAttribute("sessionData");
    }
%>

<script type="text/javascript" src="<%=cp %>/js/os/os.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	
	var os  = OSinfoDev(); //OS버젼
	
	//마이메뉴 초기화 초기화
		
		var push_yn_chk =  "<%=push_yn%>";
		 
		//알림onoff
		if(push_yn_chk=="y"){
			 $("#push_yn").attr("class","ui-block-b"); 
			 $("#push_yn >img").attr("src","../../img/my_menu/push_on.gif");
		}else{
			$("#push_yn").attr("class","ui-block-b push_off"); 
  		  	$("#push_yn >img").attr("src","../../img/my_menu/push_off.gif");
		}
		
		//알림onoff
		$("#push_yn").click(function(){
		
		var member_no = "<%=member_no%>";
		
			
		if(member_no!=null&&member_no!=""&&member_no!=undefined&&member_no!="null"){
	
		    $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/appMain/updatePush_yn.do"
		      , data        : "member_no=" + member_no
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	 
		    	  if(data.result == '1') {	
		    		 
		    		  if(data.push_yn=="y"){
		    			
		    			 $("#push_yn").attr("class","ui-block-b"); 
		    			 $("#push_yn >img").attr("src","../../img/my_menu/push_on.gif");
		    		  }else{
		    			  $("#push_yn").attr("class","ui-block-b push_off"); 
			    		  $("#push_yn >img").attr("src","../../img/my_menu/push_off.gif");
		    		  }
		    		  
					
		    	  }	
					
		      }
	    	});	
		}else{
			$("#popupCheck").popup("open");
			return false;	
		}
		    
		});
		//회원정보 로딩
		memberInfo();
		
		$("#infoMng").click(function(){
			var member_no = "<%=member_no%>";
		
			if(member_no==null||member_no=="null"||member_no==""||member_no==undefined){
				$("#popupCheck").popup("open");
				return false;
			}else{
				location.href ="<%=cp%>/member/infoMng.do";
			}
		});
		updateCheck();			
	});//end document.ready
	
	function memberInfo(){
		
    	var class_code = "<%=class_code%>";
    	var member_id =  "<%=member_id%>";
    	var member_no = "<%=member_no%>";
   	  	var member_code= "<%=member_code%>";
    	var name = "<%=name%>";
   	 	var hp= "<%=hp01%>-<%=hp02%>-<%=hp03%>";
   	 	var class_name ="";
   		
   		switch(class_code) {
   			case '01' :
   				class_name="일반회원"
   				break;
   			case '02' :
   				class_name="자재업체"
   				break;
   			case '03' :
   				class_name="기술자"
   				break;
   			case '04' :
   				class_name="장비업체"
   				break;
   			case '05' :
   				class_name="시공업체"
   				break;
   			case '06' :
   				class_name="종합"
   				break;
   			case '07' :
   				class_name="운송"
   				break;
   			default :
   				break;
   		}
 
  		
   	 	if(class_code!=null && class_code!="" && class_code!= undefined){
   	 		
	   	 	if(class_code=="01"){
	   	 		$("#member01").css("display","");
	   	 		$("#member02").css("display","none");
	   	 		$("#member02_service").css("display","none");
	   	 		$("#member03").css("display","none");
	   			$("#noMember").css("display","none");
	   			
	   			$("#member_name_01").html(name);
	   			$("#class_name_01").html(class_name);
	   			$("#member_id_01").html(member_id);
// 	   			$("#hp_01").html(hp);
	   			
	   	 	}else if(class_code=="03"){
		   	 	$.ajax({
			        type        : "POST"  
			      , async       : false 
			      , url         : "/member/getWork_sate.do"
			      , data        : "member_no=" + member_no + "&class_code=" + class_code + "&update_yn=n"
			      , dataType    : "json" 
			      , timeout     : 30000   
			      , cache       : false     
			      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			      , error       : function(request, status, error) {
						alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
			      }
			      , success     : function(data) {
			    		  if(data.work_state != null){
			    			
			    			  if(data.work_state=="0"){
				    				 $("#work_state_off").css("display","");
						 	   	 	 $("#work_state_on").css("display","none");
				    			}else{
				    				 $("#work_state_off").css("display","none");
						 	   	 	 $("#work_state_on").css("display","");
				    			}
			    		  }
			      }
		    	});	
	   	 		
	   	 		$("#member03").css("display","");
	   	 		$("#member02_service").css("display","none");
	   	 		$("#member02").css("display","none");
   	 			$("#member01").css("display","none");
   				$("#noMember").css("display","none");
   				
   			
   				$("#member_name_03").html(name);
	   			$("#class_name_03").html(class_name);
	   			$("#member_id_03").html(member_id);
	   			$("#hp_03").html(hp);
	   	 	}else{
	   	 		
	   	 		
	   	 		//유료회원 남은시간 로딩
	   	 	$.ajax({
			        type        : "POST"  
			      , async       : false 
			      , url         : "/appMain/getChargeCountDown.do"
			      , data        : "member_no=" + member_no + "&class_code=" + class_code
			      , dataType    : "json" 
			      , timeout     : 30000   
			      , cache       : false     
			      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			      , error       : function(request, status, error) {
						alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
			      }
			      , success     : function(data) {
			    	 
			    		  if(data.spare_time != null ){
			    			 charge_date = data.spare_time.split("/");
			    			 if(charge_date[0]>=0){
			    				 $("#chargeDay").html(charge_date[0]);
			    			 }else{
			    				 $("#chargeDay").html("0");
			    			 }
			    			 if(charge_date[1]>=0){
// 			    				 $("#chargeHour").html(charge_date[1]);
			    			 }else{
// 			    				 $("#chargeHour").html("0");
			    			 }
			    			 if(charge_date[2]>=0){
// 			    				 $("#chargeMin").html(charge_date[2]);
			    			 }else{
// 			    				 $("#chargeMin").html("0");
			    			 }
			    			 
			    			
			    			

			    		  }
			      }
		    	});	
	   	 		
	   	 		
	   	 		$("#member02").css("display","");
// 	   	 		$("#member02_service").css("display",""); 유료회원 운영안하기로해서 주석처리
	   	 		$("#member03").css("display","none");
   	 			$("#member01").css("display","none");
   				$("#noMember").css("display","none");
				
   				if(name=="null" || name=="" || name==null){
   					name = "";
   				}
   				
   				$("#member_name_02").html(name);
	   			$("#class_name_02").html(class_name);
	   			$("#member_id_02").html(member_id);
	   			$("#hp_02").html(hp);
	   			
	   			
	   			
	   	 	}
   	 	}else{
		
   	 		$("#noMember").css("display","");
   	 		$("#member01").css("display","none");
	 		$("#member02").css("display","none");
	 		$("#member02_service").css("display","none");
			$("#nmember03").css("display","none");
   	 	}
	}
	
	
	function updateWork_state(){
		var class_code = "<%=class_code%>";
    	var member_no = "<%=member_no%>"
   	 	$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "/member/getWork_sate.do"
	      , data        : "member_no=" + member_no + "&class_code=" + class_code + "&update_yn=y" 
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
	    		  if(data.work_state != null){
	    			
	    			if(data.work_state=="0"){
	    				 $("#work_state_off").css("display","");
			 	   	 	 $("#work_state_on").css("display","none");
	    			}else{
	    				 $("#work_state_off").css("display","none");
			 	   	 	 $("#work_state_on").css("display","");
	    			}
	    			
	    			

	    		  }
	      }
    	});
	}
	
	function moveAdvertise(member_no){
		if(member_no == null){
			 $("#popupCheck").popup("open");
		} else {
			 location.href="${pageContext.request.contextPath}/advertise/advertise_main.do?member_no="+member_no;
		}
	}
	
	
	function moveAddCompany(member_no){
		if(member_no == null){
		 $("#popupCheck").popup("open");
		} else {
			 location.href="${pageContext.request.contextPath}/addController/add_company.do";
		}
	}
	function updateCheck() {
		
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.versionUpdate("<%=str_version%>");
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s = "<%=str_version%>";
			if(s.indexOf("최신버전이아닙니다.") > -1) {
				var s2 = "iosjavascript://version_Update" + ";;;" + "itunes.apple.com/kr/app/gongsakogkeo/id1092395847?mt=8";
		    	location.href = s2;	
			}
	    }
	}
	
	function loginCheck(){
		var session = $('#session_member_no').val();
		if (session == null || session == "undefinded" || session == ''){
			$('#popupCheck').popup("open");
		}else{
			location.href = '<%=cp%>/like/likeList.do';
		}
	}
</script>	
<script>
	var os = "";
	var appExist = "";
	
	// 아래는 OS 구분에 대한 부분은 예시 코드다.  모바일이 아닌 경우도 고려해야 한다. 
	var useragent = navigator.userAgent;
	if(navigator.userAgent.toLocaleLowerCase().search("iphone") > -1){
		os = "ios";
	}else if(navigator.userAgent.toLocaleLowerCase().search("android") > -1){
		os = "android";
	}else {
		os = "else";
	}
	
	function executeAppOrGoStore() {
		if(os == "android") {
			var androidVer = "<%=app_version%>";
			var arrayVer = androidVer.split('.');
			if (arrayVer[0] > 1) {
				if (arrayVer[1] > 1) {
					if (arrayVer[2] > 2) {
						if(window.confirm("밴드로 이동합니다. \n앱이 설치되어 있지 않을 시 설치페이지로 이동합니다.")) {		
							window.android.intentBand();
						}
					}else {
						plzUpdate();
					}
				}else {
					plzUpdate();
				}
			} else {
				plzUpdate();					
			}
		}else if(os == "ios") {
			window.location = "bandapp://band/56408243";
		}else {
			
		}
	}

	function plzUpdate() {
		//alert("2.2.2 버전이하 에서는 웹브라우저로 이동합니다.");
		location.href = "http://band.us/#!/band/56408243";
		//window.android.versionUpdate("최신버전이아닙니다.");
	}
	</script>
 	<div data-role="panel" id="myPanel" data-display="overlay" data-overlay-theme="b" class="my_menu" style="position:fixed; top:0; left:0; min-height: 580px !important;"> 
		<div data-role="header" class="my_menu_header">
			<a href="#pageone" data-rel="close" data-ajax="false" class="ui-btn ui-corner-all">
				<img src="../../img/my_menu/back_icon.gif" class="header_icon" />
			</a>
			<h1>MY MENU</h1>
<!-- 			<a href="#going_popup" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-btn-right"> -->
<!-- 				<img src="../../img/my_menu/going_icon.gif" class="header_icon" /> -->
<!-- 			</a> -->
			
			<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
			
			<div data-role="popup" id="going_popup" data-dismissible="false" class="my_menu">
				<div data-role="header" class="my_menu_header">
					<h1>바로가기</h1>
					<a href="#going_popup" data-rel="close" class="ui-btn ui-corner-all ui-btn-right">
						<img src="../../img/my_menu/going_close.gif" width="60%" style="padding-top: 0.7em;"/>
					</a>
				</div>
				<div class="ui-grid-b going_popup_padding"> 
					<a href="http://homekok.com" class="ui-block-a"><img src="../../img/my_menu/going_icon_homekok.gif" class="header_icon" /></a>
					<a href="#" class="ui-block-b" onclick="executeAppOrGoStore()"><img src="../../img/my_menu/going_icon_band.gif" class="header_icon" /></a>
					<a href="http://m.blog.naver.com/PostList.nhn?blogId=zzzkin70&categoryNo=92" class="ui-block-c"><img src="../../img/my_menu/going_icon_Nblog.gif" class="header_icon" /></a>
					<a href="#" class="ui-block-a"><img src="../../img/my_menu/going_icon_wait.gif" class="header_icon" /></a>
					<!-- <a href="http://blog.daum.net/gonggan1411/648" class="ui-block-b"><img src="../../img/my_menu/going_icon_Dblog.gif" class="header_icon" /></a> -->
					<a href="#" class="ui-block-c"><img src="../../img/my_menu/going_icon_wait.gif" class="header_icon" /></a>
					<a href="#" class="ui-block-c"><img src="../../img/my_menu/going_icon_wait.gif" class="header_icon" /></a>
				</div>
			</div>
		</div>
		<div data-role="content" class="my_menu_content">
			<!-- 비회원 마이메뉴 -->
			 <div class="not_person_padding" id="noMember">
				<a href="../member/memberLogin.do" data-ajax="false">
					<div class="not_person">
						<p>회원가입 및 로그인</p>
					</div>
				</a>
			</div>
			<!-- 비회원 마이메뉴 끝 -->
			<!-- 일반회원 마이메뉴 -->
			<div class="ui-grid-a" id="member01" style="display: none;"> 
			    <div class="ui-block-a person_cha">
			    	<img src="../../img/my_menu/normal_person.gif" width="70%;" />
			    </div> 
			    <div class="ui-block-b person_info">
			    	<h4 id="member_name_01"></h4>
			    	<p style="font-size:11px; color:#666;" id="class_name_01"></p>
			    	<p id="member_id_01"></p>
			    	<p id="hp_01"></p>
			    </div> 
			</div>
			<!-- 일반회원 마이메뉴 끝 -->
			<!-- 업체회원 마이메뉴  -->
			<div class="ui-grid-a person_info_top" id="member02" style="display: none;"> 
			    <div class="ui-block-a person_cha">
			    	<img src="../../img/my_menu/company_person.gif" width="65%;" />
			    </div> 
			    <div class="ui-block-b person_info">
			    	<h4 id="member_name_02"></h4>
			    	<p style="font-size:11px; color:#666;"  id="class_name_02"></p>
			    	<p  id="member_id_02"></p>
			    	<p id="hp_02"></p>
			    </div> 
			</div>
			<div class="ui-grid-a person_info_bottom" id="member02_service" style="display: none;"> 
			    <div class="ui-block-a person_info_bottom_left">
			    	<p>서비스 종료일 :</p>
			    </div> 
			    <div class="ui-block-b person_info_bottom_right">
			    	<p>
			    		<span id="chargeDay">000</span> 일 남았습니다. <!-- <span id="chargeHour">00</span> 시 <span id="chargeMin">00</span> 분 -->
			    	</p>
			    </div> 
			</div>
			<!-- 업체회원 마이메뉴 끝 -->
			<!-- 기술자회원 마이메뉴 -->
			<div class="ui-grid-a person_info_top" id="member03" style="display: none;"> 
			    <div class="ui-block-a person_cha">
			    	<img src="../../img/my_menu/engineer_person_on.gif" width="100%;" id="work_state_on" onclick="updateWork_state()"/>
			    	<img src="../../img/my_menu/engineer_person_off.gif" width="100%;" id="work_state_off" style="display: none;" onclick="updateWork_state()" />
			    </div> 
			    <div class="ui-block-b person_info">
			    	<h4 id="member_name_03"></h4>
			    	<p style="font-size:11px; color:#666;"  id="class_name_03"></p>
			    	<p id="member_id_03"></p>
			    	<p id="hp_03"></p>
			    </div> 
			</div>
			<!-- 기술자회원 마이메뉴 끝 -->
		</div>
		<div data-role="content" class="my_menu_content02">
			<div class="ui-grid-b my_btn_group">
				<a href="#" class="ui-block-a" data-ajax="false" onclick="javascript:loginCheck();"><img src="../../img/my_menu/my_kok.gif" />나의 콕</a>
				<!-- 푸시알림 온 -->
				<a href="#" class="ui-block-b" id="push_yn"><img src="../../img/my_menu/push_on.gif" />알림</a>
				<!-- 푸시알림 온 끝 -->
				<a href="#" class="ui-block-c " data-ajax="false" id="infoMng"><img src="../../img/my_menu/my_setting.gif" />정보관리</a>
			</div>
		</div>
		<div data-role="content" class="my_menu_content03">
<!-- 			<p onclick="location.href=''">><a href="#" data-ajax="false" style="padding-left:1em;">맞춤견적</a></p> -->
			<p onclick="location.href='../notice/noticelist.do'" style="font-size:16px; color:#666;">><a href="#" data-ajax="false" style="font-size:16px; padding-left:1em;">공지사항</a></p>
			<p onclick="location.href='guide.do'" style="font-size:16px; color:#666;">><a href="#" data-ajax="false" style="font-size:16px; padding-left:1em;">이용안내</a></p>
			<p onclick="location.href='../event/eventlist.do'" style="font-size:16px; color:#666;">><a href="#" data-ajax="false" style="font-size:16px; padding-left:1em;">이벤트</a></p>
			<p onclick="moveAddCompany(<%=member_no%>)" style="font-size:16px; color:#666;">><a href="#" style="font-size:16px; padding-left:1em;">업체등록요청</a></p>
			<p onclick="location.href='../cs/cs_main.do'" style="font-size:16px; color:#666;">><a href="#" data-ajax="false" style="font-size:16px; padding-left:1em;">고객지원실</a></p>
			
			<p onclick="location.href='<%=cp%>/fieldStory/mainList.do'" style="font-size:16px; color:#666;">><a href="#" data-ajax="false" style="font-size:16px; padding-left:1em;">현장스토리</a></p>
			<p onclick="location.href='<%=cp%>/kokkok20/kokkok20list.do'" style="font-size:16px; color:#666;">><a href="#" data-ajax="false" style="font-size:16px; padding-left:1em;">콕콕!20</a></p>
			
		</div>
		<div data-role="footer" class="my_menu_footer" style="position:apsolute; bottom:0; left:0;">
			<a href="#going_popup" data-rel="popup" data-position-to="window" data-transition="pop" style="background-color: #E2E2E2; font-size:14px; text-decoration:none; text-shadow:none !important; color: #fff;">
			<p style="background-color: #29A9C8; padding:.5em 0; margin:0 1em; width: 243px;">
				<img src="../../img/my_menu/going_icon2.gif" class="header_icon" style="width: 1.5em; vertical-align: middle; margin-right: .3em;" />
			바로가기</p></a>
			<p style="margin: .7em 0 .3em 0;"><span style="border:none; font-size:14px; padding-right:.5em;">버전정보 v<%=str_ver_number%></span>
			<!-- 업데이트 -->
			<!--  <span class="version_up"><a href="#" data-ajax="false">업데이트하기</a></span> -->
			<!-- 업데이트 끝 -->
			<!-- 최신버전 -->
			<span style="padding: .3em .5em; vertical-align: middle;"><%=str_version%></span></p>
			<!-- 최신버전 끝 -->
		</div>

	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>	
			
	
	</div>
	
	
		

	
