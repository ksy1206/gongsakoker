<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


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
<script src="../js/swiper.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
	$("#confirms").click(function(){
		 add_singo();
	});
	
	//문자 공유
	$("#share_sms").click(function(){
		//제목
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 15) {
			printTitle = storyTitle.substring(0, 15);
			printTitle += "..";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "${fieldStoryVo.fs_no}" + ";;;";
		sendMessage += printTitle; //제목
		
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.shareSMS(sendMessage);
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s2 = "iosjavascript://shareSMS" + ";;;" + encodeURIComponent(sendMessage);
			document.location = s2;
		} 	    
		else {
		}
		
	});
	
	//카카오톡 공유
	$("#share_kakaotalk").click(function(){
		var img1 = "${fieldStoryVo.img01}";
		var img2 = "${fieldStoryVo.img02}";
		var img3 = "${fieldStoryVo.img03}";
		var imgsrc = "";
		
		if(img3 != null && img3 != ''){
			imgsrc = "upload/img_fieldStory/"+'${fieldStoryVo.member_no}'+"/"+'${fieldStoryVo.img03}';
		}
		
		if(img2 != null && img2 != ''){
			imgsrc = "upload/img_fieldStory/"+'${fieldStoryVo.member_no}'+"/"+'${fieldStoryVo.img02}';
		}
		
		if(img1 != null && img1 != ''){
			imgsrc = "upload/img_fieldStory/"+'${fieldStoryVo.member_no}'+"/"+'${fieldStoryVo.img01}';
		}
		
		if(imgsrc == null || imgsrc == ""){
			imgsrc = "nil";
		}
		//제목
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 35) {
			printTitle = storyTitle.substring(0, 30);
			printTitle += "...";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "<%=currentUrl%>" + ";;;"; //현재주소
		sendMessage += imgsrc + ";;;"; //이미지
		sendMessage += printTitle; //제목
		
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			
			window.android.shareKakaoTalk(sendMessage);
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s2 = "iosjavascript://shareKakaotalk" + ";;;" + encodeURIComponent(sendMessage);  
	    	document.location = s2;
		} 	    
		else {
		}
		
	});
	//카카오스토리 공유
	$("#share_kakaostory").click(function(){

		var img1 = "${fieldStoryVo.img01}";
		var img2 = "${fieldStoryVo.img02}";
		var img3 = "${fieldStoryVo.img03}";
		var imgsrc = "";
		
		if(img3 != null && img3 != ''){
			imgsrc = "/upload/img_fieldStory/"+'${fieldStoryVo.member_no}'+"/"+'${fieldStoryVo.img03}';
		}
		
		if(img2 != null && img2 != ''){
			imgsrc = "/upload/img_fieldStory/"+'${fieldStoryVo.member_no}'+"/"+'${fieldStoryVo.img02}';
		}
		
		if(img1 != null && img1 != ''){
			imgsrc = "/upload/img_fieldStory/"+'${fieldStoryVo.member_no}'+"/"+'${fieldStoryVo.img01}';
		}
		
		if(imgsrc == null || imgsrc == ""){
			imgsrc = "nil";
		}
		
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 15) {
			printTitle = storyTitle.substring(0, 15);
			printTitle += "..";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "${fieldStoryVo.fs_no}" + ";;;";
		sendMessage += imgsrc + ";;;";;
		sendMessage += printTitle; //제목
		
		var useragent = navigator.userAgent;
		if(useragent.indexOf("CONNECT_BY_KOKER_APP") > -1){
			window.android.shareKakaoStory(sendMessage);
		}
		else if(useragent.indexOf("Connect By iPhone OS") > -1) {
			var s2 = "iosjavascript://shareKakaostory" + ";;;" + encodeURIComponent(sendMessage);;  
    		document.location = s2;
		} 	    
		else {
			//일반Web일 때
		}
		
	});
	//페이스북 공유
	$("#share_facebook").click(function(){
		
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 15) {
			printTitle = storyTitle.substring(0, 15);
			printTitle += "..";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "${fieldStoryVo.fs_no}" + ";;;";
		sendMessage += printTitle; //제목
		
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
		
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 15) {
			printTitle = storyTitle.substring(0, 15);
			printTitle += "..";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "${fieldStoryVo.fs_no}" + ";;;";
		sendMessage += printTitle; //제목
		
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
		
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 15) {
			printTitle = storyTitle.substring(0, 15);
			printTitle += "..";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "${fieldStoryVo.fs_no}" + ";;;";
		sendMessage += printTitle; //제목
		
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
		
		var storyTitle = '${fieldStoryVo.title}';
		var printTitle = "";
		if(storyTitle.length > 15) {
			printTitle = storyTitle.substring(0, 15);
			printTitle += "..";
		}else {
			printTitle = storyTitle;
		}
		
		var sendMessage = "fieldstory" + ";;;";//필드스토리 공유 
		sendMessage += "${fieldStoryVo.fs_no}" + ";;;";
		sendMessage += printTitle; //제목
		
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
});

