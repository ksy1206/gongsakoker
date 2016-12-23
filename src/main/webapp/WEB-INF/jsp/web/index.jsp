<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<meta name="naver-site-verification" content="0303fa6dc164cf2e98eff4b2547d3c8876f7023f"/>
<meta name="description" content="위치기반 O2O IT 융합서비스 공사콕커, 인테리어 기술자와 업체를 한눈에!">
<!--[if IE 8]>
	<link rel="stylesheet" href="./common/TabMenuSelectTransform.css" />
<![endif]-->
<!--[if IE 9]>
<style>
	.swiper-button-prev, .swiper-button-next{display:none;}
</style>
<![endif]-->
<link rel="stylesheet" href="../css/layout.css" />
<link rel="stylesheet" href="../css/main.css" />
<link rel="stylesheet" href="../css/swiper.min.css">
<title>공사 KOKER</title>
<script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="../js/cookie_pop.js"></script>
<script type="text/javascript">
// //star rating
// var starRating = function(){
//   var $star = $(".star-input"),
//       $result = $star.find("output>b");
//   $(document)
//     .on("focusin", ".star-input>.input", function(){
//     $(this).addClass("focus");
//   })
//     .on("focusout", ".star-input>.input", function(){
//     var $this = $(this);
//     setTimeout(function(){
//       if($this.find(":focus").length === 0){
//         $this.removeClass("focus");
//       }
//     }, 100);
//   })
//     .on("change", ".star-input :radio", function(){
//     $result.text($(this).next().text());
//   })
//     .on("mouseover", ".star-input label", function(){
//     $result.text($(this).text());
//   })
//     .on("mouseleave", ".star-input>.input", function(){
//     var $checked = $star.find(":checked");
//     if($checked.length === 0){
//       $result.text("0");
//     } else {
//       $result.text($checked.next().text());
//     }
//   });
// };
// // starRating();
</script>



</head>
<body style="background-color:#ebebeb;"> 


	

