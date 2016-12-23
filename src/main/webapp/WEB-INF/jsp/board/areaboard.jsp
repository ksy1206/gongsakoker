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



<script type="text/javascript">

window.onload=function getZip_area(){
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
                         var html = "<option value='default' >시 / 도를 선택해주세요.</option>";
                        $.each(data.areaList, function (index, areaList) {
                             
                             html+= " <option value='"+areaList.sido+ "'>"+areaList.sido+ "</option>" ;
                        });
                         //alert(html );
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
                         var html = "<option value='default'  id='default_option'>구 / 군을 선택해주세요.</option>";
                        $.each(data.cityList, function (index, cityList) {
                             html+= " <option value='"+cityList.gugun+ "'>"+cityList.gugun+ "</option>" ;
                        });                        
                   $( "#cityList").html(html);
                   $( "#cityList-button span").html( "구 / 군을 선택해주세요.");                        
                   } else{
                	   
                   }
         }
  });
}

function search(){
	var sido = $("#areaList").val();
	var gugun = $("#cityList").val();
	var category = $("#category").val();
	params = "sido="+sido+"&gugun="+gugun+"&category="+category;
    $.ajax({
        type        : "POST" 
      , async       : false
      , url         : "/areaBoard/search_areaBoard.do"
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
    	  $.each(data.areaBoard, function(index, areaBoard){
    		  
    		  html += "<div onclick='details("+areaBoard.board_no+")'>"
    		  
    		  //타이틀
    		  if(areaBoard.category == 1){
    	    	  html += "<p>현장스토리</p>"
    		  }
    		  if(areaBoard.category == 2){
    	    	  html += "<p>스터디 모임</p>"
    		  } 	
    		  
    		  //타이틀 클릭하면 보여지는 내용들
    		  html += "<p>"+areaBoard.title+"</p>"
    		  html += "<p>"+areaBoard.member_id+"</p>"
    		  html += "</div>";
    	  });
    	  
    	  
    	  if(data.areaBoard == null || data.areaBoard == ""){
    		  html = "<div style='padding-top:2em; text-align:center;'>"
    		  html += "<img src='../img/board/no_search.gif' style='width:40%;'/>";
    		  html += "<p style='text-shadow:none; font-weight:normal !important; color:#666; font-size:14px;'>검색 결과가 없습니다.</p>"
    		  html += "</div>"
    	  }
    	  
    	  $("#list_div").html(html).trigger("create");
//     	  document.getElementById("area_back_cha").style.display = "none";
    	  document.getElementById("default_div").style.display = "none";
      }
});
	
}


function go_move(check){
	
	var member_no = $("#session_member_no").val();
	var member_code = $("#session_member_code").val();
	if(member_no == null || member_no == ""){
		$("#popupCheck_txt").text("로그인이 필요한 서비스입니다.");
		$("#popupCheck").popup("open");
	} else if(member_code == 02 || member_code == ""){
		$("#popupCheck_txt").text("업체인증 완료 후 사용가능합니다.");
		$("#popupCheck").popup("open");
	} 
	else {
		if(check == 1){
			location.href="${pageContext.request.contextPath}/areaBoard/list_areaBoardMain.do?member_no="+member_no;
		} else if(check == 2){
			location.href="${pageContext.request.contextPath}/areaBoard/moveWrite.do";
		}		
	}	
}

function details(board_no){
	alert(board_no);
	location.href="<%=cp%>/areaBoard/areaboard_details.do?board_no="+board_no;
}
</script>
</head>
<div data-role="page" class="board_page area_board_page">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid 1px #29A9C8 !important;">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" class="relback_btn"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#29A9C8 !important;">지역 게시판</h1>
		<a onclick="go_move(1)" data-rel="popup" data-position-to="window" data-transition="pop" class="ui-btn ui-corner-all ui-btn-right" style="background-color:#fff; border:0; padding:.2em 0 0 0;">
			<img src="../img/board/myList.png" class="header_icon" style="width:2em;"/>
		</a>		 
	</div>

	<div class="ui-grid-b">
		<div class="ui-block-a">
			<select id="category">
				<option value="default">카테고리를 선택해 주세요.</option>
				<option value="1">현장 스토리</option>
				<option value="2">스터디모임</option>
			</select>
		</div> 
	    <div class="ui-block-b">
			<select  id="areaList"  onchange="getZip_city()"  >
				<option value="default">시 / 도를 선택해주세요.</option>			  
			</select>
		</div> 
	    <div class="ui-block-c">
			<select id="cityList"  >
				<option value="default">구 / 군을 선택해주세요.</option> 
			</select>
		</div>
	</div>
	
	<div>
		<p>공지사항</p>
	</div>
	
	<div id="default_div">
		<c:forEach var="data" items="${categoryData.category1}">
			<c:if test="${data.title != null}">
				<div onclick="details('${data.board_no}')">
					<div>
						이미지
					</div>
					<div>
						<p>현장스토리</p>
						<p>${data.title}</p>
						<p>${data.member_id} | 추천수</p>
					</div>
				</div>
			</c:if>
		</c:forEach>
		
		<c:forEach var="data" items="${categoryData.category2}">
			<c:if test="${data.title != null}">
				<div onclick="details('${data.board_no}')">
					<div>
						이미지
					</div>
					<div>
						<p>스터디모임</p>
						<p>${data.title}</p>
						<p>${data.member_id} | 추천수</p>
					</div>
				</div>
			</c:if>
		</c:forEach>		
	</div>
	
<!-- 	<div id="area_back_cha" style="padding-top:2em; text-align:center;"> -->
<!-- 		<img src="../img/board/no_tikok.gif" style="width:40%;"/> -->
<!-- 		<p style="text-shadow:none; font-weight:normal !important; color:#666; font-size:14px;">지역 및 카테고리를 선택해 주세요.</p> -->
<!-- 	</div> -->
	
	<div data-role="collapsible-set" id="list_div">
	</div>
	
	<div>
		<a onclick="go_move(2)">
			<img src="../img/board/wright_icon_blue.gif" class="header_icon" style="width:3em;"/>
		</a>
	</div>
	
	
	<div data-role=footer data-position="fixed" class="guide_footer">
		<input type="button" value="검색" onclick="search()">
	</div>
	
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>
      		<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
  		</div>    
 	</div>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_code()}" id="session_member_code">	
</div>

</body>
</html>

