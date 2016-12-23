<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<link rel="stylesheet" href="../css/touchslide.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">

<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script src="http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerclusterer/1.0.2/src/markerclusterer.js"></script>
<script src="../js/swiper.min.js"></script>
<script type="text/javascript">

var kokerList = new Array();
var kokerListRank = new Array();
var kokerListBook = new Array();
var markersList = new Array();
	
	function setAdius() {
		
		var adius = $(':radio[name="radio-choice-h-2"]:checked').val();
		$("#adius").val(adius);
		
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

	function setChk_code(str) {
		$("#chk_code").val(str);
		reflashMap();
	}
	
	function koker(idMyDiv, class_code){
		for(var i =0; i < 6; i ++) {
			if (idMyDiv == "menudiv" + i) {
				if (document.getElementById("menudiv" + i).style.display == "block" ) {
					document.getElementById("menudiv" + i).style.display = "none"; 
				} else {
					document.getElementById("menudiv" + i).style.display = "block";
				}
			} else {
				document.getElementById("menudiv" + i).style.display = "none";
			}
		}
		$('#class_code').val(class_code);
	}
	
	function setCategory(ctgy) {
		
		$('#category').val(ctgy);
		callList();
		
	}
	
	function chk_lon() {
		
		if ($('#latitude').val() != null && $('#latitude').val() != '') {
			
			return true;
			
		} else {
			$("#addrText").html('새로고침을 눌러주세요.');
			$("#popupGPS").popup("open");
			return false;
			
		}
		
	}
	
	function callList() {
		if (chk_lon()) {
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
	}
	
	function getKoker() {
		if (chk_lon()) {
			var str = 'latitude=' + $('#latitude').val()
			+ '&longitude=' + $('#longitude').val()
			+ '&adius=' + $('#adius').val()
			+ '&member_no=' + $('#member_no').val();
			
			 $.ajax({
			        type        : "POST"  
			      , async       : false 
			      , url         : "/appMain/getKoker.do"
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
					if (data.kokerListRank != null) {
				  		for ( var i = 0; i < data.kokerListRank.length; i++) {
				  			kokerListRank.push(data.kokerListRank[i]);
				  		}
					}
					if (data.kokerListBook != null) {
				  		for ( var i = 0; i < data.kokerListBook.length; i++) {
				  			kokerListBook.push(data.kokerListBook[i]);
				  		}
					}
			  		setMap();
			      }
			      
		    });	
		}
	}

function move_local_board(){
	var session = <%=member_no%>;
// 	if(session == null){
// 		 $("#popupCheck").popup("open");
// 	} else {
// 		 location.href="${pageContext.request.contextPath}/areaBoard/areaBoardMain.do";
// 	}
	location.href="${pageContext.request.contextPath}/areaBoard/areaBoardMain.do";
}
</script>

</head>
<body>
	<input type="hidden" id="latitude" name="latitude" value="" />
	<input type="hidden" id="longitude" name="longitude" value="" />
	<input type="hidden" id="adius" name="adius" value="" />
	<input type="hidden" id="chk_code" name="chk_code" value="" />
	<input type="hidden" id="class_code" name="class_code" value="" />
	<input type="hidden" id="category" name="category" value="" />
	<input type="hidden" id="member_no" name="member_no" value="<%=member_no%>" />
	<input type="hidden" id="address" name="address" value="" />

<div data-role="page" id="main" class="koker_page" style="background-color:#fff;">
 <jsp:include page="../include/myMenu.jsp" flush="true" />

	<div data-role="header" class="main_header">
		<a href="#myPanel" class="ui-btn ui-corner-all" data-ajax="false">
			<img src="../img/header/my_menu.gif" class="header_icon" />
		</a>
		<h1><img src="../img/header/logo.gif" class="header_logo" /></h1>
		<div class="ui-btn-right">
			<a href="../search/search.do" class="ui-btn ui-corner-all" data-ajax="false" id="test"><img src="../img/header/search.gif" class="header_icon" style="padding:0.3em 0.5em 0 0 !important;"/></a>
			<a href="JavaScript:window.location.reload()" class="ui-btn ui-corner-all" data-ajax="false" style="margin: 0 5px 0;"><img src="../img/header/reset.gif" class="header_icon" style="padding:0.3em 0.5em 0 0 !important;"/></a>
		</div>
	</div>

	<div data-role="content" class="main_content">  
		<div class="point_add">
			<h3><div id="addrText"></div></h3>
			<div class="ui-btn-right">
				<a href="#pop_street" data-rel="popup" data-position-to="#pop_position" data-transition="pop">
					<div class="str_pop">
						<p><div id="adiusText">5 Km</div></p>
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
		<div id="pop_position"></div>
		<div id="map-page" class="map_grid">
			<div role="main" class="ui-content map_view" id="map-canvas">
			</div>
		</div>
		<div class="menu_wrap">
			<div class="menu_select">
				<div class="menu_one">
					<a href="#" onclick="koker('menudiv0'); return false;" data-ajax="false">
						<img src="../img/menu/my_icon.gif" style="width:1.2em; vertical-align: middle;"/>
						<span style="font-size:11px; vertical-align: middle;">내주변</span>
					</a>
				</div>
				<div id="menudiv0" class="menu_div">
					<div class="ui-grid-b menu_div_padding">
					    <a href="#" class="ui-block-a" data-ajax="false">
					  	 	<input class='' id='radio01' type='radio' name="chk_code" value="01" checked="checked" onclick="javascript:setChk_code('01');">
   							<label class='' for='radio01'>거리</label>
				    	</a> 
					    <a href="#" class="ui-block-b" data-ajax="false">
					  	 	<input class='' id='radio02' type='radio' name="chk_code" value="02" onclick="javascript:setChk_code('02');">
   							<label class='' for='radio02'>콕콕20</label>
				    	</a> 
					    <a href="#" class="ui-block-c" data-ajax="false">
					  	 	<input class='' id='radio03' type='radio' name="chk_code" value="03" onclick="javascript:setChk_code('03');">
   							<label class='' for='radio03'>나의 콕!</label>
				    	</a> 
					</div>
				</div>
				<div class="menu_four ui-grid-d">	
					    <div class="ui-block-a">
					  	 	<input class='' id='radio11' type='radio' name="chk_info" value="02" onclick="koker('menudiv1', '02'); return false;">
   							<label class='' for='radio11'>자재업체</label>
				    	</div> 
					    <div class="ui-block-b">
					  	 	<input class='' id='radio12' type='radio' name="chk_info" value="05" onclick="koker('menudiv2', '05'); return false;">
   							<label class='' for='radio12'>시공업체</label>
					    </div> 
					    <div class="ui-block-c">
					  	 	<input class='' id='radio13' type='radio' name="chk_info" value="04" onclick="koker('menudiv3', '04'); return false;">
   							<label class='' for='radio13'>장비업체</label>
					    </div> 
					    <div class="ui-block-d">
					  	 	<input class='' id='radio14' type='radio' name="chk_info" value="03" onclick="koker('menudiv4', '03'); return false;">
   							<label class='' for='radio14'>기술자</label>
					    </div> 
					    <div class="ui-block-e">
					  	 	<input class='' id='radio15' type='radio' name="chk_info" value="06" onclick="koker('menudiv5', '06'); return false;">
   							<label class='' for='radio15'>종합</label>
					    </div> 
				</div>
				
				<div id="menudiv1" class="sub_menu">
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('01');">목자재 ㅣ 경량</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('02');">벽지 | 필름</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('10');">바닥재 | 마감자재</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('03');">타일 | 욕실용품</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('11');">페인트 | 방수</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('05');">전기 | 조명</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('08');">가구 | 소품</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('06');">철물 | 공구</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('12');">설비 | 배관</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('04');">금속 | 유리 | 샷시</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('13');">에어컨 | 소방</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('07');">조경 | 화원</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('14');">석재 | 토목자재</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('15');">철근 | 콘크리트</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('09');">기타자재</a>
					</div>
				</div>
				
				<div id="menudiv2" class="sub_menu">
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('01');">인테리어 | 주방</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('02');">목조주택</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('03');">청소 | 철거</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('04');">방수 ㅣ 페인트</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('05');">간판 | 어닝</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('06');">조경 | 석공사</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('10');">금속 | 유리 | 샷시</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('11');">보안 | 에어컨</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('12');">음향 | 전기</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('13');">소방업체</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('07');">전문건설</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('08');">종합건설</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('09');">기타업체</a>
					</div>
				</div>
				
				<div id="menudiv3" class="sub_menu">
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('01');">화물</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('09');">퀵</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('03');">사다리차</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('02');">지게차</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('04');">크레인</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('05');">굴삭기</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('06');">덤프트럭</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('07');">펌프카</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('08');">기타장비</a>
					</div>
				</div>
				
				<div id="menudiv4" class="sub_menu">
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('01');">목공 ㅣ 경량</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('12');">철근 | 비계</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('08');">보통인부</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('09');">기타 기능공</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('02');">도배 | 필름 | 바닥재</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('03');">타일 | 미장 | 조적</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('04');">유리 | 샷시</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('05');">전기 | 설비</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('06');">청소 | 철거</a>
					</div>
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('10');">도장 | 방수</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('07');">조경 | 석공</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('11');">용접 | 금속</a>
					</div>
				</div>
				
				<div id="menudiv5" class="sub_menu">
					<div class="ui-grid-b sub_menu_setting">
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-a" data-ajax="false" onclick="javascript:setCategory('01');">설계 | 감리</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-b" data-ajax="false" onclick="javascript:setCategory('02');">안전관리</a>
						<a href="#" data-rel="page" data-transition="slideup" class="ui-block-c" data-ajax="false" onclick="javascript:setCategory('03');">이사</a>
					</div>

				</div>
				
			</div>
		</div>
		<div class="img_menu">
			<div class="ui-grid-c">
				<a onclick="move_local_board()" class="ui-block-a img_menu_img" data-ajax="false"><img src="../img/menu/area.png" /></a>
				<a href="<%=cp%>/kokkok20/kokkok20list.do" class="ui-block-b img_menu_img" data-ajax="false"><img src="../img/menu/kok20.png" /></a>
				<a href="#" class="ui-block-c img_menu_img" data-ajax="false"><img src="../img/menu/auction.png" /></a>
				<a href="#" class="ui-block-d img_menu_img" data-ajax="false"><img src="../img/menu/working.png" /></a>
			</div>
		</div>
	</div>
	
		<div data-role="footer" class="main_footer">  
			<div class="touch-slider">
			    <div class="swiper-container">
			      <div class="swiper-wrapper">
			        <div class="swiper-slide"><a href="<%=cp%>/event/event_movePage.do?event_no=23"><img src="../img/banner/mainBanner1.png" width="100%"></a></div>
			        <div class="swiper-slide"><a href="<%=cp%>/web/gongsakoker.do" data-ajax="false"><img src="../img/banner/mainBanner2.png" width="100%"></a></div>
			      </div>
			    </div>
			    <div class="pagination"></div>
			</div>
			  <script src="https://dl.dropboxusercontent.com/u/913021/touch-slider/idangerous.swiper-2.0.min.js"></script>
		</div>
		
		<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    	<div class="ui-content" role="main">
				<p>로그인이 필요한 서비스입니다.</p>
	      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  		</div>    
	 	</div>	
		
		<div id="popupGPS" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    	<div class="ui-content" role="main">
				<p>GPS가 설정되지 않았습니다.</p>
	      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  		</div>    
	 	</div>	
</div>	
<script type="text/javascript">

	var mySwiper = new Swiper('.swiper-container',{
	    pagination: '.pagination',
	    loop:true,
	    grabCursor: true,
	    paginationClickable: true,
	    autoplay:5000,
	    speed:500
	  })

	$(document).on("pagecreate","#main",function(){
	  $("img").on("swipeleft",function(){
	  });                       
	});
	$(document).on("pagecreate","#main",function(){
	  $("img").on("swiperight",function(){
	  });                       
	});
	
</script>

<script type="text/javascript">
/* 
 * 김기윤
 * 내 위치 위도, 경도 호출 및 맵 새로 고침
 */

function getLocation() {
	$("#addrText").html('GPS 설정이 필요합니다.');
	//안드로이드 호출
	var useragent = navigator.userAgent;
	if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
		window.android.reflashGPS("GPS");
    }
    else {
	//웹호출
		receiveLocation('37.347280$126.745569');
    }
}

