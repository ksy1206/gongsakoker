<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%  
	String cp = request.getContextPath();
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
	<script src="../js/swiper.min.js"></script>

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
		
		var count = '${count}'; 
		
		if(count <= 5){
			
			$('#display_button').css("display", "none");
			
		}else{
			
			$('#display_button').css("display", "");
			
		}
		
	});
	
	function list_content_plus(number1,number2){
		
		var start = $('#start').val();
		
		start = parseInt(start) + number1;
		$('#start').val(start);
		
		var str= 'start='+start+'&end='+number2;
		
		if('${search_text}' !='' && '${search_text}' != null && '${search_text}' != 'null'){
			str = str+'&search_text=${search_text}' ;
		}
		
		$.ajax({
		       type        : "POST"  
		     , async       : false 
		     , url         : "/community/communityList.do"
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
		    	var count = 0;
		    	
		    	if (data.communityList != null) {
					$.each(data.communityList, function(index, communityList) {
						html+="<div onclick='javascript:community_detail("+ communityList.cm_no +");' style='border:solid 1px #e5e5e5; margin-bottom:.3em; padding:.5em;' >";
						html+="<div class='ui-grid-a' style='border-bottom:solid 1px #e5e5e5; padding-bottom:.3em;'>";
						html+="<div class='ui-block-a' style='width:60% !important;'>";
						if(communityList.logo_name == '' || communityList.logo_name == null ||communityList.logo_name == undefined ||communityList.logo_name == 'null'){
							html+="<p style='margin:0; font-size:11px;'><img src='../img/community/name_icon.png' style='width:1.5em; vertical-align:middle; margin-right:.5em;'>" +communityList.koker_name+"</p>";	
						}else{
							html+="<p style='margin:0; font-size:11px;'><img src='../upload/img/"+communityList.member_id+"/"+communityList.logo_name+"' style='width:1.5em; vertical-align:middle; margin-right:.5em;'>" +communityList.name+"</p>";
						}
						html+="</div>";
						html+="<div class='ui-block-b' style='width:40% !important; padding:0;'>";
						html+="<p style='margin:0; font-size:11px; float:right;'>" +communityList.cm_insert_date+"</p>";
						html+="</div>";
						html+="</div>";
						html+="<p style='font-size:14px;'>"+communityList.cm_content+"</p>";
						html+="<p style='text-align:right; font-size:14px; margin:0;'><img src='../img/community/recommend_icon.png' style='width:1.5em; vertical-align:bottom; margin-right:.5em;' />"+communityList.recommend_count+"<img src='../img/community/reply_icon.png' style='width:1.5em; vertical-align:bottom; margin:0 .5em;' />"+communityList.reply_count +"</p>";
						html+="</div>";						
						count++;
					});
					
					$("#community_plus").append(html).trigger("create");
				}
		    	
		    	if(count != 10){
		    		$('#display_button').css("display", "none");
				}
		    	
		     }
	    });
	
	}
	
	function search_put(){
		var search = $('#search').val();
		$('#search_text').val(search);
		location.href ='/community/community_main.do?start=0&end=5&search_text='+search;
	}
	
	function community_detail(data){
		
		location.href = '/community/communityDetail.do?begin=0&end=5&cm_no='+data+'&member_no='+$("#session_member_no").val()+'&gubun_page=01';
		
	}
	
	function community_insert(){
		
		if($('#community_content').val()=='' || $('#community_content').val() == null){
			$("#popupCheckString").popup("open");
			return;
		}
		var session = $("#session_member_no").val();
		if(session == 'undefined' || session == undefined || session == 'null' || session == '' || session == null){
			$("#popupCheck").popup("open");
			return;
		}else {
			var content = $('#community_content').val();
			$('#cm_content').val(content);
			$('#member_no').val(session);
			document.community_save.action = '/community/communityInsert.do';
			document.community_save.submit();
		}
		
	}
	
	function login_confirm(){
		
		var session = $("#session_member_no").val();
		if(session == 'undefined' || session == undefined || session == 'null' || session == '' || session == null){
			$("#popupCheck").popup("open");
		}else {
			$('#member_no').val(session);
			document.community_save.action = '/community/communityMypage.do';
			document.community_save.submit();
		}
		
	}
	function call_back() {
		location.href = "<%=cp%>/appMain/appMain.do";
	}
	
	function move_notice(){
		location.href="<%=cp%>/community/community_notice.do";
	}
</script>
</head>

