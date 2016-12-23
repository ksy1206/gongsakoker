<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<script src="../js/swiper.min.js"></script>
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
</head>
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
		
		
		//시/도 지역 콤보설정
		getZip_area();
		//업체 콤보설정(뒤로가기 시 selected문제 때문에 스크립트로 처리..)
		getClassCodeList();
		
		//엔터키입력 시 검색처리
		$('input').keyup(function(e) {
		    if (e.keyCode == 13){
		    var search = $("#search").val();
		    if(search==""){
		    	$("#popupSpace").popup( "open" );
		    	$("#search").focus();
		    	return false;
		    }else{
		    	location.href="<%=cp%>/search/getSearchList.do?search="+search+"&flag=searchList";	
		    }
		    
			
		    }      
		});
		
	});

	//검색하기
	function getSearchList(){
		var class_code =  $( "#classCodeList option:selected").val();
		var category =  $( "#categoryList option:selected").val();
		var gugun =  $( "#cityList option:selected").val();
		var sido =  $( "#areaList option:selected").val();
		var search = $("#search").val();
		
		if(search == "" ||search == null || search == "null" || search == undefined || search == "업체명을 입력해주세요."){
			
// 			if(gugun == ""){
// 				$( "#dialog_txt").text( "시/도 를 선택해주세요." );
// 	            $( "#popupDialog").popup( "open");
// 	            return false;
// 			}
// 			if(sido == ""){
// 				$( "#dialog_txt"s).text( "구/군 을(를) 선택해주세요." );
// 	            $( "#popupDialog").popup( "open");
// 	            return false;
// 			}
			
// 			if(class_code == ""){
// 				$( "#dialog_txt").text( "업체종류를 선택해주세요." );
// 	            $( "#popupDialog").popup( "open");
// 	            return false;
// 			}
			
// 			if(category == ""){
// 				$( "#dialog_txt").text( "카테고리를 선택해주세요." );
// 	            $( "#popupDialog").popup( "open");
// 	            return false;
// 			}
			
			if(gugun == "" && sido == "" && class_code == "" && category == ""){
				$( "#dialog_txt").text( "검색할 정보를 입력해주세요." );
	            $( "#popupDialog").popup( "open");
	            return false;
			}else{
				location.href="<%=cp%>/search/getSearchList.do?class_code="+class_code+"&category="+category+"&gugun="+gugun+"&sido="+sido+"&flag=search";
			}
			
			
		}else{
			location.href="<%=cp%>/search/getSearchList.do?search="+search+"&flag=searchList";
		}
		
		
	}
	
	
	
	
	//시/도 지역
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
                       
                        if(data.areaList!= null && data.areaList.length != 0){
                 
                        	
//                              var html = "<option value='' style='background-color:yellow;'>시 / 도를 선택해주세요.</option>";
                             var html = "<option value='' >시 / 도를 선택해주세요.</option>";
                            $.each(data.areaList, function (index, areaList) {
                                 
                                 html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
                                 
                                 

                            });
                            
                            $( "#areaList").html(html);
                            
                            
                       } else{
                            
                       }

            	 }
      		});
       
 		}
 
	//구/군 지역
	function getZip_city(){

	  var sido = $( "#areaList option:selected").val();
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
	                       
                       if(data.cityList!= null && data.cityList.length != 0){
                    	
//                              var html = "<option value=''  id='default_option' style='background-color:yellow;'>구 / 군을 선택해주세요. </option>";
								var html = "<option value=''  id='default_option' >구 / 군을 선택해주세요. </option>";
                            $.each(data.cityList, function (index, cityList) {
                                 html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                            });
                            
	                       $( "#cityList").html(html);
	                       $( "#cityList-button span").html("구 / 군을 선택해주세요.");
	                            
                       } else{
                            
                       }       
	             	}     
	      	});    
	 	}    

	//업체별 전문 분야 로딩 및 화면 세팅
	function getBusinessKind(){
	     
	      var class_code = $("#classCodeList option:selected").val();
	     
	      $.ajax({
	             type        : "POST" 
	           , async       : false
	           , url         : "/member/getBusinessKind.do"
	           , data        : "class_code=" + class_code
	           , dataType    : "json"
	           , timeout     : 30000  
	           , cache       : false    
	           , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	           , error       : function(request, status, error) {
	              $( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
	              $( "#popupDialog").popup( "open");
	                     
	           }
	           , success     : function(data) {
	                     
	                      if(data.kindList!= null && data.kindList.length != 0){
	   
	                           var html =  "<option value=''  id='default_option'>카테고리를 선택해주세요.</option>";
	                          $.each(data.kindList, function (index, kindList) {
	                              
	                        	  html+= " <option value='"+kindList.category+ "'>"+kindList.code_name+ "</option>" ;
	                   
	                          });
	                          
	                          $("#categoryList").html(html);
	                          $("#categoryList-button span").html("카테고리를 선택해주세요.");
	                     } else{
	                          
	                     }
	                     
	                     
	           }
	    });
	     
	}
	
	
	//업체콤보
	function getClassCodeList(){
	      var html = "<option value=''>업체를 선택해주세요.</option>";
	      html+="<option value='02'>자재업체</option>";
	      html+="<option value='05'>시공업체</option>";
	      html+="<option value='04'>장비업체</option>";
	      html+="<option value='03'>기술자</option>";
	      html+="<option value='06'>종합</option>";
	      html+="<option value='07'>운송</option>";
	  	
	      $( "#classCodeList").html(html);      
 	}
	
</script>
<body>
	<div data-role="page" id="list_page" class="koker_page member_set_page more_menu search_page" style="background-color:#e5e5e5 !important;">
		<input type="hidden" value="" id="class_code"/>
		<input type="hidden" value="" id="category"/>
		<div data-role="header" data-position="fixed" class="join_header">
			<div class="back_btn">
				<a href="../appMain/appMain.do" data-ajax="false" data-rel="" class="relback_btn"><img src="../img/relback.gif"/></a>
			</div>
			<h1>검색</h1>
			<a href="../appMain/appMain.do" data-ajax="false" class="ui-btn ui-corner-all ui-btn-right">
				<img src="../../img/more/home_icon.gif" class="header_icon" onclick="share()"/>
			</a> 
		</div>
		
		<div data-role="content" class="search_content area_content" >
			<p style="margin: 1.5em 0 .5em 0; text-shadow: none; font-size: 14px; color:#29A9C8;">통합검색</p>
			<div class="search_input">
				<input type="search" id="search" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';" 
						onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="업체명을 입력해주세요." />
			</div>
			<p style="margin: 1.5em 0 .5em 0; text-shadow: none; font-size: 14px; color:#29A9C8;">업체 및 기술자를 쉽고 빠르게 찾아보세요!</p>
			<div class="ui-grid-a">
				<div class="ui-block-a" style="margin-right:.5em;">
					<select id="areaList"  onchange="getZip_city()" >
<!-- 						<option value="" style="background-color:yellow;">시 / 도를 선택해주세요.</option> -->
							<option value="">시 / 도를 선택해주세요.</option>
					</select>
				</div>
				<div class="ui-block-b" style="margin-left:.5em;">
					<select id="cityList">
<!-- 						<option value="" style="background-color:yellow;">구 / 군을 선택해주세요.</option>  -->
							<option value="">구 / 군을 선택해주세요.</option>
					</select>
				</div>
			</div>
			<div class="select_more">
				<select id="classCodeList" onchange="getBusinessKind();" >
					<option value="">업체를 선택해주세요.</option>
				</select>
			</div>
			<div class="select_more">
				<select id="categoryList">
					<option value="">카테고리를 선택해주세요.</option>
				</select>
			</div>
		</div>
		
		<div data-role="footer" data-position="fixed" style="border: none; background-color: rgba(255, 255, 255, 0.01)!important;">
			<div style="text-align: center; margin:0;">
<!-- 				<img src="../img/search/search_tikok.gif" style="vertical-align:bottom; width:25%; margin-bottom: -2%;"/> -->
				<p style="margin:0; padding:1em; background-color:#29A9C8; text-align: center; color:#fff; text-shadow:none !important; font-size:16px; font-weight:normal !important;" onclick="getSearchList();">검색하기</p>
			</div>
			 <div id="popupDialog" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
			    <div class="ui-content" role="main">
					<p id="dialog_txt"></p>
			      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
			  	</div>    
			 </div>	
			 <!--end 팝업부분 -->
		
		
		
			 <!-- Swiper -->
		    <div class="swiper-container">
		        <div class="swiper-wrapper">
		        	<div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=167&backCount=1'" class="swiper-slide" data-ajax="false"><img src="../img/banner/mainbanner_point.png" width="100%"></div>
		        	<div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=8128&backCount=1'" class="swiper-slide"><img src="../img/banner/mainbanner_road_3.png" width="100%"></div>
		        	<div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=7847&backCount=1'" class="swiper-slide"><img src="../img/banner/mainbanner_kang.png" width="100%"></div>
		       		<div onclick="location.href='<%=cp%>/kokkok20/kokkok20_details.do?koker_no=18&backCount=1'" class="swiper-slide" data-ajax="false"><img src="../img/banner/mainbanner_daseong.png" width="100%"></div>
		        </div>
		        <!-- Add Pagination -->
		        <div class="swiper-pagination"></div>
		    </div>
		</div>
	
		<!-- 팝업부분 -->
		
		 <div id="popupSpace" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
		    <div class="ui-content" role="main">
				<p>검색어를 입력해주세요.</p>
		      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
		  	</div>    
		 </div>	
		
		 <div id="popupDialog" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
		    <div class="ui-content" role="main">
				<p id="dialog_txt"></p>
		      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
		  	</div>    
		 </div>	
		 <!--end 팝업부분 -->
	
	</div>
	
	

</body>
</html>