//댓글 쓰기
function answer_wrtie(){ 
	var fs_no = $("#fs_no").val();
	var member_id = $("#session_member_id").val();
	var member_no = $("#session_member_no").val();
	var ans_content = $("#ans_content").val();
	
	var check_session = $("#session_member_no").val();
	if(check_session == null || check_session == "" || check_session == undefined){
		$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
		$("#popupCheck_space").popup("open");
		return false;			
	} else {
		if(ans_content == "" | ans_content == null | ans_content == "댓글쓰기"){
			$("#popupCheck_txt").text("댓글을 입력해 주세요.");
			$("#popupCheck_space").popup("open");
		} else {
			location.href="<%=cp%>/fieldStory/fieldStory_addAnswer.do?fs_no="+fs_no+"&member_id="+member_id+"&member_no="+member_no+"&ans_content="+ans_content;
		}
	}
	

}

//댓글 수정하는 DIV열기
function answer_modify(ans_no){
	html = "";
	html2 = "";
	var ans_content = $("#ans_content_"+ans_no).val();
	html += "<input type='text' value="+ans_content+" id='ans_content_"+ans_no+"' style='font-family:godom; font-weight:normal; font-size:14px;'>";
	$("#modeify_"+ans_no).html(html).trigger("create");
	html2 += "<p onclick='answer_modify_result("+ans_no+")' style='margin:.5em 0; padding:.5em; font-size:14px; text-align:center; background-color:#29A9C8; color:#fff; font-weight:normal; text-shadow:none;'>수정 완료</p>"
	$("#modeify_"+ans_no+"_2").html(html2).trigger("create");
}

//댓글 수정하기
function answer_modify_result(ans_no){
	var fs_no = $("#fs_no").val();
	var ans_content = $("#ans_content_"+ans_no).val();
	location.href="<%=cp%>/fieldStory/fieldStory_modifyAnswer.do?ans_no="+ans_no+"&ans_content="+ans_content+"&fs_no="+fs_no;
}

//댓글 삭제하기
function answer_delete(ans_no){
	var fs_no = $("#fs_no").val();
	location.href="<%=cp%>/fieldStory/fieldStory_deleteAnswer.do?ans_no="+ans_no+"&fs_no="+fs_no;
}

