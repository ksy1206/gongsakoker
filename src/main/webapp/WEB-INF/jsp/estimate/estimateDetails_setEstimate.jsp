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
function setDelete(setEst_no){
	var est_no = $("#est_no").val();
	var member_no = $("#session_member_no").val();
	
	$("#popup_txt2").text("삭제하시겠습니까?");
	$("#popupCheck2").popup("open");		
	
	$("#confirm2").click(function(){
		location.href="<%=cp%>/estimate/mySetList_estimateSetDelete.do?setEst_no="+setEst_no+"&member_no="+member_no+"&est_no="+est_no;
	});
}

function est_field(){
	$("#popupCheck").popup("open");
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
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	<input type="hidden" value="${estimateVo.est_no}" id="est_no">
	<input type="hidden" value="${estimateVo.est_state}" id="est_state">
	<input type="hidden" value="${estimateVo.setEst_no}" id="setEst_no">
	
	<div data-role="content" class="est_write_content est_write_align">	   
	   	<p style="margin:0 0 .5em 0; padding-left: .3em; text-align:left;">
	   		견적정보
	   	</p>
	   	<div style="background-color: #fff; border:solid 1px #29A9C8; padding:0 0 .5em 0;">
	      <div class="ui-grid-a est_write_box">	      
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공대상</p>
		         </div>
		         <div class="ui-block-b">
		         	<div class="ui-grid-a">
		         		<div class="ui-block-a" style="width:70% !important;">
		         			<p>
					           <c:if test="${estimateVo.estType01_code == 1}">
									<c:if test="${estimateVo.estType02_code == '01'}">
										아파트
									</c:if>
									<c:if test="${estimateVo.estType02_code == '02'}">
										주상복합
									</c:if>
									<c:if test="${estimateVo.estType02_code == '03'}">
										오피스텔
									</c:if>
									<c:if test="${estimateVo.estType02_code == '04'}">
										빌라/연립
									</c:if>
									<c:if test="${estimateVo.estType02_code == '05'}">
										기타
									</c:if>
								</c:if>
								<c:if test="${estimateVo.estType01_code == 2}">
									<c:if test="${estimateVo.estType02_code == '01'}">
										사무공간
									</c:if>
									<c:if test="${estimateVo.estType02_code == '02'}">
										식당/요리
									</c:if>
									<c:if test="${estimateVo.estType02_code == '03'}">
										학원/교육
									</c:if>
									<c:if test="${estimateVo.estType02_code == '04'}">
										병원/의료
									</c:if>
									<c:if test="${estimateVo.estType02_code == '05'}">
										매장/상업
									</c:if>
									<c:if test="${estimateVo.estType02_code == '05'}">
										체육기타
									</c:if> 
								</c:if>
							</p>
		         		</div>
		         		<c:if test="${estimateVo.estType01_code == 1}">
			         		<div class="ui-block-b" style="width:30% !important; background-color:#29A9C8;" onclick="est_field()">
								<p style="color:#fff; text-align:center; padding:0;">시공분야</p>
			         		</div>
		         		</c:if>
		         	</div>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공주소</p>
		         </div>
		         <div class="ui-block-b">
					 <p>${estimateVo.est_sido} ${estimateVo.est_gugun}</p>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공면적</p>
		         </div>
		         <div class="ui-block-b">
		         	<div class="ui-grid-b">
						<p>${estimateVo.est_area}m<sup>2</sup> /${est_area2}평</p>
		            </div>
		         </div>
	         </div>
	         
	      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
		         <div class="ui-block-a">
		            <p style="padding-left: .3em;">시공일자</p>
		         </div>
		         <div class="ui-block-b">
					<p>${estimateVo.est_startDate} ~ ${estimateVo.est_endDate}</p>
		         </div>
			</div>
			
		      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
			         <div class="ui-block-a">
			            <p style="padding-left: .3em;">시공비용</p>
			         </div>
			         <div class="ui-block-b">
						<p>${estimateVo.est_cost}만원</p>
			         </div>
		         </div>
	         
		      	<div style="width: 95%; border-bottom: solid #e5e5e5 1px; overflow: auto; padding:.5em;">
			         <div class="ui-block-a">
			            <p style="padding-left: .3em;">상세설명</p>
			         </div>
			         <div class="ui-block-b">
						<textarea readonly="readonly">${estimateVo.est_content}</textarea>
			         </div>
			    </div>
	      	</div>
	    
	      	<div style="width: 95%; overflow: auto; padding:.5em;"> 
			    <div class="ui-grid-b">
			    	<p style="margin:0; padding-left: .3em;">갤러리</p>  
				    <div class="ui-block-a" style="text-align:center; padding:0 .1em;">
				    	<c:if test="${estimateVo.est_img01 != null && estimateVo.est_img01 != ''}">
							<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img01}" style="width:100%; height:102px;"/>
						</c:if>
						<c:if test="${estimateVo.est_img01 == null || estimateVo.est_img01 == ''}">
							<img src="../img/more/no_img.png" width="100%"/>
						</c:if>
				    </div> 
				    <div class="ui-block-b" style="text-align:center; padding:0 .1em;">
				    	<c:if test="${estimateVo.est_img02 != null && estimateVo.est_img02 != ''}">
							<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img02}" style="width:100%; height:102px;"/>
						</c:if>					
						<c:if test="${estimateVo.est_img02 == null || estimateVo.est_img02 == ''}">
							<img src="../img/more/no_img.png" width="100%"/>
						</c:if>
				    </div> 
				    <div class="ui-block-c" style="text-align:center; padding:0 .1em;">
				    	<c:if test="${estimateVo.est_img03 != null && estimateVo.est_img03 != ''}">
							<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img03}" style="width:100%; height:102px;"/>
						</c:if>	
						
						<c:if test="${estimateVo.est_img03 == null || estimateVo.est_img03 == ''}">
							<img src="../img/more/no_img.png" width="100%"/>
						</c:if>
				    </div> 
				</div>
	   	   </div>
	   </div>
	   <div style="border:solid 1px #29A9C8; background-color:#fff; margin:1em 0 .5em 0;">
		<div class="set_est_sub">
			<div class="ui-grid-a set_est_text">
				<div class="ui-block-a" style="width:85%;">
					<p style="margin:.5em 0 0 .5em; font-size:16px !important; padding:0;">${estimateVo2.koker_name}<img src="../img/estimate/moveKoker_info.png" onclick="goBusiness_details('${estimateVo2.koker_no}')"></p>
					<p style="font-size:8px !important;	margin:.5em 0 0 .5em; padding:0;">${estimateVo2.setEst_insertDate.substring(0,10)}</p>
				</div>
				<c:if test="${estimateVo.est_state == 'n'}">
					<div class="ui-block-b" style="width:15%;">
						<img src="../img/estimate/setEstimate_delete.gif" align="right" onclick="setDelete('${estimateVo2.setEst_no}')" style="width:1em; padding-top:.3em;" />
					</div>
				</c:if>
			</div>
			<div class="ui-grid-a set_est_text">
				<div class="ui-block-a" style="width:20%; padding-left:.5em;">
					<p style="margin:.5em 0 0 0; padding:0;">견적가</p>
				</div>
				<div class="ui-block-b" style="width:80%;">
					<p style="margin:.3em 0 0 0; font-size:16px !important; color:#dd0e00;"> ${estimateVo2.setEst_price}<span style="margin-left:.5em; font-size:12px; color:#666;">만원</span></p>
				</div>
			</div>
			<textarea readonly="readonly" style="margin:.5em 0 0 .3em;">${estimateVo2.setEst_content}</textarea>
		</div>
	</div>
   </div>
   
   
	
	<div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup est_pop_text" data-overlay-theme="b">
		<p style="padding:1em 0; color:#666 !important; text-align:center;">
			견적 의뢰 시공 분야
			<a data-rel="back" data-ajax="false" style="padding:0 1em !important; float:right;">
				<img src="../img/estimate/field_close.gif" style="width:1em; vertical-align:middle;"/>
			</a>
		</p>
		<c:forEach var="list" items="${fieldList}">
			<c:forEach var="list2" items="${fieldList2}">
				<c:if test="${list.estimate_field_code == list2.field}">
					<c:if test="${list2.value == 'y'}">
						<p>${list.estimate_field_name}</p>
					</c:if>
				</c:if>
			</c:forEach>
		</c:forEach>
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