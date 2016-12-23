<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	<script src="../js/jquery.bxslider.min.js"></script>
	<link rel="stylesheet" href="<%=cp%>/css/layout.css" />
	<link rel="stylesheet" href="<%=cp%>/css/main.css" />
	<link rel="stylesheet" href="<%=cp%>/css/search.css">
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
	<script type="text/javascript">
		$(document).ready(function($) {
			//hide the menu when the page load
			$(".filter-list").hide();
			//when .menuBtn is clicked, do this
			$(".filter_Btn_01").click(function() {
				//open the menu with slide effect
				$(".filter-list").slideToggle(000);
			});
			//카테고리 내역
			getBusinessKind();
			//시/도 지역 
			getZip_area();
		});//end document
		
	     
	  	//업체별 전문 분야 로딩 및 화면 세팅
	  	function getBusinessKind(){

	  		var class_code = $("#class_code_hidden").val();
	  	     
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
	  	             	alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );
	  	             
	  	                     
	  	           }
	  	           , success     : function(data) {
	  	        	
	                   var html =  "";
	                   $.each(data.kindList, function (index, kindList) {

	                 	html+= "<input  id='check"+kindList.category+ "' type='checkbox' name='category' value='"+kindList.category+ "' >" +
	                 			"<label class='' for='check"+kindList.category+ "' id='check"+kindList.category+"_label' >"+kindList.code_name+ "</label></div>" ;	                 	
	                   });
	                   
	                  $( "#code_name_div").html(html).trigger("create");
	  	                         
	  	                    
	  	                  
	  	           }
	  	    });
	  	     
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
	             	alert( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오." );     
	             }
	             , success     : function(data) {
	                       
	                        if(data.areaList!= null && data.areaList.length != 0){
	                 
	                        	var html = "";
	                            $.each(data.areaList, function (index, areaList) {	                                
	                                 html+= "<input id='area_"+index+"' type='radio' name='area' value='"+areaList.sido+"' /><label for='area_"+index+"' onclick=getZip_city('"+areaList.sido+"');>"+areaList.sido+"</label>";
										  
	                            });
	                           
	                            $("#areaList").html(html).trigger("create");
	                            
	                            
	                       } else{
	                            
	                       }

	            	 }
	      		});
	       
	 		}
	 
		//구/군 지역
		function getZip_city(sido){
// 		  var sido = $('input:radio[name="area"]:checked').val();

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
								var html = "";
								
	                            $.each(data.cityList, function (index, cityList) {
	                                 html+= "<input id='city_"+index+"' type='radio' name='city' value='"+cityList.gugun+"' /><label for='city_"+index+"'>"+cityList.gugun+"</label>";
	                            });
	                            
		                       $( "#cityList").html(html);
		                    
	                       } else{
	                            
	                       }       
		             	}     
		      	});    
		 	}    
		
		

	</script>
	
	
	
