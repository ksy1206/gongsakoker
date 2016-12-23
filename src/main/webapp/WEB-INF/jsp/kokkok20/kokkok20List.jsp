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
<script type="text/javascript" src="<%=cp %>/js/koker_public.js"></script>

<script type="text/javascript">

//클래스 코드로 리스트 불러오기
function loadData(class_code){
	var class_code;
	location.href="${pageContext.request.contextPath}/kokkok20/kokkok20_class_code.do?class_code="+class_code;
}


//업체 상세 넘어가기
function move_details(koker_no, review_avg, review_count, ranking){
	var class_code = $("#class_code").val();
// 	var backUrl = "/kokkok20/kokkok20_class_code.do?class_code="+class_code;
	location.href="${pageContext.request.contextPath}/kokkok20/kokkok20_details.do?koker_no="+koker_no+"&backCount="+'1';
}

$(document).ready(function(){
	/* $("#reset").click(function(){
		var class_code = $("#calss_code_test").val();
		loadData(class_code);
	}); */
});

//전화,문자 연결		
function connect(data){
		location.href=data;
}
//좋아요insert
function insertBookmark(koker_no,cnt){
	var member_no = $("#session_member_no").val();

	if(member_no == "" || member_no == null || member_no == undefined  || member_no == 'null'){
		$("#popupCheck").popup("open");   
		return false;
	}
	
	var params = "member_no="+member_no+"&koker_no="+koker_no;
	
	
 	$.ajax({
        type        : "POST"  
      , async       : false 
      , url         : "/like/insertBookMark.do"
      , data        : params
      , dataType    : "json" 
      , timeout     : 30000   
      , cache       : false     
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
		$("#popupDialog").popup("open");   
      }
      , success     : function(data) {
			
			if(data.result_code == 1){
				
				$("#bookmark_"+cnt).attr("onclick","deleteBookmark('"+koker_no+"','"+cnt+"');");
				$("#bookmark_"+cnt).html("<p><img src='../../img/list/list_zzim_on.png'/>찜</p>");
			}else{
				
			}
      }
	});
	
}
//좋아요delete
function deleteBookmark(koker_no,cnt){
	
	var member_no = $("#session_member_no").val();
	if(member_no == "" || member_no == null || member_no == undefined  || member_no == 'null'){
		$("#popupCheck").popup("open");   
		return false;
	}
	
	var params = "member_no="+member_no+"&koker_no="+koker_no;
	
	
 	$.ajax({
        type        : "POST"  
      , async       : false 
      , url         : "/like/deleteBookMark.do"
      , data        : params
      , dataType    : "json" 
      , timeout     : 30000   
      , cache       : false     
      , contentType : "application/x-www-form-urlencoded;charset=UTF-8"
      , error       : function(request, status, error) {
  	    $("#dialog_txt").text("작업 도중 오류가 발생하였습니다. 자세한 사항은 고객센터에 문의하십시오.");
		$("#popupDialog").popup("open");   
      }
      , success     : function(data) {
			
			if(data.result_code == 1){
				$("#bookmark_"+cnt).attr("onclick","insertBookmark('"+koker_no+"','"+cnt+"');");
				$("#bookmark_"+cnt).html("<p><img src='../../img/list/list_zzim_off.png'/>찜</p>");
			}else{
				
			}
      }
	});
	
}

function moveRanking(class_code){
	var member_no = $("#session_member_no").val();
	location.href="<%=cp%>/kokkok20/kokkok20_class_code.do?class_code="+class_code+"&member_no="+member_no;
}

//뒤로가기
function call_back(){
// 	var class_code = $("#class_code").val();
// 	location.href="${pageContext.request.contextPath}/appMain/appMain.do";
	history.go(-1);
}
</script>
</head>

