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

function type_code(data){
	var estType01_code = data;
	var type01 = "";
	var type02 = "all";
	if(data == 1){
		type01 = "1";
	} else if(data == 2){
		type01 = "2";
	}
	location.href="<%=cp%>/estimate/mainList.do?estType01_code="+estType01_code+"&type01="+type01+"&type02="+type02;
}


function est_sate(data){
	var estType01_code = $("#estType01_code").val();
	var est_state = data;
	var type01=$("#type01").val();
	var type02 = "";
	if(data == 'all'){
		est_state = '';
		type02 = "all";
	} else if(data == 'n'){
		type02 = "n";
	} else if(data == 'y'){
		type02 = "y";
	} 
	location.href="<%=cp%>/estimate/mainList.do?estType01_code="+estType01_code+"&est_state="+est_state+"&type01="+type01+"&type02="+type02;
}

function search(){
	location.href="<%=cp%>/estimate/search.do";
}

function myList(){
	var member_no = $("#member_no_session").val();
	
	if(member_no == null || member_no == "" || member_no == undefined){
	$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
	$("#popupCheck_space").popup("open");
	return false;
	} else {
		location.href="<%=cp%>/estimate/myList.do?member_no="+member_no+"&est_state=n";
	}
}

function moveWrite(){
	var member_no = $("#member_no_session").val();
	
	if(member_no == null || member_no == "" || member_no == undefined){
	$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
	$("#popupCheck_space").popup("open");
	return false;
	} else {
		location.href="<%=cp%>/estimate/estimateCustom.do";
	}
}

function estimateDetails(est_no){
	var member_no = $("#member_no_session").val();
	if(member_no == null || member_no == "" || member_no == undefined){
		$("#popupCheck_txt").text("로그인 후 이용 가능 합니다.");
		$("#popupCheck_space").popup("open");
		return false;
		} else {
			location.href="<%=cp%>/estimate/estimateDetails.do?est_no="+est_no+"&member_no="+member_no;
		}	
}
</script>
<script type="text/javascript">
window.onload=function click_btn(){
	var type01 = $("#type01").val();
	if(type01 == 1){
		$("#btn").addClass("check_blue");
	} else if(type01 == 2){
		$("#btn02").addClass("check_blue");
	}
	var type02 = $("#type02").val();
	if(type02 == 'all'){
		$("#btn03").addClass("check_blue");
// 		 document.getElementById('type02_div').style.display = '';
	} else if(type02 == 'n'){
		$("#btn04").addClass("check_blue");
// 		document.getElementById('type02_div').style.display = '';
	} else if(type02 == 'y'){
		$("#btn05").addClass("check_blue");
// 		document.getElementById('type02_div').style.display = '';
	}
};

function mySetEstimate(){
	var member_no = $("#member_no_session").val();
	location.href="<%=cp%>/estimate/mySet_estimate.do?member_no="+member_no+"&est_state=n";	
}

