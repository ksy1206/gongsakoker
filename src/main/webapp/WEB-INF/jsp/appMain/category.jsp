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
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
	<link rel="stylesheet" href="../css/koker_mobile.css">
	<link rel="stylesheet" href="../css/swiper.min.css">
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
	<script src="../js/swiper.min.js"></script>
</head>
<script type="text/javascript">
	/* 슬라이드  옵션 */
	$(document).ready(function(){
		var swiper = new Swiper('.swiper-container', {
			pagination: '.swiper-pagination',
			paginationClickable: true,
			centeredSlides: true,
			autoplay: 3000,
			autoplayDisableOnInteraction: false,
			loop: true,
		});
		
		$('#latitude').val('${latitude}');
		$('#longitude').val('${longitude}');
		$('#adius').val('${adius}');
		$('#member_no').val('${member_no}');
		$('#chk_code').val('${chk_code}')
		$('#class_code').val('${class_code}');
		$('#address').val('${address}');
		var class_code = $('#class_code').val();
		
		
		class_code_view(class_code);	
		
	});
	
	function class_code_view(class_code){
		
		var str = 'latitude=' + $('#latitude').val()
		+ '&longitude=' + $('#longitude').val()
		+ '&adius=' + $('#adius').val()
		+ '&member_no=' + $('#member_no').val()
		+ '&chk_code=' + $('#chk_code').val()
		+ '&class_code=' + class_code
		+ '&address=' + $('#address').val();
		
		$('#class_code').val(class_code);
		
		$.ajax({
		       type        : "POST"  
		     , async       : false 
		     , url         : "/appMain/mainCategoryList.do"
		     , data        : str
		     , dataType    : "json" 
		     , timeout     : 30000   
		     , cache       : false     
		     , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		     , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		     }
		     , success     : function(data) {
		    	
		    	var html = "";
		    	var subject= "";
		    	var division = "";
		    	
		    	if(class_code == '02'){
		    		division += "<p class='ui-block-a' style='width:19%;' onclick=javascript:class_code_view('03')>기술자</p>";
					division += "<p class='ui-block-b' style='width:19%;' onclick=javascript:class_code_view('04')>장비업체</p>";
					division += "<p class='ui-block-c' style='width:19%;' onclick=javascript:class_code_view('05')>시공업체</p>";
					division += "<p class='ui-block-d' style='width:19%;' onclick=javascript:class_code_view('06')>종합</p>";
					division += "<p class='ui-block-e' style='width:19%;' onclick=javascript:class_code_view('07')>운송</p>";
		    	}else if(class_code == '03'){
		    		division += "<p class='ui-block-a' style='width:19%;' onclick=javascript:class_code_view('02')>자재업체</p>";
					division += "<p class='ui-block-b' style='width:19%;' onclick=javascript:class_code_view('04')>장비업체</p>";
					division += "<p class='ui-block-c' style='width:19%;' onclick=javascript:class_code_view('05')>시공업체</p>";
					division += "<p class='ui-block-d' style='width:19%;' onclick=javascript:class_code_view('06')>종합</p>";
					division += "<p class='ui-block-e' style='width:19%;' onclick=javascript:class_code_view('07')>운송</p>";
		    	}else if(class_code == '04'){
		    		division += "<p class='ui-block-a' style='width:19%;' onclick=javascript:class_code_view('02')>자재업체</p>";
					division += "<p class='ui-block-b' style='width:19%;' onclick=javascript:class_code_view('03')>기술자</p>";
					division += "<p class='ui-block-c' style='width:19%;' onclick=javascript:class_code_view('05')>시공업체</p>";
					division += "<p class='ui-block-d' style='width:19%;' onclick=javascript:class_code_view('06')>종합</p>";
					division += "<p class='ui-block-e' style='width:19%;' onclick=javascript:class_code_view('07')>운송</p>";
		    	}else if(class_code == '05'){
		    		division += "<p class='ui-block-a' style='width:19%;' onclick=javascript:class_code_view('02')>자재업체</p>";
					division += "<p class='ui-block-b' style='width:19%;' onclick=javascript:class_code_view('03')>기술자</p>";
					division += "<p class='ui-block-c' style='width:19%;' onclick=javascript:class_code_view('04')>장비업체</p>";
					division += "<p class='ui-block-d' style='width:19%;' onclick=javascript:class_code_view('06')>종합</p>";
					division += "<p class='ui-block-e' style='width:19%;' onclick=javascript:class_code_view('07')>운송</p>";
		    	}else if(class_code == '06'){
		    		division += "<p class='ui-block-a' style='width:19%;' onclick=javascript:class_code_view('02')>자재업체</p>";
					division += "<p class='ui-block-b' style='width:19%;' onclick=javascript:class_code_view('03')>기술자</p>";
					division += "<p class='ui-block-c' style='width:19%;' onclick=javascript:class_code_view('04')>장비업체</p>";
					division += "<p class='ui-block-d' style='width:19%;' onclick=javascript:class_code_view('05')>시공업체</p>";
					division += "<p class='ui-block-e' style='width:19%;' onclick=javascript:class_code_view('07')>운송</p>";
		    	}else if(class_code == '07'){
		    		division += "<p class='ui-block-a' style='width:19%;' onclick=javascript:class_code_view('02')>자재업체</p>";
					division += "<p class='ui-block-b' style='width:19%;' onclick=javascript:class_code_view('03')>기술자</p>";
					division += "<p class='ui-block-c' style='width:19%;' onclick=javascript:class_code_view('04')>장비업체</p>";
					division += "<p class='ui-block-d' style='width:19%;' onclick=javascript:class_code_view('05')>시공업체</p>";
					division += "<p class='ui-block-e' style='width:19%;' onclick=javascript:class_code_view('06')>종합</p>";
		    	}
		    	
		    	if (data.categoryList != null) {
					html+="<fieldset data-role='controlgroup' data-type='horizontal' class='choice_set'>"
					$.each(data.categoryList, function(index, categoryList) {
						html+="<input type='checkbox' name='choice' id='choice-"+(index+1)+"' value='"+categoryList.category+"' /><label for='choice-"+(index+1)+"'>"+categoryList.code_name+"</label>";
						
						if(categoryList.class_code == 02){
							subject = "자재업체";
						}else if(categoryList.class_code == 03){
							subject = "기술자";
						}else if(categoryList.class_code == 04){
							subject = "장비업체";
						}else if(categoryList.class_code == 05){
							subject = "시공업체";
						}else if(categoryList.class_code == 06){
							subject = "종합";
						}else if(categoryList.class_code == 07){
							subject = "운송";
						}
						
					});
					html+="</fieldset>";
					
					$("#categoryName").html(subject).trigger("create");
					$("#categoryListMap").html(html).trigger("create");
					$("#division").html(division).trigger("create");
				}
		     }
	    });
	}
	
	function caCheck(){
		var text = "";
		
		$("input[name='choice']:checked").each(function() {
			text += 'ca'+$(this).val()+",";
		});
		if(text==""){
			$("#popupChoose").popup("open");
			return;
		}
		$("#category").val(text);
		
		document.aroundForm.action ="kokerListPage.do";
		document.aroundForm.submit();
	}
	function mapList(){
		var text = "";
		$("input[name='choice']:checked").each(function() {
			text += 'ca'+$(this).val()+",";
		});
		
		$("#category").val(text);
		document.aroundForm.action ="mapList.do";
		document.aroundForm.submit();
	}

