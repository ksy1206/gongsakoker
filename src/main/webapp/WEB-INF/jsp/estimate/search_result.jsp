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
function est_sate(check){
	if(check == 'y'){
		document.getElementById('est_stat_y').style.display = ""; 
		document.getElementById('est_stat_n').style.display = "none";
	} else if(check == 'n'){
		document.getElementById('est_stat_y').style.display = "none"; 
		document.getElementById('est_stat_n').style.display = ""; 
	} else if(check == 'all'){
		document.getElementById('est_stat_n').style.display = "";
		document.getElementById('est_stat_y').style.display = ""; 
	}
}

function estimateDetails(est_no){
	var member_no = $("#member_no_session").val();
	location.href="<%=cp%>/estimate/estimateDetails.do?est_no="+est_no+"&member_no="+member_no;
}
function click_btn(check){
	if(check == 'all'){
		document.getElementById('btn03').style.color = "#ffffff";
		document.getElementById('btn03').style.background = "#29A9C8";
		document.getElementById('btn04').style.color = "#000000";
		document.getElementById('btn04').style.background = "none";
		document.getElementById('btn05').style.color = "#000000";
		document.getElementById('btn05').style.background = "none";
	} else if (check == 'n'){
		document.getElementById('btn03').style.color = "#000000";
		document.getElementById('btn03').style.background = "none";
		document.getElementById('btn04').style.color = "#ffffff";
		document.getElementById('btn04').style.background = "#29A9C8";
		document.getElementById('btn05').style.color = "#000000";
		document.getElementById('btn05').style.background = "none";
	} else if (check == 'y'){
		document.getElementById('btn03').style.color = "#000000";
		document.getElementById('btn03').style.background = "none";
		document.getElementById('btn04').style.color = "#000000";
		document.getElementById('btn04').style.background = "none";
		document.getElementById('btn05').style.color = "#ffffff";
		document.getElementById('btn05').style.background = "#29A9C8";
	}	
};

function call_back(){
	location.href="<%=cp%>/estimate/search.do";	
}

</script>
</head>
<body>
<div data-role="page">
	<div data-role="header" class="search_header">
		<div class="back_btn">
			<a href="#" onclick="call_back()" data-ajax="false" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1 style="font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">검색 결과</h1>
	</div>
	
	<div class="ui-grid-b" style="padding:.3em 0;">
		<div class="ui-block-a" style="padding:0 .2em 0 .5em;" onclick="click_btn('all')">
			<p onclick="est_sate('all')" id="btn03" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; border:solid 1px #ccc; border-radius:5px; padding:.5em 0; color:#fff; background-color:#29A9C8;">전체</p>
		</div>
		<div class="ui-block-b" style="padding:0 .2em 0;" onclick="click_btn('n')">
			<p onclick="est_sate('n')" id="btn04" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; border:solid 1px #ccc; border-radius:5px; padding:.5em 0;">진행중</p>
		</div>
		<div class="ui-block-c" style="padding:0 .5em 0 .2em;" onclick="click_btn('y')">
			<p onclick="est_sate('y')" id="btn05" style="text-align:center; font-family:'godom'; font-weight:normal; text-shadow:none; font-size:12px; border:solid 1px #ccc; border-radius:5px; padding:.5em 0;">견적완료</p>
		</div>
	</div>	
	
	<div data-role="content" style="padding:0 1em;">
		<div id="est_stat_y">
			<c:forEach var="data" items="${list}">
				<c:if test="${data.est_state == 'y'}">
				<div class="ui-grid-a" style="border:solid 1px #e5e5e5; padding:.3em; position:relative; margin-bottom:.5em;" onclick="estimateDetails('${data.est_no}')">
					<div class="ui-block-a" style="width:30%;">
						<img src="../upload/img_estimate/${data.member_no}/${data.est_img01}" style="width:100%;"/>
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
	
					<div style="position:absolute; top:10%; left:40%;">			
						<img src="../img/estimate/estimate_ok.gif" style="width:50%; opacity: .8;" />			
					</div>
				</div>
				</c:if>
			</c:forEach>
		</div>
		
		<div id="est_stat_n">
			<c:if test="${empty list}">
				<div style="text-align: center;">
					<img src="../img/estimate/select_tikok.gif" style="width:40%;" />
					<p style="font-family:'godom';font-size:14px;">검색 결과가 없습니다.</p>
				</div>
			</c:if>
			<c:forEach var="data" items="${list}">
				<c:if test="${data.est_state == 'n'}">
				<div class="ui-grid-a" style="border:solid 1px #e5e5e5; padding:.3em; position:relative; margin-bottom:.5em;" onclick="estimateDetails('${data.est_no}')">
					<div class="ui-block-a" style="width:30%;">
						<img src="../upload/img_estimate/${data.member_no}/${data.est_img01}" style="width:100%;"/>
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
	
							<img src="../img/estimate/estimate_ongoing.gif" style="width: 2.5em; vertical-align: middle; margin-left:.5em;" />
	
						</p>
						<div class="ui-grid-a">
							<div class="ui-block-a" style="width:35%"><p>시공 주소 :</p></div><div class="ui-block-b" style="width:65%"><p>${data.est_sido} ${data.est_gugun}</p></div>
							<div class="ui-block-a" style="width:35%"><p>상세 설명 :</p></div><div class="ui-block-b" style="width:65%"><textarea readonly="readonly" >${data.est_content}</textarea></div>
							<div class="ui-block-a" style="width:35%"><p>예상 비용 :</p></div><div class="ui-block-b" style="width:65%"><p>${data.est_cost}만원</p></div>
						</div>
					</div>				
				</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="member_no_session">
</div>
</body>
</html>