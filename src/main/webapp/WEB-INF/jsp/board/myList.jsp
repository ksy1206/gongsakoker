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
<script type="text/javascript" src="<%=cp %>/js/member/memberJoin.js"></script>
<script type="text/javascript"  src="<%=cp%>/js/jquery.form.js"></script>

<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>

<script type="text/javascript">

// 시 정보 가져오기
function getZip_area(num){
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
                        $( "#areaList_"+num).html(html);
                   } else{
                   }
         }
  });
   
}

// 도시 정보 가져오기
function getZip_city(num){
	var sido = $( "#areaList_"+num+" option:selected").val();
	$("#sido_selected_"+num).val(sido);
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
                   $( "#cityList_"+num).html(html);
                   $( "#cityList_"+num+"-button span").html( "구 / 군을 선택해주세요.");                        
                   } else{
                	   
                   }
         }
  });
}

//글 수정
function board_modify(board_no, nums){
	var category = $("#category_"+nums).val();
	var sponsor = $("#sponsor_"+nums).val();
	var start_date = $("#start_date_"+nums).val();
	var end_date = $("#end_date_"+nums).val();
	var tel = $("#tel_"+nums).val();
	var test = $("#sido_selected_"+nums).val();
	var gugun = $("#cityList_"+nums).val();
	var place = $("#place_"+nums).val();
	var title = $("#title_"+nums).val();
	var content = $("#content_"+nums).val();
	var member_id = $("#session_member_id").val();	
	var member_no = $("#session_member_no").val();
	
	if(test != null |test != ""){
		var sido = $("#sido_selected_"+nums).val();
	}
	if(test == null |test == ""){
		var sido = $("#sido_selected_2_"+nums).val();
	}
	
	if(gugun ==null||gugun ==""||gugun == 'default'){
		$("#popupCheck_txt").text("세부 지역을 선택해 주세요.");
		$("#popupCheck_space").popup("open");
		$("#company_addr").focus();
		return false;
	}
	
	var params = "board_no="+board_no+"&category="+category+"&sponsor="+sponsor+"&start_date="+start_date+"&end_date="+end_date+"&tel="+tel+"&sido="+sido+"&gugun="+gugun+"&place="+place+"&title="+title+"&content="+content;

	$.ajax({
        type        : "POST"  
      , async       : false 
      , url         : "/areaBoard/areaBoard_modify.do"
      , data        : params
      , dataType    : "json" 
      , timeout     : 30000   
      , cache       : false     
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
			alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
      }
      , success     : function(data) {
    	  location.href="${pageContext.request.contextPath}/areaBoard/list_areaBoardMain.do?member_no="+member_no;
      }
	});

}

//글 삭제
function board_delete(board_no){
	var params = "board_no="+board_no;
	var member_no = $("#session_member_no").val();
	$.ajax({
        type        : "POST"  
      , async       : false 
      , url         : "/areaBoard/areaBoard_delete.do"
      , data        : params
      , dataType    : "json" 
      , timeout     : 30000   
      , cache       : false     
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
			alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
      }
      , success     : function(data) {
    	  location.href="${pageContext.request.contextPath}/areaBoard/list_areaBoardMain.do?member_no="+member_no;
      }
	});

}

//글쓰기 페이지 이동
function moveWrite(){
	 location.href="${pageContext.request.contextPath}/areaBoard/moveWrite.do";
}

function localBoard_details(board_no){
	alert(board_no);
}

</script>
</head>
<body>
<div data-role="page" class="board_page" style="background-color:#fff;">
	<div data-role="header" data-position="fixed" class="join_header" style="background-color:#fff !important; border-bottom:solid 1px #29A9C8 !important;">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" class="relback_btn"><img src="../img/more/relback.gif"/></a>
		</div>
		<h1 style="background-color:#fff !important; color:#29A9C8 !important;">내글 리스트</h1>
	</div>
	
	<c:if test="${dataList == '[]'}">
		<div style="padding-top:2em; text-align:center;">
			<img src="../img/board/no_tikok.gif" style="width:40%;"/>
			<p style="text-shadow:none; font-weight:normal !important; color:#666; font-size:18px;">작성한 글이 없습니다.</p>
		</div>
	</c:if>
	
	<div>
	<c:forEach var="data" items="${dataList}">
		<div onclick="localBoard_details('${data.board_no}')">
			<c:if test="${data.category == 1}">
				<p>현장스토리</p>
			</c:if>
			<c:if test="${data.category == 2}">
				<p>스터디모임</p>
			</c:if>
				<p>${data.title}</p>
				<p>${data.member_id}</p>
		</div>

