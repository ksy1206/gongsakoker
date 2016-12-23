<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
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
	String current_version = "1.0";//현재서버버전
	String str_version = "";//출력될버전정보

	//app_version = request.getParameter("app_version");
	//app_version = session.getAttribute("androidData").toString();
	if (app_version.equals(current_version)) {
		str_version = "최신버전입니다.";
	} else {
		str_version = "최신버전이아닙니다.";
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


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="../css/swiper.min.css">

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerclusterer/1.0.2/src/markerclusterer.js"></script>
<script src="../js/swiper.min.js"></script>

<script type="text/javascript">
	
		$(document).on("pagecreate","#main",function(){
		  $("img").on("swipeleft",function(){
		  });                       
		});
		$(document).on("pagecreate","#main",function(){
		  $("img").on("swiperight",function(){
		  });                       
		});
		
		function reflashMapCode(){
			$(document).on("pageshow","#main",function(){
				reflashMap();
			});	
		}
		
		
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
			document.listPageGo.action ="mapList.do";
			document.listPageGo.submit();
			//reflashMapCode();
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
		
		//필터 변경사항 확인
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
		
		function listPage(){
			
			document.listPageGo.action ="kokerListPage.do";
			document.listPageGo.submit();
			
		}
	</script>
	
</head>

<body>
	
	<form method="get" id="listPageGo" name="listPageGo">
		<input type="hidden" id="chk_code" name="chk_code" value="${chk_code}" />
		<input type="hidden" id="latitude" name="latitude" value="${latitude}" />
		<input type="hidden" id="longitude" name="longitude" value="${longitude}" />
		<input type="hidden" id="adius" name="adius" value="${adius}" />
		<input type="hidden" id="class_code" name="class_code" value="${class_code}" />
		<input type="hidden" id="category" name="category" value="${category}" />
		<input type="hidden" id="member_no" name="member_no" value="<%=member_no %>" />
		<input type="hidden" id="address" name="address" value="${address}" />
	</form>

	<div data-role="page" id="main" class="koker_page list_page">
	 <jsp:include page="../include/myMenu.jsp" flush="true" />
		<div data-role="header" class="main_header category_header" data-position="fixed" style="border: none; background-color:#fff !important;">
			<a href="#myPanel" class="ui-btn ui-corner-all" data-ajax="false">
				<img src="../img/header/my_menu_me.png" class="header_icon" style="width: 95% !important;" />
			</a>
			<h1 style="margin: .7em 25% .3em 25% !important; color:#29A9C8; font-size:18px;">
				<c:if test="${class_code == 02}">자재업체</c:if>
				<c:if test="${class_code == 04}">장비업체</c:if>
				<c:if test="${class_code == 05}">시공업체</c:if>
				<c:if test="${class_code == 06}">종합</c:if>
				<c:if test="${class_code == 07}">운송</c:if>
			</h1>
			<div class="ui-btn-right">
				<a href="../search/search.do" class="ui-btn ui-corner-all" data-ajax="false" id="test"><img src="../img/header/search_me.png" class="header_icon" style="padding:0.3em 0.5em 0 0 !important;"/></a>
				<a href="appMain.do" class="ui-btn ui-corner-all" data-ajax="false" style="margin: 0 5px 0;"><img src="../img/header/home.png" class="header_icon" style="padding:0.3em 0.5em 0 0 !important;"/></a>
			</div>
		</div>
		<div data-role="content" class="main_content" style="background-color:#fff !important; padding:0 0 .5em 0 !important;">
			<div class="point_add" style="background-color:#e5e5e5 !important; height: 45px; padding: 0;">
				<h3 style="font-size:12px; line-height:34px; width:80%;"><div id="addrText">로딩중 입니다...</div></h3>
				<div class="ui-btn-right">
					<a href="#popstreet" data-transition="slideup">
						<div class="str_pop" style="margin-top: -1%; padding: 0.5em .7em 0.5em .7em;">
							<p><img src="../img/main/filter.gif" style="width:1.5em; vertical-align:middle;"/><span id="adiusText">반경설정</span></p>
						</div>
					</a>
				</div>
			</div>
		</div>
		<div id="map-page" class="list_map_grid">
			<div role="main" class="ui-content list_map_view" id="map-canvas">
			</div>
			<div data-role="content" class="list_map_content"  >
				<div class="list_map_wrap">
				</div>
			</div>
		</div>
		
		<div data-role="footer" data-position="fixed" style="border: none; background-color: rgba(255, 255, 255, 1)!important;">
			<div style="text-align:center; margin:0; padding:.5em;" onclick="javascript:listPage();">
				<p style="margin:0; padding:1em; background-color:#29A9C8; text-align: center; color:#fff; text-shadow:none !important; font-size:14px; font-weight:normal !important;">
				<img src="../img/map/map_list_btn.png" style="width:1.5em; vertical-align:middle; margin-right:1em;" />리스트 보기</p>
			</div>
		
			 <!--end 팝업부분 -->
			
			 <!-- Swiper -->
		    <div class="swiper-container">
		        <div class="swiper-wrapper">
			        <div onclick="" class="swiper-slide"><a href="https://www.facebook.com/homekok715/?fref=ts"><img src="../img/banner/mainbanner_jib.png" width="100%"></a></div>
			        <div onclick="location.href='http://newhk.firstmall.kr/main/index'" class="swiper-slide"><img src="../img/banner/newhomekokbanner.jpg" width="100%"></div>
			        <div onclick="location.href='<%=cp%>/event/event_movePage.do?event_no=25'" class="swiper-slide" data-ajax="false"><img src="../img/banner/mainbanner_call.png" width="100%"></div>
			        <div onclick="location.href='<%=cp%>/event/event_movePage.do?event_no=23'" class="swiper-slide"><img src="../img/banner/mainbanner_join.png" width="100%"></div>
		    	</div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination"></div>
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

<script type="text/javascript">

var kokerList = new Array();
var markersList = new Array();
	
	//뒤로가기
	function callList() {
		
		var str = 'latitude=' + $('#latitude').val()
		+ '&longitude=' + $('#longitude').val()
		+ '&adius=' + $('#adius').val()
		//+ '&adius=10000'
		+ '&class_code=' + $('#class_code').val()
		+ '&category=' + $('#category').val()
		+ '&address=' + $('#address').val()
		+ '&member_no=' + $('#member_no').val();
		
		location.href="${pageContext.request.contextPath}/appMain/kokerListPage.do?"+str;
		
	}
	
	function setAdius() {
		
		var adius = $(':radio[name="radio-choice-h-2"]:checked').val();
		$("#adius").val(adius);
		
		var str = 'latitude=' + $('#latitude').val()
		+ '&longitude=' + $('#longitude').val()
		+ '&adius=' + $('#adius').val()
		//+ '&adius=10000'
		+ '&class_code=' + $('#class_code').val()
		+ '&category=' + $('#category').val()
		+ '&member_no=' + $('#member_no').val();
		
		location.href="${pageContext.request.contextPath}/appMain/MapList.do?"+str;
	}
	
	function getKoker() {
		
		var str = 'latitude=' + $('#latitude').val()
		+ '&longitude=' + $('#longitude').val()
		+ '&adius=' + $('#adius').val()
		+ '&class_code=' + $('#class_code').val()
		+ '&chk_code=' + $('#chk_code').val()
		+ '&category=' + $('#category').val()
		+ '&member_no=' + $('#member_no').val();
		
		 $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/appMain/MapMarker.do"
		      , data        : str
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {	
				if (data.kokerList != null) {
					for ( var i = 0; i < data.kokerList.length; i++) {
			  			kokerList.push(data.kokerList[i]);
			  		}
				}
		  		setMap();
		      }
		      
	    });	
		
	}