//추천하기
function add_recommend(){
	
	var fs_no = $("#fs_no").val();
	var member_no = $("#session_member_no").val();
	var member_id = $("#session_member_id").val();
	params = "fs_no="+fs_no+"&member_no="+member_no+"&member_id="+member_id;
	
	if(member_no == null || member_no==''){
		$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
		$("#popupCheck_space").popup("open");
		return false;
	} else {
		 $.ajax({
		        type        : "POST"
		      , async       : false
		      , url         : "/fieldStory/add_recommend_fieldStory.do"
		      , data        : params
		      , dataType    : "json"
		      , timeout     : 30000
		      , cache       : false
		      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
		      , error       : function(request, status, error) {
		       	$( "#dialog_txt").text( "작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
		        $( "#popupDialog").popup( "open");
		      }
		      , success     : function(data) {
		    	  html = "";
		    	  if(data.recommend_check == 'y'){
		    		  html += "<p style='border-top:solid #e9e9e9 1px; border-bottom:solid #e9e9e9 1px; padding:.3em 0; font-size:14px;'><img src='../img/fieldStory/recommendRed_icon.png' onclick='add_recommend()' style='width:1.8em; vertical-align:bottom; margin-right: .5em;'>"+data.recommend_count+"명이 추천합니다.</p>";
		    		  $("#recommend_div").html(html).trigger("create");
		    		  $("#popupCheck_txt").text("추천이 되었습니다.");
		    		  $("#popupCheck_space").popup("open");
		    	  } else if(data.recommend_check == 'n'){
		    		  html += "<p style='border-top:solid #e9e9e9 1px; border-bottom:solid #e9e9e9 1px; padding:.3em 0; font-size:14px;'><img src='../img/fieldStory/recommend_icon.png' onclick='add_recommend()' style='width:1.8em; vertical-align: bottom; margin-right: .5em;' />"+data.recommend_count+"명이 추천합니다.</p>";
		    		  $("#recommend_div").html(html).trigger("create");
		    		  $("#popupCheck_txt").text("추천이 취소되었습니다.");
		    		  $("#popupCheck_space").popup("open");
		    	  }
		      }
			});
	}   
}

//더보기 함수
function more_answer(){
	var fs_no = $("#fs_no").val();
	var startNum = 3;
	var endNum = $("#endNum").val();
	params = "fs_no="+fs_no+"&startNum="+startNum+"&endNum="+endNum;
	
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/fieldStory/more_answer.do"
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
    	  var member_no = $("#session_member_no").val();
    	  var answer_count = $("#answer_count").val();
    	  $("#endNum").val(data.endNum);
    	  if(data.endNum > answer_count){
    		  document.getElementById("more_answer").style.display = "none";
    	  }
		html = "<div>";
		$.each(data.fieldStoryAnswer_more, function(index, fieldStoryAnswer_more){
    		html += "<div class='ui-grid-b' style='border-bottom:solid #e9e9e9 1px; padding-top:.5em;'>";
    		html += "<div class='ui-block-a' style='width:15%; text-align:center;'>";
    		if(fieldStoryAnswer_more.logo_name == null || fieldStoryAnswer_more.logo_name == ''){
    			html += "<img src='../img/community/name_icon.png' style='width:2em; vertical-align: bottom;' />";
    		} else {
    			html += "<img src='/upload/img/"+fieldStoryAnswer_more.member_id+"/"+fieldStoryAnswer_more.logo_name+"' style='width:2em; vertical-align: bottom;' />";
    		}    		
   			html += "</div>";
   			html += "<div class='ui-block-b' style='width:75%;'>";
   			html += "<div id='modeify_"+fieldStoryAnswer_more.ans_no+"'>"
			html += "<input type='hidden' value='"+fieldStoryAnswer_more.ans_content+"' id='ans_content_"+fieldStoryAnswer_more.ans_no+"'>";
			html += "<p style='margin:0 0 .3em 0; font-size:12px;'>"+fieldStoryAnswer_more.ans_content+"</p>";
			html += "<p style='margin:0; font-size:12px;'>"+fieldStoryAnswer_more.koker_name+"<span style='color:#888; font-size:8px; padding-left:.5em;'>"+fieldStoryAnswer_more.ans_insertDate+"</span></p>";
			html += "</div>";
			html += "</div>";
			html += "<div class='ui-block-c' style='width:10%; text-align: center;'>";
			html += "<img src='../img/fieldStory/singo_icon.png' style='width:.8em; vertical-align: bottom; padding-top:.5em;' />";
			html += "</div>";
			html += "<div class='ui-grid-a' style='width:100%;' id='modeify_"+fieldStoryAnswer_more.ans_no+"_2'>";
			if(member_no == fieldStoryAnswer_more.member_no){
				html += "<div class='ui-block-a' style='padding:1em .3em;'>";
				html += "<p onclick='answer_modify("+fieldStoryAnswer_more.ans_no+")' style='text-align:center; margin:0; padding:.5em; border-radius:20px; background-color:#29A9C8; color:#fff; font-weight:normal; text-shadow:none; font-size:12px;'>수정</p>";
				html += "</div>";
				html += "<div class='ui-block-b' style='padding:1em .3em;'>";
				html += "<p onclick='answer_delete("+fieldStoryAnswer_more.ans_no+")' style='text-align:center; margin:0; padding:.5em; border-radius:20px; background-color:#888; color:#fff; font-weight:normal; text-shadow:none; font-size:12px;'>삭제</p>";
				html += "</div>";
			}
			html += "</div>";
			html += "</div>";
		});
		html += "</div>";
		$("#add_more_answer").html(html).trigger("create");	
      }
	});
}

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
//공유하기 ------------