</script>
<body>
	
	<form method="get" name="aroundForm" id="aroundForm">
		<input type="hidden" id="latitude" name="latitude" value="" />
		<input type="hidden" id="longitude" name="longitude" value="" />
		<input type="hidden" id="adius" name="adius" value="" />
		<input type="hidden" id="chk_code" name="chk_code" value="" />
		<input type="hidden" id="class_code" name="class_code" value="" />
		<input type="hidden" id="category" name="category" value="" />
		<input type="hidden" id="address" name="address" value="" />
		<input type="hidden" id="member_no" name="member_no" value="<%=member_no%>" />
	</form>
<div id="category_page" data-role="page" style="font-family:'GodoM'; background-color: #fff !important;">
 <jsp:include page="../include/myMenu.jsp" flush="true" />
	<div data-role="header" class="search_header" style="border:0 !important; background-color:#fff !important;">		
		<div>
			<a href="#myPanel" class="relback_btn" data-ajax="false">
				<img src="../img/header/my_menu_me.png" />
			</a>
		</div>
		<h1 style="text-align:center; background-color:#fff !important; padding:0;">
			<img src="../img/header/logo_me.png" style="width:6.5em;" />
		</h1>
		<div class="ui-btn-right" style="padding-top:.2em;">
			<a href="../search/search.do" style="text-decoration:none; color:#21B4D6; margin-right:.5em;" data-ajax="false" id="test">
				<img src="../img/header/search_me.png" class="header_icon" style="width:2.2em; vertical-align:top;" />
			</a>
			<a href="appMain.do" data-ajax="false">
				<img src="../img/header/home.png" class="header_icon" style="width:2.2em; vertical-align:top;" />
			</a>
		</div>
	</div>
    <div class="content" data-role="content" style="padding:0 !important;">
    	<div style="padding: 0 .5em; height:45px; line-height:43px; background-color:#e5e5e5;">
    		<span style="font-size:12px; color:#666; text-shadow:none !important; margin-right:.3em;">카테고리></span>
    		<a href="#" class="category_btn" id="categoryName">로딩중...</a>
    		<c:if test="${class_code != '03'}">
	    		<a href="#" style="color:#666; text-decoration:none; padding:.5em 1em; border:solid 2px #29A9C8; border-radius:15px; font-size:12px; line-height:24px; float:right; background-color:#fff; margin-top: .2em; font-weight:normal !important; text-shadow:none !important;" onclick="javascript:mapList();">내주변
	    			<img src="../img/main/area_me.png" style="width:1.3em; vertical-align:middle;" />
	   			</a>
   			</c:if>
    	</div>
		<div class="category_tab_wrap" style="display:none;">
    		<p>원하시는 업체를 선택해주세요.</p>
    		<div class="ui-grid-d category_tab" id="division"></div>
		</div>
    	<p style="font-size:12px; color:#666; text-align:center; margin: 1em 0 .7em 0;">원하시는 카테고리를 선택해주세요.</p>
    	<form id="categoryListMap" name="categoryListMap">
	        
		</form>
    </div>
	<div data-role="footer" data-position="fixed" style="border: none; background: none !important;">
		<div style="padding:.5em; text-align:center;" onclick="javascript:caCheck();">
    		<h1 style="font-weight:normal !important; font-size:14px; text-shadow:none !important; color:#fff; background-color:#29A9C8; margin:0 !important; padding:1em 0;">검색하기</h1>
    	</div>
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
		        <div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=18&backCount=1'" class="swiper-slide" data-ajax="false"><img src="../img/banner/mainbanner_daseong.png" width="100%"></div>
		        <div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=8128&backCount=1'" class="swiper-slide"><img src="../img/banner/mainbanner_road_3.png" width="100%"></div>
		        <div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=167&backCount=1'" class="swiper-slide" data-ajax="false"><img src="../img/banner/mainbanner_point.png" width="100%"></div>
		        <div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=7847&backCount=1'" class="swiper-slide"><img src="../img/banner/mainbanner_kang.png" width="100%"></div>
	        </div>
	        <div class="swiper-pagination"></div>
	    </div>  
   	</div>
   	<div id="popupChoose" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="addrText">분야를 1개 이상 선택해 주세요</p>
      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>
  		</div>    
 	</div>
</div> 	

<script type="text/javascript">

$(".category_btn").click(function() {
  status = $(".category_tab_wrap").css("display");
  if (status == "none") {
    $(".category_tab_wrap").css("display","");
  }
  else {
    $(".category_tab_wrap").css("display","none");
  }
});

</script>

</body>
</html>