<!-- 			<div data-role="content" class="area_board_content">		 -->
<!-- 				제목 클릭시 아래 보여지는 것들 -->
<!-- 				<div class="ui-grid-a">  -->
<!-- 			    	<div class="ui-block-a"> -->
<!-- 						<p>말머리</p>	 -->
<!-- 					</div>	 -->
<!-- 			    	<div class="ui-block-b"> -->
<%-- 						<select id="category_${num.count}"> --%>
<%-- 							<c:if test="${data.category == 1}"> --%>
<!-- 							<option value="1" selected="selected">자재업체 홍보</option> -->
<!-- 							<option value="2">현장 스토리</option> -->
<%-- 							</c:if> --%>
							
<%-- 							<c:if test="${data.category == 2}"> --%>
<!-- 							<option value="1">자재업체 홍보</option> -->
<!-- 							<option value="2" selected="selected">현장 스토리</option> -->
<%-- 							</c:if> --%>
<!-- 						</select>	 -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="ui-grid-b">  -->
<!-- 			    	<div class="ui-block-a"> -->
<!-- 						<p>지역</p>  -->
<!-- 					</div> -->
<!-- 			    	<div class="ui-block-b" style="width:40% !important; padding-right:.1em;"> -->
<%-- 						<select id="areaList_${num.count}" onclick="getZip_area('${num.count}')" onchange="getZip_city('${num.count}')"> --%>
<%-- 							<option value="${data.sido}">${data.sido}</option> --%>
<!-- 						</select> -->
<!-- 					</div> -->
<%-- 					<input type="hidden" id="sido_selected_${num.count}"> --%>
<%-- 					<input type="hidden" id="sido_selected_2_${num.count}" value="${data.sido}"> --%>
<!-- 			    	<div class="ui-block-c" style="width:40% !important; padding-left:.1em;"> -->
<%-- 						<select id="cityList_${num.count}"> --%>
<%-- 							<option value="${data.gugun}">${data.gugun}</option> --%>
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="ui-grid-a">  -->
<!-- 			    	<div class="ui-block-a"> -->
<!-- 						<p>제목</p>  -->
<!-- 					</div> -->
<!-- 			    	<div class="ui-block-b"> -->
<%-- 						<input type="text" id="title_${num.count}" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  --%>
<%-- 									onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" value="${data.title}"> --%>
<!-- 					</div> -->
<!-- 				</div> -->
				
<!-- 				<div class="ui-grid-a">  -->
<!-- 			    	<div class="ui-block-a"> -->
<!-- 						<p>내용</p>  -->
<!-- 					</div> -->
<!-- 			    	<div class="ui-block-b"> -->
<%-- 						 <textarea id="content_${num.count}" onfocus="if(this.value==this.defaultValue){this.value='';}this.style.color='#686868';"  --%>
<%-- 									onblur="if(this.value==''){this.value=this.defaultValue;this.style.color='#DBDBDB';}" style="resize:none !important;">${data.content}</textarea> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				</div> -->
<!-- 					<div class="ui-grid-a area_list_btn">  -->
<!-- 				    	<div class="ui-block-a"> -->
<%-- 							<p onclick="board_modify('${data.board_no}','${num.count}')">수정</p> --%>
<!-- 						</div> -->
<!-- 				    	<div class="ui-block-b"> -->
<%-- 							<p onclick="board_delete(${data.board_no})" style="background-color:#fff; color:#29A9C8;">삭제</p> --%>
<!-- 						</div> -->
<!-- 					</div> -->

	</c:forEach>
	</div>
	
	<div data-role=footer class="guide_footer" style="background-color: rgba(41, 169, 200, 0.8) !important; position:fixed; bottom:0; left:0; width:100%;" onclick="moveWrite()">
		<p style="text-shadow:none !important; color:#fff; font-weight:normal !important; font-size:14px; font-family:'GodoM' !important;">새글 쓰기</p>	
	</div>	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	
	<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>
</div>
</body>
</html>