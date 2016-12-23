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
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>
<script type="text/javascript">

window.onload=function myList(){
	var member_no= $("#member_no").val();
	params = "member_no="+member_no;
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/fieldStory/move_myList_search.do"
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
    	  $.each(data.my_fieldStory_list, function(index, my_fieldStory_list){
    		  html += "<div style='border:solid 1px #e9e9e9; padding:.3em; background-color:#fff; margin-bottom:.3em;'>"
//     		  html += "<p>"+my_fieldStory_list.title+"<img src='../img/fieldStory/modifyAndDelete_icon.png' onclick='open_popup()' style='float:right; margin-right: 1em;'></p>"
    		  html += "<div class='ui-grid-a'>"
    		  html += "<div class='ui-block-a' onclick='details("+my_fieldStory_list.fs_no+")' style='width:90%;'>"
   			  html += "<p style='margin:.5em 0; padding-left:.5em;'>"+my_fieldStory_list.title+"</p>"
    		  html += "</div>"
   		 	  html += "<div class='ui-block-b' style='width:10%; text-align:center;'>"
    		  html += "<img src='../img/fieldStory/modifyAndDelete_icon.png' onclick='open_popup("+my_fieldStory_list.fs_no+")' style='width:.3em; margin-top: .5em;'>"
       		  html += "</div>"
    		  html += "</div>"
    		  html += "<div class='ui-grid-b' style=' padding:.5em;' onclick='details("+my_fieldStory_list.fs_no+")'>"
       		  html += "<div class='ui-block-a' style='width:35% !important;'>"
       		  html += "<p style='font-size:12px; margin:0; line-height: 24px;'>["+my_fieldStory_list.sido+" "+my_fieldStory_list.gugun+"]</p>"
       		  html += "</div>";
       		  html += "<div class='ui-block-b' style='width:45%; !important'>"
       		  html += "<div class='ui-grid-b'>"
   	 	 	  html += "<div class='ui-block-a' style='width:33.333% !important;'>"
   	 	 	  if(my_fieldStory_list.logo_name == null || my_fieldStory_list.logo_name == ""){
   	 	 		html += "<p style='font-size:8px; margin:0;'><img src='../img/fieldStory/list_logoImg.jpg' style='width:2em; vertical-align:bottom; margin-right:.2em;' />"+my_fieldStory_list.koker_name+"</p>"
   	 	 	  } else if(my_fieldStory_list.logo_name != null && my_fieldStory_list.logo_name != ""){
   	 	 		html += "<p style='font-size:8px; margin:0;'><img src='/upload/img/"+my_fieldStory_list.member_id+"/"+my_fieldStory_list.logo_name+"' style='width:2em; vertical-align:bottom; margin-right:.2em;' />"+my_fieldStory_list.koker_name+"</p>"
   	 	 	  }       		  
      		  html += "</div>";
   	 	 	  html += "<div class='ui-block-b' style='width:33.333% !important;'>"
       		  html += "<p style='font-size:8px; margin:0;'><img src='../img/fieldStory/recommend_icon.png' style='width:2em; vertical-align:bottom; margin-right:.2em;' />"+my_fieldStory_list.recommend_count+"</p>"
      		  html += "</div>";
   	 	 	  html += "<div class='ui-block-c' style='width:33.333% !important;'>"
      		  html += "<p style='font-size:8px; margin:0;'><img src='../img/fieldStory/answer_icon.png' style='width:2em; vertical-align:bottom; margin-right:.2em;' />"+my_fieldStory_list.answer_count+"</p>"
     		  html += "</div>";
     		  html += "</div>";
      		  html += "</div>";
       		  html += "<div class='ui-block-c' style='width:20%; !important'>"
       		  html += "<p style='font-size:8px; color:#888; margin:0; line-height: 24px; float:right;'>"+(my_fieldStory_list.insertDate).substring(2,10)+"</p>"
      		  html += "</div>";
       		  html += "</div>";
       		  html += "</div>";
    	  });    	  
    	  
    	  if(data.my_fieldStory_list == null || data.my_fieldStory_list == ""){
    		  html = "<div style='padding-top:2em; text-align:center;'>"
    		  html += "<img src='../img/board/no_search.gif' style='width:40%;'/>";
    		  html += "<p style='text-shadow:none; font-weight:normal !important; color:#666; font-size:14px; margin:0;'>작성한 글이 없습니다.</p>"
    		  html += "</div>"
    	  }
    	  
    	  $("#list_div").html(html).trigger("create");
//     	  document.getElementById("area_back_cha").style.display = "none";
      }
	});
}

function details(fs_no){
	location.href="<%=cp%>/fieldStory/move_details.do?fs_no="+fs_no+"&backCount=1";
}

function open_popup(fs_no){
	$("#target_fs_no").val(fs_no);
	$("#popup_modifyDelete").popup("open");
}

//글 수정
function modify_fieldStory(){
	var fs_no = $("#target_fs_no").val();
	location.href="<%=cp%>/fieldStory/modify_fieldStory.do?fs_no="+fs_no;
}

//글 삭제
function delete_fieldStory(){
	var fs_no = $("#target_fs_no").val();
	var member_no= $("#member_no").val();
	var returnPage = "fieldStory_myList";
	location.href="<%=cp%>/fieldStory/delete_fieldStory.do?fs_no="+fs_no+"&returnPage="+returnPage+"&member_no="+member_no;
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
</script>
</head>
<body>

<!-- 메인 Page -->
<div data-role="page" class="board_page area_board_page" id="mainPage" style="background-color: #e9e9e9 !important;">
	<div data-role="header" data-position="fixed" class="join_header" style="border:none !important;">
		<div class="back_btn">
			<a href="#" data-ajax="false" class="relback_btn" onclick="call_back()"><img src="../img/relback.gif"/></a>
		</div>
		<h1 style="">내가 쓴 글</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false"><img src="../../img/more/home_icon.gif" style="width:2.5em;" /></a>
		</div>
	</div>
	
	<input type="hidden" value="${member_no}" id="member_no">
	<input type="hidden" value="${backCount}" id="backCount">
	
	<div id="list_div" style="padding:.3em;">
	</div>
	
	<div id="popup_modifyDelete" style="min-width:200px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
    		<input type="hidden" id="target_fs_no">
    		<div class="ui-grid-a">
    			<div class="ui-block-a" style="width:50% !important;">
    				<p onclick="modify_fieldStory()" style="text-align:center; margin:.5em 0 1.5em 0 !important;">수정하기</p>
    			</div>
    			<div class="ui-block-b" style="width:50% !important;">
    				<p onclick="delete_fieldStory()" style="text-align:center; margin:.5em 0 1.5em 0 !important; color:#888 !important;">삭제하기</p>
    			</div>
    		</div>
      	  	<a style="background-color:#d7d7d7; margin-right:.5em; font-size:16px;" href="#" data-rel="back" data-ajax="false">취소</a>
  	  	</div>
    </div>
	
</div>



</body>
</html>