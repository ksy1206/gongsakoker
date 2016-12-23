<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
	String androidData = "";
	if(session.getAttribute("androidData") != null) {
		androidData = session.getAttribute("androidData").toString();	
	}
		
	String currentUrl = request.getScheme() + "://" + request.getServerName();
	currentUrl += (request.getServerPort()==80?"":":"+request.getServerPort()); 
	currentUrl += request.getAttribute("javax.servlet.forward.request_uri");
	request.setAttribute("url", currentUrl); 
	String currentQuery = request.getQueryString();
	if ( request.getQueryString() != null ){
		currentUrl = currentUrl + "?" + request.getQueryString();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="../css/swiper.min.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/like/like.js"></script>
<script type="text/javascript" src="<%=cp %>/js/koker_public.js"></script>
<script src="../js/swiper.min.js"></script>
<script type="text/javascript">

	//업체별 전문 분야 로딩 및 화면 세팅
	window.onload=function getBusinessKind(){
		var koker_no = $("#return_koker_no").val();
		var class_code = $('#class_code').val();
		var params = "class_code=" + class_code+"&koker_no="+koker_no;
		 $.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/kokkok20/getBusinessKind_select.do"
		      , data        : params
		      , dataType    : "json" 
		      , timeout     : 30000
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  var html = "";
					$.each(data.listClass_code, function(index, class_code) {
						$.each(data.category, function(index, categoryList) {
							if(class_code.category == categoryList.category){
								if(categoryList.value=="y"){
									html += "<div style='width:29%; float:left; color:#fff; background-color:#29A9C8; font-size:12px; padding:.5em 0; text-shadow:none; margin:2%;'>"
									html += class_code.code_name;
									html += "</div>";
								}
							} 
						});			
				   	});					
					$("#code_name_div").html(html).trigger("create");
		      }
	    	});
	}
	
	$(document).ready(function(){
		//전화연결 팝업창
		$("#connect_phone").click(function(){		
			$("#popupDialog").popup("open");
		});
		$("#connect_message").click(function(){
			$("#popupDialog2").popup("open");
		});
		//질문 페이지 이동
		$("#question").click(function(){
			var session = $("#session_member_no").val();
			var koker_no = $("#koker_no").val();
			if(session == ""){
				$("#popupCheck").popup("open");
			} else {
				location.href="${pageContext.request.contextPath}/kokkok20/question.do?koker_no="+koker_no+"&backCount="+'1';		
			}
		});
		//답변 페이지 이동
		$("#answer").click(function(){
			var koker_no = $("#koker_no").val();
			location.href="${pageContext.request.contextPath}/kokkok20/answer.do?koker_no="+koker_no+"&backCount="+'1';
		});
		//북마크 추가 팝업 닫기
		$("#popupAddBookmark").click(function(){
			$("#popupAddBookmark").popup("close");
		});
		//북마크 삭제 팝업 닫기
		$("#popupDeleteBookmark").click(function(){
			$("#popupDeleteBookmark").popup("close");
		});
		
		//문자공유
		$("#share_sms").click(function(){
			var sendMessage = "business" + ";;;";
			sendMessage += $("#return_koker_no").val() + ";;;"; //링크될 주소
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }'; //업체 주소 
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareSMS(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareSMS" + ";;;" + encodeURIComponent(sendMessage);
   	    		document.location = s2;
			} 	    
			else {
				alert(sendMessage);
			}
		});
		//카카오톡 공유
		$("#share_kakaoTalk").click(function(){
			var img1 = "${memberVo.file01_name}";
			var img2 = "${memberVo.file02_name}";
			var img3 = "${memberVo.file03_name}";
			var imgsrc = '';
			var logo_img = "${memberVo.logo_name}";
			
			if(logo_img != null && logo_img != ''){
				imgsrc = "upload/img/${memberVo.member_id}/${memberVo.logo_name}";
			}
			
			if(img1 != null && img1 != ''){
				imgsrc = "upload/img/"+'${memberVo.member_id }'+"/"+'${memberVo.file01_name }';
			}else {
				if(img2 != null && img2 != ''){
					imgsrc = "upload/img/"+'${memberVo.member_id }'+"/"+'${memberVo.file02_name }';
				}else {
					if(img3 != null && img3 != ''){
						imgsrc = "upload/img/"+'${memberVo.member_id }'+"/"+'${memberVo.file03_name }';
					}else {
						imgsrc = "nil";
					}
				}
			}
			var sendMessage = "business" + ";;;";
			sendMessage += "<%=currentUrl%>" + ";;;"; //현재주소
			sendMessage += imgsrc + ";;;"; //이미지
			sendMessage += getShareBusinessKind() + ";;;"; //업체 전문분야
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }'; //업체 주소 
			
			
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareKakaoTalk(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareKakaotalk" + ";;;" + encodeURIComponent(sendMessage);  
   	    		document.location = s2;
			} 	    
			else {
				alert("result = " + sendMessage);
			}
			
		});
		//카카오스토리 공유
		$("#share_kakaoStory").click(function(){
			var img1 = "${memberVo.file01_name}";
			var img2 = "${memberVo.file02_name}";
			var img3 = "${memberVo.file03_name}";
			var imgsrc = '';
			var logo_img = "${memberVo.logo_name}";
			
			if(logo_img != null && logo_img != ''){
				imgsrc = "upload/img/${memberVo.member_id}/${memberVo.logo_name}";
			}
			
			if(img1 != null && img1 != ''){
				imgsrc = "upload/img/"+'${memberVo.member_id }'+"/"+'${memberVo.file01_name }';
			}else {
				if(img2 != null && img2 != ''){
					imgsrc = "upload/img/"+'${memberVo.member_id }'+"/"+'${memberVo.file02_name }';
				}else {
					if(img3 != null && img3 != ''){
						imgsrc = "upload/img/"+'${memberVo.member_id }'+"/"+'${memberVo.file03_name }';
					}else {
						imgsrc = "nil";
					}
				}
			}
			var sendMessage = "business" + ";;;";
			sendMessage += $("#return_koker_no").val() + ";;;"; //링크될 주소
			sendMessage += imgsrc + ";;;"; //이미지
			sendMessage += getShareBusinessKind() + ";;;"; //업체 전문분야
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }' + ";;;"; //업체 주소 
			
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareKakaoStory(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareKakaostory" + ";;;" + encodeURIComponent(sendMessage); 
		    	document.location = s2;
			} 	    
			else {
				//일반Web일 때
			}
			
		});
		//페이스북 공유
		$("#share_faceBook").click(function(){
			var sendMessage = "business" + ";;;";
			sendMessage += $("#return_koker_no").val() + ";;;"; //링크될 주소
			sendMessage += getShareBusinessKind() + ";;;"; //업체 전문분야
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }' + ";;;"; //업체 주소 
			
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareFaceBook(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareFacebook" + ";;;" + encodeURIComponent(sendMessage); 
		    	document.location = s2;
			} 	    
			else {
				//일반Web일 때
			}
			
		});
		//트위터 공유
		$("#share_twitter").click(function(){
			var sendMessage = "business" + ";;;";
			sendMessage += $("#return_koker_no").val() + ";;;"; //링크될 주소
			sendMessage += getShareBusinessKind() + ";;;"; //업체 전문분야
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }' + ";;;"; //업체 주소 
			
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareTwitter(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareTwitter" + ";;;" + encodeURIComponent(sendMessage); 
		    	document.location = s2;
			} 	    
			else {
				//일반Web일 때
			}
		});
		//밴드 공유
		$("#share_band").click(function(){
			var sendMessage = "business" + ";;;";
			sendMessage += $("#return_koker_no").val() + ";;;"; //링크될 주소
			sendMessage += getShareBusinessKind() + ";;;"; //업체 전문분야
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }' + ";;;"; //업체 주소 
			
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareBand(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareBand" + ";;;" + encodeURIComponent(sendMessage);  
		    	document.location = s2;
			} 	    
			else {
				//일반Web일 때
			}
		});
		//라인공유
		$("#share_line").click(function(){
			var sendMessage = "business" + ";;;";
			sendMessage += $("#return_koker_no").val() + ";;;"; //링크될 주소
			sendMessage += getShareBusinessKind() + ";;;"; //업체 전문분야
			sendMessage += '${memberVo.koker_name }' + ";;;"; //업체 이름
			sendMessage += '${memberVo.addr01} ${memberVo.addr02 }' + ";;;"; //업체 주소 
			
			var useragent = navigator.userAgent;
			if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
				window.android.shareLine(sendMessage);
			}
			else if(useragent.indexOf("Connect By iPhone OS") > -1) {
				var s2 = "iosjavascript://shareLine"  + ";;;" + encodeURIComponent(sendMessage);  
   	    		document.location = s2;
			} 	    
			else {
				//일반Web일 때
			}
		});
		
		//공유하기에서 가져오기 ---
		function getShareBusinessKind(){
			var kind = "";
			var result = "";
			var koker_no = $("#return_koker_no").val();
			var class_code = $('#class_code').val();
			var params = "class_code=" + class_code+"&koker_no="+koker_no;
			 $.ajax({
			        type        : "POST"  
			      , async       : false 
			      , url         : "/kokkok20/getBusinessKind_select.do"
			      , data        : params
			      , dataType    : "json" 
			      , timeout     : 30000
			      , cache       : false     
			      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
			      , error       : function(request, status, error) {
						alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
			      }
			      , success     : function(data) {
			    	  $.each(data.listClass_code, function(index, class_code) {
							$.each(data.category, function(index, categoryList) {
								if(class_code.category == categoryList.category){
									if(categoryList.value=="y"){
										kind += class_code.code_name + ", ";
									}
								} 
							});			
					   	});
						result = kind;
			      }
		    	});
			return result;
		}
		//종현
		
		var rankImage= '${memberVo.ranking}';
		var html = "";
		for(var i = 1;i<=20;i++){
			if(rankImage == i ){
				html = '<img src="../img/more/ranking_number_'+i+'.png" style="width:100%;">';
				$('#rankImage').html(html);
			}
		}		
	});
	
	//전화,문자 연결		
	function connect(data){
			location.href=data;
	}
	
	//리뷰쓰기
	function review_write(koker_no, member_no){
		var koker_no = koker_no;
		var member_no = member_no;
		var comment = $("#reviewComment").val();
		if(comment == null || comment == "" || comment == "리뷰를 입력해 주세요"){
			$("#popupCheck_review").popup("open");
			return false;
		}
		$("#popupWrite").popup("open");
		$("#write").click(function(){	
		var review = $("#reviewReview").val();
		var member_id = $("#member_id").val();
		params ="koker_no="+koker_no+"&member_no="+member_no+"&comment="+comment+"&review="+review+"&member_id="+member_id;
			$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/kokkok20/review_Write.do"
		      , data        : params
		      , dataType    : "json"
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  var params = "koker_no="+koker_no+"&member_no="+member_no;
		    	  review_open(params);
		    	  $("#popupWrite").popup("close");
		      }
			});	
		});
	}
	
	//리뷰 수정
	function review_modify(review_no, koker_no, member_no){
		var comment_test = $("#rev_comment").val();
		$("#reviewComment_modify").val(comment_test);
		var koker_no = koker_no;
		var member_no = member_no;
		var review_no = review_no;
		var review = $("#reviewReview").val();
		$("#review_modify_1").val(review);
		$("#popupModify").popup("open");
		$("#modifyReview").click(function(){
			var comment = $("#reviewComment_modify").val();
			var review = $("#review_modify_1").val();		
			params = "review_no="+review_no+"&comment="+comment+"&review="+review;
			$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/kokkok20/review_Modify.do"
		      , data        : params
		      , dataType    : "json"
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  var params = "koker_no="+koker_no+"&member_no="+member_no;
		    	  review_open(params);
		    	  $("#popupModify").popup("close");
		      }
			});			
		});
	}
	
	//리뷰 삭제
	function review_delete(review_no, koker_no, member_no){
		var koker_no = koker_no;
		var member_no = member_no;
		var review_no = review_no;
		$("#popupDelete").popup("open");
		$("#deleteReview").click(function(){
			params = "review_no="+review_no;
			$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/kokkok20/review_Delete.do"
		      , data        : params
		      , dataType    : "json"
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  var params = "koker_no="+koker_no+"&member_no="+member_no;
		    	  review_open(params);
		    	  $("#popupDelete").popup("close");
		      }
			});			
		});
	}
	
	//리뷰 보기 클릭시 이너html 사용하여 리뷰 관련 div생성 
	function review_open(params){
		var params = params;
		var html = "";
		var session_member = $("#session_member_no").val();
		var this_member_no = $("#this_member_no").val();
			$.ajax({
		        type        : "POST"  
		      , async       : false 
		      , url         : "/kokkok20/select_review.do"
		      , data        :  params
		      , dataType    : "json" 
		      , timeout     : 30000   
		      , cache       : false     
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
					alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
		      }
		      , success     : function(data) {
		    	  var str ='"';
		    	  	if(data.reviewVo == null){
		    	  		if(data.member_no == ''){
		    	  			html+="<input type='text' readonly='readonly' style='padding-left:1.5em; color:#888; border:0; text-align:center;' value='리뷰는 로그인 후 작성 하실수 있습니다.'>";
		    	  		} else if (this_member_no == session_member){
		    	  			html+="<input type='text' readonly='readonly' style='padding-left:1.5em; color:#888; border:0; text-align:center;' value='My업체에는 리뷰를 남길 수 없습니다.'>";
			    	  	} else {
		    	  			html+="<div class='review_wright'><p><form><label for='slider-2' style='font-size:12px;'>평점</label><input name='slider-2' id='reviewReview' type='range' min='0' max='10' value='5' step='1' data-highlight='true'></form></p>"
		    	  			html+="<input type='text' onfocus="+str+"if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"+str+" onblur="+str+"if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}"+str+" value='리뷰를 입력해 주세요' id='reviewComment'>";
		    	  			html+="<input type='hidden' value='${sessionScope.sessionData.memberInfo.getMember_id()}' id='member_id'>";
			    	  		html+="<p class='review_wright_p'><span class='review_wright_span' onclick='review_write("+data.koker_no+","+data.member_no+")'>리뷰쓰기</span><p></div>";
		    	  		}
		    	  	} else {
		    	  		html+="<div class='review_wright'><p><form><label for='slider-2' style='font-size:12px;'>평점</label><input name='slider-2' disabled='disabled' id='reviewReview' type='range' min='0' max='10' value='"+data.reviewVo.review+"' step='1' data-highlight='true'></form></p>"
		    	  		html+="<input type='text' onfocus="+str+"if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"+str+" onblur="+str+"if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}"+str+" id='rev_comment' value='"+data.reviewVo.comment+"'>";
		    	  		html+="<p class='review_wright_p'><span class='review_wright_span' onclick='review_modify("+data.reviewVo.review_no+","+data.koker_no+","+data.member_no+")'>수정</span>";
		    	  		html+="<span class='review_wright_span' onclick='review_delete("+data.reviewVo.review_no+","+data.koker_no+","+data.member_no+")'>삭제</span></p></div>"
		    	  	}
		    	  $.each(data.reviewList, function(index, reviewList){
		    		  html+="<div class='review_list'><p><span class='review_name'>"+reviewList.member_id+"</span>  "+reviewList.insert_date.substring(0,10)+"</p>";  
		    		  html+="<p><form><label for='slider-2'></label><input name='slider-2' disabled='disabled' id='slider-2' type='range' min='0' max='10' value='"+reviewList.review+"' step='1' data-highlight='true'></form></p>"				
		    		  html+="<p>"+reviewList.comment+"</p></div>"
		    	  });
		    	  html+="<p class='review_wright_p' style='text-align:right !important;' onclick='review_more("+data.koker_no+")'>더보기<img src='../img/more/more_icon.gif' /></p>";
		      }
			});	
			$("#review").html(html).trigger("create");
			time_set();			
	}
	function time_set(){
		setTimeout("window.scrollTo(0,710)",1);
		
	}
	//리뷰 더보기 클릭
	function review_more(koker_no){
		location.href="${pageContext.request.contextPath}/kokkok20/reviewMore.do?koker_no="+koker_no;
	}
	
	
	<% String check_zzim="no"; %> // 마이콕 하트 이미지 관련 변수
	
	
	
	//페이지 다시 불러오기 메소드
	// function reloading(){
	// 	var koker_no = $("#return_koker_no").val();
	// 	var review_avg = $("#return_review_avg").val();
	// 	var review_count = $("#return_review_count").val();
	// 	var ranking = $("#return_ranking").val();
	//     	  location.href="${pageContext.request.contextPath}/kokkok20/kokkok20_details.do?koker_no="+koker_no+
	// 			"&review_avg="+review_avg+"&review_count="+review_count+"&ranking="+ranking;	
	// }
	
	//맵 페이지 이동
	function move_map(){
		
	}
	
	//공유하기 버튼 클릭
	function share(){	
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			checkAndroid();
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s2 = "iosjavascript://getAppVersion()";
			document.location = s2;
		} 	    
		else {
			$("#popupShare").popup("open");	
		}
	}
	/*
	 * 
	 버전체크 사용법 
	 var s2 = "iosjavascript://getAppVersion();;;share";
		document.location = s2;
	 */

	function setiphoneAppVer(appver) {
		
		iphoneAppVer = appver;
		//alert(iphoneAppVer);
		$("#popupShare").popup("open");
	}
	function checkAndroid() {
		var appVer = "<%=androidData%>";
		var appStr = appVer.split(".");
	 	var appInt = new Array();
	 	for(var i=0;i<3;i++) {
	 		appInt[i] = parseInt(appStr[i]);
	 	}
	 	if(appInt[0] >= 2) {
	 		if(appInt[1] >= 2) {
	 			$("#popupShare").popup("open");
	 		}else {
	 			alert("앱을 업데이트 해주세요\n 이 기능은 2.2.0버전 이상에서만 사용할 수 있습니다.");
	 		}
	 	}else {
	 		alert("앱을 업데이트 해주세요\n 이 기능은 2.2.0버전 이상에서만 사용할 수 있습니다.");
	 	}
	}
	
	$(document).ready(function(){
		   var swiper = new Swiper('.swiper-container');
			$("#back_btn").attr("data-rel","");
	});
	
	function call_back(){
		var backCount = $("#backCount").val();
		if(backCount == "1"){
			history.go(-1);
		} else if(backCount == "2"){
			history.go(-2);
		} else if(backCount == "3"){
			history.go(-3);
		}
	}
	//앱메인 가기 버튼 클릭
	function goAppMain(){	
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.send_version();
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s2 = "iosjavascript://send_version();"
			document.location = s2;
		} 	    
		else {
			document.location.href = "<%=cp%>/appMain/appMain.do";
		}
	}
