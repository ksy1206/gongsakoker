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
	
		/* $(document).on("pagecreate","#main",function(){
			$("img").on("swipeleft",function(){
			 alert("1");
			});                       
		});
		$(document).on("pagecreate","#main",function(){
			$("img").on("swiperight",function(){
			});                       
		}); */

		
		$(document).ready(function(){
			var swiper = new Swiper('.swiper-container');
			
			$(".swiper-container").on('swipe',function(){
				 alert("12");
//					var test = $(".swiper-slide-active").html();
//					alert(test);
				});	
		});
	
	</script>
	
</head>

<body>

	<input type="hidden" id="latitude" name="latitude" value="${latitude}"/>
	<input type="hidden" id="longitude" name="longitude" value="${longitude}" />
	<input type="hidden" id="adius" name="adius" value="${adius}"/>
	<input type="hidden" id="class_code" name="class_code" value="${class_code}" />
	<input type="hidden" id="category" name="category" value="${category}"/>
	<input type="hidden" id="member_no" name="member_no" value="<%=member_no%>"/>

	<div data-role="page" id="main" class="koker_page list_page">
		<div data-role="header" class="list_header">
			<div class="back_btn">
				<a href="#" data-ajax="false" class="relback_btn" onclick="javascript:callList();"><img src="../img/relback.gif"/></a>
			</div>
			<h1>내주변</h1>
			<div class="ui-btn-right">
				<a href="" onclick="javascript:callList();"><img src="../img/list/list_map_icon.gif" style="width:1.7em;" /></a>
			</div>
		</div>
		<div data-role="content" class="main_content">
			<div class="point_add">
				<h3>경기도 시흥시 정왕동 1837-3</h3>
				<div class="ui-btn-right">
					<a href="#pop_street" data-rel="popup" data-position-to="window" data-transition="pop">
						<div class="str_pop">
							<p><div id="adiusText"></div></p>
						</div>
					</a>
						<div data-role="popup" class="pop_street" id="pop_street" data-overlay-theme="b" data-theme="b" data-dismissible="false">
	    					<p>검색 반경 선택</p>
								<div class="ui-grid-d" class="pop_radio_div"> 
								    <div class="ui-block-a">
								        <input type="radio" name="radio-choice-h-2" class="pop_radio01" id="radio-choice-h-2a" value="500">
								        <label for="radio-choice-h-2a"> 
											<p>500 m</p>
										</label>
									</div> 
								    <div class="ui-block-b">
								        <input type="radio" name="radio-choice-h-2" class="pop_radio02" id="radio-choice-h-2b" value="1000">
								        <label for="radio-choice-h-2b"> 
											<p>1 Km</p>
										</label>
									</div> 
								    <div class="ui-block-c">
								        <input type="radio" name="radio-choice-h-2" class="pop_radio03" id="radio-choice-h-2c" value="5000" checked="checked">
								        <label for="radio-choice-h-2c"> 
											<p>5 Km</p>
										</label>
									</div> 
								    <div class="ui-block-d">
								        <input type="radio" name="radio-choice-h-2" class="pop_radio04" id="radio-choice-h-2d" value="10000">
								        <label for="radio-choice-h-2d"> 
											<p>10 Km</p>
										</label>
									</div> 
								    <div class="ui-block-e">
								        <input type="radio" name="radio-choice-h-2" class="pop_radio05" id="radio-choice-h-2e" value="20000">
								        <label for="radio-choice-h-2e"> 
											<p>20 Km</p>
										</label>
									</div> 
								</div>
							<div class="pop_street_btn">
								<a href="#" class="radio_btn" data-rel="back" data-ajax="false" onclick="javascript:setAdius();">
									<p>적용</p>
								</a>
							</div>
						</div>
				</div>
			</div>
		</div>
		<div id="map-page" class="list_map_grid">
			<div role="main" class="ui-content list_map_view" id="map-canvas">
			</div>
			<div data-role="content" class="list_map_content"  >
			
			<div class="list_map_wrap">
			<div class="swiper-container">
			<div class="swiper-wrapper" >
			
			
		    <c:if test="${not empty kokerList}">
			<c:forEach var="koker" items="${kokerList}" varStatus="count">
			
			   <div class="swiper-slide">
				<div class="ui-grid-a"> 
				    <div class="ui-block-a list_stats_img">
				    	<img src="../../img/list/list_bg.jpg" />
						<div class="list_img_mark">
						    <c:if test="${'0' ne koker.bookmark_no}">
						    	<img src="../../img/list/list_zzim_on.png" />	
						    </c:if>
						    <c:if test="${'0' eq koker.bookmark_no}">
						    	<img src="../../img/list/list_zzim_off.png" />	
						    </c:if>
				    	</div>
				    </div> 
				    
				    <div class="ui-block-b list_stats_group" id="test_${count.count}">
				    	<h6>${koker.koker_name }
						    <c:if test="${'03' eq koker.class_code}">
							    <c:if test="${'1' eq koker.state}">
							    	<img src="../../img/list/list_wait.gif" />
							    </c:if>
							    <c:if test="${'0' eq koker.state}">
							    	<img src="../../img/list/list_wark.gif" />	
							    </c:if>
						    </c:if>
				    	</h6>
				    	<div class="ui-grid-c list_stats" style="padding:.5em 0 0 0;"> 
						    <div class="ui-block-a" style="width:20% !important;">
						    	<p><img src="../../img/list/list_star.gif" width="5em" />${koker.review_avg }</p>
						    </div> 
						    <div class="ui-block-b" style="width:20% !important;">
						    	<p><img src="../../img/list/list_review.gif" width="5em" />${koker.review_count }</p>
						    </div> 
						    <div class="ui-block-c" style="width:30% !important;">
						    	<p><img src="../../img/list/list_mark.gif" width="5em" />${koker.distance }</p>
						    </div>
						    
						    <div class="ui-block-d" style="width:30% !important;">
						    	<p>
								    <c:if test="${'0' ne koker.ranking}">
							    		<img src="../../img/list/list_rank.gif" width="5em" />${koker.ranking }위
								    </c:if>
						    	</p>
						    </div>
							<div class="list_stats_text"> 
				    			<div style="width:100% !important; margin-top:1.5em; text-shadow:none !important;">
				    				<p>${koker.addr01} ${koker.addr02}</p>
				    			</div>
			    			</div>
							<%-- <div class="ui-grid-a list_stats_text"> 
				   				<div class="ui-block-a" style="width:25% !important;">
				   					<p>전화번호 : </p>
				   				</div>
				    			<div class="ui-block-b" style="width:75% !important;">
				    				<p>${koker.call_tel01}-${koker.call_tel02}-${koker.call_tel03}</p>
				    			</div>
			    			</div> --%>
						</div>
						<div class="list_text_mark">
						    <c:if test="${'0' ne koker.special_no}">
				    			<img src="../../img/list/list_kok.gif" />
						    </c:if>
				    	</div>
				    </div> 
	
				</div>
				</div><!--end swiper-slide -->
				
			</c:forEach>
			</c:if>
				
				<!--end swiper-slide -->
				</div> <!--end swiper-wrapper -->
	 			</div> <!--end swiper-container -->
			</div>
		</div>
		</div>
	</div>  

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
		
		location.href="${pageContext.request.contextPath}/appMain/kokerList.do?"+str;
		
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
		
		location.href="${pageContext.request.contextPath}/appMain/kokerMapList.do?"+str;
	}
	
	function getKoker() {
		
		var str = 'latitude=' + $('#latitude').val()
		+ '&longitude=' + $('#longitude').val()
		+ '&adius=' + $('#adius').val()
		+ '&class_code=' + $('#class_code').val()
		+ '&category=' + $('#category').val()
		+ '&member_no=' + $('#member_no').val();
		
		 $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/appMain/kokerMapMarker.do"
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
		
		if( status == google.maps.GeocoderStatus.OK ) {  
			$("#addrText").html(addrText = results[0].formatted_address);
		} else {
			addrText = '재설정을 눌러주세요.';
		}
	}); 
	
	markersList = kokerList;
	
	getKoker();

	kokerList = new Array();
	markersList = new Array();
	
}


window.onload=function() {
	
	var adius = $("#adius").val();
	$('input:radio[name="radio-choice-h-2"][value="'+adius+'"]').attr('checked', 'checked');
	
	if (adius == '500') {
		$("#adiusText").html('500 m');
	} else if (adius == '1000') {
		$("#adiusText").html('1 Km');
	} else if (adius == '5000') {
		$("#adiusText").html('5 Km');
	} else if (adius == '10000') {
		$("#adiusText").html('10 Km');
	} else if (adius == '20000') {
		$("#adiusText").html('20 Km');
	} 
	
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
	var myIcon = new google.maps.MarkerImage("../img/map/myMaker.gif", null, null, null, new google.maps.Size(20,20));
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
		var myOptions = {
			zoom: 14,
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
		            title:markersList[i].koker_name,
		            icon: setIcon
		          });
			//마커들을 markers 배열안에 넣습니다.
			markers.push(marker); 
		}
		var markerClusterer = new MarkerClusterer(map, markers, {
	          maxZoom: 16,
	          gridSize: 5
		});
	
	}
	 
 }
</script>


</body>
</html>