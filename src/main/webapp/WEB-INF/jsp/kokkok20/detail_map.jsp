<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<%@page import="gongsakoker.vo.MemberVO"%>

<% String check_zzim="no"; %>

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
</head>

<body>
			
    <c:if test="${not empty koker}">

	<input type="hidden" id="latitude" name="latitude" value="${koker.latitude }" />
	<input type="hidden" id="longitude" name="longitude" value="${koker.longitude }" />
	<input type="hidden" id="class_code" name="class_code" value="${koker.class_code }" />
	<input type="hidden" id="category" name="category" value="${koker.category }" />
	<input type="hidden" id="koker_name" name="koker_name" value="${koker.koker_name }" />
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">

	<div data-role="page" id="main" class="koker_page list_page">
		<div data-role="header" class="list_header" data-position="fixed" style="top:0 !important; right:0 !important;">
			<div class="back_btn">
				<a href="#" data-ajax="false" class="relback_btn" data-rel="back"><img src="../img/relback.gif"/></a>
			</div>
			<h1>${koker.koker_name }</h1>
			<div class="ui-btn-right">
				
			</div>
		</div>
		
		<div id="map-page" class="list_map_grid list_map_grid_sub" style="padding-bottom:180%;">
			<div role="main" class="ui-content list_map_view" id="map-canvas">
			</div>
			<div data-role="content" class="list_map_content" style="position:fixed; bottom:0; left:0; padding-bottom:.3em !important;">
			
			<div class="list_map_wrap">
			<div class="swiper-container">
			<div class="swiper-wrapper">
			
			   <div class="swiper-slide">
				<div class="ui-grid-a"> 
				    <div class="ui-block-a list_stats_img">
				    	<img src="../../img/list/list_bg.jpg" />
				    </div> 
				    
				    <div class="ui-block-b list_stats_group" style="padding:.3em 0 0 .5em !important;">
				    	<h6 style="text-align:left;">${koker.koker_name }
						    <c:if test="${'03' eq koker.class_code}">
							    <c:if test="${'1' eq koker.state}">
							    	<img src="../../img/list/list_wait.gif" />
							    </c:if>
							    <c:if test="${'0' eq koker.state}">
							    	<img src="../../img/list/list_zzim_off.png" />	
							    </c:if>
						    </c:if>
				    	</h6>
				    	<div class="ui-grid-c list_stats"> 
						    <div class="ui-block-a" style="width:20% !important;">
						    	<p><img src="../../img/list/list_star.gif" width="5em" />${koker.review_avg }</p>
						    </div> 
						    <div class="ui-block-b" style="width:20% !important;">
						    	<p><img src="../../img/list/list_review.gif" width="5em" />${koker.review_count }</p>
						    </div>
						    <div class="ui-block-c" style="width:30% !important;">
						    	<p>
								    <c:if test="${not empty koker.ranking}">
							    		<img src="../../img/list/list_rank.gif" width="5em" />${koker.ranking }위
								    </c:if>
							    </p>
						    </div>
						    <div class="ui-block-d" style="width:30% !important;">
						    	<p>
						    	</p>
						    </div>
						    
							<div class="list_stats_text" style="height: 58px !important; text-align:left; margin: 0 !important;"> 
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
				
				<!--end swiper-slide -->
				</div> <!--end swiper-wrapper -->
	 			</div> <!--end swiper-container -->
			</div>
		</div>
		</div>
	</div>  
				
	</c:if>

<script type="text/javascript">
/* 
 * 김기윤
 * 내 위치 위도, 경도 호출 및 맵 새로 고침
 */

window.onload=function() {
	setMap();
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
 
var latitude = $("#latitude").val();
var longitude = $("#longitude").val();
var class_code = $("#class_code").val();
var koker_name = $("#koker_name").val();
	
function setMap() {
	var markers = new Array();
	var map;
	var myIcon = new google.maps.MarkerImage("../img/map/myMaker.gif", null, null, null, new google.maps.Size(20,20));
	var icon02 = new google.maps.MarkerImage("../img/map/icon02.png", null, null, null, new google.maps.Size(18,25));
	var icon04 = new google.maps.MarkerImage("../img/map/icon04.png", null, null, null, new google.maps.Size(18,25));
	var icon05 = new google.maps.MarkerImage("../img/map/icon05.png", null, null, null, new google.maps.Size(18,25));
	var icon06 = new google.maps.MarkerImage("../img/map/icon06.png", null, null, null, new google.maps.Size(18,25));
	var setIcon;
	
	var defaultLatLng = new google.maps.LatLng(latitude, longitude);  // Default to Hollywood, CA when no geolocation support
	drawMap(defaultLatLng);
	
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
		    disableDefaultUI: true,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map-canvas"), myOptions);
		// Add an overlay to the map of current lat/lng
		if (class_code == '02') {
			setIcon = icon02;	
		} else if (class_code == '04') {
			setIcon = icon04;	
		} else if (class_code == '05') {
			setIcon = icon05;	
		} else if (class_code == '06') {
			setIcon = icon06;	
		}
		var marker = new google.maps.Marker({
			position: latlng,
			title: koker_name,
			map: map,
			icon: setIcon
		});
	}
 }
</script>


</body>
</html>