</script>    
</head>

<body>
<div data-role="page" class="koker_page member_set_page more_menu">
	<div data-role="header" data-position="fixed" class="join_header">
			<div class="back_btn">
				<a href="#" data-ajax="false" onclick="call_back()" class="relback_btn" id="back_btn"><img src="../img/relback.gif"/></a>
			</div>
			<input type="hidden" value="${memberVo.class_code }" id="class_code">
			<input type="hidden" value="${memberVo.category }" id="category">
			<c:if test="${memberVo.class_code == '02' }"><h1>자재업체</h1></c:if>
			<c:if test="${memberVo.class_code == '03' }"><h1>기술자</h1></c:if>
			<c:if test="${memberVo.class_code == '04' }"><h1>장비업체</h1></c:if>
			<c:if test="${memberVo.class_code == '05' }"><h1>시공업체</h1></c:if>
			<c:if test="${memberVo.class_code == '06' }"><h1>종합</h1></c:if>
			<c:if test="${memberVo.class_code == '07' }"><h1>운송</h1></c:if>
			<div class="ui-btn-right" style="width:18%;margin-top:.2em !important;">
				<!--공유하기버튼 -->
				<a href="#going_popup" data-rel="popup" data-position-to="window" data-transition="pop">
					<img src="../../img/more/going_icon.gif" onclick="share()" style="width:37%; margin-right:.1em; padding-top: 0.2em; vertical-align:middle;"  />
				</a> 
				<a href="#" data-ajax="false">
					<img src="../../img/more/home_icon.gif" onclick="goAppMain()" style="width:40%; vertical-align: middle; margin-right:.1em; padding-top: 0em;"/>
				</a> 
			</div>
	</div>
	<div class="member_set_name color_set_black more_set">
		<c:if test="${memberVo.logo_name == null || memberVo.logo_name == ''}">
			<img class="logo_details" src="../../img/member_set/top_back.jpg">
		</c:if>	
		<c:if test="${memberVo.logo_name != null}">
			<img class="logo_details" src="/upload/img/${memberVo.member_id}/${memberVo.logo_name}">
		</c:if>
				<p class="more_name_p1">${memberVo.koker_name }					    
		
		<c:if test="${memberVo.koker_auth == 'y'}">		
		<div class="mark_inzng"><img src="../img/inzng_mark.png" /></div>
		</c:if>
		</p>
		<p class="more_name_p2">
			<img src="../../img/list/list_star.gif" />${memberVo.review_avg }  
			<img src="../../img/list/list_review.gif" style="margin-left:.5em;" />${memberVo.review_count }
			<c:if test="${not empty memberVo.ranking}">
			<img src="../../img/list/list_rank.gif" style="margin-left:.5em;" />${memberVo.ranking}위
			</c:if>
		</p>
			<c:if test="${memberVo.special_no != null}">
				<img src="../img/more/cap_icon.gif" class="more_cap_img"/>
			</c:if>
	</div>
	<div class="member_set_back" style="height: 7em;"></div>
	<!-- 랭킹 이미지 -->
	<p style="margin:0;" id="rankImage"></p>
		
	<div data-role="content" class="join_content more_content">
	
			<table class="more_area" style="width:100%;">
				<tr>
					<td style="border:none; width:75%;">
						<p>${memberVo.addr01} ${memberVo.addr02 }</p>
					</td>
					<c:if test="${memberVo.class_code != '03'}">
						<td style="background-color:#29A9C8; color:#fff; border-bottom: 0 !important; padding:0 .5em; width: 25%; text-align: center;">
							<p onclick="location.href='detailMap.do?koker_no=${memberVo.koker_no}'"><img src="../../img/more/map_icon2.gif" style="width:1em; margin-right:1em;"/>위치</p>
						</td>
					</c:if>
				</tr>
