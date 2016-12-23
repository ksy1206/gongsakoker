<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.Map" %>
<%@page import="gongsakoker.vo.MemberVO"%>

<%
	String cp = request.getContextPath();	
	String androidData = "";
	if(session.getAttribute("androidData") != null) {
		androidData = session.getAttribute("androidData").toString();	
	}
	String iosData = "";
	if(session.getAttribute("iosData") != null) {
		iosData = session.getAttribute("iosData").toString();	
	}
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


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="stylesheet" href="../css/koker_mobile.css">
	<link rel="stylesheet" href="../css/swiper.min.css">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
	<script src="../js/swiper.min.js"></script>
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
	<script src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerclusterer/1.0.2/src/markerclusterer.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			
			var swiper = new Swiper('.swiper-container', {
				pagination: '.swiper-pagination',
				paginationClickable: true,
				centeredSlides: true,
				autoplay: 3000,
				autoplayDisableOnInteraction: false,
				loop: true,
			});
			
			var data = 1;
			filterInit(data);
			
		});
		
		//필터 초기화
		function filterInit(data){
			var adius = $("#adius").val();
			var chk_code = $("#chk_code").val();
			if(data == 2){
				$("input:radio[name='radio-choice']:radio[value='"+adius+"']").removeAttr("checked");
				$("input:radio[name='radio-choice-w-6']:radio[value='"+chk_code+"']").removeAttr("checked");
				
				adius = 10000;
				chk_code = 01;
				$("#adius").val("10000");
				$("#chk_code").val("01");
				$("input:radio[name='radio-choice']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-radio-off");
				$("input:radio[name='radio-choice-w-6']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-off");
				$("input:radio[name='radio-choice']:radio[value='10000']").attr("checked",true);
				$("input:radio[name='radio-choice-w-6']:radio[value='01']").attr("checked",true);
				$("#radio-choice-3").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-radio-on");
				$("#radio-choice-w-6a").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-on ui-first-child");
				return;
			}else if (data==1){
				
				if('${sessionScope.adius}' != ''){
					$('#adius').val('${sessionScope.adius}');
					adius = $("#adius").val();
					if('${sessionScope.chk_code}' != ''){
						$('#chk_code').val('${sessionScope.chk_code}');
						chk_code = $("#chk_code").val();
					}
				}else{
					$('#adius').val('30000')
					adius = '30000';
					$('#chk_code').val('01');
					chk_code = '01';
				}
				
				$("input:radio[name='radio-choice']:radio[value='"+adius+"']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-radio-off");
				$("input:radio[name='radio-choice-w-6']:radio[value='"+chk_code+"']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-off");
				$("input:radio[name='radio-choice']:radio[value='"+adius+"']").attr("checked",true);
				$("input:radio[name='radio-choice-w-6']:radio[value='"+chk_code+"']").attr("checked",true);
				$("#radio-choice-3").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-radio-on");
				$("#radio-choice-w-6a").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-on ui-first-child");	
				$.mobile.changePage('#main');
			}
			
		}
		
		//핉터 저장
		function filterSave(){
			var adius = $(':radio[name="radio-choice"]:checked').val();
			var chk_code = $(':radio[name="radio-choice-w-6"]:checked').val();
			
			$('#adius').val(adius);
			$('#chk_code').val(chk_code);
			
			$("input:radio[name='radio-choice']:radio[value='"+adius+"']").attr("checked",true);
			$("input:radio[name='radio-choice-w-6']:radio[value='"+chk_code+"']").attr("checked",true);
			$.mobile.changePage('#main');
		}
		
		//필터 취소
		function filterCancle(){
			var adius = $("#adius").val();
			var chk_code = $("#chk_code").val();
			if(adius == $(':radio[name="radio-choice"]:checked').val() && chk_code == $(':radio[name="radio-choice-w-6"]:checked').val()){
				$.mobile.changePage('#main');
			}else {
				$("#dialog_txt").text("변경된 사항을 저장하시겠습니까?");
   				$("#popupDialog").popup("open");
			}
		
		}
		
		function filterConfirm(data){
			var adius = $("#adius").val();
			var chk_code = $("#chk_code").val();
			if(data == 1 ){
				$("input:radio[name='radio-choice']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-radio-off");
				$("input:radio[name='radio-choice-w-6']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-off");
				$("input:radio[name='radio-choice']:radio[value='"+adius+"']").attr("checked",true);
				$("input:radio[name='radio-choice']:radio[value='"+adius+"']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-radio-on");
				$("input:radio[name='radio-choice-w-6']:radio[value='"+chk_code+"']").attr("checked",true);
				$("input:radio[name='radio-choice-w-6']:radio[value='"+chk_code+"']").prev().attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-radio-on ui-first-child");
				$.mobile.changePage('#main');			
			}else if(data == 2){
				filterSave();
			}
		}
		
		//지역보드 이동
		function move_local_board(){
			var session = <%=member_no%>;
//		 	if(session == null){
//		 		 $("#popupCheck").popup("open");
//		 	} else {
//		 		 location.href="${pageContext.request.contextPath}/areaBoard/areaBoardMain.do";
//		 	}
			//준비중이 아니면 location.href 풀것
			//location.href="${pageContext.request.contextPath}/areaBoard/areaBoardMain.do";
		}
		
		function moveCategory(class_code){
			$("#class_code").val(class_code);

			if ($('#latitude').val() != null && $('#latitude').val() != '') {
				document.moveForm.submit();
			} else {
				$("#addrText").html('새로고침을 눌러주세요.');
				$("#popupGPS").popup("open");
				return false;
			}
		}
		
		//위치 호출
		function getLocation() {
			$("#addrText").html('GPS 설정이 필요합니다.');
			//안드로이드 호출
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.reflashGPS("GPS");
		    }
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				document.location = "iosjavascript://reflashGPS";
		    }
		    else {
			//웹호출
				receiveLocation('37.347280$126.745569');
		    }
		}

		//위치 위도,경도 저장
		function receiveLocation(location) {
			
			var array_data = location.split("$");  // 위도 경도 문자열로 잘라 배열넣기
			
			//히든에 위도 경도 저장하기
			$("#latitude").val(array_data[0]);
			$("#longitude").val(array_data[1]);
			
			reflashMap();
			
		}
		
		function reflashMap() {

			var latlng = new google.maps.LatLng($("#latitude").val(), $("#longitude").val());
			var geocoder = new google.maps.Geocoder(); 
			
			geocoder.geocode({'location': latlng}, function(results, status) {
				var addrText = "";
				if( status == google.maps.GeocoderStatus.OK ) {
					addrText = results[0].formatted_address.split('대한민국');
					//addrText = results[0].formatted_address;
					$("#address").val(addrText);
				} else {
					addrText = '새로고침을 눌러주세요.';
				}
				$("#addrText").html(addrText);
			}); 
		}
		
		window.onload=function() {
			
			getLocation();
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
			var androidVer = "<%=androidData%>";
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

</head>
<body>
	<form name="moveForm" id="moveForm" action="mainCategory.do" method="get">
		<input type="hidden" id="latitude" name="latitude" value="" />
		<input type="hidden" id="longitude" name="longitude" value="" />
		<input type="hidden" id="adius" name="adius" value="" />
		<input type="hidden" id="chk_code" name="chk_code" value="" />
		<input type="hidden" id="class_code" name="class_code" value="" />
		<input type="hidden" id="address" name="address" value="" />
		<input type="hidden" id="member_no" name="member_no" value="<%=member_no%>" />
	</form>
<div data-role="page" id="main" class="koker_page" style="background-color:#e5e5e5;">
 <jsp:include page="../include/myMenu.jsp" flush="true" />
	
	<div data-role="header" class="search_header" style="border:0 !important; background-color:#21B4D6 !important;">		
		<iframe id="hfrADCheck" src="//adcheck.about.co.kr/mad/prd/view?shopid=sweetco" scrolling="no" frameborder="0" width="0" height="0"  style="display: none;"></iframe> 
		<div>
			<a href="#myPanel" class="relback_btn" data-ajax="false">
				<img src="../img/header/my_menu.png" />
			</a>
		</div>
		<h1 style="text-align:center; background-color:#21B4D6 !important; padding:0;"><img src="../img/header/logo.png" style="width:6.5em;" /></h1>
		<div class="ui-btn-right" style="padding-top:.2em;">
			<a href="../search/search.do" style="text-decoration:none; color:#21B4D6; margin-right:.5em;" data-ajax="false" id="test">
				<img src="../img/header/search.png" class="header_icon" style="width:2.2em; vertical-align:top;" />
			</a>
			<a href="JavaScript:window.location.reload()" data-ajax="false">
				<img src="../img/header/reset.png" class="header_icon" style="width:2.2em; vertical-align:top;" />
			</a>
		</div>
	</div>
	<div data-role="content" class="main_content" style="padding:0 0 .5em 0 !important;"> 
	<!-- <p style="padding:0 .5em; color:#29A9C8; font-size:14px; text-shadow:none !important;">콕커의 또 다른 서비스<img src="../img/main/v01.png" style="width:1em; margin-left:.5em;"/></p> -->
		<div class="img_menu">
			<div class="ui-grid-c ca_grid2" style="padding: .3em 0 0em 1%;">
				<%-- <a href="<%=cp%>/fieldStory/mainList.do" onclick="move_local_board()" class="ui-block-a ca_block_c" data-ajax="false" style="margin-right:1.3%;"> 
					<img src="../img/menu/area.png" style="width:100%;" />
			    	<div class="ca_text2">
			    		<h6>현장스토리</h6>
			    		<p>생생현장 포착!</p>
			    	</div>
		    	</a>
				<a href="<%=cp%>/kokkok20/kokkok20list.do" class="ui-block-b ca_block_d" data-ajax="false" style="margin-right:1.3%;">
					<img src="../img/menu/kok20.png" style="width:100%;" />
			    	<div class="ca_text2">
			    		<h6>콕콕!20</h6>
			    		<p>최고를 모았어요</p>
			    	</div>
				</a> --%>
				<a href="<%=cp%>/estimate/mainList.do?estType01_code=1&type01=1&type02=all" class="ui-block-c ca_block_e" data-ajax="false" style="margin-right:1.3%;height:100%;">
					<img src="../img/menu/auction02.png" style="width:100%;" />
					<p>맞춤견적</p>
			    	<!-- <div class="ca_text2">
			    		<h6>맞춤견적</h6>
			    		<p>맞춤 견적 서비스</p>
			    	</div> -->
				</a>
				<%-- <a href="<%=cp%>/community/community_main.do?start=0&end=5" class="ui-block-d ca_block_f" data-ajax="false"> --%>
				<a href="javascript:executeAppOrGoStore()" class="ui-block-d ca_block_f" data-ajax="false">
					<img src="../img/menu/band.jpg" style="width:100%;" />
					<p>커뮤니티</p>
			    	<!-- <div class="ca_text2">
			    		<h6>커뮤니티</h6>
			    		<p>한줄을 남겨요.</p>
			    	</div> -->
				</a>
			</div>
		</div> 
		<div class="point_add" style="margin:0 0 0.5em 0.1em;border:2px solid blue;width:98%">
			<h3 style="line-height:34px; width:80%;"><div id="addrText" style="height:40px;">로딩중 입니다...</div></h3>
			<div class="ui-btn-right">
				<a href="#popstreet" data-transition="slideup">
					<div class="str_pop">
						<p><img src="../img/main/filter.gif" style="width:1.5em; vertical-align:middle;"/><span id="adiusText">반경설정</span></p>
					</div>
				</a>
			</div>
		</div>
		<div class="ui-grid-a ca_grid" style="text-align:center;"> 
		    <div class="ui-block-a ca_block_a" style="margin: 0 1.5%; text-align: left;" onclick="javascript:moveCategory('02');" data-ajax="false">
		    	<img src="../img/main/ca01.png"/>
		    	<div class="ca_text">
		    		<h6>자재업체</h6>
		    		<p>모든 자재업체를 콕커!</p>
		    	</div>
		    </div> 
		    <div class="ui-block-b ca_block_b" style="margin: 0 1.5%; text-align: left;" onclick="javascript:moveCategory('05');" data-ajax="false">
		    	<img src="../img/main/ca02.png"/>
		    	<div class="ca_text">
		    		<h6>시공업체</h6>
		    		<p>빠르게 시공업체 찾기</p>
		    	</div>
		    </div> 
	    </div> 
		<div class="ui-grid-a ca_grid" style="text-align:center;"> 
		    <div class="ui-block-a ca_block_a" style="margin: 0 1.5%; text-align: left;" onclick="javascript:moveCategory('04');" data-ajax="false">
		    	<img src="../img/main/ca03.png"/>
		    	<div class="ca_text">
		    		<h6>장비업체</h6>
		    		<p>대형 장비업체들도 준비 OK!</p>
		    	</div>
		    </div> 
		    <div class="ui-block-b ca_block_b" style="margin: 0 1.5%; text-align: left;" onclick="javascript:moveCategory('03');" data-ajax="false">
		    	<img src="../img/main/ca04.png"/>
		    	<div class="ca_text">
		    		<h6>기술자</h6>
		    		<p>작업상태를 확인 가능!</p>
		    	</div>
		    </div> 
	    </div> 
		<div class="ui-grid-a ca_grid" style="text-align:center;"> 
		    <div class="ui-block-a ca_block_a" style="margin: 0 1.5%; text-align: left;" onclick="javascript:moveCategory('06');" data-ajax="false">
		    	<img src="../img/main/ca05.png"/>
		    	<div class="ca_text">
		    		<h6>종합</h6>
		    		<p>설계 · 감리, 안전관리, 디자인</p>
		    	</div>
		    </div> 
		    <div class="ui-block-b ca_block_b" style="margin: 0 1.5%; text-align: left;" onclick="javascript:moveCategory('07');" data-ajax="false">
		    	<img src="../img/main/ca06.png"/>
		    	<div class="ca_text">
		    		<h6>운송</h6>
		    		<p>이사짐부터 화물, 퀵까지 !</p>
		    	</div>
		    </div> 
	    </div> 
	</div> 

	<div data-role="footer" style="border: none;">
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
		        <div onclick="location.href='http://newhk.firstmall.kr/main/index'" class="swiper-slide" data-ajax="false"><img src="../img/banner/newhomekokbanner.jpg" width="100%"></div>
		        <div onclick="location.href='<%=cp%>/event/event_movePage.do?event_no=23'" class="swiper-slide"><img src="../img/banner/mainbanner_join.png" width="100%"></div>
		        <div onclick="" class="swiper-slide"><a href='https://www.facebook.com/homekok715/?fref=ts'><img src="../img/banner/mainbanner_jib.png" width="100%"></a></div>
		        <div onclick="location.href='<%=cp%>/event/event_movePage.do?event_no=25'" class="swiper-slide"><img src="../img/banner/mainbanner_call.png" width="100%"></div>
	        </div>
	        <div class="swiper-pagination"></div>
	    </div>
	    <p style="font-size: 1%; color: #666; margin: .5em; text-shadow:none; font-weight:normal !important;">공사콕커는 통신판매중개자이며 통신판매의 당사자가 아닙니다. 따라서 공사콕커는 상품거래정보 및 거래에 책임을 지지 않습니다.</p>  
	</div>
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
  		</div>    
 	</div>	
	
	<div id="popupGPS" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="addrText">GPS가 설정되지 않았습니다.</p>
      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
  		</div>    
 	</div>
 	 	
</div>

<section id="popstreet" data-role="page" style="font-family:'GodoM';">
	<div data-role="header" class="search_header" style="position:relative;">		
		<div class="pop_btn_left">
			<a href="#" data-ajax="false" onclick="javascript:filterInit('2');">초기화</a>
		</div>
		<h1 style="font-family:'GodoM'; font-size:18px !important;">반경설정</h1>
		<div class="ui-btn-right pop_btn_right" onclick="javascript:filterCancle();">
			<a href="#">x</a>
		</div>
	</div>
    <div class="content" data-role="content" style="padding:.5em !important;">
		<p style="font-size:12px; color:#444;">검색반경</p>
    	<form>
	        <fieldset data-role="controlgroup" data-type="horizontal" class="radio_set">
		     	<input type="radio" name="radio-choice" id="radio-choice-1" value="1000" />
		     	<label for="radio-choice-1">1km</label>
		
		     	<input type="radio" name="radio-choice" id="radio-choice-2" value="5000" />
		     	<label for="radio-choice-2">5km</label>
		
		     	<input type="radio" name="radio-choice" id="radio-choice-3" value="10000"/>
		     	<label for="radio-choice-3">10km</label>
		
		     	<input type="radio" name="radio-choice" id="radio-choice-4" value="20000" />
		     	<label for="radio-choice-4">20km</label>
		
		     	<input type="radio" name="radio-choice" id="radio-choice-5" value="30000" />
		     	<label for="radio-choice-5">30km</label> 
			</fieldset>
		</form>
		<p style="font-size:12px; color:#444;">검색설정</p>
		<form>
		    <fieldset data-role="controlgroup" data-iconpos="right" class="radio_set2">
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6a" value="01">
		        <label for="radio-choice-w-6a" style="border-bottom:solid 1px #e5e5e5 !important;">거리순</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6b" value="02">
		        <label for="radio-choice-w-6b" style="border-bottom:solid 1px #e5e5e5 !important;">콕콕!20순</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6c" value="03">
		        <label for="radio-choice-w-6c">추천순</label>
		    </fieldset>
		</form>
    </div>
    <footer data-role="footer" data-position="fixed" style="background-color: rgba(255, 255, 255, 0.01) !important; border:none !important;">
		<div style="text-align: center; margin:0;" >
			<img src="../img/search/search_tikok.gif" style="vertical-align:bottom; width:35%; margin-bottom: -2.7%;"/>
			<p style="margin:0; padding:1em; background-color:#29A9C8; text-align: center; color:#fff; text-shadow:none !important; font-size:14px; font-weight:normal !important;" onclick="javascript:filterSave();" >적용하기</p>
		</div>
   	</footer>
 	<div id="popupDialog" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="dialog_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-ajax="false" onclick="javascript:filterConfirm('1')">취소</a>   
      	  	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirm" onclick="javascript:filterConfirm('2')">저장</a>    
  	  	</div>    
	</div>
	
 	<div id="popupSave" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p>저장되었습니다.</p>
      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
  		</div>    
 	</div>	
</section>

</body>
</html>