/* 
 * 김기윤
 * 내 위치 위도, 경도 호출 및 맵 새로 고침
 */
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
	
	markersList = kokerList;
	
	getKoker();

	kokerList = new Array();
	markersList = new Array();
}


window.onload=function() {
	reflashMap();
}  

</script>

<script type="text/javascript">
/* 
 * 김기윤
 * 지도 호출
 */
/*
 * Google Maps documentation: http://code.google.com/apis/maps/documentation/javascript/basics.html
 * Geolocation documentation: http://dev.w3.org/geo/api/spec-source.html
 */
function setMap() {
	 
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	var markers = new Array();
	var map;
	var myIcon = new google.maps.MarkerImage("../img/map/myMark4.png", null, null, null, new google.maps.Size(30,40));
	var icon02 = new google.maps.MarkerImage("../img/map/icon02.png", null, null, null, new google.maps.Size(18,25));
	var icon04 = new google.maps.MarkerImage("../img/map/icon04.png", null, null, null, new google.maps.Size(18,25));
	var icon05 = new google.maps.MarkerImage("../img/map/icon05.png", null, null, null, new google.maps.Size(18,25));
	var icon06 = new google.maps.MarkerImage("../img/map/icon06.png", null, null, null, new google.maps.Size(18,25));
	 
	var defaultLatLng = new google.maps.LatLng(latitude, longitude);  // Default to Hollywood, CA when no geolocation support
	drawMap(defaultLatLng);
	/* 
	if ( navigator.geolocation ) {
		function success(pos) {
			// Location found, show map with these coordinates
			drawMap(new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude));
		}
		function fail(error) {
			drawMap(defaultLatLng);  // Failed to find location, show default map
		}
		// Find the users current position.  Cache the location for 5 minutes, timeout after 6 seconds
		navigator.geolocation.getCurrentPosition(success, fail, {maximumAge: 500000, enableHighAccuracy:true, timeout: 6000});
	} else {
		drawMap(defaultLatLng);  // No geolocation support, show default map
	} */
	function drawMap(latlng) {
		var adius = $(':radio[name="radio-choice"]:checked').val();
		var zoomSize = 0;
		if (adius == '1000') {
			zoomSize = 14;
		} else if (adius == '5000') {
			zoomSize = 13;
		} else if (adius == '10000') {
			zoomSize = 11;
		} else if (adius == '20000') {
			zoomSize = 10;
		} else if (adius == '30000') {
			zoomSize = 9;
		}
		var myOptions = {
			zoom: zoomSize,
			center: latlng,
			panControl: false,
		  	zoomControl: false,
		  	mapTypeControl: false,
		 	scaleControl: false,
		 	streetViewControl: false,
		  	overviewMapControl: false,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
		// Add an overlay to the map of current lat/lng
		
		var marker = new google.maps.Marker({
			position: latlng,
			map: map,
			icon: myIcon
		});
		setMarkers();
	}
	
function setMarkers() {
		
		var setIcon;
		var infowindow = new google.maps.InfoWindow();
		for (var i = 0; i < markersList.length; i++) {
			//반복문으로 외부 데이터를 기반으로 마커를 생성해줍니다.
			var latLng = new google.maps.LatLng(markersList[i].latitude, markersList[i].longitude);
			//마커 색 선택
			if (markersList[i].class_code == '02') {
				setIcon = icon02;
			} else if (markersList[i].class_code == '04') {
				setIcon = icon04;
			} else if (markersList[i].class_code == '05') {
				setIcon = icon05;
			} else if (markersList[i].class_code == '06') {
				setIcon = icon06;
			}
			
			var marker = new google.maps.Marker({
		            position: latLng,
		            icon: setIcon,
		            title: markersList[i].koker_name + "$" + markersList[i].koker_no
		          });
			
			//마커들을 markers 배열안에 넣습니다.
			markers.push(marker); 
			
			google.maps.event.addListener(marker, 'click', (function(marker, i) {
		   		return function() {
		    	var tit = marker.title;
		    	var array_data = tit.split("$");  // 위도 경도 문자열로 잘라 배열넣기
		    	
		    	//히든에 위도 경도 저장하기
		    	var koker_name = array_data[0];
		    	var koker_no = array_data[1];
		    	map.setCenter(marker.getPosition());
				infowindow.setContent('<a href="../kokkok20/kokkok20_details.do?koker_no='+koker_no+'&backCount=1" style="text-decoration:none;color:#666;" data-ajax="false"><div style="font-size:11px;">'+koker_name+'</div></a>');
					infowindow.open(map, marker);
				}
			})(marker, i));
			
		}
		var clusterStyles = [
		                     {
		                       textColor: 'white',
		                       url: '../img/map/m1.png',
		                       height: 50,
		                       width: 50
		                     },
		                    {
		                       textColor: 'white',
		                       url: '../img/map/m2.png',
		                       height: 50,
		                       width: 50
		                     },
		                    {
		                       textColor: 'white',
		                       url: '../img/map/m3.png',
		                       height: 50,
		                       width: 50
		                    },
		                    {
			                   textColor: 'white',
			                   url: '../img/map/m4.png',
			                   height: 50,
			                   width: 50
			                },
		                    {
			                   textColor: 'white',
			                   url: '../img/map/m5.png',
			                   height: 50,
			                   width: 50
			                }
		                   ];
		
		var markerClusterer = new MarkerClusterer(map, markers, {
	          maxZoom: 16,
	          gridSize: 40,
	          styles: clusterStyles
		});
	
	}
	 
 }
</script>


</body>
</html>