<%-- 			<p>${memberVo.call_tel01}-${memberVo.call_tel02}-${memberVo.call_tel03}</p> --%>
			</table>
		
			<p style="margin-top: 1em;">전문분야</p>
		<table class="company_table more_table">
			<tr>
				<td>
					<div class="total_type" id="code_name_div" style="text-align: center;">
					</div>
				</td>
			</tr>
		</table>
		
			<p style="margin-top: 1em;">안내</p>
	    <div class="member_set_table more_set_table">
			<div class="ui-grid-a"> 
			    <div class="ui-block-a">
					<label for="work_time" style="padding-top: .3em;">업무시간</label>
				</div> 
			    <div class="ui-block-b" style="width:70% !important;">
					<input readonly="readonly" id="work_time" type="text" value="${memberVo.call_stime} ~ ${memberVo.call_ntime}" style="padding-top:.7em !important;" />
				</div> 
			</div>
			<div class="ui-grid-a"> 
			    <div class="ui-block-a">
					<label for="work_holiday" style="padding-top: .3em;">휴일</label>
				</div> 
			    <div class="ui-block-b" style="width:70% !important;">
					<input readonly="readonly" id="work_holiday" type="text" value="${memberVo.holiday }" style="padding-top:.7em !important;" />
				</div> 
			</div>
			<div class="ui-grid-a"> 
			    <div class="ui-block-a">
					<label for="work_url" style="padding-top: .3em;">홈페이지</label>
				</div> 
			    <div class="ui-block-b" style="width:70% !important;">
			    
			    <c:if test="${(memberVo.koker_url).length() > 4}">
				    <c:choose>
				    	<c:when  test="${(memberVo.koker_url).substring(0,4) == 'http'}">
				    		<a href="${memberVo.koker_url }">
				    			<input readonly="readonly" id="work_url" type="text" value="${memberVo.koker_url }" style="padding-top:.7em !important;"/>
							</a>
				    	</c:when>
				    	<c:otherwise>	
				    		<a href="http://${memberVo.koker_url }">
				    			<input readonly="readonly" id="work_url" type="text" value="${memberVo.koker_url }" style="padding-top:.7em !important;"/>
							</a>    
						</c:otherwise>
					</c:choose>
				</c:if>
				<c:if test="${(memberVo.koker_url).length() <= 4}">
					<a href="http://${memberVo.koker_url }">
		    			<input readonly="readonly" id="work_url" type="text" value="${memberVo.koker_url }" style="padding-top:.7em !important;"/>
					</a> 
				</c:if>
				</div>
				  
			</div>
			<div class=""> 
			    <div class="" style="width:100% !important;">
					<textarea readonly="readonly" style="padding: 1em !important;">${memberVo.koker_content}</textarea>
				</div> 
			</div>
		</div>
			<p style="margin-top: 1em;">갤러리</p>
	    <div class="member_set_table more_set_table" style="text-align:center;">
			<a href="#overlay" data-rel="popup" class="" data-position-to="window">
				<p style="margin:.5em 0 0 0;">
				<c:if test="${memberVo.file01_name != null && memberVo.file01_name != ''}">
					<img src="/upload/img/${memberVo.member_id }/${memberVo.file01_name }" style="width:98px; height:98px;"/>
				</c:if>
				<c:if test="${memberVo.file01_name == null || memberVo.file01_name == ''}">
					<img src="../img/more/no_img.png" width="30%"/>
				</c:if>
				<c:if test="${memberVo.file02_name != null && memberVo.file02_name != ''}">
					<img src="/upload/img/${memberVo.member_id}/${memberVo.file02_name }" style="width:98px; height:98px;"/>
				</c:if>
				<c:if test="${memberVo.file02_name == null || memberVo.file02_name == ''}">
					<img src="../img/more/no_img.png" width="30%"/>
				</c:if>
				<c:if test="${memberVo.file03_name != null && memberVo.file03_name != ''}">
					<img src="/upload/img/${memberVo.member_id }/${memberVo.file03_name }" style="width:98px; height:98px;"/>
				</c:if>
				<c:if test="${memberVo.file03_name == null || memberVo.file03_name == ''}">
					<img src="../img/more/no_img.png" width="30%"/>
				</c:if>
				</p>
			</a>
			<div id="overlay" data-role="popup" data-overlay-theme="b"  data-theme="none" class="ui-content more_set_pop">
				<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:if test="${memberVo.file01_name != null }">
					   		<div class="swiper-slide" style="text-align:center;">
					   		<c:choose>
					   			<c:when test="${memberVo.file03_name != null }">
					   				<p>1/3</p>
					   			</c:when>
					   			<c:when test="${memberVo.file02_name != null }">
					   				<p>1/2</p>
					   			</c:when>
					   			<c:otherwise>
					   				<p>1/1</p>
					   			</c:otherwise>
					   		</c:choose>
								<img src="/upload/img/${memberVo.member_id}/${memberVo.file01_name }" width="90%" />
				            </div>
				        </c:if>
				        
				        <c:if test="${memberVo.file02_name != null }">
					   		<div class="swiper-slide" style="text-align:center;">
							<c:choose>
								<c:when test="${memberVo.file03_name != null }">
					   				<p>2/3</p>
					   			</c:when>
					   			<c:otherwise>
					   				<p>2/2</p>
					   			</c:otherwise>
					   		</c:choose>
								<img src="/upload/img/${memberVo.member_id }/${memberVo.file02_name }" width="90%" />
				            </div>
				         </c:if>
				         
				         <c:if test="${memberVo.file03_name != null }">
					   		<div class="swiper-slide" style="text-align:center;">
					   		<p>3/3</p>
								<img src="/upload/img/${memberVo.member_id }/${memberVo.file03_name }" width="90%" />
				            </div>
			            </c:if>
			        </div>
			    </div>
			</div>
		</div>
			<p style="margin-top: 1em;">질문 답변</p>
				<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != memberVo.member_no}">
					<div id="question" class="more_btn_icon">
						<input type="hidden" value="${memberVo.koker_no }" id="koker_no">
						<p class="more_text_btn"><img src="../img/more/answer_icon.gif" />질문하기</p>
					</div>
				</c:if>
				<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == memberVo.member_no}">
					<div id="answer" class="more_btn_icon">
						<input type="hidden" value="${memberVo.koker_no }" id="koker_no">
						<p class="more_text_btn"><img src="../img/more/answer_icon.gif" />답변하기</p>
					</div>
				</c:if>
	
			<p style="margin-top: 1em;">리뷰</p>
			<div data-role="collapsible" class="more_btn_icon" style="margin-bottom:3em;">
			    <h4 class="more_text_btn" onclick="review_open('koker_no=${memberVo.koker_no }&member_no=${sessionScope.sessionData.memberInfo.getMember_no()}')">
				<p class="more_btn_bg" style="padding:1.5em 0;"></p>
				</h4>
				<div id="review" class="review_star">
				</div>
			</div>
	</div>
	
	<div data-role="footer" data-position="fixed" class="more_footer" style="background:none; margin:0; padding:0;">
		<div class="ui-grid-b cont_box02"> 