function call_back(){
	location.href="<%=cp%>/appMain/appMain.do";	
}
</script>
</head>
<body>
<div data-role="page" style="background-color:#fff;">
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn">
				<img src="../img/search/back_icon.gif"/>
			</a>
		</div>
		<h1 style="font-family:'godom'; font-size:18px !important; font-weight:normal !important; text-shadow:none !important; padding:.5em 0;">맞춤견적</h1>
		<div class="ui-btn-right" style="padding-bottom:.3em;">		 
			<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != null}">
				<c:if test="${sessionScope.sessionData.memberInfo.getClass_code() != '01'}">
					<a data-rel="popup" data-position-to="window" data-transition="pop" style="color:#21B4D6; margin-right:.3em;">
						<img src="../img/estimate/view.png" style="width:3em; margin-right:.2em; vertical-align:bottom;" onclick="mySetEstimate()" data-ajax="false" />
					</a>
				</c:if>
			</c:if>
			<img src="../img/fieldStory/search.png" style="width:3em; margin-right:.2em; vertical-align:bottom;" onclick="search()"  data-ajax="false" />  
			<span style="font-size:24px; font-family:'godom';" onclick="myList()" data-ajax="false">MY</span>
		</div>
	</div>
	
	<input type="hidden" value="${estType01_code}" id="estType01_code">
	<input type="hidden" value="${type01}" id="type01">
	<input type="hidden" value="${type02}" id="type02">
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no_session">	
	
	<div class="ui-grid-a" style="border-top:solid 1px #29A9C8; background-color:#fff; box-shadow:0 0 10px 2px #888;">
		<div class="ui-block-a" id="btn" onclick="click_btn()">
			<p onclick="type_code(1)" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">주거공간</p>
		</div>
		<div class="ui-block-b" id="btn02" onclick="click_btn()">
			<p onclick="type_code(2)" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">상업공간</p>
		</div>
	</div>
	
	<div class="ui-grid-b" style="padding:.3em 0; " id="type02_div">
		<div class="ui-block-a" style="padding:0 .2em 0 .5em;" onclick="click_btn()">
			<p onclick="est_sate('all')" id="btn03" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; border:solid 1px #ccc; border-radius:5px; padding:.5em 0;">전체</p>
		</div>
		<div class="ui-block-b" style="padding:0 .2em 0;" onclick="click_btn()">
			<p onclick="est_sate('n')" id="btn04" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; border:solid 1px #ccc; border-radius:5px; padding:.5em 0;">진행중</p>
		</div>
		<div class="ui-block-c" style="padding:0 .5em 0 .2em;" onclick="click_btn()">
			<p onclick="est_sate('y')" id="btn05" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; border:solid 1px #ccc; border-radius:5px; padding:.5em 0;">견적완료</p>
		</div>
	</div>	
	
	<div data-role="content" style="padding:0 1em;">
		<c:if test="${empty list }">
			<div style='padding-top:2em; text-align:center;'>
	    		 <img src='../img/estimate/select_tikok.gif' style='width:40%;'/>
	    		 <p style="text-shadow:none; font-family:'godom'; font-weight:normal !important; color:#666; font-size:14px;">작성된 견적이 없습니다.</p>
			</div>
		</c:if>
		<c:forEach var="data" items="${list}">
			<div class="ui-grid-a" style="border:solid 1px #e5e5e5; padding:.3em; position:relative; margin-bottom:.5em;" onclick="estimateDetails('${data.est_no}')">
				<div class="ui-block-a" style="width:30%;">
					<c:if test="${empty data.est_img01}">
						<img src="../img/list/list_bg.jpg" style="width:100%; height: 6.4em;"/>
					</c:if>
					<c:if test="${not empty data.est_img01}">
						<img src="../upload/img_estimate/${data.member_no}/${data.est_img01}" style="width:100%; height: 6.4em;"/>
					</c:if>	
				</div>
				<div class="ui-block-b estimate_text" style="width:70%;">
					<p style="font-size:16px;">
						<c:if test="${data.estType01_code == 1}">
							<c:if test="${data.estType02_code == '01'}">
								아파트 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '02'}">
								주상복합 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '03'}">
								오피스텔 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '04'}">
								빌라/연립 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '05'}">
								기타 | ${data.est_area}m<sup>2</sup>
							</c:if>
						</c:if>
						<c:if test="${data.estType01_code == 2}">
							<c:if test="${data.estType02_code == '01'}">
								사무공간 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '02'}">
								식당/요리 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '03'}">
								학원/교육 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '04'}">
								병원/의료 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '05'}">
								매장/상업 | ${data.est_area}m<sup>2</sup>
							</c:if>
							<c:if test="${data.estType02_code == '06'}">
								체육기타 | ${data.est_area}m<sup>2</sup>
							</c:if>
						</c:if>
						
						<c:if test="${data.est_state == 'n'}">
							<img src="../img/estimate/estimate_ongoing.gif" style="width: 2.5em; vertical-align: middle; margin-left:.5em;" />
						</c:if>
					</p>
					<div class="ui-grid-a">
						<div class="ui-block-a" style="width:35%"><p>시공 주소 :</p></div><div class="ui-block-b" style="width:65%"><p>${data.est_sido} ${data.est_gugun}</p></div>
						<div class="ui-block-a" style="width:35%"><p>상세 설명 :</p></div><div class="ui-block-b" style="width:65%"><textarea readonly="readonly" >${data.est_content}</textarea></div>
						<div class="ui-block-a" style="width:35%"><p>예상 비용 :</p></div><div class="ui-block-b" style="width:65%"><p>${data.est_cost}만원</p></div>
					</div>
				</div>	
			
				<!--견적완료 이미지 -->
				<c:if test="${data.est_state == 'y'}">
					<div style="position:absolute; top:10%; left:40%;">
						<img src="../img/estimate/estimate_ok.gif" style="width:50%; opacity: .8;" />
					</div>
				</c:if>
			</div>
		</c:forEach>
	</div>
	
	<!-- 팝업 -->
	<div id="popupCheck_space" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
    	<div class="ui-content" role="main" style="font-family:'godom'; font-size:14px;">
			<p id="popupCheck_txt"></p>	      		
      	  	<a style="background-color:#d7d7d7; margin-right:.5em;font-family:'godom';" href="#" data-rel="back" data-ajax="false">확인</a>   
  	  	</div>    
    </div>
	
	<div data-role="footer" onclick="moveWrite()" data-position="fixed" class="more_footer" style="opacity:.8; border:none !important;">
		<p><img src="../img/estimate/write.gif" style="vertical-align:middle; width:1em; margin-right:.5em;"/>견적서 작성</p>
	</div>
			
</div>
</body>
</html>