//글 수정
function modify_fieldStory(){
	var fs_no = $("#fs_no").val();
	location.href="<%=cp%>/fieldStory/modify_fieldStory.do?fs_no="+fs_no;
}

//글 삭제
function delete_fieldStory(){
	var fs_no = $("#fs_no").val();
	var returnPage = "fieldStory_main";
	location.href="<%=cp%>/fieldStory/delete_fieldStory.do?fs_no="+fs_no+"&returnPage="+returnPage;
}

//신고하기 팝업
function singo(){
	var report_category = $("input:radio[name='radio-choice-w-6']:checked").val();
	var report_content = $("#sigoTextarea").val();
	
	if(report_category ==null||report_category ==""||report_category == 'default'){
		$("#popupCheck_txt2").text("신고사유를 선택해 주세요.");
		$("#popupCheck_space2").popup("open");
		return false;			
	}
	if(report_content ==null||report_content ==""||report_content == '내용을 입력해 주세요.'){
		$("#popupCheck_txt2").text("내용을 입력해 주세요.");
		$("#popupCheck_space2").popup("open");
		return false;			
	}else {		
		$("#dialog_txt").text("신고 하시겠습니까?");
		$("#popupDialog").popup("open");
	}
}

//신고하기 db등록
function add_singo(){
	
	var fs_no = $("#fs_no").val();
	var member_no = $("#session_member_no").val();
	var report_category = $("input:radio[name='radio-choice-w-6']:checked").val();
	var report_content = $("#sigoTextarea").val();
	var report_grade = $("#check_code").val();
	var ans_no = $("#ans_no").val();
	params = "fs_no="+fs_no+"&member_no="+member_no+"&report_category="+report_category+"&report_content="+report_content+"&report_grade="+report_grade+"&ans_no="+ans_no;
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/fieldStory/add_fieldStorySingo.do"
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
	    	document.getElementById('confirms2').style.display = ""; 
	  		document.getElementById('confirms').style.display = "none";
	  		document.getElementById('cancel2').style.display = "none";
			$("#dialog_txt").text("신고가 완료 되었습니다.");
      		$("#backCount").val("2");
      }
	});
}


//초기화 및 메인 페이지 이동
function move_mainPage(){
	//체크박스 값 초기화
	$("input:radio[name='radio-choice-w-6']").removeAttr("checked");
	$("#radio_1_check").attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
	$("#radio_2_check").attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
	$("#radio_3_check").attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
	$("#radio_4_check").attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
	$("#radio_5_check").attr("class","ui-btn ui-corner-all ui-btn-inherit ui-btn-icon-right ui-first-child ui-radio-off");
	document.getElementById('confirms2').style.display = "none"; 
	document.getElementById('confirms').style.display = "";
	document.getElementById('cancel2').style.display = "";
	//신고사유 내용 초기화
	document.getElementById("sigoTextarea").value="";
	//페이지 이동
	location.href="#mainPage";
}

function check_code(code, ans_no){
	var check_session = $("#session_member_no").val();
	if(check_session == null || check_session == "" || check_session == undefined){
		$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
		$("#popupCheck_space").popup("open");
		return false;			
	} else {
		$("#check_code").val(code);
		$("#ans_no").val(ans_no);
		location.href="#singoPage";
	}	
}

function call_back(){
	var backCount = $("#backCount").val();
	
	if(backCount == "1"){
		history.go(-1);
	} else if(backCount == "2"){
		history.go(-2);
	} else if(backCount == "3"){
		history.go(-3);
	} else if(backCount == "4"){
		history.go(-4);
	}
}