<!-- 		    <div class="ui-block-a" style="width: 33.333% !important; padding:0;" id="connect_phone"><p><img src="../img/more/call_icon.gif" style="width:1em;"/>통화</p></div>  -->
<!-- 		    <div class="ui-block-b" style="width: 33.333% !important; padding:0; border-right:solid #fff 1px; border-left:solid #fff 1px;" id="connect_message"><p><img src="../img/list/list_msg_icon.gif" />문자</p></div>  -->
		    <div class="ui-block-a" style="width: 33.333% !important; padding:0;" onclick="doMapping('tel','${memberVo.call_tel01}${memberVo.call_tel02}${memberVo.call_tel03}','${memberVo.koker_no}');"><p><img src="../img/more/call_icon.gif" style="width:1em;"/>통화</p></div> 
		    <div class="ui-block-b" style="width: 33.333% !important; padding:0; border-right:solid #fff 1px; border-left:solid #fff 1px;" onclick="doMapping('sms','${memberVo.call_tel01}${memberVo.call_tel02}${memberVo.call_tel03}','${memberVo.koker_no}');"><p><img src="../img/list/list_msg_icon.gif" />문자</p></div> 
		    <div class="ui-block-c" style="width: 33.333% !important; padding:0; height:46px;">
		    	<p>
			    	<span id=bookMark>
						<c:forEach var="data" items="${bookMark }">
							<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == data.member_no}">
								<img src="../../img/list/list_zzim_on.png" onclick="delete_bookmark_no()"/>						
								<% check_zzim="ok"; %>
							</c:if>					
						</c:forEach>					
							<% if(check_zzim == "no"){ %>
								<img src="../../img/list/list_zzim_off.png" onclick="add_bookmark_no()"/>
							<%} %>
					</span>
			    	찜
	    		</p>
	    	</div> 
		</div>
	</div>		
 		
	<div id="popupDialog" style="max-width: 400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>연결 하시겠습니까?</p>
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>
<!-- 	      	<050 번호 연결> -->
	      	<a  style="background-color:#29A9C8;" onclick="doMapping('tel','${memberVo.call_tel01}${memberVo.call_tel02}${memberVo.call_tel03}','${memberVo.koker_no}');" data-ajax="false" id="confirm">연결</a>