<body>

	<div class="wrapper" >
	
		<div class="board_header" style="background-color:#fff;">
			<jsp:include page="../../web/include/header.jsp"/>
			<div class="title" style="vertical-align: bottom; padding:3em 0 2em 0; text-align:center; border-bottom:solid 1px #ddd;background-color:#fff;">
					<h1 style="color:#21b4d6; font-size:32px;height:36px;">
						<input type="hidden" id="class_code_hidden" value="${class_code}">
						<input type="hidden" id="search_hidden" value="${search}">
						<input type="hidden" id="category_hidden" value="${category}">
						<input type="hidden" id="gugun_hidden" value="${gugun}">
						<input type="hidden" id="sido_hidden" value="${sido}">
						<c:choose>
							<c:when test="${class_code=='02'}">
								자재업체
							</c:when>
							<c:when test="${class_code=='03'}">
								기술자
							</c:when>
							<c:when test="${class_code=='04'}">
								장비업체
							</c:when>
							<c:when test="${class_code=='05'}">
								시공업체
							</c:when>
							<c:when test="${class_code=='06'}">
								종합
							</c:when>
							<c:when test="${class_code=='07'}">
								운송
							</c:when>
						</c:choose>

						
					</h1>
					<p style="color: #888; vertical-align: middle; font-size:11px;">모든 업체를 콕! 하세요.</p> 
			</div>
		</div>
		
		
			<div class="search_top_btn">
				<div style="float:left;" class="search_top_filter_btn">
					<span class="filter_Btn_01"><a href="#"><img src="<%=cp %>/img/web/filter_ico.png" style="width:12px;"> 필터</a></span>
						<!-- 필터 활성화 -->
						<nav class="filter-list">
							<div class="filter_btn">
								<div class="search_filter" style="float:none;" id="search_filter">
									<div class="search_filter_01">
										<p><img src="<%=cp %>/img/web/filter_paper_ico.PNG" style="width:17px;vertical-align:middle;"> 전문분야를 선택해주세요. (중복선택가능)</p>
										<div class="search_filter_list" id="code_name_div">
											
										</div>
									</div>
									<div class="search_filter_02">
										<p><img src="<%=cp %>/img/web/filter_position_ico.png" style="width:17px;vertical-align:middle;"> 지역을 선택해주세요.</p>
										<div class="search_filter_list" id="areaList" >
											
										   
										</div>
										<div class="search_filter_02">
											<div class="search_filter_list"  id="cityList" >
											
										   
											</div>
										</div>
									</div>
									<div class="search_filter_btn" onclick='search("web_detail");'>
										<h3>적용하기</h3>
									</div>
								</div>
							</div>
						</nav>
						<!-- 필터 활성화 끝 -->
				</div>
				<!-- 추천순 메뉴 -->
				<div class="search_top_btn_commend">
					<select name="combo" id="order" size="1" onchange='search("web_order");'>
						<option value="" selected>정렬</option>
						<option value="review_avg" >평점순</option>
						<option value="insert_date">최신순</option>
						<option value="ranking">랭킹순</option>
					</select>
				</div>
			</div>
		
		
		<!-- 검색결과가 없을때 리스트가 없을때 -->
		<c:if test="${dataCnt==null || dataCnt==0}">
			<center>
				<div class="kok_list_none" id="none_list" >
					<img src="../../img/list/list_none_cha.gif" />
					<h3>찾으실 업체명을 검색해주세요.</h3>
				</div>
			</center>
		</c:if>	
		<c:if test="${dataCnt!=null && dataCnt!=0}">	
		<!-- 나의콕 리스트가 있을때 -->	
		
			<div class="main_container">
				<div class="content">
				
				<c:forEach var="data" items="${searchList}" varStatus="num">
					<input type="hidden" value="${data.koker_no}" id="return_koker_no_${num.count}">
					
					<!-- 추천 리스트 첫번째 줄 -->
					  	<div class="koker_recommend" style="background-color:#fff;" onclick="location.href='<%=cp%>/web/web_details.do?koker_no=${data.koker_no}'">
					  		<div  class="koker_recommend_top">
					  				<span class="main_star">
					  					<c:if test="${'y' eq data.charge_yn}">
				    						<img src="<%=cp%>/img/web/main/list_recommend_ico.gif" style="width:21px;float:left;margin-top:-2px;">
				    					 </c:if>
										<span class="star-input">
										  <span class="input">
										  <c:choose>
											<c:when test="${data.review_avg=='1'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" checked="checked" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='2'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled" checked="checked"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='3'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" checked="checked"><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='4'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled" checked="checked"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='5'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled" checked="checked"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='6'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled" checked="checked"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='7'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled"checked="checked" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='8'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled" checked="checked"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='9'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled" ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled" checked="checked"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:when>
											<c:when test="${data.review_avg=='10'}">
												<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"  ><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled" checked="checked"><label for="p10">10</label>
											</c:when>
											<c:otherwise>
											<input type="radio" name="star-input" id="p1" value="1" disabled="disabled"><label for="p1">1</label>
											    <input type="radio" name="star-input" id="p2" value="2" disabled="disabled"><label for="p2">2</label>
											    <input type="radio" name="star-input" id="p3" value="3" disabled="disabled" ><label for="p3">3</label>
											    <input type="radio" name="star-input" id="p4" value="4" disabled="disabled"><label for="p4">4</label>
											    <input type="radio" name="star-input" id="p5" value="5" disabled="disabled"><label for="p5">5</label>
											    <input type="radio" name="star-input" id="p6" value="6" disabled="disabled"><label for="p6">6</label>
											    <input type="radio" name="star-input" id="p7" value="7" disabled="disabled" ><label for="p7">7</label>
											    <input type="radio" name="star-input" id="p8" value="8" disabled="disabled"><label for="p8">8</label>
											    <input type="radio" name="star-input" id="p9" value="9" disabled="disabled"><label for="p9">9</label>
											    <input type="radio" name="star-input" id="p10" value="10" disabled="disabled"><label for="p10">10</label>
											</c:otherwise>
										</c:choose>
										    
										  </span>
										</span>

						  				 <c:if test="${'0' ne data.ranking}">
						    				<span class="main_ranking" >콕콕! ${data.ranking}위</span>
							   			 </c:if>
							  			
						  			</span>
						  			
					  				<h4 style="margin:5% 0 2% 0;"><a href="#">${data.koker_name }</a>
										    <c:if test="${'1' eq data.state}">
										    	<img src="../../img/list/list_wait.gif" style="width:17%;height:20px;margin:-7px .5%;"/>
										    </c:if>
										    <c:if test="${'0' eq data.state}">
										   
										   	 <c:if test="${'03' eq data.class_code}">
										    	<img src="../../img/list/list_wark.gif" style="width:17%;height:20px;margin:-7px .5%;"/>
										     </c:if>
										     
										    </c:if>
									</h4>
					  				<p style="font-size:9pt;margin-bottom:2%;">${data.addr01}</p>
