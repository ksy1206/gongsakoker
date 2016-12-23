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
function est_field(){
	$("#popupCheck").popup("open");
}

function estimate_confirm(){
	
	var session_member_no = $("#member_no").val();
	var details_member_no = $("#details_member_no").val();
	
	if(session_member_no == details_member_no){
		var est_no = $("#est_no").val();
		var setEst_no = $("#setEst_no").val();
		var est_state = $("#est_state").val();
		location.href="<%=cp%>/estimate/estimateConfirm.do?est_no="+est_no+"&setEst_no="+setEst_no+"&est_state="+est_state;
	} else {
		$("#popupCheck_txt").text("작성자만 확인 가능합니다.");
   	 	$("#popupCheck_space").popup("open");
        return false;
	}
	
}

function estimate_submit(){
	var est_no = $("#est_no").val();
	var member_no = $("#member_no").val();
	location.href="<%=cp%>/estimate/estimateSubmit.do?est_no="+est_no+"&member_no="+member_no+"&backCount=1";
}

function deletes(){
	var est_no = $("#est_no").val();
	var member_no = $("#member_no").val();
	location.href="<%=cp%>/estimate/estimateDelete.do?est_no="+est_no+"&member_no="+member_no;
}

function call_back(){
	history.go(-1);
}

function img_expand(data){
	var member_no = $("#estimateVo_member_no").val();
	if (data == '01'){
		var img01 = $("#img01").val();
		location.href="<%=cp%>/estimate/img_expand.do?member_no="+member_no+"&img01="+img01;
	} else if (data == '02'){
		var img02 = $("#img02").val();
		location.href="<%=cp%>/estimate/img_expand.do?member_no="+member_no+"&img02="+img02;
	} else if (data == '03'){
		var img03 = $("#img03").val();
		location.href="<%=cp%>/estimate/img_expand.do?member_no="+member_no+"&img03="+img03;
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
		<h1 style="font-family:'godom'; font-weight:normal; text-shadow:none; font-size:14px;">맞춤견적</h1>
<%-- 		<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == estimateVo.member_no}"> --%>
<!-- 			<div class="ui-btn-right" style="padding-top:.1em;"> -->
<!-- 				<a href="#" data-ajax="false"><img src="../img/estimate/header_confirm.gif" style="width:2.5em;" onclick="estimate_confirm()" /></a> -->
<!-- 			</div> -->
<%-- 		</c:if> --%>
	</div>	
	
	<input type="hidden" id="member_no" value="${sessionScope.sessionData.memberInfo.getMember_no()}">
	<input type="hidden" id="details_member_no" value="${estimateVo.member_no}">
	<input type="hidden" name="class_code" value="${sessionScope.sessionData.memberInfo.getClass_code()}">
	<input type="hidden" id="est_no" value="${estimateVo.est_no}">
	<input type="hidden" id="est_state" value="${estimateVo.est_state}">
	<input type="hidden" id="setEst_no" value="${estimateVo.setEst_no}">
	
	<!-- 이미지 정보 -->
	<input type="hidden" value="${estimateVo.member_no}" id="estimateVo_member_no">
	<input type="hidden" value="${estimateVo.est_img01}" id="img01">
	<input type="hidden" value="${estimateVo.est_img02}" id="img02">
	<input type="hidden" value="${estimateVo.est_img03}" id="img03">
	
	<div data-role="content" class="est_write_content est_write_align">
	   <form  enctype="multipart/form-data" method="post" id="estimateWrite" name="estimateWrite">
	   	<p style="margin:0 0 .5em 0; padding-left: .3em; text-align:left;">
	   		견적정보
	   		<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == estimateVo.member_no}">
		   		<span onclick="deletes()" style="float:right; padding:.5em 1em; background-color:#29A9C8; color:#fff; line-height: 8px; margin-top: -.2em;">
		   			삭제
		   		</span>
	   		</c:if>
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
			    <div class="ui-block-a" style="text-align:center; padding:0 .1em;"  onclick="img_expand('01')">
			    	<c:if test="${estimateVo.est_img01 != null && estimateVo.est_img01 != ''}">
						<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img01}" style="width:89px; height:89px;"/>
					</c:if>
					<c:if test="${estimateVo.est_img01 == null || estimateVo.est_img01 == ''}">
						<img src="../img/more/no_img.png" style="width:89px; height:89px;"/>
					</c:if>
			    </div> 
			    <div class="ui-block-b" style="text-align:center; padding:0 .1em;"  onclick="img_expand('02')">
			    	<c:if test="${estimateVo.est_img02 != null && estimateVo.est_img02 != ''}">
						<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img02}" style="width:89px; height:89px;"/>
					</c:if>					
					<c:if test="${estimateVo.est_img02 == null || estimateVo.est_img02 == ''}">
						<img src="../img/more/no_img.png" style="width:89px; height:89px;"/>
					</c:if>
			    </div> 
			    <div class="ui-block-c" style="text-align:center; padding:0 .1em;"  onclick="img_expand('03')">
			    	<c:if test="${estimateVo.est_img03 != null && estimateVo.est_img03 != ''}">
						<img src="../upload/img_estimate/${estimateVo.member_no}/${estimateVo.est_img03}" style="width:89px; height:89px;"/>
					</c:if>	
					
					<c:if test="${estimateVo.est_img03 == null || estimateVo.est_img03 == ''}">
						<img src="../img/more/no_img.png" style="width:89px; height:89px;"/>
					</c:if>
			    </div> 
			</div>
   	    </div>
	   </div>      
	   </form>
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
	
	<c:if test="${estimateVo.est_state == 'y'}">
		<div data-role="footer" onclick="estimate_confirm()" data-position="fixed" class="more_footer" style="background-color:#fff !important; opacity:.8; border: none;">
			<div class="ui-grid-a est_footer_text" style="position:relative; width:100%;">
				<c:if test="${estimateVo.est_state == 'y'}">
					<div class="ui-blcok-a" style="float:left; width:50%;">
						<p style="color: red !important; font-size:18px !important; text-align:center;">최고가</p>
						<p style=" text-align:center;"><img src="../img/estimate/hi_price.gif" style="width:1em; vertical-align:middle; margin-right:.5em;" />${estimateVo.max_price}<span>만원</span></p>
					</div>
					<div class="ui-blcok-b" style="float:left; width:50%;">
						<p style="color: blue !important; font-size:18px !important; text-align:center;">최저가</p>
						<p style=" text-align:center;"><img src="../img/estimate/low_price.gif" style="width:1em; vertical-align:middle; margin-right:.5em;" />${estimateVo.min_price}<span>만원</span></p>
					</div>
				</c:if>
			</div>
			<p style="margin:0; padding:1em 0; font-size:16px;">견적 완료</p>
		</div>
	</c:if>

	<c:if test="${estimateVo.est_state == 'n'}">
		<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() == estimateVo.member_no}">
			<div data-role="footer" onclick="estimate_confirm()" data-position="fixed" class="more_footer">
				<p><img src="../img/estimate/footer_confirm.gif" style="vertical-align:middle; width:1em; margin-right:.5em;"/>견적서 확인하기</p>
			</div>
		</c:if>
		
		<c:if test="${sessionScope.sessionData.memberInfo.getMember_no() != estimateVo.member_no}">
			<c:if test="${sessionScope.sessionData.memberInfo.getClass_code() != '01' }">
				<div data-role="footer" onclick="estimate_submit()" data-position="fixed" class="more_footer">
					<p><img src="../img/estimate/footer_confirm.gif" style="vertical-align:middle; width:1em; margin-right:.5em;"/>견적서 제출하기</p>
				</div>
			</c:if>
		</c:if>
	</c:if>
	
	<div id="popupCheck_space" class="board_footer_popup" style="max-width: 400px;" data-role="popup" data-dismissible="false" data-overlay-theme="b">
       <div class="ui-content" role="main">
         <p id="popupCheck_txt"></p>               
              <a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false">확인</a>   
          </div>    
    </div>
	
</div>
</body>
</html>