<body style="background-color: #fff !important;">
<div data-role="page" class="koker_page" style="background-color:#fff !important;">
	<div data-role="header" class="search_header">		
		<div class="back_btn">
			<a href="#" data-ajax="false" onclick="call_back()" class="relback_btn"><img src="../img/search/back_icon.gif"/></a>
		</div>
		<h1>콕콕! 20</h1>
		<div class="ui-btn-right" style="padding-top:.1em;">
			<a href="<%=cp%>/appMain/appMain.do" id="reset" data-ajax="false"><img src="../img/header/home.png" style="width:2.5em;" /></a>
		</div>
	</div>	
	
	<div class="koklist_top">
		<div style="background-image:url('../img/kokkok20/background_text.png'); !important;">
			<c:if test="${class_code == 02}">
				<div class="choice_img">
					<div class="choice_img_block">
						<p onclick="moveRanking('02')" class="choice">자재업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('05')">시공업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('04')">장비업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('03')">기술자</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('07')">운송</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('06')">종합</p>
					</div>
				</div>
			</c:if>
			<c:if test="${class_code == 05}">
				<div class="choice_img">
					<div class="choice_img_block">
						<p onclick="moveRanking('02')">자재업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('05')" class="choice">시공업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('04')">장비업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('03')">기술자</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('07')">운송</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('06')">종합</p>
					</div>
				</div>
			</c:if>
			<c:if test="${class_code == 04}">
				<div class="choice_img">
					<div class="choice_img_block">
						<p onclick="moveRanking('02')">자재업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('05')">시공업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('04')" class="choice">장비업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('03')">기술자</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('07')">운송</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('06')">종합</p>
					</div>
				</div>
			</c:if>
			<c:if test="${class_code == 03}">
				<div class="choice_img">
					<div class="choice_img_block">
						<p onclick="moveRanking('02')">자재업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('05')">시공업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('04')">장비업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('03')" class="choice">기술자</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('07')">운송</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('06')">종합</p>
					</div>
				</div>
			</c:if>
			<c:if test="${class_code == 06}">
				<div class="choice_img">
					<div class="choice_img_block">
						<p onclick="moveRanking('02')">자재업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('05')">시공업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('04')">장비업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('03')">기술자</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('07')">운송</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('06')" class="choice">종합</p>
					</div>
				</div>
			</c:if>
			<c:if test="${class_code == 07}">
				<div class="choice_img">
					<div class="choice_img_block">
						<p onclick="moveRanking('02')">자재업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('05')">시공업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('04')">장비업체</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('03')">기술자</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('07')" class="choice">운송</p>
					</div>
					<div class="choice_img_block">
						<p onclick="moveRanking('06')">종합</p>
					</div>
				</div>
			</c:if>
		</div>
	</div>
	
	<input type="hidden" value="${sessionScope.sessionData.memberInfo.getMember_no()}" id="session_member_no">
	
	<div data-role="content" class="list_content" style="padding:0 !important; background-color: #fff; width: 100%;">
		<c:if test="${empty ranking20}">
			<div style="padding-top:15%; text-align:center;">
	         	<img src="../img/board/no_tikok.gif" style="width:40%;"/>
	         	<p style="text-shadow:none; font-weight:normal !important; color:#888; font-size:18px;">랭킹 업데이트 중입니다.</p>
	     	</div>
		</c:if>
		<c:forEach var="data" items="${ranking20 }" varStatus="num">
			<input type="hidden" value="${data.class_code }" id="calss_code_test">			
			
			<div data-role="content" class="list_content">
				<div class="list_big_group">
					<div class="ui-grid-a" onclick="move_details('${data.koker_no }','${data.review_avg }', '${data.review_count }', '${data.ranking }' )"> 
					    <div class="ui-block-a list_stats_img">
							<!-- 이미지 없을때 -->
							<c:if test="${data.logo_name == null || data.logo_name == ''}">
								<div class="kok20_logo_img">
									<img src="../img/list/list_bg.jpg"/>
								</div>
							</c:if>
							<!-- 이미지 있을때 -->
							<c:if test="${data.logo_name != null }">
								<div class="kok20_logo_img">
									<img src="/upload/img/${data.member_id }/${data.logo_name}" style="min-height:135px;"/>
								</div>
							</c:if>
					    	
							<div class="list_text_mark">
								<c:if test="${data.special_no != null}">
				    				<img src="../../img/list/list_kok.gif" />
							    </c:if>
					    	</div>
							<div class="list_text_mark02">
							 	<c:if test="${'y' eq data.koker_auth}">
				    				<img src="../../img/inzng_mark.png" />
				    			</c:if>
					    	</div>
					    </div> 
					    
					    <div class="ui-block-b list_stats_group" style="padding: .3em 0 0 .5em !important;">
					    	<h6>${data.koker_name }
							    <c:if test="${'03' eq data.class_code}">
								    <c:if test="${'1' eq data.state}">
								    	<img src="../../img/list/list_wait.gif" />
								    </c:if>
								    <c:if test="${'0' eq data.state}">
								    	<img src="../../img/list/list_wark.gif" />
								    </c:if>
							    </c:if>
					    	</h6>
					    	
					    	<div class="ui-grid-a list_stats"> 
							    <div class="ui-block-a review_list" style="width:65% !important;">		
									<form>
										<label for="slider-2"></label>
										<input name="slider-2" id="slider-2" type="range" min="0" max="10" value="${data.review_avg}" step="1" data-highlight="true" disabled='disabled'>
									</form>
							    </div> 
							    <div class="ui-block-b" style="width:35% !important; padding-right: .3em;">
								    <c:if test="${'0' ne data.ranking}">
							    		<p style="background-color:#e0000d; color:#fff; text-align:center; border-radius:25px; padding:.5em 0; text-shadow:none; font-weight:normal; margin:0;">콕콕! ${data.ranking }위</p>
								    </c:if>
							    </div>							    						    
								<%-- <div class="ui-grid-a list_stats_text"> 
					   				<div class="ui-block-a" style="width:25% !important;">
					   					<p>전화번호 : </p>
					   				</div>
					    			<div class="ui-block-b" style="width:75% !important;">
					    				<p>${data.call_tel01}-${data.call_tel02}-${data.call_tel03}</p>
					    			</div>
				    			</div> --%>
							</div>
					    </div>
					    
					    <div class="ui-block-b list_stats_text" style="margin: 0 !important; padding: .3em 0 0 .5em !important; width:60%;">
	  							<p style="margin:.5em; font-size:14px;">${data.addr01}</p>
					    </div>
					    
					    <div class="ui-block-b">
					    	<div class="ui-grid-a" style="width:100%;"> 
					   			<div class="ui-block-a" style="width:50%; line-height: 28px;">
					    			<img src="../../img/list/list_review.gif" style="width:1.2em; vertical-align:middle;" /><span style="font-size:14px; padding-left:.3em;">${data.review_count }</span>
					    		</div>
					   			<div class="ui-block-b" style="padding:0;">
						    	</div>
					    	</div>
					    </div> 
					</div>
	<!-- 				<div class="ui-grid-a cont_font" style="padding:.3em 0;">  -->
	<!-- 					<div class="ui-block-a" style="width:85% !important; margin:0; line-height:8px;"> -->
	<!-- 						<p style="margin:0;"><span>에어컨 ㅣ 공조 ㅣ 닥트</span><span>주방 ㅣ 가구</span><span>에어컨 ㅣ 공조 ㅣ 닥트</span></p> -->
	<!-- 					</div> -->
	<!-- 					<div class="ui-block-b" style="width:15% !important; padding:0;"> -->
	<%-- 						<p style="color:#6e6c6c; margin:0; font-size:8px;" onclick="location.href='/kokkok20/kokkok20_details.do?koker_no=${data.koker_no }&backCount=1'">그외 3</p> --%>
	<!-- 					</div> -->
	<!-- 	   			</div>  -->
			   		<div class="ui-grid-b cont_box"> 
					   <div class="ui-block-a" style="width: 33.333% !important; padding:0;"><p onclick="doMapping('tel','${data.call_tel01}${data.call_tel02}${data.call_tel03}','${data.koker_no}');"><img src="../img/more/call_icon.gif" style="width:1em;"/>통화</p></div> 
					  
					    <div class="ui-block-b" style="width: 33.333% !important; padding:0 .3em;"><p onclick="doMapping('sms','${data.call_tel01}${data.call_tel02}${data.call_tel03}','${data.koker_no}');"><img src="../img/list/list_msg_icon.gif" />문자</p></div> 
					  <c:if test="${'0' ne data.bookmark_no}">
						    <div id="bookmark_${num.count}" class="ui-block-c" onclick="deleteBookmark('${data.koker_no}','${num.count}');" style="width: 33.333% !important; padding:0;">
						    	<p>  	
							    	<img src="../img/list/list_zzim_on.png" />찜
								</p>
					    	</div> 
				    	</c:if>
				    	<c:if test="${'0' eq data.bookmark_no}">
						    <div id="bookmark_${num.count}" class="ui-block-c" onclick="insertBookmark('${data.koker_no}','${num.count}');" style="width: 33.333% !important; padding:0;">
						    	<p>
							    	<img src="../../img/list/list_zzim_off.png"/>찜 
							    </p>
					    	</div> 
				    	</c:if>
					</div><!-- /grid-b -->
				</div>
			</div>
		
		</c:forEach>
	</div>
	
	<div id="popupAddBookmark" data-role="popup" data-transition="pop" class="kok_pop"  data-ajax="false">
	    <div class="ui-content" role="main">
	    	<img src="../img/more/kok_on.gif" />
	  	</div>    
	 </div>	

	 <div id="popupDeleteBookmark" data-role="popup" data-transition="pop" class="kok_pop"  data-ajax="false">
	    <div class="ui-content" role="main">
	    	<img src="../img/more/kok_off.gif" />
	  	</div>    
	 </div>	
	 
	 <div id="popupCheck" style="max-width: 400px;" data-role="popup" data-dismissible="false" class="board_footer_popup">
	    <div class="ui-content" role="main">
			<p>로그인이 필요한 서비스입니다.</p>
	      	<a style="background-color:#29A9C8;" href="#" data-rel="back" data-ajax="false">확인</a>   
	  	</div>    
	 </div>	

</div>
</body>
</html>