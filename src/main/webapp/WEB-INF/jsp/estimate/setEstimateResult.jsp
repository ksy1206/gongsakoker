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

function chose(){	
	var setEst_no = $("input[name=setEst]:checked").val();
	if(setEst_no == undefined || setEst_no == null || setEst_no == ""){
		$("#popupCheck_txt").text("견적을 선택해 주세요.");
		$("#popupCheck_space").popup("open");
		return false;
	} else {
		$("#popup_txt").text("선택하시겠습니까?");
		$("#popup_txt2").text("※ 견적금액은 예상가이며 정확한 금액은 업체와 협의하시길 바랍니다.");
		$("#popupCheck").popup("open");
	}	
}
function confirm(){
	var est_no = $("#est_no").val();
	var setEst_no = $("input[name=setEst]:checked").val();
	location.href="<%=cp%>/estimate/setEstimateChoice.do?setEst_no="+setEst_no+"&est_no="+est_no;
}

function goBusiness_details(koker_no){
	location.href="<%=cp%>/kokkok20/kokkok20_details.do?koker_no="+koker_no+"&backCount=1";
}

function call_back(){
	history.go(-1);
}
</script>
</head>
<body>
<div data-role="page">
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1 style="font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">맞춤견적</h1>		
	</div>
	
	<div data-role="content" style="padding: .7em;">
		<input type="hidden" value="${est_no}" id="est_no">
		<c:forEach var="data" items="${list}">
			<div style="border:solid 1px #29A9C8; background-color:#fff; margin-bottom:.5em;">
				<div class="set_est_sub">
					<div class="ui-grid-a set_est_text">
						<div class="ui-block-a" style="width:15%;">
							
								<c:if test="${est_state == 'y' }">
									<label for="setEst" style="padding:1.23em; background-color:#fff; border-radius:0;">					
										<c:if test="${data.setEst_no == check_setEst_no}">
											<input type="radio" name="setEst" value="${data.setEst_no}" checked="checked" disabled="disabled"/>
										</c:if>
										<c:if test="${data.setEst_no != check_setEst_no}">
											<input type="radio" name="setEst" value="${data.setEst_no}" disabled="disabled"/>
										</c:if>
									</label>
								</c:if>
								<c:if test="${est_state == 'n' }">
									<label for="setEst" style="padding:1.23em; background-color:#fff; border-radius:0;">	
										<c:if test="${data.setEst_no != check_setEst_no}">
											<input type="radio" name="setEst" value="${data.setEst_no}" />
										</c:if>
									</label>
								</c:if>
						</div>
						<div class="ui-block-b" style="width:85%;">
							<p style="margin:.8em 0 0 .5em; font-size:16px !important;">${data.koker_name}<img src="../img/estimate/moveKoker_info.png" onclick="goBusiness_details('${data.koker_no}')"></p>
							<p style="font-size:8px !important;	margin:.5em 0 0 .5em;">${data.setEst_insertDate.substring(0,10)}</p>
						</div>
					</div>
					<div class="ui-grid-a set_est_text">
						<div class="ui-block-a" style="width:20%; padding-left:.5em;">
							<p style="margin:.5em 0 0 0;">견적가</p>
						</div>
						<div class="ui-block-b" style="width:80%;">
							<p style="margin:.3em 0 0 0; font-size:16px !important; color:#dd0e00;">${data.setEst_price}<span style="margin-left:.5em; font-size:12px; color:#666;">만원</span></p>
						</div>
					</div>
						<textarea readonly="readonly" style="margin:.5em 0 0 .3em;">${data.setEst_content}</textarea>
				</div>
			</div>
		</c:forEach>
	</div>
	
	<c:if test="${est_state == 'n' }">
		<div data-role="footer" onclick="chose()" data-position="fixed" class="more_footer" style="opacity: .8;">
			<p><img src="../img/estimate/chose.gif" style="vertical-align:middle; width:1em; margin-right:.5em;"/>견적 선택</p>
		</div>	
	</c:if>
	<c:if test="${est_state == 'y' }">
		<div data-role="footer" onclick="" data-position="fixed" class="more_footer" style="opacity: .8;">
			<p><img src="../img/estimate/chose.gif" style="vertical-align:middle; width:1em; margin-right:.5em;"/>견적 완료</p>
		</div>	
	</c:if>
	
	<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" data-overlay-theme="b" class="board_footer_popup est_pop_text">
    	<div class="ui-content" role="main">
			<p id="popupCheck_txt" style="border: none !important; margin: 1em 0 !important; font-size: 14px;"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em; padding: .5em 2em !important; font-size: 14px; font-family: 'godom'; text-shadow: none !important; font-weight: normal !important" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>
    
    <div id="popupCheck" style="width:250px !important;" data-role="popup" data-dismissible="false" data-overlay-theme="b" class="board_footer_popup est_pop_text">
    	<div class="ui-content" role="main">
			<p style="border: none !important; margin:0 !important; font-size: 18px;" id="popup_txt"></p>
			<p style="border: none !important; margin: 1em 0 !important; font-size: 14px; color:#666 !important;" id="popup_txt2"></p>
			<a style="background-color:#d7d7d7; margin-right:.5em; padding: .5em 2em !important; font-size: 14px; font-family: 'godom'; text-shadow: none !important; font-weight: normal !important" href="#" data-rel="back" data-ajax="false">취소</a>
			<a style="background-color:#29A9C8; margin-right:.5em; padding: .5em 2em !important; font-size: 14px; font-family: 'godom'; text-shadow: none !important; font-weight: normal !important" href="#"  data-ajax="false" onclick="confirm()">확인</a>  
  	  	</div>    
    </div>
	
</div>
</body>
</html>