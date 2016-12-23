<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%  
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=320, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<link rel="stylesheet" href="../css/koker_mobile.css">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("#submit").click(function(){
		var setEst_price = $("#setEst_price").val();
		var setEst_content = $("#setEst_content").val();
		
		if(setEst_price ==null||setEst_price ==""||setEst_price == 'default'){
			$("#popupCheck_txt").text("견적가를 입력해 주세요.");
			$("#popupCheck_space").popup("open");
			return false;
		} else if(setEst_content ==null||setEst_content ==""||setEst_content == 'default'){
			$("#popupCheck_txt").text("견적 내용을 입력해 주세요.");
			$("#popupCheck_space").popup("open");
			return false;
		} else {			
			$("#popup_txt").text("제출하시겠습니까?");
			$("#popupCheck").popup("open");
		}
	});
	
	$("#confirm").click(function(){
		var member_no = $("#session_member_no").val();
		var setEst_price = $("#setEst_price").val();
		var setEst_content = $("#setEst_content").val();
		var est_no = $("#est_no").val();
		var params = "setEst_price="+setEst_price+"&setEst_content="+setEst_content+"&est_no="+est_no+"&member_no="+member_no;
		$.ajax({
	        type        : "POST"  
	      , async       : false 
	      , url         : "<%=cp%>/estimate/setEstimate.do"
	      , data        : params
	      , dataType    : "json" 
	      , timeout     : 30000   
	      , cache       : false     
	      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
	      , error       : function(request, status, error) {
				alert("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");       
	      }
	      , success     : function(data) {
				var est_no = $("#est_no").val();
				var member_no = $("#session_member_no").val();
				location.href="<%=cp%>/estimate/estimateSubmit.do?est_no="+est_no+"&member_no="+member_no+"&backCount=3";

	      }
    	});
	});
});

function goBusiness_details(koker_no){
	location.href="<%=cp%>/kokkok20/kokkok20_details.do?koker_no="+koker_no+"&backCount=1";
}

function setDelete(setEst_no){
	var est_no = $("#est_no").val();
	var member_no = $("#session_member_no").val();
	
	$("#popup_txt2").text("삭제하시겠습니까?");
	$("#popupCheck2").popup("open");		
	
	$("#confirm2").click(function(){
		location.href="<%=cp%>/estimate/estimateSetDelete.do?setEst_no="+setEst_no+"&member_no="+member_no+"&est_no="+est_no;
	});
}

function call_back(){
	var backCount = $("#backCount").val();
	if (backCount == "1"){
		history.go(-1);
	} else if (backCount == "2"){
		history.go(-2);
	} else if (backCount == "3"){
		history.go(-3);
	}
}

function est_cost_check(){
	var est_cost = $("#setEst_price").val();
	if (est_cost == 0 ){
		$("#setEst_price").val(0);
	} else {
		
	}
}

</script>
</head>
<body>
<div data-role="page">
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1 style="font-size:14px; font-weight:normal; text-shadow:none; font-family:'godom';">맞춤견적</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<a href="#" data-ajax="false"><img src="../img/estimate/submit.gif" style="width:1.5em; padding-top:.4em;"/></a>
		</div>
	</div>
	
	<input type="hidden" id="backCount" value="${backCount}">
	
	<div data-role="content">
	<c:if test="${check == 'n'}">
		<div class="est_submit_text">
			<div class="ui-grid-b">
				<div class="ui-block-a" style="width:25%;">
					<p style="font-size:16px !important;">견 적 가 </p>
				</div>
				<div class="ui-block-b" style="width:60%;">
					<input type="number" id="setEst_price" onchange="est_cost_check()">
				</div>
				<div class="ui-block-c" style="width:15%;">
					<p style="font-size:12px !important; margin: 2em 0 0 .5em;">만원</p>
				</div>
			</div>
			<div>
				<p>상세내용</p>
			</div>
			<div>
				<textarea id="setEst_content"></textarea>
			</div>
			<p style="color:#888; font-size:10px !important;">- 내용 작성 시 개인정보가 포함되지 않도록 유의하시기 바랍니다.</p>
			<p style="color:#888; font-size:10px !important;">- 부적절한 견적, 내용은 관리자에 의해 사전동의 없이 삭제될 수 있습니다.</p>
			<p style="color:#888; font-size:10px !important;">- 견적 금액은 예상가이며, 분야별 자재선택은 의뢰자와 협의 후 재조정 바랍니다.</p>
		</div>
		<div style="background-color:#29A9C8; padding:.3em 0; margin:1em 0;" id="submit">
			<p style="color:#fff; font-size:14px; font-weight:normal; text-shadow:none; font-family:'godom'; text-align:center;">제출하기</p>
		</div>
	</c:if>
	
	<div data-role="content" style="padding: .7em;">
		<c:if test="${check == 'y'}">
			<div style="border:solid 1px #29A9C8; background-color:#fff; margin-bottom:.5em;">
				<div class="set_est_sub">
					<div class="ui-grid-a set_est_text">
						<div class="ui-block-a" style="width:85%;">
							<p style="margin:.5em 0 0 .5em; font-size:16px !important;">${estimateVo.koker_name}<img src="../img/estimate/moveKoker_info.png" onclick="goBusiness_details('${estimateVo.koker_no}')"></p>
							<p style="font-size:8px !important;	margin:.5em 0 0 .5em;">${estimateVo.setEst_insertDate.substring(0,10)}</p>
						</div>
						<div class="ui-block-b" style="width:15%;">
							<img src="../img/estimate/setEstimate_delete.gif" align="right" onclick="setDelete('${estimateVo.setEst_no}')" style="width:1em; padding-top:.3em;" />
						</div>
					</div>
					<div class="ui-grid-a set_est_text">
						<div class="ui-block-a" style="width:20%; padding-left:.5em;">
							<p style="margin:.5em 0 0 0;">견적가</p>
						</div>
						<div class="ui-block-b" style="width:80%;">
							<p style="margin:.3em 0 0 0; font-size:16px !important; color:#dd0e00;"> ${estimateVo.setEst_price}<span style="margin-left:.5em; font-size:12px; color:#666;">만원</span></p>
						</div>
					</div>
					<textarea readonly="readonly" style="margin:.5em 0 0 .3em;">${estimateVo.setEst_content}</textarea>
				</div>
			</div>
		</c:if>
		<p style="font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; text-align:center;">*다른 업체의 견적제시 글은 확인할 수 없습니다.</p>
	</div>
	
	<input type="hidden" id="session_member_no" value="${sessionScope.sessionData.memberInfo.getMember_no()}">
	<input type="hidden" value="${est_no}" id="est_no">
	
	</div>
	
	<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup est_pop_class" data-overlay-theme="b">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>
	
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup est_pop_class" data-overlay-theme="b">
    	<div class="ui-content" role="main">
			<p id="popup_txt"></p>
			<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>
			<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirm">완료</a>  
  	  	</div>    
    </div>
    
    <div id="popupCheck2" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup est_pop_class" data-overlay-theme="b">
    	<div class="ui-content" role="main">
			<p id="popup_txt2"></p>
			<a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">취소</a>
			<a style="background-color:#29A9C8;" href="#"  data-ajax="false" id="confirm2">완료</a>  
  	  	</div>    
    </div>
	
</div>
</body>
</html>