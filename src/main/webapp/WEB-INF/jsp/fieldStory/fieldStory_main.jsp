<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<link rel="stylesheet" href="../css/swiper.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script
	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
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
		
		//리스트 검색
		var sido = $("#sido").val();
		var gugun = $("#gugun").val();
		var list_select = $("#list_select").val();
		getZip_area();
		if(gugun != "default"){
			getZip_city();
		}
		search();	
	});
	
	function reset_search(){
		//페이지 리로드
		location.reload();
		
		//value 값 초기화
// 		$("#sido").val("default");
// 		$("#gugun").val("default");
// 		$("#list_select").val("new");		
		
		//라디오 버튼 초기화
// 		$('#radio_new').attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-on");
// 		$('#radio_comment').attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
// 		$('#radio_recomment').attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
		
		//시도 구군 초기화
// 		document.getElementById("areaList-button").innerHTML = "<span>시 / 도를 선택해주세요.</span>"
// 		document.getElementById("cityList-button").innerHTML = "<span>구 / 군를 선택해주세요.</span>"
// 		getZip_area();
		
// 		var sido = $("#sido").val();
// 		var gugun = $("#gugun").val();
// 		var list_select = $("#list_select").val();
// 		params = "sido="+sido+"&gugun="+gugun+"&list_select="+list_select;
	}

	function getZip_area(){
	    $.ajax({
	           type        : "POST"
	         , async       : false
	         , url         : "/member/getZip_area.do"
	         , dataType    : "json"
	         , timeout     : 30000
	         , cache       : false
	         , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	         , error       : function(request, status, error) {
	          	$( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
	          	$( "#popupDialog").popup( "open");
	         }
	         , success     : function(data) {
	        	 var sido = $("#sido").val();
	        	 if(data.areaList!= null && data.areaList.length != 0){
				     if(sido == "default"){
				    	 var html = "<option value='default' >시 / 도를 선택해주세요.</option>";
				     } else {
				    	 var html = "<option value='"+sido+"' >"+sido+"</option>";
				     }
	        		 
				     $.each(data.areaList, function (index, areaList) {                          
				         if(areaList.sido == sido){
				        	  
				         } else {
				        	 html+= "<option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
				         }
				     });
				     $( "#areaList").html(html);
				} else{}
	         }
	  });	
	}
	
	function default_gugun(){
		var gugun = $( "#cityList option:selected").val();
		$("#gugun").val(gugun);
	}
	
	function getZip_city(){		
		var sido = $( "#areaList option:selected").val();
    	$("#sido").val(sido);
	    $.ajax({
	           type        : "POST" 
	         , async       : false
	         , url         : "/member/getZip_city.do"
	         , data        : "sido=" + sido
	         , dataType    : "json"
	         , timeout     : 30000  
	         , cache       : false    
	         , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	         , error       : function(request, status, error) {
	          $( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
	                   $( "#popupDialog").popup( "open");
	                   
	         }
	         , success     : function(data) {   
	        	 var gugun = $("#gugun").val();
                 if(data.cityList!= null && data.cityList.length != 0){
                	 if(gugun != "default"){
                		 var html = "<option value='"+gugun+"'  id='default_option'>"+gugun+"</option>";
                	 } else {
                		 var html = "<option value='default'  id='default_option'>구 / 군을 선택해주세요.</option>";
                	 }
                      
                     $.each(data.cityList, function (index, cityList) {
                    	 if(cityList.gugun == gugun){
                    		 
                    	 } else {
                    		 html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                    	 }                          
                     });                        
                $( "#cityList").html(html);
                $( "#cityList-button span").html( "구 / 군을 선택해주세요.");                        
                } else{}
	         }
	  });
	}
	
	function check_list(data){
		if(data == "1"){
			$("#list_select").val("new");
		} else if(data == "2"){
			$("#list_select").val("comment");
		} else if(data == "3"){
			$("#list_select").val("recommend");
		}
	}
	
	function search(){
// 		var sido = $("#areaList").val();
// 		var gugun = $("#cityList").val();
		var sido = $("#sido").val();
		var gugun = $("#gugun").val();
		var list_select = $("#list_select").val();
		var title = $("#search").val();
		params = "sido="+sido+"&gugun="+gugun+"&list_select="+list_select+"&title="+title;
	    $.ajax({
	        type        : "POST"
	      , async       : false
	      , url         : "/fieldStory/search_fieldStory.do"
	      , data        : params
	      , dataType    : "json"
	      , timeout     : 30000
	      , cache       : false
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
	       	$( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
	        $( "#popupDialog").popup( "open");
	      }
	      , success     : function(data) {
	    	  html = "";
	    	  $.each(data.fieldStory, function(index, fieldStory){
	    		  
	    		  html += "<div onclick='details("+fieldStory.fs_no+")' style='padding:.3em; border:solid 1px #e5e5e5; margin-bottom:.3em;'>"
	    		  html += "<div style='display:inline-block; width:25%; vertical-align:top;'>"
				  if(fieldStory.img01 != null && fieldStory.img01 != ""){
					  html += "<img src='/upload/img_fieldStory/"+fieldStory.member_no+"/"+fieldStory.img01+"' style='width:100%; height:4.5em; vertical-align:bottom; margin-right:.2em;' />"
				  } else if(fieldStory.img01 == null || fieldStory.img01 == ""){
	    			  if(fieldStory.img02 != null && fieldStory.img02 != ""){
	    				  html += "<img src='/upload/img_fieldStory/"+fieldStory.member_no+"/"+fieldStory.img02+"' style='width:100%; height:4.5em; vertical-align:bottom; margin-right:.2em;' />"
	    			  } else if(fieldStory.img02 == null || fieldStory.img02 == ""){
	    				  if(fieldStory.img03 != null && fieldStory.img03 != ""){
	    					  html += "<img src='/upload/img_fieldStory/"+fieldStory.member_no+"/"+fieldStory.img03+"' style='width:100%; height:4.5em; vertical-align:bottom; margin-right:.2em;' />"
	    				  } else {
	    					  html += "<img src='../img/fieldStory/list_noImg.jpg' style='width:100%; height:4.5em; vertical-align:middle; margin-right:.2em;' />"
	    				  }
	    			  }
	    		  }
	    		  
	    		  html += "</div>"
	    		  html += "<div style='display:inline-block; width:75%;'>"
	    		  html += "<div class='ui-grid-a' style=' padding:0 .3em;'>"
	    		  html += "<div class='ui-block-a' style='width:70% !important;'>"
				  html += "<p style='font-size:12px; margin:0; line-height: 24px;'>["+fieldStory.sido+" "+fieldStory.gugun+"]</p>"
	       		  html += "</div>";
	    		  html += "<div class='ui-block-b' style='width:30%; !important'>"
	       		  html += "<p style='font-size:8px; color:#888; margin:0; line-height: 24px; float:right;'>"+(fieldStory.insertDate).substring(2,10)+"</p>"
	      		  html += "</div>";
	      		  html += "</div>";
	    		  html += "<p style='margin:.1em .3em .3em .3em; font-size:14px; white-space:nowrap; overflow:hidden;'>"+fieldStory.title+"</p>"
// 	    		  if(fieldStory.logo_name == null || fieldStory.logo_name == ""){
// 				 	html += "<p>"+fieldStory.sido+" "+fieldStory.gugun+"<img src='../img/fieldStory/list_Write_icon.png'>"+fieldStory.member_id+"<img src='../img/fieldStory/recommend_icon.png style='width:1.5em;'>"+fieldStory.recommend_count+"<img src='../img/fieldStory/answer_icon.png'>"+fieldStory.answer_count+"</p>"  
// 				  } else if(fieldStory.logo_name != null && fieldStory.logo_name != ""){
// 				  	html += "<p>"+fieldStory.sido+" "+fieldStory.gugun+"<img src='/upload/img/"+fieldStory.member_id+"/"+fieldStory.logo_name+"' style='width:1.5em;'>"+fieldStory.member_id+"<img src='../img/fieldStory/recommend_icon.png'>"+fieldStory.recommend_count+"<img src='../img/fieldStory/answer_icon.png'>"+fieldStory.answer_count+"</p>"
// 			  	  }
	    		  html += "<div class='ui-grid-b' style=' padding:0 .3em;'>"
		 	 	  html += "<div class='ui-block-a' style='width:60% !important;'>"
		 	 		if(fieldStory.logo_name == null || fieldStory.logo_name == ""){
		 	 			html += "<p style='font-size:8px; margin:0; white-space:nowrap; overflow:hidden;'><img src='../img/fieldStory/list_logoImg.jpg' style='width:2em; vertical-align:middle; margin-right:.5em;' />"+fieldStory.koker_name+"</p>"
		 	 		} else if(fieldStory.logo_name != null && fieldStory.logo_name != ""){
		 	 			html += "<p style='font-size:8px; margin:0; white-space:nowrap; overflow:hidden;'><img src='/upload/img/"+fieldStory.member_id+"/"+fieldStory.logo_name+"' style='width:2em; vertical-align:middle; margin-right:.5em;' />"+fieldStory.koker_name+"</p>"
		 	 		}	       		  
	      		  html += "</div>";
		 	 	  html += "<div class='ui-block-b' style='width:20% !important;'>"
	       		  html += "<p style='font-size:8px; margin:0;'><img src='../img/fieldStory/recommend_icon.png' style='width:2em; vertical-align:middle; margin-right:.5em;' />"+fieldStory.recommend_count+"</p>"
	      		  html += "</div>";
		 	 	  html += "<div class='ui-block-c' style='width:20% !important;'>"
	       		  html += "<p style='font-size:8px; margin:0;'><img src='../img/fieldStory/answer_icon.png' style='width:2em; vertical-align:middle; margin-right:.5em;' />"+fieldStory.answer_count+"</p>"
	      		  html += "</div>";
	    		  html += "</div>";
	    		  html += "</div>";
	    		  html += "</div>";
	    	  });    	  
	    	  
	    	  if(data.fieldStory == null || data.fieldStory == ""){
	    		  html = "<div style='padding-top:2em; text-align:center;'>"
	    		  html += "<img src='../img/board/no_search.gif' style='width:40%;'/>";
	    		  html += "<p style='text-shadow:none; font-weight:normal !important; color:#666; font-size:14px; margin:0;'>검색 결과가 없습니다.</p>";
	    		  html += "</div>"
	    	  }
	    	  
	//   <c:if test="${data.logo_name == null }">
	// 		<div class="kok20_logo_img">
	// 			<img src="../img/list/list_bg.jpg"/>
	// 		</div>
	// 	</c:if>
		
	// 	<c:if test="${data.logo_name != null }">
	// 		<div class="kok20_logo_img">
	// 			<img src="/upload/img/${data.member_id }/${data.logo_name}" style="min-height:135px;"/>
	// 		</div>
	// 	</c:if>	  
	    	  $("#list_div").html(html).trigger("create");
	//     	  document.getElementById("area_back_cha").style.display = "none";
	      }
		});
	}
	
	//글쓰기
	function moveWrite(){
		var check_session = $("#session_member_no").val();
		var check_class_code = $("#session_class_code").val();
		if(check_session == null || check_session == "" || check_session == undefined){
			$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
			$("#popupCheck_space").popup("open");
		} else if(check_class_code == "01"){
			$("#popupCheck_txt").text("일반회원은 사용할 수 없습니다.");
			$("#popupCheck_space").popup("open");
		} 		
		else {
			location.href="<%=cp%>/fieldStory/move_write.do";
		}	
	}
	
	//상세페이지 이동
	function details(fs_no){
		var member_no = $("#session_member_no").val();
		location.href="<%=cp%>/fieldStory/move_details.do?fs_no="+fs_no+"&member_no="+member_no+"&backCount=1";
	}
	
	function myList(){
		var check_session = $("#session_member_no").val();
		if(check_session == null || check_session == "" || check_session == undefined){
			$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
			$("#popupCheck_space").popup("open");
		} else {
			location.href="<%=cp%>/fieldStory/move_myList.do?member_no="+check_session+"&backCount=1";
		}
	}
	
	function move_notice(){
		location.href="<%=cp%>/fieldStory/move_notice.do";
	}
	function move_mainPage() {
		location.href='#mainPage';
	}
</script>
</head>
<body>

	<!-- 메인 Page -->
	<div data-role="page" class="koker_page"
		style="background-color: #fff !important;" id="mainPage">
		<div data-role="header" data-position="fixed" class="join_header" style="background-color: #fff !important; border-bottom: solid 1px #29A9C8 !important;">
			<div class="back_btn">
				<a href="../appMain/appMain.do" data-ajax="false"
					class="relback_btn"><img src="../img/more/relback.gif" /></a>
			</div>
			<h1	style="background-color: #fff !important; color: #29A9C8 !important; font-size: 16px !important; font-weight: normal !important; text-shadow: none !important;">현장
				스토리</h1>
			<div class="ui-btn-right" style="padding-top: .2em;">
				<a onclick="location.href='#searchPage'" data-ajax="false">
					<img src="../img/fieldStory/search.png" style="width: 2.7em; vertical-align: top;" />
				</a>
				<a data-rel="popup" data-position-to="window" data-transition="pop" style="color:#21B4D6; margin-right:.3em;">
					<span style="font-size:24px; font-family:'godom';" onclick="myList()" data-ajax="false">MY</span>
				</a> 
				<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false">
					<img src="../img/header/home.png" style="width: 2.2em; vertical-align: top;" />
				</a>
			</div>
		</div>

		<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
		<input type="hidden" value="${sessionScope.sessionData.memberInfo.getClass_code()}" id="session_class_code">
		
		<!-- 검색 및 정렬 설정 부분 -->
<!-- 		<div class="ui-grid-a" style="background-color: #29A9C8; padding: .3em;"> -->
<!-- 			<div class="ui-block-a" style="width: 80% !important;"> -->
<!-- 				<div class="ui-grid-a" style="border-radius: 15px; padding: .2em 0 0 0; background-color: #fff;"> -->
<!-- 					<div class="ui-block-a" style="width: 88% !important;"> -->
<!-- 						<input type="text" name="search" id="search" placeholder="검색어를 입력해주세요." style="font-weight: normal !important; text-shadow: none; font-size: 14px; padding-left: 1em;" /> -->
<!-- 					</div> -->
<!-- 					<div class="ui-block-b"	style="width: 12% !important; padding: .2em 0 0 0;"> -->
<!-- 						<img src="../img/search/search_icon.gif" onclick="search()"	style="width: 1.5em; vertical-align: middle;" /> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="ui-block-b"	style="width: 20% !important; padding: 0 0 0 .3em;"> -->
<!-- 				<p onclick="location.href='#searchPage'" data-transition="slideup" style="margin: 0; font-weight: normal; text-shadow: none; font-size: 14px; text-align: center; background-color: #fff; border-radius: 20px; color: #29A9C8; padding: .5em 0;"> -->
<!-- 					<img src="../img/fieldStory/fil.png" style="width: 1.5em; vertical-align: bottom;" />정렬 -->
<!-- 				</p> -->
<!-- 			</div> -->
<!-- 		</div> -->

		<!-- 공지 사항 -->
		<div onclick="move_notice()">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach var="data" items="${fieldStoryNotice_list}">
						<div class="swiper-slide">
							<p>${data.c_s_title}</p>
						</div>
					</c:forEach>
				</div>
				<div class="swiper-pagination"></div>
			</div>
		</div>

		<div>
			<img src="../img/fieldStory/banner_img.png"	style="width: 100%; vertical-align: bottom;" />
<!-- 			<p style="margin: 0; font-size: 11px; padding: .3em 0 .3em .5em; background-color: #e5e5e5;"> -->
<!-- 				<img src="../img/list/list_area.gif" style="width: 1em; vertical-align: middle;" />검색결과 -->
<!-- 			</p> -->
		</div>

		<div id="list_div" style="margin-bottom: 3em; padding: .3em;"></div>

		<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
			<div class="ui-content" role="main">
				<p id="popupCheck_txt" style=""></p>
				<a style="background-color: #d7d7d7; margin-right: .5em;" href="#" data-rel="back" data-ajax="false">확인</a>
			</div>
		</div>

		<div data-role="footer" data-position="fixed" class="guide_footer" style="background-color: rgba(41, 169, 200, 1) !important; width: 100%; margin: 0; border: none; padding: .3em 0;" onclick="moveWrite()">
			<p style="text-shadow: none !important; color: #fff; font-weight: normal !important; font-size: 14px; font-family: 'GodoM' !important;">
				글쓰기
				<img src="../img/fieldStory/write_icon.png"	style="width: 1em; vertical-align: bottom;" />
			</p>
		</div>
	</div>

	<!-- 필터 Page -->
	<div data-role="page" id="searchPage">
		<div data-role="header" class="search_header"
			style="position: relative;">
			<div class="pop_btn_left">
				<a href="#" onclick="reset_search()" data-ajax="false">초기화</a>
			</div>
			<h1 style="font-family: 'GodoM'; font-size: 18px !important;">현장스토리
				검색</h1>
			<div class="ui-btn-right pop_btn_right">
				<a href="javascript:move_mainPage();" data-transition="slideup" class="ui-btn-right" style="font-size: 18px;">X</a>
			</div>
		</div>
		
<!-- 검색 및 정렬 설정 부분 -->

		<div data-role="content" class="search_content area_content search_cont search_cont2">
			<div class="ui-grid-a" style=" padding: .3em;">
				<p style="margin: 1em 0; font-size: 14px; font-weight: normal; text-shadow: none; font-family: 'godom'; color: #29A9C8;">
					통합검색
				</p>
				<input type="search" name="search" id="search" placeholder="제목을 입력해 주세요." style="font-weight: normal !important; text-shadow: none; font-size: 14px; padding-left: 1em;" />
			</div>		
		
			<p style="margin: 1em 0; font-size: 14px; font-weight: normal; text-shadow: none; font-family: 'godom'; color: #29A9C8;">
				지역검색
			</p>
			
			<div style="border-bottom: solid 1px #e9e9e9; padding-bottom: 1em;">
				<select id="areaList" onchange="getZip_city()" style="background-color: #fff;">
					<option value="default">시 / 도를 선택해주세요.</option>
				</select> <select id="cityList" onchange="default_gugun()"
					style="background-color: #fff;">
					<option value="default">구 / 군을 선택해주세요.</option>
				</select>
			</div>
			
			<div>
				<p style="margin: 1.5em 0 1em 0; font-size: 14px; font-weight: normal; text-shadow: none; font-family: 'godom'; color: #29A9C8;">
					리스트 정렬
				</p>
				<fieldset data-role="controlgroup" data-iconpos="right"	class="radio_set2">
					<input type="radio" name="radio-choice-w-6" id="radio-choice-w-6a" value="new" onclick="check_list('1')" checked="checked"> 
					
					<label	for="radio-choice-w-6a" id="radio_new" style="border-bottom: solid 1px #e5e5e5 !important; padding-left: .5em;">
						최신순
					</label>

					<input type="radio" name="radio-choice-w-6" id="radio-choice-w-6b" value="comment" onclick="check_list('2')">
					<label for="radio-choice-w-6b" id="radio_comment" style="border-bottom: solid 1px #e5e5e5 !important; padding-left: .5em;">댓글순</label>

					<input type="radio" name="radio-choice-w-6" id="radio-choice-w-6c" value="recommend" onclick="check_list('3')"> 
					<label for="radio-choice-w-6c" id="radio_recomment"	style="border-bottom: solid 1px #e5e5e5 !important; padding-left: .5em;">추천순</label>
				</fieldset>
			</div>
		</div>

		<div data-role=footer data-position="fixed"	style="border: none; text-align: center; background: none;">
			<img src="../img/search/search_tikok.gif" style="vertical-align: bottom; width: 25%; margin-bottom: -2%;" />
			<div onclick="search()"	style="text-align: center; background-color: #29A9C8; padding: .7em 0;">
				<a href="#mainPage" onclick="search()" data-transition="slideup" style="font-size: 16px; font-weight: normal; text-shadow: none; font-family: 'godom'; text-decoration: none; color: #fff;">검색</a>
			</div>
		</div>
	</div>

	<div>
		<input type="hidden" id="list_select" value="new">
		<input type="hidden" id="sido" value="default">
		<input type="hidden" id="gugun" value="default">
	</div>

</body>
</html>