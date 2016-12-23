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
		//시 지역 콤보
		getZip_area();
		//분류1 콤보 
		getEstType01List();
		//엔터키 입력시
		$('input').keyup(function(e) {
		    if (e.keyCode == 13){
		    var search = $("#search").val();
		    if(search==""){
		    	$("#popupSpace").popup( "open" );
		    	$("#search").focus();
		    }else{
		    	location.href="<%=cp%>/estimate/getSearchList.do?search="+search+"&flag=searchList";	
		    }
		    
			
		    }      
		});
		/* 슬라이드  옵션 */
		var swiper = new Swiper('.swiper-container', {
			pagination: '.swiper-pagination',
			paginationClickable: true,
			centeredSlides: true,
			autoplay: 3000,
			autoplayDisableOnInteraction: false,
			loop: true,
		});
	});


	function getSearchList(){
		var estType01_code =  $( "#estType01List option:selected").val();
		var estType02_code =  $( "#estType02List option:selected").val();
		var gugun =  $( "#cityList option:selected").val();
		var sido =  $( "#areaList option:selected").val();
		
		if(estType01_code == ""){
			$( "#dialog_txt").text( "분류를 선택해주세요." );
            $( "#popupDialog").popup( "open");
            return false;
		}
		if(estType02_code == ""){
			$( "#dialog_txt").text( "분류를 선택해주세요." );
            $( "#popupDialog").popup( "open");
            return false;
		}		
		location.href="<%=cp%>/estimate/getSearchList.do?estType01_code="+estType01_code+"&estType02_code="+estType02_code+"&est_gugun="+gugun+"&est_sido="+sido+"&flag=search";
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
                       
                        if(data.areaList!= null && data.areaList.length != 0){
                 
                 
                             var html = "<option value='' >시 / 도</option>";
                            $.each(data.areaList, function (index, areaList) {
                                 
                                 html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
                                 
                                 

                            });
                            
                            $( "#areaList").html(html);
                            
                            
                       } else{
                            
                       }

            	 }
      		});
       
 		}
 
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

                             var html = "<option value=''  id='default_option'>구 / 군 </option>";
                            $.each(data.cityList, function (index, cityList) {
                                 html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                            });
                            
	                       $( "#cityList").html(html);
	                       $( "#cityList-button span").html("구 / 군");
	                            
                       } else{
                            
                       }       
	             	}     
	      	});    
	 	}    

	//소분류 로딩 및 화면 세팅
	function getEstType02List(){
	     
	      var estType01_code = $("#estType01List option:selected").val();
	    
	      $.ajax({
	             type        : "POST" 
	           , async       : false
	           , url         : "/estimate/getEstType02List.do"
	           , data        : "estType01_code=" + estType01_code
	           , dataType    : "json"
	           , timeout     : 30000  
	           , cache       : false    
	           , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	           , error       : function(request, status, error) {
	              $( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
	              $( "#popupDialog").popup( "open");
	                     
	           }
	           , success     : function(data) {
	        	  
                   
	                      if(data.estType02List!= null && data.estType02List.length != 0){
	   
	                           var html =  "<option value=''  id='default_option'>소분류를 선택해주세요.</option>";
	                          $.each(data.estType02List, function (index, estType02List) {
	                             
	                        	  html+= " <option value='"+estType02List.estType02_code+ "'>"+estType02List.estType02_name+ "</option>" ;
	                   
	                          });
	                          
	                          $("#estType02List").html(html);
	                          $("#estType02List-button span").html("분류를 선택해주세요.");
	                     } else{
	                          
	                     }
	                     
	                     
	           }
	    });
	     
	}
	
	//중분류 콤보
	function getEstType01List(){

	      var html = "<option value=''>대분류를 선택해주세요.</option>";
	      html+="<option value='1'>주거공간</option>";
	      html+="<option value='2'>상업공간</option>";
	    
	  	
	      $( "#estType01List").html(html);      
 	}
	
	function call_back(){
		location.href="<%=cp%>/estimate/mainList.do?estType01_code=1&type01=1&type02=all";	
	}
	
</script>
<body>
	<div data-role="page" id="list_page" class="koker_page member_set_page more_menu search_page" style="background-color:#e5e5e5 !important;">
	
		<div data-role="header" data-position="fixed" class="join_header">
			<div class="back_btn">
				<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/relback.gif"/></a>
			</div>
			<h1>검색</h1>
			<a href="../appMain/appMain.do" data-ajax="false" class="ui-btn ui-corner-all ui-btn-right">
				<img src="../../img/more/home_icon.gif" class="header_icon" onclick="share()"/>
			</a> 
		</div>
		
		<div data-role="content" class="search_content area_content" >
<!-- 			<p style="margin: 1.5em 0 .5em 0; text-shadow: none; font-size: 14px; color:#29A9C8;">통합검색</p> -->
<!-- 			<div class="search_input"> -->
<!-- 				<input type="search" id="search" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  -->
<!-- 						onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="검색어를 입력해주세요." /> -->
<!-- 			</div> -->
			<p style="margin: 1.5em 0 .5em 0; text-shadow: none; font-size: 14px; color:#29A9C8;">견적의뢰를 쉽고 빠르게 찾아보세요!</p>
			<div class="ui-grid-a">
				<div class="ui-block-a" style="margin-right:.5em;">
					<select id="areaList"  onchange="getZip_city()" >
						<option value="">시 / 도</option>
					</select>
				</div>
				<div class="ui-block-b" style="margin-left:.5em;">
					<select id="cityList">
						<option value="">구 / 군</option> 
					</select>
				</div>
			</div>
			<div class="select_more">
				<select id="estType01List" onchange="getEstType02List();" >
					<option value="">대분류를 선택해주세요.</option>
				</select>
			</div>
			<div class="select_more">
				<select id="estType02List">
					<option value="">소분류를 선택해주세요.</option>
				</select>
			</div>
		</div>
		
		<div data-role="footer" data-position="fixed" style="border: none; background-color: rgba(255, 255, 255, 0.01)!important;">
			<div style="text-align: center; margin:1em 0 0 0;">
				<img src="../img/search/search_tikok.gif" style="vertical-align:bottom; width:25%; margin-bottom: -2%;"/>
				<p style="margin:0; padding:1em; background-color:#29A9C8; text-align: center; color:#fff; text-shadow:none !important; font-size:14px; font-weight:normal !important;" onclick="getSearchList();">검색하기</p>
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
		           <div class="swiper-slide"><img src="../img/banner/test1.png" style="width:100%;"/></div>
		           <div class="swiper-slide"><img src="../img/banner/test2.png" style="width:100%;"/></div>
		           <div class="swiper-slide"><img src="../img/banner/test3.png" style="width:100%;"/></div>
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