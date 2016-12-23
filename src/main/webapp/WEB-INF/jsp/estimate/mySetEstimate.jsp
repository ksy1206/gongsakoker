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
<!-- 세션 없으면 메인페이지로 강제 이동 -->
<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == null || sessionScope.sessionData.memberInfo.getMember_no() ==''}">
	<script>
		location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	</script>
</c:if>
<script type="text/javascript">
window.onload=function click_btn(){
	var est_state_check = $("#est_state_check").val();
	if(est_state_check == 'n'){
		$("#btn04").addClass("check_blue");
	} else if(est_state_check == 'y'){
		$("#btn05").addClass("check_blue");
	}
};

function mySetEstimate(est_state){
	var member_no = $("#member_no_session").val();
	location.href="<%=cp%>/estimate/mySet_estimate.do?member_no="+member_no+"&est_state="+est_state;	
}

function details_setEstimate(est_no){
	var member_no = $("#member_no_session").val();
	location.href="<%=cp%>/estimate/details_setEstimate.do?member_no="+member_no+"&est_no="+est_no;	
}

function call_back() {
	location.href = "<%=cp%>/estimate/mainList.do?estType01_code=1&type01=1&type02=all";
}

</script>
</head>
<body>
<div data-role="page" style="background-color:#fff;">
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="<%=cp%>/estimate/mainList.do?estType01_code=1&type01=1&type02=all" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1 style="font-family:'godom'; font-size:16px !important; font-weight:normal !important; text-shadow:none !important; padding:.5em 0;">MY 견적서</h1>
	</div>
	
	<div class="ui-grid-a" style="border-top:solid 1px #29A9C8; background-color:#fff; box-shadow:0 0 10px 2px #888;">
		<div class="ui-block-a" id="btn04" onclick="mySetEstimate('n')">
			<p  onclick="" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">견적 신청중</p>
		</div>
		<div class="ui-block-b" id="btn05" onclick="mySetEstimate('y')">
			<p onclick="" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">견적 선택됨</p>
		</div>
	</div>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no_session">	
	<input type="hidden" value="${est_state}" id="est_state_check">
	
	<div data-role="content" style="padding:0 1em; margin-top: 1em;">
		<c:forEach var="data" items="${myList}">
			<div class="ui-grid-a" style="border:solid 1px #e5e5e5; padding:.3em; position:relative; margin-bottom:.5em; background-color:#fff;" onclick="details_setEstimate('${data.est_no}')">
				<div class="ui-block-a" style="width:30%; height:115px; overflow:hidden;">
					<c:if test="${empty data.est_img01}">
						<img src="../img/list/list_bg.jpg" style="width:100%; height:137px;"/>
					</c:if>
					<c:if test="${not empty data.est_img01}">
						<img src="../upload/img_estimate/${data.member_no}/${data.est_img01}" style="width:100%; height:137px;"/>
					</c:if>
				</div>
				<div class="ui-block-b estimate_text" style="width:70%;">
					<p style="font-size:16px; margin-bottom:.5em !important;">
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
	
</div>
</body>
</html>