function img_expand(data){
	var member_no = $("#fieldStoryVo_member_no").val();
	if (data == '01'){
		var img01 = $("#img01").val();
		location.href="<%=cp%>/fieldStory/img_expand.do?member_no="+member_no+"&img01="+img01;
	} else if (data == '02'){
		var img02 = $("#img02").val();
		location.href="<%=cp%>/fieldStory/img_expand.do?member_no="+member_no+"&img02="+img02;
	} else if (data == '03'){
		var img03 = $("#img03").val();
		location.href="<%=cp%>/fieldStory/img_expand.do?member_no="+member_no+"&img03="+img03;
	}
}

function iphone_not_ready() {
	alert("아이폰은 업데이트 준비중입니다.");
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
<div data-role="page" class="board_page area_board_page" id="mainPage" style=" background-color:#e9e9e9 !important;">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid 1px #29A9C8 !important;">
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#29A9C8 !important; font-size:16px !important;">현장 스토리</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<img src="../img/fieldStory/share_icon.png" style="width:2em; margin-right: .5em; vertical-align: top; margin-top: .34em;" onclick="share()">	
			<a href="#" id="reset" data-ajax="false" ><img src="../img/header/home.png" onclick="goAppMain()"style="width:2.5em;" /></a>
		</div>
	</div>
	
	<input type="hidden" id="ans_no">
	<input type="hidden" id="check_code">
	<input type="hidden" value="${fieldStoryVo.fs_no}" id="fs_no">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_id()}" id="session_member_id">
	<input type="hidden" value="${endNum}" id="endNum">
	<input type="hidden" value="${fieldStoryVo.answer_count}" id="answer_count">
	<input type="hidden" value="${backCount}" id="backCount">
	
	<!-- 이미지 관련 정보 -->
	<input type="hidden" value="${fieldStoryVo.member_no}" id="fieldStoryVo_member_no">
	<input type="hidden" value="${fieldStoryVo.img01}" id="img01">
	<input type="hidden" value="${fieldStoryVo.img02}" id="img02">
	<input type="hidden" value="${fieldStoryVo.img03}" id="img03">
	
	<div data-role="content" style="padding:.3em;">
		<div style="background-color:#fff;">
			<div class="ui-grid-b">
				<div class="ui-block-a" style="width:20%; padding:.3em;">
					<c:if test="${fieldStoryVo.logo_name == null || fieldStoryVo.logo_name == ''}">
						<img src="../img/fieldStory/logo_noImg.jpg" style="width:3em; vertical-align:middle;">
					</c:if>
					<c:if test="${fieldStoryVo.logo_name != null && fieldStoryVo.logo_name != ''}">
						<img src="/upload/img/${fieldStoryVo.member_id}/${fieldStoryVo.logo_name}" style="width:3em; vertical-align:middle;">
					</c:if>
				</div>
				<div class="ui-block-b" style="width:70%;">
					<p style="margin:1em 0 0 0; font-size:14px;">${fieldStoryVo.title}</p>
					<p style="margin:.3em 0; font-size:11px; color:#888;">${fieldStoryVo.koker_name} | ${fieldStoryVo.sido} ${fieldStoryVo.gugun}</p>
				</div>
				<div class="ui-block-c" style="width:10%; text-align:center; padding:1em 0;">
					<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != fieldStoryVo.member_no}">
						<a href="#" data-transition="slideup" onclick="check_code('01')"><img src="../img/fieldStory/singo_icon.png" style="width:.8em; vertical-align:middle;" ></a>
					</c:if>
					<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == fieldStoryVo.member_no}">
						<div data-role="collapsible-set" data-theme="c" data-content-theme="d">
							<div data-role="collapsible" data-collapsible="true" class="comunity_coll comunity_coll_02 comunity_coll_03">
								<h3>
									<img src="<%=cp%>/img/community/update_insert.png" style="width:.3em; vertical-align: middle;" />
								</h3>
					    		<p onclick="modify_fieldStory()">수정</p>
					    		<p onclick="delete_fieldStory()">삭제</p>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			<textarea style="border:none; box-shadow:none; resize:none; color:#000; font-size:14px; padding:.5em 1em 0 1em;" readonly="readonly">${fieldStoryVo.content}</textarea>
			
			<div style="text-align:center; margin-top:1em;">
				<c:if test="${fieldStoryVo.img01 != null && fieldStoryVo.img01 != ''}">
					<c:if test="${fieldStoryVo.img02 == null || fieldStoryVo.img02 == ''}">
						<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="100%" height="100" onclick="img_expand('01')" />
						</c:if>
						<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="49%" height="100" onclick="img_expand('01')" />
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" width="49%" height="100" onclick="img_expand('02')" />
						</c:if>
					</c:if>
					<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
						<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="49%" height="100" onclick="img_expand('01')"/>
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="49%" height="100" onclick="img_expand('02')"/>
						</c:if>
					</c:if>
					<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
						<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img01}" width="30%" height="100" onclick="img_expand('01')" />
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="30%" height="100" onclick="img_expand('02')" />
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" width="30%" height="100" onclick="img_expand('03')" />
						</c:if>
					</c:if>
				</c:if>
				
				<c:if test="${fieldStoryVo.img01 == null || fieldStoryVo.img01 == ''}">
					<c:if test="${fieldStoryVo.img02 != null && fieldStoryVo.img02 != ''}">
						<c:if test="${fieldStoryVo.img03 == null || fieldStoryVo.img03 == ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="100%" height="100" onclick="img_expand('01')" />
						</c:if>
						<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img02}" width="49%" height="100" onclick="img_expand('01')" />
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" width="49%" height="100" onclick="img_expand('02')" />
						</c:if>
					</c:if>
					<c:if test="${fieldStoryVo.img02 == null || fieldStoryVo.img02 == ''}">
						<c:if test="${fieldStoryVo.img03 != null && fieldStoryVo.img03 != ''}">
							<img src="/upload/img_fieldStory/${fieldStoryVo.member_no}/${fieldStoryVo.img03}" width="100%" height="100" onclick="img_expand('01')"/>
						</c:if>
					</c:if>
				</c:if>
			</div>
			
			<div id="recommend_div" style="margin:1em 0; padding:0 1em;">
				<p style="border-top:solid #e9e9e9 1px; border-bottom:solid #e9e9e9 1px; padding:.3em 0; font-size:14px;">
					<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() == ''}">
						<img src="../img/fieldStory/recommend_icon.png" onclick="add_recommend()" style="width:1.8em; vertical-align: bottom; margin-right: .5em;" />
					</c:if>
					<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != null && sessionScope.sessionData.memberInfo.getMember_no() != ''}">
						<c:if test="${recommend_check == 'y'}">
							<img src="../img/fieldStory/recommend_icon.png" onclick="add_recommend()" style="width:1.8em; vertical-align: bottom; margin-right: .5em;" />
						</c:if>
						<c:if test="${recommend_check == 'n'}">
							<img src="../img/fieldStory/recommendRed_icon.png" onclick="add_recommend()" style="width:1.8em; vertical-align: bottom; margin-right: .5em;" />
						</c:if>
					</c:if>
					${fieldStoryVo.recommend_count}명이 추천합니다.
				</p>
			</div>
			<div style="padding:0 .5em;" class="input_type_more">
				<c:forEach var="answer" items="${fieldStoryAnswer}">
					<div class="ui-grid-b" style="border-bottom:solid #e9e9e9 1px; padding-top:.5em;">
						<div class="ui-block-a" style="width:15%; text-align:center;">
							<c:if test="${answer.logo_name == null || answer.logo_name == ''}">
								<img src="<%=cp %>/img/community/name_icon.png" style="width:2em; vertical-align: bottom;" >
							</c:if>
							<c:if test="${answer.logo_name != null && answer.logo_name != ''}">
								<img src="/upload/img/${answer.member_id}/${answer.logo_name}" style="width:2em; vertical-align: bottom;" >
							</c:if>
						</div>
						<div class="ui-block-b" style="width:75%;">
							<div id="modeify_${answer.ans_no}">			
								<input type="hidden" value="${answer.ans_content}" id="ans_content_${answer.ans_no}">
								<p style="margin: 0 0 .3em 0; font-size:12px;">${answer.ans_content}</p>
								<p style="margin:0; font-size:12px;">${answer.koker_name}<span style="color:#888; font-size:8px; padding-left:.5em;">${answer.ans_insertDate}</span></p>
							</div>
						</div>
						<div class="ui-block-c" style="width:10%; text-align: center;">
							<a href="#" data-transition="slideup" onclick="check_code('02', '${answer.ans_no}')">
								<img src="../img/fieldStory/singo_icon.png" style="width: .8em; vertical-align: bottom; padding-top:.5em;" >
							</a>
						</div>
						<div class="ui-grid-a" style="width:100%;" id="modeify_${answer.ans_no}_2">
							<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == answer.member_no}">
								<div class="ui-block-a" style="padding:1em .3em;">
									<p onclick="answer_modify('${answer.ans_no}')" style="text-align:center; margin:0; padding:.5em; border-radius:20px; background-color:#29A9C8; color:#fff; font-weight:normal; text-shadow:none; font-size:12px;">수정</p>
								</div>
								<div class="ui-block-b" style="padding:1em .3em;">
									<p onclick="answer_delete('${answer.ans_no}')" style="text-align:center; margin:0; padding:.5em; border-radius:20px; background-color:#888; color:#fff; font-weight:normal; text-shadow:none; font-size:12px;">삭제</p>
								</div>
							</c:if>
						</div>
					</div>
				</c:forEach>
			</div>			

			<div id="add_more_answer" class="input_type_more" style="padding:0 .5em;">
			</div>
			
			<c:if test="${fn:length(fieldStoryAnswer) < 1}">
				<p style="font-weight:normal; text-shadow:none; font-size:14px; text-align:center; margin:0; padding:.5em 0; color:#888;"><span style="padding-right:.5em;"></span>등록된 댓글이 없습니다.</p>
			</c:if>
			
			<c:if test="${fn:length(fieldStoryAnswer) >= 3}">
			<div onclick="more_answer()" id="more_answer">
				<p style="font-weight:normal; text-shadow:none; font-size:14px; text-align:center; margin:0; padding:.5em 0; color:#888;"><span style="padding-right:.5em;">∨</span>더보기</p>
			</div>
			</c:if>
		</div>
	</div>

	<div data-role="footer" class="input_margin" data-position="fixed" style="padding:0; background-color:#fff; boder:none !important;">
		<div class="ui-grid-a" style="padding:.5em;">