<%-- 					  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_map_ico.gif" style="width:10px;"> 9.5 km</span> --%>
					  				<span style="font-size:11pt;"><img src="<%=cp%>/img/web/main/list_review_ico.gif" style="width:15px;">${data.review_count }</span>
					  		</div>
					  		<div class="koker_recommend_middle" style="width:100%; overflow:hidden; height:130px;">
					  					<c:if test="${'03' ne data.class_code}">
						  		  			<c:if test="${data.logo_name == '' || data.logo_name == null || data.logo_name == undefined}">
									    		<img src="<%=cp %>/img/list/list_bg.jpg" style="width:100%;" />
									    	</c:if>
								    		<c:if test="${data.logo_name != '' && data.logo_name != null && data.logo_name != undefined}">	
									    		<img src="<%=cp %>/upload/img/${data.member_id}/${data.logo_name}" style="width:233px; height:130px;" />
									    	</c:if>	
								    	</c:if>
					  					<c:if test="${'03' eq data.class_code}">
										    <c:if test="${data.logo_name == '' || data.logo_name == null || data.logo_name == undefined}">
									    		<img src="<%=cp %>/img/list/list_bg.jpg" style="width:100%;" />
									    	</c:if>
								    		<c:if test="${data.logo_name != '' && data.logo_name != null && data.logo_name != undefined}">	
									    		<img src="<%=cp %>/upload/img/${data.member_id}/${data.logo_name}" style="width:233px; height:130px;" />
									    	</c:if>	
									    </c:if>
					  		</div> 
<!-- 					  		<div class="koker_recommend_bottom"> -->
<!-- 					  			<span style="margin-left:0.5%;">인테리어</span> -->
<!-- 					  			<span>주방|가구</span> -->
<!-- 					  			<span>가가가가가가가가</span> -->
<!-- 					  			<span style="float:right;color:#b7b6b6;font-size:8pt;margin-right:1%;">그 외 3</span> -->
<!-- 					  		</div> -->
					  	</div>
				  	</c:forEach>
				</div>
			</div>
		</c:if>
	</div>
		
		<div class="footer_wrap">
			<jsp:include page="../../web/include/footer.jsp"/>
		</div>
</body>
</html>