<body style="background-color: #fff !important;">
<div data-role="page" class="koker_page" style="background-color:#fff !important;">
		
	<form name="community_save" id="community_save" method="get">
		<input type="hidden" id="cm_content" name="cm_content">
		<input type="hidden" id="member_no" name="member_no">
	</form>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" id="start" name="start" value="-5">
	<input type="hidden" id="search_text" name="search_text">
	
	<div data-role="header" class="search_header" style="border:0 !important;">		
		<div class="back_btn">
			<a href="<%=cp%>/appMain/appMain.do" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1>커뮤니티</h1>
		<div class="ui-btn-right" style="padding-top:.2em;">
			<a href="#" id="reset" data-ajax="false" style="text-decoration:none; color:#21B4D6; margin-right:.5em;">
				<span style="font-size:24px; font-family:'godom';" onclick="javascript:login_confirm()" data-ajax="false">MY</span>
			</a>
			<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false">
				<img src="../img/header/home.png" style="width:2.2em; vertical-align:top;" />
			</a>
		</div>
	</div>
		
	<div style="background-color:#29A9C8; padding:.3em;">
		<div class="ui-grid-a" style="border-radius:15px; padding:.3em; background-color:#fff;">
			<div class="ui-block-a" style="width:90% !important;">
				<input type="text" name="search" id="search" placeholder="검색어를 입력해주세요." /> 
			</div>
			<div class="ui-block-b" style="width:10% !important; padding:.2em 0 0 0;">
				<img src="../img/search/search_icon.gif" onclick="javascript:search_put();" style="width:1.5em;" />
			</div>
		</div>
	</div>

	
	<div data-role="content" class="list_content" style="width: 100%;">
		<div onclick="move_notice()">	
			<div class="swiper-container">
		        <div class="swiper-wrapper">
					<c:forEach items="${list}" var="list">
						<div class="swiper-slide" data-ajax="false">
							<p>${list.c_s_title}</p>
						</div>
					</c:forEach>
		        </div>
		        <div class="swiper-pagination"></div>
		    </div>
	    </div>
	    
		<div style="padding:.3em;">
			<!-- 없으면 뿌려줌 -->
			
			<c:if test="${fn:length(communityList) == 0}">
				<div style='padding-top:2em; text-align:center;'>
		    		<img src='<%=cp%>/img/board/no_search.gif' style='width:40%;'/>
		    		<p style='text-shadow:none; font-weight:normal !important; color:#666; font-size:14px; margin:0;'>검색 결과가 없습니다.</p>
	    		</div>
			</c:if>
			
			<c:forEach items="${communityList}" var="community" varStatus="count">
			
				<div onclick="javascript:community_detail('${community.cm_no}');" style="border:solid 1px #e5e5e5; margin-bottom:.3em; padding:.5em;">
					<div class="ui-grid-a" style="border-bottom:solid 1px #e5e5e5; padding-bottom:.3em;">
						<div class="ui-block-a" style="width:60% !important;">
							<p style="margin:0; font-size:11px;">
								
								<c:if test="${community.logo_name != null && community.logo_name != '' }">
									<img src="../upload/img/${community.member_id}/${community.logo_name}" style="width:1.5em; vertical-align:middle; margin-right:.5em;" />${community.koker_name}
								</c:if>
								<c:if test="${community.logo_name == null || community.logo_name == '' }">
									<img src="<%=cp %>/img/community/name_icon.png" style="width:1.5em; vertical-align:middle; margin-right:.5em;" />${community.koker_name}
								</c:if>
							</p>
						</div>
						<div class="ui-block-b" style="width:40% !important; padding:0;">
							<p style="margin:0; font-size:11px; float:right;">
								${(community.cm_insert_date).substring(0,19)}
							</p>
						</div>
					</div>
					<p style="font-size:14px;">${community.cm_content}</p>
					<p style="text-align:right; font-size:14px; margin:0;">
						<img src="<%=cp %>/img/community/recommend_icon.png" style="width:1.5em; vertical-align:bottom; margin-right:.5em;">${community.recommend_count} 
						<img src="<%=cp %>/img/community/reply_icon.png" style="width:1.5em; vertical-align:bottom; margin:0 .5em;"> ${community.reply_count}
					</p>
				</div>
			</c:forEach>
		
			<div id="community_plus">
			</div>
			
			<div id="display_button" style="padding:.3em 0;background-color: #21ABC7; border-radius:3px;">
				<p onclick ="javascript:list_content_plus(10,10);" style="text-align:center; font-size:14px; margin:0; color:#fff; text-shadow:none !important;"><span style="padding:0 .2em;">∨</span>더보기</p>
			</div>
		</div>
		
	</div>

	<div data-role="footer" data-position="fixed" style="padding:.5em; background-color:#fff;">
		<div class="ui-grid-b">
			<div class="ui-block-a" style="width:12% !important;">
				<img src="<%=cp %>/img/community/name_icon.png" style="width:2em; vertical-align:bottom;" />				
			</div>
			<div class="ui-block-b" style="width:65% !important;">
				<input type="text" id="community_content" name="community_content" placeholder="한 줄을 남겨주세요." style="background-color:#e5e5e5; color:#000; text-shadow:none; font-weight:normal;" maxlength="50">
			</div>
			<div class="ui-block-c" style="width:20% !important; padding:0 0 0 .3em;">
				<p onclick="javascript:community_insert();" style="font-weight:normal; text-shadow:none; font-size:14px; margin:0; text-align:center; color:#fff; background-color:#29A9C8; padding:.5em 0;">글쓰기</p>
			</div>
		</div>
	</div>
	
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	</div>
	
	<div id="popupCheckString" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p style="text-shadow:none !important; font-weight:normal !important;">텍스트를 입력해주세요.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>
	  	</div>    
	</div>
	
</div>

	
</body>
</html>