<%-- 	      	<a  style="background-color:#29A9C8;" href="tel:${memberVo.call_tel01}${memberVo.call_tel02}${memberVo.call_tel03}"  data-ajax="false" id="confirm">연결</a>   --%>
	  	</div>    
	</div>
	
	<div id="popupDialog2" style="max-width: 400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>문자를 보내시겠습니까?</p>
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>
<!-- 	      	<050 번호 연결> -->
	      	<a  style="background-color:#29A9C8;" onclick="doMapping('sms','${memberVo.call_tel01}${memberVo.call_tel02}${memberVo.call_tel03}','${memberVo.koker_no}');" data-ajax="false" id="confirm">보내기</a>
<%-- 	      	<a  style="background-color:#29A9C8;" href="tel:${memberVo.call_tel01}${memberVo.call_tel02}${memberVo.call_tel03}"  data-ajax="false" id="confirm">연결</a>   --%>
	  	</div>    
	</div>
		
	 <div id="popupWrite" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>리뷰를 등록 하시겠습니까?</p>  		
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
	      	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="write">등록</a>    
	  	</div>    
	 </div>	
	 	 
	 <div id="popupModify" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false">
       <div class="ui-content review_wright review_star review_modify" role="main">
          <form>
            <label for="slider-2" style="font-size:12px;">평점</label>
				<input name="slider-2" id="review_modify_1" type="range" min="0" max="10" value="" step="1" data-highlight="true">
			</form>
			<input type="text" id="reviewComment_modify" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"
															onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="">
	      	<p class="review_wright_p">
		      	<a class="review_wright_a" href="#" data-rel="back" data-ajax="false">취소</a>   
		      	<a class="review_wright_a" href="#"  data-ajax="false" id="modifyReview">등록</a>    
	      	</p>
        </div>    
    </div>

	 <div id="popupDelete" style="max-width:400px;" data-role="popup" data-overlay-theme="b" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>리뷰를 삭제 하시겠습니까?</p>  		
	      	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>   
	      	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="deleteReview">삭제</a>    
	  	</div>    
	 </div>	
	 
	 <div id="popupAddBookmark" data-role="popup" data-transition="pop" class="kok_pop"  data-ajax="false">
	    <div class="ui-content" role="main">
	    	<img src="../img/more/kok_on.gif" />
	  	</div>    
	 </div>	

	 <div id="popupDeleteBookmark" data-role="popup" data-transition="pop" class="kok_pop"  data-ajax="false">
	    <div class="ui-content" role="main">
	    	<img src="../img/more/kok_off.gif" />
	  	</div>    
	 </div>		

	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>
	 
	 <div id="popupCheck_review" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>리뷰를 입력해 주세요.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>
	 
 <!-- 공유 팝업 -->
	<div data-role="popup" id="popupShare" data-dismissible="false" class="my_menu more_menu_btn">
		<div data-role="header" class="my_menu_header">
			<h1>공유하기</h1>
			<a href="#going_popup" data-rel="close" class="ui-btn ui-corner-all ui-btn-right">
				<img src="../../img/my_menu/going_close.gif" width="60%" style="padding-top: 0.7em;"/>
			</a>
		</div>
		<div class="ui-grid-b more_popup_padding"> 
	      	<p id="share_sms" class="ui-block-a"><img src="../../img/more/upload_sns.gif" /></p>
	      	<p id="share_kakaoTalk" class="ui-block-b"><img src="../../img/more/upload_kt.gif" /></p>
	      	<p id="share_kakaoStory" class="ui-block-c"><img src="../../img/more/upload_ks.gif" /></p>
	      	<p id="share_faceBook" class="ui-block-a"><img src="../../img/more/upload_face.gif" /></p>
	      	<!-- <p id="share_twitter" class="ui-block-b"><img src="../../img/more/upload_twitter.png" /></p> -->
	      	<p id="share_band" class="ui-block-b"><img src="../../img/more/upload_band.png" /></p>
	      	<p id="share_line" class="ui-block-b"><img src="../../img/more/upload_line.png" /></p>
		</div>
	</div>
	
	<input type="hidden" value="${memberVo.koker_name }" id="return_koker_name">
	<input type="hidden" value="${memberVo.addr01 }" id="return_addr01">
	<input type="hidden" value="${memberVo.addr02 }" id="return_addr02">
	<input type="hidden" value="${memberVo.member_no }" id="this_member_no">
	<input type="hidden" value="${memberVo.koker_no }" id="return_koker_no">
	<input type="hidden" value="${memberVo.review_avg }" id="return_review_avg">
	<input type="hidden" value="${memberVo.review_count }" id="return_review_count">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" value="${backCount}" id="backCount">	
</div>
    
</body>
</html>