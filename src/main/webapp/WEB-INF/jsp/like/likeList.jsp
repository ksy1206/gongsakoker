<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<%@page import="gongsakoker.vo.MemberVO"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();	

    Map sessionData = null;
  
    boolean isSession = true;
    MemberVO memberVO = null;
    String member_no="";
   
    if (session.getAttribute("sessionData") != null) {
        sessionData = (Map)session.getAttribute("sessionData");
        memberVO = (MemberVO)sessionData.get("memberInfo");
        member_no = memberVO.getMember_no();
       
    } else {
        isSession = false;
        session.removeAttribute("sessionData");
    }
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
	<script type="text/javascript" src="<%=cp %>/js/koker_public.js"></script>
</head>


<script type="text/javascript">
	var member_no = <%=member_no%>;
	$(document).ready(function(){
		
	
	}); //end document ..
	//삭제 팝업 오픈
	function showDeletePopup(koker_no){
			$("#delete_btn").attr("onclick","deleteBookMark("+koker_no+")");
	  	    $("#dialog_txt").text("삭제하시겠습니까?");
			$("#popupDialog").popup("open");   
	     
	}
	
	//좋아요 삭제
	function deleteBookMark(koker_no){
	
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
					//$("#like_"+koker_no).css("display","none");
					location.href = "/like/likeList.do";
				}else{
					
				}
	      }
		});
	}
	
	//전화,문자 연결		
	function connect(data){
			location.href=data;
	}
</script>

<body>

<div data-role="page" id="list" class="koker_page" style="background-color:#fff;">
	<div data-role="header" class="list_header">
		<div class="back_btn">
			<a href="../appMain/appMain.do" data-ajax="false" data-rel="" class="relback_btn"><img src="../img/relback.gif"/></a>
		</div>
		<h1>나의 콕!</h1>
	
	</div>
	<div class="list_count">
		<p><img src="../../img/list/list_cap.gif" width="1em" />나의 콕! 
		(<span id="like_count"> ${dataCnt} </span>)</p>
	</div>
	<div data-role="content" class="list_content">
	
	<!-- 나의콕 리스트가 없을때 -->
	<c:if test="${dataCnt==0}">
		<div class="kok_list_none" id="none_list" >
			<img src="../../img/list/list_none_cha.gif" />
			<h3>콕! 해주세요</h3>
			<p>자주 이용하시는 업체 및 기술자를 콕! 하세요.</p>
			<p>더욱 편리하게 이용 할 수 있습니다.</p>
		</div>
	</c:if>	
	<!-- 나의콕 리스트가 있을때 -->

	<c:forEach var="data" items="${likeList}">
		  
	<div data-role="content" class="list_content">
			<div class="list_big_group">
				<div class="ui-grid-a" onclick="location.href='/kokkok20/kokkok20_details.do?koker_no=${data.koker_no }&backCount=1'"> 
				    <div class="ui-block-a list_stats_img">
		    			<c:if test="${data.logo_name == '' || data.logo_name == null || data.logo_name == undefined}">
				    		<img src="../../img/list/list_bg.jpg" />
				    	</c:if>
			    		<c:if test="${data.logo_name != '' && data.logo_name != null && data.logo_name != undefined}">	
				    		<img src="../upload/img/${data.member_id}/${data.logo_name}" style="min-height:135px;"/>
				    	</c:if>	
				    	
						<div class="list_text_mark">
						    <c:if test="${'0' ne data.special_no}">
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
				    				<p>${koker.call_tel01}-${koker.call_tel02}-${koker.call_tel03}</p>
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
				    <div class="ui-block-a" style="width: 33.333% !important; padding:0;"><p onclick="doMapping('tel','${data.call_tel01}${data.call_tel02}${data.call_tel03}','${data.koker_no}');"/><img src="../img/more/call_icon.gif" style="width:1em;"/>통화</p></div> 
				    <div class="ui-block-b" style="width: 33.333% !important; padding:0 .3em;"><p  onclick="doMapping('sms','${data.call_tel01}${data.call_tel02}${data.call_tel03}','${data.koker_no}');" />문자</p></div> 
				    <div class="ui-block-c" onclick="showDeletePopup(${data.koker_no});" style="width: 33.333% !important; padding:0;">
				    	<p><img src="../img/list/list_zzim_on.png" />찜
				    	
<!-- 		    		<img src="../../img/list/list_zzim_off.png" /> -->
						</p>
			    	</div> 
				</div><!-- /grid-b -->
			</div>
		</div>
	</c:forEach>	
	
		<div id="popupDialog" class="com_popup" style="max-width:400px;" data-role="popup" data-theme="b" data-overlay-theme="b" data-dismissible="false">
		    <div class="com_popup_text" role="main">
		        <p id="dialog_txt"></p>
		        <a style="background-color:#d7d7d7; margin-right:.5em;" href="#" data-rel="back" data-ajax="false" >취소</a>  
	      	  	<a style="background-color:#29A9C8;  data-ajax="false" id="delete_btn">삭제</a>
		    </div>
		</div>
	</div>
</div>  
</body>
</html>