<jsp:include page="../web/include/main_header.jsp"/>

    <input type="hidden" name="chk_noView" id="chk_noView">
    <iframe id="hfrADCheck" src="//adcheck.about.co.kr/mad/prd/view?shopid=sweetco" scrolling="no" frameborder="0" width="0" height="0"  style="display: none;"></iframe> 
	<div class="board_top_banner"  style="background-color:#ebebeb;">
		<img src="<%=cp%>/img/web/main_banner_img.png">
	</div>

		<!-- <div class="slogan_wrap">
			<div class="slogan">
				<div class="slogan_img">
					<img src="../img/small_phone.png" />
				</div>
				<div class="slogan_text">
					<p style="margin-top:1.3em;">휴대폰 번호를 입력하시면 공사콕커 app을 편하게 다운받으실 수 있도록 문자를 보내드립니다.</p>
					<p>(입력하신 휴대폰 번호는 문자 발송시만 사용됩니다.)</p>
				</div>
				<div class="slogan_btn">
					<a href="https://play.google.com/store/apps/details?id=com.gonggan.koker">다운로드</a>
				</div>
			</div>
		</div> -->
    <div class="main_container" >
	  <div class="content">
	  <div class="bottom_banner">
			<div class="banner_service">
				<h4>서비스 소개</h4>
				<a href="#service_intro"><img src="<%=cp%>/img/web/service_img.png" style="width:100%;border:1px solid #969696;"></a>
			</div>
			<div class="banner_media">
				<h4>미디어</h4>
				<a href="blob:https%3A//www.youtube.com/1a57bbe3-26b0-4e11-b328-658f42c3c5c1https://youtu.be/hnmiV8u76kc" target="_blank">
				<img src="<%=cp %>/img/web/main/koker_CF.png" style="width:100%;border:1px solid #969696;"></a>
			</div>
			<div class="banner_top">
				<a href="#"><img src="<%=cp %>/img/web/search_banner.png"></a>
			</div>
    	</div>
	  <div class="intro_content">
		
		<div class="introduce">
			<h1>국내 최초 내 위치기반 서비스 '공사콕커'</h1>
			<p>공사콕커는 2차 업데이트를 통해 더욱 쉽고 편리한 사용자 인터페이스와</p>
			<p>전문적이고 다양한 카테고리를 추가함으로써 필요한 서비스를 마음껏 누리실 수 있도록 준비하였습니다.</p>
			<h3>쉽고 빠르게 편리하게, "공사콕커"를 이용해 보세요!</h3>
		</div>
		<div class="main_content_intro">
			<div class="click_btn" id="click_event">
				<a href="#click_event">
					<img src="../img/going_btn.png" />
				</a>
			</div>
			<div class="main_content_icon" id="service_intro">
				<div class="service01">
					<img src="../img/icon_01.png" />
					<p>업체 및 기술자들은</p>
					<p>공사콕커를 통해 <span>홍보</span>가 가능해요!</p>
				</div>
				
				<div class="service02">
					<img src="../img/icon_02.png" />
					<p>기술자의 작업 가능 <span>상태</span>를</p>
					<p>쉽게 파악할 수 있어요!</p>
				</div>
				
				<div class="service03">
					<img src="../img/icon_03.png" />
					<p>통화하기 곤란하시다면</p>
					<p><span>메세지</span>를 보내세요!</p>
				</div>
				
				<div class="service04">
					<img src="../img/icon_04.png" />
					<p>"소재가 궁금해요. 그래서 얼마에요?"</p>
					<p>모든 궁금증을 <span>질문</span>해주세요!</p>
				</div>
			</div>
		</div>
	  </div>
	  <div class="banner">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide" style="background-image:url('../img/sub_back_01.png');">
					<p>
						<img src="../img/service_img01.png" />
					</p>
				</div>
				<div class="swiper-slide" style="background-image:url('../img/sub_back_02.png');">
					<img src="../img/service_img02.png" />
				</div>
				
				<div class="swiper-slide" style="background-image:url('../img/sub_back_02.png');">
					<img src="../img/service_img04.png" />
				</div>
			</div>
			<!-- Add Pagination -->
			<div class="swiper-pagination"></div>
			<!-- Add Arrows -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
      </div>
	  
	  
	  
	  
	  
	  
	  	<%-- <h3 style="text-align:left;width: 100%;margin:5% 0 2% 0;">콕커 추천</h3>
	  	
	  	<!-- 추천 리스트 첫번째 줄 -->
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
				  			
			  				<span class="star-input">
							  <span class="input">
							    <input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
							    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
							    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
							    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
							    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
							    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
							    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" checked="checked"><label for="p7">7</label>
							    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
							    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
							    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
							  </span>
							</span>
							
			  				<span class="main_ranking" >콕콕! 1위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">주식회사 한진 종합건설</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">제주특별자치도 제주시 구좌읍 하도리</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span>가가가가가가가가</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 3</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking"  style="background-color:#F1D100;color:#000;font-weight:bold;">대기중</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">류준열</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">인테리어는 여기가 짱!</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">대성우드</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
			<!-- 추천 리스트 두번째 줄 -->
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 1위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">주식회사 한진 종합건설</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">제주특별자치도 제주시 구좌읍 하도리</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span>가가가가가가가가</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 3</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" style="background-color:#969696;color:#fff;font-weight:bold;">작업중</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">류준열</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">인테리어는 여기가 짱!</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">대성우드</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>  
	  		<!-- 추천 리스트 세번째 줄 -->
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 1위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">주식회사 한진 종합건설</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">제주특별자치도 제주시 구좌읍 하도리</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span>가가가가가가가가</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 3</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking"  style="background-color:#F1D100;color:#000;font-weight:bold;">대기중</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">류준열</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">인테리어는 여기가 짱!</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">대성우드</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!-- 추천 리스트 네번째 줄 -->
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 1위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">주식회사 한진 종합건설</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">제주특별자치도 제주시 구좌읍 하도리</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span>가가가가가가가가</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 3</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking"  style="background-color:#969696;color:#fff;font-weight:bold;">작업중</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">류준열</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">인테리어는 여기가 짱!</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div>
		  	<!------------------------------------------------------------------------------------------------>
		  	<div class="koker_recommend" style="background-color:#fff;">
		  		<div  class="koker_recommend_top">
		  				<span class="main_star">
				  			<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;margin-top:5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<img src="<%=cp %>/img/web/main/star_01.png" style="width:20px;margin-right:-5px;">
			  				<span class="main_ranking" >콕콕! 2위</span>
			  			</span>
		  				<a href="#" style="color:#000;"><h4 style="margin:5% 0 2% 0;">대성우드</h4></a>
		  				<p style="font-size:9pt;margin-bottom:2%;">경기도 시흥시 정왕동</p>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span>
		  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;"> 222</span>
		  		</div>
		  		<div class="koker_recommend_middle" style="width:100%;height:100px;">
		  			<img src="<%=cp %>/img/web/main/list_img.PNG"  style="width:99%;height:100px;margin:5px .5%;">
		  		</div>
		  		<div class="koker_recommend_bottom" style="width:100%;margin-top:19px;font-size:9pt;">
		  			<span style="margin-left:0.5%;">인테리어</span>
		  			<span>주방|가구</span>
		  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 0</span>
		  		</div>
		  	</div> --%>
	  
	  	
    	<div class="banner_last">
    		<a href="http://newhk.firstmall.kr/main/index" target="_blank"><img src="<%=cp %>/img/web/newhomekok_footer.jpg"></a>
    	</div>
	</div>
</div>
	
	<div class="footer_wrap">
		<jsp:include page="../web/include/footer.jsp"/>
	</div>
 
    <script src="../js/swiper.min.js"></script>

    <script>
		var swiper = new Swiper('.swiper-container', {
			pagination: '.swiper-pagination',
			paginationClickable: true,
			centeredSlides: true,
			autoplay: 3000,
			autoplayDisableOnInteraction: false,
			loop: true,
			nextButton: '.swiper-button-next',
			prevButton: '.swiper-button-prev'
		});
    </script>
    
    <script>
    /* 
     * 쿠키값이 있을때 true, 없을때 false 를 리턴한다.
     * chk_noView 값이 1이면 더이상 보지않기, 0이면 계속 팝업을 띄운다.
     */
    window.onload=function() {
    	 if(!popView()) {
    		
    		var popUrl = "/mainPopup.jsp";	//팝업창에 출력될 페이지 URL
    		var popOption = "width=400px, height=430px, resizable=no, scrollbars=no, status=no, location=no, left=100, top=200";    //팝업창 옵션(optoin)
    			window.open(popUrl,"popup",popOption);
    	} else {
    		//초기화
    		//noView('0');
    	} 
    }
    
    function set_noView(str) {
    	$('#chk_noView').val(str);
    }
    
    function chk_noView() {
    	var days = '1'; //보이지 않게 할 날짜.
    	if ($('#chk_noView').val() == '1') {
    		noView(days);
    	}
    }
    </script>
  </body>
</html>