function receiveLocation(location) {
	
	var array_data = location.split("$");  // 위도 경도 문자열로 잘라 배열넣기
	
	//히든에 위도 경도 저장하기
	$("#latitude").val(array_data[0]);
	$("#longitude").val(array_data[1]);
	
	//위도 경도로 내 위치 근처 업체 가져오기
	reflashMap();
	
}

function reflashMap() {

	var latlng = new google.maps.LatLng($("#latitude").val(), $("#longitude").val());
	var geocoder = new google.maps.Geocoder(); 
	
	geocoder.geocode({'location': latlng}, function(results, status) {
		
		if( status == google.maps.GeocoderStatus.OK ) {
			addrText = results[0].formatted_address.split('대한민국 ');
			//addrText = results[0].formatted_address;
			$("#address").val(addrText);
		} else {
			addrText = '새로고침을 눌러주세요.';
		}
		$("#addrText").html(addrText);
	}); 

	var chk_code = $("#chk_code").val();
	
	if (chk_code == '01') {
		markersList = kokerList;
	} else if (chk_code == '02') {
		markersList	= kokerListRank;
	} else if (chk_code == '03') {
		markersList	= kokerListBook;
	}
	getKoker();

	kokerList = new Array();
	kokerListRank = new Array();
	kokerListBook = new Array();
	markersList = new Array();
	
}


window.onload=function() {
	$("#adius").val($(':radio[name="radio-choice-h-2"]:checked').val());
	$("#chk_code").val($(':radio[name="chk_code"]:checked').val());
	getLocation();
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
var infoWindows = new Array();

function setMap() {
	 
	var latitude = $("#latitude").val();
	var longitude = $("#longitude").val();
	var markers = new Array();
	var map;
	//var myIcon = new google.maps.MarkerImage("../img/map/myMaker1.gif", null, null, null, new google.maps.Size(20,20));
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
		var adius = $(':radio[name="radio-choice-h-2"]:checked').val();
		var zoomSize = 0;
		if (adius == '500') {
			zoomSize = 15;
		} else if (adius == '1000') {
			zoomSize = 14;
		} else if (adius == '5000') {
			zoomSize = 12;
		} else if (adius == '10000') {
			zoomSize = 11;
		} else if (adius == '20000') {
			zoomSize = 10;
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
	
	var contentString = [];
	
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
			
			/* google.maps.event.addListener(marker, 'click', (function(marker, i) {
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
			})(marker, i)); */
			
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