<!-- 			<div class="ui-block-a" style="width:12% !important;"> -->
<%-- 				<c:if test="${sessionScope.sessionData.memberInfo.getMember_id() == null || sessionScope.sessionData.memberInfo.getMember_id() == ''}"> --%>
<%-- 					<img src="<%=cp %>/img/community/name_icon.png" style="width:2em; vertical-align:bottom;" /> --%>
<%-- 				</c:if> --%>
<%-- 				<c:if test="${sessionScope.sessionData.memberInfo.getMember_id() != null && sessionScope.sessionData.memberInfo.getMember_id() != ''}"> --%>
<%-- 					<img src="<%=cp %>/img/${sessionScope.sessionData.memberInfo.getMember_id()}/${fieldStoryVo.logo_name}" style="width:2em; vertical-align:bottom;" /> --%>
<%-- 				</c:if> --%>
<!-- 			</div> -->
			<div class="ui-block-a" style="width:78% !important; margin-right:2%;">
				<input type="text" id="ans_content" placeholder="댓글쓰기" style="background-color:#e5e5e5; color:#000; text-shadow:none; font-weight:normal; font-size:14px; font-family:'godom';">
			</div>
			<div class="ui-block-b" style="width:20% !important;">
				<p onclick="answer_wrtie()" style="font-weight:normal; text-shadow:none; font-size:14px; margin:0; text-align:center; color:#fff; background-color:#29A9C8; padding:.5em 0;">등록</p>
			</div>
		</div>
	</div>
	
	<!-- 공유 팝업 -->
	<div data-role="popup" id="popupShare" class="my_menu more_menu_btn">
		<div data-role="header" class="my_menu_header">
			<h1>공유하기</h1>
			<a href="#going_popup" data-rel="close" class="ui-btn ui-corner-all ui-btn-right">
				<img src="../../img/my_menu/going_close.gif" width="60%" style="padding-top: 0.7em;"/>
			</a>
		</div>
		<div class="ui-grid-b more_popup_padding"> 
	      	<p id="share_sms" class="ui-block-a"><img src="../../img/more/upload_sns.gif" /></p>
	      	<p id="share_kakaotalk" class="ui-block-b"><img src="../../img/more/upload_kt.gif" /></p>
	      	<p id="share_kakaostory" class="ui-block-c"><img src="../../img/more/upload_ks.gif" /></p>
	      	<p id="share_facebook" class="ui-block-a"><img src="../../img/more/upload_face.gif" /></p>
	      	<!-- <p id="share_twitter" class="ui-block-b"><img src="../../img/more/upload_twitter.png" /></p> -->
	      	<p id="share_band" class="ui-block-b"><img src="../../img/more/upload_band.png" /></p>
			<p id="share_line" class="ui-block-b"><img src="../../img/more/upload_line.png" /></p>
		</div>
	</div>
	
	<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-ajax="false" onclick="move_mainPage()">확인</a>   
  	  	</div>
    </div>
</div>

<!-- 필터 Page -->
<div data-role="page" id="singoPage" class="koker_page" style="background-color:#e5e5e5 !important;">

	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1>신고 하기</h1>
	</div>

	<div data-role="content" style="padding:0 1em 1em 1em; background:#e5e5e5;">
		<p>신고사유</p>
		<div style="border:solid #29A9C8 1px; padding:1em; background-color:#fff;">
			<fieldset data-role="controlgroup" data-iconpos="right" class="radio_set2">
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6a" value="불법 정보">
		        <label id="radio_1_check" for="radio-choice-w-6a" style="border-bottom:solid 1px #e5e5e5 !important;">불법 정보</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6b" value="음란성 / 선정성">
		        <label id="radio_2_check" for="radio-choice-w-6b" style="border-bottom:solid 1px #e5e5e5 !important;">음란성 / 선정성</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6c" value="욕설 / 인신공격">
		        <label id="radio_3_check" for="radio-choice-w-6c" style="border-bottom:solid 1px #e5e5e5 !important;">욕설 / 인신공격</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6d" value="같은 내용의 반복 게시 (도배)">
		        <label id="radio_4_check" for="radio-choice-w-6d" style="border-bottom:solid 1px #e5e5e5 !important;">같은 내용의 반복 게시 (도배)</label>
		        
		        <input type="radio" name="radio-choice-w-6" id="radio-choice-w-6e" value="기타">
		        <label id="radio_5_check" for="radio-choice-w-6e">기타</label>
		        <textarea placeholder="내용을 입력해 주세요." style="resize:none;" id="sigoTextarea"></textarea>
		    </fieldset>
		</div>
	</div>
	
    <div id="popupCheck_space2" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt2"></p>
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>
  	  	</div>
    </div>

	<div id="popupDialog" class="board_footer_popup" style="max-width: 400px; box-shadow:0 0 0 #fff !important;" data-role="popup" data-overlay-theme="b" data-dismissible="false">
	    <div class="ui-content" role="main">
			<p id="dialog_txt"></p>
     	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" id="cancel2">취소</a>
     	  	<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirms" >확인</a>
     	  	<a style="background-color:#d7d7d7; margin-right:.5em; display: none;" href="#"  onclick="move_mainPage()" data-ajax="false" id="confirms2">확인</a>
	   	</div>
	 </div>
	
	<div data-role="footer" data-position="fixed" style="text-align: center; margin:0;">
		<div class="ui-grid-a">
			<div class="ui-block-a" style="padding:1em .5em 1em 1em;">
				<p style="margin:0; padding:1em; background-color:#666; text-align: center; color:#fff; text-shadow:none !important; font-size:18px; font-weight:normal !important; cursor:pointer;" onclick="move_mainPage()" >취소</p>
			</div>
			<div class="ui-block-b" style="padding:1em 1em 1em .5em;">
				<p style="margin:0; padding:1em; background-color:#29A9C8; text-align: center; color:#fff; text-shadow:none !important; font-size:18px; font-weight:normal !important; cusor:pointer;" onclick="singo()" >신고</p>
			</div>
		</div>
	</div>
	
</div>

</body>
</html>